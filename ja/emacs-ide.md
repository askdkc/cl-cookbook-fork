---
title: Emacs を IDE として使う
---

このページでは、[Emacs](https://www.gnu.org/software/emacs/) を Lisp IDE として使うための導入を説明します。

大まかに 3 つの節に分けています。Slime（または Sly）のインストール方法、使い方、そして Lisp コードを扱うための Emacs 組み込みコマンドに関する補足情報です。

![Emacs の紹介画像](assets/emacs-teaser.png)

<!-- todo: C-u M-x slime and its configuration to work with multiple implementations -->

ところで、なぜ Emacs を使うのでしょうか。

* Emacs は Lisp コードを扱うための非常に優れたサポートを備えています
  * Slime-Swank の client-server モデルは LSP より前からあり、Common Lisp との統合ではずっと豊かです。
* ほぼすべての OS とすべての CL 処理系で動作し、軽量です
* Emacs はおそらく今後もあり続けます
* Emacs はマウスありでもなしでもうまく使えます
* Emacs は GUI モードでもターミナルでもうまく使えます
* 組み込みの tree-sitter と LSP サポート
* 優れた vim モード
* [Org-mode](http://orgmode.org) があるから
* [Magit](https://magit.vc/) があるから
* [Emacs Rocks !](http://emacsrocks.com) があるから
* 大きなユーザー層と膨大な拡張機能: [awesome-emacs](https://github.com/emacs-tw/awesome-emacs)。

## SLIME: Superior Lisp Interaction Mode for Emacs

[SLIME](http://common-lisp.net/project/slime/) は CL プログラミングの定番のメジャーモードです。強力で統合された、非常に対話的な開発環境にするための機能を多数備えています。

* 実行中の image に接続された REPL を Emacs 内で提供します
* Common Lisp のデバッガを Emacs インターフェイスと統合します
* シンボルの補完を提供します
* コードの評価、コンパイル、マクロ展開
* 相互参照
* ブレーク、ステップ実行、トレース
* 定義へのジャンプ
* オンラインドキュメント
* 関数、シンボル、システム名、ドキュメントのあいまい検索
* 対話的なオブジェクトインスペクタ
* 一般的な Common Lisp 処理系をすべてサポートします
* 複数の接続と複数のリスナーバッファ（mrepl）
* MELPA からすぐ利用できます
* 活発に保守されています。


## SLY: Sylvester the Cat's Common Lisp IDE

[SLY](https://github.com/joaotavora/sly) は SLIME の fork で、次の変更と機能を含みます。

* Emacs 自身の高機能な comint.el に基づく、全面的に再設計された REPL。あらゆるものを REPL にコピーできます。
* [Stickers](https://joaotavora.github.io/sly/#Stickers) 機能による、コードへのライブな注釈。
* オブジェクトをハイライトし、REPL のセッションを通じて安定して残る、番号付きの後方参照。
* 初期段階ながら機能する試作版の、可搬な注釈ベースのステッパ。
* 複数の REPL と複数のインスペクタ。
* 正規表現に対応した `M-x sly-apropos`。
* Contribs は第一級の SLY の構成要素で、デフォルトで有効、必要に応じて ASDF でロードされます。
  * [NAMED-READTABLES](https://github.com/joaotavora/sly-named-readtables) 対応
  * [macrostep.el](https://github.com/joaotavora/sly-macrostep)
  * [Quicklisp](https://github.com/joaotavora/sly-quicklisp)
  * [ASDF](https://github.com/mmgeorge/sly-asdf)
  * [Evaluation Overlays](https://git.sr.ht/~fosskers/sly-overlay)

一方で、いくつか不足や違いも見つかりました。

* Sly には `slime-call-defun`（C-c C-y）相当がありません。
  * これは残念です。私たちはかなり慣れているからです。下の「REPL にコードを送る」を参照してください。
* `slime-profile-*` 関数がありません（`sb-prof` の contrib がありません）。
* REPL に切り替えるショートカット `C-c C-z` は Slime のものと挙動が異なります（ソースファイルを残して横に REPL を表示する代わりに、ソースファイルを REPL ウィンドウで置き換えることがあります）。

Sly は [Doom Emacs](https://github.com/doomemacs/doomemacs/) にデフォルトで同梱されています。

## SLIME または SLY をインストールする

### 手動

Ubuntu では、SLIME は Emacs と SBCL と一緒に簡単にインストールできます。

    sudo apt install emacs slime sbcl

それ以外では、次のコードを `~/.emacs.d/init.el` ファイルに追加して SLIME をインストールします。

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

SLIME はかなりモジュール化されており、デフォルトでは最低限（SLIME REPL すら含まない）しか有効にならないため、次のようにより多くの機能を有効にしたくなるかもしれません。

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

詳しくは[ドキュメント](https://common-lisp.net/project/slime/doc/html/)を参照してください（Info ページとしても利用できます）。

これで、前述のとおり `M-x slime` や `M-x slime-connect` で SLIME を実行できます。

関連項目:

- [Portacle](https://shinmera.github.io/portacle/) - Emacs、Slime、SBCL、git、必要な拡張機能を同梱した、可搬でマルチプラットフォームな CL 開発環境。手軽に始められる方法です。
  - ただし Portacle は現在古く、保守されていません。Emacs 27.1 を含んでおり、新しい MacOS では実行が面倒かもしれません。自己責任です。それでも使える場合はあり、更新の取り組みに参加できます。
* [emacs4cl](https://github.com/susam/emacs4cl) - 新規ユーザが素早く始めるための、チュートリアル付きの最小限の Emacs 設定。

### Doom Emacs

[Doom Emacs](https://github.com/doomemacs/doomemacs/) は人気の Emacs 設定です。Sly の統合を簡単に有効にできます。


<a id="slime-fancy--contrib-packages"></a>

### SLIME fancy と contrib パッケージ

SLIME の機能はパッケージといわゆる [contrib モジュール](https://common-lisp.net/project/slime/doc/html/Contributed-Packages.html) に分かれており、追加機能を使うにはロードする必要があります。前述の `slime-fancy` には次が含まれます。

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

SLIME には [Helm-SLIME](https://github.com/emacs-helm/helm-slime) のような便利な拡張機能もあります。主な機能は次のとおりです。

- あいまい補完
- REPL と接続の一覧
- REPL 履歴のあいまい検索
- _apropos_ ドキュメントのあいまい検索


## SLIME（または SLY）で作業する

最初にやりたくなることの一つは、Lisp コードをコンパイルしてロードすることです。関数上で `C-c C-c`、またはファイル全体をコンパイルするには `C-c C-k` を使います。しかしそれだけではありません。続きを読んでください。

ここでは SLIME の関数名を示します。多くの場合 SLY でも似ています。

### ちょっとしたコツ: Emacs のメニューを使う

このページの情報は多くて圧倒されるかもしれませんが、ここで扱うコマンドやキーバインドは Emacs の Slime メニューの下で簡単に見つけられます。そのためメニューは*無効にしない*ことを勧めます。とても便利です。

見えない場合は `M-x menu-bar-mode RET` を呼び出します。

ターミナル版 Emacs（`emacs -nw`）では、`M-x menu-bar-open` でメニューを開けます。これはデフォルトで `f10` に割り当てられています。また、マウスが有効ならマウスも使えます（`M-:` または `*scratch*` バッファで `(xterm-mouse-mode +1)` を評価します）。

![](assets/slime-menu.png "Emacs' SLIME menu lists all available commands and keybindings.")


### コード補完

SLIME でシンボルを補完するには、組み込みの `C-c TAB` を使います。[company-mode](http://company-mode.github.io/) を使うとツールチップも得られます。

![](assets/emacs-company-elisp.png "Lisp symbols completion with company-mode tooltips.")

**REPL** では単に **TAB** です。

ほかの開いているバッファにある任意の文字列を補完するには、`M-/` に割り当てられた Emacs の hippie-expand を使います。

### SLIME で Lisp を評価・コンパイルする

**バッファ**全体をコンパイルするには `C-c C-k`（`slime-compile-and-load-file`）を押します。

**リージョン**は `M-x slime-compile-region` でコンパイルします。

**defun** はカーソルをその中に置き、`C-c C-c`（`slime-compile-defun`）を押してコンパイルします。

コードをコンパイルしたら、たとえば REPL で試せます。


コンパイルではなく**評価**するには:

- ポイントの前の **sexp** を評価するには、閉じ括弧の後にカーソルを置いて `C-x C-e`（`slime-eval-last-expression`）を押します。結果はミニバッファに表示されます。
- 同様に、`C-c C-p`（`slime-pprint-eval-last-expression`）を使うとポイント前の式を評価して整形表示します。結果は新しい "slime-description" バッファに表示されます。
- `M-x slime-eval-print-last-expression`（デフォルトでは未割り当て）を使うと、結果を同じファイルのカーソル下に出力します。
- リージョンは `C-c C-r` で評価します。
- defun は `C-M-x` で評価します。
- `C-c C-e`（`slime-interactive-eval`）を入力すると、現在のコンテキストで評価するコードを尋ねるプロンプトが出ます。結果はミニバッファに表示されます。前置引数付きなら、結果を現在のバッファに挿入します。
- 式の閉じ括弧の後にカーソルがあるとき、`C-c C-j`（`slime-eval-last-expression-in-repl`）を入力すると、この式を REPL に送って評価します。

メニューにある他のコマンドも参照してください。

では、コードを評価することとコンパイルすることにはどんな違いがあるのでしょうか。

### 評価とコンパイルの違い

コンパイルと評価のどちらを選ぶかには、いくつか実用上の違いがあります。

ただし SBCL のような処理系では、REPL にコードを書く場合や評価用ショートカットを使う場合でも、*明示的に別指定しない限り* 式は*常にコンパイル*されます。

そうは言っても一般には、トップレベルのフォームは*コンパイル*する方がよいです。理由は 2 つあります。

* トップレベルのフォームをコンパイルするとエディタ内で警告とエラーがハイライトされますが、評価ではされません。
* SLIME はコンパイル済みフォームの行番号を追跡しますが、トップレベルのフォームを評価するとファイルの行番号情報が失われます。これはその後のコード移動で問題になります。

`eval` は、トップレベルではない個々のフォームの結果を観察するのに今でも便利です。たとえば次の関数があるとします。


~~~lisp
(defun foo ()
  (let ((f (open "/home/mariano/test.lisp")))
    ...))
~~~

OPEN 式の末尾へ移動して評価（`C-x C-e`）し、結果を観察します。

```
=> #<SB-SYS:FD-STREAM for "file /mnt/e6b00b8f-9dad-4bf4-bd40-34b1e6d31f0a/home/marian/test.lisp" {1003AAAB53}>
```

また次の例では、カーソルを最後の括弧に置いて `C-x C-e` を押すと `let` を評価できます。

~~~lisp
(let ((n 20))
  (loop for i from 0 below n
     do (print i)))
~~~

REPL に数値が出力されるはずです。

下の「REPL にコードを送る」と `C-c C-j` のショートカットも参照してください。


### デバッグ

デバッグ用のコマンドは独立した [デバッグ](debugging.html) の章で扱います。

### 定義へ移動する

任意のシンボルにカーソルを置き、`M-.`（`slime-edit-definition`）を押すとその定義へ移動します。戻るには `M-,` を押します。

<a id="symbol--source--symbols-"></a>

### 任意のシンボルへ移動し、現在のソース内のシンボルを一覧する

`C-u M-.`（前置引数付きの `slime-edit-definition`、`M-- M-.` としても利用可能）を使うと、シンボルを自動補完してそこへ移動できます。

このコマンドはカーソルがシンボル上にあっても常にシンボルを尋ねます。ロード済みの任意の定義で動作します。短い[デモ動画](https://www.youtube.com/watch?v=ZAEt73JHup8)があります。

これは、任意の Lisp シンボルに対して常に動く `imenu` の補完のようなものだと考えられます。最大の威力を得るには [Slime のあいまい補完][slime-fuzzy] も追加してください。

### 引数リスト

関数上にカーソルを置くと、SLIME はそのシグネチャをミニバッファに表示します。

よりよく見たい場合は、関数名の後で `C-c C-s` を試してください。

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

これはソースファイル（または REPL）に書き込まれます。

ミニバッファには引数のデフォルト値が表示されます。

### ドキュメントの参照

知っておくべき主なショートカットは次です。

- **C-c C-d d** はシンボルのドキュメントを新しいウィンドウに表示します（`describe` を使うのと同じ結果です）。

役立つかもしれないその他の割り当て:

- **C-c C-d f** は関数を説明します
- **C-c C-d h** は Web ブラウザを開いて Common Lisp Hyper Spec（CLHS）のシンボルのドキュメントを検索します。ただしシンボルにしか使えないため、さらに 2 つの割り当てがあります。
- **C-c C-d #** は reader マクロ用です
- **C-c C-d ~** は format ディレクティブ用です

ヘルプバッファは Slime の拡張 [slime-doc-contribs](https://github.com/mmontone/slime-doc-contribs) で強化できます。見やすいバッファにより多くの情報を表示し、ドキュメント表示コマンドに選択肢を追加します。

* **slime-help-package** は CL パッケージについての情報を表示します。エクスポートされた変数、コンディション、クラス、総称関数、関数、マクロとそのドキュメントをきれいに表示します。パッケージが何を提供するかを一目で見るのに優れています。
* **slime-help-system** は *システム* について同じことをします。
* **slime-help-apropos-documentation** はドキュメントが "PATTERN" に一致するシンボルを表示します。関数を探すのに便利です。
* ほかにもあります。

![](assets/slime-help.png)


### インスペクタ

REPL から `(inspect 'symbol)` を呼ぶか、ソースファイルから `C-c I` で呼び出せます。

[ドキュメント](https://slime.common-lisp.dev/doc/html/Inspector.html#Inspector) で使い方を確認してください。たとえば、`l` で前のオブジェクトに戻り、`*` でポイント位置のオブジェクトをコピーできます。

### マクロ展開

マクロの呼び出しを展開するには `C-c M-m` を使います。

### 警告の間を移動する

`C-c C-k` でファイルをコンパイルしてロードする場合（または `C-c C-c` で単一関数をコンパイルする場合）、コンパイル時の警告があっても対話デバッガは出ません。ソースファイルの横に開く専用の "`*slime-compilation*`" Emacs バッファ内に警告の一覧が表示されます。

警告の影響を受けたソースの各行は赤で下線が引かれます。

slime-compilation バッファの各警告はクリックでき、キーバインド `M-n` と `M-p`（`slime-[next, previous]-note`）により次または前の警告（"notes" または "annotations" と呼ばれます）へ素早く移動できます。

通常の Emacs のショートカットである [compilation-mode]( https://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation-Mode.html#Compilation-Mode) の C-x \`（Control-x とバッククォート）も使えます。

ソースの赤い注釈を見たくない場合は、`C-c M-c`、`slime-remove-notes` を使います。ただし自動で修正されるわけではありません。

コードにスタイル警告しかない場合、それらは slime-compilation バッファに捕捉されますが、バッファは自動ではポップアップしません。

これらのキーバインドはいつもどおり Emacs の Slime メニューから見つけられます。

参考: [https://slime.common-lisp.dev/doc/html/Compilation.html#Compilation](https://slime.common-lisp.dev/doc/html/Compilation.html#Compilation)。


<a id="crossreferencing-symbol-"></a>

### 相互参照: 誰が呼び出し、参照し、シンボルを設定しているかを調べる

Slime には便利な相互参照機能があります。たとえば、誰が関数を呼ぶか、誰がマクロを展開するか、グローバル変数がどこで使われているかを尋ねられます。

結果は新しいバッファに表示され、特定の対象を参照する場所が一覧されます。そこから Enter を押すと対応するソース行へ移動できます。さらに興味深いことに、その行で **C-c C-c** を押すとポイントの場所を再コンパイルできます。同様に **C-c C-k** はすべての参照を再コンパイルします。これはマクロ、インライン関数、定数を変更するときに便利です。

割り当ては次のとおりです（Slime のメニューにも表示されます）。

- **C-c C-w c**（`slime-who-calls`）関数の呼び出し元
- **C-c C-w m**（`slime-who-macroexpands`）マクロが展開される場所
- **C-c C-w r**（`slime-who-references`）グローバル変数の参照
- **C-c C-w b**（`slime-who-bind`）グローバル変数の束縛
- **C-c C-w s**（`slime-who-sets`）グローバル変数の設定箇所
- **C-c C-w a**（`slime-who-specializes`）シンボルに特化したメソッド
- **C-c >**（`slime-list-callees`）関数本体内で呼ばれるすべての関数を一覧します。
- **C-c <**（`slime-list-callers`）指定関数を呼ぶすべての関数を一覧します。

`slime-asdf` contrib が有効な場合、**C-c C-w d**（`slime-who-depends-on`）は依存する ASDF システムを一覧します。

一般的なキーバインドである **M-?** または **M-_**（`slime-edit-uses`）は上記すべてを組み合わせ、あらゆる種類の参照を一覧表示します。

### システムとの対話

Slime では、.asd ファイル内で通常の `C-c C-k` を使ってコンパイルしてロードし、その後 `ql:quickload`（または `asdf:load-system`）で実際にシステムをロードできます。SLIME は Lisp のシステムと対話するための、より対話的なコマンドを提供します。

- `M-x slime-load-system`: **ASDF システムを選択**するプロンプトを表示します。ASDF が Common Lisp のプロジェクトを見る場所から集めたプロジェクトを**自動補完**付きで選び、システムをコンパイルしてロードします。デフォルトのシステム名は、現在のバッファの作業ディレクトリで *.asd に一致する最初のファイルから取られます。
  - システム名は .asd のファイル名から推論されることに注意してください。内部で定義された本当のシステム名は異なる場合があります。
  - ASDF が Lisp のシステムをどこで探すかを理解するには、[getting started](getting-started.html) のページの "How to load an existing project" の節を読んでください。
- `M-x slime-open-system`: 指定システムのすべてのソースファイル用に新しいバッファを開きます。
- `M-x slime-browse-system`: システムのファイルを閲覧する Dired バッファを開きます。
- `M-x slime-rgrep-system`: システムのベースディレクトリで `rgrep` を実行します。
- `M-x slime-isearch-system`: システムのファイルに対して `isearch` を実行します。
- `M-x slime-query-replace-system`: ASDF システムに対して `query-replace` を実行します。
- `M-x slime-save-system`: システムに属するすべてのファイルを保存します。
- `M-x slime-delete-system-fasls`: このシステムのキャッシュされた .fasl ファイルを削除します。

Sly のユーザーにはより多機能な `sly-load-system` コマンドがあり、現在のディレクトリと親ディレクトリで .asd ファイルを検索します。


### REPL との対話

SLIME REPL では、`,` を押すとコマンドのプロンプトが出ます。利用可能なシステムとパッケージに対して補完があります。例:

- `,load-system`
- `,reload-system`
- `,in-package`（.lisp ファイルでは `C-c M-p` も）
- `,restart-inferior-lisp`

ほかにも多数あります。通常、前節で示した対話的なコマンドには REPL のショートカットがあります。

`slime-quicklisp` contrib を使うと、`,ql` でインストール可能な全システムからシステムを自動補完してインストールできます。

さらに [Quicklisp-systems](https://github.com/mmontone/quicklisp-systems) という Slime の拡張を使うと、Emacs から Quicklisp のシステムを検索、閲覧、ロードできます。

### REPL にコードを送る

REPL にコードを書けますが、ソースファイルからコードと直接やり取りすることもできます。

**C-c C-j** は見ました。ポイントの式を REPL に送り、評価します。

**C-c C-y**（`slime-call-defun`）: コードを REPL に送ります（Sly にはありません）。

ポイントが defun 内にあり、C-c C-y が押された場合（下では [] をカーソル位置の目印として使います）

~~~lisp
(defun foo ()
 nil[])
~~~


すると `(foo [])` が REPL に挿入され、追加引数を書いて実行できます。


`foo` が REPL のパッケージとは異なるパッケージにあった場合、`(package:foo )` または `(package::foo )` が挿入されます。

この機能は、書いたばかりの関数をテストするのにとても便利です。

これは `defun` だけでなく、`defgeneric`、`defmethod`、`defmacro`、`define-compiler-macro` に対しても defun と同じように動作します。

`defvar`、`defparameter`、`defconstant` の場合は `[] *foo*` が挿入されます（シンボルの前にカーソルが置かれるため、簡単に関数呼び出しで包めます）。

defclass の場合: `(make-instance ‘class-name )`。

**デバッガ内のフレームへの呼び出しを挿入する**

SLDB のフレーム上で **C-y** を押すと、そのフレームへの呼び出しが REPL に挿入されます。例:

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

**C-c ~**（`slime-sync-package-and-default-directory`）: lisp ファイルのバッファで実行すると、REPL の現在のパッケージをそのファイルのパッケージに変更し、REPL の現在のディレクトリもファイルの親ディレクトリに設定します。

<a id="symbols--export-"></a>

### シンボルを export する

Slime はパッケージに export 宣言を追加するショートカットを提供します。実質的に一つまたは複数のシンボルを export したり、逆に un-export したりできます。

`slime-package-fu` contrib の **C-c x**（*slime-export-symbol-at-point*）: ポイントのシンボルを取り、対応する defpackage フォームの `:export` 節を変更します。またシンボルも export します。負の引数（C-u C-c x）付きで呼ぶと、シンボルを `:export` から削除し unexport します。

**M-x slime-export-class** も同じことをしますが、アクセサ、コンストラクタなど、構造体またはクラスによって定義されるシンボルが対象です。今のところ構造体では SBCL と Clozure CL でのみ動作します。クラスは MOP によりどこでも動くはずです。

カスタマイズ

`defpackage` でシンボルを表示するスタイルにはいくつかあり、デフォルトは uninterned シンボル（`#:foo`）を使います。これは変更できます。

キーワードを使うには、Emacs の init ファイルに次を追加します。


~~~lisp
(setq slime-export-symbol-representation-function
      (lambda (n) (format ":%s" n)))
~~~

または文字列:

~~~lisp
(setq slime-export-symbol-representation-function
 (lambda (n) (format "\"%s\"" (upcase n))))
~~~


### （任意）Hyper Spec（CLHS）を offline で参照する

[Common Lisp Hyper Spec](http://www.lispworks.com/documentation/common-lisp.html) は ANSI Common Lisp 標準の公式オンライン版です。[starting points](http://www.lispworks.com/documentation/HyperSpec/Front/StartPts.htm) から閲覧を始められます。短縮された [table of contents of highlights](http://www.lispworks.com/documentation/HyperSpec/Front/Hilights.htm)、[シンボル索引](http://www.lispworks.com/documentation/HyperSpec/Front/Hilights.htm)、用語集、総合索引があります。

2023 年 1 月以降、Common Lisp Community Spec があります: [https://cl-community-spec.github.io/pages/index.html](https://cl-community-spec.github.io/pages/index.html)。これは仕様書の新しい Web 表示です。より現代的な見た目です。

* *検索ボックス* があります
* *シンタックスハイライト* があります
* GitHub でホストされており、変更する権利があります: [https://github.com/fonol/cl-community-spec](https://github.com/fonol/cl-community-spec)

公式の Web サイトには検索バーがないため、CLHS 上のシンボルを他のツールですばやく参照したい場合は、次を使えます。

* Xach の website search utility: [https://www.xach.com/clhs?q=with-open-file](https://www.xach.com/clhs?q=with-open-file)
* l1sp.org website: [http://l1sp.org/search?q=with-open-file](http://l1sp.org/search?q=with-open-file)
* Duckduckgo または Brave Search の `!clhs` "bang" も使えます。

MacOS では [Dash](https://kapeli.com/dash)、GNU/Linux では [Zeal](https://zealdocs.org/)、Windows では [Velocity](https://velocity.silverlakesoftware.com/) を使って **CLHS をオフラインで閲覧**できます。

しかし Emacs からもオフラインで閲覧できます。CL パッケージをインストールし、Emacs 側を一つのコマンドで設定します。

~~~lisp
(ql:quickload "clhs")
(clhs:install-clhs-use-local)
~~~

次を Emacs configuration に追加します。

~~~lisp
(load "~/quicklisp/clhs-use-local.el" 'noerror)
~~~

これで `C-c C-d h` を使って、ポイントのシンボルを HyperSpec で参照できます。ブラウザが開きますが、URL が "file://home/" で始まることを見てください。ローカルファイルを開いています。

他のコマンドも利用できます。

* `#'`（sharpsign-quote）や `(`（left-parenthesis）のような reader マクロを参照したい場合は、`C-c C-d #` に割り当てられた `M-x common-lisp-hyperspec-lookup-reader-macro` を使います。
* `~A` のような `format` ディレクティブを参照するには、`C-c C-d ~` に割り当てられた `M-x common-lisp-hyperspec-format` を使います。
  * もちろん、Emacs のミニバッファのプロンプトで TAB 補完すれば利用可能な format ディレクティブをすべて見られます。
* 用語集の項目も参照できます（たとえば "defun" ではなく "function" を参照できます）。`C-c C-d g` に割り当てられた `M-x common-lisp-hyperspec-glossary-term` を使います。


## Emacs で作業する

この節では、Lisp コード一般を扱うため、またよくある操作を行うために最も役立つ Emacs のコマンドを学びます。

まず Emacs の組み込みドキュメントで道を見つける方法から始めます。学ぶべき技能が一つあるとすれば、これです。

Emacs の GUI とターミナルのインターフェイスの両方にメニューがあることを忘れないでください。利用可能なコマンドを発見する助けになります。見えない場合は、emacs の設定が隠していないことを確認してください。`M-x menu-bar-mode` でメニューを表示できます。

### 組み込みのドキュメント

Emacs には組み込みチュートリアルとドキュメントが付属します。さらに、自己ドキュメント化と自己発見性を備えたエディタであり、introspection によって現在のキーバインド、関数のドキュメント、利用可能な変数、ソースコード、チュートリアルなどを知ることができます。「x をするためのショートカットは何があるか」や「このキーバインドは実際に何をするのか」といった疑問を持ったとき、答えはほぼ確実に Emacs の中でキー操作一つ先にあります。Emacs で Emacs を滞りなく発見できるよう、いくつかのキーバインドを覚えるべきです。

この話題のヘルプはここにあります。

- [Help page: commands for asking Emacs about its commands](https://www.gnu.org/software/emacs/manual/html_node/emacs/Help.html#Help)

ヘルプのキーバインドは `C-h` または `F1` で始まります。重要なものは次です。

- `C-h k <keybinding>`: このキーバインドはどの関数を呼ぶか？
- `C-h f <function name>`: この関数にはどのキーバインドが関連付けられているか？
- `C-h a <topic>`: 指定された *topic* に名前が一致するコマンドの一覧を表示します。キーワード、キーワードのリスト、正規表現を受け付けます。
- `C-h i`: Info ページを表示します。主要な話題のメニューです。

Emacs パッケージの中には、さらに多くのヘルプを提供するものもあります。

<a id="help--discoverability-packages"></a>

### さらにヘルプと発見性を高めるパッケージ

キーの並びを入力し始めたものの、完全には思い出せないことがあります。また、関連する他のキーバインドが気になることもあります。そこで [which-key-mode](https://github.com/justbur/emacs-which-key) です。このパッケージは、入力したキーで始まる可能なキーバインドをすべて表示します。

たとえば、`C-x` の下に便利なキーバインドがあることは知っているけれど、どれかを覚えていないとします。`C-x` と入力し、半秒待つだけで、which-key が利用可能なものをすべて表示します。

![](assets/emacs-which-key-minibuffer.png)

`C-h` でも試してみてください。

組み込みの Emacs ヘルプの代替で、より多くの文脈情報を提供する [Helpful](https://github.com/Wilfred/helpful) も参照してください。

<img src="assets/emacs-helpful.png" style="height: 450px" alt="The Emacs helpful package shows detailed information about a symbol."/>

<!-- pdf-include-start
![](assets/emacs-helpful.png)
   pdf-include-end -->


### 組み込みのチュートリアル

Emacs には独自のチュートリアルが付属しています。重要なキーバインドと概念を学ぶために一度見ておくとよいでしょう。

`M-x help-with-tutorial`（ここで `M-x` は `alt-x`）で呼び出します。



### 括弧を編集する

Emacs にはもちろん、S 式を扱う組み込みコマンドがあります。

#### S 式による前後・上下の移動と選択

`C-M-f` と `C-M-b`（`forward-sexp` と `backward-sexp`）を使うと、ポイントの S 式の終端（始端）や、同じ階層の次の式へ移動できます。`C-M-n` と `C-M-p`（next、previous）も似ています。

`C-M-u`（`backward-up-list`）と `C-M-d`（`down-list`）で S 式の木構造を上下に移動します。

`C-M-a`（lisp-mode では `beginning-of-defun` または `slime-beginning-of-defun`）と `C-M-e`（`end-of-defun` または `slime-end-of-defun`）でトップレベルの S 式の始端（または終端）へ移動します。たとえば現在の関数定義の先頭へ移動します。

S 式全体をハイライトするには `C-M-@` または `C-M-space`（どちらも `mark-sexp`）を使います。その後 `C-M-u` で選択範囲を「上方向」に広げ、`C-M-d` で括弧の一段下へ進めます。`mark-sexp` を繰り返し押すこともできます。

`M-)`（`move-past-close-and-reindent`）を使うと、現在のレキシカルブロックの終端へ移動し、新しい行を作ってインデントします。

`C-M-t`（`transpose-sexps`）を使うと、ポイントの S 式を前の S 式の前へ移動できます。

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

#### 行またはリージョンをコメントにする

`M-;` でコメントを挿入するかリージョンをコメントにし、`M-q` でテキストを整えます。

#### 括弧と S 式を削除する

ポイントの前方にある括弧の対を削除するには `M-x delete-pair` を使います。実際には対になる任意の記号（ダブルクォート、角括弧…）で動作します。

例:

~~~lisp
[](1 2 3)
;; M-x delete-pair =>
1 2 3
~~~

`C-M-k`（`kill-sexp`）と `C-M-backspace`（`backward-kill-sexp`）を使います（ただし注意: このキーバインドは GNU/Linux でシステムを再起動することがあります）。

たとえばポイントが `(progn` の前にある場合（[] をカーソルの位置として使います）:

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

#### raise: S 式を上へ移動する

現在の式を "raise" するには `M-x raise-sexp`（デフォルトでは未割り当て）を使います。これは一段上へ移動し、以前の式を消します。たとえばポイントが下の位置にある場合:

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

グローバルキーに割り当てられます。

~~~lisp
(keymap-global-set "M-+" #'raise-sexp) ;; M-+ originally unbound
~~~

#### S 式をインデントする

Lisp フォームのインデントは自動です。

TAB を押すと、誤ってインデントされたコードをインデントします。たとえば `(+ 3 3)` フォームの先頭にポイントを置いて TAB を押します。

~~~lisp
(progn
(+ 3 3))
~~~

正しく次のようになります。

~~~lisp
(progn
  (+ 3 3))
~~~

ポイントのフォームを再インデントするには `C-M-q`（`indent-sexp`）を使います。

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

現在の関数定義をインデントするには `C-c M-q`（`slime-reindent-defun`）を使います。

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

リージョンを選択して `M-x indent-region` を呼ぶこともできます。

#### 括弧を開閉する

Lisp の括弧を管理するのに、多くのキーバインドは（あるいはまったく）必要ないかもしれません。`M-x show-paren-mode` だけでも非常に便利です（下記参照）。とはいえ、役立つキーバインドもあります。

Slime REPL では、`C-return` または `M-return`（`slime-repl-closing-return`）で残りの括弧を閉じて入力文字列を評価できることを知っていましたか。

ソースファイルでは、必要な数の閉じ括弧を挿入するために `C-c C-]`（`slime-close-all-parens-in-sexp`）を使えます。

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

ファイルでは、`M-(` で括弧の対（`()`）を挿入できます。同じキーバインドに前置引数 `C-u M-(` を付けると、カーソルの前の式を括弧の対で囲みます。

たとえば最初の括弧の前にカーソルがある状態から始めます。

~~~lisp
[](- 2 2)
~~~

`C-u M-(` を押して parens で囲みます。

~~~lisp
([](- 2 2))
;; now write anything.
(zerop (- 2 2))
~~~

数値の前置引数（`C-u 2 M-(`）を使うと、その数の S 式を囲みます。

さらに、不正な形の S 式を見つけるには `M-x check-parens` を使います。

括弧の利用を簡単にする追加パッケージもあります。

- `M-x show-paren-mode` は組み込みの Emacs モードで、対応する括弧の可視化を切り替えます。有効にすると、括弧の上にカーソルを置いたとき対応する括弧が見えます。Emacs の init ファイルで `(show-paren-mode t)` により初期化できます。グローバルなマイナーモードです（すべてのバッファ、すべての言語で動作します）。
 - **有効にすることを強く勧めます**。
- evil-mode（vim レイヤー）が有効な場合、`%` キーで対応する括弧に移動できます。
- `M-x electric-pair-mode` は組み込みの Emacs モードです。有効にすると、開き括弧を入力したとき対応する閉じ括弧を自動挿入し、その逆も行います（角括弧なども同様）。リージョンがアクティブな場合、括弧（角括弧など）はリージョンの周りに挿入されます。
- [Paredit (animated guide)](http://danmidwood.com/content/2014/11/21/animated-paredit.html) を使うと括弧を自動で対にして挿入できます。
- または [lispy-mode](https://github.com/abo-abo/lispy) もあります。Paredit のようなものですが、カーソルが括弧の直前または直後にあるときだけキーが動作を起こします。

<a id="structured-editing--packages"></a>

### （任意）構造化編集のパッケージ

組み込みの Emacs コマンドとモード（`show-paren-mode` は必須です。上記参照）に加えて、括弧やインデントのバランスを保つ助けになるパッケージがさらにあります。下の一覧は、[history of Lisp editing](https://github.com/shaunlebron/history-of-lisp-editing) による拡張の年代順にある程度並べています。

- [Paredit](https://www.emacswiki.org/emacs/ParEdit) - Paredit は定番です。必携のコマンド（S 式の移動、削除、分割、結合など）を定義します。
  ([visual tutorial](http://danmidwood.com/content/2014/11/21/animated-paredit.html))
- [Smartparens](https://github.com/Fuco1/smartparens) - Smartparens は括弧だけでなく対になるすべてのもの（html タグなど）を扱うため、Lisp 以外の言語向けの機能もあります。
- [Lispy](https://github.com/abo-abo/lispy) - Lispy は Paredit を再考し、ポイント位置に応じて動作する最短の割り当て（多くは 1 キー）を目指しています。
- [Paxedit](https://github.com/promethial/paxedit) - Paxedit は文脈（シンボル内、S 式内など）に基づくコマンドを追加し、空白の整理と文脈に応じたリファクタリングに力を入れています。
- [Parinfer](http://shaunlebron.github.io/parinfer/) - Parinfer はインデントに応じて括弧を自動修正するか、その逆を行います（または両方）。

個人的には、まず組み込み関数をよく知り、その後有名な Paredit や evil ユーザー向けの Lispy から着想を得ることを勧めます。さらに詳しくは [Wikemacs](http://wikemacs.org/wiki/Lisp_editing) を参照してください。


### コードを隠す/表示する

`C-x n n`（narrow-to-region）と `C-x n w` を使って元に戻します。

外部パッケージによる [code folding](http://wikemacs.org/wiki/Folding) も参照してください。

### 検索と置換

#### 前方/後方のインクリメンタル検索、正規表現検索、検索・置換

`C-s` は前方へのインクリメンタル検索を行います。たとえば検索文字列の各キーを入力するたびにソースファイルが最初の一致に向けて検索されます。一意になる文字だけを入力すればよいため、特定のテキストをかなり素早く見つけられます。同じ検索文字を使った繰り返し検索は、`C-s` を繰り返し押すことで行えます。

`C-r` は後方へのインクリメンタル検索を行います。

`C-s RET` と `C-r RET` はどちらも通常の文字列検索を行います（それぞれ前方と後方）。

`C-M-s` と `C-M-r` はどちらも正規表現検索を行います（それぞれ前方と後方）。

`M-%` は検索・置換を行い、`C-M-%` は正規表現の検索・置換を行います。


#### 出現箇所を探す（occur、grep）

`M-x grep`、`rgrep`、`occur` などを使います。

対話的な版として [helm-swoop](http://wikemacs.org/wiki/Helm-swoop)、helm-occur、[ag.el](https://github.com/Wilfred/ag.el) も参照してください。


## 質問と回答

### Emacs Lisp vs Common Lisp

Common Lisp 用に Emacs を Slime または Sly と一緒に使うために、Emacs Lisp を書く必要はありません。

ただし Emacs Lisp を学ぶことは役に立ちますし、CL と似ています（しかし異なります）。

*   ダイナミックスコープが至るところにあります
*   reader（または reader 関連）の関数がありません
*   CL でサポートされるすべての型をサポートしているわけではありません
*   CLOS の実装は不完全です（追加の EIEIO パッケージによる）
*   数の塔（numerical tower）のサポートがありません

Emacs Lisp 学習に役立つ資料:

*   [An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/eintr.html)
*   [Writing GNU Emacs Extensions](http://www.oreilly.com/catalog/gnuext/)
*   [Wikemacs](http://wikemacs.org/wiki/Category:Emacs_Lisp)

### LSP（Language Server Protocol）はどうか？

Common Lisp 向けの LSP サーバーとクライアントの移植版は存在しますが、高品質な IDE 連携を得るためにそれらが*必要*なわけではありません。実際、Slime/Swank は LSP のようなクライアント/サーバー型のアーキテクチャに従っていますが、Slime は LSP より何十年も前からあり、今でも LSP より lisper 向けにずっと多くの機能を提供しています。

### utf-8 エンコーディング

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

これにより、SLIME で評価するファイルに非 ASCII 文字があるときの `ascii stream decoding error` を避けられます。


<a id="default-cutcopypaste-keybindings"></a>

### デフォルトの切り取り・コピー・貼り付け用キーバインド

*私はテキストのコピーと貼り付けに C-c、C-v などを使うことに慣れすぎていて、Emacs のデフォルトショートカットがまったくしっくりきません。*

幸い、解決策があります。[cua-mode](http://www.emacswiki.org/cgi-bin/wiki.pl?CuaMode) をインストールすれば、これらのショートカットを使い続けられます。

~~~lisp
;; C-z=Undo, C-c=Copy, C-x=Cut, C-v=Paste (needs cua.el)
(require 'cua) (CUA-mode t)
~~~


## 付録

### Slime REPL のショートカットすべて

REPL で動作するすべての Slime のショートカットのリファレンスです。

見るには REPL に移動し、`C-h m` と入力して Slime REPL map の節へ進みます。


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

### その他すべての Slime のショートカット

ここで示した以上のものがあります。Slime には、ポイントのシンボルの関数定義を逆アセンブルしたり、インスペクタの操作方法を学んだり、関数のプロファイリングを切り替えたり、インデントや補完の方法を学んだり、複数の Lisp 接続を使ったり、[presentations を操作](https://slime.common-lisp.dev/doc/html/Presentations.html#Presentations)したりするショートカットがあります。

Slime モードによって定義されるデフォルトのキーバインドは次のとおりです。

見るには .lisp ファイルに移動し、`C-h m` と入力して Slime の節へ進みます。

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
- **[Slime のビデオチュートリアル](https://www.youtube.com/watch?v=sBcPNr1CKKw)**（作者のチャンネルも素晴らしい内容が豊富です）
- Marco Baringer の [Slime チュートリアル](https://www.youtube.com/watch?v=NUpAvqa5hQw)
- [Common Lisp REPL exploration guide](https://bnmcgn.github.io/lisp-guide/lisp-exploration.html)。REPL で道を見つけるための、簡潔で厳選された要点集です。
- [Emacs4CL](https://github.com/susam/emacs4cl)。素の Emacs を Common Lisp プログラミング用に設定するための小さな DIY キットです。
- [slime-star](https://github.com/mmontone/slime-star)。SLIME 拡張の詰め合わせです。
  * doc contribs: ドキュメントを表示する、より豊かな slime-help と slime-info のバッファ。
  * Quicklisp systems: REPL から Quicklisp のシステムをロードする自動補完。
  * quicksearch 連携: Quicklisp、Github、Cliki で Common Lisp のリポジトリを検索。
  * Slime breakpoints: コードへの注釈なしでブレークポイントを視覚的に設定し、コードをステップ実行するボタンを得る。
  * Quicklisp apropos: Quicklisp ライブラリ全体の "apropos"。
  * Slime critic: Slime critic にコードをやさしく批評してもらう。
  * 対話的な print と trace のバッファ
  * 出力ストリーム用の専用 Emacs バッファ
* ANSI Common Lisp 仕様を Emacs Info 形式で参照できます。
  * Lisp system browser: Common Lisp 用の（開発中の）Smalltalk 風システムブラウザ。利用可能なパッケージとその関数、変数、マクロ、クラス、総称関数を閲覧するための複数のペインを得られます。
- [Slime tips](https://github.com/lisp-tips/lisp-tips/issues?q=state%3Aopen%20label%3A%22slime%22)
