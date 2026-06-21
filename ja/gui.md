---
title: GUI ツールキット
---

Lisp には長く豊かな歴史があり、GUI 開発にも同じことが言えます。実際、最初の GUI ビルダーは Lisp で書かれました（そして Apple に売却され、今では Interface Builder になっています）。

Lisp は対話的開発能力でも有名で、GUI アプリケーション開発ではこの利点がさらに大きくなります。関数 1 つをコンパイルしただけで GUI が即座に更新される様子を想像できるでしょうか。今日では多くの GUI フレームワークでこれが可能ですが、細部はそれぞれ異なります。

最後に、ソフトウェア開発では、どうビルドしてどう利用者へ届けるかも重要です。ここでも、主要な 3 つの OS 向けに自己完結型バイナリを作り、利用者がダブルクリックで実行できるようにできます。

ここでは、適切な GUI フレームワークを選ぶための情報を整理して示します。[contribute](https://github.com/LispCookbook/cl-cookbook/issues/) して、さらに例を追加したり、元のドキュメントを補ったりするのは歓迎です。


<a id="introduction"></a>

## はじめに

このレシピでは、次の GUI ツールキットを紹介します。

- [Tk][tk] と [Ltk][ltk] / [nodgui][nodgui]
- [Qt4][qt4] と [Qtools][qtools]
- [IUP][iup-tecgraf] と [lispnik/iup][iup-lisp]
- [Gtk3][gtk] と [cl-cffi-gtk][cl-cffi-gtk]
  - Gtk4 のバインディングが欲しい場合は [cl-gtk4](https://github.com/bohonghuang/cl-gtk4) を見てください。これは 2022 年 9 月に公開された新しいバインディングです。

- [Nuklear][nuklear] と [Bodge-Nuklear][bodge-nuklear]

加えて、次のものも見ておくとよいでしょう。

- [CAPI][capi] ツールキット（Common Application Programming Interface）,
  これは LispWorks 製のプロプライエタリなツールキットです。Windows、Gtk+、Cocoa をまたぐ完全なクロスプラットフォームツールキットで、利用者の評判も高いです。LispWorks には [iOS と Android のランタイム](http://www.lispworks.com/products/lw4mr.html) もあります。CAPI で作られた例として [ScoreCloud](https://scorecloud.com/) があります。LispWorks の無料デモで試せます。
- [Allegro CL の IDE と Common Graphics ウィンドウシステム](https://franz.com/products/allegro-common-lisp/acl_ide.lhtml)（プロプライエタリ）: Allegro の IDE はアプリケーション開発のための一般的な環境です。Common Graphics というウィンドウシステムと連携して動きます。この IDE は、Allegro CL の Microsoft Windows 版、Linux プラットフォーム、Free BSD、Mac 版で利用できます。
  - NEW! 🎉 Allegro CL 10.1（2022 年 3 月公開）以降、IDE と Common Graphics GUI ツールキットはブラウザ上で動きます。これを [CG/JS](https://franz.com/ftp/pri/acl/cgjs/doc.html) と呼びます。
- [CCL の組み込み Cocoa
  interface](https://ccl.clozure.com/docs/ccl.html#the-objective-c-bridge),
  [Opusmodus](https://opusmodus.com/) のようなアプリケーションを作るのに使われています。
- Clozure CL の組み込み [Objective-C bridge](https://ccl.clozure.com/docs/ccl.html#the-objective-c-bridge) と [CocoaInterface](https://github.com/plkrueger/CocoaInterface/) は、CCL 向けの Cocoa インターフェイスです。Lisp コードだけで Cocoa のユーザインターフェイスのウィンドウを動的に作れ、典型的な Xcode の手順を飛ばせます。
  - この bridge は ObjC エラーを拾って Lisp エラーに変換するのが得意なので、macOS GUI アプリケーションでも REPL ベースの反復開発サイクルを回せます。
* [McCLIM](https://common-lisp.net/project/mcclim/) と [Garnet](https://github.com/earl-ducaine/cl-garnet) は 100% Common Lisp のツールキットです。McCLIM には Broadway プロトコルでブラウザ上で動く [プロトタイプ](https://techfak.de/~jmoringe/mcclim-broadway-7.ogv) があり、Garnet には Gtk への継続的なインターフェイスがあります。
* [Alloy](https://github.com/Shirakumo/alloy) は、これも新しめの 100% Common Lisp ツールキットで、たとえば [Kandria](https://github.com/shinmera/kandria) ゲームで使われています。
* [eql, eql5, eql5-android](https://gitlab.com/eql) は、ECL に埋め込まれ、Qt にも埋め込める Qt4/Qt5 Lisp です。EQL5 の Android 移植版もあります。
* [ABCL から Java Swing を使うデモ](https://github.com/defunkydrummer/abcl-jazz)
* [SBCL で C ファイルなしに Gtk を使う例](https://github.com/mifpasoti/Gtk-Demos) と GTK-server。
* [Ceramic][ceramic] は、Electron でクロスプラットフォーム Web アプリを配布するためのものです。
  * 詳しくは Web Apps in Lisp の [Electron](https://web-apps-in-lisp.github.io/building-blocks/electron/index.html) と [Web view (webview, webui, CLOG Frame)](https://web-apps-in-lisp.github.io/building-blocks/web-views/index.html) を見てください。
* [Barium ツールキット](https://tomscii.sig7.se/barium/)
  * 例のアプリケーション: [ChessLab](https://tomscii.sig7.se/chesslab/) (2025)

そのほか、[awesome-cl#gui](https://github.com/CodyReichert/awesome-cl#Gui) と [Cliki](https://www.cliki.net/GUI) にあるものも参照してください。

### Tk (Ltk and nodgui)

[Tk][tk]（あるいは Tcl/Tk。Tcl がプログラミング言語です）は、古臭い見た目だという悪評があります。ですが、それは今では（それほど）当てはまりません。1997 年のバージョン 8 以降は特にそうです。たぶん、思っているより良いものです。

これは nodgui の組み込みテーマを使ったシンプルな GUI です（詳細は後述）。

![](assets/gui/nodgui-feet2meters-yaru.png)

同じテーマの treeview です。

![](assets/gui/nodgui-treeview-yaru.png)

Arc テーマを使った、ツリーリスト、チェックボックス、ボタン、ラベルを表示するおもちゃのメディアプレーヤーです。

![](assets/gui/mediaplayer-nodgui-arc.png)

MacOS テーマのデモです。

![](assets/gui/ltk-on-macos.png)

これらに加えて、[ttkthemes](https://ttkthemes.readthedocs.io/en/latest/themes.html) や [Forest テーマ](https://github.com/rdbende/Forest-ttk-theme) など多数のテーマを使えます。[この tcl/tk の一覧](https://wiki.tcl-lang.org/page/List+of+ttk+Themes) を見てください。

では Tk は何に向いているのでしょうか。Tk のウィジェットの種類は豊富ではありませんが、便利なキャンバスがあり、さらにいくつか独自の特徴があります。GUI を **完全に対話的に** 開発でき、コアアプリから GUI を **遠隔実行** できます。しかもクロスプラットフォームです。

つまり Tk はネイティブではなく、最先端の機能を備えているわけでもありませんが、実績のある GUI ツールキット（兼プログラミング言語）で、今も業界で使われています。単純な GUI を素早く作りたいとき、配布のしやすさを重視したいとき、安定性が必要なときに向いています。

Lisp バインディングは 2 つあります。[Ltk][ltk] と [nodgui][nodgui] です。Nodgui（"No Drama GUI"）は Ltk のフォークで、追加ウィジェット（たとえば自動補完リストウィジェット）、非同期イベントループ、そして何よりライブラリに付属する意外と見栄えの良い "Yaru" テーマを備えています。ほかのテーマを入れて使うのも簡単です。詳細は後述します。

- **Tk の実装言語**: Tcl
- **移植性**: クロスプラットフォーム (Windows, macOS, Linux).

- **ウィジェット**: Tk はウィジェットの豊富さが売りではありません。既定ウィジェットは **少数** で、デートピッカーのような重要なものが欠けています。拡張（**Nodgui** など）で補えますが、あまりネイティブには見えません。カレンダーは Tk 拡張が提供しており、こちらのほうが見栄えがよいです。

- **対話的な開発**: 非常に向いています。

- **GUI ビルダー**: なし

- **その他の機能**:
  - **遠隔実行**: Lisp と Tcl/Tk の接続はストリーム経由で行われます。そのため、Lisp プログラムを 1 台のコンピュータで動かし、GUI を別のコンピュータに表示できます。クライアント側に必要なのは tcl/tk のインストールと remote.tcl スクリプトだけです。[Ltk-remote](http://www.peter-herth.de/ltk/ltkdoc/node46.html) を見てください。

- **バインディングのドキュメント**: 短いですが十分です。Nodgui も同様です。
- **バインディングの安定性**: とても安定しています。
- **バインディングの活動状況**: Ltk は低め（主に保守）、Nodgui は活発（新機能あり）です。
- **ライセンス**: Tcl/Tk は BSD 風、Ltk は LGPL です。
- 例:
  - [Fulci](https://notabug.org/cage/fulci/) - 映画コレクションを整理するプログラムです。
  - [Ltk small games](https://github.com/mijohnson99/ltk-small-games) - snake と tic-tac-toe です。
  - [cl-pkr](https://github.com/VitoVan/cl-pkr) - クロスプラットフォームのカラーピッカーです。
  - [cl-torrents](https://github.com/vindarel/cl-torrents) - 人気のトラッカーのトレントを検索します。CLI、readline、シンプルな Tk GUI を備えています。
- 追加の例:
  - [https://peterlane.netlify.app/ltk-examples/](https://peterlane.netlify.app/ltk-examples/): [tkdocs](https://tkdocs.com/tutorial/index.html) チュートリアル向けの LTk 例です。
  - [LTk Plotchart](https://peterlane.netlify.app/ltk-plotchart/) - tklib/plotchart ライブラリを LTk で使うためのラッパーです。xy プロット、ガントチャート、3D 棒チャートなど 20 種類以上のチャートを含みます。


**ウィジェット一覧**

(網羅的な一覧ではありません)

```
Button Canvas Check-button Entry Frame Label Labelframe Listbox
Menu Menubutton Message
Paned-window
Radio-button Scale
Scrollbar Spinbox Text
Toplevel Widget Canvas

Ltk-megawidgets:
    progress
    history-entry
    menu-entry
```

nodgui に追加されるもの:

```
treelist tooltip searchable-listbox date-picker calendar autocomplete-listbox
password-entry progress-bar-star notify-window
dot-plot bar-chart equalizer-bar
swap-list
```

### Qt4 (Qtools)

Qt と [Qt4][qt4] を改めて紹介する必要があるでしょうか。Qt は非常に大きく、何でも入っています。UI ウィジェットだけでなく、ネットワークや D-BUS など多くの層を提供します。

Qt はオープンソースソフトウェアなら無料で使えますが、プロプライエタリソフトウェアを配布する場合は条件を確認してください。

[Qtools][qtools] バインディングは Qt4 を対象にしています。Qt5 の Lisp バインディングは [https://github.com/commonqt/commonqt5/](in the works) で、まだ本番向けではありません。

Qtools の付属ライブラリとして、最初の Qtools アプリケーションを作ったらぜひ見ておきたいのが [Qtools-ui](https://github.com/Shinmera/qtools-ui) です。便利なウィジェットと既成コンポーネントの集まりで、短い [デモ動画](https://www.youtube.com/playlist?list=PLkDl6Irujx9Mh3BWdBmt4JtIrwYgihTWp) もあります。

<!-- possible future: gobject-introspection -->

- **フレームワークの実装言語**: C++
- **フレームワークの移植性**: マルチプラットフォーム、Android、組み込みシステム、WASM。
- **バインディングの移植性**: Qtools は Windows、macOS、GNU/Linux の x86 デスクトッププラットフォームで動きます。

- **ウィジェットの選択肢**: 豊富。

- **GUI ビルダー**: あり。

- **その他の機能**: Web ブラウザなど多数。

- **バインディングのドキュメント**: 詳しい説明と少数の例があります。Qt の事前知識が必要です。
- **バインディングの安定性**: 安定。
- **バインディングの活動状況**: 活発。
- **Qt のライセンス**: 商用とオープンソースの両方があります。
- 例:
  - https://github.com/Shinmera/qtools/tree/master/examples
  - https://github.com/Shirakumo/lionchat
  - https://github.com/shinmera/halftone - シンプルな画像 viewer


### Gtk+3 (cl-cffi-gtk)

[Gtk+3][gtk] は [GNOME][gnome] アプリケーションを作る主要ライブラリです。Lisp バインディングとしては、現時点で最も進んでいるものが [cl-cffi-gtk][cl-cffi-gtk] です。主に GNU/Linux 向けに作られましたが、Gtk は macOS でも問題なく動き、今では Windows でも使えます。


- **フレームワークの実装言語**: C
- **移植性**: GNU/Linux と macOS、Windows でも可。

- **ウィジェットの選択肢**: 豊富。

- **GUI ビルダー**: あり: Glade。
- **その他の機能**: Web ブラウザ (WebKitGTK)

- **バインディングのドキュメント**: とても良いです: http://www.crategus.com/books/cl-gtk/gtk-tutorial.html
- **バインディングの安定性**: 安定。
- **バインディングの活動状況**: 活動量は少なめですが、開発は続いています。
- **ライセンス**: LGPL
- 例:
  - Glade で作られた [Atmosphere Calculator](https://github.com/ralph-schleicher/atmosphere-calculator)。
- 追加の documentation と例:
  - [Learn Common Lisp by Example: GTK GUI with SBCL](https://dev.to/goober99/learn-common-lisp-by-example-gtk-gui-with-sbcl-5e5c)


### IUP (lispnik/IUP)

[IUP][iup-tecgraf] は、ブラジルのリオデジャネイロ・カトリック大学で活発に開発されているクロスプラットフォーム GUI ツールキットです。**ネイティブコントロール** を使い、Windows では Windows API、GNU/Linux では Gtk3 を使います。執筆時点では Cocoa 版も開発中で、iOS、Android、WASM 版もあります。IUP の特徴は **API が小さい** ことです。

[Lisp バインディング] は [lispnik/iup](https://github.com/lispnik/iup/) です。C ソースから自動生成されているため、よくできています。新しい IUP バージョンに追従する手間が少なく、必要な手順も文書化されています。これにより bus factor の面でも安心です。

IUP は Tk と Gtk/Qt の中間にある、非常に良い選択肢です。

- **フレームワークの実装言語**: C（公式 API は Lua と LED にもあります）
- **移植性**: Windows と Linux、Cocoa、iOS、Android、WASM 版も作業中です。

- **ウィジェットの選択肢**: 中程度。Web ブラウザウィンドウを含みます（Linux では WebkitGTK、Windows では IE の WebBrowser）。

- **GUI ビルダー**: あり: [IupVisualLED](http://webserver2.tecgraf.puc-rio.br/iup/en/iupvisualled.html)

- **その他の機能**: OpenGL、Web ブラウザ（GNU/Linux では WebKitGTK）、作図、Scintilla テキストエディタ

- **バインディングのドキュメント**: 例と README は良いですが、それ以外は少なめです。
- **バインディングの安定性**: alpha（ただし完全に生成されていて、問題なく動きます）。
- **バインディングの活動状況**: 少なめですが安定していて、新しい IUP バージョンにも反応します。
- **ライセンス**: IUP もバインディングも MIT license です。


**ウィジェット一覧**

```
Radio, Tabs, FlatTabs, ScrollBox, DetachBox,
Button, FlatButton, DropButton, Calendar, Canvas, Colorbar, ColorBrowser, DatePick, Dial, Gauge, Label, FlatLabel,
FlatSeparator, Link, List, FlatList, ProgressBar, Spin, Text, Toggle, Tree, Val,
listDialog, Alarm, Color, Message, Font, Scintilla, file-dialog…
Cells, Matrix, MatrixEx, MatrixList,
GLCanvas, Plot, MglPlot, OleControl, WebBrowser (WebKit/Gtk+)…
drag-and-drop
WebBrowser
```

<!-- editor's note: found missing a list view with columns. -->

![](assets/iup-demo.png)


### Nuklear (Bodge-Nuklear)

[Nuklear][nuklear] は小さな [immediate-mode](https://en.wikipedia.org/wiki/Immediate_mode_GUI) GUI ツールキットです。

> [Nuklear] は、ANSI C で書かれ、パブリックドメインでライセンスされた、最小限の状態しか持たないイミディエイトモードのグラフィカルユーザインターフェイスツールキットです。アプリケーションに組み込めるシンプルなユーザインターフェイスとして設計されており、依存関係も、デフォルトのレンダリングバックエンドも、OS のウィンドウ/入力処理も持ちません。代わりに、入力用のシンプルな入力状態と、出力としてプリミティブな図形を記述する描画コマンドを備えた、高度にモジュール化されたライブラリベースの方式を提供します。つまり、数多くのプラットフォームやレンダリングバックエンドを抽象化しようとする階層化されたライブラリを提供するのではなく、実際の UI だけに集中しています。

Lisp バインディングは [Bodge-Nuklear][bodge-nuklear] で、上位の付属として [bodge-ui](https://github.com/borodust/bodge-ui) と [bodge-ui-window](https://github.com/borodust/bodge-ui-window) があります。

従来の UI フレームワークと違い、Nuklear では描画ループや入力管理を開発者が引き継げます。設定は少し増えますが、ゲームや、新しいコントロールを作りたいアプリケーションには特に向いています。


- **フレームワークの実装言語**: ANSI C、single-header ライブラリ。
- **移植性**: C が動くところならどこでも。Nuklear にはプラットフォーム固有コードは含まれていません。OS やウィンドウの直接処理も Nuklear では行われません。その代わり、*すべての入力状態をプラットフォーム固有コードが提供する必要があります*。

- **ウィジェットの選択肢**: 少ない。

- **GUI ビルダー**: なし。

- **その他の機能**: skin と customization が完全に可能。

- **バインディングの安定性**: 安定。
- **バインディングの活動状況**: 活発。
- **ライセンス**: MIT か Public Domain（unlicense）。
- アプリケーションの例:
  - [Trivial-gamekit](https://github.com/borodust/trivial-gamekit)
  - [Obvius](https://github.com/thicksteadTHpp/Obvius/) - a resurrected image processing library.
  - [Notalone](https://github.com/borodust/notalone) - an autumn 2017 Lisp Game Jam entry.

**ウィジェット一覧**

抜粋です。

```
buttons, progressbar, image selector, (collapsable) tree, list, grid, range, slider, color picker,
date-picker
```

![](assets/gui/nuklear.png)

<a id="getting-started"></a>

## 使ってみる

### Tk

Ltk はすぐに使えて、つかみやすいものです。

~~~lisp
(ql:quickload "ltk")
(in-package :ltk-user)
~~~


**ウィジェットの作り方**

ウィジェットはすべて、通常の `make-instance` とウィジェット名で作ります。

~~~lisp
(make-instance 'button)
(make-instance 'treeview)
~~~

これにより、デフォルトのシンボル補完で Ltk をたどっていけます。

**メインループの始め方**

たいていのバインディングと同じく、GUI 関連のコードはメインループを扱うマクロ（ここでは `with-ltk`）の中で始める必要があります。

~~~lisp
(with-ltk ()
  (let ((frame (make-instance 'frame)))
    …))
~~~

**ウィジェットの表示の仕方**

ウィジェットを作ったら、レイアウトに配置する必要があります。Tk にはいくつか配置方法がありますが、今使うべきなのは `grid` です。`grid` はウィジェット、列、行、いくつかの optional パラメータを引数に取る関数です。

通常の Lisp コードと同じく、関数のシグネチャはエディタに出ます。これも Ltk をたどりやすくしてくれます。

ボタンを表示する例です。

~~~lisp
(with-ltk ()
  (let ((button (make-instance 'button :text "hello")))
    (grid button 0 0)))
~~~

やることはそれだけです。


<a id="event-"></a>

#### イベントに反応する

多くのウィジェットには `:command` 引数があり、ウィジェットのイベントが発生したときに実行される lambda を受け取ります。ボタンの場合はクリック時です。

~~~lisp
(make-instance 'button
  :text "Hello"
  :command (lambda ()
             (format t "clicked")))
~~~


#### 対話的開発

`(start-wish)` で Tk プロセスを background で起動すると、ウィジェットを作って grid に置く作業を対話的に行えます。

詳しくは [ドキュメント](http://www.peter-herth.de/ltk/ltkdoc/node8.html) を見てください。

終わったら `(exit-wish)` を呼びます。


#### Nodgui

Nodgui のデモを試すには次のようにします。

~~~lisp
(ql:quickload "nodgui")
(nodgui.demo:demo)
~~~

見た目のよいテーマでデモを読み込むなら、次のようにします。

~~~lisp
(nodgui.demo:demo :theme "yaru")
~~~

or

~~~lisp
(setf nodgui:*default-theme* "yaru")
(nodgui.demo:demo)
~~~

#### Nodgui UI theme

nodgui に付属する "yaru" テーマを使うには、単純に次のようにします。

~~~lisp
(with-nodgui ()
  (use-theme "yaru")
  …)
~~~

or

~~~lisp
(with-nodgui (:theme "yaru")
  …)
~~~

or

~~~lisp
(setf nodgui:*default-theme* "yaru")
(with-nodgui ()
  …)
~~~

別の tcl テーマをインストールして読み込むこともできます。たとえば [Forest ttk テーマ](https://github.com/rdbende/Forest-ttk-theme) や [ttkthemes](https://github.com/TkinterEP/ttkthemes/) を clone します。project ディレクトリは次のようになります。

```
yourgui.asd
yourgui.lisp
ttkthemes/
```

`ttkthemes/` の中では `png/` ディレクトリにテーマがあり、それ以外は現時点で未対応です。

    /ttkthemes/ttkthemes/png/arc/arc.tcl

nodgui で .tcl ファイルを読み込み、このテーマを使うよう指示します。

~~~lisp
(with-nodgui ()
   (eval-tcl-file "/ttkthemes/ttkthemes/png/arc/arc.tcl")
   (use-theme "arc")
   … code here …)
~~~

これで終わりです。アプリケーションは新しい、そこそこ見栄えのよい GUI テーマを使うようになります。

### Qt4

~~~lisp
(ql:quickload '(:qtools :qtcore :qtgui))
~~~

~~~lisp
(defpackage #:qtools-test
  (:use #:cl+qt)
  (:export #:main))
(in-package :qtools-test)
(in-readtable :qtools)
~~~

残りを入れるメインウィジェットを作ります。

~~~lisp
(define-widget main-window (QWidget)
  ())
~~~

このメインウィジェットの中に入力フィールドとボタンを作ります。

~~~lisp
(define-subwidget (main-window name) (q+:make-qlineedit main-window)
  (setf (q+:placeholder-text name) "Your name please."))
~~~

~~~lisp
(define-subwidget (main-window go-button) (q+:make-qpushbutton "Go!" main-window))
~~~

横に並べます。

~~~lisp
(define-subwidget (main-window layout) (q+:make-qhboxlayout main-window)
  (q+:add-widget layout name)
  (q+:add-widget layout go-button))
~~~

そして表示します。

~~~lisp
(with-main-window
  (window 'main-window))
~~~

![](assets/gui/qtools-intro.png)

これで形はできましたが、まだ click イベントには反応していません。

<a id="event--1"></a>

#### イベントに反応する

Qt でイベントに反応するにはシグナルとスロットを使います。**スロット** はシグナルを受け取る、あるいはシグナルに "接続する" 関数で、**シグナル** はイベントの運び手です。

ウィジェットはすでに自前のシグナルを送っています。たとえばボタンは "pressed" イベントを送ります。そのため、たいていはそれに接続するだけで済みます。

ただし、必要なら独自のシグナル群を作ることもできます。

<a id="event"></a>

##### 組み込みイベント

`go-button` を `pressed` と `return-pressed` イベントに接続し、メッセージボックスを表示します。

- これを `define-slot` 関数の中で行い、
- その中でイベントへの接続を確立し、
- さらにメッセージボックスを作ります。`name` 入力フィールドのテキストは `(q+:text name)` で取得します。

~~~lisp
(define-slot (main-window go-button) ()
  (declare (connected go-button (pressed)))
  (declare (connected name (return-pressed)))
  (q+:qmessagebox-information main-window
                              "Greetings"  ;; title
                              (format NIL "Good day to you, ~a!" (q+:text name))))
~~~

これで完成です。次のように実行します。

~~~lisp
(with-main-window (window 'main-window))
~~~

<a id="event-1"></a>

##### 独自イベント

上と同じ機能を実装しますが、説明のためにボタンクリック時に発火する `name-set` という独自シグナルを作ります。

まずシグナルを定義します。これは `main-window` の中で行い、型は `string` です。

~~~lisp
(define-signal (main-window name-set) (string))
~~~

最初のスロットを作ってボタンを `pressed` と `return-pressed` イベントに反応させます。ただしここでは上のようにメッセージボックスを作るのではなく、入力フィールドの値を載せた `name-set` シグナルを送ります。

~~~lisp
(define-slot (main-window go-button) ()
  (declare (connected go-button (pressed)))
  (declare (connected name (return-pressed)))
  (signal! main-window (name-set string) (q+:text name)))
~~~

ここまでのところ、`name-set` に反応するものはありません。そこで、これに接続してメッセージを表示する **2 つ目の slot** を作ります。ここでもパラメータの型を明示します。

~~~lisp
(define-slot (main-window name-set) ((new-name string))
  (declare (connected main-window (name-set string)))
  (q+:qmessagebox-information main-window "Greetings"
        (format NIL "Good day to you, ~a!" new-name)))
~~~

そして実行します。

~~~lisp
(with-main-window (window 'main-window))
~~~

<a id="building-and-deployment"></a>

#### ビルドと配布

バイナリをビルドし、必要な共有ライブラリすべてと一緒にまとめて配布できます。

[https://github.com/Shinmera/qtools#deployment](https://github.com/Shinmera/qtools#deployment) を読んでください。

3 つの OS 向けに自己完結型のバイナリをビルドする [この Travis CI スクリプト](https://github.com/phoe-trash/furcadia-post-splitter/blob/master/.travis.yml) も参考になるでしょう。


### Gtk3

[ドキュメント](http://www.crategus.com/books/cl-gtk/gtk-tutorial.html)は、初心者向けも含めて非常によくできています。

quickload するライブラリは `cl-cffi-gtk` です。これは数多くのライブラリから成り、自分のパッケージで `:use` する必要があります。

~~~lisp
(ql:quickload "cl-cffi-gtk")

(defpackage :gtk-tutorial
  (:use :gtk :gdk :gdk-pixbuf :gobject
   :glib :gio :pango :cairo :common-lisp))

(in-package :gtk-tutorial)
~~~

**メインループの実行の仕方**

ほかのライブラリと同じく、すべてはメインループのラッパー（ここでは `with-main-loop`）の中で起こります。

**ウィンドウの作り方**

`(make-instance 'gtk-window :type :toplevel :title "hello" ...)`。

**ウィジェットの作り方**

ウィジェットにはすべて対応するクラスがあります。`make-instance 'widget-class` で作れますが、できればコンストラクタを使うのが望ましいです。

コンストラクタは "new" で終わります（または "new" を含みます）。

```lisp
(gtk-label-new)
(gtk-button-new-with-label "Label")
```

**layout の作り方**

~~~lisp
(let ((box (make-instance 'gtk-box :orientation :horizontal
                                   :spacing 6))) ...)
~~~

続いてウィジェットをボックスに詰め込みます。

~~~lisp
(gtk-box-pack-start box mybutton-1)
~~~

そしてボックスをウィンドウに追加します。

~~~lisp
(gtk-container-add window box)
~~~

最後にすべてを表示します。

~~~lisp
(gtk-widget-show-all window)
~~~

<a id="reacting-to-events"></a>

#### イベントに反応する

`g-signal-connect` ＋対象のウィジェット＋イベント名（文字列）＋ウィジェットを引数に取る lambda、という形で使います。

~~~lisp
(g-signal-connect window "destroy"
  (lambda (widget)
    (declare (ignore widget))
    (leave-gtk-main)))
~~~

あるいは、もうひとつ例を挙げます。

~~~lisp
(g-signal-connect button "clicked"
  (lambda (widget)
    (declare (ignore widget))
    (format t "Button was pressed.~%")))
~~~

<a id="full-example"></a>

#### 完全な例

~~~lisp
(defun hello-world ()
  ;; in the docs, this is example-upgraded-hello-world-2.
  (within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Hello Buttons"
                                 :default-width 250
                                 :default-height 75
                                 :border-width 12))
          (box (make-instance 'gtk-box
                              :orientation :horizontal
                              :spacing 6)))
      (g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      (let ((button (gtk-button-new-with-label "Button 1")))
        (g-signal-connect button "clicked"
                          (lambda (widget)
                            (declare (ignore widget))
                            (format t "Button 1 was pressed.~%")))
        (gtk-box-pack-start box button))
      (let ((button (gtk-button-new-with-label "Button 2")))
        (g-signal-connect button "clicked"
                        (lambda (widget)
                          (declare (ignore widget))
                          (format t "Button 2 was pressed.~%")))
        (gtk-box-pack-start box button))
      (gtk-container-add window box)
      (gtk-widget-show-all window))))
~~~

![](assets/gui/gtk3-hello-buttons.png)


### IUP

インストール手順は上流のドキュメントで確認してください。GNU/Linux ではシステム依存パッケージが 1 つ必要になることがあり、Windows では環境変数を変更する必要があるかもしれません。

最後に、次を実行します。

~~~lisp
(ql:quickload "iup")
~~~

IUP は `:use` しません（そもそも一般的によくない習慣です）。

~~~lisp
(defpackage :test-iup
  (:use :cl))
(in-package :test-iup)
~~~

次のスニペットは、テキストラベルを表示するダイアログフレームを作ります。

~~~lisp
(defun hello ()
  (iup:with-iup ()
    (let* ((label (iup:label
                     :title
                     (format nil "Hello, World!~%IUP ~A~%~A ~A"
                       (iup:version)
                       (lisp-implementation-type)
                       (lisp-implementation-version))))
           (dialog (iup:dialog label :title "Hello, World!")))
      (iup:show dialog)
      (iup:main-loop))))
(hello)
~~~

SBCL についての重要な注意です。現時点ではゼロ除算エラーを捕捉する必要があります（[この issue](https://github.com/lispnik/iup/issues/30) の進展を見てください）。そのため、スニペットは次のように実行します。

~~~lisp
(defun run-gui-function ()
  #-sbcl (gui-function)
  #+sbcl
  (sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (gui-function)))
~~~


**メインループの起動方法**

ここまで見てきたバインディングと同様に、ウィジェットは `with-iup` マクロの中で表示し、`iup:main-loop` を呼びます。

**ウィジェットの作り方**

コンストラクタ関数はウィジェット名そのものです。`iup:label`、`iup:dialog` などです。

**ウィジェットの表示方法**

必ず "show" してください。`(iup:show dialog)` です。

ウィジェットは `frame` にまとめられ、縦 (`vbox`) や横 (`hbox`) に並べられます（下の例を参照）。

ウィンドウのリサイズ時にウィジェットを伸縮させたい場合は `:expand :yes` を使います（または `:horizontal`、`:vertical`）。

`:alignement` property も使えます。

**widget の属性の取得と設定**

属性の値を得るには `(iup:attribute widget attribute)` を使い、設定するときはそれに `setf` します。


<a id="event--2"></a>

#### イベントに反応する

ほとんどのウィジェットは `:action` パラメータを取り、1 つのパラメータ（ハンドル）を持つ lambda を受け取ります。

~~~lisp
(iup:button :title "Test &1"
            :expand :yes
            :tip "Callback inline at control creation"
            :action (lambda (handle)
                      (iup:message "title" "button1's action callback")
                      iup:+default+))
~~~

以下ではラベルを作り、その下にボタンを置きます。ボタンをクリックするとメッセージ dialog を表示します。

~~~lisp
(defun click-button ()
  (iup:with-iup ()
    (let* ((label (iup:label :title
                      (format nil "Hello, World!~%IUP ~A~%~A ~A"
                          (iup:version)
                          (lisp-implementation-type)
                          (lisp-implementation-version))))
           (button (iup:button :title "Click me"
                               :expand :yes
                               :tip "yes, click me"
                               :action
                               (lambda (handle)
                                 (declare (ignorable handle))
                                 (iup:message "title"
                                              "button clicked")
                                 iup:+default+)))
           (vbox
            (iup:vbox (list label button)
                      :gap "10"
                      :margin "10x10"
                      :alignment :acenter))
           (dialog (iup:dialog vbox :title "Hello, World!")))
      (iup:show dialog)
      (iup:main-loop))))

#+sbcl
(sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (click-button))
~~~

クリック回数のカウンターを作る似た例を示します。ラベルとその `title` に回数を保持します。`title` は整数です。

~~~lisp
(defun counter ()
  (iup:with-iup ()
    (let* ((counter (iup:label :title 0))
           (label (iup:label :title
                     (format nil "The button was clicked ~a time(s)."
                             (iup:attribute counter :title))))
           (button (iup:button :title "Click me"
                               :expand :yes
                               :tip "yes, click me"
                               :action (lambda (handle)
                                         (declare (ignorable handle))
                                         (setf (iup:attribute counter :title)
                                               (1+ (iup:attribute counter :title 'number)))
                                         (setf (iup:attribute label :title)
                                               (format nil "The button was clicked ~a times."
                                                       (iup:attribute counter :title)))
                                         iup:+default+)))
           (vbox
            (iup:vbox (list label button)
                      :gap "10"
                      :margin "10x10"
                      :alignment :acenter))
           (dialog (iup:dialog vbox :title "Counter")))
      (iup:show dialog)
      (iup:main-loop))))

(defun run-counter ()
  #-sbcl
  (counter)
  #+sbcl
  (sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (counter)))
~~~

<a id="list-widget-"></a>

#### リストウィジェットの例

以下では、単一選択と複数選択のリストウィジェットを 3 つ作り、既定値（事前選択行）を設定して、横に並べます。

~~~lisp
(defun list-test ()
  (iup:with-iup ()
    (let*  ((list-1 (iup:list :tip "List 1"  ;; tooltip
                              ;; multiple selection
                              :multiple :yes
                              :expand :yes))
            (list-2 (iup:list :value 2   ;; default index of the selected row
                              :tip "List 2" :expand :yes))
            (list-3 (iup:list :value 9 :tip "List 3" :expand :yes))
            (frame (iup:frame
                    (iup:hbox
                     (progn
                       ;; populate the lists: display integers.
                       (loop for i from 1 upto 10
                          do (setf (iup:attribute list-1 i)
                                   (format nil "~A" i))
                          do (setf (iup:attribute list-2 i)
                                   (format nil "~A" (+ i 10)))
                          do (setf (iup:attribute list-3 i)
                                   (format nil "~A" (+ i 50))))
                       ;; hbox wants a list of widgets.
                       (list list-1 list-2 list-3)))
                    :title "IUP List"))
            (dialog (iup:dialog frame :menu "menu" :title "List example")))

      (iup:map dialog)
      (iup:show dialog)
      (iup:main-loop))))

(defun run-list-test ()
  #-sbcl (hello)
  #+sbcl
  (sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (list-test)))
~~~

### Nuklear

**注意**: 執筆時点で著者の言葉によれば、bodge-ui はまだ開発初期段階で、一般利用には未対応です。修正が必要な癖がいくつかあり、API に変更が入る可能性があります。

`bodge-ui` は Quicklisp 本体ではなく、独自の Quicklisp distribution にあります。まずそれをインストールします。

~~~lisp
(ql-dist:install-dist "http://bodge.borodust.org/dist/org.borodust.bodge.txt" :replace t :prompt nil)
~~~

OpenGL 2 renderer を有効にしたい場合だけ、この行のコメントを外して評価します。

~~~lisp
;; (cl:pushnew :bodge-gl2 cl:*features*)
~~~

`bodge-ui-window` を quickload します。

~~~lisp
(ql:quickload "bodge-ui-window")
~~~

組み込み例を実行できます。

~~~lisp
(ql:quickload "bodge-ui-window/examples")
(bodge-ui-window.example.basic:run)
~~~

では、簡単なアプリケーションを書くためのパッケージを定義します。

~~~lisp
(cl:defpackage :bodge-ui-window-test
  (:use :cl :bodge-ui :bodge-host))
(in-package :bodge-ui-window-test)
~~~

~~~lisp
(defpanel (main-panel
           (:title "Bodge UI へようこそ")
           (:origin 200 50)
           (:width 400) (:height 400)
           (:options :movable :resizable
                     :minimizable :scrollable
                     :closable))
    (label :text "入れ子の widget:")
  (horizontal-layout
   (radio-group
    (radio :label "選択肢 1")
    (radio :label "選択肢 2" :activated t))
   (vertical-layout
    (check-box :label "チェック 1" :width 100)
    (check-box :label "チェック 2"))
   (vertical-layout
    (label :text "左寄せ" :align :left)
    (label :text "中央" :align :centered)
    (label :text "右寄せ" :align :right)))
  (label :text "幅に応じて伸縮:")
  (horizontal-layout
   (button :label "可変")
   (button :label "最小幅" :width 80)
   (button :label "固定幅" :expandable nil :width 100))
  (label :text "幅に応じて伸縮:")
  (horizontal-layout
   (button :label "1.0" :expand-ratio 1.0)
   (button :label "0.75" :expand-ratio 0.75)
   (button :label "0.5" :expand-ratio 0.5))
  (label :text "残り:")
  (button :label "最上位ボタン"))

(defparameter *window-width* 800)
(defparameter *window-height* 600)

(defclass main-window (bodge-ui-window:ui-window) ()
  (:default-initargs
   :title "Bodge UI Window の例"
   :width *window-width*
   :height *window-height*
   :panels '(main-panel)
   :floating t
   :opengl-version #+bodge-gl2 '(2 1)
                   #+bodge-gl2 '(3 3)))


(defun run ()
  (bodge-host:open-window (make-instance 'main-window)))
~~~

そして実行します。

~~~lisp
(run)
~~~

![](assets/gui/nuklear-test.png)

イベントに反応するには、次のシグナルを使います。

```
:on-click
:on-hover
:on-leave
:on-change
:on-mouse-press
:on-mouse-release
```

これらは引数 1 つ、つまりパネルを取る関数を受け取ります。ただし注意してください。ウィジェットがその状態にあるあいだは描画 cycle ごとに呼ばれるため、かなり頻繁になることがあります。


#### 対話的開発

REPL で例を動かしただけでは、何が面白いかは見えません。コードを Lisp ファイルに入れて実行し、ウィンドウを出してください。そうすればパネルウィジェットやレイアウトを変えたとき、その変更がアプリケーションの実行中に即座に反映されるのが分かります。


## まとめ

楽しんでください。体験談やアプリケーションの共有も遠慮なくどうぞ。


[tk]: https://www.tcl.tk
[ltk]: http://www.peter-herth.de/ltk/ltkdoc/
[nodgui]: https://codeberg.org/cage/nodgui
[qt4]: https://doc.qt.io/archives/qt-4.8/index.html
[gtk]: https://www.gtk.org/
[qtools]: https://github.com/Shinmera/qtools
[cl-cffi-gtk]: https://github.com/Ferada/cl-cffi-gtk/
[iup-tecgraf]: http://webserver2.tecgraf.puc-rio.br/iup/
[iup-lisp]: https://github.com/lispnik/iup/
[gnome]: https://www.gnome.org/
[nuklear]: https://github.com/Immediate-Mode-UI/Nuklear
[bodge-nuklear]: https://github.com/borodust/bodge-nuklear
[capi]: http://www.lispworks.com/products/capi.html
[ceramic]: http://ceramic.github.io/
