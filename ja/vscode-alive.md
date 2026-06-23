---
title: Alive で VSCode を使う
---

[Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive)
拡張機能は [VSCode](https://code.visualstudio.com) を強力な
Common Lisp の開発プラットフォームにします。
対象プラットフォーム上で動作する Common Lisp の処理系以外に依存はありません。現在は次に対応しています。

- シンタックスハイライト
- コード補完
- コードフォーマッタ
- 定義へのジャンプ
- スニペット
- REPL 統合
- 対話的デバッガ
- REPL の履歴
- インライン評価
- マクロ展開
- 逆アセンブル
- インスペクタ
- ホバーテキスト
- 関数の引数や let の束縛のリネーム
- コードの折りたたみ

![](assets/commonlisp-vscode-alive.png)

### 前提条件

VSCode の Alive 拡張機能は ANSI Common Lisp と互換性があり、Alive REPL が正常に起動する限り、これらの手順はどの処理系でも動くはずです。例ではすべて SBCL を使います。

- [VsCode](https://code.visualstudio.com)。[コマンドライン](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
  がインストールされており、
  [Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive)
  拡張機能が動作しているもの。
- [SBCL](http://www.sbcl.org)

#### VSCode を REPL に接続する

![](assets/vscode-gifs/attach-repl.gif)

1. VSCode 内で、編集したい lisp ファイルを開きます。
   - まだない場合は、`hello.lisp` という新しいファイルを作成します。
2. VSCode 内で、上部メニューの `View/Command Palette` から Command Palette を開き、
   `Alive: Start REPL And Attach` を選んで、VSCode の REPL に接続された Swank サーバーを動かす SBCL インスタンスを起動します。
   - `REPL Connected` と書かれた小さなウィンドウがポップアップします。
   - `REPL Connected` メッセージが出ない場合は、上部メニューの `View:Output` から VSCode の
     Output を開き、プルダウンで `Swank Trace` を選びます。この出力は実行中の lisp イメージからの出力で、何がうまくいっていないのかを調べる出発点になります。

これで、稼働中の SBCL イメージのポート 4005 で動く Swank サーバーに接続された REPL を持つ VSCode インスタンスができました。ファイル内の文を評価でき、それらは実行中の SBCL インスタンスで処理されます。

_REPL を切断し、SBCL インスタンスを終了するには、上部メニューの `View/Command
Palette` から Command Palette を開き、`Alive: Detach from REPL` を選びます。_

すべての操作にはキーバインドがあります。必要に応じて調べ、変更してください。

### レシピ

_特に明記しない限り、すべてのレシピは、VSCode でファイルを開き、REPL が接続されている状態を前提とします。_

_式を評価するときは、評価したい S 式の中、または直後のどこかにカーソルを置いて、評価する式を選びます。_

#### 文をインラインで評価する

![](assets/vscode-gifs/in-line-eval.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選びます。
3. `=> 4 (3 bits, #x4, #o4,
   #b100)` と書かれた小さなポップアップが表示されます。これが結果です。

   _文をインラインで評価することは、それを REPL に送ることとまったく同じです。違いは表示方法だけです。_

#### 文を評価する

![](assets/vscode-gifs/eval.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Send To REPL` を選びます。
3. 式が REPL に表示され、結果も一緒に表示されます。

~~~lisp
CL-USER>
(+ 2 2)
4
CL-USER>
~~~

#### ファイルをコンパイルする

![](assets/vscode-gifs/compile.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Compile` を選びます。
3. REPL にコンパイルの詳細が表示され、ファイルシステムに fasl ファイルができます。

~~~
CL-USER>

; compiling file "/Users/jason/Desktop/hello.lisp" (written 14 SEP 2021 04:24:37 AM):


; wrote /Users/jason/Desktop/hello.fasl

; compilation finished in 0:00:00.001
~~~

#### 対話的デバッガを使って中断する

![](assets/vscode-gifs/debug-abort.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(defun divide (x y)
  (/ x y))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、`define`
   した関数を image にロードします。
3. 開いているファイルに新しい行を追加し、次を入力します。

~~~lisp
(divide 1 0)
~~~

4. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、divide 関数を image 内で実行します。
5. 対話的デバッガがポップアップします。`Restarts`
   の節で、選択肢 2 を選んで中断します。
6. エディタとまだ動いている REPL に戻り、何も起きなかったかのように続けられます。

#### 対話的デバッガを使って実行時に問題を修正する

![](assets/vscode-gifs/debug-fix.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y))
          (y)
          "The second argument can not be zero.")
  (/ x y))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、`define`
   した関数を image にロードします。
3. 開いているファイルに新しい行を追加し、次を入力します。

~~~lisp
(divide 1 0)
~~~

4. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、divide 関数を image 内で実行します。
5. 対話的デバッガがポップアップします。`Restarts`
   の節で、選択肢 0 の "Retry assertion with new value for Y" を選びます。
6. ポップアップメニューに `y'` と入力します。
7. 次のポップアップメニューに `1` と入力します。
8. `=> 1 (1 bit, #x1, #o1,
   #b1)` と書かれた小さなポップアップが表示されるはずです。これは新しい値の結果です。デバッガへクラッシュした後、クラッシュの原因になった値を変更させてもらい、誤った `0` という値を入力しなかったかのように処理を進めた状態で、エディタとまだ動いている REPL に戻っています。

_デバッガでできることのさらなるアイデアは[エラー処理](error_handling.md)のページにあります。_

<a id="macro--expand-"></a>

#### マクロを展開する

![](assets/vscode-gifs/macro-expand.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(loop for x in '(a b c d e) do
     (print x))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Macro Expand` を選んで for-loop マクロを展開します。
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

#### 関数を逆アセンブルする

![](assets/vscode-gifs/disassemble.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(defun hello (name)
  (format t "Hello, ~A~%" name))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで関数を image にロードします。
2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Disassemble` を選んでコンパイル済み関数の機械語を出力します。
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

#### Common Lisp システムのひな形を作成する

![](assets/vscode-gifs/skeleton.gif)

_このレシピは新しい Common Lisp システムを作成するため、稼働中の REPL は不要です。_

1. 新しいプロジェクト用に `experiment` というフォルダを作成します。
2. 新しく作成したディレクトリで vscode を開きます。

```bash
cd experiment
code .
```

3. 新しい Common Lisp システムを作成します。
  - VSCode 内で、上部メニューの
      `View/Command Palette` から Command Palette を開き、システムのひな形を生成します: `Alive: System Skeleton`
  - 前のコマンドは、次のディレクトリ構成を生成しているはずです。
      - experiment.asd
      - src/
        - app.lisp
      - test/
        - all.lisp

それらのファイルの内容は次のとおりです。

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

### 任意のカスタム設定

#### Quicklisp と連携するよう VSCode Alive を設定する

quicklisp がインストール済みで、初期化時にロードされるよう設定されていると仮定すると、quicklisp はそのまま動きます。

#### 既定のコンテキストの CLPM と連携するよう VSCode Alive を設定する

[CLPM](https://clpm.dev) がインストール済みかつ設定済みであると仮定し、[vscode の設定を変更](https://code.visualstudio.com/docs/getstarted/settings)して次のようにします。

1. VSCode の設定に次を追加します。

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

_これは既定の clpm コンテキストで sbcl を起動します。_

#### bundle の clpmfile を使う CLPM と連携するよう VSCode Alive を設定する

[CLPM](https://clpm.dev) がインストール済みかつ設定済みであり、
ホームディレクトリのルートに swank を開発用の依存として含む bundle が設定されていると仮定し、[vscode
の設定](https://code.visualstudio.com/docs/getstarted/settings)を変更して次のようにします。

1. VSCode の設定に次を追加します。

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

_これは bundle の clpm コンテキストで sbcl を起動します。_

#### Roswell と連携するよう VSCode Alive を設定する

[Roswell](https://roswell.github.io/) がインストール済みであると仮定し、
[vscode の設定](https://code.visualstudio.com/docs/getstarted/settings)を変更して次のようにします。

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

#### VSCode Alive を Docker コンテナに接続する

![](assets/vscode-gifs/docker-connect.gif)

_これらの手順は、リモート接続、wsl 接続、github Codespaces でも、それぞれ `Remote - SSH`、`Remote -
WSL`、`Github Codespaces` の拡張機能を使って動きます。拡張機能がインストールされていることを前提とします。この例では、[Containers 拡張機能がインストール済みかつ設定済み](https://code.visualstudio.com/docs/remote/containers)であることを確認してください。_

1. sbcl がインストールされた docker イメージを pull します。この例では最新の clfoundations sbcl を使います。

```sh
docker pull clfoundation/sbcl
```

2. docker イメージ内で bash を実行し、起動して動かし続けます。

```sh
docker run -it clfoundation/sbcl bash
```

3. VSCode の Side Bar で `Remote Explorer` のアイコンをクリックします。
4. Dev Containers の一覧で clfoundation/sbcl を右クリックし、`Attach to Container` を選びます。
5. 開いた新しい VSCode ウィンドウの Side Bar で、`Explorer` をクリックします。_ファイルがまだ表示されていない場合は、コンテナ内のファイルを表示するよう指定する必要があるかもしれません。_
6. コンテナ内のファイルを表示できたら、VSCode の `Side Bar` 内で右クリックし、`New File` を選びます。ファイル名を `hello.lisp` にします。
7. VSCode の Side Bar で `Extensions` のアイコンをクリックします。
8. `Alive` プラグインの `Install in Container...` ボタンをクリックします。
9. `hello.lisp` ファイルを開き、このレシピの冒頭にある "Connect VSCode to a
   REPL" の手順に従います。
10. これで、docker コンテナ内の SBCL イメージで動く Slime サーバーに接続された REPL を持つ VSCode が
    動いています。
