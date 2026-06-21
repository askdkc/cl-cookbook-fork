---
title: スクリプト、コマンドライン引数、実行ファイル
---

REPL からプログラムを使うのは問題ありませんが、できあがったらターミナルから呼び出したくなります。そういうときは Lisp の **スクリプト** を使えます。

さらに、プログラムを手軽に配布したいなら、**実行ファイル** を作りたくなります。

Lisp 実装ごとに作り方は少し違いますが、どれも対象アーキテクチャ向けの **自己完結型実行ファイル** を作れます。利用者は Lisp 実装をインストールする必要がなく、すぐにソフトウェアを実行できます。

**起動時間** はほぼゼロに近く、特に SBCL と CCL では顕著です。

少なくともオープンソース実装では、バイナリの **サイズ** はやや大きめです。Lisp 本体だけでなく、ライブラリ、すべてのシンボル名、関数の引数リスト情報、コンパイラ、デバッガ、ソースコードの位置情報なども含まれます。ただし、コンパイラとデバッガが入っているおかげで、プログラム実行中に Lisp コードをコンパイルして読み込めます。さらに、有償版の LispWorks には tree shaker があり、3〜5MB 程度のバイナリを作れます。こちらにはコンパイラが入っていないので、実行中の更新はできません。

同様に、HTML や JS などの静的アセットをすべて含む **Web アプリ** 向けの自己完結型実行ファイルも作れます。

## Common Lisp でスクリプトを書く

`hello` という名前のファイルを作り（`.lisp` 拡張子は外してもかまいません）、次を入れます。

```
#!/usr/bin/env -S sbcl --script
(require :uiop)
(format t "hello ~a!~&" (uiop:getenv "USER"))
```

スクリプトに実行権を付けて（`chmod +x hello`）、実行します。

```
$ ./hello
hello me!
```

いい感じです。これだけでもかなり使えます。

しかも、私の環境ではこのスクリプトの起動はかなり速く、0.03 秒でした。

ただし、依存関係を追加すると起動時間は長くなります。素直な解はバイナリを作ることです。依存関係をすべてコンパイル済みで、さらに速く起動します。別の方法として、自分用の *core image* を作る手もあります。

ここでは SBCL の CLI オプション `--script` を使いました。これは `--no-sysinit --no-userinit --disable-debugger --end-toplevel-options` と同等です。

- `--no-sysinit` はシステム全体の初期化ファイルを読み込みません。
- `--no-userinit` はユーザーの `~/.sbclrc` を読み込みません。
- `--disable-debugger` はデバッガを無効にします。エラー時には Lisp プロセスがバックトレースを表示して終了コード 1 で終了します。Lisp REPL は入りません。
- `--end-toplevel-options` は省略可能で、"プログラム向けのオプションが誤って SBCL に処理されるのを防ぐ" ものです。

また `env -S` も使いました。通常 `env` は 1 つの引数しか受け取りませんが、`-S`（`--split-string`）を使うと複数の引数を指定できます。そのおかげで `--script` フラグを追加できました。


### スクリプトから依存関係を quickload する

まだ `.asd` のプロジェクト定義を用意しておらず、とにかく簡単なスクリプトを書きたいだけで、Quicklisp の依存を読み込みたいとします。その場合は少し手順が増えます。

```lisp
#!/usr/bin/env -S sbcl --script

(require :uiop)

;; We want quicklisp, which is loaded from our initfile,
;; after a classical installation.
;; However the --script flag doesn't load our init file:
;; it implies --no-sysinit --no-userinit --disable-debugger --end-toplevel-options
;; So, please load it:
(load "~/.sbclrc")

;; Load a quicklisp dependency silently.
(ql:quickload "str" :silent t)

(princ (str:concat "hello " (uiop:getenv "USER") "!"))
```

そのため、Quicklisp 依存がすでにインストール済みなら、`require` だけでも済ませられます。

~~~lisp
;; replace loading sbclrc and ql:quickload.
(require :str)
~~~

なお、コードの途中に `ql:quickload` を置くと、そのファイルはもう読み込めませんし、エディタから `C-c C-k` もできなくなります。reader は `quickload` をまだ実行せずに読み進め、そのあとで、まだロードされていないパッケージへの呼び出しである `str:concat` に遭遇するからです。Common Lisp には、read フェーズ中にコードを実行する形があります。

~~~lisp
;; you shouldn't need this. Use an .asd system definition!
(eval-when (:load-toplevel :compile-toplevel :execute)
  (ql:quickload "str" :silent t))
~~~

ただし、ASDF のプロジェクト定義があるのには理由があります。

アプリケーションコードの途中で依存関係をインストールさせる言語を、他に見つけてください。

<a id="the-main-entry-point"></a>

### 「main」エントリポイント

ファイルを `load` すると、トップレベルの命令がすべて実行されます。

次のコードでは:

```lisp
(defun foo ()
  :hello)
```

`foo` 関数はコンパイルされますが、何も実行されません。次のコードでは:

```lisp
(defun foo ()
  :hello)

(foo)
```

`foo` はコンパイルされ、そのあと実行されます。ただし標準出力には何も出していないので、ターミナルには何も表示されないかもしれません。

つまり `(foo)` を main エントリポイントと考えられます。`main` 関数というものはありません。

ただし、トップレベル式があると、Slime の `C-c C-k` のように、ファイル全体を副作用なしでコンパイルして読み込むことができなくなります。これを避けるには、次のようにします。

```lisp
(eval-when (:execute)
  (foo))
```

これで、エディタから対話的にスクリプトを開発でき、トップレベル式の副作用に悩まされずに `C-c C-k`（`slime-compile-and-load-file`）を使えます。


## 自己完結型実行ファイルを作る

### SBCL を使う - イメージと実行ファイル

自己完結型の実行ファイルの作り方は、デフォルトでは実装依存です（移植可能な方法は後述します）。SBCL では、[ドキュメント](http://www.sbcl.org/manual/index.html#Function-sb_002dext_003asave_002dlisp_002dand_002ddie) にあるとおり、`save-lisp-and-die` を `:executable` 引数を `t` にして呼び出します。

~~~lisp
(sb-ext:save-lisp-and-die #P"path/name-of-executable"
                         :toplevel #'my-app:main-function
                         :executable t)
~~~

`sb-ext` は SBCL の拡張で、外部プロセスを扱います。ほかの [SBCL 拡張](http://www.sbcl.org/manual/index.html#Extensions) もあります（多くは他のライブラリで移植可能になっています）。

`:executable t` は、イメージではなく実行ファイルを作ることを意味します。現在の Lisp イメージの状態を保存して、あとでその状態から作業を再開するためにイメージを作ることもできます。計算量の多い作業をたくさんしたときには特に便利です。その場合は `sbcl --core name-of-image` でそのイメージを再利用します。

`:toplevel` はプログラムのエントリポイントで、ここでは `my-app:main-function` です。シンボルを `export` するのを忘れないでください。あるいは `my-app::main-function`（コロン 2 つ）を使ってもかまいません。

これを Slime で実行すると、スレッドが動いていることに関するエラーになります。

> Cannot save core with multiple threads running.

このコマンドは、端末上の素の SBCL REPL から実行する必要があります。

プロジェクトに Quicklisp の依存があるとしましょう。その場合は次のことが必要です。

* Lisp 起動時に Quicklisp がインストールされ、読み込まれていることを確認する（Quicklisp の導入を済ませる）
* プロジェクトの `.asd` を `asdf:load-asd` する（単なる `load` より推奨）
* 依存関係をインストールする
* 実行ファイルを作る

すると、次のようになります。

~~~lisp
(asdf:load-asd "my-app.asd")
(ql:quickload "my-app")
(sb-ext:save-lisp-and-die #p"my-app-binary"
                          :toplevel #'my-app:main
                          :executable t)
~~~

コマンドラインや Makefile からは、`--load` と `--eval` を使います。

```
build:
	sbcl --load my-app.asd \
	     --eval '(ql:quickload :my-app)' \
         --eval "(sb-ext:save-lisp-and-die #p\"my-app\" :toplevel #'my-app:main :executable t)"
```

### `uiop:dump-image` を使う

`sb-ext:save-lisp-and-die` は SBCL 専用です。ほかの実装にも似た機能はありますが、関数名や引数は異なります。CCL（Clozure CL）では `ccl:save-application` です。

Common Lisp 実装間で移植可能なビルドスクリプトを書きたいなら、`uiop:dump-image` を使えます。引数はおおむね `save-lisp-and-die` と同じですが、`:toplevel` の代わりに `uiop:*image-entry-point*` 変数へ設定します。

~~~lisp
;; build.lisp
(asdf:load-asd "my-app.asd")
(ql:quickload "my-app")

(setf uiop:*image-entry-point* #'my-app:main)

(uiop:dump-image "my-app-binary" :executable t :compression 9)
~~~

この `build.lisp` というファイルは、どの実装でも実行できます。

    $ sbcl --load build.lisp
    $ ecl --load build.lisp
    $ ccl --load build.lisp
    …


### ASDF を使う

ビルド手順を `.asd` のプロジェクト定義に直接書くこともできます。

ASDF 3.1 以降ではそれが可能です。`.asd` から引数を読む [`make` コマンド](https://common-lisp.net/project/asdf/asdf.html#Convenience-Functions) が導入されました。`.asd` に次を追加します。

~~~
:build-operation "program-op" ;; leave as is
:build-pathname "<here your final binary name>"
:entry-point "<my-package:main-function>"
~~~

そして `asdf:make :my-package` を呼びます。

そのため、Makefile には次のように書けます。

~~~lisp
LISP ?= sbcl

build:
    $(LISP) --load my-app.asd \
    	--eval '(ql:quickload :my-app)' \
		--eval '(asdf:make :my-app)' \
		--eval '(quit)'
~~~

### Deploy を使う - 外部ライブラリ依存もまとめて配布する

ここまでで、自分のマシンでは動くバイナリを作れます。しかし、他人の環境やサーバーで動くとは限りません。たぶんプログラムは、ファイルシステム上のどこかにある C の共有ライブラリに依存しています。たとえば `libssl` が次のような場所にあるかもしれません。

    /usr/lib/x86_64-linux-gnu/libssl.so.1.1

しかし VPS では別の場所にあるかもしれません。

そこで [Deploy](https://github.com/Shinmera/deploy) の出番です。

Deploy は、バイナリと必要な外部ライブラリを含む `bin/` ディレクトリを作ります。プログラムが必要とするものを自動検出しますが、必要なら手助けもできますし、やりすぎないように指示もできます。

使い方は、`asdf:make` と `.asd` の構成を使う先ほどのレシピにかなり近いです。次のようにします。

~~~lisp
:defsystem-depends-on (:deploy)  ;; (ql:quickload "deploy") before
:build-operation "deploy-op"     ;; instead of "program-op"
:build-pathname "my-application-name"  ;; doesn't change
:entry-point "my-package:my-start-function"  ;; doesn't change
~~~

そして、前と同じく `(asdf:make :my-app)` でバイナリをビルドします。

これで `bin/` ディレクトリを利用者へ配布できます。

バイナリを実行すると、同梱したライブラリが使われているのが分かります。

~~~lisp
$ ./my-app
 ==> Performing warm boot.
   -> Runtime directory is /home/debian/projects/my-app/bin/
   -> Resource directory is /home/debian/projects/my-app/bin/
 ==> Running boot hooks.
 ==> Reloading foreign libraries.
   -> Loading foreign library #<LIBRARY LIBRT>.
   -> Loading foreign library #<LIBRARY LIBMAGIC>.
 ==> Launching application.
 […]
~~~

成功です。

`libssl` について補足です。少なくとも Linux では、OS に入っているものを使うほうが簡単なので、Deploy にはこれを同梱しないよう指示します（`libcrypto` も同様です）。

~~~lisp
(require :cl+ssl)
#+linux (deploy:define-library cl+ssl::libssl :dont-deploy T)
#+linux (deploy:define-library cl+ssl::libcrypto :dont-deploy T)
~~~

Deploy が見つけられない外部ライブラリを同梱したい日には、次のように指定できます。

~~~lisp
(deploy:define-library cl+ssl::libcrypto
  ;;                   ^^^ CFFI system name.
  ;;                   Find it with a call to "apropos".
  :path "/usr/lib/x86_64-linux-gnu/libcrypto.so.1.1")
~~~

最後にもう 1 点です。バイナリを作って初めて実行すると、ASDF が自分自身を更新しようとして `~/common-lisp/asdf/` リポジトリに何も見つけられず、終了することがあります。これを避けるには、`.asd` に次を追加します。

~~~lisp
;; Tell ASDF to not update itself.
(deploy:define-hook (:deploy asdf) (directory)
  (declare (ignorable directory))
  #+asdf (asdf:clear-source-registry)
  #+asdf (defun asdf:upgrade-asdf () nil))
~~~

`asdf:make` を呼ぶ前にビルドスクリプトへこれを追加すると、Deploy の起動メッセージも消せます。

    (push :deploy-console *features*)

ほかにもあります。詳しくは Deploy のドキュメントを参照してください。


### Roswell または Buildapp を使う

[Roswell](https://roswell.github.io) は、実装管理、スクリプト起動などを行うツールで、`ros build` コマンドを備えています。多くの実装で使えるはずです。

これを使えば、`ros install my-app` のようにして他人に簡単にインストールしてもらえます。詳しくは Roswell のドキュメントを参照してください。

なお、`ros build` は既定で core compression を有効にします。そのため、単純なアプリでも起動オーバーヘッドがかなり増えます（およそ 150ms 増え、30ms ほどだった起動時間が 180ms ほどになることがあります）。`ros build <app.ros> --disable-compression` で無効化できます。もちろん、core compression はバイナリサイズを大きく減らします。後ろの「実装ごとの実行ファイルサイズと起動時間」の表を見てください。

最後に [Buildapp](http://www.xach.com/lisp/buildapp/) について少し触れます。これは実戦投入され、今でも人気のある「SBCL または CCL 向けで、実行可能な Common Lisp イメージを構成して保存するアプリケーション」です。

使用例です。

~~~lisp
buildapp --output myapp \
         --asdf-path . \
         --asdf-tree ~/quicklisp/dists \
         --load-system my-app \
         --entry my-app:main
~~~

多くのアプリケーションが使っています（たとえば [pgloader](https://github.com/dimitri/pgloader)）。Debian では `apt install buildapp` で入りますが、今なら `asdf:make` や Roswell で足りるはずです。


<a id="for-web-apps"></a>

### Web アプリ向け

同様に、Web アプリケーション向けの自己完結型実行ファイルも作れます。これには Web サーバーが含まれ、コマンドラインから起動できます。

    $ ./my-web-app
    Hunchentoot server is started.
    Listening on localhost:9003.

これは開発用ではなく本番用の Web サーバーを起動する点に注意してください。そのため、バイナリを VPS でそのまま実行して外部からアクセスできます。

気をつける点が 1 つあります。動いている Web サーバーのスレッドを見つけて前面に置くことです。`main` 関数では次のようにできます。

~~~lisp
(defun main ()
  (handler-case
      (progn
        (start-app :port 9003) ;; our start-app, for example clack:clack-up
        ;; let the webserver run,
        ;; keep the server thread in the foreground:
        ;; sleep for ± a hundred billion years.
        (sleep most-positive-fixnum))

    ;; Catch a user's C-c
    (#+sbcl sb-sys:interactive-interrupt
      #+ccl  ccl:interrupt-signal-condition
      #+clisp system::simple-interrupt-condition
      #+ecl ext:interactive-interrupt
      #+allegro excl:interrupt-signal
      () (progn
           (format *error-output* "Aborting.~&")
           (clack:stop *server*)
           (uiop:quit)))
    (error (c) (format t "Woops, an unknown error occurred:~&~a~&" c))))
~~~

ここでは `bordeaux-threads` ライブラリ（`(ql:quickload "bordeaux-threads")`、別名 `bt`）と、ASDF の一部としてすでに読み込まれている `uiop` を使い、移植可能な方法で終了しています（`sb-ext:quit` ではなく、任意の終了コードを取れる `uiop:quit`）。


### 実装ごとの実行ファイルサイズと起動時間

**SBCL** だけが Lisp 実装ではありません。[**ECL**](https://gitlab.com/embeddable-common-lisp/ecl/)（Embeddable Common Lisp）は Lisp プログラムを C に変換するため、より小さな実行ファイルになります。

[この Reddit 投稿](https://www.reddit.com/r/lisp/comments/46k530/tackling_the_eternal_problem_of_lisp_image_size/) によると、ECL は確かに最小の実行ファイルを生成し、SBCL より 1 桁ほど小さい一方で、起動時間は長めです。

CCL のバイナリは、SBCL と同程度に速く起動し、サイズはほぼ半分のようです。


```
| program size | implementation |  CPU | startup time |
|--------------+----------------+------+--------------|
|           28 | /bin/true      |  15% |        .0004 |
|         1005 | ecl            | 115% |        .5093 |
|        48151 | sbcl           |  91% |        .0064 |
|        27054 | ccl            |  93% |        .0060 |
|        10162 | clisp          |  96% |        .0170 |
|         4901 | ecl.big        | 113% |        .8223 |
|        70413 | sbcl.big       |  93% |        .0073 |
|        41713 | ccl.big        |  95% |        .0094 |
|        19948 | clisp.big      |  97% |        .0259 |
```

<!-- TODO: what about SBCL with maximum core compression? -->

コンパイル時間については、**CCL** が速いことで有名です。ECL は処理が重く、この 3 つの中ではコンパイルに最も時間がかかります。

商用 Lisp の **tree shaker** の能力も調べる価値があります。**LispWorks** なら、圧縮なしでも完全に tree shake された 8MB の hello-world プログラムを作れます。そのような実行ファイルは約 1 秒で生成され、Apple M2 Pro CPU では実行時間は 0.02 秒未満です。


### Building a smaller binary with SBCL's core compression

SBCL の core compression を使うと、アプリケーションのバイナリサイズを大幅に減らせます。今回の例では 120MB から 23MB まで減り、その代わり起動時間は十数ミリ秒増えましたが、それでも 50ms 未満でした。

<div class="info-box info">
    <strong>Note:</strong> SBCL 2.2.6 switched to compression with zstd instead of zlib, which provides smaller binaries and faster compression and decompression times. Un-official numbers are: about 4x faster compression, 2x faster decompression, and smaller binaries by 10%.
</div>


使っている SBCL は core compression 対応である必要があります。ドキュメント [Saving-a-Core-Image](http://www.sbcl.org/manual/#Saving-a-Core-Image) を参照してください。

対応しているかどうかは次で確認できます。

~~~lisp
(find :sb-core-compression *features*)
:SB-CORE-COMPRESSION
~~~

はい、Debian 版の SBCL では対応しています。

**SBCL の場合**

SBCL では `save-lisp-and-die` に引数を渡します。`:compression` は次の意味です。

> -7 から 22 までの整数で、zstd の圧縮レベルに対応します。`t` は既定の圧縮レベル 9 と同じです。

単純な "Hello, world" プログラムの場合:

```
| Program size | Compression level   |
|--------------|---------------------|
| 46MB         | Without compression |
| 22MB         | -7                  |
| 12MB         | 9                   |
| 11MB         | 22                  |
```

Lisp で書かれた X ウィンドウマネージャー StumpWM のような大きなプロジェクトでは、次のようになります。

```
| Program size | Compression level   |
|--------------|---------------------|
| 58MB         | Without compression |
| 27MB         | -7                  |
| 15MB         | 9                   |
| 13MB         | 22                  |
```

**ASDF の場合**

ただし、ASDF（正確には UIOP）でやるほうが好まれます。`.asd` に次を追加します。

~~~lisp
#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c)
                   :executable t
                   :compression t))
~~~

**Deploy の場合**

[Deploy](https://github.com/Shinmera/deploy/) ライブラリでも、完全にスタンドアロンなアプリケーションを作れます。利用可能なら圧縮も使います。

Deploy は、外部ライブラリ依存のあるアプリケーション向けに特化しています。依存先の共有ライブラリをすべて集め、`bin` サブディレクトリにまとめます。

これで完了です。

## core image を作る: 依存が多くても速く起動する

最初の用途に戻りましょう。shebang 行（`#!/usr/bin/env -S sbcl --script`）を使うスクリプトで依存関係を "quickload" したい場面です。ただし、依存が増えるほどスクリプトの起動は遅くなります。これを改善できるでしょうか。

必要なのは十数個の依存関係（とその推移的依存）です。

```
str
cl-ppcre
serapeum
bordeaux-threads
local-time
dexador
hunchentoot
djula
parse-number
shasht
cl-yaml
clingon
log4cl
```

スクリプトを再び速くする方法があります。依存関係をすべて読み込んだ "core image" をダンプし、その core image からスクリプトを実行します。

`uiop:dump-image "my.core"` で移植可能に core image を作れます。SBCL では `sb-ext:save-lisp-and-die …` に相当し、` :executable t` を除いた引数が同じです。実行ファイルでなければ、それは core image です。

`build-core.lisp` を作ります。

```lisp
(ql:quickload
 '("str"
   "cl-ppcre"
   "serapeum"
   "bordeaux-threads"
   "local-time"
   "dexador"
   "hunchentoot"
   "djula"
   "parse-number"
   "shasht"
   "cl-yaml"
   "clingon"
   "log4cl"
   ))

(uiop:dump-image "my.core")
```

このファイルを実行して core image を作ります。

    sbcl --load build-core.lisp

出力は次のようになります。

```
This is SBCL 2.5.8, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
To load "str":
  Load 1 ASDF system:
    str
; Loading "str"
...

[…]

[undoing binding stack and other enclosing state... done]
[performing final GC... done]
[defragmenting immobile space... (inst,code,sym)=1038+22032+24090... done]
[saving current Lisp image into my.core:
writing 65536 bytes from the linkage space at 0xb7ffb00000
writing 1310720 bytes from the fixedobj space at 0x50000000
writing 2752 bytes from the static space at 0x520000000000
writing 26050560 bytes from the dynamic space at 0x1200000000
writing 18951888 bytes from the read-only space at 0x11fede8000
writing 12767232 bytes from the text space at 0xb800000000
done]
```

これで新しい `my.core` ファイルができます。

```
$ ls -lh my.core
-rwxr-xr-x 1 me me 86M Mar  3 14:12 my.core
```

これをスクリプトから使うには、コマンドライン引数 `--core my.core` を付けます。`myscript.lisp` は次のようになります。

```lisp
#!/usr/bin/env -S sbcl --core my.core --script

(format t "Hello script. We are using dependencies. Time is ~a.~&" (local-time:now))
```

```sh
$ chmod +x myscript.lisp
$ time ./myscript.lisp
Hello script. We are using dependencies. Time is 2084-03-03T14:19:55.573738+01:00.
./use-core.lisp  0.01s user 0.01s system 99% cpu 0.017 total
```

起動の速さを見てください。

最後に注意点です。

- core image はマシン間で移植できません。これは自分用であり、利用者へ配ったりサーバーへデプロイしたりはできません。そういう用途には実行ファイルを使ってください。
- Lisp ライブラリ以外も事前読み込みできます。静的ファイル（ゲームアセット、JS/CSS、Markdown 文書など）や、事前計算済みデータ（重い CSV をコンパイル時に解析して読み込むなど）も含められます。

さらに読む:

- [SBCL's documentation](https://www.sbcl.org/manual/#Saving-a-Core-Image)


## コマンドライン引数を解析する

SBCL はコマンドライン引数を `sb-ext:*posix-argv*` に入れます。

ただし変数名は実装ごとに違うので、その差を吸収する手段が欲しくなります。

そこで `(uiop:command-line-arguments)` があります。これは ASDF に含まれ、ほぼすべての実装で使えます。コードのどこからでも、次のようにして特定の文字列がこのリストにあるか確認できます。

~~~lisp
(member "-h" (uiop:command-line-arguments) :test #'string-equal)
~~~

これで十分そうですが、さらに引数の解析や、短いオプション・長いオプションのチェック、自動ヘルプ生成なども欲しくなります。

そこで [Clingon](https://github.com/dnaeon/clingon) ライブラリを選びました。機能がもっとも豊富かもしれないからです。

- it handles subcommands,
- it supports various kinds of options (flags, integers, booleans, counters, enums…),
- it generates Bash and Zsh completion files as well as man pages,
- it is extensible in many ways,
- we can easily try it out on the REPL
- etc

ダウンロードしてみましょう。

    (ql:quickload "clingon")

よくあることですが、作業は 2 つの段階に分かれます。

* we first declare the options that our application accepts, their
  kind (flag, string, integer…), their long and short names and the
  required ones.
* we ask Clingon to parse the command-line options and run our app.


### オプションを宣言する

コマンドラインツールの使い方を、次のように表したいとします。

    $ myscript [-h, --help] [-n, --name NAME]

最終的には、アプリケーションを表す Clingon の command を `clingon:make-command` で作る必要があります。command は option と、ロジックを担当する handler 関数から成ります。

まずは option を作りましょう。Clingon は `--help` はすでに扱ってくれますが、短い版は扱いません。`clingon:make-option` で option を作る例は次のとおりです。

~~~lisp
(clingon:make-option
 :flag                ;; <--- option kind. A "flag" does not expect a parameter on the CLI.
 :description "short help"
 ;; :long-name "help" ;; <--- long name, sans the "--" prefix, but here it's a duplicate.
 :short-name #\h      ;; <--- short name, a character
 ;; :required t       ;; <--- is this option always required? In our case, no.
 :key :help)          ;; <--- the internal reference to use with getopt, see later.
~~~

これは **flag** です。コマンドラインに `-h` があれば option の値は真、それ以外は偽になります。flag は引数を取りません。単独で存在します。

似た種類の option には次のものがあります。

- `:boolean`: 引数を取ります。"true" または 1 なら真、それ以外は偽とみなします。
- `:counter`: コマンドラインで何回指定されたかを数えます。通常は `-v` / `--verbose` に使い、利用者は `-vvv` のようにして詳細度を上げられます。この場合、値は 3 です。指定されなければ 0 になります。

2 つ目の option（引数付きの `--name` または `-n`）を作り、すべてを小さな関数にまとめます。

~~~lisp
;; The naming with a "/" is just our convention.
(defun cli/options ()
  "Returns a list of options for our main command"
  (list
   (clingon:make-option
    :flag
    :description "short help."
    :short-name #\h
    :key :help)
   (clingon:make-option
    :string              ;; <--- string type: expects one parameter on the CLI.
    :description "Name to greet"
    :short-name #\n
    :long-name "name"
    :env-vars '("USER")     ;; <-- takes this default value if the env var exists.
    :initial-value "lisper" ;; <-- default value if nothing else is set.
    :key :name)))
~~~

2 つ目に作ったオプションは `:string` 種別です。このオプションは引数を 1 つ取り、それは文字列として解析されます。引数を整数として解析する `:integer` もあります。

Clingon にはほかにもオプション種別があり、その充実したドキュメントで確認できます。`:choice`、`:enum`、`:list`、`:filepath`、`:switch` などです。

### Top-level command

トップレベルコマンドを Clingon に伝える必要があります。`clingon:make-command` はいくつかの説明用フィールドと、2 つの重要なフィールドを受け取ります。

- `:options` は Clingon オプションのリストで、各オプションは `clingon:make-option` で作ります
- `:handler` はアプリのロジックを実行する関数です。

最後に、main 関数（バイナリのエントリポイント）の中で `clingon:run` を使って、コマンドライン引数を解析し、コマンドのロジックを適用します。開発中は `clingon:parse-command-line` を手動で呼んで試すこともできます。

最小限のコマンドを示します。ハンドラ関数はあとで定義します。

~~~lisp
(defun cli/command ()
  "A command to say hello to someone"
  (clingon:make-command
   :name "hello"
   :description "say hello"
   :version "0.1.0"
   :authors '("John Doe <john.doe@example.org")
   :license "BSD 2-Clause"
   :options (cli/options) ;; <-- our options
   :handler #'null))  ;; <--  to change. See below.
~~~

この時点で、REPL でもう試せます。

### REPL でオプション解析を試す

`clingon:parse-command-line` を使います。トップレベル command と、コマンドライン引数の文字列リストを受け取ります。

~~~lisp
CL-USER> (clingon:parse-command-line (cli/command) '("-h" "-n" "me"))
#<CLINGON.COMMAND:COMMAND name=hello options=5 sub-commands=0>
~~~

動きます。

この command オブジェクトを `inspect` すると、プロパティ（name、hooks、description、context など）や option の一覧などが見えます。

未知の option でも試してみましょう。

~~~lisp
CL-USER> (clingon:parse-command-line (cli/command) '("-x"))
;; => debugger: Unknown option -x of kind SHORT
~~~

その場合は対話デバッガに入り、次のように表示されます。

```
Unknown option -x of kind SHORT
   [Condition of type CLINGON.CONDITIONS:UNKNOWN-OPTION]
```

そして、いくつかの restart が提示されます。

```
Restarts:
 0: [DISCARD-OPTION] Discard the unknown option
 1: [TREAT-AS-ARGUMENT] Treat the unknown option as a free argument
 2: [SUPPLY-NEW-VALUE] Supply a new value to be parsed
 3: [RETRY] Retry SLIME REPL evaluation request.
 4: [*ABORT] Return to SLIME's top level.
```

これらはかなり実用的です。必要なら `parse-command-line` に `:around` メソッドを作り、`handler-bind` で Clingon の条件を扱い、その restart を使って未知の option に別の処理をさせることもできます。ただ、現時点ではそこまで要りません。無効な option は警告してほしいからです。

最後に、Clingon が CLI ツールの usage 情報をどう出すか見てみましょう。

```
CL-USER> (clingon:print-usage (cli/command) t)
NAME:
  hello - say hello

USAGE:
  hello [options] [arguments ...]

OPTIONS:
      --help          display usage information and exit
      --version       display version and exit
  -h                  short help.
  -n, --name <VALUE>  Name to greet [default: lisper] [env: $USER]

AUTHORS:
  John Doe <john.doe@example.org

LICENSE:
  BSD 2-Clause
```

`USAGE` 部分は、トップレベル command の `:usage` キーパラメータで調整できます。


### option を処理する

コマンドライン引数の解析が成功したら、それを使って何かする必要があります。ここで新しい Clingon 関数を 2 つ使います。

- `clingon:getopt` は、` :key` で option の値を取得します
- `clingon:command-arguments` は、コマンドラインに残った自由引数を取得します

使い方は次のとおりです。

~~~lisp
CL-USER> (let ((command (clingon:parse-command-line (cli/command) '("-n" "you" "last"))))
           (format t "name is: ~a~&" (clingon:getopt command :name))
           (format t "free args are: ~s~&" (clingon:command-arguments command)))
name is: you
free args are: ("last")
NIL
~~~

これらを使って、トップレベル command の handler を書きます。

~~~lisp
(defun cli/handler (cmd)
  "The handler function of our top-level command"
  (let ((free-args (clingon:command-arguments cmd))
        (name (clingon:getopt cmd :name)))  ;; <-- using the option's :key
    (format t "Hello, ~a!~%" name)
    (format t "You have provided ~a more free arguments~%"
            (length free-args))
    (format t "Bye!~%")))
~~~

トップレベル command に、この handler を使うよう伝えます。

~~~lisp
;; from above:
(defun cli/command ()
  "A command to say hello to someone"
  (clingon:make-command
   ...
   :handler #'cli/handler))  ;; <-- changed.
~~~

あとはバイナリの main エントリポイントを書けば終わりです。

ちなみに `clingon:getopt` は 3 つの値を返します。

- option の値
- その option がコマンドラインで指定されたかを示す真偽値
- この値を提供した command

`clingon:opt-is-set-p` も参照してください。


### main エントリポイント

これは任意の関数でかまいませんが、Clingon を使うなら `run` 関数を呼びます。

~~~lisp
(defun main ()
  "The main entrypoint of our CLI program"
  (clingon:run (cli/command)))
~~~

この main 関数をバイナリのエントリポイントとして使うには、上で説明した Common Lisp バイナリの作り方に従います。念のため、`.asd` の system 定義で次のように設定します。

~~~lisp
:entry-point "my-package::main"
~~~

これでほぼ終わりです。おめでとうございます。これでコマンドライン引数をきちんと解析できます。

Clingon のドキュメントには、サブコマンド、コンテキスト、フック、C-c の扱い、メール用の option のような新しい種類の開発、Bash/Zsh 補完など、さらに多くの情報があります。


## C-c の終了シグナルを捕まえる

既定では、**Clingon は SIGINT シグナルの handler を提供します**。これによりアプリケーションはすぐに終了し、終了コード 130 を返します。

アプリケーションに後始末のロジックが必要なら、`unwind-protect` を使えます。ただしすべてのケースに向くとは限らないため、Clingon では [with-user-abort](https://github.com/compufox/with-user-abort) 補助ライブラリの利用も案内しています。

以下では、C-c を手動で捕まえる方法を示します。既定では Lisp のスタックトレースが出るからです。

簡単なバイナリを作って実行し、`C-c` を押してみました。スタックトレースを見てみましょう。

~~~
$ ./my-app
sleep…
^C
debugger invoked on a SB-SYS:INTERACTIVE-INTERRUPT in thread   <== condition name
#<THREAD "main thread" RUNNING {1003156A03}>:
  Interactive interrupt at #x7FFFF6C6C170.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE     ] Return from SB-UNIX:SIGINT.               <== it was a SIGINT indeed
  1: [RETRY-REQUEST] Retry the same request.
~~~

シグナルされた条件の名前は実装依存で、ここでは `sb-sys:interactive-interrupt` です。アプリケーションコードを `handler-case` で囲めばよいです。

~~~lisp
(handler-case
    (run-my-app free-args)
  (sb-sys:interactive-interrupt ()
      (progn
        (format *error-output* "Abort.~&")
        (uiop:quit))))
~~~

ただし、このコードは SBCL 専用です。[trivial-signal](https://github.com/guicho271828/trivial-signal/) もありますが、ここではまだ十分ではありませんでした。なので、次のような書き方にできます。

~~~lisp
(handler-case
    (run-my-app free-args)
  (#+sbcl sb-sys:interactive-interrupt
   #+ccl  ccl:interrupt-signal-condition
   #+clisp system::simple-interrupt-condition
   #+ecl ext:interactive-interrupt
   #+allegro excl:interrupt-signal
   ()
   (uiop:quit)))
~~~

ここで `#+` は、実装に応じてその行をコンパイル時に含めます。`#-` もあります。`#+` は `*features*` リスト内のシンボルを見ます。シンボルは `and`、`or`、`not` でも組み合わせられます。

## 実行ファイルの継続的デリバリー

継続的インテグレーションシステム（Travis CI、GitLab CI など）に、コミットごと、タグ push ごと、あるいは任意のポリシーでバイナリをビルドさせられます。

[`継続的インテグレーション`](testing.html#continuous-integration) を参照してください。

## 関連項目

- [SBCL-GOODIES](https://github.com/sionescu/sbcl-goodies) - 外部ライブラリ付きの SBCL バイナリを配布できます。`libssl`、`libcrypto`、`libfixposix` が静的に組み込まれます。これら 3 つの外部ライブラリだけを使うなら、Deploy は不要になります。
  * 2023 年 2 月に公開されました。
- [CIEL Is an Extended Lisp](http://ciel-lang.org/) - スクリプト機能を備えた、盛り込み済みの Common Lisp パッケージです。
- [kiln](https://github.com/ruricolist/kiln) - Lisp のスクリプト実行を効率的かつ扱いやすくするための基盤です（隠しマルチコールバイナリを管理します）。
  * Kiln を使うと、非常に小さなスクリプトも実用的に書けます。Kiln のスクリプトは高速で低コストなので、Lisp の小さな機能片でもシェルへ公開する意味が出てきます。
- [Common Lisp を Windows 向けにクロスコンパイルする](https://www.fosskers.ca/en/blog/cl-windows)

## 謝辞

* [cl-torrents のチュートリアル](https://vindarel.github.io/cl-torrents/tutorial.html)
* [lisp-journey/web-dev](https://lisp-journey.gitlab.io/web-dev/)
