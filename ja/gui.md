---
title: GUI toolkits
---

Lisp には長く豊かな歴史があり、GUI 開発にも同じことが言えます。実際、最初の GUI ビルダーは Lisp で書かれました（そして Apple に売却され、今では Interface Builder になっています）。

Lisp は対話的開発能力でも有名で、GUI アプリケーション開発ではこの利点がさらに大きくなります。関数 1 つをコンパイルしただけで GUI が即座に更新される様子を想像できるでしょうか。今日では多くの GUI framework でこれが可能ですが、細部はそれぞれ異なります。

最後に、ソフトウェア開発では、どうビルドしてどう利用者へ届けるかも重要です。ここでも、主要な 3 つの OS 向けに自己完結型 binary を作り、利用者がダブルクリックで実行できるようにできます。

ここでは、適切な GUI framework を選ぶための情報を整理して示します。[contribute](https://github.com/LispCookbook/cl-cookbook/issues/) して、さらに例を追加したり、元のドキュメントを補ったりするのは歓迎です。


## Introduction

このレシピでは、次の GUI toolkit を紹介します。

- [Tk][tk] と [Ltk][ltk] / [nodgui][nodgui]
- [Qt4][qt4] と [Qtools][qtools]
- [IUP][iup-tecgraf] と [lispnik/iup][iup-lisp]
- [Gtk3][gtk] と [cl-cffi-gtk][cl-cffi-gtk]
  - Gtk4 の bindings が欲しい場合は [cl-gtk4](https://github.com/bohonghuang/cl-gtk4) を見てください。これは 2022 年 9 月に公開された新しい bindings です。

- [Nuklear][nuklear] と [Bodge-Nuklear][bodge-nuklear]

加えて、次のものも見ておくとよいでしょう。

- [CAPI][capi] toolkit（Common Application Programming Interface）,
  これは LispWorks 製の proprietary な toolkit です。Windows、Gtk+、Cocoa をまたぐ完全な cross-platform toolkit で、利用者の評判も高いです。LispWorks には [iOS と Android の runtimes](http://www.lispworks.com/products/lw4mr.html) もあります。CAPI で作られた例として [ScoreCloud](https://scorecloud.com/) があります。LispWorks の free demo で試せます。
- [Allegro CL の IDE と Common Graphics windowing system](https://franz.com/products/allegro-common-lisp/acl_ide.lhtml)（proprietary）: Allegro の IDE は application 開発のための一般的な environment です。Common Graphics という windowing system と連携して動きます。この IDE は、Allegro CL の Microsoft Windows 版、Linux platform、Free BSD、Mac 版で利用できます。
  - NEW! 🎉 Allegro CL 10.1（2022 年 3 月公開）以降、IDE と Common Graphics GUI toolkit は browser 上で動きます。これを [CG/JS](https://franz.com/ftp/pri/acl/cgjs/doc.html) と呼びます。
- [CCL の組み込み Cocoa
  interface](https://ccl.clozure.com/docs/ccl.html#the-objective-c-bridge),
  [Opusmodus](https://opusmodus.com/) のような application を作るのに使われています。
- Clozure CL の組み込み [Objective-C bridge](https://ccl.clozure.com/docs/ccl.html#the-objective-c-bridge) と [CocoaInterface](https://github.com/plkrueger/CocoaInterface/) は、CCL 向けの Cocoa interface です。Lisp code だけで Cocoa の user interface window を動的に作れ、典型的な Xcode の手順を飛ばせます。
  - この bridge は ObjC エラーを拾って Lisp エラーに変換するのが得意なので、macOS GUI application でも REPL ベースの反復開発サイクルを回せます。
* [McCLIM](https://common-lisp.net/project/mcclim/) と [Garnet](https://github.com/earl-ducaine/cl-garnet) は 100% Common Lisp の toolkit です。McCLIM には Broadway protocol で browser 上で動く [プロトタイプ](https://techfak.de/~jmoringe/mcclim-broadway-7.ogv) があり、Garnet には Gtk への継続的な interface があります。
* [Alloy](https://github.com/Shirakumo/alloy) は、これも新しめの 100% Common Lisp toolkit で、たとえば [Kandria](https://github.com/shinmera/kandria) ゲームで使われています。
* [eql, eql5, eql5-android](https://gitlab.com/eql) は、ECL に埋め込まれ、Qt にも埋め込める Qt4/Qt5 Lisp です。EQL5 の Android 移植版もあります。
* [ABCL から Java Swing を使うデモ](https://github.com/defunkydrummer/abcl-jazz)
* [SBCL で C ファイルなしに Gtk を使う例](https://github.com/mifpasoti/Gtk-Demos) と GTK-server。
* [Ceramic][ceramic] は、Electron で cross-platform web app を配布するためのものです。
  * 詳しくは Web Apps in Lisp の [Electron](https://web-apps-in-lisp.github.io/building-blocks/electron/index.html) と [web view (webview, webui, CLOG Frame)](https://web-apps-in-lisp.github.io/building-blocks/web-views/index.html) を見てください。
* [Barium toolkit](https://tomscii.sig7.se/barium/)
  * 例の application: [ChessLab](https://tomscii.sig7.se/chesslab/) (2025)

そのほか、[awesome-cl#gui](https://github.com/CodyReichert/awesome-cl#Gui) と [Cliki](https://www.cliki.net/GUI) にあるものも参照してください。

### Tk (Ltk and nodgui)

[Tk][tk]（あるいは Tcl/Tk。Tcl が programming language です）は、古臭い見た目だという悪評があります。ですが、それは今では（それほど）当てはまりません。1997 年の version 8 以降は特にそうです。たぶん、思っているより良いものです。

これは nodgui の組み込み theme を使ったシンプルな GUI です（詳細は後述）。

![](assets/gui/nodgui-feet2meters-yaru.png)

同じ theme の treeview です。

![](assets/gui/nodgui-treeview-yaru.png)

Arc theme を使った、tree list、checkbox、button、label を表示するおもちゃの media player です。

![](assets/gui/mediaplayer-nodgui-arc.png)

MacOS theme の demo です。

![](assets/gui/ltk-on-macos.png)

これらに加えて、[ttkthemes](https://ttkthemes.readthedocs.io/en/latest/themes.html) や [Forest theme](https://github.com/rdbende/Forest-ttk-theme) など多数の theme を使えます。[この tcl/tk の一覧](https://wiki.tcl-lang.org/page/List+of+ttk+Themes) を見てください。

では Tk は何に向いているのでしょうか。Tk の widget の種類は豊富ではありませんが、便利な canvas があり、さらにいくつか独自の特徴があります。GUI を **完全に対話的に** 開発でき、core app から GUI を **遠隔実行** できます。しかも cross-platform です。

つまり Tk は native ではなく、最先端の機能を備えているわけでもありませんが、実績のある GUI toolkit（兼 programming language）で、今も業界で使われています。単純な GUI を素早く作りたいとき、配布のしやすさを重視したいとき、安定性が必要なときに向いています。

Lisp bindings は 2 つあります。[Ltk][ltk] と [nodgui][nodgui] です。Nodgui（"No Drama GUI"）は Ltk の fork で、追加 widget（たとえば auto-completion list widget）、非同期 event loop、そして何よりライブラリに付属する意外と見栄えの良い "Yaru" theme を備えています。ほかの theme を入れて使うのも簡単です。詳細は後述します。

- **Tk is Written in**: Tcl
- **Portability**: cross-platform (Windows, macOS, Linux).

- **Widgets**: Tk は widget の豊富さが売りではありません。既定 widget は **少数** で、date picker のような重要なものが欠けています。拡張（**Nodgui** など）で補えますが、あまり native には見えません。calendar は Tk extension が提供しており、こちらのほうが見栄えがよいです。

- **Interactive development**: 非常に向いています。

- **Graphical builder**: なし

- **Other features**:
  - **remote execution**: Lisp と Tcl/Tk の接続は stream 経由で行われます。そのため、Lisp program を 1 台の computer で動かし、GUI を別の computer に表示できます。client 側に必要なのは tcl/tk のインストールと remote.tcl script だけです。[Ltk-remote](http://www.peter-herth.de/ltk/ltkdoc/node46.html) を見てください。

- **Bindings documentation**: 短いですが十分です。Nodgui も同様です。
- **Bindings stability**: とても安定しています。
- **Bindings activity**: Ltk は低め（主に maintenance）、Nodgui は活発（新機能あり）です。
- **Licence**: Tcl/Tk は BSD 風、Ltk は LGPL です。
- 例:
  - [Fulci](https://notabug.org/cage/fulci/) - movie collection を整理する program です。
  - [Ltk small games](https://github.com/mijohnson99/ltk-small-games) - snake と tic-tac-toe です。
  - [cl-pkr](https://github.com/VitoVan/cl-pkr) - cross-platform の color picker です。
  - [cl-torrents](https://github.com/vindarel/cl-torrents) - 人気 tracker の torrent を検索します。CLI、readline、シンプルな Tk GUI を備えています。
- 追加の例:
  - [https://peterlane.netlify.app/ltk-examples/](https://peterlane.netlify.app/ltk-examples/): [tkdocs](https://tkdocs.com/tutorial/index.html) tutorial 向けの LTk 例です。
  - [LTk Plotchart](https://peterlane.netlify.app/ltk-plotchart/) - tklib/plotchart library を LTk で使うための wrapper です。xy plot、gantt chart、3d bar chart など 20 種類以上の chart を含みます。


**widget 一覧**

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

Qt と [Qt4][qt4] を改めて紹介する必要があるでしょうか。Qt は非常に大きく、何でも入っています。UI widget だけでなく、networking や D-BUS など多くの層を提供します。

Qt は open-source software なら無料で使えますが、proprietary software を配布する場合は条件を確認してください。

[Qtools][qtools] bindings は Qt4 を対象にしています。Qt5 の Lisp bindings は [https://github.com/commonqt/commonqt5/](in the works) で、まだ本番向けではありません。

Qtools の companion library として、最初の Qtools application を作ったらぜひ見ておきたいのが [Qtools-ui](https://github.com/Shinmera/qtools-ui) です。便利な widget と既成 component の集まりで、短い [デモ動画](https://www.youtube.com/playlist?list=PLkDl6Irujx9Mh3BWdBmt4JtIrwYgihTWp) もあります。

<!-- possible future: gobject-introspection -->

- **Framework written in**: C++
- **Framework Portability**: multi-platform, Android, embedded systems, WASM.
- **Bindings Portability**: Qtools は Windows、macOS、GNU/Linux の x86 desktop platform で動きます。

- **Widgets choice**: 豊富。

- **Graphical builder**: あり。

- **Other features**: web browser など多数。

- **Bindings documentation**: 詳しい説明と少数の例があります。Qt の事前知識が必要です。
- **Bindings stability**: 安定。
- **Bindings activity**: 活発。
- **Qt Licence**: 商用と open source の両方があります。
- 例:
  - https://github.com/Shinmera/qtools/tree/master/examples
  - https://github.com/Shirakumo/lionchat
  - https://github.com/shinmera/halftone - シンプルな image viewer


### Gtk+3 (cl-cffi-gtk)

[Gtk+3][gtk] は [GNOME][gnome] application を作る主要 library です。Lisp bindings としては、現時点で最も進んでいるものが [cl-cffi-gtk][cl-cffi-gtk] です。主に GNU/Linux 向けに作られましたが、Gtk は macOS でも問題なく動き、今では Windows でも使えます。


- **Framework written in**: C
- **Portability**: GNU/Linux と macOS、Windows でも可。

- **Widgets choice**: 豊富。

- **Graphical builder**: あり: Glade。
- **Other features**: web browser (WebKitGTK)

- **Bindings documentation**: とても良いです: http://www.crategus.com/books/cl-gtk/gtk-tutorial.html
- **Bindings stability**: 安定。
- **Bindings activity**: 活動量は少なめですが、開発は続いています。
- **Licence**: LGPL
- 例:
  - Glade で作られた [Atmosphere Calculator](https://github.com/ralph-schleicher/atmosphere-calculator)。
- 追加の documentation と例:
  - [Learn Common Lisp by Example: GTK GUI with SBCL](https://dev.to/goober99/learn-common-lisp-by-example-gtk-gui-with-sbcl-5e5c)


### IUP (lispnik/IUP)

[IUP][iup-tecgraf] は、ブラジルのリオデジャネイロ・カトリック大学で活発に開発されている cross-platform GUI toolkit です。**native control** を使い、Windows では Windows API、GNU/Linux では Gtk3 を使います。執筆時点では Cocoa 版も開発中で、iOS、Android、WASM 版もあります。IUP の特徴は **API が小さい** ことです。

[Lisp bindings] は [lispnik/iup](https://github.com/lispnik/iup/) です。C source から自動生成されているため、よくできています。新しい IUP version に追従する手間が少なく、必要な手順も文書化されています。これにより bus factor の面でも安心です。

IUP は Tk と Gtk/Qt の中間にある、非常に良い選択肢です。

- **Framework written in**: C（公式 API は Lua と LED にもあります）
- **Portability**: Windows と Linux、Cocoa、iOS、Android、WASM 版も作業中です。

- **Widgets choice**: 中程度。web browser window を含みます（Linux では WebkitGTK、Windows では IE の WebBrowser）。

- **Graphical builder**: あり: [IupVisualLED](http://webserver2.tecgraf.puc-rio.br/iup/en/iupvisualled.html)

- **Other features**: OpenGL、web browser（GNU/Linux では WebKitGTK）、plotting、Scintilla text editor

- **Bindings documentation**: 例と README は良いですが、それ以外は少なめです。
- **Bindings stability**: alpha（ただし完全に生成されていて、問題なく動きます）。
- **Bindings activity**: 少なめですが安定していて、新しい IUP version にも反応します。
- **Licence**: IUP も bindings も MIT license です。


**List of widgets**

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

[Nuklear][nuklear] は小さな [immediate-mode](https://en.wikipedia.org/wiki/Immediate_mode_GUI) GUI toolkit です。

> [Nuklear] is a minimal-state, immediate-mode graphical user interface toolkit written in ANSI C and licensed under public domain. It was designed as a simple embeddable user interface for application and does not have any dependencies, a default render backend or OS window/input handling but instead provides a highly modular, library-based approach, with simple input state for input and draw commands describing primitive shapes as output. So instead of providing a layered library that tries to abstract over a number of platform and render backends, it focuses only on the actual UI.

Lisp bindings は [Bodge-Nuklear][bodge-nuklear] で、上位の companion として [bodge-ui](https://github.com/borodust/bodge-ui) と [bodge-ui-window](https://github.com/borodust/bodge-ui-window) があります。

従来の UI framework と違い、Nuklear では描画ループや input 管理を開発者が引き継げます。設定は少し増えますが、ゲームや、新しい control を作りたい application には特に向いています。


- **Framework written in**: ANSI C、single-header library。
- **Portability**: C が動くところならどこでも。Nuklear には platform-specific code は含まれていません。OS や window の直接処理も Nuklear では行われません。その代わり、*すべての input state を platform-specific code が提供する必要があります*。

- **Widgets choice**: 少ない。

- **Graphical builder**: なし。

- **Other features**: skin と customization が完全に可能。

- **Bindings stability**: 安定。
- **Bindings activity**: 活発。
- **Licence**: MIT か Public Domain（unlicense）。
- Example applications:
  - [Trivial-gamekit](https://github.com/borodust/trivial-gamekit)
  - [Obvius](https://github.com/thicksteadTHpp/Obvius/) - a resurrected image processing library.
  - [Notalone](https://github.com/borodust/notalone) - an autumn 2017 Lisp Game Jam entry.

**List of widgets**

抜粋です。

```
buttons, progressbar, image selector, (collapsable) tree, list, grid, range, slider, color picker,
date-picker
```

![](assets/gui/nuklear.png)

## Getting started

### Tk

Ltk is quick and easy to grasp.

~~~lisp
(ql:quickload "ltk")
(in-package :ltk-user)
~~~


**How to create widgets**

All widgets are created with a regular `make-instance` and the widget name:

~~~lisp
(make-instance 'button)
(make-instance 'treeview)
~~~

This makes Ltk explorable with the default symbol completion.

**How to start the main loop**

As with most bindings, the GUI-related code must be started inside a macro that
handles the main loop, here `with-ltk`:

~~~lisp
(with-ltk ()
  (let ((frame (make-instance 'frame)))
    …))
~~~

**How to display widgets**

widget を作ったら、layout に配置する必要があります。Tk にはいくつか配置方法がありますが、今使うべきなのは `grid` です。`grid` は widget、列、行、いくつかの optional parameter を引数に取る関数です。

通常の Lisp code と同じく、関数の signature は editor に出ます。これも Ltk をたどりやすくしてくれます。

button を表示する例です。

~~~lisp
(with-ltk ()
  (let ((button (make-instance 'button :text "hello")))
    (grid button 0 0)))
~~~

やることはそれだけです。


#### event に反応する

多くの widget には `:command` argument があり、widget の event が発生したときに実行される lambda を受け取ります。button の場合はクリック時です。

~~~lisp
(make-instance 'button
  :text "Hello"
  :command (lambda ()
             (format t "clicked")))
~~~


#### 対話的開発

`(start-wish)` で Tk process を background で起動すると、widget を作って grid に置く作業を対話的に行えます。

詳しくは [ドキュメント](http://www.peter-herth.de/ltk/ltkdoc/node8.html) を見てください。

終わったら `(exit-wish)` を呼びます。


#### Nodgui

Nodgui の demo を試すには次のようにします。

~~~lisp
(ql:quickload "nodgui")
(nodgui.demo:demo)
~~~

見た目のよい theme で demo を読み込むなら、次のようにします。

~~~lisp
(nodgui.demo:demo :theme "yaru")
~~~

or

~~~lisp
(setf nodgui:*default-theme* "yaru")
(nodgui.demo:demo)
~~~

#### Nodgui UI theme

nodgui に付属する "yaru" theme を使うには、単純に次のようにします。

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

別の tcl theme をインストールして読み込むこともできます。たとえば [Forest ttk theme](https://github.com/rdbende/Forest-ttk-theme) や [ttkthemes](https://github.com/TkinterEP/ttkthemes/) を clone します。project directory は次のようになります。

```
yourgui.asd
yourgui.lisp
ttkthemes/
```

`ttkthemes/` の中では `png/` directory に theme があり、それ以外は現時点で未対応です。

    /ttkthemes/ttkthemes/png/arc/arc.tcl

nodgui で .tcl file を読み込み、この theme を使うよう指示します。

~~~lisp
(with-nodgui ()
   (eval-tcl-file "/ttkthemes/ttkthemes/png/arc/arc.tcl")
   (use-theme "arc")
   … code here …)
~~~

これで終わりです。application は新しい、そこそこ見栄えのよい GUI theme を使うようになります。

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

残りを入れる main widget を作ります。

~~~lisp
(define-widget main-window (QWidget)
  ())
~~~

この main widget の中に input field と button を作ります。

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

これで形はできましたが、まだ click event には反応していません。

#### event に反応する

Qt で event に反応するには signal と slot を使います。**slot** は signal を受け取る、あるいは signal に "接続する" 関数で、**signal** は event の運び手です。

widget はすでに自前の signal を送っています。たとえば button は "pressed" event を送ります。そのため、たいていはそれに接続するだけで済みます。

ただし、必要なら独自の signal 群を作ることもできます。

##### 組み込み event

`go-button` を `pressed` と `return-pressed` event に接続し、message box を表示します。

- これを `define-slot` 関数の中で行い、
- その中で event への接続を確立し、
- さらに message box を作ります。`name` input field の text は `(q+:text name)` で取得します。

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

##### 独自 event

上と同じ機能を実装しますが、説明のために button クリック時に発火する `name-set` という独自 signal を作ります。

まず signal を定義します。これは `main-window` の中で行い、型は `string` です。

~~~lisp
(define-signal (main-window name-set) (string))
~~~

最初の slot を作って button を `pressed` と `return-pressed` event に反応させます。ただしここでは上のように message box を作るのではなく、input field の値を載せた `name-set` signal を送ります。

~~~lisp
(define-slot (main-window go-button) ()
  (declare (connected go-button (pressed)))
  (declare (connected name (return-pressed)))
  (signal! main-window (name-set string) (q+:text name)))
~~~

So far, nobody reacts to `name-set`. We create a **second slot** that
connects to it, and displays our message. Here again, we precise the
parameter type.

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

#### Building and deployment

It is possible to build a binary and bundle it together with all the
necessary shared libraries.

Please read [https://github.com/Shinmera/qtools#deployment](https://github.com/Shinmera/qtools#deployment).

You might also like [this Travis CI script](https://github.com/phoe-trash/furcadia-post-splitter/blob/master/.travis.yml) to build a self-contained binary for the three OSes.


### Gtk3

The
[documentation](http://www.crategus.com/books/cl-gtk/gtk-tutorial.html)
is exceptionally good, including for beginners.

The library to quickload is `cl-cffi-gtk`. It is made of numerous
ones, that we have to `:use` for our package.

~~~lisp
(ql:quickload "cl-cffi-gtk")

(defpackage :gtk-tutorial
  (:use :gtk :gdk :gdk-pixbuf :gobject
   :glib :gio :pango :cairo :common-lisp))

(in-package :gtk-tutorial)
~~~

**How to run the main loop**

As with the other libraries, everything happens inside the main loop
wrapper, here `with-main-loop`.

**How to create a window**

`(make-instance 'gtk-window :type :toplevel :title "hello" ...)`.

**How to create a widget**

All widgets have a corresponding class. We can create them with
`make-instance 'widget-class`, but we preferably use the constructors.

The constructors end with (or contain) "new":

```lisp
(gtk-label-new)
(gtk-button-new-with-label "Label")
```

**How to create a layout**

~~~lisp
(let ((box (make-instance 'gtk-box :orientation :horizontal
                                   :spacing 6))) ...)
~~~

then pack a widget onto the box:

~~~lisp
(gtk-box-pack-start box mybutton-1)
~~~

and add the box to the window:

~~~lisp
(gtk-container-add window box)
~~~

and display them all:

~~~lisp
(gtk-widget-show-all window)
~~~

#### Reacting to events

Use `g-signal-connect` + the concerned widget + the event name (as a
string) + a lambda, that takes the widget as argument:

~~~lisp
(g-signal-connect window "destroy"
  (lambda (widget)
    (declare (ignore widget))
    (leave-gtk-main)))
~~~

Or again:

~~~lisp
(g-signal-connect button "clicked"
  (lambda (widget)
    (declare (ignore widget))
    (format t "Button was pressed.~%")))
~~~

#### Full example

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

Please check the installation instructions upstream. You may need one
system dependency on GNU/Linux, and to modify an environment variable
on Windows.

Finally, do:

~~~lisp
(ql:quickload "iup")
~~~

We are not going to `:use` IUP (it is a bad practice generally after all).

~~~lisp
(defpackage :test-iup
  (:use :cl))
(in-package :test-iup)
~~~

The following snippet creates a dialog frame to display a text label.

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

ここまで見てきた bindings と同様に、widget は `with-iup` macro の中で表示し、`iup:main-loop` を呼びます。

**widget の作り方**

constructor 関数は widget 名そのものです。`iup:label`、`iup:dialog` などです。

**widget の表示方法**

必ず "show" してください。`(iup:show dialog)` です。

widget は `frame` にまとめられ、縦 (`vbox`) や横 (`hbox`) に並べられます（下の例を参照）。

window のリサイズ時に widget を伸縮させたい場合は `:expand :yes` を使います（または `:horizontal`、`:vertical`）。

`:alignement` property も使えます。

**widget の attribute の取得と設定**

attribute の値を得るには `(iup:attribute widget attribute)` を使い、設定するときはそれに `setf` します。


#### event に反応する

ほとんどの widget は `:action` parameter を取り、1 つの parameter（handle）を持つ lambda を受け取ります。

~~~lisp
(iup:button :title "Test &1"
            :expand :yes
            :tip "Callback inline at control creation"
            :action (lambda (handle)
                      (iup:message "title" "button1's action callback")
                      iup:+default+))
~~~

以下では label を作り、その下に button を置きます。button をクリックすると message dialog を表示します。

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

クリック回数の counter を作る似た例を示します。label とその title に回数を保持します。title は整数です。

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

#### list widget の例

以下では、単一選択と複数選択の list widget を 3 つ作り、既定値（事前選択行）を設定して、横に並べます。

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

組み込み example を実行できます。

~~~lisp
(ql:quickload "bodge-ui-window/examples")
(bodge-ui-window.example.basic:run)
~~~

では、簡単な application を書くための package を定義します。

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

and run it:

~~~lisp
(run)
~~~

![](assets/gui/nuklear-test.png)

event に反応するには、次の signal を使います。

```
:on-click
:on-hover
:on-leave
:on-change
:on-mouse-press
:on-mouse-release
```

これらは引数 1 つ、つまり panel を取る関数を受け取ります。ただし注意してください。widget がその state にあるあいだは描画 cycle ごとに呼ばれるため、かなり頻繁になることがあります。


#### 対話的開発

REPL で example を動かしただけでは、何が面白いかは見えません。code を Lisp file に入れて実行し、window を出してください。そうすれば panel widget や layout を変えたとき、その変更が application の実行中に即座に反映されるのが分かります。


## まとめ

楽しんでください。体験談や application の共有も遠慮なくどうぞ。


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
