---
title: OS との連携
---


ANSI Common Lisp 標準はこの話題に触れていません。（この標準が書かれたのは、[Lisp Machine](https://en.wikipedia.org/wiki/Lisp_machine) が最盛期だった時代だということを覚えておいてください。これらのマシンでは Lisp _そのもの_ がオペレーティングシステムでした！）そのため、ここで言えることのほとんどは OS と処理系に依存します。
ただし、広く使われているライブラリはいくつかあります。これらは Common Lisp 処理系に同梱されているか、[Quicklisp](https://www.quicklisp.org/beta/) から簡単に入手できます。例を挙げると次のとおりです。

* ASDF3。ほぼすべての Common Lisp 処理系に含まれており、
  [Utilities for Implementation- and OS- Portability (UIOP)](https://common-lisp.net/project/asdf/uiop.html) を含んでいます。
* [osicat](https://common-lisp.net/project/osicat/)
* [unix-opts](http://quickdocs.org/unix-opts/) または、より新しい [clingon](https://github.com/dnaeon/clingon)。Python の `argparse` に似たコマンドライン引数パーサーです。


<a name="env"></a>

## 環境変数へのアクセス

UIOP には、多くの CL 処理系で Unix/Linux の環境変数を参照できる関数があります。

~~~lisp
* (uiop:getenv "HOME")
  "/home/edi"
~~~

以下は実装例です。ここでは、特定の処理系でコードを実行するために /feature flags/ が使われていることが分かります。

~~~lisp
* (defun my-getenv (name &optional default)
    "Obtains the current value of the POSIX environment variable NAME."
    (declare (type (or string symbol) name))
    (let ((name (string name)))
      (or #+abcl (ext:getenv name)
         #+ccl (ccl:getenv name)
         #+clisp (ext:getenv name)
         #+cmu (unix:unix-getenv name) ; CMUCL 20b 以降
         #+ecl (si:getenv name)
         #+gcl (si:getenv name)
         #+mkcl (mkcl:getenv name)
         #+sbcl (sb-ext:posix-getenv name)
         default)))
MY-GETENV
* (my-getenv "HOME")
"/home/edi"
* (my-getenv "HOM")
NIL
* (my-getenv "HOM" "huh?")
"huh?"
~~~

これらの処理系の一部は、環境変数を _設定_ する機能も提供していることに注意してください。たとえば ECL（`si:setenv`）や AllegroCL、LispWorks、CLISP では、上で挙げた関数を [`setf`](http://www.lispworks.com/documentation/HyperSpec/Body/m_setf_.htm) と組み合わせて使えます。この機能は、Lisp 環境からサブプロセスを起動したい場合に重要になることがあります。

環境変数を設定するには、処理系に依存しない方法として `(uiop:getenv "lisp")` に対して `setf` を使えます。

また、
[Osicat](https://www.common-lisp.net/project/osicat/manual/osicat.html#Environment)
ライブラリには、Windows を含む POSIX 風システムで使える `(environment-variable "name")` メソッドがあります。これは `fset` 可能でもあります。

### ディレクトリを持つ環境変数（PATH）

ある関数を使うと、環境変数からディレクトリのリストを取得できます。

```lisp
(uiop:getenv-absolute-directories "PATH")
;; => (#P"/home/vince/.local/bin/" #P"/usr/local/bin/" #P"/usr/sbin/" #P"/usr/bin/")
```

そのドキュメントは次のとおりです。

> ユーザーが設定した環境変数から、ネイティブ OS に従って絶対ディレクトリのリストを取り出します。環境変数 X に空のエントリがある場合、それらは NIL として返されます。

環境変数が 1 つのディレクトリを含む場合は `uiop:getenv-absolute-directory` を使います。関連項目: `uiop:getenv-pathname[s]`。


<a name="accessing-command-line"></a>

## コマンドライン引数へのアクセス

### 基本

コマンドライン引数へのアクセスは処理系固有ですが、ほとんどの処理系にはそれらを取得する方法があるようです。`uiop:command-line-arguments` を使う UIOP、[Roswell](https://github.com/roswell/roswell/wiki)、および外部ライブラリ（次の節を参照）を使うと移植性を持たせられます。

[SBCL](http://www.sbcl.org) は引数リストを special 変数 `sb-ext:*posix-argv*` に格納します。

~~~lisp
$ sbcl my-command-line-arg
~~~

....

~~~lisp
* sb-ext:*posix-argv*

("sbcl" "my-command-line-arg")
*
~~~

これを使ってスタンドアロンの Lisp スクリプトを書く方法の詳細は、[SBCL Manual](http://www.sbcl.org/manual/index.html#Command_002dline-arguments) にあります。

[LispWorks](http://www.lispworks.com) には `system:*line-arguments-list*` があります。

~~~lisp
* system:*line-arguments-list*
("/Users/cbrown/Projects/lisptty/tty-lispworks" "-init" "/Users/cbrown/Desktop/lisp/lispworks-init.lisp")
~~~

複数の処理系で引数文字列のリストを返す簡単な関数は次のとおりです。

~~~lisp
(defun my-command-line ()
  (or
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*)
   #+CLISP *args*)
~~~

これで、移植可能な方法で引数にアクセスし、スキーマ定義に従って解析できると便利です。

### コマンドライン引数の解析

[Awesome CL list#scripting](https://github.com/CodyReichert/awesome-cl#scripting)
の節を見て、[clingon](https://github.com/dnaeon/clingon) の使い方を示します。

詳しくは [scripting recipe](https://lispcookbook.github.io/cl-cookbook/scripting.html#parsing-command-line-arguments) を参照してください。


## 外部プログラムの実行

**uiop** が対応してくれます。おそらく Common Lisp 処理系に含まれています。

### 同期的に

[`uiop:run-program`](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fRUN_002dPROGRAM) は、実行する executable の名前を表す文字列、またはプログラムとその引数を表す文字列のリストを引数に取ります。

~~~lisp
(uiop:run-program "ls | grep lisp" :output t)
~~~

または

~~~lisp
(uiop:run-program (list "ls" "-lh") :output t)
~~~

これは指定どおりにプログラム出力を処理し、プログラムと出力処理が完了したときに処理結果を返します。

コマンドを文字列として渡すと shell 内で実行され、リストとして渡すと shell を使いません。

標準出力に出力するために `:output t` を使っています。出力は文字列、ファイル、その他任意のストリームに取り込めますし、対話的な出力にもできます。後述します。

この関数には次の省略可能引数があります。

~~~lisp
run-program (command &rest keys &key
               ignore-error-status
               (force-shell nil force-shell-suppliedp)
               input
               (if-input-does-not-exist :error)
               output
               (if-output-exists :supersede)
               error-output
               (if-error-output-exists :supersede)
               (element-type *default-stream-element-type*)
               (external-format *utf-8-external-format*)
              allow-other-keys)
~~~

`force-shell` が指定されている場合、可能ならコマンドを直接実行するのではなく、常に shell を呼び出します。同様に、`force-shell` に `nil` が指定されている場合、shell は決して呼び出されません。

プロセスが成功しなかった場合（終了コードが 0 でない場合）、`ignore-error-status` が指定されていない限り、継続可能な `subprocess-error` を通知します。

`:output` 引数には次のものを指定できます。

- `output` が `nil`（デフォルトで、`null` device を指定）、pathname、または pathname を指定する文字列の場合、その path のファイルが出力として使われます。
- `t` の場合、出力は現在の `*standard-output*` ストリームに送られます。
- `:output :string`、または末尾の newline を取り除く `:output '(:string :stripped t)`。
- `:interactive` の場合、出力は現在のプロセスから継承されます。これは `*standard-output*` と異なる可能性があり、`slime` では `*inferior-lisp*` buffer 上になるので注意してください。
- それ以外の場合、`output` は `uiop:slurp-input-stream` の適切な第 1 引数、またはそのような値と keyword 引数のリストである必要があります。例として `:string` や `'(:string :stripped t)` があります。
この場合、`run-program` はプログラム出力用の一時ストリームを作成します。
そのストリーム内のプログラム出力は、`output` を第 1 引数（または `output` の先頭要素を第 1 引数、残りを keyword）として `slurp-input-stream` を呼び出すことで処理されます。
その呼び出しから得られる primary 値（呼び出しが不要だった場合は `nil`）が、`run-program` の第 1 戻り値になります。
たとえば、`:output :string` を使うと、出力ストリーム全体が文字列として返されます。

`if-output-exists` は、`output` が文字列または pathname の場合にのみ意味があり、`:error`、`:append`、`:supersede`（デフォルト）を取れます。これらの値の意味と、`output` が存在しない場合への影響は、`:direction` `:output` で `open` に渡す `if-exists` パラメータと同様です。

`error-output` は `output` と似ていますが、結果の値は `run-program` の第 2 戻り値として返されます。`t` は `*error-output*` を指定します。また `:output` はエラー output を output ストリームに redirect することを意味し、この場合は `nil` が返されます。

`if-error-output-exists` は `if-output-exist` と似ていますが、`output` ではなく `error-output` に影響します。

`input` は `output` と似ていますが、`vomit-output-stream` が使われ、値は返されず、`T` は `*standard-input*` を指定します。

`if-input-does-not-exist` は、`input` が文字列または pathname の場合にのみ意味があり、`:create` と `:error`（デフォルト）を取れます。これらの値の意味は、`:direction :input` で `open` に渡す `if-does-not-exist` パラメータと同様です。

`element-type` と `external-format` は、該当する場合、出力ストリームの作成のために Lisp 処理系へ渡されます。

ストリームの slurping または vomiting のうち 1 つだけが、option と処理系によってはサブプロセスと並行して行われる場合があります。その際は output processing が優先されます。
その他のストリームは、サブプロセスを spawn する前または後に、一時ファイルを使って完全に生成または消費されます。

`run-program` は 3 つの値を返します。

* `output` の slurping 結果があればそれ、なければ `nil`
* `error-output` の slurping 結果があればそれ、なければ `nil`
* サブプロセスが成功 status で終了した場合は 0、そうでなければプロセスの `exit-code` による失敗の情報


### 非同期的に

[`uiop:launch-program`](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fLAUNCH_002dPROGRAM) を使います。

その signature は次のとおりです。

~~~lisp
launch-program (command &rest keys &key
                    input
                    (if-input-does-not-exist :error)
                    output
                    (if-output-exists :supersede)
                    error-output
                    (if-error-output-exists :supersede)
                    (element-type *default-stream-element-type*)
                    (external-format *utf-8-external-format*)
                    directory
                    #+allegro separate-streams
                    &allow-other-keys)
~~~

起動したプログラムからの output（stdout）は、`output` keyword で設定します。

 - `output` が pathname、pathname を指定する文字列、または `nil`（デフォルトで null device を指定）の場合、その path のファイルが出力として使われます。
 - `:interactive` の場合、出力は現在のプロセスから継承されます。これは `*standard-output*` と異なる可能性があり、Slime では `*inferior-lisp*` buffer 上になるので注意してください。
 - `T` の場合、出力は現在の `*standard-output*` ストリームに送られます。
 - `:stream` の場合、新しいストリームが利用可能になり、`process-info-output` 経由でアクセスして読み取れます。
 - それ以外の場合、`output` は underlying lisp 処理系が扱える値である必要があります。

`if-output-exists` は、`output` が文字列または pathname の場合にのみ意味があり、`:error`、`:append`、`:supersede`（デフォルト）を取れます。これらの値の意味と、`output` が存在しない場合への影響は、`:DIRECTION :output` で `open` に渡す `if-exists` パラメータと同様です。

`error-output` は `output` と似ています。`T` は `*error-output*` を指定し、`:output` はエラー output を output ストリームに redirect することを意味し、`:stream` は `process-info-error-output` 経由でストリームを利用可能にします。

`launch-program` は、次のような `process-info` オブジェクトを返します（[source](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/launch-program.lisp#L205)）。


~~~lisp
(defclass process-info ()
    (
     ;; PID の代わりに stream を扱う利点は、
     ;; `sys:pipe-kill-process` のような関数が使えることです。
     (process :initform nil)
     (input-stream :initform nil)
     (output-stream :initform nil)
     (bidir-stream :initform nil)
     (error-output-stream :initform nil)
     ;; 後方互換性のため、(zerop exit-code) <-> success という性質を
     ;; 保つ目的で、signal に応答した exit は 128+signum として
     ;; encode されます。
     (exit-code :initform nil)
     ;; platform が許す場合、code >128 での exit と signal に応答した
     ;; exit を区別するために、この code を設定します。
     (signal-code :initform nil)))
~~~

[docstrings](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/launch-program.lisp#L508) を参照してください。

#### サブプロセスが生きているかをテストする

`uiop:process-alive-p` は、`launch-program` が返した `process-info` オブジェクトを与えると、そのプロセスがまだ生きているかをテストします。

~~~lisp
* (defparameter *shell* (uiop:launch-program "bash"
                            :input :stream :output :stream))

;; 下位 shell process が実行中
* (uiop:process-alive-p *shell*)
T

;; input stream と output stream を閉じる
* (uiop:close-streams *shell*)
* (uiop:process-alive-p *shell*)
NIL
~~~

#### exit code を取得する

`uiop:wait-process` を使えます。プロセスが終了していれば即座に戻り、exit code を返します。終了していなければ、プロセスが終了するまで待ちます。

~~~lisp
(uiop:process-alive-p *process*)
NIL
(uiop:wait-process *process*)
0
~~~

exit code が 0 なら成功です（`zerop` を使います）。

exit code は `process-info` オブジェクトの `exit-code` スロットにも格納されます。上のクラス定義から分かるように accessor はないので、`slot-value` を使います。`nil` への `initform` があるため、スロットが bound かどうかを確認する必要はありません。次のようにできます。

~~~lisp
(slot-value *my-process* 'uiop/launch-program::exit-code)
0
~~~

こつは、事前に必ず `wait-process` を実行しなければならないことです。そうしないと結果は `nil` になります。

`wait-process` は blocking なので、新しいスレッドで実行できます。

~~~lisp
(bt:make-thread
  (lambda ()
    (let ((exit-code (uiop:wait-process
                       (uiop:launch-program (list "of" "commands"))))
      (if (zerop exit-code)
          (print :success)
          (print :failure)))))
  :name "Waiting for <program>")
~~~


`run-program` は exit code を第 3 戻り値として返すことにも注意してください。


### サブプロセスからの input と output

`input` keyword が `:stream` に設定されている場合、ストリームが作成され、ファイルと同じように書き込めます。このストリームには `uiop:process-info-input` を使ってアクセスできます。

~~~lisp
;; input stream と output stream を持つ下位 shell を起動する
* (defparameter *shell* (uiop:launch-program "bash"
                           :input :stream :output :stream))
;; shell に 1 行を書き込む
* (write-line "find . -name '*.md'"
     (uiop:process-info-input *shell*))
;; stream を flush する
* (force-output (uiop:process-info-input *shell*))
~~~

ここで [write-line](http://clhs.lisp.se/Body/f_wr_stg.htm) は、与えられたストリームに文字列を書き込み、末尾に newline を追加します。
[force-output](http://clhs.lisp.se/Body/f_finish.htm) の呼び出しはストリームの flush を試みますが、完了を待ちません。

出力ストリームからの読み取りも同様で、`uiop:process-info-output` は output ストリームを返します。

~~~lisp
* (read-line (uiop:process-info-output *shell*))
~~~

場合によっては、読み取るデータ量が分かっていたり、読み取りを止める delimiter があったりします。そうでない場合、[read-line](http://clhs.lisp.se/Body/f_rd_lin.htm) の呼び出しはデータを待って hang する可能性があります。これを避けるために、文字が利用可能かをテストする [listen](http://clhs.lisp.se/Body/f_listen.htm) を使えます。

~~~lisp
* (let ((stream (uiop:process-info-output *shell*)))
     (loop while (listen stream) do
         ;; 文字はすぐ利用可能
         (princ (read-line stream))
         (terpri)))
~~~

1 文字を読み取るか、利用可能な文字がない場合に `nil` を返す [read-char-no-hang](http://clhs.lisp.se/Body/f_rd_c_1.htm) もあります。
buffering のような問題や、相手プロセスがいつ実行されるかのタイミングにより、送信されたすべてのデータが `listen` や `read-char-no-hang` が `nil` を返す前に受信される保証はないことに注意してください。

<a id="standard-output--error-output-"></a>

### standard output とエラー output の捕捉

standard output の捕捉は上で見たように、`:output` に `:string` を指定するか、末尾の newline を取り除くために `:output '(:string :stripped t)` を使うだけで簡単にできます。

`:error-output` にも同じことを指定できます。さらに `:ignore-error-status t` を使うと、`uiop:run-program` にエラーを通知させず、対話型デバッガに入らないようにできます。

その場合、返された `exit-code` でプログラムの成功または失敗を確認できます。0 は成功です。

すべてをまとめると次のようになります。

~~~lisp
(uiop:run-program (list "git"
                        "checkout"
                        "me/does-not-exist")
                  :output :string
                  :error-output :string
                  :ignore-error-status t)
;; =>
""
"error: pathspec 'me/does-not-exist did not match any file(s) known to git
"
1
~~~

`uiop:run-program` は 3 つの値を返します。

- standard output（ここでは空文字列）
- エラー output（ここではエラーメッセージを含む文字列）
- exit code

これらは `multiple-value-bind` で bind できます。

~~~lisp
(multiple-value-bind (output error-output exit-code)
    (uiop:run-program (list …))
  (unless (zerop exit-code)
    (format t "error output is: ~a" error-output)))
~~~

### 対話的・視覚的なコマンドの実行（htop）

`uiop:run-program` を使い、`:input` と `:output` の両方を `:interactive` に設定します。

~~~lisp
(uiop:run-program "htop"
                  :output :interactive
                  :input :interactive)
~~~

これにより、`htop` は本来そうあるべきように全画面で spawn されます。

これは他のコマンド（`sudo`、`vim`、`less`…）でも動作します。

## パイプ

`ls | sort` と同等のことを行う例です。"ls" は `launch-program`（async）を使い、ストリームに出力します。一方、pipe の最後のコマンドである "sort" は `run-program` を使い、文字列に出力することに注意してください。

~~~lisp
(uiop:run-program "sort"
                   :input
                   (uiop:process-info-output
                    (uiop:launch-program "ls"
                                         :output :stream))
                   :output :string)
~~~


<a id="lisp--process-idpid"></a>

## Lisp の現在のプロセス ID（PID）を取得する

処理系はそれぞれ独自の関数を提供しています。

SBCL では次のとおりです。

~~~lisp
(sb-posix:getpid)
~~~

osicat ライブラリを使うと移植可能にできます。

~~~lisp
(osicat-posix:getpid)
~~~

ここでも、`apropos` 関数を使って探せます。

~~~lisp
CL-USER> (apropos "pid")
OSICAT-POSIX:GETPID (fbound)
OSICAT-POSIX::PID
[…]
SB-IMPL::PID
SB-IMPL::WAITPID (fbound)
SB-POSIX:GETPID (fbound)
SB-POSIX:GETPPID (fbound)
SB-POSIX:LOG-PID (bound)
SB-POSIX::PID
SB-POSIX::PID-T
SB-POSIX:WAITPID (fbound)
[…]
~~~
