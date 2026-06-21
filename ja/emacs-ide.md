---
title: Emacs を IDE として使う
---

このページでは、[Emacs](https://www.gnu.org/software/emacs/) を Lisp IDE として使うための導入を説明します。

大まかに 3 つの節に分けています。Slime（または Sly）のインストール方法、使い方、そして Lisp コードを扱うための Emacs 組み込みコマンドに関する補足情報です。

![Emacs teaser image](assets/emacs-teaser.png)

<!-- todo: C-u M-x slime and its configuration to work with multiple implementations -->

ところで、なぜ Emacs を使うのでしょうか。

* Emacs は Lisp コードを扱うための非常に優れたサポートを備えています
  * Slime-Swank の client-server モデルは LSP より前からあり、Common Lisp との統合ではずっと豊かです。
* ほぼすべての OS とすべての CL 処理系で動作し、軽量です
* Emacs はおそらく今後もあり続けます
* Emacs はマウスありでもなしでもうまく使えます
* Emacs は GUI mode でも terminal でもうまく使えます
* 組み込みの tree-sitter と LSP サポート
* 優れた vim mode
* [Org-mode](http://orgmode.org) があるから
* [Magit](https://magit.vc/) があるから
* [Emacs Rocks !](http://emacsrocks.com) があるから
* 大きな user base と膨大な extensions: [awesome-emacs](https://github.com/emacs-tw/awesome-emacs)。

## SLIME: Superior Lisp Interaction Mode for Emacs

[SLIME](http://common-lisp.net/project/slime/) は CL programming の定番 major mode です。強力で統合された、非常に対話的な開発環境にするための機能を多数備えています。

* 実行中の image に接続された REPL を Emacs 内で提供します
* Common Lisp debugger を Emacs インターフェイスと統合します
* シンボル completion を提供します
* code evaluation、compilation、macroexpansion
* cross-referencing
* breaking、stepping、tracing
* go to definition
* online documentation
* 関数、シンボル、system names、documentation の fuzzy search
* 対話的なオブジェクト inspector
* 一般的な Common Lisp 処理系をすべてサポートします
* 複数 connection と複数 listener buffers（mrepl）
* MELPA からすぐ利用できます
* 活発に保守されています。


## SLY: Sylvester the Cat's Common Lisp IDE

[SLY](https://github.com/joaotavora/sly) は SLIME の fork で、次の変更と機能を含みます。

* Emacs 自身の高機能な comint.el に基づく、完全に再設計された REPL。あらゆるものを REPL に copy できます。
* [Stickers](https://joaotavora.github.io/sly/#Stickers) 機能による live code annotations。
* オブジェクトを highlight し、REPL session を通じて安定して残る enumerated backreferences。
* 初期段階ながら機能する prototype の、portable な annotation-based stepper。
* 複数 REPL と複数 inspectors。
* Regexp-capable な `M-x sly-apropos`。
* Contribs は第一級の SLY citizens で、デフォルトで有効、必要に応じて ASDF でロードされます。
  * [NAMED-READTABLES](https://github.com/joaotavora/sly-named-readtables) support
  * [macrostep.el](https://github.com/joaotavora/sly-macrostep)
  * [Quicklisp](https://github.com/joaotavora/sly-quicklisp)
  * [ASDF](https://github.com/mmgeorge/sly-asdf)
  * [Evaluation Overlays](https://git.sr.ht/~fosskers/sly-overlay)

一方で、いくつか不足や違いも見つかりました。

* Sly には `slime-call-defun`（C-c C-y）相当がありません。
  * これは残念です。私たちはかなり慣れているからです。下の「REPL にコードを送る」を参照してください。
* `slime-profile-*` 関数がありません（`sb-prof` contrib がありません）。
* REPL に切り替える shortcut `C-c C-z` は Slime のものと挙動が異なります（source file を残して横に REPL を表示する代わりに、source file を REPL ウィンドウで置き換えることがあります）。

Sly は [Doom Emacs](https://github.com/doomemacs/doomemacs/) にデフォルトで同梱されています。

## SLIME または SLY をインストールする

### 手動

Ubuntu では、SLIME は Emacs と SBCL と一緒に簡単にインストールできます。

    sudo apt install emacs slime sbcl

それ以外では、次の code を `~/.emacs.d/init.el` file に追加して SLIME をインストールします。

~~~lisp
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(defvar my-packages '(slime))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

(require 'slime)
~~~

Emacs と SBCL もインストール済みだと仮定します。

SLIME はかなり modular で、デフォルトでは最低限（SLIME REPL すら含まない）しか有効にならないため、次のようにより多くの機能を有効にしたくなるかもしれません。

~~~lisp
(require 'slime)
(slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl))
~~~

最後に、Slime に SBCL を使うよう伝えます。

~~~lisp
(setq inferior-lisp-program "sbcl")
~~~

これでキーボードの Alt-X を押して `slime` と入力し、Common Lisp を試せます。

（Alt-X は Emacs の世界ではよく `M-x` と書かれます。）

詳しくは[documentation](https://common-lisp.net/project/slime/doc/html/)を参照してください（Info page としても利用できます）。

これで、前述のとおり `M-x slime` や `M-x slime-connect` で SLIME を実行できます。

関連項目:

- [Portacle](https://shinmera.github.io/portacle/) - Emacs、Slime、SBCL、git、必要な extensions を同梱した portable で multi-platform な CL development 環境。始めるための straightforward な方法です。
  - ただし Portacle は現在古く、保守されていません。Emacs 27.1 を含んでおり、新しい MacOS では実行が面倒かもしれません。自己責任です。それでも使える場合はあり、更新の取り組みに参加できます。
* [emacs4cl](https://github.com/susam/emacs4cl) - 新規ユーザが素早く始めるための、チュートリアル付きの最小 Emacs configuration。

### Doom Emacs

[Doom Emacs](https://github.com/doomemacs/doomemacs/) は人気の Emacs configuration です。Sly integration を簡単に有効にできます。


<a id="slime-fancy--contrib-packages"></a>

### SLIME fancy と contrib パッケージ

SLIME の機能はパッケージといわゆる [contrib modules](https://common-lisp.net/project/slime/doc/html/Contributed-Packages.html) に分かれており、追加機能を使うにはロードする必要があります。前述の `slime-fancy` には次が含まれます。

* slime-autodoc
* slime-c-p-c
* slime-editing-commands
* slime-fancy-inspector
* slime-fancy-trace
* slime-fontifying-fu
* slime-fuzzy
* slime-mdot-fu
* slime-macrostep
* slime-presentations
* slime-references
* slime-repl
* slime-scratch
* slime-package-fu
* slime-trace-dialog
* [slime-mrepl](https://slime.common-lisp.dev/doc/html/slime_002dmrepl.html#slime_002dmrepl)（複数 REPL）

SLIME には [Helm-SLIME](https://github.com/emacs-helm/helm-slime) のような便利な extensions もあります。主な機能は次のとおりです。

- Fuzzy completion
- REPL と connection の一覧
- REPL history の fuzzy-search
- _apropos_ documentation の fuzzy-search


## SLIME（または SLY）で作業する

最初にやりたくなることの一つは、Lisp code を compile して load することです。関数上で `C-c C-c`、または file 全体を compile するには `C-c C-k` を使います。しかしそれだけではありません。続きを読んでください。

ここでは SLIME の関数 names を示します。多くの場合 SLY でも似ています。

### Pro Tip: Emacs menu を使う

このページの情報は多くて圧倒されるかもしれませんが、ここで扱う commands と keybindings は Emacs の Slime menu の下で簡単に見つけられます。そのため menu は*無効にしない*ことを勧めます。とても便利です。

見えない場合は `M-x menu-bar-mode RET` を呼び出します。

terminal 版 Emacs（`emacs -nw`）では、`M-x menu-bar-open` で menu を開けます。これはデフォルトで `f10` に bound されています。また、mouse が有効なら mouse も使えます（`M-:` または `*scratch*` buffer で `(xterm-mouse-mode +1)` を評価します）。

![](assets/slime-menu.png "Emacs' SLIME menu lists all available commands and keybindings.")


### Code completion

SLIME でシンボルを補完するには、組み込みの `C-c TAB` を使います。[company-mode](http://company-mode.github.io/) を使うと tooltips も得られます。

![](assets/emacs-company-elisp.png "Lisp symbols completion with company-mode tooltips.")

**REPL** では単に **TAB** です。

ほかの open buffers にある任意の文字列を補完するには、`M-/` に bound された Emacs の hippie-expand を使います。

### SLIME で Lisp を評価・コンパイルする

**buffer** 全体を compile するには `C-c C-k`（`slime-compile-and-load-file`）を押します。

**region** は `M-x slime-compile-region` で compile します。

**defun** は cursor をその中に置き、`C-c C-c`（`slime-compile-defun`）を押して compile します。

code を compile したら、たとえば REPL で試せます。


compile ではなく**evaluate** するには:

- point の前の **sexp** を評価するには、closing paren の後に cursor を置いて `C-x C-e`（`slime-eval-last-expression`）を押します。結果は minibuffer に表示されます。
- 同様に、`C-c C-p`（`slime-pprint-eval-last-expression`）を使うと point 前の式を eval して pretty-print します。結果は新しい "slime-description" buffer に表示されます。
- `M-x slime-eval-print-last-expression`（デフォルトでは unbound）を使うと、結果を同じ file の cursor 下に出力します。
- region は `C-c C-r` で evaluate します。
- defun は `C-M-x` で evaluate します。
- `C-c C-e`（`slime-interactive-eval`）を入力すると、現在の context で eval する code を尋ねる prompt が出ます。結果は minibuffer に表示されます。prefix 引数付きなら、結果を現在の buffer に挿入します。
- 式の closing parenthesis の後に cursor があるとき、`C-c C-j`（`slime-eval-last-expression-in-repl`）を入力すると、この式を REPL に送って評価します。

menu にある他の commands も参照してください。

では、code を evaluate することと compile することにはどんな違いがあるのでしょうか。

### evaluation vs. compilation

compile と evaluate のどちらを選ぶかには、いくつか実用上の違いがあります。

ただし SBCL のような処理系では、REPL に code を書く場合や評価用 shortcut を使う場合でも、*明示的に別指定しない限り* 式は*常に compile* されます。

そうは言っても一般には、top-level forms は*compile* する方がよいです。理由は 2 つあります。

* top-level form を compile すると editor 内で warnings とエラーが highlight されますが、evaluation ではされません。
* SLIME は compiled forms の line-numbers を追跡しますが、top-level form を evaluate すると file line number information が失われます。これはその後の code navigation で問題になります。

`eval` は、top-level ではない個々の forms の結果を観察するのに今でも便利です。たとえば次の関数があるとします。


~~~lisp
(defun foo ()
  (let ((f (open "/home/mariano/test.lisp")))
    ...))
~~~

OPEN 式の末尾へ移動して評価（`C-x C-e`）し、結果を観察します。

```
=> #<SB-SYS:FD-STREAM for "file /mnt/e6b00b8f-9dad-4bf4-bd40-34b1e6d31f0a/home/marian/test.lisp" {1003AAAB53}>
```

また次の例では、cursor を最後の parentheses に置いて `C-x C-e` を押すと `let` を evaluate できます。

~~~lisp
(let ((n 20))
  (loop for i from 0 below n
     do (print i)))
~~~

REPL に numbers が出力されるはずです。

下の「REPL にコードを送る」と `C-c C-j` shortcut も参照してください。


### Debugging

debugging commands は独立した [debugging](debugging.html) chapter で扱います。

### Go to definition

任意のシンボルに cursor を置き、`M-.`（`slime-edit-definition`）を押すとその definition へ移動します。戻るには `M-,` を押します。

<a id="symbol--source--symbols-"></a>

### 任意のシンボルへ移動し、現在の source 内のシンボルを一覧する

`C-u M-.`（prefix 引数付きの `slime-edit-definition`、`M-- M-.` としても利用可能）を使うと、シンボルを autocomplete してそこへ navigate できます。

この command は cursor がシンボル上にあっても常にシンボルを尋ねます。load 済みの任意の definition で動作します。短い[demonstration video](https://www.youtube.com/watch?v=ZAEt73JHup8)があります。

これは、任意の Lisp シンボルに対して常に動く `imenu` completion のようなものだと考えられます。最大の威力を得るには [Slime's fuzzy completion][slime-fuzzy] も追加してください。

### Argument lists

関数上に cursor を置くと、SLIME はその signature を minibuffer に表示します。

よりよく見たい場合は、関数 name の後で `C-c C-s` を試してください。

たとえば、`with-open-file` の使い方を忘れたとします。これを書きます。

```lisp
(with-open-file
```

ここで `C-c C-s`（`slime-complete-form`）を押すと、次が得られます。

```lisp
(with-open-file (stream filespec :direction direction
                                 :element-type element-type
                                 :if-exists if-exists
                                 :if-does-not-exist if-does-not-exist
                                 :external-format external-format
                                 :class class
                         )
           body...)
```

これは source file（または REPL）に書き込まれます。

minibuffer には引数の default 値が表示されます。

### Documentation lookup

知っておくべき主な shortcut は次です。

- **C-c C-d d** はシンボルの documentation を新しいウィンドウに表示します（`describe` を使うのと同じ結果です）。

役立つかもしれないその他の bindings:

- **C-c C-d f** は関数を describe します
- **C-c C-d h** は web browser を開いて Common Lisp Hyper Spec（CLHS）のシンボル documentation を検索します。ただしシンボルにしか使えないため、さらに 2 つの bindings があります。
- **C-c C-d #** は reader マクロ用です
- **C-c C-d ~** は format directives 用です

help buffer は Slime extension [slime-doc-contribs](https://github.com/mmontone/slime-doc-contribs) で強化できます。見やすい buffer により多くの情報を表示し、documentation command に選択肢を追加します。

* **slime-help-package** は CL パッケージについての情報を表示します。exported 変数、コンディション、クラス、generic 関数、関数、マクロとその documentation をきれいに表示します。パッケージが何を提供するかを一目で見るのに優れています。
* **slime-help-system** は *system* について同じことをします。
* **slime-help-apropos-documentation** は documentation が "PATTERN" に一致するシンボルを表示します。関数を探すのに便利です。
* ほかにもあります。

![](assets/slime-help.png)


### Inspector

REPL から `(inspect 'symbol)` を呼ぶか、source file から `C-c I` で呼び出せます。

[documentation](https://slime.common-lisp.dev/doc/html/Inspector.html#Inspector) を読んで使い方を学んでください。`l` で前のオブジェクトに戻り、`*` で point のオブジェクトを copy する、などがあります。

### Macroexpand

マクロ call を macroexpand するには `C-c M-m` を使います。

### Warnings を navigate する

`C-c C-k` で file を compile and load する場合（または `C-c C-c` で単一関数を compile する場合）、compilation warnings があっても interactive debugger は出ません。source file の横に開く専用の "`*slime-compilation*`" Emacs buffer 内に warnings の一覧が表示されます。

warning の影響を受けた source の各行は赤で underline されます。

slime-compilation buffer の各 warning は clickable で、keybindings `M-n` と `M-p`（`slime-[next, previous]-note`）により次または前の warning（"notes" または "annotations" と呼ばれます）へ素早く移動できます。

通常の Emacs shortcut である [compilation-mode]( https://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation-Mode.html#Compilation-Mode) の C-x \`（Control-x と backquote）も使えます。

source の赤い annotations を見たくない場合は、`C-c M-c`、`slime-remove-notes` を使います。ただし自動で修正されるわけではありません。

code に style warnings しかない場合、それらは slime-compilation buffer に捕捉されますが、buffer は自動では pop up しません。

これらの keybindings はいつもどおり Emac's Slime menu から見つけられます。

Reference: [https://slime.common-lisp.dev/doc/html/Compilation.html#Compilation](https://slime.common-lisp.dev/doc/html/Compilation.html#Compilation)。


<a id="crossreferencing-symbol-"></a>

### Crossreferencing: 誰が呼び出し、参照し、シンボルを設定しているかを調べる

Slime には便利な cross-referencing 機能があります。たとえば、誰が関数を呼ぶか、誰がマクロを展開するか、global 変数がどこで使われているかを尋ねられます。

結果は新しい buffer に表示され、特定の entity を参照する場所が一覧されます。そこから Enter を押すと対応する source line へ移動できます。さらに興味深いことに、その行で **C-c C-c** を押すと point の場所を recompile できます。同様に **C-c C-k** はすべての references を recompile します。これはマクロ、inline 関数、constants を変更するときに便利です。

bindings は次のとおりです（Slime の menu にも表示されます）。

- **C-c C-w c**（`slime-who-calls`）関数の callers
- **C-c C-w m**（`slime-who-macroexpands`）マクロが展開される場所
- **C-c C-w r**（`slime-who-references`）global variable references
- **C-c C-w b**（`slime-who-bind`）global variable bindings
- **C-c C-w s**（`slime-who-sets`）global variable setters
- **C-c C-w a**（`slime-who-specializes`）シンボルに specialize されたメソッド
- **C-c >**（`slime-list-callees`）関数 body 内で呼ばれるすべての関数を一覧します。
- **C-c <**（`slime-list-callers`）指定関数を呼ぶすべての関数を一覧します。

`slime-asdf` contrib が有効な場合、**C-c C-w d**（`slime-who-depends-on`）は依存する ASDF systems を一覧します。

一般的な binding として、**M-?** または **M-_**（`slime-edit-uses`）は上記すべてを組み合わせ、あらゆる種類の references を一覧します。

### Systems interactions

Slime では、.asd file 内で通常の `C-c C-k` を使って compile and load し、その後 `ql:quickload`（または `asdf:load-system`）で実際に system をロードできます。SLIME は Lisp systems と対話するための、より interactive な commands を提供します。

- `M-x slime-load-system`: **ASDF system を選択**する prompt を表示します。ASDF が Common Lisp projects を見る場所から集めた projects を **autocompletion** 付きで選び、system を compile and load します。default system name は、現在の buffer の working directory で *.asd に一致する最初の file から取られます。
  - system name は .asd file name から推論されることに注意してください。内部で定義された本当の system name は異なる場合があります。
  - ASDF が Lisp systems をどこで探すかを理解するには、[getting started](getting-started.html) page の "How to load an existing project" section を読んでください。
- `M-x slime-open-system`: 指定 system のすべての source files 用に新しい buffer を開きます。
- `M-x slime-browse-system`: system の files を browse する Dired buffer を開きます。
- `M-x slime-rgrep-system`: system の base directory で `rgrep` を実行します。
- `M-x slime-isearch-system`: system の files に対して `isearch` を実行します。
- `M-x slime-query-replace-system`: ASDF system に対して `query-replace` を実行します。
- `M-x slime-save-system`: system に属するすべての files を保存します。
- `M-x slime-delete-system-fasls`: この system の cached .fasl files を削除します。

Sly users にはより多機能な `sly-load-system` command があり、現在の directory と親 directories で .asd file を検索します。


### REPL interactions

SLIME REPL では、`,` を押すと commands の prompt が出ます。利用可能な systems とパッケージに対して completion があります。例:

- `,load-system`
- `,reload-system`
- `,in-package`（.lisp file では `C-c M-p` も）
- `,restart-inferior-lisp`

ほかにも多数あります。通常、前節で示した interactive commands には REPL shortcut があります。

`slime-quicklisp` contrib を使うと、`,ql` でインストール可能な全 systems から system を autocomplete して install できます。

さらに [Quicklisp-systems](https://github.com/mmontone/quicklisp-systems) Slime extension を使うと、Emacs から Quicklisp systems を検索、browse、load できます。

### REPL にコードを送る

REPL に code を書けますが、source file から code と直接やり取りすることもできます。

**C-c C-j** は見ました。point の式を REPL に送り、評価します。

**C-c C-y**（`slime-call-defun`）: code を REPL に送ります（Sly にはありません）。

point が defun 内にあり、C-c C-y が押された場合（下では [] を cursor 位置の目印として使います）

~~~lisp
(defun foo ()
 nil[])
~~~


すると `(foo [])` が REPL に挿入され、追加引数を書いて実行できます。


`foo` が REPL のパッケージとは異なるパッケージにあった場合、`(package:foo )` または `(package::foo )` が挿入されます。

この機能は、書いたばかりの関数を test するのにとても便利です。

これは `defun` だけでなく、`defgeneric`、`defmethod`、`defmacro`、`define-compiler-macro` に対しても defun と同じように動作します。

`defvar`、`defparameter`、`defconstant` の場合は `[] *foo*` が挿入されます（シンボルの前に cursor が置かれるため、簡単に関数 call で包めます）。

defclass の場合: `(make-instance ‘class-name )`。

**debugger 内のフレームへの calls を挿入する**

SLDB のフレーム上で **C-y** を押すと、そのフレームへの call が REPL に挿入されます。例:

```
(/ 0) =>
…
1: (CCL::INTEGER-/-INTEGER 1 0)
…
```

**C-y** は `(CCL::INTEGER-/-INTEGER 1 0)` を挿入します。

（[Slime tips](https://slime-tips.tumblr.com/page/2) に感謝）


<a id="packages-"></a>

### パッケージを同期する

**C-c ~**（`slime-sync-package-and-default-directory`）: lisp file の buffer で実行すると、REPL の現在パッケージをその file のパッケージに変更し、REPL の current directory も file の parent directory に設定します。

<a id="symbols--export-"></a>

### シンボルを export する

Slime はパッケージに export declarations を追加する shortcut を提供します。実質的に一つまたは複数のシンボル(s) を export したり、逆に un-export したりできます。

`slime-package-fu` contrib の **C-c x**（*slime-export-symbol-at-point*）: point のシンボルを取り、対応する defpackage form の `:export` clause を変更します。またシンボルも export します。negative 引数（C-u C-c x）付きで呼ぶと、シンボルを `:export` から削除し unexport します。

**M-x slime-export-class** も同じことをしますが、accessors、コンストラクタなど、structure またはクラスによって定義されるシンボルが対象です。今のところ structures では SBCL と Clozure CL でのみ動作します。クラスは MOP によりどこでも動くはずです。

Customization

`defpackage` でシンボルを表示する style にはいくつかあり、default は uninterned シンボル（`#:foo`）を使います。これは変更できます。

keywords を使うには、Emacs init file に次を追加します。


~~~lisp
(setq slime-export-symbol-representation-function
      (lambda (n) (format ":%s" n)))
~~~

または strings:

~~~lisp
(setq slime-export-symbol-representation-function
 (lambda (n) (format "\"%s\"" (upcase n))))
~~~


### （任意）Hyper Spec（CLHS）を offline で参照する

[Common Lisp Hyper Spec](http://www.lispworks.com/documentation/common-lisp.html) は ANSI Common Lisp standard の公式 online version です。[starting points](http://www.lispworks.com/documentation/HyperSpec/Front/StartPts.htm) から browsing を始められます。短縮された [table of contents of highlights](http://www.lispworks.com/documentation/HyperSpec/Front/Hilights.htm)、[シンボル index](http://www.lispworks.com/documentation/HyperSpec/Front/Hilights.htm)、glossary、master index があります。

2023 年 1 月以降、Common Lisp Community Spec があります: [https://cl-community-spec.github.io/pages/index.html](https://cl-community-spec.github.io/pages/index.html)。これは specification の新しい web rendering です。より modern な rendering です。

* *search box* があります
* *syntax highlihgting* があります
* GitHub で host されており、変更する権利があります: [https://github.com/fonol/cl-community-spec](https://github.com/fonol/cl-community-spec)

公式 website には search bar がないため、CLHS 上のシンボルを他の tools ですばやく look-up したい場合は、次を使えます。

* Xach の website search utility: [https://www.xach.com/clhs?q=with-open-file](https://www.xach.com/clhs?q=with-open-file)
* l1sp.org website: [http://l1sp.org/search?q=with-open-file](http://l1sp.org/search?q=with-open-file)
* Duckduckgo または Brave Search の `!clhs` "bang" も使えます。

MacOS では [Dash](https://kapeli.com/dash)、GNU/Linux では [Zeal](https://zealdocs.org/)、Windows では [Velocity](https://velocity.silverlakesoftware.com/) を使って **CLHS を offline で browse**できます。

しかし Emacs からも offline で browse できます。CL パッケージをインストールし、Emacs 側を一つの command で設定します。

~~~lisp
(ql:quickload "clhs")
(clhs:install-clhs-use-local)
~~~

次を Emacs configuration に追加します。

~~~lisp
(load "~/quicklisp/clhs-use-local.el" 'noerror)
~~~

これで `C-c C-d h` を使って、point のシンボルを HyperSpec で look-up できます。browser が開きますが、URL が "file://home/" で始まることを見てください。local file を開いています。

他の commands も利用できます。

* `#'`（sharpsign-quote）や `(`（left-parenthesis）のような reader マクロを look-up したい場合は、`C-c C-d #` に bound された `M-x common-lisp-hyperspec-lookup-reader-macro` を使います。
* `~A` のような `format` directive を look-up するには、`C-c C-d ~` に bound された `M-x common-lisp-hyperspec-format` を使います。
  * もちろん、Emacs の minibuffer prompt で TAB-complete すれば利用可能な format directives をすべて見られます。
* glossary terms も look-up できます（たとえば "defun" ではなく "function" を look-up できます）。`C-c C-d g` に bound された `M-x common-lisp-hyperspec-glossary-term` を使います。


## Emacs で作業する

この section では、Lisp code 一般を扱うため、また common actions を行うために最も役立つ Emacs commands を学びます。

まず Emacs 組み込み documentation で道を見つける方法から始めます。学ぶべき skill が一つあるとすれば、これです。

Emacs の GUI と terminal interfaces の両方に menu があることを忘れないでください。利用可能な commands を発見する助けになります。見えない場合は、emacs configuration が隠していないことを確認してください。`M-x menu-bar-mode` で menu を表示できます。

### Built-in documentation

Emacs には組み込みチュートリアルと documentation が付属します。さらに、自己 documentation と自己発見性を備えた editor であり、introspection によって現在の keybindings、関数 documentation、available 変数、source code、チュートリアルなどを知ることができます。「x をするための shortcuts は何があるか」や「この keybinding は実際に何をするのか」といった疑問を持ったとき、答えはほぼ確実に Emacs の中で keystroke 一つ先にあります。Emacs で Emacs を滞りなく発見できるよう、いくつかの keybindings を覚えるべきです。

この topic の help はここにあります。

- [Help page: commands for asking Emacs about its commands](https://www.gnu.org/software/emacs/manual/html_node/emacs/Help.html#Help)

help keybindings は `C-h` または `F1` で始まります。重要なものは次です。

- `C-h k <keybinding>`: この keybinding はどの関数を呼ぶか？
- `C-h f <function name>`: この関数にはどの keybinding が関連付けられているか？
- `C-h a <topic>`: 指定された *topic* に name が一致する commands の一覧を表示します。keyword、keywords の list、正規表現を受け付けます。
- `C-h i`: Info page を表示します。major topics の menu です。

Emacs パッケージの中には、さらに多くの help を提供するものもあります。

<a id="help--discoverability-packages"></a>

### さらに help と discoverability パッケージ

key sequence を入力し始めたものの、完全には思い出せないことがあります。また、関連する他の keybindings が気になることもあります。そこで [which-key-mode](https://github.com/justbur/emacs-which-key) です。このパッケージは、入力した key(s) で始まる可能な keybindings をすべて表示します。

たとえば、`C-x` の下に便利な keybindings があることは知っているけれど、どれかを覚えていないとします。`C-x` と入力し、半秒待つだけで、which-key が利用可能なものをすべて表示します。

![](assets/emacs-which-key-minibuffer.png)

`C-h` でも試してみてください。

組み込み Emacs help の代替で、より多くの contextual information を提供する [Helpful](https://github.com/Wilfred/helpful) も参照してください。

<img src="assets/emacs-helpful.png" style="height: 450px" alt="The Emacs helpful package shows detailed information about a symbol."/>

<!-- pdf-include-start
![](assets/emacs-helpful.png)
   pdf-include-end -->


### Built-in tutorial

Emacs には独自のチュートリアルが付属しています。重要な keybindings と concepts を学ぶために一度見ておくとよいでしょう。

`M-x help-with-tutorial`（ここで `M-x` は `alt-x`）で呼び出します。



### Parentheses を編集する

Emacs にはもちろん、s-expressions を扱う組み込み commands があります。

#### s-expressions による Forward/Backward/Up/Down movement と selection

`C-M-f` と `C-M-b`（`forward-sexp` と `backward-sexp`）を使うと、point の s-expression の終端（始端）や、同じ level の次の式へ移動できます。`C-M-n` と `C-M-p`（next、previous）も似ています。

`C-M-u`（`backward-up-list`）と `C-M-d`（`down-list`）で s-expressions の tree を上下に移動します。

`C-M-a`（lisp-mode では `beginning-of-defun` または `slime-beginning-of-defun`）と `C-M-e`（`end-of-defun` または `slime-end-of-defun`）で top-level s-expression の始端（または終端）へ移動します。たとえば現在の関数 definition の先頭へ移動します。

sexp 全体を highlight するには `C-M-@` または `C-M-space`（どちらも `mark-sexp`）を使います。その後 `C-M-u` で selection を「上方向」に広げ、`C-M-d` で parentheses の一段下へ forward できます。`mark-sexp` を繰り返し押すこともできます。

`M-)`（`move-past-close-and-reindent`）を使うと、現在の lexical block の終端へ移動し、新しい行を作って indent します。

`C-M-t`（`transpose-sexps`）を使うと、point の s-expression を前の s-exp の前へ drag できます。

例:

```lisp
;; C-M-t を押し、異なる additions がどう動くかを観察します。

(defun c ()
  "another function"
  (let ((x 42))
    (+ x
       (+ 2 2)
     [](+ 3 3)  ; <-- cursor
       (+ 4 4))))

;; C-M-t =>

(defun c ()
  "another function"
  (let ((x 42))
    (+ x
       (+ 3 3)
       (+ 2 2)[]  ; <-- cursor moved too (now right before (+ 4 4)
       (+ 4 4))))
```

#### 行または region を comment する

`M-;` で comment を挿入するか region を comment し、`M-q` で text を整えます。

#### Parenthesis と s-expressions を削除する

point の前方にある pair of parenthesis を削除するには `M-x delete-pair` を使います。実際には pair になる任意のシンボル（double quotes、square brackets…）で動作します。

例:

~~~lisp
[](1 2 3)
;; M-x delete-pair =>
1 2 3
~~~

`C-M-k`（`kill-sexp`）と `C-M-backspace`（`backward-kill-sexp`）を使います（ただし注意: この keybinding は GNU/Linux で system を restart することがあります）。

たとえば point が `(progn` の前にある場合（[] を cursor の位置として使います）:

~~~lisp
(defun d ()
  (if t
      (+ 3 3)
     [](progn
        (+ 1 1)
        (if t
            (+ 2 2)
            (+ 3 3)))
      (+ 4 4)))
~~~

`C-M-k` を押すと、次になります。

~~~lisp
(defun d ()
  (if t
      (+ 3 3)
      []
      (+ 4 4)))
~~~

#### raise: s-expression を上へ移動する

現在の式を "raise" するには `M-x raise-sexp`（デフォルトでは unbound）を使います。これは一段上へ移動し、以前の式を消します。たとえば point が下の位置にある場合:

~~~lisp
(defun d ()
  (when t
    [](+ 3 3)
~~~

`raise-sexp` を呼ぶと、次になります。

~~~lisp
(defun d ()
  [](+ 3 3))
~~~

global key に bind できます。

~~~lisp
(keymap-global-set "M-+" #'raise-sexp) ;; M-+ originally unbound
~~~

#### s-expressions を indent する

Lisp forms の indentation は自動です。

TAB を押すと、誤って indent された code を indent します。たとえば `(+ 3 3)` form の先頭に point を置いて TAB を押します。

~~~lisp
(progn
(+ 3 3))
~~~

正しく次のようになります。

~~~lisp
(progn
  (+ 3 3))
~~~

point の form を re-indent するには `C-M-q`（`indent-sexp`）を使います。

~~~lisp
;; cursor を "(defun ..." の open parens に置き、
;; "C-M-q" を押して code を indent します:
[] (defun e ()
   "A badly indented function."
 (let ((x 20))
 (print x)))
~~~

次のようになります。

```lisp
(defun e ()
  "A correctly indented function."
  (let ((x 20))
    (print x)))
```

現在の関数 definition を indent するには `C-c M-q`（`slime-reindent-defun`）を使います。

~~~lisp
;; cursor を function 内のどこかに置き、
;; "C-M-q" を押して code を indent します:
(defun e ()
"A badly indented function."
(let ((x 20))
(loop for i from 0 to x
do (loop for j from 0 below 10
do (print j))
(if (< i 10)
(let ((z nil) )
(setq z (format t "x=~d" i))
(print z))))))

;; This is the result:

(defun e ()
  "A badly indented function (now correctly indented)."
  (let ((x 20))
    (loop for i from 0 to x
       do (loop for j from 0 below 10
             do (print j))
         (if (< i 10)
             (let ((z nil) )
               (setq z (format t "x=~d" i))
               (print z))))))
~~~

region を select して `M-x indent-region` を呼ぶこともできます。

#### Parentheses を開閉する

Lisp の parentheses を管理するのに、多くの keybindings（またはまったく）必要ないかもしれません。`M-x show-paren-mode` だけでも非常に便利です（下記参照）。とはいえ、役立つ keybindings もあります。

Slime REPL では、`C-return` または `M-return`（`slime-repl-closing-return`）で残りの parenthesis を閉じて input 文字列を evaluate できることを知っていましたか。

source files では、必要な数の closing parenthesis を挿入するために `C-c C-]`（`slime-close-all-parens-in-sexp`）を使えます。

例:

```lisp
(defun example ()
  (when t
    (when (+ 1 2)
      nil[]  ;; <--- point

;; C-c C-]
;; =>

(defun example ()
  (when t
    (when (+ 1 2)
      nil)))
         ^^^ 3 closing ) were inserted.
```

files では、`M-(` で pair of parenthesis（`()`）を挿入できます。同じ keybinding に prefix 引数 `C-u M-(` を付けると、cursor の前の式を pair of parens で囲みます。

たとえば最初の paren の前に cursor がある状態から始めます。

~~~lisp
[](- 2 2)
~~~

`C-u M-(` を押して parens で囲みます。

~~~lisp
([](- 2 2))
;; now write anything.
(zerop (- 2 2))
~~~

numbered prefix 引数（`C-u 2 M-(`）を使うと、その数の s-expressions を wrap します。

さらに、malformed s-exps を見つけるには `M-x check-parens` を使います。

parens の利用を簡単にする追加パッケージもあります。

- `M-x show-paren-mode` は組み込み Emacs mode で、対応する parenthesis の可視化を toggle します。有効にすると、paren 上に cursor を置いたとき対応する paren が見えます。Emacs init file で `(show-paren-mode t)` により初期化できます。global minor mode です（すべての buffers、すべての languages で動作します）。
 - **有効にすることを強く勧めます**。
- evil-mode（vim layer）が有効な場合、`%` key で matching paren に移動できます。
- `M-x electric-pair-mode` は組み込み Emacs mode です。有効にすると、open parenthesis を入力したとき対応する closing parenthesis を自動挿入し、その逆も行います（brackets なども同様）。region が active の場合、parentheses（brackets など）は region の周りに挿入されます。
- [Paredit (animated guide)](http://danmidwood.com/content/2014/11/21/animated-paredit.html) を使うと parentheses を自動で pair 挿入できます。
- または [lispy-mode](https://github.com/abo-abo/lispy) もあります。Paredit のようなものですが、cursor が parentheses の直前または直後にあるときだけ key が action を trigger します。

<a id="structured-editing--packages"></a>

### （任意）Structured editing のパッケージ

組み込み Emacs commands と modes（`show-paren-mode` は必須です。上記参照）に加えて、parens や indentation の balance を保つ助けになるパッケージがさらにあります。下の list は、[history of Lisp editing](https://github.com/shaunlebron/history-of-lisp-editing) による extension の年代順にある程度並べています。

- [Paredit](https://www.emacswiki.org/emacs/ParEdit) - Paredit は classic です。must-have commands（move、kill、split、join a sexp など）を定義します。
  ([visual tutorial](http://danmidwood.com/content/2014/11/21/animated-paredit.html))
- [Smartparens](https://github.com/Fuco1/smartparens) - Smartparens は parens だけでなく pair になるすべてのもの（html tags など）を扱うため、non-lispy languages 向けの機能もあります。
- [Lispy](https://github.com/abo-abo/lispy) - Lispy は Paredit を再考し、point position に応じて動作する最短の bindings（多くは 1 key）を目指しています。
- [Paxedit](https://github.com/promethial/paxedit) - Paxedit は context（シンボル内、sexp 内など）に基づく commands を追加し、whitespace cleanup と context refactoring に力を入れています。
- [Parinfer](http://shaunlebron.github.io/parinfer/) - Parinfer は indentation に応じて parens を自動修正するか、その逆を行います（または両方）。

個人的には、まず組み込み関数をよく知り、その後有名な Paredit や evil users 向けの Lispy から着想を得ることを勧めます。さらに詳しくは [Wikemacs](http://wikemacs.org/wiki/Lisp_editing) を参照してください。


### Code を隠す/表示する

`C-x n n`（narrow-to-region）と `C-x n w` を使って widen back します。

external パッケージによる [code folding](http://wikemacs.org/wiki/Folding) も参照してください。

### Search and replace

#### isearch forward/backward、regexp searches、search/replace

`C-s` は forward incremental search を行います。たとえば search 文字列の各 key を入力するたびに source file が最初の match に向けて検索されます。unique 文字だけを入力すればよいため、特定の text をかなり素早く見つけられます。同じ search 文字を使った repeat searches は、`C-s` を繰り返し押すことで行えます。

`C-r` は backward incremental search を行います。

`C-s RET` と `C-r RET` はどちらも通常の文字列 search を行います（それぞれ forward と backward）。

`C-M-s` と `C-M-r` はどちらも 正規表現 search を行います（それぞれ forward と backward）。

`M-%` は search/replace を行い、`C-M-%` は 正規表現 search/replace を行います。


#### Occurrences を探す（occur、grep）

`M-x grep`、`rgrep`、`occur` などを使います。

interactive versions として [helm-swoop](http://wikemacs.org/wiki/Helm-swoop)、helm-occur、[ag.el](https://github.com/Wilfred/ag.el) も参照してください。


## Questions/Answers

### Emacs Lisp vs Common Lisp

Common Lisp 用に Emacs を Slime または Sly と一緒に使うために、Emacs Lisp を書く必要はありません。

ただし Emacs Lisp を学ぶことは役に立ちますし、CL と似ています（しかし異なります）。

*   Dynamic scope が至るところにあります
*   reader（または reader-related）関数がありません
*   CL でサポートされるすべての types をサポートしているわけではありません
*   CLOS の実装は不完全です（add-on の EIEIO パッケージによる）
*   numerical tower support がありません

Emacs Lisp 学習に役立つ resources:

*   [An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/eintr.html)
*   [Writing GNU Emacs Extensions](http://www.oreilly.com/catalog/gnuext/)
*   [Wikemacs](http://wikemacs.org/wiki/Category:Emacs_Lisp)

### LSP（Language Server Protocol）はどうか？

Common Lisp 向けの LSP サーバーとクライアント ports は存在しますが、高品質な IDE integration を得るためにそれらが*必要*なわけではありません。実際、Slime/Swank は LSP のような client/server architecture に従っていますが、Slime は LSP より何十年も前からあり、今でも LSP より lispers 向けにずっと多くの機能を提供しています。

### utf-8 encoding

init file に次を設定したくなるかもしれません。

~~~lisp
(set-language-environment "UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
~~~

Sly では次のようにします。

~~~lisp
(setf sly-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)
        ))
~~~

これにより、SLIME で評価する files に non-ascii 文字があるときの `ascii stream decoding error` を避けられます。


### Default cut/copy/paste keybindings

*私は text の copy and paste に C-c、C-v などを使うことに慣れすぎていて、default Emacs shortcuts がまったくしっくりきません。*

幸い、解決策があります。[cua-mode](http://www.emacswiki.org/cgi-bin/wiki.pl?CuaMode) を install すれば、これらの shortcuts を使い続けられます。

~~~lisp
;; C-z=Undo, C-c=Copy, C-x=Cut, C-v=Paste (needs cua.el)
(require 'cua) (CUA-mode t)
~~~


## Appendix

### Slime REPL shortcuts すべて

REPL で動作するすべての Slime shortcuts の reference です。

見るには REPL に移動し、`C-h m` と入力して Slime REPL map section へ進みます。


```
REPL mode defined in ‘slime-repl.el’:
Major mode for interacting with a superior Lisp.
key             binding
---             -------

C-c             Prefix Command
C-j             slime-repl-newline-and-indent
RET             slime-repl-return
C-x             Prefix Command
ESC             Prefix Command
SPC             slime-space
  (that binding is currently shadowed by another mode)
,               slime-handle-repl-shortcut
DEL             backward-delete-char-untabify
<C-return>      slime-repl-closing-return
<C-down>        slime-repl-forward-input
<C-up>          slime-repl-backward-input
<return>        slime-repl-return

C-x C-e         slime-eval-last-expression

C-c C-c         slime-interrupt
C-c C-n         slime-repl-next-prompt
C-c C-o         slime-repl-clear-output
C-c C-p         slime-repl-previous-prompt
C-c C-s         slime-complete-form
C-c C-u         slime-repl-kill-input
C-c ESC         Prefix Command
C-c I           slime-repl-inspect

M-RET           slime-repl-closing-return
M-n             slime-repl-next-input
M-p             slime-repl-previous-input
M-r             slime-repl-previous-matching-input
M-s             slime-repl-next-matching-input

C-c C-z         run-lisp
  (that binding is currently shadowed by another mode)

C-M-x           lisp-eval-defun

C-M-q           indent-sexp

C-c M-e         macrostep-expand
C-c M-i         slime-fuzzy-complete-symbol
C-c M-o         slime-repl-clear-buffer
```

### その他すべての Slime shortcuts

ここで示した以上のものがあります。Slime には、point のシンボルの関数 definition を disassemble したり、inspector の navigate 方法を学んだり、関数 profiling を toggle したり、indentation や completion strategies を学んだり、複数 Lisp connections を使ったり、[presentations を操作](https://slime.common-lisp.dev/doc/html/Presentations.html#Presentations)したりする shortcuts があります。

Slime mode によって定義される default keybindings は次のとおりです。

見るには .lisp file に移動し、`C-h m` と入力して Slime section へ進みます。

```
Commands to compile the current buffer’s source file and visually
highlight any resulting compiler notes and warnings:
C-c C-k	- Compile and load the current buffer’s file.
C-c M-k	- Compile (but not load) the current buffer’s file.
C-c C-c	- Compile the top-level form at point.

Commands for visiting compiler notes:
M-n	- Goto the next form with a compiler note.
M-p	- Goto the previous form with a compiler note.
C-c M-c	- Remove compiler-note annotations in buffer.

Finding definitions:
M-.
- Edit the definition of the function called at point.
M-,
- Pop the definition stack to go back from a definition.

Documentation commands:
C-c C-d C-d	- Describe symbol.
C-c C-d C-a	- Apropos search.
C-c M-d	- Disassemble a function.

Evaluation commands:
C-M-x	- Evaluate top-level from containing point.
C-x C-e	- Evaluate sexp before point.
C-c C-p	- Evaluate sexp before point, pretty-print result.

Full set of commands:
key             binding
---             -------

C-c             Prefix Command
C-x             Prefix Command
ESC             Prefix Command
SPC             slime-space

C-c C-c         slime-compile-defun
C-c C-j         slime-eval-last-expression-in-repl
C-c C-k         slime-compile-and-load-file
C-c C-s         slime-complete-form
C-c C-y         slime-call-defun
C-c ESC         Prefix Command
C-c C-]         slime-close-all-parens-in-sexp
C-c x           slime-export-symbol-at-point
C-c ~           slime-sync-package-and-default-directory

C-M-a           slime-beginning-of-defun
C-M-e           slime-end-of-defun
M-n             slime-next-note
M-p             slime-previous-note

C-M-,           slime-previous-location
C-M-.           slime-next-location

C-c TAB         completion-at-point
C-c RET         slime-expand-1
C-c C-p         slime-pprint-eval-last-expression
C-c C-u         slime-undefine-function
C-c ESC         Prefix Command

C-c C-b         slime-interrupt
C-c C-d         slime-doc-map
C-c C-e         slime-interactive-eval
C-c C-l         slime-load-file
C-c C-r         slime-eval-region
C-c C-t         slime-toggle-fancy-trace
C-c C-v         Prefix Command
C-c C-w         slime-who-map
C-c C-x         Prefix Command
C-c C-z         slime-switch-to-output-buffer
C-c ESC         Prefix Command
C-c :           slime-interactive-eval
C-c <           slime-list-callers
C-c >           slime-list-callees
C-c E           slime-edit-value
C-c I           slime-inspect

C-x C-e         slime-eval-last-expression
C-x 4           Prefix Command
C-x 5           Prefix Command

C-M-x           slime-eval-defun
M-,             slime-pop-find-definition-stack
M-.             slime-edit-definition
M-?             slime-edit-uses
M-_             slime-edit-uses

C-c M-c         slime-remove-notes
C-c M-e         macrostep-expand
C-c M-i         slime-fuzzy-complete-symbol
C-c M-k         slime-compile-file
C-c M-q         slime-reindent-defun

C-c M-m         slime-macroexpand-all

C-c C-v C-d     slime-describe-presentation-at-point
C-c C-v TAB     slime-inspect-presentation-at-point
C-c C-v C-n     slime-next-presentation
C-c C-v C-p     slime-previous-presentation
C-c C-v C-r     slime-copy-presentation-at-point-to-repl
C-c C-v C-w     slime-copy-presentation-at-point-to-kill-ring
C-c C-v ESC     Prefix Command
C-c C-v SPC     slime-mark-presentation
C-c C-v d       slime-describe-presentation-at-point
C-c C-v i       slime-inspect-presentation-at-point
C-c C-v n       slime-next-presentation
C-c C-v p       slime-previous-presentation
C-c C-v r       slime-copy-presentation-at-point-to-repl
C-c C-v w       slime-copy-presentation-at-point-to-kill-ring
C-c C-v C-SPC   slime-mark-presentation

C-c C-w C-a     slime-who-specializes
C-c C-w C-b     slime-who-binds
C-c C-w C-c     slime-who-calls
C-c C-w RET     slime-who-macroexpands
C-c C-w C-r     slime-who-references
C-c C-w C-s     slime-who-sets
C-c C-w C-w     slime-calls-who
C-c C-w a       slime-who-specializes
C-c C-w b       slime-who-binds
C-c C-w c       slime-who-calls
C-c C-w d       slime-who-depends-on
C-c C-w m       slime-who-macroexpands
C-c C-w r       slime-who-references
C-c C-w s       slime-who-sets
C-c C-w w       slime-calls-who

C-c C-d C-a     slime-apropos
C-c C-d C-d     slime-describe-symbol
C-c C-d C-f     slime-describe-function
C-c C-d C-g     common-lisp-hyperspec-glossary-term
C-c C-d C-p     slime-apropos-package
C-c C-d C-z     slime-apropos-all
C-c C-d #       common-lisp-hyperspec-lookup-reader-macro
C-c C-d a       slime-apropos
C-c C-d d       slime-describe-symbol
C-c C-d f       slime-describe-function
C-c C-d g       common-lisp-hyperspec-glossary-term
C-c C-d h       slime-documentation-lookup
C-c C-d p       slime-apropos-package
C-c C-d z       slime-apropos-all
C-c C-d ~       common-lisp-hyperspec-format
C-c C-d C-#     common-lisp-hyperspec-lookup-reader-macro
C-c C-d C-~     common-lisp-hyperspec-format

C-c C-x c       slime-list-connections
C-c C-x n       slime-next-connection
C-c C-x p       slime-prev-connection
C-c C-x t       slime-list-threads

C-c M-d         slime-disassemble-symbol
C-c M-p         slime-repl-set-package

C-x 5 .         slime-edit-definition-other-frame

C-x 4 .         slime-edit-definition-other-window

C-c C-v M-o     slime-clear-presentations
```

[slime-fuzzy]: https://common-lisp.net/project/slime/doc/html/Fuzzy-Completion.html

## 関連項目

- [SLIME's documentation](https://slime.common-lisp.dev/doc/html/)
- **[Slime video チュートリアル](https://www.youtube.com/watch?v=sBcPNr1CKKw)**（作者の channel も素晴らしい内容が豊富です）
- Marco Baringer の [Slime チュートリアル](https://www.youtube.com/watch?v=NUpAvqa5hQw)
- [Common Lisp REPL exploration guide](https://bnmcgn.github.io/lisp-guide/lisp-exploration.html)。REPL で道を見つけるための、簡潔で curated な highlights 集です。
- [Emacs4CL](https://github.com/susam/emacs4cl)。vanilla Emacs を Common Lisp programming 用に設定するための小さな DIY kit です。
- [slime-star](https://github.com/mmontone/slime-star)。SLIME extensions の collection です。
  * doc contribs: documentation を表示する、より豊かな slime-help と slime-info buffers。
  * Quicklisp systems: REPL から Quicklisp systems を load する autocompletion。
  * quicksearch integration: Quicklisp、Github、Cliki で Common Lisp repositories を検索。
  * Slime breakpoints: code annotation なしで breakpoints を visual に設定し、code を step through するボタンを得る。
  * Quicklisp apropos: Quicklisp ライブラリ全体の "apropos"。
  * Slime critic: Slime critic に code をやさしく critique してもらう。
  * interactive print and trace buffers
  * output ストリーム用の dedicated Emacs buffers
  * ANSICL specification への Emacs Info format での access。
  * Lisp system browser: Common Lisp 用の（work in progress な）Smalltalk-like system browser。available パッケージとその関数、変数、マクロ、クラス、generic 関数を browse するための different panes を得られます。
- [Slime tips](https://github.com/lisp-tips/lisp-tips/issues?q=state%3Aopen%20label%3A%22slime%22)
