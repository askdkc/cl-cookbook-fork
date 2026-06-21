---
title: Win32 API の使い方
---


<a name="intro"></a>

## 導入と範囲

この章では Win32 API の基本を紹介し、Lisp からどう呼び出すかを示し、さらに Lisp を使って特定のアプリケーション領域に最適化した強力な Win32 プログラミング環境を作る方法を示します。Win32 API の全オプションを露出する Lisp 環境は、Win32 API と同じくらい複雑にならざるを得ません。しかし、あるアプリケーション領域が Win32 API のすべての関数のすべてのオプションを必要とするとは考えにくいものです。Lisp の構文を領域固有に拡張すると、その領域には不要な Win32 API の部分を隠せます。たぶん Win32 API の大部分は隠れるでしょう。プログラマは、その時点で必要な API の部分だけを扱い、考えればよくなります。後で必要になった部分は、いつでも簡単に露出できます。

単一の環境を、単純なアプリケーションと複雑なアプリケーションの両方に最適化するのは容易ではありません。この章で示す方法を使えば、単純なものから複雑なものまで、さまざまなアプリケーション領域に適した環境を構築できます。

章の前半では、後半の節へつながる概念や考え方を紹介し、最後から 2 番目の節で "Hello" プログラムにたどり着きます。

~~~lisp
(require "win-header")
(in-package :wh)
(export '(initialize-appendix-b))

(DefMsgHandler appendix-b-proc MsgMap ()
               (WM_PAINT
                (text-out "Hello from Lisp!" 0 0 :color (RGB 0 0 255))
                0))

(defun initialize-appendix-b ()
  (DefActiveTopWindow "Hello" 'appendix-b-proc
    :style ws_overlappedwindow :width 150 :height 200 :title "Hello Program"))
~~~

使用しているのは Lispworks for Windows 4.2.7 です（Personal Edition は無料でダウンロードできます）。他の Lisp に合わせる試みはしておらず、クロスプラットフォーム互換性も考慮していません。これらの点は文書の構成を考える段階で議論し、現在の方針を次の理由で選びました。

* 早く、頻繁に公開するのはよいことです。範囲を絞るのはこの方針に合っています。他の Lisp は後から追加できます。[Corman Lisp](http://www.cormanlisp.com) は Win32 API の機能を多く含んでいることは知っています。ほかのベンダーの Lisp には実際に触れていないので、それぞれ確認してください。
* ここで示す情報は、他のベンダーの Lisp にも概ね当てはまるはずです。Foreign Language Interface は変わるかもしれませんが、Win32 自体は同じだからです。

Cookbook では、これらの分野や他の分野のカバー範囲を広げる貢献を歓迎します。

Win32 API を使ってプログラミングする人は、Charles Petzold の [Programming Windows, The Definitive Guide to the Win32 API](http://www.charlespetzold.com/pw5/index.html) や同等の本に目を通しておくべきです。

ここで示すコードは、Windows XP 上の Lispworks for Windows 4.2.7 Professional Edition でのみテストしています。


<a name="whywin32"></a>

## なぜ Lisp を Win32 と組み合わせるのか

プログラムがクロスプラットフォームにできるなら、そうすべきです。Common Lisp の "Common" は、クロスプラットフォームかつクロスベンダーである性質への敬意でもあります。この移植性の利点は軽視すべきではありません。ただし、Win32 API を活用するプログラムを非移植的に書くからといって、Lisp の力を手放す必要はありません。

気になる点の 1 つは、Lisp の実行ファイルは大きいという印象かもしれません。Microsoft の OS は C と C++ で書かれており、C/C++ プログラム向けのサポートライブラリは OS に同梱されています。Lisp の実行時サポートが大きく見えるのは、それが OS に含まれていないからに過ぎません。Lispworks for Windows を使えば、ロイヤリティなしでデリバリモードの Lisp プログラムを配布できますし、実行時ライブラリを一度配布してから、小さなコンパイル済みプログラムだけを順次配布することもできます。

大量配布向けの小さなプログラムを作る必要があるなら、Lisp の実行時サポートが大半のコンピュータに入っていないことは制約になります。ただし、Lispworks for Windows ではデリバリ段階でかなり強い刈り込み（pruning）ができ、プログラムを 2MB 未満まで縮められることもあります。多くの配布ケースには十分です。完全な Lisp 実行時環境が必要なケースは、たいてい大規模アプリケーションで、実行時環境を CD や大きな一括ダウンロードで配布し、その後は個別にコンパイルしたコンポーネントをプログラムやコンポーネントの初期化時に読み込むのが理にかなっています。

配布可能なプログラムサイズの下限は、Lisp という言語に本質的なものではなく、現在の市場需要の結果に過ぎないと私は考えています。Lisp で書かれた本当に小さなスタンドアロン実行ファイルへの需要が高まれば、ベンダーにはよりよい pruner や shaker を開発する動機が生まれるはずです。（Lisp は最初にたくさん持っていて、配布物に不要なものを取り除きます。一方 C/C++ は最初に少ししか持っておらず、リンク時に必要なものを足していきます。起動直後の Lisp は REPL、つまり read-eval-print loop から始まり、Lisp の完全な力が対話的に使える状態になっています。）

Lispworks の Foreign Language Interface、つまり FLI の生々しい詳細を見ると、最初は奇妙に思えるかもしれません。OS は C/C++ で書かれているので、C/C++ からの OS 呼び出しは外部呼び出しではありません。Lisp 関数が Lisp 関数から呼ばれるのと同じです。


<a name="apioverview"></a>

## Win32 プログラムの一生をざっと見る

OS は Win32 の GUI プログラムを、サブルーチン、つまり関数の集合として扱います。

* これらの最初の関数である WinMain は、プログラム初期化時に呼ばれます。
* WinMain は Win32 関数 RegisterClass を呼び、コールバック関数の場所を OS に知らせます。RegisterClass は複数回呼べますが、アプリケーションの主ウィンドウに対応するのは、そのうち 1 つだけです。RegisterClass が呼ばれると、OS は新しく定義されたクラスを認識します。
* Win32 関数 CreateWindowEx が呼ばれ、先ほどの RegisterClass 呼び出しで指定したクラス名が渡されます。これでウィンドウが存在し、CreateWindowEx に渡した引数しだいで表示されます。
* OS は、新しく作られたウィンドウに関連するメッセージをキューし始めます。そのキューは WinMain に渡すために保存されます。
* WinMain は、メッセージポンプ（message pump）と呼ばれるループでメッセージキューにアクセスします。このループでは GetMessage、TranslateMessage、DispatchMessage が呼ばれます。
* GetMessage はキューから 1 つのメッセージを取り出します。メッセージがキューに積まれる順序にはある程度の規則性があります。たとえばウィンドウが作られたとき、特定の順序でメッセージが積まれます。マウス移動のようなイベントも、他のメッセージをキューに積みます。
* TranslateMessage は仮想キー（virtual-key）メッセージを文字メッセージに変換します。DispatchMessage は OS にメッセージを処理するよう要求する呼び出しです。OS はアプリケーションプログラム内の別のサブルーチン、つまり関数を呼ぶことでメッセージを処理します。呼ばれるアプリケーション関数は RegisterClass で指定した関数で、そこではクラス名パラメータが与えられ、そのクラス名は CreateWindowEx の呼び出しで指定されました。（長いですね）。
* RegisterClass 呼び出しで指定するアプリケーション関数は 4 つの引数を取ります。
    1. メッセージに関連付いたウィンドウのハンドル
    2. メッセージ ID、整数
    3. wParam の `unsigned long`
    4. lParam の `unsigned long`
* wParam と lParam の意味はメッセージ ID によって変わります。
* アプリケーション関数には `case` 文に相当するものがあり、メッセージ ID で分岐します。メッセージ ID はたくさんあります（何百もあります）。代表的なものには、ウィンドウ作成時に送られる `WM_CREATE`、内容を描画するときに送られる `WM_PAINT`、ウィンドウが消えるときに送られる `WM_DESTROY` があります。ほかにも、キー入力、マウス移動、マウスボタンのクリックなどに応答して生成されるメッセージがあります。接続されたカメラからの映像表示、音声ファイルの録音や再生、電話発信などに関連する Windows メッセージもあります。OS には何千ものメッセージがありますが、個々のプログラムが通常扱うのはそのごく一部です。メッセージ関数が明示的に処理しないメッセージを受け取ったら、そのメッセージは Win32 のデフォルト関数へ渡されます。
* メニューコマンドや他のイベントによってプログラムが Win32 関数 PostQuitMessage を呼ぶコードに入ると、メッセージポンプは GetMessage から 0 を返し、これがメッセージポンプのループを抜ける合図になります。すると WinMain が終了し、プログラムは終わります。


<a name="unicode"></a>

## Windows の文字システムと Lisp

Microsoft の OS には、単一バイトの ASCII 文字集合を使うものと、2 バイトの Unicode 文字集合を使うものがあります。次を使います。

~~~lisp
(defun external-format ()
  (if (string= (software-type) "Windows NT")
      :unicode
    :ascii)
~~~

どちらの形式を使っているかを判定します。文字や文字列を受け取る、または返す Win32 関数には 2 種類あります。1) ASCII 文字用で末尾が A のもの、2) 幅広 Unicode 文字用で末尾が W のものです。この external-format 関数は、主に Lispworks の外部関数インターフェイスの一部である `fli:with-foreign-string` を呼ぶときに役立ちます。Win32 関数を外部関数インターフェイス、つまり FLI で定義するとき、`:dbcs` キーワードがあると、その関数に単一バイト版と二重バイト版の両方があることを示します。`:dbcs` があると、Lispworks は単一バイトの Windows 95 では関数名に "A" を、二重バイトの Windows NT/2000/XP では "W" を付けます（サンプルプログラムは Windows XP で作成・テストしました）。`:dbcs` がなければ、Lispworks は外部関数名をそのまま使います。

Win32 の TextOut 関数に対する FLI 定義の一例は次のとおりです。

~~~lisp
(fli:define-foreign-function
    (TextOut "TextOut" :dbcs :calling-convention :stdcall)
    ((HDC (:unsigned :long)) (nXStart (:unsigned :int)) (nYStart (:unsigned :int))
     (lpString :pointer) (cbString (:unsigned :int)))
  :result-type (:unsigned :long))
~~~

これは次の定義と等価です。

~~~lisp
(fli:define-foreign-function
    (TextOut "TextOutW" :calling-convention :stdcall)
    ((HDC (:unsigned :long)) (nXStart (:unsigned :int)) (nYStart (:unsigned :int))
     (lpString :pointer) (cbString (:unsigned :int)))
  :result-type (:unsigned :long))
~~~


これは NT/2000/XP での話です（2 番目の例は 95 では "TextOutA" を使います）。

これを確かめるために、テスト目的で対話的に呼び出しやすい単純な FLI 定義を使ってみましょう。ここでは、ある Win32 関数を OS が認識しているかどうかだけを調べます。次の REPL での操作では、戻り値が意味を持つのは Lisp のリスタートハンドラが呼ばれたときだけです。リスタートハンドラが呼ばれなければ、その Win32 関数は見つかり、ロードされ、呼び出されたということです。FLI が見つけられない Win32 関数を呼び出そうとすると、リスタートハンドラが呼ばれます。（textout の正しい `define-foreign-function` 定義は [付録 A](#appendixa) にあります。）

~~~lisp
CL-USER 9 > (fli:define-foreign-function
                (TextOut-1 "TextOut" :dbcs :calling-convention :stdcall)
                () :result-type :int)
TEXTOUT-1

CL-USER 10 > (textout-1)
1

CL-USER 11 > (fli:define-foreign-function
                 (TextOut-2 "TextOut" :dbcs :calling-convention :stdcall)
                 () :result-type :int)
TEXTOUT-2

CL-USER 12 > (textout-2)
0
~~~


`TextOut` 関数はどちらの場合も見つかりました。これは、ある Win32 関数を複数の FLI 定義で名付けられることを示しています。この手法は、Win32 関数のあるパラメータに対して複数の Lisp データ型が要件を満たせる場合に役立つことがあります。

~~~lisp
CL-USER 13 > (fli:define-foreign-function
                 (TextOut-3 "TextOutW" :dbcs :calling-convention :stdcall)
                 () :result-type :int)

TEXTOUT-3

CL-USER 14 > (textout-3)

Error: Foreign function TEXTOUT-3 trying to call to unresolved
external function "TextOutWW".

1 (abort) Return to level 0.
2 Return to top-level loop.
3 Return from multiprocessing.

Type :b for backtrace, :c  to proceed,  or :? for other
options

CL-USER 15 : 1 > :top

CL-USER 16 > (fli:define-foreign-function
                 (TextOut-4 "TextOutW" :calling-convention :stdcall)
                 () :result-type :int)

TEXTOUT-4

CL-USER 17 > (textout-4)
1

CL-USER 18 > (fli:define-foreign-function
                 (TextOut-5 "TextOutA" :calling-convention :stdcall)
                 () :result-type :int)
TEXTOUT-5

CL-USER 19 > (textout-5)
0

CL-USER 20 >
~~~


外部関数を複数回定義したとき、直前の定義と現在の定義とで `:dbcs` キーワードの使い方が異なると、Lispworks は警告を出します。ここではその警告を省略しました。CL-USER 14 のあと、Lispworks は "TextOutWW" について不平を述べています。これは `:dbcs` キーワードを使うと Lispworks が外部関数名に 'W' を付け足すことを示しています。ただし外部関数自体の存在は、実際に呼び出すまで検証されません。TextOut-5 は、TextOut の ASCII 版である Win32 関数 TextOutA の存在を検証しています。

タイトルなどに奇妙な文字集合が現れるのを見たことがありますが、`:dbcs` や W/A 宣言を一貫して使うようにすることで、そうした問題を解決できました。

Edi Weitz から、`:dbcs` キーワードが ...A と ...W のどちらを呼ぶかを決めるのはコンパイル時か実行時か、という質問がありました。そこで次のプログラムを書きました。

~~~lisp
(in-package :cl-user)

(fli:define-foreign-function
    (MessageBox "MessageBox" :dbcs :calling-convention :stdcall)
    ((hwnd (:unsigned :long)) (text (:unsigned :long)) (title (:unsigned :long)) (flags (:unsigned :long)))
  :result-type (:unsigned :long))

(defun external-format ()
  (if (string= (software-type) "Windows NT")
      :unicode
      :ascii))

(defun display-format-used ()
  (fli:with-foreign-string
      (unicode-p u-ec u-bc :external-format (external-format)) "Unicode"
      (fli:with-foreign-string
	  (ascii-p a-ec a-bc :external-format (external-format)) "Ascii"
	  (fli:with-foreign-string
              (title-p t-ec t-bc :external-format (external-format)) "External Format"
              (if (eq (external-format) :unicode)
                  (messagebox 0 (fli:pointer-address unicode-p)
                              (fli:pointer-address title-p) 0)
                  (messagebox 0 (fli:pointer-address ascii-p)
                              (fli:pointer-address title-p) 0))))))

(compile 'external-format)
(compile 'display-format-used)

(deliver 'display-format-used "dbcs-run" 5)
(quit)

; We then have dbcs-run.exe. When run on Windows XP, dbcs-run pops up a messagebox
; displaying "Unicode". The same dbcs-run.exe file, ftp'd to a Macintosh running OS 9 with
; Virtual PC running Windows 98, pops up a message box displaying "Ascii".
~~~


<a name="fli"></a>

<a id="fli---the-foreign-language-interface---translating-c-header-files-to-lisp"></a>

## FLI — Foreign Language Interface — C ヘッダファイルを Lisp へ翻訳する

C/C++ から Win32 API を呼ぶときは、コンパイラに付属するヘッダファイルをプログラムに `#include` します。ヘッダファイルには、API を構成する定数・構造体・関数の定義が含まれています。これらの定義は Lisp プログラムからも利用できる必要があります。私はこの変換を手作業で行うのがいちばんわかりやすいと考えています。自動化する方法もありますが、関数単位で手作業で行ってもさほど時間はかかりません。

C/C++ では、`#define` はプリプロセッサに存在します。プログラムが使う `define` だけがオブジェクトコードに含まれます。一方 Lisp では、`defconstant` はその後使われるかどうかに関わらず、すべて Lisp イメージにロードされます。この問題のきれいな解決策は私にはわかりません。

当面は、基礎となる中核の win-header.lisp を用意し、あまり使わない定義は機能ごとにまとめた別の .lisp ファイルに置いて、必要になったときにロードするようにしています。<a name="fli-types"></a>


<a id="fli-data-types"></a>

### FLI のデータ型

Win32 の C/C++ ヘッダファイルには、HINSTANCE、ハンドル、HMENU、LPCTSTR など、OS 固有のデータ型に対する typedef が数多く含まれています。Lisp の側から見ると、これらは結局のところ、符号付きか符号なしか、`long` か `char` か、単一か配列か、あるいはそれらの型からなる C 構造体か、に行き着きます。（`Int` は `long` と同じもののようです。）

Lisp は HINSTANCE と HMENU の違いを知りませんし、気にもしません。どちらも単なる 32 ビット値です。Lisp がこれらの値に注意を払うのは 2 つの場面です。1) Lisp のデータを外部のフィールドへ移すとき、2) 外部のデータを Lisp へ移すときです。Lispworks はその時点で型強制を試み、符号なしフィールドに負の値を詰め込むような誤った変換をしようとするとコンディションが発生します。外部フィールドを `:pointer` 型と宣言するなど、型についてのヒントをさらに与えると、ポインタにゼロを詰め込もうとしたときに Lisp が不平を述べます。OS にヌルポインタを渡したい場合には、これは不便です。そのため私は、たいていのパラメータを `long` として扱う方が楽だと感じています。とはいえ、ときどきこの方針は曲げます。

Lispworks の FLI ポインタは、実際には fli:pointer-address で取り出した（アンボックスした）アドレスを含む Lisp の構造体です。ポインタ値を OS に渡すとき、たとえば `RECT` のアドレスを `GetClientRect` に渡すときには、2 つのステップが必要です。1) 外部構造体を確保する、2) 確保した構造体のアドレスを OS に渡す、です。たいていの場合、こうした確保は `fli:allocate-dynamic-foreign-object` の呼び出しを `fli:with-dynamic-foreign-objects` で囲んで扱うのが最善です。解放を気にしなくて済むからです。確保した構造体のアドレスは `fli:pointer-address` で（ポインタ値をアンボックスして）渡し、外部関数のパラメータリストではそのフィールドを `unsigned long` と定義します。

FLI では、Lispworks が自動的な型強制（アンボックス）を試みるように定義することもできます。パラメータの型を `:pointer` と定義してみてください。ただし Lispworks は NULL ポインタを渡そうとすると不平を述べます。もっとも、アドレスがゼロの FLI ポインタを作ってみたわけではありません。私が選んだ、ポインタを `unsigned long` として扱う方法は、私にとって明快で、双方向（OS→Lisp、Lisp→OS）でうまく動きます。これは単に私の理解がまだ完全でないからかもしれず、もっとよい方法があるのかもしれません。

ときには C 構造体の中に C の配列を定義すると便利なことがあります。特に `sPAINTSTRUCT` でそうです。これは動きますが、構造体メンバや配列要素のアドレスを得る現在の方法は気に入っていません。気づけばバイトオフセットを手で数え、次のようなコードを使っています。

~~~lisp
(defun interior-copy (to-struct-ptr byte-offset src-ptr)
  (let ((ptr (fli:make-pointer
              :address (fli:pointer-address to-struct-ptr :type :char))))
    (fli:incf-pointer ptr byte-offset)
    (wcscpy (fli:pointer-address ptr) (fli:pointer-address src-ptr))))
~~~


ここで `wcscpy` は `strcpy` のワイド文字版で、FLI を通して定義しています。もっとよい方法があって、誰かがすぐに教えてくれることを願っています。`strcpy` と `wcscpy` のどちらを選ぶかについては、`(software-type)` で呼び分けを決める以外のベストな方法を知るほど、さまざまな OS と Lispworks を使い込んでいません。（あるいは付録 A で定義した `(external-format)` を使います。）

Lisp 側に定義するデータ型は最小限に抑えていますが、ドキュメントの観点では、C/C++ ヘッダファイルで使われている `typedef` 名をまねるのがとても役立ちます。そこで `fli:define-c-typedef` を使って、BOOL、DWORD、ハンドル、HDC など、同様の Win32 データ型を定義します。

OS 固有の定数の多くは、Lisp プログラムから利用できるようにしておく必要があります。

~~~lisp
(defconstant CW_USEDEFAULT       #x80000000)
(defconstant IDC_ARROW                32512)
(defconstant SW_SHOW                      5)
(defconstant WM_CLOSE            #x00000010)
(defconstant WM_DESTROY          #x00000002)
~~~


これらの定数は、MSDN のドキュメントでは名前だけが示され、値は載っていません。Lisp プログラムには名前だけでなく値も必要です。必要な値を見つける簡単な方法は、VC98/Include ディレクトリを grep することです。Visual Studio にはツールバーに「ファイルから検索」機能があり、この種の検索ができます。Kenny Tilton はこう述べています。「私がやったのは、ビルドできる VC++ プロジェクトを適当に手に入れることでした（NeHe OpenGL のサイトには VC++ プロジェクトがたくさんあります（ページ左のサイドバーにある OpenGL チュートリアルを参照。[http:///nehe.gamedev.net](http://nehe.gamedev.net)）。私の環境では問題なくビルドできました）。そして気になるシンボルを右クリックします。（もちろん、まずは参照箇所を見つける必要がありますが <g>。）すると VC++ が 'find definition' を提示し、関数や定数やマクロなどのヘッダエントリへ直接ジャンプしてくれます。」<a name="fli-structures"></a></g>

<a id="fli-data-structures"></a>

### FLI のデータ構造

私はたいてい、構造体とそれに対する `typedef` を定義します。

~~~lisp
; PAINTSTRUCT
(fli:define-c-struct sPAINTSTRUCT
    (HDC hdc)
  (fErase bool)
  (rcPaint-x uint)
  (rcPaint-y uint)
  (rcPaint-width uint)
  (rcPaint-height uint)
  (fRestore bool)
  (fIncUpdate bool)
  (rgbReserved (:c-array wBYTE 32)))
(fli:define-c-typedef PAINTSTRUCT sPAINTSTRUCT)
~~~

そうすると、次のようなことができます。

~~~lisp
(fli:with-dynamic-foreign-objects ()
  (let ((ps-ptr (fli:allocate-dynamic-foreign-object :type 'paintstruct)))
    (format t "~&Pointer value: ~a" (fli:pointer-address ps-ptr))))
~~~

もっとも、この `typedef` がなぜ価値があるのかは私にはよくわかりません。Lisp は C ではないので、Lisp では `typedef` があっても、たとえば `struct sPAINTSTRUCT` と打たずに済むわけではありません。`typedef` は余計なものだと思うので、おそらく使うのをやめるでしょう。<a name="fli-functions"></a>


### FLI の関数

FLI で OS の呼び出しを定義するのはとても簡単です。私は OS のドキュメントにある API 定義から始めます。Visual C++ が使えるなら、MSDN のドキュメントもおそらくマシンにインストールされています。ドキュメントは [MSDN のウェブサイト](http://msdn.microsoft.com) でも参照できます。目的の関数の Win32 ドキュメントページを開き、単純に翻訳します。

~~~lisp
; LoadCursor
(fli:define-foreign-function
    (LoadCursor "LoadCursor" :dbcs :calling-convention :stdcall)
    ((hInstance handle) (param ulong))
  :result-type handle)
~~~


これまで見てきた Win32 の呼び出しはすべて `:calling-convention :stdcall` です。関数がテキストのパラメータを含むとわかっている場合は `:dbcs` キーワードを付けます。わからない場合は `:dbcs` なしで試します。この例で実際に呼び出される関数は `LoadCursorA` または `LoadCursorW` です。


<a name="callbacks"></a>

<a id="callbacks-from-windows-to-lisp"></a>

## Windows から Lisp へのコールバック

メッセージポンプが立ち上がって動き出すと、OS は Lisp の関数を繰り返し呼び出すことでメッセージを届けます。外部環境から呼び出せる Lisp 関数は、次のように定義できます。

~~~lisp
; WndProc -- Window procedure for the window we will create
(fli:define-foreign-callable
    (wndproc :result-type :long :calling-convention :stdcall)
    ((hwnd hwnd) (msg ulong)
     (wparam ulong) (lparam ulong))
  (case msg
    (#.WM_PAINT (wndproc-paint hwnd msg wparam lparam))
    #+console (#.WM_DESTROY (PostQuitMessage 0) 0)
    (t (DefWindowProc hwnd msg wparam lparam))))
~~~


この wndproc 関数がメッセージディスパッチャです。OS はプログラムに送られるメッセージごとに wndproc を 1 回呼び出します。wndproc は、メッセージを理解して適切な関数を呼び出す役割を担います。

`#.` リーダーマクロは `WM_PAINT` と `WM_DESTROY` の値をコンパイル時に返すので、`case` が機能します。`#+console` は「`:console` が `*features*` のメンバである場合にのみ次のフォームを含める」という意味です。

付録 A の Win32 Lisp プログラムの例は、Lispworks IDE からでも、Emacs の ILISP のようなコンソールモードからでも実行できます。`PostQuitMessage` を IDE から呼ぶと、IDE が終了してしまいます。コンソールモードで `PostQuitMessage` を呼ばないと、Win32 のウィンドウが閉じません。


<a name="startup"></a>

<a id="starting-the-program"></a>

## プログラムを起動する

マルチプロセッシングは Lispworks IDE では常に動いていますが、Emacs の ILISP では動いていることもあれば動いていないこともあります。マルチプロセッシングが使えると便利です。プログラムが動いていて、ボタンやメニューがすべて有効なウィンドウが表示されたままの状態で、プログラムやその変数を覗いたりいじったり、即座に反映される新しい関数や再定義した関数を与えたり、さらには Win32 API を呼び出したりできるからです。

ただし ILISP の下では、マルチプロセッシングは私にとってそれほど快適ではありませんでした。私は ILISP と Emacs の環境が大好きです。Lispworks IDE もとてもよくできていて、オンラインマニュアルを探したり、インスペクタのようなデバッグツールを使ったりといった用途のために、起動したままにしてあります。とはいえ編集やたいていの実行については、Emacs と ILISP の方が好みです。しかし ILISP では複数のプロセスを見る方法を覚えておらず、プロセス間を切り替える方法も知りません。ILISP でマルチプロセッシングを使うと、コンディションを抱えたスレッドが `*standard-output*` と `*standard-input*` を握ってしまうように見えます。もう一方のスレッドへ戻る方法がわかりません。これは十分に厄介なので、ILISP の下ではマルチプロセッシングを使わず、マルチプロセッシングで可能になる対話的なデバッグ機能が必要・欲しいとき、あるいは何らかの形でマルチプロセッシングが必要なときには、Lispworks IDE に切り替えます。

IDE の下で実行する場合、メッセージポンプは Lispworks が提供します。Emacs/ILISP の下（あるいは配布されたアプリケーションでそうなるようなコンソールモード）で実行する場合は、Lisp プログラム自身がメッセージポンプを提供しなければなりません。

そのため付録 A の例のプログラムでは、関数 `create-toplevel-window` が、コンソールモードのときにマルチプロセッシングが動いていることを保証します。関数 `create-toplevel-window-run` は、コンソールモードのときだけメッセージポンプの処理を行い、それ以外では行いません。

付録 A のプログラムは、ファイルがロードされたときに `register-class` を呼び出します。この呼び出しは一度だけ行えばよいので、トップレベルで呼び出しています。

~~~lisp
(defvar *reg-class-atom* (register-class))
~~~


そうすれば `create-toplevel-window-run` は、`CreateWindowEx` を呼び、必要に応じてメッセージポンプを開始するだけで済みます。


<a name="repl"></a>

<a id="the-lisp-repl-and-win32-development"></a>

## Lisp REPL と Win32 開発

Win32 アプリケーションを Lispworks IDE の中で実行しているときは、IDE の REPL プロンプトで Lisp のフォームを入力できます。任意の変数を見たり、任意の関数を再定義したり、`SendMessage` や、`WM_PAINT` の中にいることのような OS からのコンテキストを必要としないその他の Win32 関数を呼び出したりできます。ボタンがクリックされたときに呼ばれる関数を再定義すれば、次にそのボタンをクリックしたときには新しい関数が呼ばれます。Lispworks のデバッグツールが使えます。ほかの Lisp プログラムを同時に実行することもできます。実行中の Win32 プログラム内の個々の関数を REPL から呼び出せます。関数をトレースしたり解除したり、アドバイス（advice）を追加・削除したり、CLOS のクラスをその場で再定義したりできます。Lisp は、スロットの追加や削除が実行中のプログラム内で秩序立って行われることを保証します。

Lisp は、慎重に管理すればプログラムを何年も連続して動かせるように設計されており、その間にバグを直し、新しい関数を定義し、CLOS オブジェクトを再定義しながら、プログラムを保守できるようにも設計されています。


<a name="capi"></a>

<a id="making-direct-win32-calls-from-capi"></a>

## CAPI から Win32 を直接呼び出す

Lispworks には、GUI プログラム開発のためのクロスプラットフォーム API である CAPI が含まれています。CAPI は強力で使いやすいものです。真にクロスプラットフォームな能力を得るには、100% 純粋な CAPI にとどめることが重要です。

とはいえ、純粋な Win32 環境であっても、車輪をいちいち作り直すことなく、CAPI の機能をさっと使って高度な GUI プログラムを生成したいと思うのは自然なことです。CAPI プログラムの中から Win32 固有の機能を使うこともできます。

~~~lisp
(defclass image-pane (output-pane) ()
  (:default-initargs
   :display-callback 'draw-image))

...

(let ((pane-1 (make-instance 'image-pane))
      ...
      (contain (make-instance 'column-layout
                              :description (list pane-1 other-pane))
        :best-width 640
        :best-height 480)))

...

(defun draw-image (pane x y width height)
  (let ((hwnd (capi:simple-pane-handle pane)))
    ;; This returns the actual Win32 window handle
    ;; Now call CreateWindowEx with hwnd as the new window's parent
    ;; The Win32-defined window then covers the
    ;; CAPI window. After destroying or hiding the Win32 window, the
    ;; CAPI window is revealed.
    ;; Be careful not to create the window if it already is created.

    ....
~~~

`image-pane` から `pane-1` への、そして `image-pane` から `draw-image` へのつながりと、`pane-1` が CAPI のウィンドウに含まれていることに注目してください。`draw-image` は、画像を描くべきとき……つまり画像を描くべきときに呼び出されます！

ウィンドウへのハンドルや CAPI 環境とのその他のやりとりを必要としない Win32 関数の呼び出しは、もちろん問題なく動きます。

よいプログラムの多くは、主にローカル変数を使います。Windows のプログラムが動いている間に、Lispworks IDE からマルチプロセッシング環境を使ってプログラムを操作したい場合は、ウィンドウハンドルやその他の Windows リソースに対応するシンボルや変数にアクセスできることが重要です。`SendMessage` を REPL から呼ぶつもりなら、有効な `hwnd` が手に入る必要があります。`hwnd` を手元に置く方法のひとつは、OS が `hwnd` を渡してくる関数の中で `setf` することです。これはデバッグ専用の手法として使ってもよいし、プログラムの恒久的な一部として残しておいてもかまいません。


<a name="cinterface"></a>

<a id="interfacing-to-c"></a>

## C とのインターフェイス

OS は Win32 関数の多くを常に利用可能にしています。一方で、たとえば `avicap32` のビデオ関数のように、明示的にロードしなければならない DLL の中に存在する関数もあります。サードパーティ製や自作の DLL も、明示的なロードが必要です。

目的の DLL の名前にちなんだ `.def` ファイル（たとえば `avicap32.def`）を作ります。

~~~
exports capCreateCaptureWindow=capCreateCaptureWindowW
exports capGetDriverDescription=capGetDriverDescriptionW
~~~


そして Lisp 側では次のようにします。

~~~lisp
;; capCreateCaptureWindow
(fli:define-foreign-function
    (capCreateCaptureWindow "capCreateCaptureWindowW")
    ((lpszWindowName :pointer) (dwStyle fli-dword) (x :int) (y :int)
     (nWidth :int) (nHeight :int) (HWND fli-hwnd) (nID :int))
  :result-type (:unsigned :long)
  :module :avicap32
  :documentation "Opens a video capture window.")

(fli:register-module "avicap32")
~~~


DLL 内の関数を使って作ったウィンドウには、先ほど示したように CAPI のウィンドウを親として与えられます。`.def` ファイルが必要かどうかは、どの関数を使いたいかによります。ここでは `:dbcs` を使えば、外部関数名にハードコードした 'W' が不要になるかもしれません。


<a name="raiiandgc"></a>

<a id="raii-and-gc"></a>

## RAII と GC

C++ でよく使われるイディオムに「Resource Acquisition Is Initialization（リソースの確保は初期化である）」があります。C++ のオブジェクトがコンストラクタでオペレーティングシステムのリソース（たとえば開いたファイル）を確保し、オブジェクトのデストラクタでそのリソースを解放するものです。これらのオブジェクトは動的エクステントを持つことも、不定エクステントを持つこともあります。

動的エクステントを持つオブジェクトは、C++ の関数の先頭でローカルに宣言され、関数が戻ってオブジェクトがスコープから外れると、そのデストラクタが呼ばれます。これに対応する Lisp のイディオムは `with-...` マクロの使用です。マクロはリソースを確保し、`unwind-protect` のもとでそれを解放する役割を担います。

C++ では、不定エクステントを持つオブジェクトは `delete` または `delete []` でデストラクタを明示的に呼び出さなければなりません。デストラクタはオブジェクトを取り壊し、まず明示的に書かれた C++ コードによって確保済みのリソースを解放し、続いてデストラクタが終了する際にコンパイラ生成のコードによってオブジェクトのメモリを解放します。

Lisp はガベージコレクトされます。つまり、オブジェクトのメモリを解放するのは Lisp の責任です。しかしそれは、オブジェクトへの最後の参照が消えてから、かなり長い時間が経つまで起こらないかもしれません。ガベージコレクタはメモリが埋まったときか、明示的に呼ばれたときにしか動きません。オブジェクトが確保済みのリソースを保持している場合、ほとんどの場合そのリソースを解放すべき適切な時点があり、その時点で解放しないとリソースの枯渇につながります。

プログラマが明示的な Lisp コードで確保した、ウィンドウハンドルのような確保済みリソースについては、Lisp は責任を負いません。プログラマは `(defun release-resources...` のような関数を定義し、C++ ならデストラクタが呼ばれたであろう箇所でその解放関数を呼ばなければなりません。解放関数が戻り、オブジェクトへの参照がなくなれば、Lisp は将来のガベージコレクションでそのオブジェクトのメモリを解放します。

Win32/Lisp 環境のもうひとつの問題は GC に関するものです。GC は Lisp のデータを自由に移動できます。GC によって移動されうる Lisp データのアドレスを OS に渡してはいけません。OS に渡すデータはすべて FLI を通して確保すべきです。FLI がそのデータを移動不可にする役割を担います。


<a name="com"></a>

## COM

COM は Windows プログラミングで広く使われています。Lispworks for Windows には _COM/Automation User Guide and Reference Manual_ と関連する関数群が含まれています。私は Lisp で COM をいじったことがなく、ここではマニュアルと関数が利用できることを記すにとどめます。実のところ、`com` と `automation` を `require` して `com:midl` フォームを呼び出してみたところ、膨大な一連の IDL ファイルがロードされ、その幅広さと量に驚かされました。ただ、COM で実際に何かを動かすところまではやっていません。


<a name="power"></a>

<a id="beginning-to-use-the-power-of-lisp"></a>

## Lisp の力を使い始める

デモプログラムをようやく完成させたとき、私が最初に思ったのは「ほかの Win32 プログラムと変わらないな」でした。Lisp らしいところは何もありませんでした。どんな言語でも書ける、ただの Win32 コードだったのです。言語が違えば得意な問題領域も違います。Perl と聞けばテキストを思い浮かべます。Fortran とともに数値を思い浮かべます。Lisp と聞けば、自分自身の言語を定義することを思い浮かべます。マクロは Lisp の中に組み込み言語を定義するために使う道具のひとつであり、Lisp をプログラム可能なプログラミング言語たらしめているものの一部です。

Win32 API プログラミングは、新しい言語を強く求めています。これは非常に強力で柔軟な API ですが、あるアプリケーションの文脈では特定の部分集合しか使われず、しかもそれらは繰り返しの形で使われます。これは、仮にできたとしても API そのものを再定義すべきだ、という意味ではありません。あるアプリケーションでうまくいくものが、次のアプリケーションでうまくいくとは限らないからです。おそらくほぼすべての Win32 プログラムで使われる言語拡張もあるでしょう。一方、特定のアプリケーションにしか当てはまらない拡張もあるでしょう。

Lisp の美点のひとつは、プログラマがいつでも新しい拡張を定義できることです。[Common Lisp Cookbook のマクロの章](macros.html)を参照してください。マクロの書き方をはじめ多くを学ぶには、Paul Graham の [On Lisp](http://paulgraham.com/books.html) もおすすめします。

コードを書くときは、同じパターンを何度も打ち込んでいることに気づいてください。そして遅すぎないうちに「マクロか関数の出番だ」と考えましょう。マクロを書いているときでさえ、繰り返しのコーディングに気づいてください。マクロはマクロの上に組み立てられますし、マクロがマクロを生成することもできます。

マクロと関数のどちらを選ぶべきかは、ひとつにはコードの肥大化の問題です。マクロはその場で評価されて新しいコードを生み出しますが、関数はそうではありません。マクロの利点は、クロージャを作れること、つまりマクロが展開される時点で環境に存在する変数の値を取り込めることで、これにより単純なオブジェクトの必要性の多くがなくなります。マクロが `defvar` や `defparameter` フォームを作る場合、そのマクロが作る別の関数からそれらの変数やパラメータを使えます。もっとも、その用途にはクロージャも使えます。defvar を使うと、Win32 プログラムがウィンドウを開いて実行している間に、マルチプロセッシング環境の REPL からそれらの defvar を参照できます。defvar とクロージャのどちらを使うにせよ、保存と取り出しのための仕組みはまったく必要ありません。

マクロをこのように使わない場合、本来ならマクロが作っていたであろう関数は、当該オブジェクト固有のウィンドウハンドルやキャプションなどのリソースを取り出すために、何らかのオブジェクト検索コードを持たなければなりません。

関数は `inline` に `declaim` でき、パラメータとして渡せますが、マクロはそうはできない点に注意してください。

[On Lisp](http://www.paulgraham.com/books.html) で定義されているマクロの多くは、Win32 プログラミングでとても役立ちます。私はシンボル生成のマクロを多用しています。

必要なマクロのひとつの群は、Foreign Language Interface の利用をより簡単に、よりコンパクトに、より読みやすくします。私は `with-foreign-strings` というマクロを持っていて、これはポインタ名と文字列のペアのリストを受け取り、入れ子になった一連の `(fli:with-foreign-string...` 呼び出しを生成します。各文字列に対して、一意で予測可能な名前を付けた要素数とバイト数のパラメータの生成も含みます。私の `setf-foreign-slot-values` や `with-foreign-slot-values` マクロも、コードをよりコンパクトで読みやすくしてくれます。

もうひとつのマクロの群は、Windows のメッセージハンドラ関数を定義するのに役立ちます。私はウィンドウメッセージ用に CLOS クラスを作り、CLOS のメソッドディスパッチャに各メッセージへの適切な関数を見つけさせるのが好みです。こうするとメッセージハンドラを継承でき、派生クラスで選んだメッセージに対してより具体的なハンドラを定義できます。CLOS はこれをうまく扱ってくれます。私は `DefMsgHandler` というマクロを持っていて、これは RegisterClass を呼び、処理する各メッセージに対する CLOS メソッドを定義し、`WM_PAINT` のような遍在する関数で必要な定型処理を引き受け、望む種類のメッセージごとに実行する関数本体を簡単に定義できるようにします。ほかにも、プッシュボタン、エディットボックス、リストビューなどの Win32 コントロールを定義するのに役立つマクロがあります。

[付録 B](#appendixb) を見て、[付録 A](#appendixa) と比べてみてください。もちろん、付録 A のヘッダファイル部分を拡張したものが付録 B でも使われていますが、そこには示されていません。付録 A のプログラムは、ごく一部を除いてライブラリにまとめられ、付録 B ではそれが呼び出されています。アプリケーション固有の情報はすべて、付録 B のごく小さなプログラムの中に収まっています。

[付録 C](#appendixc) のプログラムは、これらのマクロを使って、ラジオボタン、プッシュボタン、チェックボックス、背景ウィンドウに描いたテキスト、そして列を持つリストビューを含むウィンドウを定義しています。


<a name="conclusion"></a>

### まとめ

本文と付録 A〜C で示したサンプルコードは、Lisp の中にとどまり、そこから Win32 API にアクセスすることに重点を置いています。Paul Tarvydas は [付録 D](#appendixd) に、C と Lisp の協調とやりとりを示すコードを寄せています。Paul のよく書かれた例では、メッセージループの駆動に C の dll を使い、Lisp のコールバック関数のアドレスを Lisp 側から dll 内の変数に書き込んでいます。

Lisp は対話的で豊かなプログラミング環境を提供します。Lisp で言語拡張を作るためにマクロを賢く使うと、アプリケーション固有の情報がシステム全体の中の小さな局所領域に集約されます。これによってアプリケーションを理解する労力が減り、アプリケーションの信頼性が高まり、保守の時間が短くなり、保守のための変更の信頼性も高まります。Lisp はこれを容易にするよう設計されています。

* * *

<a name="appendixa"></a>

<a id="appendix-a-hello-lisp-program-1"></a>

## 付録 A: 「Hello, Lisp」プログラム #1

ここに、「Hello, Lisp!」と表示する GUI ウィンドウを開く Win32 Lisp プログラムを示します。プログラムの詳細についての議論は、このリスティングのあとに続きます。プログラムのリスティングには、C/C++ プログラムで `#include` されるヘッダファイルから必要な行が含まれています。

本文を読みながら、プログラムのソースコードが見える別ウィンドウを開いておくと便利かもしれません。

~~~lisp
{% include code/w32-appendix-a.lisp %}
~~~

![](AppendixA.jpg)

* * *

<a name="appendixb"></a>

<a id="appendix-b-hello-lisp-program-2"></a>

## 付録 B: 「Hello, Lisp!」プログラム #2

~~~lisp
{% include code/w32-appendix-b.lisp %}
~~~

![](AppendixB.jpg)

* * *

<a name="appendixc"></a>

<a id="appendix-c-program-3"></a>

### 付録 C: プログラム #3

~~~lisp
{% include code/w32-appendix-c.lisp %}
~~~

![](AppendixC.jpg)

* * *

<a name="appendixd"></a>

<a id="appendix-d-paul-tarvydass-example"></a>

### 付録 D: Paul Tarvydas の例

これは、（C で）ウィンドウクラスを作り、それを LWW から呼び出して処理する例です。Petzold の「Hello」の例に似ていますが、独自のメインループを作る代わりに LWW のメインループにフックする点が異なります。私が Win32 に不慣れなため（そして辛抱が足りないため :-)）、おそらく本来あるべき姿ほどきれいではありません。

使い方は次のとおりです。

1) "wintest" という DevStudio の Win32 DLL プロジェクトを作る
2) wintest.c ファイルをプロジェクトに入れる
3) run.lisp ファイルをプロジェクトディレクトリにコピーする（Debug ディレクトリがそのサブディレクトリになるように）
4) C プロジェクトをビルドする
5) Project>>Settings>>Debug>>Executable for debug session を lispworksxxx.exe を指すように設定する
6) プロジェクトを実行する。これで lispworks が立ち上がるはず
7) run.lisp を開き、コンパイルしてロードする
8) リスナーで "(run)" と打つ
9) すると、中央に "hello" と表示されたウィンドウが見えるはず

このサンプルのウィンドウクラスは C で作られて初期化されます（lisp のメインラインから呼ばれます）。このウィンドウへの Windows からのコールバック（たとえば `WM_PAINT` メッセージ）は lisp で処理されます。Windows には lisp 関数（Lisp_WndProc）へのポインタが渡され、コールバックにそれを使うよう指示されています。lisp コードは "hello" のテキストを表示する Win32 呼び出しを直接行います。lisp はこれを設定するために FLI の外部関数と外部変数を使います。［実際のプロジェクトでこれを行うなら、もっと無理のない制御の流れを選ぶでしょうが、この例はあなたが尋ねていた FLI 呼び出しをひととおり試しているようです。］

［スタイルや簡素化などについて、どなたからのコメントも歓迎します。］

Paul Tarvydas
tarvydas at spamoff-attcanada dotca

~~~c
{% include code/w32-appendix-d.c %}
~~~

~~~lisp
{% include code/w32-appendix-d.lisp %}
~~~
