---
title: Alive で VSCode を使う
---

[Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive)
extension は [VSCode](https://code.visualstudio.com) を強力な
Common Lisp development platform にします。
target platform 上で動作する Common Lisp の version 以外に dependency はありません。現在は次を support しています。

- Syntax highlighting
- Code completion
- Code formatter
- Jump to definition
- Snippets
- REPL integration
- Interactive Debugger
- REPL history
- Inline evaluation
- Macro expand
- Disassemble
- Inspector
- Hover Text
- Rename function args and let bindings
- Code folding

![](assets/commonlisp-vscode-alive.png)

### Prerequisites

VSCode の Alive extension は ANSI Common Lisp と互換性があり、Alive REPL が正常に起動する限り、これらの手順はどの実装でも動くはずです。例ではすべて SBCL を使います。

- [VsCode](https://code.visualstudio.com)。[command
  line](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
  が install されており、
  [Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive)
  extension が動作しているもの。
- [SBCL](http://www.sbcl.org)

#### VSCode を REPL に接続する

![](assets/vscode-gifs/attach-repl.gif)

1. VSCode 内で、編集したい lisp file を開きます。
   - まだない場合は、`hello.lisp` という新しい file を作成します。
2. VSCode 内で、上部 menu の `View/Command Palette` から Command Palette を開き、
   `Alive: Start REPL And Attach` を選んで、VSCode REPL に attach された Swank サーバーを動かす SBCL instance を起動します。
   - `REPL Connected` と書かれた小さなウィンドウが pop up します。
   - `REPL Connected` メッセージが出ない場合は、上部 menu の `View:Output` から VSCode の
     Output を開き、pulldown で `Swank Trace` を選びます。この output は実行中の lisp image からの output で、何がうまくいっていないのかを調べる出発点になります。

これで、稼働中の SBCL image の port 4005 で動く Swank サーバーに attach された REPL を持つ VSCode instance ができました。file 内の statement を evaluate でき、それらは実行中の SBCL instance で処理されます。

_REPL を disconnect し、SBCL instance を shut down するには、上部 menu の `View/Command
Palette` から Command Palette を開き、`Alive: Detach from REPL` を選びます。_

すべての操作には keybinding があります。必要に応じて explore し、変更してください。

### Recipes

_特に明記しない限り、すべての recipe は、VSCode で file を開き、REPL が attach されている状態を前提とします。_

_expression を evaluate するときは、evaluate したい s-expression の中、または直後のどこかに cursor を置いて、evaluate する式を選びます。_

#### statement を in-line で evaluate する

![](assets/vscode-gifs/in-line-eval.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選びます。
3. `=> 4 (3 bits, #x4, #o4,
   #b100)` と書かれた小さな pop up が表示されます。これが result です。

   _statement を in-line で evaluate することは、それを REPL に送ることとまったく同じです。違いは表示方法だけです。_

#### statement を evaluate する

![](assets/vscode-gifs/eval.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Send To REPL` を選びます。
3. 式が REPL に表示され、result も一緒に表示されます。

~~~lisp
CL-USER>
(+ 2 2)
4
CL-USER>
~~~

#### file を compile する

![](assets/vscode-gifs/compile.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Compile` を選びます。
3. repl に compile の詳細が表示され、filesystem に fasl file ができます。

~~~
CL-USER>

; compiling file "/Users/jason/Desktop/hello.lisp" (written 14 SEP 2021 04:24:37 AM):


; wrote /Users/jason/Desktop/hello.fasl

; compilation finished in 0:00:00.001
~~~

#### Interactive Debugger を使って abort する

![](assets/vscode-gifs/debug-abort.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(defun divide (x y)
  (/ x y))
~~~

2. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、`define`
   関数を image に load します。
3. 開いている file に新しい行を追加し、次を入力します。

~~~lisp
(divide 1 0)
~~~

4. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、divide function を image 内で実行します。
5. Interactive Debugger が pop up します。`Restarts`
   section で、option 2 を選んで Abort します。
6. editor とまだ動いている REPL に戻り、何も起きなかったかのように続けられます。

#### Interactive Debugger を使って runtime に問題を修正する

![](assets/vscode-gifs/debug-fix.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y))
          (y)
          "The second argument can not be zero.")
  (/ x y))
~~~

2. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、`define`
   関数を image に load します。
3. 開いている file に新しい行を追加し、次を入力します。

~~~lisp
(divide 1 0)
~~~

4. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、divide function を image 内で実行します。
5. Interactive Debugger が pop up します。`Restarts`
   section で、option 0 の "Retry assertion with new 値 for Y" を選びます。
6. popup menu に `y'` と入力します。
7. 次の popup menu に `1` と入力します。
8. `=> 1 (1 bit, #x1, #o1,
   #b1)` と書かれた小さな pop up が表示されるはずです。これは新しい value の result です。debugger へ crash した後、crash の原因になった value を変更させてもらい、悪い `0` value を入力しなかったかのように proceeding した状態で、editor とまだ動いている REPL に戻っています。

_debugger でできることのさらなる idea は [エラー handling](error_handling.md) page にあります。_

<a id="macro--expand-"></a>

#### マクロを expand する

![](assets/vscode-gifs/macro-expand.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(loop for x in '(a b c d e) do
     (print x))
~~~

2. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: マクロ Expand` を選んで for-loop macro を expand します。
3. 次のようなものが見えるはずです。

~~~lisp
(BLOCK NIL
  (LET ((X NIL)
        (#:LOOP-LIST-559
         (SB-KERNEL:THE* (LIST :USE-ANNOTATIONS T
                               :SOURCE-FORM '(A B C D E))
                         '(A B C D E))))
    (DECLARE (IGNORABLE #:LOOP-LIST-559)
             (IGNORABLE X))
    (TAGBODY
     SB-LOOP::NEXT-LOOP
      (SETQ X (CAR #:LOOP-LIST-559))
      (SETQ #:LOOP-LIST-559 (CDR #:LOOP-LIST-559))
      (PRINT X)
      (IF (ENDP #:LOOP-LIST-559)
          (GO SB-LOOP::END-LOOP))
      (GO SB-LOOP::NEXT-LOOP)
     SB-LOOP::END-LOOP)))
~~~

<a id="function--disassemble-"></a>

#### 関数を disassemble する

![](assets/vscode-gifs/disassemble.gif)

1. editor ウィンドウの開いている file に、次を入力します。

~~~lisp
(defun hello (name)
  (format t "Hello, ~A~%" name))
~~~

2. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで function を image に load します。
2. まだそうなっていなければ、最後の parenthesis の後に cursor を置きます。上部 menu の `View/Command
   Palette` から Command Palette を開き、`Alive: Disassemble` を選んで compiled function の machine code を print します。
3. 次のように始まります。

~~~
; disassembly for HELLO
; Size: 172 bytes. Origin: #x70052478B4                       ; HELLO
; 8B4:       AC0A40F9         LDR R2, [THREAD, #16]           ; binding-stack-pointer
; 8B8:       4C0F00F9         STR R2, [CFP, #24]
; 8BC:       AC4642F9         LDR R2, [THREAD, #1160]         ; tls: *STANDARD-OUTPUT*
; 8C0:       9F8501F1         CMP R2, #97
; 8C4:       61000054         BNE L0
; 8C8:       4AFDFF58         LDR R0, #x7005247870            ; '*STANDARD-OUTPUT*
; 8CC:       4C1140F8         LDR R2, [R0, #1]
; 8D0: L0:   4C1700F9         STR R2, [CFP, #40]
; 8D4:       E0031BAA         MOV NL0, CSP
; 8D8:       7A0701F8         STR CFP, [CSP], #16
; 8DC:       EAFCFF58         LDR R0, #x7005247878            ; "Hello, "
; 8E0:       4B1740F9         LDR R1, [CFP, #40]
; 8E4:       B6FBFF58         LDR LEXENV, #x7005247858        ; #<SB-KERNEL:FDEFN WRITE-STRING>
; 8E8:       970080D2         MOVZ NARGS, #4
; 8EC:       FA0300AA         MOV CFP, NL0
; 8F0:       DE9240F8         LDR LR, [LEXENV, #9]
; 8F4:       C0033FD6         BLR LR
; 8F8:       3B039B9A         CSEL CSP, OCFP, CSP, EQ
; 8FC:       E0031BAA         MOV NL0, CSP
; 900:       7A0701F8         STR CFP, [CSP], #16
; 904:       4A2F42A9         LDP R0, R1, [CFP, #32]
; 908:       D6FAFF58         LDR LEXENV, #x7005247860        ; #<SB-KERNEL:FDEFN PRINC>
; 90C:       970080D2         MOVZ NARGS, #4
; 910:       FA0300AA         MOV CFP, NL0
; 914:       DE9240F8         LDR LR, [LEXENV, #9]
; 918:       C0033FD6         BLR LR
; 91C:       3B039B9A         CSEL CSP, OCFP, CSP, EQ
; 920:       E0031BAA         MOV NL0, CSP
; 924:       7A0701F8         STR CFP, [CSP], #16
; 928:       2A4981D2         MOVZ R0, #2633
; 92C:       4B1740F9         LDR R1, [CFP, #40]
; 930:       D6F9FF58         LDR LEXENV, #x7005247868        ; #<SB-KERNEL:FDEFN WRITE-CHAR>
; 934:       970080D2         MOVZ NARGS, #4
; 938:       FA0300AA         MOV CFP, NL0
; 93C:       DE9240F8         LDR LR, [LEXENV, #9]
; 940:       C0033FD6         BLR LR
; 944:       3B039B9A         CSEL CSP, OCFP, CSP, EQ
; 948:       EA031DAA         MOV R0, NULL
; 94C:       FB031AAA         MOV CSP, CFP
; 950:       5A7B40A9         LDP CFP, LR, [CFP]
; 954:       BF0300F1         CMP NULL, #0
; 958:       C0035FD6         RET
; 95C:       E00120D4         BRK #15                         ; Invalid argument count trap
~~~

#### Common Lisp system の skeleton を作成する

![](assets/vscode-gifs/skeleton.gif)

_この recipe は新しい Common Lisp System を作成するため、running REPL は不要です。_

1. 新しい project 用に `experiment` という folder を作成します。
2. newly created directory で vscode を開きます。

```bash
cd experiment
code .
```

3. 新しい Common Lisp System を作成します。
  - VSCode 内で、上部 menu の
      `View/Command Palette` から Command Palette を開き、system skeleton を生成します: `Alive: System Skeleton`
  - 前の command は、次の directory
      structure を生成しているはずです。
      - experiment.asd
      - src/
        - app.lisp
      - test/
        - all.lisp

それらの file の内容は次のとおりです。

`experiment.asd`:

~~~lisp
(in-package :asdf-user)

(defsystem "experiment"
  :class :package-inferred-system
  :depends-on ("experiment/src/app")
  :description ""
  :in-order-to ((test-op (load-op "experiment/test/all")))
  :perform (test-op (o c) (symbol-call :test/all :test-suite)))

(defsystem "experiment/test"
  :depends-on ("experiment/test/all"))

(register-system-packages "experiment/src/app" '(:app))
(register-system-packages "experiment/test/all" '(:test/all))
~~~

`src/app.lisp`:

~~~lisp
(defpackage :app
  (:use :cl))

(in-package :app)
~~~

`test/all.lisp`:

~~~lisp
(defpackage :test/all
  (:use :cl
        :app)
  (:export :test-suite))

(in-package :test/all)

(defun test-suite ()
  (format T "Test Suite~%"))
~~~

### Optional Custom Configurations

#### Quicklisp と連携するよう VSCode Alive を configure する

quicklisp が install 済みで、init 時に load されるよう configure されていると仮定すると、quicklisp はそのまま動きます。

#### default context の CLPM と連携するよう VSCode Alive を configure する

[CLPM](https://clpm.dev) が install 済みで configure 済みであると仮定し、[vscode settings を変更](https://code.visualstudio.com/docs/getstarted/settings) して次のようにします。

1. VSCode settings に次を追加します。

```json
  "alive.swank.startupCommand":[
    "clpm",
    "exec",
    "--",
    "sbcl",
    "--eval",
    "(asdf:load-system :swank)",
    "--eval",
    "(swank:create-server)"
  ],
```

_これは default clpm context で sbcl を起動します。_

#### bundle clpmfile を使う CLPM と連携するよう VSCode Alive を configure する

[CLPM](https://clpm.dev) が install 済みで configure 済みであり、
home directory の root に swank を dev dependency として含む bundle が configure されていると仮定し、[vscode
settings](https://code.visualstudio.com/docs/getstarted/settings) を変更して次のようにします。

1. VSCode settings に次を追加します。

```json
  "alive.swank.startupCommand":[
    "clpm",
    "bundle",
    "exec",
    "--",
    "sbcl",
    "--eval",
    "(asdf:load-system :swank)",
    "--eval",
    "(swank:create-server)"
  ],
```

_これは bundle の clpm context で sbcl を起動します。_

#### Roswell と連携するよう VSCode Alive を configure する

[Roswell](https://roswell.github.io/) が install 済みであると仮定し、
[vscode settings](https://code.visualstudio.com/docs/getstarted/settings) を変更して次のようにします。

```json
  "alive.swank.startupCommand": [
    "ros",
    "run",
    "--eval",
    "(require :asdf)",
    "--eval",
    "(asdf:load-system :swank)",
    "--eval",
    "(swank:create-server)"
  ]
```

#### VSCode Alive を Docker container に接続する

![](assets/vscode-gifs/docker-connect.gif)

_これらの手順は、remote connection、wsl connection、github Codespaces でも、それぞれ `Remote - SSH`、`Remote -
WSL`、`Github Codespaces` extension を使って動きます。extension が install されていることを前提とします。この例では、[Containers extension が install 済みで configure 済み](https://code.visualstudio.com/docs/remote/containers) であることを確認してください。_

1. sbcl が install された docker image を pull します。この例では latest の clfoundations sbcl を使います。

```sh
docker pull clfoundation/sbcl
```

2. docker image 内で bash を run し、起動して動かし続けます。

```sh
docker run -it clfoundation/sbcl bash
```

3. VSCode Side Bar で `Remote Explorer` icon を click します。
4. Dev Containers の list で clfoundation/sbcl を右 click し、`Attach to Container` を選びます。
5. 開いた新しい VSCode ウィンドウの VSCode Side Bar で、`Explorer` を click します。_file がまだ表示されていない場合は、container 内の file を表示するよう伝える必要があるかもしれません。_
6. container 内の file を表示できたら、VSCode `Side Bar` 内で右 click し、`New File` を選びます。file 名を `hello.lisp` にします。
7. VSCode Site Bar で `Extensions` icon を click します。
8. `Alive` plugin の `Install in Container...` ボタンを click します。
9. `hello.lisp` file を開き、この recipe の冒頭にある "Connect VSCode to a
   REPL" の手順に従います。
10. これで、docker container 内の SBCL image で動く Slime サーバーに接続された REPL を持つ VSCode が
    動いています。
