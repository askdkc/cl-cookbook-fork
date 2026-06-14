---
title: デバッグ
---

Lisp という新しい世界に入ると、次の疑問が出てくるでしょう。何が起きているかをどうデバッグするのか？ ほかのプラットフォームよりどこが対話的なのか？ スタックトレース以外に、対話的デバッガは何をもたらすのか？

## print デバッグ

もちろん有名な "print debugging" という手法は使えます。まずはいくつかの出力関数を簡単に振り返ります。

`print` は使えます。引数の `read` 可能な表現を出力します。つまり、`print` されたものは Lisp リーダで読み戻せます。引数は 1 つだけ受け取ります。

`princ` は*見た目向け*の表現に重点を置きます。

`(format t "~a" …)` は、*見た目向け*ディレクティブにより文字列を（標準出力ストリームである `t` に）出力し、nil を返します。一方 `format nil …` は何も出力せず、文字列を返します。多くの format 制御を使えば、複数の変数を一度に出力できます。

`print` にはデバッグに便利な性質があります。引数として渡されたフォームを出力し、さらにその結果を返します。アルゴリズムの途中に `print` 文を挟んでも、処理は壊れません。

~~~lisp
(+ 2 (print 40))
~~~


## ロギング

ロギングは、print デバッグからのよい進化です ;)

[log4cl](https://github.com/sharplispers/log4cl/) は人気のある、事実上の標準的なロギングライブラリです。ただし唯一の選択肢ではありません。ダウンロードします。

~~~lisp
(ql:quickload "log4cl")
~~~

ダミー変数を用意します。

~~~lisp
(defvar *foo* '(:a :b :c))
~~~

log4cl は `log` ニックネームで使えます。すると、使い方は次のように単純です。

~~~lisp
(log:info *foo*)
;; <INFO> [13:36:49] cl-user () - *FOO*: (:A :B :C)
~~~

文字列と式を、`format` 制御文字列の有無にかかわらず混在させられます。

~~~lisp
(log:info "foo is " *foo*)
;; <INFO> [13:37:22] cl-user () - foo is *FOO*: (:A :B :C)
(log:info "foo is ~{~a~}" *foo*)
;; <INFO> [13:39:05] cl-user () - foo is ABC
~~~

関連ライブラリ `log4slime` を使うと、ログレベルを対話的に変更できます。

- グローバルに
- パッケージごとに
- 関数ごとに
- CLOS メソッドと CLOS 階層（before/after メソッド）ごとに

大量の出力があるとき、すでに正しく動いていると分かっている関数やパッケージのログを止め、探索範囲を正しい場所へ絞り込めるので非常に便利です。この設定を保存し、別のイメージ、別のマシン上でも再利用できます。

これはコマンド、キーボードショートカット、メニューやマウスクリックから実行できます。

!["changing the log level with log4slime"](assets/log4cl.png)

log4cl の README も読んでみてください。

## 強力な REPL を使う

Lisp の楽しさの一部は、優れた REPL にあります。通常の作業では、REPL の存在によってほかのデバッグツールが必要になる時期が遅れます。場合によっては不要になることすらあります。

関数を定義したら、すぐ REPL で試せます。Slime では、`C-c C-c` で関数をコンパイルし（バッファ全体は `C-c C-k`）、`C-c C-z` で REPL に切り替えて試します。必要に応じて `(in-package :your-package)`、または `C-c ~`（`slime-sync-package-and-default-directory`、パッケージ定義のディレクトリへデフォルト作業ディレクトリも変更します）で作業中のパッケージに入ります。

フィードバックは即座に得られます。すべてを再コンパイルする必要も、プロセスを再起動する必要も、main 関数を作ってシェル用のコマンドライン引数を定義する必要もありません（もちろん必要になれば後でできます）。

関数をテストするために、何らかのデータを作ることがよくあります。これは REPL があることに伴う一つの技法で、初心者には新しい習慣かもしれません。コツは、テストデータを関数の近く、ただし `#+nil` feature test（またはより安全に `#+(or)`。誰かが `NIL` を `*features*` リストへ push している可能性は残るため）の下に書いておき、自分だけが手動でコンパイルできるようにすることです。

~~~lisp
#+nil
(progn
   (defvar *test-data* nil)
   (setf *test-data* (make-instance 'foo …)))
~~~

このファイルをロードしても `*test-data*` は存在しませんが、`C-c C-c` で手動作成できます。

このようにテスト用関数を定義できます。

`#| … |#` コメントの中で同様のことをする人もいます。

とはいえ、時期が来たらユニットテストを書くことを忘れないでください ;)


## inspect と describe

この 2 つのコマンドは、オブジェクトの説明を出力するという同じ目的を持ちます。`inspect` は対話的なものです。

~~~
(inspect *foo*)

The object is a proper list of length 3.
0. 0: :A
1. 1: :B

2. 2: :C
> q
~~~

対応しているエディタでは、REPL 内の任意のオブジェクトを右クリックして `inspect` することもできます（Slime では調べたいオブジェクト上で `C-c I`）。データ構造の内部へ深く潜り、変更すらできる画面が表示されます。

もう少し面白い構造、オブジェクトで簡単に見てみましょう。

~~~lisp
(defclass foo ()
    ((a :accessor foo-a :initform '(:a :b :c))
     (b :accessor foo-b :initform :b)))
;; #<STANDARD-CLASS FOO>
(make-instance 'foo)
;; #<FOO {100F2B6183}>
~~~

`#<FOO` オブジェクトを右クリックし、"inspect" を選びます。対話的なペイン（Slime の場合）が表示されます。

!["Slime's inspector, a textual window with buttons"](assets/slime-inspector.png)

スロット A の行をクリックするか Enter を押すと、さらに詳しく調べられます。

```
#<CONS {100F5E2A07}>
--------------------
A proper list:
0: :A
1: :B
2: :C
```

LispWorks ではグラフィカルなインスペクタを使えます。

!["The LispWorks inspector window"](assets/lispworks-graphical-inspector.png)



## Trace

[trace](http://www.lispworks.com/documentation/HyperSpec/Body/m_tracec.htm) を使うと、関数がいつ呼ばれたか、どんな引数を受け取ったか、どんな値を返したかを確認できます。

~~~lisp
(defun factorial (n)
  (if (plusp n)
    (* n (factorial (1- n)))
    1))
~~~

関数のトレースを始めるには、関数名（または複数の関数名）を指定して `trace` を呼ぶだけです。

~~~lisp
(trace factorial)

(factorial 2)
  0: (FACTORIAL 3)
    1: (FACTORIAL 2)
      2: (FACTORIAL 1)
        3: (FACTORIAL 0)
        3: FACTORIAL returned 1
      2: FACTORIAL returned 1
    1: FACTORIAL returned 2
  0: FACTORIAL returned 6
6

(untrace factorial)
~~~

すべての関数のトレースを解除するには、`(untrace)` を評価します。

現在トレースされている関数の一覧を得るには、引数なしで `(trace)` を評価します。

Slime では、関数をトレースまたはトレース解除するショートカット `C-c M-t` があります。

再帰呼び出しが見えない場合、コンパイラの最適化が原因かもしれません。トレースしたい関数を定義する前に、次を試してください。

~~~lisp
(declaim (optimize (debug 3)))  ;; 最大デバッグ設定でコンパイルするには C-u C-c C-c でもよい。
~~~

出力は `*trace-output*` に出力されます（CLHS を参照）。


### Trace オプション

`trace` はオプションを受け取ります。たとえば `:break t` を使うと、関数が呼び出される前、関数開始時にデバッガを起動できます（break については後述）。

~~~lisp
(trace factorial :break t)
(factorial 2)
~~~

`trace` の 1 回の呼び出しで多くのものを定義できます。たとえば、最初のトレース対象関数名より前に現れるオプションは*グローバル*で、その後に追加するすべてのトレース関数に影響します。ここでは、`:break t` が後続のすべての関数 `factorial`、`foo`、`bar` に設定されます。

~~~lisp
(trace :break t factorial foo bar)
~~~

逆に、オプションが関数名の後に来る場合、それは*ローカル*オプションとして、直前の関数にだけ作用します。最初に行ったのはこちらです。下では `foo` と `bar` は後に来るので、`:break` の影響を受けません。

~~~lisp
(trace factorial :break t foo bar)
~~~

しかし本当に関数呼び出しの*前*に `break` したいのでしょうか、それとも*後*でしょうか？ `:break` では、多くのオプションと同じく選べます。`:break` のオプションは次のとおりです。

```
:break form  ;; 前
:break-after form
:break-all form ;; 前と後
```

`form` は真に評価される任意のフォームです。

ここで説明したのは SBCL の trace 関数です。ほかの処理系にも同様の機能があるかもしれませんが、構文やオプション名は異なる場合があります。たとえば LispWorks では ":break-after" ではなく ":break-on-exit" で、`(trace (factorial :break t))` と書きます。

以下では、ほかのオプションをいくつか紹介します。その前に、`:break` を使った小技です。

### Trace オプション: break

オプションの引数には任意のフォームを渡せます。SBCL で、`factorial` が 0 で呼び出されようとしているときに break ウィンドウを出す小技です。`(sb-debug:arg 0)` は最初の引数 `n` を指します。

~~~lisp
CL-USER> (trace factorial :break (equal 0 (sb-debug:arg 0)))
;; WARNING: FACTORIAL is already TRACE'd, untracing it first.
;; (FACTORIAL)
~~~

もう一度実行します。

```
CL-USER> (factorial 3)
  0: (FACTORIAL 3)
    1: (FACTORIAL 2)
      2: (FACTORIAL 1)
        3: (FACTORIAL 0)

breaking before traced call to FACTORIAL:
   [Condition of type SIMPLE-CONDITION]

Restarts:
 0: [CONTINUE] Return from BREAK.
 1: [RETRY] Retry SLIME REPL evaluation request.
 2: [*ABORT] Return to SLIME's top level.
 3: [ABORT] abort thread (#<THREAD "repl-thread" RUNNING {1003551BC3}>)

Backtrace:
  0: (FACTORIAL 1)
      Locals:
        N = 1   <---------- (factorial 0) を呼ぶ前なので、n は 1。
```


### Trace オプション: 条件付きトレース、別関数から呼ばれた場合のトレース

`:condition` は、`form` 内の条件が真に評価される場合だけトレースを有効にします。

```
:condition form
:condition-after form
:condition-all form
```

> :condition が指定された場合、呼び出し時に Form が真に評価されないかぎり trace は何もしません。:condition-after も同様ですが、最初の出力を抑制し、関数が戻るときにテストされます。:condition-all は前後の両方で試します。

`:wherein` は非常に便利です。

```
:wherein Names
```

> 指定した場合、Names は関数名または名前のリストです。それらの関数のいずれかの呼び出しがこの関数の呼び出しを包んでいないかぎり（つまりバックトレースに現れないかぎり）、trace は何もしません。無名関数には "DEFUN FOO" のような文字列名があります。


```
:report Report-Type
```

> Report-Type が trace（デフォルト）の場合、情報はただちに出力されます。Report-Type が nil の場合、trace の効果はほかのオプション（print や break など）を実行することだけです。それ以外の場合、Report-Type は関数指定子として扱われ、各 trace イベントごとに 5 つの引数で funcall されます。trace の深さ（非負整数）、関数名または関数オブジェクト、キーワード（:enter、:exit、:non-local-exit）、スタックフレーム、値（引数または戻り値）のリストです。

トレース出力を豊かにするには `:print` も参照してください。

処理系が `trace` を非標準オプションで拡張するのは普通のことです。ここでは利用可能なオプションをすべて挙げたわけではないので、使っている処理系のドキュメントを参照してください。

- [SBCL trace](http://www.sbcl.org/manual/index.html#Function-Tracing)
- [CCL trace](https://ccl.clozure.com/manual/chapter4.2.html)
- [LispWorks trace](http://www.lispworks.com/documentation/lw80/lw/lw-tracer-ug-2.htm)
- [Allegro trace](https://franz.com/support/documentation/current/doc/debugging.htm#tracer-1)


### メソッド呼び出しのトレース

SBCL では、`(trace foo :methods t)` を使うとメソッド結合（before、after、around メソッド）の実行順序をトレースできます。例:

~~~lisp
(trace foo :methods t)

(foo 2.0d0)
  0: (FOO 2.0d0)
    1: ((SB-PCL::COMBINED-METHOD FOO) 2.0d0)
      2: ((METHOD FOO (FLOAT)) 2.0d0)
        3: ((METHOD FOO (T)) 2.0d0)
        3: (METHOD FOO (T)) returned 3
      2: (METHOD FOO (FLOAT)) returned 9
      2: ((METHOD FOO :AFTER (DOUBLE-FLOAT)) 2.0d0)
      2: (METHOD FOO :AFTER (DOUBLE-FLOAT)) returned DOUBLE
    1: (SB-PCL::COMBINED-METHOD FOO) returned 9
  0: FOO returned 9
9
~~~

CCL でも可能です。

もう少し情報が必要なら [CLOS](clos.html) セクションを参照してください。

### 対話的 Trace Dialog

SLIME と SLY はどちらも、トレースをより見やすく表示し、引数と戻り値にも、単なる印字表現ではなくインスペクタ経由で実体の形式でアクセスできる[対話的なトレース表示](https://slime.common-lisp.dev/doc/html/SLIME-Trace-Dialog.html#SLIME-Trace-Dialog)を提供します。

![trace-dialog](trace-dialog.png "Trace dialog")

動作方法（以下の手順は SLIME 向けです）:

1. `C-c M-t` に割り当てられた `M-x slime-trace-dialog-toggle-trace` で、トレースする関数を選びます。
2. トレース対象関数を呼び出すコードを評価します。
3. `C-c T` に割り当てられた `M-x slime-trace-dialog` で trace dialog ツールを開きます。
4. トレース対象関数の一覧が `Traced specs` の下に表示されます。トレースはバッチで取得されます。そのため `[refresh]` ボタンで、トレース状況（取得可能なトレース数）を更新します。
5. 次に `[fetch next batch]` または `[fetch all]` ボタンでトレースを取得します。その後、トレースは `Traced specs` の下に表示され、SLIME インスペクタでそのデータ（引数と戻り値）を可視化できます。
6. トレース対象関数を呼び出すコードをさらに評価したら、この手順を繰り返します（ステップ 4 へ）。

ただし、この流れは、トレース状態の更新と取得が分かれているため、少し面倒になることがあります。状態更新を先に行わず、そのままトレースを取得した方がよい場合もあります。これは `G` に割り当てられた `M-x slime-trace-dialog-fetch-traces` を呼び出すことでできます。つまり、ステップ 4 と 5 の代わりに `G` を押してユーザーインターフェイスを更新します。

便利なキーに割り当てられている Emacs コマンドの一部です。

`g`
`M-x slime-trace-dialog-fetch-status`

    トレース収集と traced specs の情報を更新します。

`G`
`M-x slime-trace-dialog-fetch-traces`

    未取得のトレースの次のバッチを取得します。C-u prefix argument を付けると、未取得のトレースがなくなるまで繰り返します。

`C-k`
`M-x slime-trace-dialog-clear-fetched-traces`

    確認を求めたうえで、取得済みと未取得の両方を含むすべてのトレースを消去します。


最後に、各トレースエントリの引数と戻り値は対話的なボタンです。クリックすると、それらに対して SLIME インスペクタが開きます。`M-RET` `M-x slime-trace-dialog-copy-down-to-repl` を呼び出すと、操作のため REPL に戻せます。各エントリの左側の数字は呼び出し順における絶対位置を示し、複数スレッドが同じトレース対象関数を呼ぶ場合には表示順と異なることがあります。

`M-x slime-trace-dialog-hide-details-mode` は引数と戻り値を隠し、呼び出しロジックに集中できるようにします。また、`M-x slime-trace-dialog-autofollow-mode` はカーソルがエントリ上を移動したときに、そのエントリの追加詳細を自動表示します。

## 対話的デバッガ

例外的な状況が起きたとき（[エラー処理](error_handling.html)を参照）、または自分で要求したとき（`step` や `break` を使用）、対話的デバッガが表示されます。

そこにはエラーメッセージ、利用可能な操作（*restarts*）、バックトレースが表示されます。いくつか注意点があります。

- restarts はプログラム可能で、自分で作成できます。
- Slime では、スタックトレースのフレーム上で `v` を押すと対応するソースファイル位置を表示できます。
- フレーム上で Enter（または `t`）を押すと詳細表示を切り替えます。
- `e` を使うと、そのフレーム内でコードを評価できます。
- `r` を押すと、指定したフレームを再起動できます（後述）。
- エディタに表示されるはずのメニューから、機能を探索できます。

### 最大のデバッグ情報でコンパイルする（`declaim` と `C-u` prefix）

通常、コンパイラはさまざまなものを最適化で取り除くため、デバッガで利用できる情報量が減ります。たとえば計算途中の変数が見えないことがあります。最適化の選択は次で変更できます。

~~~lisp
(declaim (optimize (speed 0) (space 0) (debug 3)))
~~~

そしてコードを再コンパイルします。同じことは便利なショートカット `C-u C-c C-c` でもできます。このフォームは最大デバッグ設定でコンパイルされます。逆に負の prefix argument（`M--`）を使うと速度優先でコンパイルできます。また数値引数を使うと、その設定値を指定できます（`slime-compile-defun` の docstring を読むとよいでしょう）。

同様に、現在のバッファ全体へ最大デバッグ設定を適用するには `C-u C-c C-k` を使えます。最大速度には `M--` prefix を使います。


## Step

[step](http://www.lispworks.com/documentation/HyperSpec/Body/m_step.htm) は `trace` と似た範囲を持つ対話的コマンドです。これは:

~~~lisp
;; 注: より多くのデバッグ情報を得るため、factorial をファイルにコピーした。
(step (factorial 3))
~~~

利用可能な操作（restarts）とバックトレースを含む対話的ペインを表示します。

```
Evaluating call:
  (FACTORIAL 3)
With arguments:
  3
   [Condition of type SB-EXT:STEP-FORM-CONDITION]

Restarts:
 0: [STEP-CONTINUE] Resume normal execution   <-------------------- stepping actions
 1: [STEP-OUT] Resume stepping after returning from this function
 2: [STEP-NEXT] Step over call
 3: [STEP-INTO] Step into call
 4: [RETRY] Retry SLIME REPL evaluation request.
 5: [*ABORT] Return to SLIME's top level.
 --more--

Backtrace:
  0: (FACTORIAL 3)     <----------- press Enter to fold/unfold. Fix your code and press "r" to restart it.
      Locals:
        N = 3          <----------- want to check? Move the point here and
                                    press "e" to evaluate code on that frame.

  1: (SB-INT:SIMPLE-EVAL-IN-LEXENV (LET ((SB-IMPL::*STEP-OUT* :MAYBE)) (UNWIND-PROTECT (SB-IMPL::WITH-STEPPING-ENABLED #))) #S(SB-KERNEL:LEXENV :FUNS NIL :VARS NIL :BLOCKS NIL :TAGS NIL :TYPE-RESTRICTIONS ..
  2: (SB-INT:SIMPLE-EVAL-IN-LEXENV (STEP (FACTORIAL 3)) #<NULL-LEXENV>)
  3: (EVAL (STEP (FACTORIAL 3)))
 --more--

```

*（繰り返しになりますが、関数は最大デバッグ設定でコンパイルしておいてください（上記参照）。そうでないと、コンパイラが内部で最適化を行い、ローカル変数のような有用な情報が見えなかったり、そもそもステップ実行できなかったりします。）*

ここには多くの選択肢があります。Emacs（実際にはほかのエディタでも）を使っているなら、step ウィンドウに加えて、利用可能な操作を表示する "SLDB" メニューがあることを覚えておいてください。

- restarts に従って**ステップ実行を続ける**: 実行を継続する、この関数から出る、ポイント上の関数呼び出しに入る、次の関数呼び出しまで進む、またはすべてを中止する。ショートカットは次のとおりです。
  - `c`: continue
  - `s`: step
  - `x`: step next
  - `o`: step out

- **バックトレース**とソースコードを調べる。バックトレースの各スタックフレーム（各行）で `v` を押すとソースファイルへ移動できます。スタックフレーム上で `Enter` または `t`（"toggle details"）を押すと、この呼び出しの関数パラメータなど、より多くの情報を表示できます。`n` と `p` で移動し、`M-n` と `M-p` で次または前のスタックフレームへ移動しながら、対応するソースファイルも同時に開けます。ポイントは呼び出されている関数上に置かれます。

- そのスタックフレームの**コンテキスト内でコードを評価する**。Slime では `e`（"eval in frame"、結果を pretty-print するには `d`）を使い、Lisp フォームを入力します。ポイントがあるスタックフレームのコンテキストで実行されます。変数を inspect して、Slime に別の inspector ウィンドウを開かせることすらできます。最初のフレーム（`0:`）上にいるなら、`i` を押し、次に "n" を押して中間変数を inspect します。

- 好きな場所から**実行を再開する**。ポイントがあるフレームを再起動するには `r` を使います。たとえば、（対話的デバッガを終了せずに）ソースコードを変更し、再コンパイルし、そのフレームを再実行して改善されたか確認します。プログラム全体の実行を再起動したのではありません。プログラムを正確な一点から再起動しただけです。スタックフレームから戻るには `R` を使い、戻り値を与えます。

<div class="info-box info" style="margin-bottom: 1em">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> 考えてみてください。<strong>これはすごいことです！</strong> プログラムを任意の時点から再起動したのです。長時間実行される計算を扱っている場合、最初からやり直す必要はありません。問題のあるコードを変更、再コンパイルし、通過に必要な地点から実行を再開できます。
</div>

ステップ実行は貴重です。ただし、ある関数の挙動を何度も調べているなら、その関数を単純化し、より小さな部品に分ける必要があるサインかもしれません。

そして繰り返しますが、**LispWorks** には**グラフィカルなステッパ**があります。


<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px; margin-bottom: 1em;">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>TIP:</strong> <a href="https://github.com/mmontone/slime-breakpoints">slime-breakpoints</a> パッケージは、Slime にもステップ実行と break のボタンを追加します。
</div>

![](assets/slime-breakpoints-toolbars.png)

### スタック内の任意の場所からプログラム実行を再開する（デモ）

[この動画](https://www.youtube.com/watch?v=jBBS4FeY7XM) では、上で説明した流れ、つまりバグのある関数を修正し、すべてをゼロから実行し直さずに、スタック内の任意の場所から**プログラム実行を再開する**方法のデモを見られます。この動画では Emacs と Slime、Lem エディタ、いずれも SBCL を使っています。

重要なのは、スタックフレーム上で `r`（`sldb-restart-frame`）を使って再起動することです。

<!-- epub-exclude-start -->

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/jBBS4FeY7XM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<!-- epub-exclude-end -->


## Break

[break](http://www.lispworks.com/documentation/HyperSpec/Body/f_break.htm) を呼び出すと、プログラムはデバッガに入り、そこからコールスタックを調べ、ステッパで上に述べたすべてのことを実行できます。


### Slime のブレークポイント

`SLDB` メニューを見てください。ナビゲーションキーと利用可能な操作が表示されます。その中には次のものがあります。

- `e`（*sldb-eval-in-frame*）は式の入力を促し、選択されたフレームで評価します。これにより中間変数を探索できます。
- `d` は似ていますが、結果を pretty printing します。

フレーム内に入り、不審な挙動を見つけたら、実行時に関数を再コンパイルし、停止した場所からプログラム実行を再開することもできます（"step-continue" restart を使うか、指定したスタックフレーム上で `r`（"restart frame"）を使います）。

コード注釈なしでブレークポイントを設定するには、上で触れた [Slime-star](https://github.com/mmontone/slime-star) Emacs 拡張も参照してください。

## 条件発生時に break する: `*break-on-signals*`

[*break-on-signals*](https://cl-community-spec.github.io/pages/002abreak_002don_002dsignals_002a.html) は、エラー（または任意の condition）が発生したことは分かるがデバッガが出ず、エラー（または任意の condition）が signal される*直前*にデバッガを強制的に開きたいとき、特に役立ちます。

たとえば、サードパーティライブラリのデータベースレコードの `print-object` メソッドが、何か問題が起きたと知らせてくるとします。

    #<DB record: <<ERROR while printing the DB object>> >

しかし、そのライブラリがエラーを処理してしまい、対話的デバッガは表示されませんでした。

これをデバッグするには、`*break-on-signals` を `'error`（または既存の condition 型を指す任意のシンボル）に設定できます。

通常は、`*break-on-signals*` は NIL です。

~~~lisp
(ignore-errors
 (format t "*break-on-signals* value is: ~a~&" *break-on-signals*)
 (error 'simple-error :format-control "Oh no!"))
;; *break-on-signals* value is: NIL   <--- stdout
;; NIL                                <--- first returned value
;; #<SIMPLE-ERROR "Oh no!" {1205C6BC03}>  <-- second returned value, the condition object.
~~~

`*break-on-signals*` を `'error` に設定してみます。

~~~lisp
(let ((*break-on-signals* 'error))
 (format t "*break-on-signals* value is: ~a~&" *break-on-signals*)
  (ignore-errors
   (error 'simple-error :format-control "Oh no!")))
~~~

`error` が `ignore-errors` に囲まれているにもかかわらず、対話的デバッガが表示されます。

```
Oh no!
BREAK was entered because of *BREAK-ON-SIGNALS* (now rebound to NIL).
   [Condition of type SIMPLE-CONDITION]

Restarts:
 0: [CONTINUE] Return from BREAK.
 1: [RESET] Set *BREAK-ON-SIGNALS* to NIL and continue.
 2: [REASSIGN] Return from BREAK and assign a new value to *BREAK-ON-SIGNALS*.
 …

Backtrace:
 …
```

デバッガから、スタックトレースを調べ、condition を signal した行へ移動し、修正して実行を再開できます。

signal された condition がエラーの場合、break を処理した後に 2 回目のデバッガには入りません。


## Advise と watch

*advise* と *watch* は、CCL（[advise](https://ccl.clozure.com/manual/chapter4.3.html#Advising) と [watch](https://ccl.clozure.com/manual/chapter4.12.html#watched-objects)）や LispWorks など、一部の処理系で利用できます。SBCL にも存在しますが、export されていません。`advise` を使うと、ソースを変更せずに関数を変更したり、実行前後に何かを行ったりできます。CLOS のメソッド結合（before、after、around メソッド）に似ています。

`watch` は、監視中のオブジェクトへスレッドが書き込もうとしたときに condition を signal します。GUI 内で監視対象オブジェクトを表示する機能と組み合わせることもできます。ある種のバグ（誰かがこの値を変更しているが、誰か分からない）には、非常に役立つことがあります。

## クロスリファレンス

Lisp は、関数が参照または呼び出されているすべての場所、グローバル変数が set されている場所、マクロが展開されている場所などを教えてくれます。たとえば `slime-who-calls`（`C-c C-w C-c` または Slime > Cross-Reference メニュー）は、関数が呼び出されているすべての場所を表示します。

- `slime-who-references`: グローバル変数参照
- `slime-who-bind`: グローバル変数束縛
- `slime-who-sets`: グローバル変数 setter
- `slime-who-specializes`: シンボルに特殊化されたメソッド
- `slime-who-macroexpands`: マクロが展開されている場所
- `slime-list-callees`: 指定した関数本体内で呼び出されるすべての関数を一覧表示します。
- `slime-list-callers`: 指定した関数を呼び出すすべての関数を一覧表示します。

このようなクロスリファレンス関数を呼び出すと、結果一覧を含む新しいバッファが開きます。参照間を移動でき、通常のショートカット（`C-c C-k`）で一覧された関数やマクロをすべて再コンパイルすることもできます。これは、マクロを変更したばかりで、そのマクロを使っているすべての関数を再コンパイルしたいときに特に便利です。

コマンドと Slime ショートカットの完全な一覧は Emacs ページを参照してください。


## SLY stepper と SLY stickers

SLY には改良された [stepper](https://github.com/joaotavora/sly-stepper) と、独自機能である [stickers](https://joaotavora.github.io/sly/#Stickers) があります。コードの一部に印を付けてコードを実行すると、SLY は各 sticker の結果を取得し、プログラム実行を対話的に調べられるようにします。どの sticker が取得されたか、またはされなかったかを確認できるため、その関数呼び出しにおけるコードカバレッジを一目で把握できます。

これらは `print` と `break` に対する非侵入的な代替手段です。

## ユニットテスト

最後に、独立した関数の自動テストこそ探しているものかもしれません！ [testing](testing.html) セクションと [test frameworks and libraries](https://github.com/CodyReichert/awesome-cl#unit-testing) の一覧を参照してください。


## リモートデバッグ

ソフトウェアをネットワーク上のマシンで実行し、そこへ接続して、自宅や開発環境からデバッグできます。

手順は、リモートマシン上で **Swank server**（Swank は Slime のバックエンド伴走役です）を起動し、ssh トンネルを作成し、エディタから Swank server に接続することです。すると実行中のインスタンス上で透過的にコードを閲覧、評価できます。

これを試すため、永久に出力する関数を定義しましょう。

必要なら、まず依存関係を import します。

~~~lisp
(ql:quickload '("swank" "bordeaux-threads"))
~~~


~~~lisp
;; 小さな common lisp swank デモ
;; このプログラムの実行中、別のターミナルやマシンから接続できる
;; そして doprint の定義を変更し、別のものを出力させられる！

(require :swank)
(require :bordeaux-threads)

(defparameter *counter* 0)

(defun dostuff ()
  (format t "hello world ~a!~%" *counter*))

(defun runner ()
  (swank:create-server :port 4006 :dont-close t)
  (format t "we are past go!~%")
  (bt:make-thread (lambda ()
                    (loop repeat 5 do
                          (sleep 5)
                          (dostuff)
                          (incf *counter*)))
                  :name "do-stuff"))

(runner)
~~~

サーバ上では、このコードを次で実行できます。

    sbcl --load demo.lisp

`(bt:all-threads)` で確認すると、ポート 4006 で動作中の Swank server と、処理を行う準備ができた別スレッドが見えるはずです。

    (#<SB-THREAD:THREAD "do-stuff" RUNNING {10027CEDC3}>
     #<SB-THREAD:THREAD "Swank Sentinel" waiting on:
          #<WAITQUEUE  {10027D0003}>
        {10027CE8B3}>
     #<SB-THREAD:THREAD "Swank 4006" RUNNING {10027CEB63}>
     #<SB-THREAD:THREAD "main thread" RUNNING {1007C40393}>)

開発マシン上でポートフォワーディングを行います。

    ssh -L4006:127.0.0.1:4006 username@example.com

これにより、example.com のサーバ上のポート 4006 が、ローカルコンピュータのポート 4006 へ安全に転送されます（Swank は localhost からの接続だけを受け付けます）。

実行中の Swank へ `M-x slime-connect` で接続し、ホストには localhost、ポートには 4006 を選びます。

新しいコードを書けます。

~~~lisp
(defun dostuff ()
  (format t "goodbye world ~a!~%" *counter*))
(setf *counter* 0)
~~~

そして通常どおり、たとえば `C-c C-c` や `M-x slime-eval-region` で評価します。出力が変わるはずです。

Ron Garret は 1999 年に、このようにして地球から Deep Space 1 探査機をデバッグしました。

> 地上試験では現れなかった競合状態をデバッグし、修正できました。（1 億マイル離れた 1 億ドルのハードウェア上で動くプログラムをデバッグするのは興味深い経験です。探査機上で read-eval-print loop が動いていたことは、問題の発見と修正に非常に貴重でした。


## 参考資料

- ["How to understand and use Common Lisp"](https://successful-lisp.blogspot.com/p/httpsdrive.html)、第 30 章、David Lamkins（著者サイトから書籍をダウンロード）
- [Malisper: debugging Lisp series](https://malisper.me/debugging-lisp-part-1-recompilation/)
- [Two Wrongs: debugging Common Lisp in Slime](https://two-wrongs.com/debugging-common-lisp-in-slime.html)
- [Slime documentation: connecting to a remote Lisp](https://common-lisp.net/project/slime/doc/html/Connecting-to-a-remote-lisp.html#Connecting-to-a-remote-lisp)
- [cvberrycom: remotely modifying a running Lisp program using Swank](http://cvberry.com/tech_writings/howtos/remotely_modifying_a_running_program_using_swank.html)
- [Ron Garret: Lisping at the JPL](http://www.flownet.com/gat/jpl-lisp.html#1994-1999%20-%20Remote%20Agent)
- [the Remote Agent experiment: debugging code from 60 million miles away (youtube)](https://www.youtube.com/watch?v=_gZK0tW8EhQ&feature=youtu.be&t=4175)（[reddit の "AMA"](https://www.reddit.com/r/lisp/comments/a7156w/lisp_and_the_remote_agent/)）
