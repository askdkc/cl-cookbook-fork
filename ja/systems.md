---
title: システムを定義する
---

**システム**とは、アプリケーションまたはライブラリを構成する Lisp ファイルの集まりであり、そのため全体として管理されるべきものです。**システム定義**は、どのソースファイルがシステムを構成するのか、それらの依存関係は何か、どの順序でコンパイルおよびロードされるべきかを記述します。


## ASDF

[ASDF](https://gitlab.common-lisp.net/asdf/asdf) は Common Lisp の標準ビルドシステムです。ほとんどの Common Lisp 処理系に同梱されています。[UIOP](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/README.md)、すなわち _"the Utilities for Implementation- and OS- Portability"_ も含まれています。[マニュアル](https://common-lisp.net/project/asdf/asdf.html) と [チュートリアルおよびベストプラクティス](https://gitlab.common-lisp.net/asdf/asdf/blob/master/doc/best_practices.md) を読むことができます。

<a name="example"></a>

## 簡単な例

### システム定義をロードする

Lisp を起動した時点で、Lisp は内部モジュールについては知っていますが、デフォルトでは、あなたのすばらしい新プロジェクトが `~/code/foo/bar/new-ideas/` ディレクトリの下にあることを知る方法がありません。そのため、プロジェクトをイメージにロードするには、次の3つの方法のいずれかを使います。

- ASDF または Quicklisp のデフォルトを使う
- ASDF または Quicklisp がプロジェクト定義を探す場所を設定する
- プロジェクト定義を明示的にロードする

[getting started#how-to-load-an-existing-project](https://lispcookbook.github.io/cl-cookbook/getting-started.html#how-to-load-an-existing-project) ページの該当節を読んでください。


### システムをロードする

Lisp がシステムとは何か、どこにあるかを知ったら、それをロードできます。

ASDF の最も単純な使い方は、`asdf:load-system` を呼び出してライブラリをロードすることです。その後、それを使えます。たとえば、そのライブラリが `foobar` パッケージで `some-fun` という関数を export しているなら、`(foobar:some-fun ...)` として呼び出せますし、次のようにもできます。

~~~lisp
(in-package :foobar)
(some-fun ...)
~~~

Quicklisp も使えます。

Quicklisp は内部で ASDF を呼び出します。依存関係がまだインストールされていなければ、それらをダウンロードしてインストールしてくれる利点があります。

~~~lisp
(ql:quickload "foobar")
;; =>
;; installs all dependencies
;; and loads the system.
~~~

また、Emacs コマンド `M-x slime-load-system`、またはプロンプトでの `, load-system` コマンドを使って、SLIME からシステムをロードすることもできます。この方法の面白い点は、SLIME が処理中のシステムの警告とエラーをすべて集め、ロード完了後に対話的に調べられる `*slime-compilation*` バッファに入れることです。

### システムをテストする

システムのテストを実行するには、次を使えます。

~~~lisp
(asdf:test-system :foobar)
~~~

慣習として、テストが成功しなかった場合はエラーを通知するべきです。

### システムを指定する

プログラム内でシステムを指定する適切な方法は、シンボルではなく小文字の文字列を使うことです。たとえば次のようにします。

~~~lisp
(asdf:load-system "foobar")
(asdf:test-system "foobar")
~~~

### 些細なシステム定義の書き方

些細なシステムは、プロジェクトのルートにある `foobar.lisp` という1つの Lisp ファイルだけを持つでしょう。そのファイルは、汎用ユーティリティの `alexandria` やパターンマッチングの `trivia` など、既存のライブラリに依存するとします。このシステムを ASDF でビルド可能にするため、次の内容を持つ `foobar.asd` というシステム定義ファイルを作ります。

~~~lisp
(asdf:defsystem "foobar"
  :depends-on ("alexandria" "trivia")
  :components ((:file "foobar")))
~~~


上のファイル名では、`foobar.lisp` の型 `lisp` が暗黙的であることに注意してください。そのファイルの内容は次のようになります。

~~~lisp
(defpackage :foobar
  (:use :common-lisp :alexandria :trivia)
  (:export
   #:some-function
   #:another-function
   #:call-with-foobar
   #:with-foobar))

(in-package :foobar)

(defun some-function (...)
    ...)
...
~~~

複数の完全なパッケージを `using` する代わりに、その一部だけを取り込みたい場合もあります。

~~~lisp
(defpackage :foobar
  (:use #:common-lisp)
  (:import-from #:alexandria
                #:some-function
                #:another-function))
  (:import-from #:trivia
                #:some-function
                #:another-function))
...)
~~~


#### 定義したシステムを使う

システムが `~/common-lisp/`、`~/quicklisp/local-projects/`、または ASDF 用にすでに設定された他のファイルシステム階層の下にインストールされていると仮定すると、`(asdf:load-system "foobar")` でロードできます。

そのファイルを作った時点で Lisp がすでに起動していた場合は、次のどちらかが必要になることがあります。

- 新しい .asd ファイルをロードする: `(asdf:load-asd "path/to/foobar.asd")`、または Slime で `C-c C-k` を使ってファイル全体をコンパイルしてロードします。
  - 注意: ASDF ファイルに組み込みの `load` を使うのは避けてください。動くかもしれませんが、`asdf:load-asd` が推奨されます。
- `(asdf:clear-configuration)` で設定を再処理します。


### 些細なテスト定義の書き方

どれほど些細なシステムであっても、いくらかのテストは必要です。いずれ変更されることになり、その変更が利用側のコードを壊さないことを確認したいからです。テストは期待される振る舞いを文書化するよい方法でもあります。

テストを書く最も簡単な方法は、`foobar-tests.lisp` というファイルを用意し、上の `foobar.asd` を次のように変更することです。

~~~lisp
(asdf:defsystem "foobar"
    :depends-on ("alexandria" "trivia")
    :components ((:file "foobar"))
    :in-order-to ((test-op (test-op "foobar/tests"))))

(asdf:defsystem "foobar/tests"
    :depends-on ("foobar" "fiveam")
    :components ((:file "foobar-tests"))
    :perform (test-op (o c) (symbol-call :fiveam '#:run! :foobar)))
~~~

最初のシステムの `:in-order-to` 節により、`(asdf:test-system :foobar)` を使えるようになり、それが `foobar/tests` へ連鎖します。2つ目のシステムの `:perform` 節がテストそのものを実行します。

テスト用システムでは、`fiveam` は人気のあるテストライブラリの名前であり、`perform` メソッドの内容は、このライブラリを呼び出してテストスイート `:foobar` を実行する方法です。別のライブラリを使う場合は、当然ながら事情は変わります。

## プロジェクトスケルトンを作成する

[cl-project](https://github.com/fukamachi/cl-project) を使うと、プロジェクトスケルトンを生成できます。デフォルトの ASDF 定義を作成し、ユニットテスト用のシステムを生成する、などを行います。

インストールします。

    (ql:quickload "cl-project")

プロジェクトを作成します。

~~~lisp
(cl-project:make-project #p"lib/cl-sample/"
:author "Eitaro Fukamachi"
:email "e.arrows@gmail.com"
:license "LLGPL"
:depends-on '(:clack :cl-annot))
;-> writing /Users/fukamachi/Programs/lib/cl-sample/.gitignore
;   writing /Users/fukamachi/Programs/lib/cl-sample/README.markdown
;   writing /Users/fukamachi/Programs/lib/cl-sample/cl-sample-test.asd
;   writing /Users/fukamachi/Programs/lib/cl-sample/cl-sample.asd
;   writing /Users/fukamachi/Programs/lib/cl-sample/src/hogehoge.lisp
;   writing /Users/fukamachi/Programs/lib/cl-sample/t/hogehoge.lisp
;=> T
~~~

これで完了です。
