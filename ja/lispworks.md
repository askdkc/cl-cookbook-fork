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
- [CAPI 移植性のある GUI ツールキット](http://www.lispworks.com/documentation/lw61/CAPRM/html/capiref.htm): Windows、Cocoa、GTK+、Motif でネイティブな外観を提供します。
  - グラフィカルな "Interface Builder"（QtCreator のようなもの）が付属します（ただし MacOS では利用できません（mobile でも利用できません））
- Android と iOS 向けの [LispWorks for mobile runtime](http://www.lispworks.com/products/lw4mr.html)
- 最適化されたアプリケーション配布: LispWorks は tree shaker を使って、配布アプリケーションから未使用の Lisp コードを取り除けます。そのため、既存のオープンソース処理系より軽いバイナリを配布できます。
- 動的ライブラリとして配布できること
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

- **ヒープサイズの制限**があります。これを超えるとイメージは終了します。制限に近づくと警告が出ます。

何ができなくなるのでしょうか。例として、同じイメージ内で次のライブラリ群をまとめてロードすることはできません。

~~~lisp
(ql:quickload '("alexandria" "serapeum" "bordeaux-threads"
    "lparallel" "dexador" "hunchentoot" "quri"
    "cl-ppcre" "mito"))
~~~

- 各セッションには**5 時間の時間制限**があります。その後 LispWorks Personal は終了し、作業内容の保存や、一時ファイル削除などの後始末を行わない可能性があります。4 時間使用すると警告されます。

- **バイナリを作成できません**。実際、[save-image](http://www.lispworks.com/documentation/lw71/LW/html/lw-95.htm)、[deliver](http://www.lispworks.com/documentation/lw71/DV/html/delivery-4.htm#pgfId-852223)（スタンドアロン実行ファイルを作成するための*その*関数）、load-all-patches は利用できません。

- **初期化ファイルはロードされません**。Emacs で `~/.sbclrc` から Quicklisp を初期化することに慣れている場合、LispWorks を起動するたびに init file を手動でロードする必要があります（`(load #p"~/.your-init-file`））。

参考までに、起動ファイルに入れるために Quicklisp が提供するスニペットは次のとおりです。

~~~lisp
;; quicklisp を ~/quicklisp/ にインストールしている場合
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
~~~

これをリスナーのウィンドウに貼り付ける必要があります（`C-y` キー、y は "yank" の y です）。

- LispWorks Professional と Enterprise Editions の一部である階層化製品（CLIM、KnowledgeWorks、Common SQL、LispWorks ORB）は含まれていません。ただし、**CAPI ツールキットは試せます**。

インストール手順では、ダウンロードリンクを受け取るために HTML フォームへ入力し、次に利用規約とライセンスへの同意を求める最初のスクリプトを実行し、さらにソフトウェアをインストールする 2 つ目のスクリプトを実行します。

### ライセンスモデル

LispWorks には実際には 4 つの有料エディションがあります。ここで自分たちで説明しています: [http://www.lispworks.com/products/lispworks.html](http://www.lispworks.com/products/lispworks.html)。要約すると次のとおりです。

- Hobbyist edition: `save-image` と `load-all-patches` があり、minor version の更新を適用できます。明らかな制限はありませんが、非商用かつ非学術利用向けです。
- HobbyistDV edition: 実行ファイルを作成するための `deliver` 関数があります（これも非商用かつ非学術利用向け）。
- Professional edition: `deliver` 関数があり、商用および学術利用向けです。
- Enterprise edition: Common SQL インターフェイス、LispWorks ORB、KnowledgeWorks といったエンタープライズ向けモジュールを含みます。

執筆時点では、hobbyist edition のライセンスは 750 USD、pro version はその倍です。これらは LW のバージョンごと、プラットフォームごとに購入します。時間制限はありません。

<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> 提供元のリソースを必ず再確認し、遠慮なく問い合わせてください。
</div>


## LispWorks IDE

LispWorks IDE は自己完結していますが、Emacs と Slime から LispWorks という処理系を使うこともできます（下記参照）。IDE は Common Lisp イメージの*内部*で動作します。これは、Swank と Slime を通じて Lisp イメージと通信する外部プログラムである Emacs とは異なります。ユーザコードは同じプロセスで実行されます。

### エディタ

エディタは期待どおりの機能を提供します。TAB 補完のポップアップ、シンタックスハイライト、Emacs 風のキーバインド（`M-x` の拡張コマンドを含む）です。メニューは機能発見を助けます。

個人的には、編集体験はやや「素朴」だと感じました。たとえば:

- 改行後のインデントは自動ではなく、もう一度 TAB を押す必要があります。
- 自動補完はあいまい補完ではありません。
- ~~Paredit~~ に似たプラグイン（まったく新しい（2021）[Paredit for LispWorks](https://github.com/g000001/lw-paredit) はあります）や Lispy、Vim レイヤーはありません。

また、`M-.` に割り当てられた go-to-source 関数が組み込み Lisp シンボルではうまく動かないという問題もありました。どうやら LispWorks はあまり多くのソースコードを提供しておらず、主にエディタのコードだけのようです。Allegro CL のような別の商用 Lisp は、より多くのソースコードを提供しています。

エディタには興味深いタブがあります: Changed Definitions です。これは、選択に応じて、セッションの最初の編集、最後の保存、最後のコンパイル以降に再定義された関数とメソッドを一覧します。

関連項目:

- [Editor User Guide](http://www.lispworks.com/documentation/lw71/EDUG-U/html/eduser-u.htm)


### Keybindings

ほとんどのキーバインドは Emacs と似ていますが、すべてではありません。いくつかの違いを挙げます。

- **関数をコンパイルする**には、C-c C-c ではなく `C-S-c`（control、shift、c）を使います。
- **現在のバッファをコンパイルする**には、C-c C-k ではなく `C-S-b` を使います。

似ているものには次があります。

- `C-g` で今していることを取り消す
- `C-x C-s` で現在のバッファを保存
- `M-w` と `C-y` でコピーと貼り付け
- `M-b`、`M-f`、`C-a`、`C-e`… で単語単位の移動、行頭・行末への移動
- `C-k` で行末まで削除、`C-w` で選択リージョンを削除
- `M-.` でシンボルのソースを探す
- `C-x C-e` で現在の defun を評価
- …

便利な関数の中には、デフォルトでは keybinding がないものもあります。たとえば:

<!-- - delete selected text with `M-x delete-region` (or kill the region with `C-w`) -->

- `M-x Clear Listener` で REPL をクリア
- `Backward Kill Line`

KDE/Gnome 風の**古典的なキーバインド**を使うこともできます。Preferences メニュー、環境、Emulation タブへ進みます。

**Vim レイヤーはありません**。

### 名前でキーバインドを検索する

関数に対応するキーバインド、またはキーバインドから関数名を検索できます。メニュー（Help -> Editing -> Key to Command / Command to Key）か、Emacs と同じく `C-h` に続いてキーを押します。たとえば `C-h k` と入力してからキーバインドを入力すると、コマンド名が得られます。詳しくは `C-h ?` を見てください。

### IDE を調整する

キーバインドは変更できます。エディタの状態は `editor` パッケージからアクセスでき、エディタは CAPI フレームワークで構築されているため、`capi` インターフェイスも使えます。便利な関数には次があります。

~~~lisp
`
editor:bind-key
editor:defcommand
editor:current-point
editor:with-point  ;; ポイントの位置を保存
editor:move-point
editor:*buffer-list*
editor:*in-listener* ;; REPL 内にいるとき T を返す
…
~~~

キーを割り当てる方法は次のとおりです。

~~~lisp
;; 新しい行をインデントする。
;; デフォルトでは、Return 後にポイントはインデントされない。
(editor:bind-key "Indent New Line" #\Return :mode "Lisp")

;; 対を挿入する。
(editor:bind-key "Insert Parentheses For Selection" #\( :mode "Lisp")
(editor:bind-key "Insert Double Quotes For Selection"
   #\"
  :mode "Lisp")
~~~

新しいコマンドを定義する方法は次のとおりです。`)` キーで次の閉じ括弧を越えるようにします。


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

special form のインデントを変更する方法は次のとおりです。

~~~lisp
(editor:setup-indent "if" 1 4 1)
~~~

関連項目:

- LispWorks のキーバインドの一覧: [https://www.nicklevine.org/declarative/lectures/additional/key-binds.html](https://www.nicklevine.org/declarative/lectures/additional/key-binds.html)

### リスナー

リスナーは期待どおりの REPL ですが、Slime とは少し違いがあります。

入力を行ごと、またはフォームごとに評価するのではなく、入力中に解析します。そのため、いくつかのエラーは即座に得られます。たとえば `(abc` と入力します。ここまでは問題ありません。次にコロンを入力して `(abc:` にすると、入力のすぐ上にエラーメッセージが表示されます。

```
Error while reading: Reader cannot find package ABC.

CL-USER 1 > (abc:
```

実際、ここで `abc:` はパッケージを参照していますが、そのようなパッケージは存在しません。

対話的デバッガは主にテキストベースですが、グラフィカルな要素でも操作できます。たとえばメニューバーの Abort ボタンを使うとトップレベルに戻ります。グラフィカルなデバッガを呼び出してスタックトレースを見て操作することもできます。ツールバーの一番端にある Debugger ボタンを参照してください。

![](assets/lispworks/toolbar-debugger.png)

スタックトレースに自分の関数名が表示されている場合（コードを REPL に直接書いたのではなく、ファイルに書いてコンパイルしていれば表示されます）、その名前をダブルクリックするとエディタに戻り、エラーを引き起こしたコードの部分がハイライトされます。


<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> これは Slime で <code>M-v</code> を押すのと同等です。
</div>

テキストベースのデバッガの代わりに、グラフィカルなデバッガがデフォルトで現れるよう選ぶこともできます。

リスナーは、Slime のカンマ `,` で始まるものに少し似た補助コマンドを提供します。

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

エディタウィンドウでコードを書いているとき、大きな赤い "Breakpoint" ボタン（または `M-x Stepper Breakpoint`）でブレークポイントを設定できます。これによりコードに赤い印が付きます。

次にそのコードが実行されると、包括的な Stepper のポップアップウィンドウが表示されます。内容は次のとおりです。

- ソースコード。評価中の式を示すインジケータ付き
- 2 つのタブを持つ下部のペイン:
  - バックトレース。途中の変数を表示し、プログラム実行中の変化を示します
  - リスナー。この関数呼び出しの文脈で式を評価できます
- stepper の操作ボタンを持つメニューバー: 次の式へ step into、次の関数呼び出しへ step、カーソルの位置まで実行、次のブレークポイントまで実行継続、など

![](assets/lispworks/stepper.gif)

それだけではありません。視覚的ではない、REPL 向けの stepper も便利です。評価中のフォームとその結果を表示します。

この例では、`:s` を使って現在のフォームとサブフォームを "step" します。通常のリスナーを使っており、プロンプト（ここでは小さな ` -> `）の後に任意の Lisp コードを書けます。またローカル変数（`X`）にもアクセスできます。

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

利用可能な stepper のコマンドは次のとおりです（`:?` を参照）。

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

### クラスブラウザ

クラスブラウザを使うと、クラスのスロット、親クラス、利用可能なメソッドなどを調べられます。

単純なクラスを作りましょう。

~~~lisp
(defclass person ()
  ((name :accessor name
         :initarg :name
         :initform "")
   (lisper :accessor lisperp
           :initform t)))
~~~

次にクラスブラウザを呼び出します。

- リスナーの "Class" ボタンを使う
- またはメニューの 式 -> クラスを使う
- またはクラスにカーソルを置いて `M-x Describe class` を呼ぶ

![](assets/lispworks/class-browser.png)

これはいくつかのペインで構成されています。

- **クラス階層**。左にスーパークラス、右にサブクラスを表示し、下部に説明を表示します
- **スーパークラスビューア**。単純な図の形で表示します。サブクラスについても同様です
- **スロットのペイン**（デフォルト）
- 利用可能な **initargs**
- そのクラスの既存の **総称関数**
- そして **クラス優先順位リスト**

関数のペインは、そのクラスに適用可能なすべてのメソッドを一覧するため、CLOS オブジェクトシステムが提供する公開メソッドを見つけられます。たとえば `initialize-instance`、`print-object`、`shared-initialize` などです。ダブルクリックするとソースに移動できます。継承されたメソッドを含めないよう選ぶこともできます（"include inherited" のチェックボックスを参照）。

ツールバーにはボタン（たとえば総称関数を Inspect するもの）があり、メソッドのメニューにはさらに操作があります。たとえば **function calls** を見る方法、関数を **undefine** または **trace** するメニューなどです。

さらに読む:

* [Chapter 8 of the documentation: the Class Browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-55.htm#pgfId-871798)


### 関数呼び出しブラウザ

関数呼び出しブラウザを使うと、ある関数の呼び出し元と呼び出し先のグラフを見られます。表示情報を絞り込んだり、コールスタックをさらに調べたりする方法がいくつか用意されています。

<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> そのような相互参照を探す Slime の関数は <code>slime-who-[calls, references, binds, sets, depends-on, specializes, macroexpands]</code> です。
</div>

いくつかのパッケージをロードした後、`string-trim` 関数を誰が呼んでいるかを示す単純な例です。

![関数呼び出しブラウザ](assets/lispworks/function-call-browser.png)

すべてのパッケージから関数を表示しますが、たとえば "current and used" や現在のパッケージのみに制限する選択ボックスがあります。

グラフに表示された関数をダブルクリックするとソースに移動します。多くの LispWorks のビューと同様に、関数のメニューでは選択した関数をさらに操作できます。trace、undefine、listen（オブジェクトを Listener に貼り付ける）などです。

Text タブは同じ情報をテキストで、呼び出し元と呼び出し先を横並びで表示します。

コンパイル済みコードについて相互参照を見ることができ、その機能が有効になっていることを確認する必要があります。コードをコンパイルすると、LispWorks は次のようなコンパイル出力を表示します。

```
;;; Safety = 3, Speed = 1, Space = 1, Float = 1, Interruptible = 1
;;; Compilation speed = 1, Debug = 2, Fixnum safety = 3
;;; Source level debugging is on
;;; Source file recording is  on
;;; Cross referencing is on
```

相互参照が有効になっていることが分かります。そうでなければ `(toggle-source-debugging t)` で有効にします。

さらに読む:

- [Chapter 15: the function call browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-114.htm#pgfId-852601)


### プロセスブラウザ

プロセスブラウザは実行中の全スレッドの一覧を表示します。入力欄では名前で絞り込めます。正規表現を受け付けます。その後、これらのプロセスを stop、inspect、listen、break into できます。

!["The process browser"](assets/lispworks/process-browser.png)

さらに読む:

* [Chapter 28: the Process Browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-178.htm#pgfId-852666)

### イメージの保存

LispWorks でイメージを保存する方法は SBCL とは異なります。

- 今すぐイメージを保存することも、後の時点にスナップショットの作成を予約することもできます
- 新しく作成されたイメージは LispWorks 環境のデフォルトのコアイメージになります
- REPL のセッションが保存されます
- ウィンドウの構成が保存されます
- スレッドが保存されます

つまり実質的に、イメージを保存すれば開発環境を同じ状態に戻せます。現在の作業のスナップショットを取り、離れた場所から続けられるわけです。

たとえば REPL からゲームを開始し、そのウィンドウで少し遊び、イメージを保存すると、復元時にそのゲームと状態が戻ってきます。


### その他

`Search Files` 機能は気に入っています。再帰的な `grep` のようなものですが、結果を表示し、ダブルクリックでき、さらにいくつかの操作を提供する典型的な LispWorks のグラフィカルなウィンドウが得られます。

最後に、**コンパイルコンディションブラウザ** も見てください。システムをコンパイルすると、LispWorks はすべての警告とエラーを特別なブラウザに入れます。それ以降は、それらを修正し、ブラウザから消えていくのを見ながら作業できます。開発中に警告とエラーを追跡し続ける助けになります。


## Emacs と Slime から LispWorks を使う

これには 2 つの方法があります。1 つ目は、LispWorks を通常どおり起動し、Swank サーバーを開始して Emacs から接続する方法です（Swank は Slime のバックエンド部分です）。

まず依存をロードします。

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

Emacs から `M-x slime-connect` を実行し、ホストに `localhost`、ポートに `9876` を選びます。

接続されているはずです。`(lisp-implementation-type)` で確認してください。これで LispWorks の機能を使えます。

~~~lisp
(setq button
      (make-instance 'capi:push-button
                     :data "Button"))
(capi:contain button)
~~~

2 つ目の方法は、Swank をロードした GUI なしの LispWorks イメージを作成し、このイメージを SLIME または SLY から実行することです。たとえばマルチプロセッシングを有効にした、いわゆる `console` イメージを作るには:

~~~lisp
(in-package "CL-USER")
(load-all-patches)
(save-image "~/lw-console"
            :console t
            :multiprocessing t
            :environment nil)
~~~

そして新しいイメージ ~/lw-console を作成するため、LispWorks を次のように実行します。

    lispworks-7-0-0-x86-linux -build /tmp/resave.lisp

ただし、`console` は **Windows と Mac でのみ**実装されています。

LispWorks のドキュメントを参照してください。

## アプリケーションを配布する

LispWorks の配布の方法は `delivery` 関数を中心にしています。よいドキュメントがあります: [https://www.lispworks.com/documentation/lw80/deliv/deliv.htm](https://www.lispworks.com/documentation/lw80/deliv/deliv.htm)。

他のオープンソースの Lisp と違い、LispWorks は tree-shaker を提供します。これにより配布アプリケーションからパッケージを取り除き、7MB 前後の小さなバイナリを作れます。


#### 配布の制限

LispWorks の配布は、配布アプリケーションに `compile-file` を[含みません](https://www.lispworks.com/products/runtimes.html)（`save-image`、`deliver`、IDE も含みません）。そのため、配布済みのイメージ上で動的にコードを変更することはできません。Swank サーバーもなく、`ql:quickload` を使う可能性もありません。

ただしリモートデバッグを可能にするために、LW は独自のデバッガクライアントを提供します。バックエンド側では次を実行します。

    (require "remote-debugger-client")
    (dbg:start-client-remote-debugging-server :announce t)

IDE 側では次を実行します。

    (require "remote-debugger-full")
    (dbg:ide-connect-remote-debugging "host" :open-a-listener t)


## 関連項目

- [LispWorks IDE User Guide](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u.htm)（ここで扱わなかった節も確認してください）
- [LispWorks on Wikipedia](https://en.wikipedia.org/wiki/LispWorks)
- [Awesome LispWorks](https://github.com/fourier/awesome-lispworks) の一覧
- [Common Lisp における真のイメージベースアプローチ](https://www.youtube.com/watch?v=nsKx40ab9SY) - SBCL と LispWorks の違い
- ブログ記事: [Delivering a LispWorks application](https://blog.dziban.net/posts/delivering-a-lispworks-application/)
- [lw-plugins](https://github.com/apr3vau/lw-plugins) - LispWorks のプラグイン:
  * 端末連携、コードの折りたたみ、サイドツリー、markdown のハイライト、Nerd Fonts、あいまい一致、強化されたディレクトリモード、領域の展開、対の編集、SVG レンダリング…
