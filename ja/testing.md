---
title: コードのテスト
---

書いているコードを手軽にテストしたいですか。このレシピでは、自動テストの書き方とコードカバレッジの確認方法を扱います。さらに、GitHub Actions、GitLab CI、Travis CI、Coveralls といった現代的な継続的インテグレーションサービスへ組み込むための手がかりも示します。

ここでは、[FiveAM](https://github.com/lispci/fiveam) という成熟したテストフレームワークを使います。テストスイート、ランダムテスト、テストフィクスチャ、そしてもちろん対話的開発をサポートしています。

以前の Cookbook では [Prove](https://github.com/fukamachi/prove) を使っていました。かつては広く好まれたテストフレームワークでしたが、いくつかの弱点があり、のちにリポジトリはアーカイブされました。後継の [Rove](https://github.com/fukamachi/rove) はまだ安定性が十分ではなく、いくつかの機能も不足しているため、ここでは採用しませんでした。気が向けば、[他のテストフレームワーク](https://github.com/CodyReichert/awesome-cl#unit-testing) も試してみてください。

FiveAM には [API ドキュメント](https://common-lisp.net/project/fiveam/docs/index.html) があります。そこを参照してもよいですし、コード中の docstring を読むだけでもかまいません。たいていは、それだけで疑問に答えるのに十分な情報が得られます。ここに載っていない場合でもです。では始めましょう。

## FiveAM でテストする

FiveAM には 3 段階の抽象化があります。`check`、`test`、`suite` です。名前の通りです。

1. **check** は、引数が真であることを確認する単一のアサーションです。もっともよく使うのは `is` です。たとえば `(is (= 2 (+ 1 1)))` です。
2. **test** は、実行可能な最小単位です。1 つのテストケースに複数の check を含められます。どれか 1 つでも失敗すると、そのテスト全体が失敗になります。
3. **suite** はテストの集合です。suite を実行すると、その中のすべてのテストが実行されます。suite には親子関係を持たせられるので、ある suite を走らせると、その中で定義されたテストと子 suite のテストもまとめて実行されます。

上の 3 つの基本ブロックを含む簡単な例は次のとおりです。

~~~lisp
(def-suite* my-suite)

(test my-test
  (is (= 2 (+ 1 1))))
~~~

テストと suite の階層は、完全に利用者次第です。ここでは主に FiveAM の使い方に注目します。

かなり複雑なシステムを作っていて、次の関数がその一部だとしましょう。

~~~lisp
;; We have a custom "file doesn't exist" condition.
(define-condition file-not-existing-error (error)
  ((filename :type string :initarg :filename :reader filename)))

;; We have a function that tries to read a file and signals the above condition
;; if the file doesn't exist.
(defun read-file-as-string (filename &key (error-if-not-exists t))
  "Read file content as string. FILENAME specifies the path of file.

Keyword ERROR-IF-NOT-EXISTS specifies the operation to perform when the file
is not found. T (by default) means an error will be signaled. When given NIL,
the function will return NIL in that case."
  (cond
    ((uiop:file-exists-p filename)
     (uiop:read-file-string filename))
    (error-if-not-exists
     (error 'file-not-existing-error :filename filename))
    (t nil)))
~~~

このコードに対するテストを書きます。特に、次を保証する必要があります。

- ファイルから読み込んだ内容が期待どおりであること
- ファイルが存在しないときに条件がシグナルされること


### インストールと読み込み

`FiveAM` は Quicklisp にあり、次のコマンドで読み込めます。

~~~lisp
(ql:quickload "fiveam")
~~~

パッケージ名は `fiveam` で、ニックネームは `5am` です。簡単のため、以下のコード例ではパッケージ接頭辞を省略します。

これは、テスト用パッケージ定義で fiveam を `:use` したのと同じようなものです。REPL では `(use-package :fiveam)` として追いかけてもかまいません。

使えるパッケージ定義の例を示します。

```lisp
(in-package :cl-user)
(defpackage my-fiveam-test
  (:use :cl
        :fiveam))
(in-package :my-fiveam-test)
```

### suite を定義する (`def-suite`, `def-suite*`)

FiveAM でのテストは、通常 suite を定義するところから始まります。suite を使うと、テストを小さなまとまりに分けられて整理しやすくなります。ASDF との統合を考えるなら、単一の *root* suite を定義することを強く勧めます。これについては後で触れます。ここではまず、テストそのものに集中しましょう。

以下のコードは `my-system` という suite を定義しています。システム全体の root suite として使います。

~~~lisp
(def-suite my-system
  :description "Test my system")
~~~

次に、`read-file-as-string` 関数をテストする別の suite を定義しましょう。

~~~lisp
;; suite を定義し、以降のテストのデフォルトに設定する。
(def-suite read-file-as-string
  :description "Test the read-file-as-string function."
  :in my-system)
(in-suite read-file-as-string)

;; Alternatively, the following line is a combination of the 2 lines above.
(def-suite* read-file-as-string :in my-system)
~~~

ここで `read-file-as-string` という新しい suite を定義しました。`:in` キーワードで指定したとおり、`my-system` の子 suite になっています。マクロ `in-suite` は、後で定義するテストのデフォルト suite をこの suite に設定します。

### テストを定義する

テストに入る前に、テストの中で使える check を簡単に紹介します。

* `is` マクロは、おそらくもっともよく使う check です。与えた式が真値を返すかを確認し、それに応じて `test-passed` または `test-failure` を返します。
* `skip` マクロは理由を受け取り、`test-skipped` を返します。
* `signals` マクロは、実行中に指定した条件がシグナルされたかを確認します。

ほかにもあります。

* `finishes`: アサーション本体が正常終了すれば成功です。つまり、本体がエラーをシグナルしたり非ローカルなジャンプを行ったりした場合、このテストは失敗します。
* `pass`: テストを成功としてマークします。
* `is-true`: `is` に似ていますが、失敗の報告内容を決めるためにアサーション本体を調べません。これと同様に `is-false` もあります。

なお、すべての check はオプションで理由文字列を受け取れます。この文字列は `format` ディレクティブで整形できます（後述）。省略した場合、FiveAM は関数に渡された引数に基づいて失敗理由を説明するレポートを生成します。

`test` マクロは、名前付きのテストを簡単に定義するためのものです。

*以下では 2 つのファイルが存在すると仮定します。`/tmp/hello.txt` には "hello" が入っていて、`/tmp/empty.txt` は空です。*

~~~lisp
;; 最初の基本ケース: "hello" を含むファイルを読む。
(test read-file-as-string-normal-file
  (let ((result (read-file-as-string "/tmp/hello.txt")))
    ;; ヒント: = や equal, string= などでは、期待値を第 1 引数に置く。
    ;; FiveAM はこの慣例に従うと、より読みやすいレポートを生成する。
    (is (string= "hello" result))))

;; 空のファイルを読む。
(test read-file-as-string-empty-file
  (let ((result (read-file-as-string "/tmp/empty.txt")))
    (is (not (null result)))
    ;; 理由には整形済みテキストを指定できる。
    (is (= 0 (length result)))
        "Empty string expected but got ~a" result))

;; では、存在しないファイルを読むとこの条件がシグナルされることを確認する。
(test read-file-as-string-non-existing-file
  (let ((result (read-file-as-string "/tmp/non-existing-file.txt"
                                     :error-if-not-exists nil)))
    (is (null result)
      "Reading a file should return NIL when :ERROR-IF-NOT-EXISTS is set to NIL"))
  ;; SIGNALS は、クォートしない条件名と評価する本体を受け取る。
  ;; ここでは FILE-NOT-EXISTING-ERROR がシグナルされるかを調べる。
  (signals file-not-existing-error
    (read-file-as-string "/tmp/non-existing-file.txt"
                         :error-if-not-exists t)))
~~~

上のコードでは、3 つのテストと合計 5 つの check を定義しました。デモのために、いくつかの check は実際には冗長です。すべての check を 1 つの大きなテストにまとめてもよいですし、複数のシナリオに分けてもかまいません。そこは自由です。

`test` マクロは、`def-test` を使って単純なテストを定義するための便利なラッパーです。たとえば `:depends-on` についても含め、より詳しくは docstring を読んでください。

### テストを実行する

FiveAM にはテストの実行方法がいくつかあります。開発中の出発点としては、`run!` マクロが便利です。suite 名または test 名を受け取り、それを実行して標準出力にレポートを出します。では、実際に走らせてみましょう。

~~~lisp
(run! 'my-system)
; Running test suite MY-SYSTEM
;  Running test READ-FILE-AS-STRING-EMPTY-FILE ..
;  Running test READ-FILE-AS-STRING-NON-EXISTING-FILE ..
;  Running test READ-FILE-AS-STRING-NORMAL-FILE .
;  Did 5 checks.
;     Pass: 5 (100%)
;     Skip: 0 ( 0%)
;     Fail: 0 ( 0%)
;  => T, NIL, NIL
~~~

`read-file-as-string-non-existing-file` の `/tmp/non-existing-file.txt` を `/tmp/hello.txt` に置き換えて壊すと、期待どおり（当然！）テストは失敗します。

~~~lisp
(run! 'read-file-as-string-non-existing-file)
; Running test READ-FILE-AS-STRING-NON-EXISTING-FILE ff
;  Did 2 checks.
;     Pass: 0 ( 0%)
;     Skip: 0 ( 0%)
;     Fail: 2 (100%)
;  Failure Details:
;  --------------------------------
;  READ-FILE-AS-STRING-NON-EXISTING-FILE []:
;       Should return NIL when :ERROR-IF-NOT-EXISTS is set to NIL.
;  --------------------------------
;  --------------------------------
;  READ-FILE-AS-STRING-NON-EXISTING-FILE []:
;       Failed to signal a FILE-NOT-EXISTING-ERROR.
;  --------------------------------
;  => NIL
; (#<IT.BESE.FIVEAM::TEST-FAILURE {10064485F3}>
;  #<IT.BESE.FIVEAM::TEST-FAILURE {1006438663}>)
; NIL
~~~

suite/test ランナーの挙動は `*on-failure*` 変数で調整できます。これは check が失敗したときにどうするかを制御します。次の値を設定できます。

- `:debug`: デバッガに入る。
- `:backtrace`: バックトレースを表示して続行する。
- `NIL`（既定値）: そのまま続行し、レポートを表示する。

`*on-error*` もあります。

#### コンパイル時にテストを実行する

通常、テストは書いてコンパイルし（Slime ならおなじみの `C-c C-c`）、実行はその後で別に行います。定義した瞬間に（`C-c C-c` で）テストを実行したいなら、次のように設定します。

~~~lisp
(setf fiveam:*run-test-when-defined* t)
~~~


### テスト説明をカスタマイズする

先ほど、check は `format` ディレクティブで整形できる任意の理由を受け取れると説明しました。簡単な例を示します。

ここでは数値関数をテストします。

~~~lisp
(fiveam:test simple-maths
  (is (= 3 (+ 1 1))))
~~~

これを `run!` すると、少し長いですが情報量のある出力が表示されます。これは重要です。

```
Running test suite NIL
 Running test SIMPLE-MATHS f
 Did 1 check.
    Pass: 0 ( 0%)
    Skip: 0 ( 0%)
    Fail: 1 (100%)

 Failure Details:
 --------------------------------
 SIMPLE-MATHS []:

(+ 1 1)

 evaluated to

2

 which is not

=

 to

3


 --------------------------------
```

では、独自の理由を付けてみましょう。

~~~lisp
(fiveam:test simple-maths
  (is (= 3 (+ 1 1))
      "Maths should work, right? ~a. Another parameter is: ~S" t :foo))
~~~


すると次のようになります。

~~~
Running test suite NIL
 Running test SIMPLE-MATHS f
 Did 1 check.
    Pass: 0 ( 0%)
    Skip: 0 ( 0%)
    Fail: 1 (100%)

 Failure Details:
 --------------------------------
 SIMPLE-MATHS []:
      Maths should work, right? T. Another parameter is: :FOO
 --------------------------------
~~~

### フィクスチャ

FiveAM には、テストコンテキストを整えるための **fixture** という機能もあります。目的は、ある関数を呼ばずに常に同じ結果を返すようにすることです。ネットワークにアクセスする関数を想像してください。ネットワーク呼び出しを小さな関数に切り出し、fixture を書いて、テスト中はその関数が常に同じ既知の結果を返すようにしたいわけです。（ただし、その場合でも、実データとすべてのコードを使った "end to end" テストが別途必要になるかもしれません。）

ただし、FiveAM の fixture システムはマクロ以上のものではなく、[Mockingbird](https://github.com/pfdietz/mockingbird) のような他のライブラリと比べて機能は豊富ではありません。FiveAM のメンテナも、代わりに「ただマクロを使えばよい」と勧めています。

Mockingbird（おそらく他のライブラリも同様）では、基本機能に加えて、関数が何回呼ばれたか、どんな引数で呼ばれたか、といったことも数えられます。

### ランダムテスト

ランダムテストの目的は、開発者がテストケースを生成するのを助け、思いつかなかったケースを見つけることです。

使えるデータジェネレータはいくつかあります。たとえば次のものです。

~~~lisp
(gen-float)
#<CLOSURE (LAMBDA () :IN GEN-FLOAT) {1005A906AB}>

(funcall (gen-float))
9.220082e37

(funcall (gen-integer :max 27 :min -16))
26
~~~

ほかにも `gen-string`、`gen-list`、`gen-tree`、`gen-buffer`、`gen-character` があります。

また、与えたジェネレータから毎回新しい値を取り出して 100 回の check を実行する `for-all` もあります。

~~~lisp
(test randomtest
  (for-all ((a (gen-integer :min 1 :max 10))
            (b (gen-integer :min 1 :max 10)))
    "Test random tests."
    (is (<= a b))))
~~~

これを `run! 'randomtest` すると、おそらくエラーになるはずです。毎回 `a` が `b` 以下になるとは限りませんから。

詳細は [FiveAM のドキュメント](https://common-lisp.net/project/fiveam/docs/Checks.html#Random_0020_0028QuickCheck-ish_0029_0020testing) を参照してください。

Haskell の [QuickCheck](https://en.wikipedia.org/wiki/QuickCheck) に触発された [cl-quickcheck](https://github.com/mcandre/cl-quickcheck) や [Check-it](https://github.com/DalekBaldwin/check-it) もあります。


### ASDF 統合

`my-system` を 1 行でテストできると便利です。root suite を用意したほうがよいと言ったのを覚えていますか。理由はここにあります。

~~~lisp
(asdf:defsystem my-system
  ;; Parts omitted.
  :in-order-to ((test-op (test-op :my-system/test))))

(asdf:defsystem mitogrator/test
  ;; Parts omitted.
  :perform (test-op (op c)
                    (symbol-call :fiveam :run!
                                 (find-symbol* :my-system :my-system/test))))
~~~

最後の行は、ASDF に `my-system/test` パッケージからシンボル `:my-system` を読み込み、`fiveam:run!` を呼ぶよう指示しています。実際には、先ほど述べた `(run! 'my-system)` と同じです。

### ターミナルでテストを実行する

ここまでは、エディタの REPL からテストを実行していました。では、ターミナルからはどう実行するのでしょうか。

いつものように、必要な手順は次のとおりです。

- Lisp を起動する
- Quicklisp が有効になっていることを確認する（外部依存がある場合）
- 本体システムを読み込む
- テストシステムを読み込む
- FiveAM のテストを実行する

これらを新しい `run-tests.lisp` ファイルにまとめられます。

~~~lisp
(load "mysystem.lisp")
(load "mysystem-tests.lisp") ;; <-- where all the FiveAM tests are written.
(in-package :mysystem-tests)

(run!)  ;; <-- run all the tests and print the report.
~~~

そして、ソースファイルや Makefile から次のように呼び出せます。

~~~lisp
rlwrap sbcl --non-interactive --load mysystem.asd --eval '(ql:quickload :mysystem)' --load run-tests.lisp
;; Quicklisp がインストール済みで読み込まれていると仮定しています。
;; これは .sbclrc のような Lisp 起動ファイルで行えます。
~~~

ただしその方法に進む前に、下の継続的インテグレーション節で使う `CI-Utils` ツールを見てください。これには、ここまでの作業をすべてやってくれる `run-fiveam` コマンドがあります。

ただし、この方法でテストを回すなら、気をつけるべき点があります。それは **終了コード** です。`(run!)` はレポートを表示しますが、テストが成功したかどうかや、終了コードを 0 にするか（成功）、それ以外にするか（エラー）までは Lisp に伝えません。そのため、CI 上ではテストが失敗しても常に緑になってしまいます。これを避けるには、`run!` を次のように置き換えます。

~~~lisp
(let ((result (run!)))
  (cond
    ((null result)
     (log:info "Tests failed!")  ;; FiveAM printed the report already.
     (uiop:quit 1))
    (t
     (log:info "All pass.")
     (uiop:quit))))
~~~

シェルで `echo $?` を確認して、終了コードが正しいか見てください。


### テストレポートをカスタマイズする

自分でテストレポートを生成することもできます。`run!` マクロは、`explain!` と `run` を組み合わせただけのものです。

`run!` のようにレポートを直接出す代わりに、`run` 関数は渡された suite や test を実行し、`test-result` のリストを返します。通常は `test-failure` や `test-passed` のサブクラスのインスタンスです。

`text-explainer` クラスは、テストレポート生成用の基本クラスとして定義されています。汎用関数 `explain` は `text-plainer` インスタンスと `run` が返した `test-result` インスタンスを受け取り、テストレポートを生成します。次の 2 つのコードは同値です。

~~~lisp
(run! 'read-file-as-string-non-existing-file)

(explain (make-instance '5am::detailed-text-explainer)
         (run 'read-file-as-string-non-existing-file))
~~~

`text-explainer` の新しいサブクラスを作り、それに対する `explain` メソッドを定義すれば、新しいテスト報告システムを作れます。

以下のコードは、概念実証としての実装にすぎません。完全に理解するには `5am::detailed-text-explainer` のソースを読む必要があるかもしれません。

~~~lisp
(defclass my-explainer (5am::text-explainer)
  ())

(defmethod 5am:explain ((explainer my-explainer) results &optional (stream *standard-output*) recursive-deps)
  (loop for result in results
        do (case (type-of result)
             ('5am::test-passed
              (format stream "~%Test ~a passed" (5am::name (5am::test-case result))))
             ('5am::test-failure
              (format stream "~%Test ~a failed" (5am::name (5am::test-case result)))))))

(explain (make-instace 'my-explainer)
         (run 'read-file-as-string-non-existing-file))
; Test READ-FILE-AS-STRING-NON-EXISTING-FILE failed
; Test READ-FILE-AS-STRING-NON-EXISTING-FILE passed => NIL
~~~


## 対話的にユニットテストを修正する

Common Lisp は本質的に対話的です（ほとんどの実装もそうです）。テストフレームワークはその特性を活かせます。失敗したテストでデバッガを開かせ、スタックトレースを確認して該当行へすぐ移動し、修正してから、提案された *restart* を選んで中断したところから再実行できます。

FiveAM では、`fiveam:*on-failure*` を `:debug` に設定します。

~~~lisp
(setf fiveam:*on-failure* :debug)
~~~

エラーが起きると対話デバッガに入ります。

`:backtrace` を使うと、バックトレースを表示して残りのテストを続行し、FiveAM のレポートを出します。

既定値は `nil` で、テスト実行を続けてレポートを表示します。

<!-- epub-exclude-start -->

以下は、その一連の流れを示す短いスクリーンキャストです。

<iframe width="560" height="315" src="https://www.youtube.com/embed/KsHxgP3SRTs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<!-- epub-exclude-end -->

デバッガでは次の点に注意してください。

- バックトレース上で `<enter>` を押すと、さらに表示されます
- バックトレース上で `v` を押すと、対応する行や関数へ移動します
- ほかの操作はメニューから確認できます


## コードカバレッジ

コードカバレッジツールは、どの部分のコードがテストされ、どの部分がされていないかを視覚的に示します。


![](assets/coverage.png "source: https://www.snellman.net/blog/archive/2007-05-03-code-coverage-tool-for-sbcl.html")

こうした機能は Lisp 実装に組み込まれています。たとえば SBCL には [sb-cover](http://www.sbcl.org/manual/index.html#sb_002dcover) モジュールがあり、[CCL](https://ccl.clozure.com/docs/ccl.html#code-coverage) や [LispWorks](http://www.lispworks.com/documentation/lw71/LW/html/lw-68.htm) にも同様の機能があります。

### HTML のカバレッジ出力を生成する

SBCL の [sb-cover](http://www.sbcl.org/manual/index.html#sb_002dcover) でやってみましょう。

カバレッジレポートは、`compile-file` でコンパイルされたコードに対してのみ生成されます。その際、`sb-cover:store-coverage-data` の最適化品質を 3 に設定します。

~~~lisp
;;; Load SB-COVER
(require :sb-cover)

;;; Turn on generation of code coverage instrumentation
;;; in the compiler
(declaim (optimize sb-cover:store-coverage-data))

;;; Load some code, ensuring that it's recompiled
;;; with the new optimization policy.
(asdf:oos 'asdf:load-op :cl-ppcre-test :force t)

;;; Run the test suite.
(fiveam:run! yoursystem-test)
~~~

カバレッジレポートを出力するには、出力先ディレクトリを指定します。

~~~lisp
(sb-cover:report "coverage/")
~~~

最後に、計測をオフにします。

~~~lisp
(declaim (optimize (sb-cover:store-coverage-data 0)))
~~~

ブラウザで `../yourproject/t/coverage/cover-index.html` を開くと、上の画像のようなレポート、または [cl-ppcre のカバレッジ例](https://www.snellman.net/sbcl/cover/cl-ppcre-report-3/cover-index.html) のような表示を確認できます。


<a id="continuous-integration"></a>

## 継続的インテグレーション

継続的インテグレーションは、コミット後や pull request の前に自動テストを走らせたり、コード品質チェックを行ったり、ソフトウェアをビルドして配布したりするために重要です。要するに、ソフトウェア周りの作業を自動化するためのものです。

プログラムを Lisp 実装間で移植可能にしたいので、CI パイプラインを組み、複数の実装でテストを走らせます。もちろん SBCL と CCL でもよいですし、せっかくなら ABCL、ECL、ほかの実装も含められます。

利用できる継続的インテグレーションサービスには、Travis CI、Circle、GitLab CI、現在なら GitHub Actions などがあります（GitHub Actions より前から存在するものも多いです）。ここでは Common Lisp 用の CI パイプラインの組み方を見ていき、最後は少し GitLab CI に重点を置きます。

あわせて、カバレッジレポートを [Coveralls](https://coveralls.io/) に公開する方法も簡単に示します。[cl-coveralls](https://github.com/fukamachi/cl-coveralls) を使うと、カバレッジをこのサービスへ送れます。

### CI-Utils を使う GitHub Actions、Circle CI、Travis など

ここでは、たくさんの例を含むユーティリティ集 [CI-Utils](https://neil-lindquist.github.io/CI-Utils/) を使います。CI システムとは何かをより正確に説明し、十数種類のサービスも比較しています。

Lisp 実装のインストールとテスト実行には [Roswell](https://github.com/roswell/roswell/) を使います。インストールは bash の 1 行で済みます。

    curl -L https://raw.githubusercontent.com/roswell/roswell/release/scripts/install-for-ci.sh | bash

(GitLab CI の例では、これらをすべて含んだすぐ使える Docker イメージを使います)

FiveAM 用のテストランナーも付属しており、端末へ正しいエラーコードを返すといった面倒な部分を楽にしてくれます。Roswell で ci-utils をインストールすると、`run-fiveam` 実行ファイルが手に入ります。

すると、次のようにテストを実行できます。

    run-fiveam -e t -l foo/test :foo-tests  # foo is our project

以下は完全な `.travis.yml` です。

最初の部分は見れば分かるはずです。

```yml
### Travis CI の設定例 ###
language: generic

addons:
  homebrew:
    update: true
    packages:
    - roswell
  apt:
    packages:
      - libc6-i386 # needed for a couple implementations
      - default-jre # needed for abcl

# 各 OS で各 Lisp 実装を走らせる
os:
  - linux
#  - osx # OSX has a long setup on travis, so it's likely easier
#          to just run select implementations on OSX.
```

こうして実装マトリクスを設定し、複数の Lisp 実装でテストを実行します。SBCL で作ったテストカバレッジは Coveralls に送ります。

```yml
env:
  global:
    - PATH=~/.roswell/bin:$PATH
    - ROSWELL_INSTALL_DIR=$HOME/.roswell
#    - COVERAGE_EXCLUDE=t  # for rove
  jobs:
    # The implementation and whether coverage
    # is sent to coveralls are controlled
    # with these environmental variables
    - LISP=sbcl-bin COVERALLS=true
    - LISP=ccl-bin
    - LISP=abcl
    - LISP=ecl   # warn: in our experience,
    # compilations times can be long on ECL.

# 生成された組み合わせに、追加の OS/Lisp 組み合わせを
# 加えることもできます
jobs:
  include:
    - os: osx
      env: LISP=sbcl-bin
    - os: osx
      env: LISP=ccl-bin
```

一部のジョブは失敗を許可することもできます。


```yml
# これは、そのシステムでライブラリを動かすことに
# 興味がない場合にだけ使うべきです
#  allow_failures:
#    - env: LISP=abcl
#    - env: LISP=ecl
#    - env: LISP=cmucl
#    - env: LISP=alisp
#      os: osx

  fast_finish: true
```

最後に Roswell と各実装をインストールし、テストを実行します。

```yml
cache:
  directories:
    - $HOME/.roswell
    - $HOME/.config/common-lisp

install:
  - curl -L https://raw.githubusercontent.com/roswell/roswell/release/scripts/install-for-ci.sh | sh
  - ros install ci-utils #for run-fiveam
#  - ros install rove #for [run-] rove

  # If asdf 3.16 or higher is needed, uncomment the following lines
  #- mkdir -p ~/common-lisp
  #- if [ "$LISP" == "ccl-bin" ]; then git clone https://gitlab.common-lisp.net/asdf/asdf.git ~/common-lisp; fi

script:
  - run-fiveam -e t -l foo/test :foo-tests
  #- rove foo.asd
```

以下の GitLab CI では、Lisp バイナリと Quicklisp ライブラリのビルドに必要な Debian パッケージをすべて含んだ Docker イメージを使います。


### GitLab CI

[Gitlab CI](https://docs.gitlab.com/ce/ci/README.html) は Gitlab の一部で、[Gitlab.com](https://gitlab.com/) 上で公開・非公開どちらのリポジトリでも利用できます。さっそくシンプルな `.gitlab-ci.yml` を見てみましょう。

~~~
variables:
  QUICKLISP_ADD_TO_INIT_FILE: "true"

image: clfoundation/sbcl:latest

before_script:
  - install-quicklisp
  - git clone https://github.com/foo/bar ~/quicklisp/local-projects/

test:
  script:
    - make test
~~~

GitLab CI は Docker ベースです。`image` で [clfoundation/sbcl](https://hub.docker.com/r/clfoundation/sbcl/) イメージの `latest` タグを使うよう指定しています。これには SBCL の最新版、CI に便利な OS パッケージ群、Quicklisp をインストールするスクリプトが含まれています。GitLab はこのイメージを読み込み、プロジェクトをクローンし、残りのコマンドを実行できる管理権限付きの状態でプロジェクトルートに置いてくれます。

`test` は定義する "job" で、`script` は実行するコマンドの一覧を受け取る既知のキーワードです。

テストの前に依存関係を入れる必要がある場合、`before_script` は各 job の前に実行されます。ここでは Quicklisp をインストールし（SBCL の初期化ファイルへ追加し）、Quicklisp が見つけられる場所にライブラリをクローンしています。

手元でも試せます。すでに [Docker](https://docs.docker.com/) をインストールしていて、デーモンを起動済み（`sudo service docker start`）なら、次のようにできます。

    docker run --rm -it -v /path/to/local/code:/usr/local/share/common-lisp/source clfoundation/sbcl:latest bash

これで Lisp イメージ（圧縮で約 300MB）がダウンロードされ、指定した場所にローカルのコードがマウントされ、bash が起動します。これで `make test` を試せます。

以下は、複数の CL 実装に対して並列にテストする、もう少し完全な例です。

~~~yml
variables:
  IMAGE_TAG: latest
  QUICKLISP_ADD_TO_INIT_FILE: "true"
  QUICKLISP_DIST_VERSION: latest

image: clfoundation/$LISP:$IMAGE_TAG

stages:
  - test
  - build

before_script:
  - install-quicklisp
  - git clone https://github.com/foo/bar ~/quicklisp/local-projects/

.test:
  stage: test
  script:
    - make test

abcl test:
  extends: .test
  variables:
    LISP: abcl

ccl test:
  extends: .test
  variables:
    LISP: ccl

ecl test:
  extends: .test
  variables:
    LISP: ecl

sbcl test:
  extends: .test
  variables:
    LISP: sbcl

build:
  stage: build
  variables:
    LISP: sbcl
  only:
    - tags
  script:
    - make build
  artifacts:
    paths:
      - some-file-name
~~~

ここでは 2 つの `stages`（[環境](https://docs.gitlab.com/ee/ci/environments/) を参照）"test" と "build" を定義し、順番に実行するようにしています。"build" ステージは "test" が成功したときだけ始まります。

"build" は、毎回のコミットではなく、新しいタグが push されたときにだけ `only` で実行されます。成功すると、`artifacts` の `paths` に列挙したファイルをダウンロード可能にします。これらは GitLab の Pipelines UI から、または URL からダウンロードできます。次の URL は、最新の "build" job から "some-file-name" をダウンロードします。

    https://gitlab.com/username/project-name/-/jobs/artifacts/master/raw/some-file-name?job=build

パイプラインが通ると、次のように表示されます。

![](assets/img-ci-build.png)

これで、すぐ使える GitLab CI の設定ができました。

### SourceHut

[SourceHut](https://sr.ht/) の Common Lisp 向け CI を設定するのはとても簡単です。以下は最小構成の `.build.yml` で、[build manifest tester](https://builds.sr.ht/) で試せます。

```yaml
image: archlinux
packages:
- sbcl
- quicklisp
sources:
- https://git.sr.ht/~fosskers/cl-transducers
tasks:
# If our project isn't in the special `common-lisp` directory, quicklisp won't
# be able to find it for loading.
- move: |
    mkdir common-lisp
    mv cl-transducers ~/common-lisp
- quicklisp: |
    sbcl --non-interactive --load /usr/share/quicklisp/quicklisp.lisp --eval "(quicklisp-quickstart:install)"
- test: |
    cd common-lisp/cl-transducers
    sbcl --non-interactive --load ~/quicklisp/setup.lisp --load run-tests.lisp
```

与えられる Docker イメージはほぼ空なので、`sbcl` と `quicklisp` を手動でインストールする必要があります。さらに、テスト駆動用に `run-tests.lisp` ファイルを実行している点にも注意してください。例は次のようになります。

```lisp
(ql:quickload :transducers/tests)
(in-package :transducers/tests)

(let ((status (parachute:status (parachute:test 'transducers/tests))))
  (cond ((eq :PASSED status) (uiop:quit))
        (t (uiop:quit 1))))
```

ここでは [Parachute](https://shinmera.github.io/parachute/) テストライブラリの例を示しています。ほかの箇所でも述べたように、どれか 1 つでもテストが失敗したら CI ジョブ全体を失敗にするには、テスト結果の状態を手動で確認し、問題があれば `1` を返します。

## Emacs 統合: Slite を使ってテストを走らせる

[Slite](https://github.com/tdrhq/slite) は SLIme TEst runner の略です。テスト失敗の要約を見たり、テスト定義へ飛んだり、デバッガ付きでテストを再実行したりできます。しかも、これらを Emacs の中だけで行えます。緑と赤のバッジが並ぶダッシュボード風バッファが表示され、そこからテストに対処できます。テストの流れがさらに一体化し、対話的になります。

これは ASDF システムと Emacs パッケージで構成されています。新しいプロジェクト（2021 年半ばに登場）なので、2021 年 9 月時点では Quicklisp や MELPA からはまだインストールできません。導入方法は [リポジトリ](https://github.com/tdrhq/slite) を参照してください。

## 参考文献

- [Tutorial: Working with FiveAM](http://turtleware.eu/posts/Tutorial-Working-with-FiveAM.html), by Tomek "uint" Kurcz
- [Comparison of Common Lisp Testing Frameworks](https://sabracrolleton.github.io/testing-framework), by Sabra Crolleton.
- the [CL Foundation Docker images](https://hub.docker.com/u/clfoundation)

## 関連項目

- [cl-cookieproject](https://github.com/vindarel/cl-cookieproject), a project skeleton with a FiveAM tests structure.
