---
title: LispWorks レビュー
---

[LispWorks](http://www.lispworks.com/) は Common Lisp の処理系で、独自の統合開発環境（IDE）と、CAPI GUI ツールキットのような独自機能を備えています。これは**プロプライエタリ**で、**無料の制限版**も提供されています。

ここでは主にその IDE を見ていきます。Emacs と Slime に慣れた Lisp ユーザに何を提供できるのか、という観点です。短く言えば、扱いやすいグラフィカルステッパ、トレーサ、コードカバレッジブラウザ、クラスブラウザといった、より多くのグラフィカルツールがあります。ブレークポイントの設定と利用も Slime より簡単でした。

LispWorks はさらに統合されたツールも提供します。たとえばプロセス browser は Lisp イメージ内で実行中の全プロセスを一覧し、それらを停止、break、debug できます。また、多くの情報をグラフ形式で表示します。たとえば関数呼び出しのグラフや、作成された全ウィンドウのグラフです。

![Mate デスクトップ環境での LispWorks の listener と editor](assets/lispworks/two-sided-view.png "Mate デスクトップ環境での LispWorks の listener と editor")

## LispWorks の機能

LispWorks の機能をエディションとプラットフォーム別にまとめた表はここで見られます: [http://www.lispworks.com/products/features.html](http://www.lispworks.com/products/features.html)。

注目点:

- Windows、MacOS、Linux、Solaris、FreeBSD での 32-bit、64-bit、ARM サポート
- [CAPI portable GUI ツールキット](http://www.lispworks.com/documentation/lw61/CAPRM/html/capiref.htm): Windows、Cocoa、GTK+、Motif でネイティブな look-and-feel を提供します。
  - グラフィカルな "Interface Builder"（QtCreator のようなもの）が付属します（ただし MacOS では利用できません（mobile でも利用できません））
- Android と iOS 向けの [LispWorks for mobile runtime](http://www.lispworks.com/products/lw4mr.html)
- 最適化されたアプリケーション配布: LispWorks は tree shaker を使って、配布アプリケーションから未使用の Lisp コードを取り除けます。そのため、既存のオープンソース処理系より軽いバイナリを配布できます。
- dynamic ライブラリとして配布できること
- Lisp から Java を呼ぶ、またはその逆を可能にする [Java インターフェイス](http://www.lispworks.com/documentation/lw71/LW/html/lw-113.htm)
- Objective-C と Cocoa のインターフェイス。drag and drop と multi-touch をサポート
- Foreign Language Interface
- SSL と IPv6 をサポートする TCP/UDP sockets
- ネイティブスレッドと symmetric multiprocessing、unicode サポート、その他すべての Common Lisp 機能、そしてその他すべての LispWorks Enterprise 機能

そしてもちろん、組み込み IDE があります。

LispWorks は産業界のさまざまな分野で使われています。開発元は [success stories の一覧](http://www.lispworks.com/success-stories/index.html)を管理しています。私たち自身が使えるソフトウェアとしては、[ScoreCloud](https://scorecloud.com/)（楽器を弾いたり、歌ったり、口笛を吹いたりすると楽譜を書いてくれる音楽記譜ソフトウェア）や [OpenMusic](https://github.com/openmusic-project/openmusic/)（オープンソースの作曲環境）が見事です。


### Free edition の制限

ダウンロード手順と制限は[ダウンロードページ](http://www.lispworks.com/downloads/index.html)に示されています。

制限は次のとおりです。

- **heap size limit** があります。これを超えるとイメージは終了します。制限に近づくと警告が出ます。

何ができなくなるのでしょうか。例として、同じイメージ内で次のライブラリ群をまとめてロードすることはできません。

~~~lisp
(ql:quickload '("alexandria" "serapeum" "bordeaux-threads"
    "lparallel" "dexador" "hunchentoot" "quri"
    "cl-ppcre" "mito"))
~~~

- 各セッションには**5 時間の時間制限**があります。その後 LispWorks Personal は終了し、作業内容の保存や、一時ファイル削除などの cleanup を行わない可能性があります。4 時間使用すると警告されます。

- **バイナリを作成できません**。実際、[save-image](http://www.lispworks.com/documentation/lw71/LW/html/lw-95.htm)、[deliver](http://www.lispworks.com/documentation/lw71/DV/html/delivery-4.htm#pgfId-852223)（スタンドアロン実行ファイルを作成するための*その*関数）、load-all-patches は利用できません。

- **初期化ファイルはロードされません**。Emacs で `~/.sbclrc` から Quicklisp を初期化することに慣れている場合、LispWorks を起動するたびに init file を手動でロードする必要があります（`(load #p"~/.your-init-file`））。

参考までに、startup file に入れるために Quicklisp が提供する snippet は次のとおりです。

~~~lisp
;; quicklisp を ~/quicklisp/ にインストールしている場合
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
~~~

これを listener ウィンドウに貼り付ける必要があります（`C-y` キー、y は "yank" の y です）。

- LispWorks Professional と Enterprise Editions の一部である layered products（CLIM、KnowledgeWorks、Common SQL、LispWorks ORB）は含まれていません。ただし、**CAPI ツールキットは試せます**。

インストール手順では、ダウンロードリンクを受け取るために HTML フォームへ入力し、次に terms と licence への同意を求める最初の script を実行し、さらにソフトウェアをインストールする 2 つ目の script を実行します。

### ライセンスモデル

LispWorks には実際には 4 つの有料エディションがあります。ここで自分たちで説明しています: [http://www.lispworks.com/products/lispworks.html](http://www.lispworks.com/products/lispworks.html)。要約すると次のとおりです。

- Hobbyist edition: `save-image` と `load-all-patches` があり、minor version の更新を適用できます。明らかな制限はありませんが、非商用かつ非学術利用向けです。
- HobbyistDV edition: 実行ファイルを作成するための `deliver` 関数があります（これも非商用かつ非学術利用向け）。
- Professional edition: `deliver` 関数があり、商用および学術利用向けです。
- Enterprise edition: Common SQL インターフェイス、LispWorks ORB、KnowledgeWorks といった enterprise modules を含みます。

執筆時点では、hobbyist edition のライセンスは 750 USD、pro version はその倍です。これらは LW のバージョンごと、プラットフォームごとに購入します。時間制限はありません。

<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> upstream のリソースを必ず再確認し、遠慮なく問い合わせてください。
</div>


## LispWorks IDE

LispWorks IDE は自己完結していますが、Emacs と Slime から LispWorks という処理系を使うこともできます（下記参照）。IDE は Common Lisp イメージの*内部*で動作します。これは、Swank と Slime を通じて Lisp イメージと通信する外部プログラムである Emacs とは異なります。ユーザコードは同じプロセスで実行されます。

### エディタ

エディタは期待どおりの機能を提供します。TAB 補完の pop-up、syntax highlighting、Emacs 風 keybindings（`M-x` extended command を含む）です。メニューは機能発見を助けます。

個人的には、編集体験はやや「素朴」だと感じました。たとえば:

- 改行後の indent は自動ではなく、もう一度 TAB を押す必要があります。
- auto-completion は fuzzy ではありません。
- ~~Paredit~~ に似た plugins（まったく新しい（2021）[Paredit for LispWorks](https://github.com/g000001/lw-paredit) はあります）や Lispy、Vim layer はありません。

また、`M-.` に割り当てられた go-to-source 関数が組み込み Lisp シンボルではうまく動かないという問題もありました。どうやら LispWorks はあまり多くの source code を提供しておらず、主に editor のコードだけのようです。Allegro CL のような別の commercial Lisps は、より多くの source code を提供しています。

エディタには興味深いタブがあります: Changed Definitions です。これは、選択に応じて、セッションの最初の編集、最後の保存、最後の compile 以降に再定義された関数とメソッドを一覧します。

関連項目:

- [Editor User Guide](http://www.lispworks.com/documentation/lw71/EDUG-U/html/eduser-u.htm)


### Keybindings

ほとんどの keybindings は Emacs と似ていますが、すべてではありません。いくつかの違いを挙げます。

- **関数を compile する**には、C-c C-c ではなく `C-S-c`（control、shift、c）を使います。
- **現在の buffer を compile する**には、C-c C-k ではなく `C-S-b` を使います。

似ているものには次があります。

- `C-g` で今していることを cancel
- `C-x C-s` で現在の buffer を保存
- `M-w` と `C-y` でコピーと貼り付け
- `M-b`、`M-f`、`C-a`、`C-e`… で単語単位の移動、行頭・行末への移動
- `C-k` で行末まで kill、`C-w` で選択 region を kill
- `M-.` でシンボルの source を探す
- `C-x C-e` で現在の defun を evaluate
- …

便利な関数の中には、デフォルトでは keybinding がないものもあります。たとえば:

<!-- - delete selected text with `M-x delete-region` (or kill the region with `C-w`) -->

- `M-x Clear Listener` で REPL を clear
- `Backward Kill Line`

KDE/Gnome 風の**classical keybindings**を使うこともできます。Preferences menu、環境、Emulation tab へ進みます。

**Vim layer はありません**。

### 名前で keybindings を検索する

関数に対応する keybinding、または keybinding から関数名を検索できます。メニュー（Help -> Editing -> Key to Command / Command to Key）か、Emacs と同じく `C-h` に続いてキーを押します。たとえば `C-h k` と入力してから keybinding を入力すると、command name が得られます。詳しくは `C-h ?` を見てください。

### IDE を調整する

keybindings は変更できます。エディタの状態は `editor` パッケージからアクセスでき、エディタは CAPI framework で構築されているため、`capi` インターフェイスも使えます。便利な関数には次があります。

~~~lisp
`
editor:bind-key
editor:defcommand
editor:current-point
editor:with-point  ;; point location を保存
editor:move-point
editor:*buffer-list*
editor:*in-listener* ;; REPL 内にいるとき T を返す
…
~~~

キーを bind する方法は次のとおりです。

~~~lisp
;; 新しい行を indent する。
;; デフォルトでは、Return 後に point は indent されない。
(editor:bind-key "Indent New Line" #\Return :mode "Lisp")

;; pair を挿入する。
(editor:bind-key "Insert Parentheses For Selection" #\( :mode "Lisp")
(editor:bind-key "Insert Double Quotes For Selection"
   #\"
  :mode "Lisp")
~~~

新しい command を定義する方法は次のとおりです。`)` キーで次の閉じ括弧を越えるようにします。


~~~lisp
(editor:defcommand "Move Over ()" (p)
  "Move past the next close parenthesis.
Any indentation preceeding the parenthesis is deleted."
  "Move past the next close parenthesis."
  ;; Thomas Hermann に感謝
  ;; https://github.com/ThomasHermann/LispWorks/blob/master/editor.lisp
  (declare (ignore p))
  (let ((point (editor:current-point)))
    (editor:with-point ((m point))
      (cond ((editor::forward-up-list m)
	     (editor:move-point point m)
             (editor::point-before point)
             (loop (editor:with-point ((back point))
                     (editor::back-to-indentation back)
                     (unless (editor:point= back point)
                       (return)))
                   (editor::delete-indentation point))
	     (editor::point-after point))
	    (t (editor:editor-error))))))

(editor:bind-key "Move Over ()" #\) :mode "Lisp")
~~~

special forms の indent を変更する方法は次のとおりです。

~~~lisp
(editor:setup-indent "if" 1 4 1)
~~~

関連項目:

- LispWork keybindings の一覧: [https://www.nicklevine.org/declarative/lectures/additional/key-binds.html](https://www.nicklevine.org/declarative/lectures/additional/key-binds.html)

### Listener

listener は期待どおりの REPL ですが、Slime とは少し違いがあります。

入力を行ごと、または form ごとに評価するのではなく、入力中に parse します。そのため、いくつかのエラーは即座に得られます。たとえば `(abc` と入力します。ここまでは問題ありません。次に colon を入力して `(abc:` にすると、入力のすぐ上にエラーメッセージが表示されます。

```
Error while reading: Reader cannot find package ABC.

CL-USER 1 > (abc:
```

実際、ここで `abc:` はパッケージを参照していますが、そのようなパッケージは存在しません。

対話的デバッガは主に text ベースですが、グラフィカルな要素でも操作できます。たとえば menu bar の Abort ボタンを使うと top level に戻ります。graphical debugger を呼び出して stacktraces を見て操作することもできます。toolbar の一番端にある Debugger ボタンを参照してください。

![](assets/lispworks/toolbar-debugger.png)

stacktraces に自分の関数名が表示されている場合（コードを REPL に直接書いたのではなく、ファイルに書いて compile していれば表示されます）、その名前を double-click すると editor に戻り、エラーを引き起こしたコードの部分が highlight されます。


<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> これは Slime で <code>M-v</code> を押すのと同等です。
</div>

textual debugger の代わりに、graphical debugger がデフォルトで現れるよう選ぶこともできます。

listener は、Slime の comma `,` で始まるものに少し似た helper commands を提供します。

```
CL-USER 1 > :help

:bug-form <subject> &key <filename>
         Print out a bug report form, optionally to a file.
:get <variable> <command identifier>
         Get a previous command (found by its number or a symbol/subform within it) and put it in a variable.
:help    Produce this list.
:his &optional <n1> <n2>
         List the command history, optionally the last n1 or range n1 to n2.
:redo &optional <command identifier>
         Redo a previous command, found by its number or a symbol/subform within it.
:use <new> <old> &optional <command identifier>
         Do variant of a previous command, replacing old symbol/subform with new symbol/subform.
```


### Stepper。Breakpoints。

[stepper](http://www.lispworks.com/documentation/lw61/IDE-W/html/ide-w-496.htm) は、LispWorks が光る領域の一つです。

editor ウィンドウでコードを書いているとき、大きな赤い "Breakpoint" ボタン（または `M-x Stepper Breakpoint`）で breakpoints を設定できます。これによりコードに赤い mark が付きます。

次にそのコードが実行されると、包括的な Stepper pop-up ウィンドウが表示されます。内容は次のとおりです。

- source code。評価中の式を示す indicator 付き
- 2 つの tab を持つ下部 pane:
  - backtrace。途中の変数を表示し、プログラム実行中の変化を示します
  - listener。この関数 call の context で式を評価できます
- stepper controls を持つ menu bar: 次の式に step into、次の関数 call に step、cursor の位置まで実行、次の breakpoint まで実行継続、など

![](assets/lispworks/stepper.gif)

それだけではありません。visual ではない、REPL 向け stepper も便利です。評価中の forms とその results を表示します。

この例では、`:s` を使って現在の form と subforms を "step" します。通常の listener を使っており、prompt（ここでは小さな ` -> `）の後に任意の Lisp code を書けます。また local 変数（`X`）にもアクセスできます。

~~~lisp
CL-USER 4 > (defun my-abs (x)
              (cond ((> x 0) x) ((< x 0) (- x)) (t 0)))
CL-USER 5 > (step (my-abs -5))
(MY-ABS -5) -> :s
   -5 -> :s
   -5
   (COND ((> X 0) X) ((< X 0) (- X)) (T 0)) <=> (IF (> X 0) (PROGN X) (IF (< X 0) (- X) (PROGN 0)))
   ;; local variables へのアクセス:
   (IF (> X 0) (PROGN X) (IF (< X 0) (- X) (PROGN 0))) -> (format t "Is X equal to -5? ~a~&" (if (equal x -5) "yes" "no"))
Is X equal to -5? yes
   (IF (> X 0) (PROGN X) (IF (< X 0) (- X) (PROGN 0))) -> :s
      (> X 0) -> :s
         X -> :s
         -5
         0 -> :s
         0
      NIL
      (IF (< X 0) (- X) (PROGN 0)) -> :s
         (< X 0) -> :s
            X -> :s
            -5
            0 -> :s
            0
         T
         (- X) -> :s
            X -> :s
            -5
         5
      5
   5
5
~~~

利用可能な stepper commands は次のとおりです（`:?` を参照）。

~~~
:s       Step this form and all of its subforms (optional +ve integer arg)
:st      Step this form without stepping its subforms
:si      Step this form without stepping its arguments if it is a function call
:su      Step up out of this form without stepping its subforms
:sr      Return a value to use for this form
:sq      Quit from the current stepper level
:bug-form <subject> &key <filename>
         Print out a bug report form, optionally to a file.
:get <variable> <command identifier>
         Get a previous command (found by its number or a symbol/subform within it) and put it in a variable.
:help    Produce this list.
:his &optional <n1> <n2>
         List the command history, optionally the last n1 or range n1 to n2.
:redo &optional <command identifier>
         Redo a previous command, found by its number or a symbol/subform within it.
:use <new> <old> &optional <command identifier>
         Do variant of a previous command, replacing old symbol/subform with new symbol/subform.
~~~

### Class browser

クラス browser を使うと、クラスのスロット、parent クラス、利用可能なメソッドなどを調べられます。

単純なクラスを作りましょう。

~~~lisp
(defclass person ()
  ((name :accessor name
         :initarg :name
         :initform "")
   (lisper :accessor lisperp
           :initform t)))
~~~

次にクラス browser を呼び出します。

- listener の "Class" ボタンを使う
- または menu 式 -> クラスを使う
- またはクラスに cursor を置いて `M-x Describe class` を呼ぶ

![](assets/lispworks/class-browser.png)

これはいくつかの panes で構成されています。

- **class hierarchy**。左に superclasses、右に subclasses を表示し、下部に description を表示します
- **superclasses viewer**。単純な schema の形で表示します。subclasses についても同様です
- **slots pane**（デフォルト）
- 利用可能な **initargs**
- そのクラスの既存の **generic functions**
- そして **class precedence list**

関数 pane は、そのクラスに適用可能なすべてのメソッドを一覧するため、CLOS オブジェクト system が提供する public メソッドを見つけられます。たとえば `initialize-instance`、`print-object`、`shared-initialize` などです。double-click すると source に移動できます。継承されたメソッドを含めないよう選ぶこともできます（"include inherited" checkbox を参照）。

toolbar にはボタン（たとえば generic 関数を Inspect するもの）があり、メソッド menu にはさらに actions があります。たとえば **function calls** を見る方法、関数を **undefine** または **trace** する menu などです。

さらに読む:

* [Chapter 8 of the documentation: the Class Browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-55.htm#pgfId-871798)


### Function call browser

関数 call browser を使うと、ある関数の callers と callees の graph を見られます。表示情報を filter したり、call stack をさらに inspect したりする方法がいくつか用意されています。

<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> そのような cross-references を探す Slime の関数は <code>slime-who-[calls, references, binds, sets, depends-on, specializes, macroexpands]</code> です。
</div>

いくつかのパッケージをロードした後、`string-trim` 関数を誰が呼んでいるかを示す単純な例です。

![The function call browser](assets/lispworks/function-call-browser.png)

すべてのパッケージから関数を表示しますが、たとえば "current and used" や current パッケージのみに制限する select box があります。

graph に表示された関数を double click すると source に移動します。多くの LispWorks views と同様に、関数 menu では選択した関数をさらに操作できます。trace、undefine、listen（オブジェクトを Listener に貼り付ける）などです。

Text tab は同じ情報を textually に、callers と callees を横並びで表示します。

compiled code について cross references を見ることができ、その機能が有効になっていることを確認する必要があります。code を compile すると、LispWorks は次のような compilation output を表示します。

```
;;; Safety = 3, Speed = 1, Space = 1, Float = 1, Interruptible = 1
;;; Compilation speed = 1, Debug = 2, Fixnum safety = 3
;;; Source level debugging is on
;;; Source file recording is  on
;;; Cross referencing is on
```

cross referencing が on であることが分かります。そうでなければ `(toggle-source-debugging t)` で有効にします。

さらに読む:

- [Chapter 15: the function call browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-114.htm#pgfId-852601)


### Process Browser

Process Browser は実行中の全スレッドの一覧を表示します。入力欄では name で filter できます。正規表現を受け付けます。その後、これらのプロセスを stop、inspect、listen、break into できます。

!["The process browser"](assets/lispworks/process-browser.png)

さらに読む:

* [Chapter 28: the Process Browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-178.htm#pgfId-852666)

### イメージの保存

LispWorks で image を保存する方法は SBCL とは異なります。

- 今すぐ image を保存することも、後の時点に snapshots を schedule することもできます
- 新しく作成された image は LispWorks 環境のデフォルト core image になります
- REPL session が保存されます
- ウィンドウ configuration が保存されます
- スレッドが保存されます

つまり実質的に、image を保存すれば開発環境を同じ状態に戻せます。現在の作業の snapshots を取り、離れた場所から続けられるわけです。

たとえば REPL からゲームを開始し、そのウィンドウで少し遊び、image を保存すると、復元時にそのゲームと状態が戻ってきます。


### その他

`Search Files` 機能は気に入っています。recursive `grep` のようなものですが、結果を表示し、double-click でき、さらにいくつかの actions を提供する典型的な LispWorks graphical ウィンドウが得られます。

最後に、**compilation コンディション browser** も見てください。system を compile すると、LispWorks はすべての warnings とエラーを特別な browser に入れます。それ以降は、それらを修正し、browser から消えていくのを見ながら作業できます。開発中に warnings とエラーを追跡し続ける助けになります。


## Emacs と Slime から LispWorks を使う

これには 2 つの方法があります。1 つ目は、LispWorks を通常どおり起動し、Swank サーバーを開始して Emacs から接続する方法です（Swank は Slime の backend 部分です）。

まず dependencies をロードします。

~~~lisp
(ql:quickload "swank")
;; or
(load "~/.emacs.d/elpa/slime-20xx/swank-loader.lisp")
~~~

サーバーを開始します。

~~~lisp
(swank:create-server :port 9876)
;; Swank started at port: 9876.
9876
~~~

Emacs から `M-x slime-connect` を実行し、host に `localhost`、port に `9876` を選びます。

接続されているはずです。`(lisp-implementation-type)` で確認してください。これで LispWorks の機能を使えます。

~~~lisp
(setq button
      (make-instance 'capi:push-button
                     :data "Button"))
(capi:contain button)
~~~

2 つ目の方法は、Swank をロードした non-GUI LispWorks image を作成し、この image を SLIME または SLY から実行することです。たとえば multiprocessing を有効にした、いわゆる `console` image を作るには:

~~~lisp
(in-package "CL-USER")
(load-all-patches)
(save-image "~/lw-console"
            :console t
            :multiprocessing t
            :environment nil)
~~~

そして新しい image ~/lw-console を作成するため、LispWorks を次のように実行します。

    lispworks-7-0-0-x86-linux -build /tmp/resave.lisp

ただし、`console` は **Windows と Mac でのみ**実装されています。

LispWorks の documentation を参照してください。

## アプリケーションを配布する

LispWorks の delivery メソッドは `delivery` 関数を中心にしています。よい documentation があります: [https://www.lispworks.com/documentation/lw80/deliv/deliv.htm](https://www.lispworks.com/documentation/lw80/deliv/deliv.htm)。

他の open-source Lisps と違い、LispWorks は tree-shaker を提供します。これにより配布アプリケーションからパッケージを取り除き、7MB 前後の小さなバイナリを作れます。


#### Delivery の制限

LispWorks の delivery は、配布アプリケーションに `compile-file` を[含みません](https://www.lispworks.com/products/runtimes.html)（`save-image`、`deliver`、IDE も含みません）。そのため、配布済み image 上で動的に code を変更することはできません。Swank サーバーもなく、`ql:quickload` を使う可能性もありません。

ただし remote debugging を可能にするために、LW は独自の debugger クライアントを提供します。backend 側では次を実行します。

    (require "remote-debugger-client")
    (dbg:start-client-remote-debugging-server :announce t)

IDE 側では次を実行します。

    (require "remote-debugger-full")
    (dbg:ide-connect-remote-debugging "host" :open-a-listener t)


## 関連項目

- [LispWorks IDE User Guide](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u.htm)（ここで扱わなかった sections も確認してください）
- [LispWorks on Wikipedia](https://en.wikipedia.org/wiki/LispWorks)
- [Awesome LispWorks](https://github.com/fourier/awesome-lispworks) list
- [Common Lisp における真のイメージベースアプローチ](https://www.youtube.com/watch?v=nsKx40ab9SY) - SBCL と LispWorks の違い
- blog post: [Delivering a LispWorks application](https://blog.dziban.net/posts/delivering-a-lispworks-application/)
- [lw-plugins](https://github.com/apr3vau/lw-plugins) - LispWorks plugins:
  * terminal integration、code folding、side tree、markdown highlighting、Nerd Fonts、fuzzy-matching、enhanced directory mode、expand region、pair editing、SVG rendering…
