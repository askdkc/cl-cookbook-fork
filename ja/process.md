---
title: スレッド、並行性、並列性
---


<a name="intro"></a>

## はじめに

_スレッド_ とは、単一の Lisp プロセス内にあり、同じアドレス空間を共有する、独立した実行の流れを指します。通常、これらの流れの間ではシステム（Lisp カーネルまたは OS）によって実行が自動的に切り替えられるため、タスクは並列に（非同期に）完了しているように見えます。このページでは、スレッドの作成と管理、およびスレッド間の相互作用の一部について説明します。Lisp と他の _プロセス_ との相互作用については、[OS とのインターフェイス](os.html) を参照してください。

不慣れな人がすぐにつまずく点として、多くの処理系では（用語上）スレッドを _processes_ と呼びます。これは、_thread_ という用語よりずっと長く存在してきた言語の歴史的な特徴です。望むなら、これを安定した処理系の成熟のしるしと呼んでもよいでしょう。

ANSI Common Lisp 標準はこの話題に触れていません。ここでは、ポータブルな
[bordeaux-threads](https://github.com/sionescu/bordeaux-threads)
ライブラリ、[SBCL Manual](http://www.sbcl.org/manual/) の [SBCL スレッド](http://www.sbcl.org/manual/#Threading) による実装例、そして [lparallel](https://lparallel.org)
ライブラリ（[GitHub](https://github.com/sharplispers/lparallel)）を紹介します。

Bordeaux-threads は、事実上の標準となっているポータブルなライブラリで、かなり低レベルなプリミティブを公開しています。Lparallel はその上に構築されており、次の機能を備えています。

-  受信用キューを使う単純なタスク投入モデル
-  細粒度の並列性を表現するための構文
-  スレッド境界を越えた **非同期コンディションハンドリング**
-  **map、reduce、sort、remove の並列版**、その他多数
-  **promises**、futures、遅延評価構文
-  相互に接続されたタスクを並列化するための計算木
-  有界および無界の FIFO **queues**
-  **channels**
-  高優先度および低優先度のタスク
-  カテゴリによるタスクの kill
-  統合されたタイムアウト

並列性と並行性に関する他のライブラリについては、[Awesome CL list](https://github.com/CodyReichert/awesome-cl#parallelism-and-concurrency)
および [Quickdocs](http://quickdocs.org/) の [スレッド](https://quickdocs.org/-/search?q=thread) や [concurrency](https://quickdocs.org/-/search?q=concurrency) などを参照してください。

<a name="why_bother"></a>

### なぜわざわざ使うのか？

最初に解決すべき問いは、「なぜわざわざスレッドを使うのか」です。アプリケーションが非常に単純なので、スレッドをまったく気にする必要がない、という答えになる場合もあります。しかし、それ以外の多くの場合では、高度なアプリケーションをマルチスレッドなしで書く方法を想像するのは困難です。たとえば次のような場合です。

*   一度に複数のユーザーや接続に応答できる必要があるサーバー（たとえば Web
    サーバー。Sockets のページを参照）を書いている。
*   その処理中にメインアプリケーションを停止させず、何らかのバックグラウンド処理を行いたい。
*   一定時間が経過したときにアプリケーションへ通知したい。
*   何らかのシステムリソースが利用可能になるのを待つ間も、アプリケーションを実行中かつアクティブに保ちたい。
*   マルチスレッドを必要とする別のシステムと連携する必要がある（たとえば Windows 上の「ウィンドウ」は一般にそれぞれ自身のスレッドで動く）。
*   アプリケーションの異なる部分に、異なるコンテキスト（例: 異なる動的束縛）を対応付けたい。
*   単に 2 つのことを同時に行う必要がある。


<a name="emergency"></a>

### Concurrency とは何か？ Parallelism とは何か？

*Credit: 以下はもともと
[z0ltan.wordpress.com](https://z0ltan.wordpress.com/2016/09/02/basic-concurrency-and-parallelism-in-common-lisp-part-3-concurrency-using-bordeaux-and-sbcl-threads/)
に Timmy Jose によって書かれたものです。*

Concurrency は、異なる、場合によっては関連するタスクを、見かけ上同時に実行する方法です。つまり、単一プロセッサのマシン上でも、たとえばスレッドを使い、それらをコンテキストスイッチすることで同時性をシミュレートできます。

システム（ネイティブ OS）スレッドの場合、スケジューリングとコンテキストスイッチは最終的に OS によって決定されます。Java のスレッドや Common Lisp のスレッドはこの例です。

「グリーン」スレッド、つまりプログラムによって完全に管理されるスレッドの場合、スケジューリングはプログラム自身が完全に制御できます。Erlang はこのアプローチの優れた例です。

では、Concurrency と Parallelism の違いは何でしょうか？ Parallelism は通常、非常に厳密な意味では、独立したタスクが異なるプロセッサまたは異なるコア上で同時に並列実行されることを意味します。この狭い意味では、単一コア、単一プロセッサのマシンで真の parallelism を得ることはできません。

これら 2 つの関連する概念は、より抽象的なレベルで区別すると分かりやすくなります。Concurrency は主に、長時間実行される操作の最中でもシステムがロックされているように見えないよう、クライアントに同時性の錯覚を提供することを扱います。GUI システムはこの種のシステムの素晴らしい例です。したがって concurrency は、必ずしも性能上の利点ではなく、良いユーザー体験を提供することに関心があります。

Java の Swing ツールキットと JavaScript はどちらもシングルスレッドですが、背後のコンテキストスイッチにより同時性があるように見せられます。もちろん、多くの場合 concurrency は複数のスレッドやプロセスを使って実装されます。

一方、Parallelism は主に純粋な性能向上に関心があります。たとえば、与えられた範囲内のすべての偶数の二乗を求めるタスクがあるとします。この範囲をチャンクに分割し、それらを異なるコアまたは異なるプロセッサ上で並列に実行し、結果を集約して最終結果を作れます。これは Map-Reduce が実際に働いている例です。

Concurrency の抽象的な意味を Parallelism の抽象的な意味から切り分けたので、次にそれらを実装するために使われる実際の機構について少し話せます。多くの人にとって混乱が生じるのはここです。抽象概念を、それを実装する具体的手段に結び付けてしまいがちなのです。本質的には、どちらの抽象概念も同じ機構で実装されることがあります。たとえば Java では、同じ基本的なスレッド機構を使って concurrent な機能と parallel な機能を実装できます。私たちにとって違いを生むのは、抽象レベルでのタスク同士の概念的な絡み合い、または独立性だけです。

たとえば、作業の一部を別スレッド（場合によっては別コアや別プロセッサ）で行えるタスクがあるとします。しかし、そのスレッドを生成したスレッドが、生成されたスレッドの結果に論理的に依存している（そのためそのスレッドに “join” しなければならない）なら、それは依然として Concurrency です。

要するに、Concurrency と Parallelism は異なる概念ですが、その実装は同じ機構、すなわちスレッド、プロセスなどで行われることがあります。


## Bordeaux threads

Bordeaux ライブラリは、複数の Common Lisp 処理系で基本的なスレッド処理を扱うための、プラットフォーム非依存な方法を提供します。興味深い点は、それ自体が実際にネイティブスレッドを作成するわけではないことです。完全に下位の処理系に依存してそれを行います。

一方で、低レベルなスレッドの上に独自の抽象化を置き、いくつかの便利な追加機能を提供します。

また、デモプログラムを見ると、多くの Bordeaux 関数が SBCL で使われるものとかなり似ていることが分かります。これは偶然ではないと思います。

詳細についてはドキュメントを参照してください（“Wrap-up” セクションを確認してください）。

<a id="bordeaux-threads-"></a>

### Bordeaux-Threadsのインストール

まず Quicklisp を使って Bordeaux ライブラリをロードしましょう。

~~~lisp
CL-USER> (ql:quickload "bordeaux-threads")
To load "bordeaux-threads":
  Load 1 ASDF system:
    bordeaux-threads
; Loading "bordeaux-threads"

("bordeaux-threads")
~~~


### Common Lisp でのスレッドサポートの確認

Common Lisp 処理系にかかわらず、スレッドサポートが利用可能か確認する標準的な方法があります。

~~~lisp
CL-USER> (member :thread-support *FEATURES*)
(:THREAD-SUPPORT :SWANK :QUICKLISP :ASDF-PACKAGE-SYSTEM :ASDF3.1 :ASDF3 :ASDF2
 :ASDF :OS-MACOSX :OS-UNIX :NON-BASE-CHARS-EXIST-P :ASDF-UNICODE :64-BIT
 :64-BIT-REGISTERS :ALIEN-CALLBACKS :ANSI-CL :ASH-RIGHT-VOPS :BSD
 :C-STACK-IS-CONTROL-STACK :COMMON-LISP :COMPARE-AND-SWAP-VOPS
 :COMPLEX-FLOAT-VOPS :CYCLE-COUNTER :DARWIN :DARWIN9-OR-BETTER :FLOAT-EQL-VOPS
 :FP-AND-PC-STANDARD-SAVE :GENCGC :IEEE-FLOATING-POINT :INLINE-CONSTANTS
 :INODE64 :INTEGER-EQL-VOP :LINKAGE-TABLE :LITTLE-ENDIAN
 :MACH-EXCEPTION-HANDLER :MACH-O :MEMORY-BARRIER-VOPS :MULTIPLY-HIGH-VOPS
 :OS-PROVIDES-BLKSIZE-T :OS-PROVIDES-DLADDR :OS-PROVIDES-DLOPEN
 :OS-PROVIDES-PUTWC :OS-PROVIDES-SUSECONDS-T :PACKAGE-LOCAL-NICKNAMES
 :PRECISE-ARG-COUNT-ERROR :RAW-INSTANCE-INIT-VOPS :SB-DOC :SB-EVAL :SB-LDB
 :SB-PACKAGE-LOCKS :SB-SIMD-PACK :SB-SOURCE-LOCATIONS :SB-TEST :SB-THREAD
 :SB-UNICODE :SBCL :STACK-ALLOCATABLE-CLOSURES :STACK-ALLOCATABLE-FIXED-OBJECTS
 :STACK-ALLOCATABLE-LISTS :STACK-ALLOCATABLE-VECTORS
 :STACK-GROWS-DOWNWARD-NOT-UPWARD :SYMBOL-INFO-VOPS :UD2-BREAKPOINTS :UNIX
 :UNWIND-TO-FRAME-AND-CALL-VOP :X86-64)
~~~

スレッドサポートがない場合、この式の値として “NIL” が表示されます。

使用する具体的なライブラリによっては、concurrency サポートを確認する別の方法が用意されていることもあり、上で述べた共通の確認方法の代わりに使えます。

たとえばここでは Bordeaux ライブラリを使うことに関心があります。このライブラリでスレッドのサポートがあるかを確認するには、グローバル変数 `*supports-threads-p*` が NIL（サポートなし）または T（サポートあり）のどちらに設定されているかを見ます。

~~~lisp
CL-USER> bt:*supports-threads-p*
T
~~~

さて、これで準備ができたので、プラットフォーム非依存のライブラリ（Bordeaux）と、プラットフォーム固有のサポート（この場合は SBCL）の両方を試してみましょう。

そのために、いくつかの簡単な例を順に見ていきます。

-    基本 — 現在のスレッドを列挙する、すべてのスレッドを列挙する、スレッド名を取得する
-    スレッドからグローバル変数を更新する
-    スレッドを使って top-level にメッセージを表示する
-    top-level にメッセージを表示する — 修正版
-    top-level にメッセージを表示する — より良い版
-    複数のスレッドから共有リソースを変更する
-    複数のスレッドから共有リソースを変更する — ロックを使った修正版
-    複数のスレッドから共有リソースを変更する — アトミック操作を使う
-    スレッドに join する例、スレッドを破棄する例

### 基本 — 現在のスレッドを列挙する、すべてのスレッドを列挙する、スレッド名を取得する

~~~lisp
    ;;; Print the current thread, all the threads, and the current thread's name
    (defun print-thread-info ()
      (let* ((curr-thread (bt:current-thread))
             (curr-thread-name (bt:thread-name curr-thread))
             (all-threads (bt:all-threads)))
        (format t "Current thread: ~a~%~%" curr-thread)
        (format t "Current thread name: ~a~%~%" curr-thread-name)
        (format t "All threads:~% ~{~a~%~}~%" all-threads))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-thread-info)
    Current thread: #<THREAD "repl-thread" RUNNING {10043B8003}>

    Current thread name: repl-thread

    All threads:
     #<THREAD "repl-thread" RUNNING {10043B8003}>
    #<THREAD "auto-flush-thread" RUNNING {10043B7DA3}>
    #<THREAD "swank-indentation-cache-thread" waiting on: #<WAITQUEUE  {1003A28103}> {1003A201A3}>
    #<THREAD "reader-thread" RUNNING {1003A20063}>
    #<THREAD "control-thread" waiting on: #<WAITQUEUE  {1003A19E53}> {1003A18C83}>
    #<THREAD "Swank Sentinel" waiting on: #<WAITQUEUE  {1003790043}> {1003788023}>
    #<THREAD "main thread" RUNNING {1002991CE3}>

    NIL
~~~

スレッドからグローバル変数を更新します。

~~~lisp
    (defparameter *counter* 0)

    (defun test-update-global-variable ()
      (bt:make-thread
       (lambda ()
         (sleep 1)
         (incf *counter*)))
      *counter*)
~~~

`bt:make-thread` を使って新しいスレッドを作成します。この関数は lambda 抽象を引数として受け取ります。この lambda 抽象は引数を取れないことに注意してください。

もう 1 つ注意すべき点は、他の一部の言語（たとえば Java）とは異なり、スレッドオブジェクトの作成と、その開始や実行が分離されていないことです。この場合、スレッドは作成されるとすぐに実行されます。

出力は次のとおりです。

~~~lisp
    CL-USER> (test-update-global-variable)

    0
    CL-USER> *counter*
    1
~~~

見てのとおり、メインスレッドがただちに戻るため、`*counter*` の初期値は 0 です。その約 1 秒後、無名スレッドによって 1 に更新されます。

### スレッドを作成する: top-level にメッセージを表示する

~~~lisp
    ;;; Print a message onto the top-level using a thread
    (defun print-message-top-level-wrong ()
      (bt:make-thread
       (lambda ()
         (format *standard-output* "Hello from thread!"))
       :name "hello")
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-wrong)
    NIL
~~~

何が問題だったのでしょうか？問題は変数束縛です。`format` 関数の `t` 引数は top-level を指します。top-level はメインのコンソールストリームを表す Common Lisp の用語で、グローバル変数 `*standard-output*` によっても参照されます。そのため、出力はメインのコンソール画面に表示されると期待したかもしれません。

同じコードは、別スレッドで実行していなければ問題なく動いたでしょう。実際に起こることは、各スレッドが独自のスタックを持ち、そこで変数が再束縛されるということです。この場合、グローバル変数なので全スレッドで利用できるはずだと思いがちな `*standard-output*` でさえ、各スレッド内で再束縛されます。これは Java の ThreadLocal ストレージの概念に似ています。

### top-level にメッセージを表示する — 修正版

では、前の例の問題をどう修正すればよいでしょうか？もちろん、スレッド作成時に top-level を束縛します。純粋なレキシカルスコープの出番です。

~~~lisp
    ;;; Print a message onto the top-level using a thread — fixed
    (defun print-message-top-level-fixed ()
      (let ((top-level *standard-output*))
        (bt:make-thread
         (lambda ()
           (format top-level "Hello from thread!"))
         :name "hello"))
      nil)
~~~

これにより次の出力が得られます。

~~~lisp
    CL-USER> (print-message-top-level-fixed)
    Hello from thread!
    NIL
~~~

これで一安心です。ただし、次に見るように、非常に興味深い reader マクロを使って同じ結果を得る別の方法もあります。

### top-level にメッセージを表示する — 読み込み時 eval マクロ

まずコードを見てみましょう。

~~~lisp
    ;;; Print a message onto the top-level using a thread - reader macro

    (eval-when (:compile-toplevel)
      (defun print-message-top-level-reader-macro ()
        (bt:make-thread
         (lambda ()
           (format #.*standard-output* "Hello from thread!")))
        nil))

    (print-message-top-level-reader-macro)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-reader-macro)
    Hello from thread!
    NIL
~~~

動きました。では `eval-when` は何をしているのでしょうか。また、`*standard-output*` の前にある奇妙な `#.` という記号は何でしょうか？

`eval-when` は Lisp 式の評価がいつ行われるかを制御します。指定できる対象は `:compile-toplevel`、`:load-toplevel`、`:execute` の 3 つです。

`#.` 記号はいわゆる “Reader マクロ” です。reader（または read）マクロと呼ばれるのは、Common Lisp 式を読み込み解釈する責任を持つ Common Lisp Reader に対して特別な意味を持つためです。この特定の reader マクロは、`*standard-output*` の束縛が読み込み時に行われることを保証します。

読み込み時に値を束縛することで、スレッド実行時にも `*standard-output*` の元の値が維持され、出力が正しい top-level に表示されます。

ここで `eval-when` が効いてきます。関数定義全体を `eval-when` の中に包み、コンパイル時に評価が行われるようにすることで、`*standard-output*` の正しい値が束縛されます。`eval-when` を省略していた場合、次のエラーが表示されます。

~~~lisp
      error:
        don't know how to dump #<SWANK/GRAY::SLIME-OUTPUT-STREAM {100439EEA3}> (default MAKE-LOAD-FORM method called).
        ==>
          #<SWANK/GRAY::SLIME-OUTPUT-STREAM {100439EEA3}>

      note: The first argument never returns a value.
      note:
        deleting unreachable code
        ==>
          "Hello from thread!"


    Compilation failed.
~~~

これは理にかなっています。この出力ストリームが返すものはストリームであり、`format` 関数が期待するような、実際に定義された値ではないため、SBCL はそれを解釈できません。そのため “unreachable code” エラーが表示されます。

同じコードを REPL 上で直接実行していた場合は、すべてのシンボル解決が REPL スレッドによって正しく行われるため、問題はありません。


### 複数のスレッドから共有リソースを変更する

最小限の bank-account クラス（エラーチェックなし）を使った次の設定があるとします。

~~~lisp
    ;;; Modify a shared resource from multiple threads

    (defclass bank-account ()
      ((id :initarg :id
           :initform (error "id required")
           :accessor :id)
       (name :initarg :name
             :initform (error "name required")
             :accessor :name)
       (balance :initarg :balance
                :initform 0
                :accessor :balance)))

    (defgeneric deposit (account amount)
      (:documentation "Deposit money into the account"))

    (defgeneric withdraw (account amount)
      (:documentation "Withdraw amount from account"))

    (defmethod deposit ((account bank-account) (amount real))
      (incf (:balance account) amount))

    (defmethod withdraw ((account bank-account) (amount real))
      (decf (:balance account) amount))
~~~

そして、どうやらどのような同期も信じていない単純なクライアントがあるとします。

~~~lisp
    (defparameter *rich*
      (make-instance 'bank-account
                     :id 1
                     :name "Rich"
                     :balance 0))
    ; compiling (DEFPARAMETER *RICH* ...)

    (defun demo-race-condition ()
      (loop repeat 100
         do
           (bt:make-thread
            (lambda ()
              (loop repeat 10000 do (deposit *rich* 100))
              (loop repeat 10000 do (withdraw *rich* 100))))))
~~~

ここで行っているのはこれだけです。新しい銀行口座インスタンス（残高 0）を作成し、その後 100 個のスレッドを作成します。それぞれのスレッドは単に 100 という金額を 10000 回預け入れ、その後同じ金額を同じ回数だけ引き出します。したがって最終結果は開始時の残高、つまり 0 と同じになるはずです。確認してみましょう。

サンプル実行では、次のような結果になることがあります。

~~~lisp
    CL-USER> (:balance *rich*)
    0
    CL-USER> (dotimes (i 5)
               (demo-race-condition))
    NIL
    CL-USER> (:balance *rich*)
    22844600
~~~

おっと！この不一致の理由は、incf と decf がアトミック操作ではないことです。これらは複数の下位操作から成り、その実行順序は私たちの制御下にありません。

これが “race コンディション” と呼ばれるものです。複数のスレッドが同じ共有リソースを奪い合い、少なくとも 1 つの変更スレッドが、変更中に誤ったオブジェクト値を読み取ってしまう可能性が高い状態です。どう修正すればよいでしょうか？単純な方法の 1 つはロックを使うことです（この場合は mutex、より複雑な状況では semaphore もあり得ます）。

### 複数のスレッドから共有リソースを変更する — ロックを使った修正版

まず口座の残高を 0 に戻しましょう。

~~~lisp
    CL-USER> (setf (:balance *rich*) 0)
    0
    CL-USER> (:balance *rich*)
    0
~~~

次に、ロックを使って共有リソースにアクセスするように `demo-race-condition` 関数を変更します（`bt:make-lock` で作成し、示したように使用します）。

~~~lisp
    (defvar *lock* (bt:make-lock))
    ; compiling (DEFVAR *LOCK* …)

    (defun demo-race-condition-locks ()
      (loop repeat 100
         do
           (bt:make-thread
            (lambda ()
              (loop repeat 10000 do (bt:with-lock-held (*lock*)
                                      (deposit *rich* 100)))
              (loop repeat 10000 do (bt:with-lock-held (*lock*)
                                      (withdraw *rich* 100)))))))
    ; compiling (DEFUN DEMO-RACE-CONDITION-LOCKS ...)
~~~

今度は、より大きなサンプル実行を行ってみましょう。

~~~lisp
    CL-USER> (dotimes (i 100)
               (demo-race-condition-locks))
    NIL
    CL-USER> (:balance *rich*)
    0
~~~

素晴らしい。これで改善されました。もちろん、このように mutex を使うと性能に影響することを覚えておく必要があります。かなり多くの状況では、より良い方法があります。可能な場合はアトミック操作を使うことです。次にそれを扱います。

### 複数のスレッドから共有リソースを変更する — アトミック操作を使う

アトミック操作とは、概念上のトランザクション内ですべて発生することがシステムによって保証される操作です。つまり、主操作のすべての下位操作が外部からの干渉なしにまとめて行われます。操作は完全に成功するか、完全に失敗します。中間状態はなく、不整合な状態もありません。

もう 1 つの利点は、共有状態へのアクセスを保護するためにロックを使う場合より、性能がはるかに優れていることです。この違いは実際のデモ実行で確認します。

Bordeaux ライブラリはアトミック操作に対する実質的なサポートを提供していないため、その点では特定の処理系のサポートに依存する必要があります。ここではそれが SBCL なので、このデモは SBCL セクションに回します。

### スレッドに join する、スレッドを破棄する

スレッドに join するには `bt:join-thread` 関数を使います。スレッドを破棄するには（推奨される操作ではありませんが）`bt:destroy-thread` 関数を使えます。

単純なデモです。

~~~lisp
    (defmacro until (condition &body body)
      (let ((block-name (gensym)))
        `(block ,block-name
           (loop
               (if ,condition
                   (return-from ,block-name nil)
                   (progn
                       ,@body))))))

    (defun join-destroy-thread ()
      (let* ((s *standard-output*)
            (joiner-thread
              (bt:make-thread
                (lambda ()
                  (loop for i from 1 to 10
                     do
                       (format s "~%[Joiner Thread]  Working...")
                       (sleep (* 0.01 (random 100)))))))
            (destroyer-thread
                (bt:make-thread
                   (lambda ()
                    (loop for i from 1 to 1000000
                       do
                         (format s "~%[Destroyer Thread] Working...")
                         (sleep (* 0.01 (random 10000))))))))
        (format t "~%[Main Thread] Waiting on joiner thread...")
        (bt:join-thread joiner-thread)
        (format t "~%[Main Thread] Done waiting on joiner thread")
        (if (bt:thread-alive-p destroyer-thread)
            (progn
              (format t "~%[Main Thread] Destroyer thread alive... killing it")
              (bt:destroy-thread destroyer-thread))
            (format t "~%[Main Thread] Destroyer thread is already dead"))
        (until (bt:thread-alive-p destroyer-thread)
               (format t "[Main Thread] Waiting for destroyer thread to die..."))
        (format t "~%[Main Thread] Destroyer thread dead")
        (format t "~%[Main Thread] Adios!~%")))
~~~

ある実行での出力は次のとおりです。

~~~lisp
    CL-USER> (join-destroy-thread)

    [Joiner Thread]  Working...
    [Destroyer Thread] Working...
    [Main Thread] Waiting on joiner thread...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Main Thread] Done waiting on joiner thread
    [Main Thread] Destroyer thread alive... killing it
    [Main Thread] Destroyer thread dead
    [Main Thread] Adios!
    NIL
~~~

until マクロは、条件が真になるまで単純にループします。残りのコードはほぼ自明です。メインスレッドは joiner-thread の終了を待ちますが、destroyer-thread はただちに破棄します。

繰り返しますが、`bt:destroy-thread` の使用は推奨されません。この関数を必要とするように見える状況は、たいてい別のアプローチでより良く実現できます。

では、ここまで説明したすべての概念を結び付ける、もう少し総合的な例に進みましょう。

### タイムアウト

`bt:with-timeout` を使えます。

バックグラウンド操作を実行したいが、最大時間制限を超えないようにしたい場合があります。その場合、n を秒数として `bt:with-timeout
(n)` を使えます。タイムアウトした場合、Bordeaux-threads は `bt:timeout` エラーを signal します。

以下のシナリオでは、長時間かかる可能性のある操作を起動するスレッドを作成し、タイムアウト付きでそのスレッドに `join` し、タイムアウトエラーを処理します。ここでは、実行中のスレッドを破棄します。これにより、（`uiop:run-program` で実行されていた場合は）その下位プロセスも kill されます。

~~~lisp
(defun maybe-costly-operation ()
  (print "working hard...")
  (sleep 10))

(let ((thread (bt:make-thread            ;; <--- create a thread
                 (lambda ()
                   ;; maybe a long operation:
                   (maybe-costly-operation))
                 :name "maybe-costly-thread")))
    (handler-case
        (bt:with-timeout (timeout)       ;; <-- with-timeout
          (bt:join-thread thread))       ;; <-- join the thread
      (bt:timeout ()                     ;; <-- handle timeout.
        (bt:destroy-thread thread))))
~~~


### 便利な関数

デモ例で使用した関数、マクロ、グローバル変数に、いくつかの追加項目を加えた要約です。これらで基本的なプログラミングシナリオの大半をカバーできるはずです。

- `bt:*supports-thread-p*`（基本的なスレッドサポートを確認する）
- `bt:make-thread`（新しいスレッドを作成する）
- `bt:current-thread`（現在のスレッドオブジェクトを返す）
- `bt:all-threads`（実行中のすべてのスレッドのリストを返す）
- `bt:thread-alive-p`（スレッドがまだ生きているか確認する）
- `bt:thread-name`（スレッドの名前を返す）
- `bt:join-thread`（指定されたスレッドに join する）
- `bt:interrupt-thread`（指定されたスレッドに interrupt する）
- `bt:destroy-thread`（スレッドの abort を試みる）
- `bt:make-lock`（mutex を作成する）
- `bt:with-lock-held`（指定されたロックを使ってクリティカルコードを保護する）
- `bt:with-timeout`（タイムアウトエラーを signal する）

## SBCL threads

[SBCL](http://www.sbcl.org/) は [sb-thread](http://www.sbcl.org/manual/#Threading)
パッケージを通じてネイティブスレッドのサポートを提供します。これらは非常に低レベルな関数ですが、デモ例で示すように、その上に独自の抽象化を構築できます。

詳細についてはドキュメントを参照してください（“Wrap-up” セクションを確認してください）。

以下の例から、Bordeaux と SBCL スレッドの関数の間には強い対応関係があることが分かります。ほとんどの場合、違いはパッケージ名が bt から sb-thread に変わることだけです。

Bordeaux-Threadsライブラリがおおむね SBCL の実装を基にしていることは明らかです。そのため、構文または意味論に大きな違いがある場合にのみ説明を加えます。

### 基本 — 現在のスレッドを列挙する、すべてのスレッドを列挙する、スレッド名を取得する

コードです。


~~~lisp
    ;;; Print the current thread, all the threads, and the current thread's name

    (defun print-thread-info ()
      (let* ((curr-thread sb-thread:*current-thread*)
             (curr-thread-name (sb-thread:thread-name curr-thread))
             (all-threads (sb-thread:list-all-threads)))
        (format t "Current thread: ~a~%~%" curr-thread)
        (format t "Current thread name: ~a~%~%" curr-thread-name)
        (format t "All threads:~% ~{~a~%~}~%" all-threads))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-thread-info)
    Current thread: #<THREAD "repl-thread" RUNNING {10043B8003}>

    Current thread name: repl-thread

    All threads:
     #<THREAD "repl-thread" RUNNING {10043B8003}>
    #<THREAD "auto-flush-thread" RUNNING {10043B7DA3}>
    #<THREAD "swank-indentation-cache-thread" waiting on: #<WAITQUEUE  {1003A28103}> {1003A201A3}>
    #<THREAD "reader-thread" RUNNING {1003A20063}>
    #<THREAD "control-thread" waiting on: #<WAITQUEUE  {1003A19E53}> {1003A18C83}>
    #<THREAD "Swank Sentinel" waiting on: #<WAITQUEUE  {1003790043}> {1003788023}>
    #<THREAD "main thread" RUNNING {1002991CE3}>

    NIL
~~~

### スレッドからグローバル変数を更新する

コードです。

~~~lisp
    ;;; Update a global variable from a thread

    (defparameter *counter* 0)

    (defun test-update-global-variable ()
      (sb-thread:make-thread
       (lambda ()
         (sleep 1)
         (incf *counter*)))
      *counter*)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (test-update-global-variable)
    0
~~~

### スレッドを使って top-level にメッセージを表示する

コードです。

~~~lisp
    ;;; Print a message onto the top-level using a thread

    (defun print-message-top-level-wrong ()
      (sb-thread:make-thread
       (lambda ()
         (format *standard-output* "Hello from thread!")))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-wrong)
    NIL
~~~

top-level にメッセージを表示する — 修正版:

コードです。

~~~lisp
    ;;; Print a message onto the top-level using a thread - fixed

    (defun print-message-top-level-fixed ()
      (let ((top-level *standard-output*))
        (sb-thread:make-thread
         (lambda ()
           (format top-level "Hello from thread!"))))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-fixed)
    Hello from thread!
    NIL
~~~

### top-level にメッセージを表示する — より良い版

コードです。

~~~lisp
    ;;; Print a message onto the top-level using a thread - reader macro

    (eval-when (:compile-toplevel)
      (defun print-message-top-level-reader-macro ()
        (sb-thread:make-thread
         (lambda ()
           (format #.*standard-output* "Hello from thread!")))
        nil))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-reader-macro)
    Hello from thread!
    NIL
~~~

###    複数のスレッドから共有リソースを変更する

コードです。

~~~lisp
    ;;; Modify a shared resource from multiple threads

    (defclass bank-account ()
      ((id :initarg :id
           :initform (error "id required")
           :accessor :id)
       (name :initarg :name
             :initform (error "name required")
             :accessor :name)
       (balance :initarg :balance
                :initform 0
                :accessor :balance)))

    (defgeneric deposit (account amount)
      (:documentation "Deposit money into the account"))

    (defgeneric withdraw (account amount)
      (:documentation "Withdraw amount from account"))

    (defmethod deposit ((account bank-account) (amount real))
      (incf (:balance account) amount))

    (defmethod withdraw ((account bank-account) (amount real))
      (decf (:balance account) amount))

    (defparameter *rich*
      (make-instance 'bank-account
                     :id 1
                     :name "Rich"
                     :balance 0))

    (defun demo-race-condition ()
      (loop repeat 100
         do
           (sb-thread:make-thread
            (lambda ()
              (loop repeat 10000 do (deposit *rich* 100))
              (loop repeat 10000 do (withdraw *rich* 100))))))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (:balance *rich*)
    0
    CL-USER> (demo-race-condition)
    NIL
    CL-USER> (:balance *rich*)
    3987400
~~~

###    複数のスレッドから共有リソースを変更する — ロックを使った修正版

コードです。

~~~lisp
    (defvar *lock* (sb-thread:make-mutex))

    (defun demo-race-condition-locks ()
      (loop repeat 100
         do
           (sb-thread:make-thread
            (lambda ()
              (loop repeat 10000 do (sb-thread:with-mutex (*lock*)
                                      (deposit *rich* 100)))
              (loop repeat 10000 do (sb-thread:with-mutex (*lock*)
                                      (withdraw *rich* 100)))))))
~~~

ここでの唯一の違いは、Bordeaux の make-lock の代わりに `make-mutex` があり、それを例に示すように `with-mutex` マクロと一緒に使うことです。

出力は次のとおりです。

~~~lisp
    CL-USER> (:balance *rich*)
    0
    CL-USER> (demo-race-condition-locks)
    NIL
    CL-USER> (:balance *rich*)
    0
~~~

### 複数のスレッドから共有リソースを変更する — アトミック操作を使う

まずコードです。

~~~lisp
    ;;; Modify a shared resource from multiple threads - atomics

    (defgeneric atomic-deposit (account amount)
      (:documentation "Atomic version of the deposit method"))

    (defgeneric atomic-withdraw (account amount)
      (:documentation "Atomic version of the withdraw method"))

    (defmethod atomic-deposit ((account bank-account) (amount real))
      (sb-ext:atomic-incf (car (cons (:balance account) nil)) amount))

    (defmethod atomic-withdraw ((account bank-account) (amount real))
      (sb-ext:atomic-decf (car (cons (:balance account) nil)) amount))

    (defun demo-race-condition-atomics ()
      (loop repeat 100
         do (sb-thread:make-thread
             (lambda ()
               (loop repeat 10000 do (atomic-deposit *rich* 100))
               (loop repeat 10000 do (atomic-withdraw *rich* 100))))))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (dotimes (i 5)
               (format t "~%Opening: ~d" (:balance *rich*))
               (demo-race-condition-atomics)
               (format t "~%Closing: ~d~%" (:balance *rich*)))

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0
    NIL
~~~

見てのとおり、SBCL のアトミック関数は少し癖があります。ここで使っている 2 つの関数 `sb-ext:incf` と `sb-ext:atomic-decf` は、次のシグネチャを持ちます。


    Macro: atomic-incf [sb-ext] place &optional diff

and


    Macro: atomic-decf [sb-ext] place &optional diff

興味深い点は、“place” 引数が次のいずれかでなければならないことです（ドキュメントによる）。

- 宣言型が (unsigned-byte 64) の defstruct スロット、または (simple-array (unsigned-byte 64) (*)) の aref。この目的には `sb-ext:word` 型を使えます。
- cons の car または cdr（それぞれ first または REST）。
- fixnum 型として proclaim された、defglobal で定義された変数。

これが、`atomic-deposit` メソッドと `atomic-decf` メソッドで奇妙な構文が使われている理由です。

アトミック操作をできるだけ使う大きな動機の 1 つは性能です。`demo-race-condition-locks` 関数と `demo-race-condition-atomics` 関数を 1000 回実行して、性能差があるか手早く確認してみましょう。

ロックを使う場合:

~~~lisp
    CL-USER> (time
                        (loop repeat 100
                          do (demo-race-condition-locks)))
    Evaluation took:
      57.711 seconds of real time
      431.451639 seconds of total run time (408.014746 user, 23.436893 system)
      747.61% CPU
      126,674,011,941 processor cycles
      3,329,504 bytes consed

    NIL
~~~

アトミック操作を使う場合:

~~~lisp
    CL-USER> (time
                        (loop repeat 100
                         do (demo-race-condition-atomics)))
    Evaluation took:
      2.495 seconds of real time
      8.175454 seconds of total run time (6.124259 user, 2.051195 system)
      [ Run times consist of 0.420 seconds GC time, and 7.756 seconds non-GC time. ]
      327.66% CPU
      5,477,039,706 processor cycles
      3,201,582,368 bytes consed

    NIL
~~~

結果はどうでしょうか？ロック版は約 57 秒かかったのに対し、ロックなしのアトミック版はわずか 2 秒でした。これは実に大きな差です。

### スレッドに join する例、スレッドを破棄する例

コードです。

~~~lisp
;;; Joining on and destroying a thread

(defmacro until (condition &body body)
  (let ((block-name (gensym)))
    `(block ,block-name
       (loop
           (if ,condition
               (return-from ,block-name nil)
               (progn
                   ,@body))))))

(defun join-destroy-thread ()
  (let* ((s *standard-output*)
        (joiner-thread
           (sb-thread:make-thread
              (lambda ()
                (loop for i from 1 to 10
                   do
                     (format s "~%[Joiner Thread]  Working...")
                     (sleep (* 0.01 (random 100)))))))
        (destroyer-thread
           (sb-thread:make-thread
              (lambda ()
                (loop for i from 1 to 1000000
                   do
                     (format s "~%[Destroyer Thread] Working...")
                     (sleep (* 0.01 (random 10000))))))))

    (format t "~%[Main Thread] Waiting on joiner thread...")
    (bt:join-thread joiner-thread)
    (format t "~%[Main Thread] Done waiting on joiner thread")
    (if (sb-thread:thread-alive-p destroyer-thread)
        (progn
          (format t "~%[Main Thread] Destroyer thread alive... killing it")
          (sb-thread:terminate-thread destroyer-thread))
        (format t "~%[Main Thread] Destroyer thread is already dead"))
    (until (sb-thread:thread-alive-p destroyer-thread)
       (format t "[Main Thread] Waiting for destroyer thread to die..."))
    (format t "~%[Main Thread] Destroyer thread dead")
    (format t "~%[Main Thread] Adios!~%")))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (join-destroy-thread)

    [Joiner Thread]  Working...
    [Destroyer Thread] Working...
    [Main Thread] Waiting on joiner thread...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Main Thread] Done waiting on joiner thread
    [Main Thread] Destroyer thread alive... killing it
    [Main Thread] Destroyer thread dead
    [Main Thread] Adios!
    NIL
~~~

### 便利な関数

例で使った関数、マクロ、グローバル変数に、いくつかの追加項目を加えた要約リストです。

-    `(member :thread-support *features*)`（スレッドサポートを確認する）
-    `sb-thread:make-thread`（新しいスレッドを作成する）
-    `sb-thread:*current-thread*`（現在のスレッドオブジェクトを保持する）
-    `sb-thread:list-all-threads`（実行中のすべてのスレッドのリストを返す）
-    `sb-thread:thread-alive-p`（スレッドがまだ生きているか確認する）
-    `sb-thread:thread-name`（スレッドの名前を返す）
-    `sb-thread:join-thread`（指定されたスレッドに join する）
-    `sb-thread:interrupt-thread`（指定されたスレッドに interrupt する）
-    `sb-thread:destroy-thread`（スレッドの abort を試みる）
-    `sb-thread:make-mutex`（mutex を作成する）
-    `sb-thread:with-mutex`（指定されたロックを使ってクリティカルコードを保護する）

## まとめ

見てのとおり、Common Lisp における concurrency サポートはかなり原始的です。しかし、それは主に ANSI Common Lisp 仕様にこの重要な機能が明らかに存在しないためです。とはいえ、Common Lisp 処理系が提供するサポートや、Bordeaux ライブラリのような素晴らしいライブラリの価値が少しでも損なわれるわけではありません。

この話題については、さらに多くを読んで自分で深めるべきです。ここに私自身の参考資料をいくつか共有します。

- [Common Lisp Recipes](http://weitz.de/cl-recipes/) by Edmund Weitz
- [Bordeaux API Reference](https://trac.common-lisp.net/bordeaux-threads/wiki/ApiDocumentation)
- [SBCL Manual](http://www.sbcl.org/manual/) on [Threading](http://www.sbcl.org/manual/#Threading)
- [The Common Lisp Hyperspec](https://www.lispworks.com/documentation/HyperSpec/Front/)

次は、このミニシリーズの最後の記事です。**lparallel** ライブラリを使った Common Lisp における parallelism です。

## lparallel による並列プログラミング

lparallel は非同期プログラミングに対する広範なサポートも提供しており、純粋な並列プログラミングライブラリではない、という点に注意することが重要です。前述のとおり、parallelism は、タスクが概念上互いに独立しているという抽象概念にすぎません。

lparallel ライブラリは Bordeaux threading ライブラリの上に構築されています。

前述したように、parallelism と concurrency は同じ手段、すなわちスレッド、プロセスなどを使って実装できます（そして通常そうされています）。違いは、それらの概念上の違いにあります。

この記事で示す例のすべてが必ずしも parallel であるとは限らないことに注意してください。特に Promises や Futures のような非同期構文は、並列プログラミングよりも並行プログラミングに適しています。

lparallel ライブラリを使う基本的な手順は次のとおりです。

- `lparallel:make-kernel` を使って、ライブラリが kernel と呼ぶもののインスタンスを作成します。kernel はタスクをスケジュールし実行するコンポーネントです。
-    futures、promises、その他の高レベルな関数的概念の観点からコードを設計します。このために、lparallel は **channels**、**promises**、**futures**、**cognates** のサポートを提供します。
-    ライブラリが cognates と呼ぶものを使って操作を行います。これは単に、Common Lisp 言語自体に対応物を持つ関数です。たとえば `lparallel:pmap` 関数は、Common Lisp の `map` 関数の並列版です。
-    最後に、最初のステップで作成した kernel を `lparallel:end-kernel` で閉じます。

実行されるタスクが論理的に parallelisable であることを保証し、すべての mutable state を適切に扱う責任は開発者にあることに注意してください。

_Credit: この記事は最初に
[z0ltan.wordpress.com](https://z0ltan.wordpress.com/2016/09/09/basic-concurrency-and-parallelism-in-common-lisp-part-4a-parallelism-using-lparallel-fundamentals/)
に掲載されました。_

### インストール

lparallel が Quicklisp でダウンロード可能か確認してみましょう。

~~~lisp
CL-USER> (ql:system-apropos "lparallel")
#<SYSTEM lparallel / lparallel-20160825-git / quicklisp 2016-08-25>
#<SYSTEM lparallel-bench / lparallel-20160825-git / quicklisp 2016-08-25>
#<SYSTEM lparallel-test / lparallel-20160825-git / quicklisp 2016-08-25>
; No value
~~~

利用できるようです。インストールしましょう。

~~~lisp
CL-USER> (ql:quickload "lparallel")
To load "lparallel":
  Load 2 ASDF systems:
    alexandria bordeaux-threads
  Install 1 Quicklisp release:
    lparallel
; Fetching #<URL "http://beta.quicklisp.org/archive/lparallel/2016-08-25/lparallel-20160825-git.tgz">
; 76.71KB
==================================================
78,551 bytes in 0.62 seconds (124.33KB/sec)
; Loading "lparallel"
[package lparallel.util]..........................
[package lparallel.thread-util]...................
[package lparallel.raw-queue].....................
[package lparallel.cons-queue]....................
[package lparallel.vector-queue]..................
[package lparallel.queue].........................
[package lparallel.counter].......................
[package lparallel.spin-queue]....................
[package lparallel.kernel]........................
[package lparallel.kernel-util]...................
[package lparallel.promise].......................
[package lparallel.ptree].........................
[package lparallel.slet]..........................
[package lparallel.defpun]........................
[package lparallel.cognate].......................
[package lparallel]
(:LPARALLEL)
~~~

これだけです。では、このライブラリが実際にどのように動くか見てみましょう。

### 前準備 - コア数を取得する

まず、並列処理の例で使用するスレッド数を取得しましょう。理想的には、ワーカースレッドの数と利用可能なコア数が 1:1 で対応しているのが望ましいです。

この目的には、主要なすべてのプラットフォームで動作する `count-cpus` 関数を持つ、優れた **Serapeum** ライブラリを使えます。

インストールします。

~~~lisp
CL-USER> (ql:quickload "serapeum")
~~~

そして呼び出します。

~~~lisp
CL-USER> (serapeum:count-cpus)
8
~~~

それが正しいことを確認します。


### 共通のセットアップ

この例では、初期セットアップの部分を順に見て、セットアップが完了した後にいくつかの有用な情報も表示します。

ライブラリをロードします。

~~~lisp
CL-USER> (ql:quickload "lparallel")
To load "lparallel":
  Load 1 ASDF system:
    lparallel
; Loading "lparallel"

(:LPARALLEL)
~~~

lparallel kernel を初期化します。

~~~lisp
CL-USER> (setf lparallel:*kernel*
               (lparallel:make-kernel 8 :name "custom-kernel"))
#<LPARALLEL.KERNEL:KERNEL :NAME "custom-kernel" :WORKER-COUNT 8 :USE-CALLER NIL :ALIVE T :SPIN-COUNT 2000 {1003141F03}>
~~~

`*kernel*` グローバル変数は再束縛できることに注意してください。これにより、同じ実行中に複数の kernel を共存させられます。では、kernel に関する有用な情報をいくつか見てみましょう。

~~~lisp
CL-USER> (defun show-kernel-info ()
           (let ((name (lparallel:kernel-name))
                 (count (lparallel:kernel-worker-count))
                 (context (lparallel:kernel-context))
                 (bindings (lparallel:kernel-bindings)))
             (format t "Kernel name = ~a~%" name)
             (format t "Worker threads count = ~d~%" count)
             (format t "Kernel context = ~a~%" context)
             (format t "Kernel bindings = ~a~%" bindings)))


WARNING: redefining COMMON-LISP-USER::SHOW-KERNEL-INFO in DEFUN
SHOW-KERNEL-INFO

CL-USER> (show-kernel-info)
Kernel name = custom-kernel
Worker threads count = 8
Kernel context = #<FUNCTION FUNCALL>
Kernel bindings = ((*STANDARD-OUTPUT* . #<SLIME-OUTPUT-STREAM {10044EEEA3}>)
                   (*ERROR-OUTPUT* . #<SLIME-OUTPUT-STREAM {10044EEEA3}>))
NIL
~~~

kernel を終了します（`*kernel*` は明示的に終了するまでガベージコレクトされないため、これは重要です）。

~~~lisp
CL-USER> (lparallel:end-kernel :wait t)
(#<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {100723FA83}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {100723FE23}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {10072581E3}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007258583}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007258923}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007258CC3}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007259063}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007259403}>)
~~~

lparallel ライブラリのさまざまな側面について、さらにいくつかの例に進みましょう。

これらのデモでは、コードの観点から次の初期セットアップを使います。

~~~lisp
(require ‘lparallel)
(require ‘bt-semaphore)

(defpackage :lparallel-user
  (:use :cl :lparallel :lparallel.queue :bt-semaphore))

(in-package :lparallel-user)

;;; initialise the kernel
(defun init ()
  (setf *kernel* (make-kernel 8 :name "channel-queue-kernel")))

(init)
~~~

したがって、8 個の ワーカースレッド（マシン上の各 CPU コアに 1 つ）を持つ kernel を使います。

すべての例が終わったら、次のコードを実行して kernel を閉じ、使用したすべてのシステムリソースを解放します。

~~~lisp
;;; shut the kernel down
(defun shutdown ()
  (end-kernel :wait t))

(shutdown)
~~~

<a id="channels--queues-"></a>

### channels とキューを使う

まず、いくつか定義しておきましょう。

**task** は kernel に投入されるジョブです。これは単に、関数オブジェクトとその引数から成ります。

lparallel における **channel** は、Go における同じ概念に似ています。channel は単に、ワーカースレッドと通信するための手段です。ここでは、kernel にタスクを投入するための 1 つの方法です。

lparallel では `lparallel:make-channel` を使って channel を作成します。タスクは `lparallel:submit-task` で投入し、結果は `lparallel:receive-result` で受け取ります。

たとえば、数の二乗を次のように計算できます。

~~~lisp
(defun calculate-square (n)
  (let* ((channel (lparallel:make-channel))
         (res nil))
    (lparallel:submit-task channel (lambda (x)
                                       (* x x))
                           n)
    (setf res (lparallel:receive-result channel))
    (format t "Square of ~d = ~d~%" n res)))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (calculate-square 100)
Square of 100 = 10000
NIL
~~~

次に、同じ channel に複数のタスクを投入してみましょう。この単純な例では、与えられた入力をそれぞれ二乗、三乗、四乗する 3 つのタスクを作成しているだけです。

複数タスクの場合、出力の順序は非決定的になることに注意してください。

~~~lisp
(defun test-basic-channel-multiple-tasks ()
  (let ((channel (make-channel))
        (res '()))
    (submit-task channel (lambda (x)
                             (* x x))
                 10)
    (submit-task channel (lambda (y)
                             (* y y y))
                 10)
    (submit-task channel (lambda (z)
                             (* z z z z))
                 10)
     (dotimes (i 3 res)
       (push (receive-result channel) res))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (dotimes (i 3)
                              (print (test-basic-channel-multiple-tasks)))

(100 1000 10000)
(100 1000 10000)
(10000 1000 100)
NIL
~~~

lparallel は、ワーカースレッド間のメッセージパッシングを可能にするため、blocking キューを作成するサポートも提供します。キューは `lparallel.queue:make-queue` を使って作成します。

キューを使うための便利な関数には次のものがあります。

-    `lparallel.queue:make-queue`: FIFO blocking キューを作成する
-    `lparallel.queue:push-queue`: キューに要素を挿入する
-    `lparallel.queue:pop-queue`: キューから項目を pop する
-    `lparallel.queue:peek-queue`: pop せずに値を調べる
-    `lparallel.queue:queue-count`: キュー内の entry 数
-    `lparallel.queue:queue-full-p`: キューが満杯か確認する
-    `lparallel.queue:queue-empty-p`: キューが空か確認する
-    `lparallel.queue:with-locked-queue`: アクセス中にキューを lock する

キューの基本的な性質を示す基本デモです。

~~~lisp
    (defun test-queue-properties ()
      (let ((queue (make-queue :fixed-capacity 5)))
        (loop
           when (queue-full-p queue)
           do (return)
           do (push-queue (random 100) queue))
         (print (queue-full-p queue))
        (loop
           when (queue-empty-p queue)
           do (return)
           do (print (pop-queue queue)))
        (print (queue-empty-p queue)))
      nil)
~~~

これにより次の出力が得られます。

~~~lisp
    LPARALLEL-USER> (test-queue-properties)

    T
    17
    51
    55
    42
    82
    T
    NIL
~~~

注: `lparallel.queue:make-queue` は generic インターフェイスであり、実際には異なる種類のキューによって裏付けられています。たとえば前の例では、`:fixed-capacity` キーワード引数を使って固定サイズであることを指定したため、キューの実際の型は `lparallel.vector-queue` です。

ドキュメントには、`lparallel.queue:make-queue` に渡せるキーワード引数が実際には明記されていません。そのため、別の方法で調べてみましょう。

~~~lisp
    LPARALLEL-USER> (describe 'lparallel.queue:make-queue)
    LPARALLEL.QUEUE:MAKE-QUEUE
      [symbol]

    MAKE-QUEUE names a compiled function:
      Lambda-list: (&REST ARGS)
      Derived type: FUNCTION
      Documentation:
        Create a queue.

        The queue contents may be initialized with the keyword argument
        `initial-contents'.

        By default there is no limit on the queue capacity. Passing a
        `fixed-capacity' keyword argument limits the capacity to the value
        passed. `push-queue' will block for a full fixed-capacity queue.
      Source file: /Users/z0ltan/quicklisp/dists/quicklisp/software/lparallel-20160825-git/src/queue.lisp

    MAKE-QUEUE has a compiler-macro:
      Source file: /Users/z0ltan/quicklisp/dists/quicklisp/software/lparallel-20160825-git/src/queue.lisp
    ; No value
~~~

見てのとおり、次のキーワード引数をサポートしています。
*:fixed-capacity* と *initial-contents* です。

`:fixed-capacity` を指定した場合、キューの実際の型は `lparallel.vector-queue` になります。このキーワード引数を省略した場合、キューは `lparallel.cons-queue` 型（サイズ無制限のキュー）になります。これは次のスニペットの出力から分かります。

~~~lisp
    (defun check-queue-types ()
      (let ((queue-one (make-queue :fixed-capacity 5))
            (queue-two (make-queue)))
        (format t "queue-one is of type: ~a~%" (type-of queue-one))
        (format t "queue-two is of type: ~a~%" (type-of queue-two))))


    LPARALLEL-USER> (check-queue-types)
    queue-one is of type: VECTOR-QUEUE
    queue-two is of type: CONS-QUEUE
    NIL
~~~

もちろん、特定のキュー型のインスタンスを自分で作成することもいつでもできます。しかし可能な場合は、generic インターフェイスを使い、適切なキュー型の作成をライブラリに任せる方が常によいでしょう。

では、キューが実際に動く様子を見てみましょう。

~~~lisp
    (defun test-basic-queue ()
      (let ((queue (make-queue))
            (channel (make-channel))
            (res '()))
        (submit-task channel (lambda ()
                         (loop for entry = (pop-queue queue)
                            when (queue-empty-p queue)
                            do (return)
                            do (push (* entry entry) res))))
        (dotimes (i 100)
          (push-queue i queue))
        (receive-result channel)
        (format t "~{~d ~}~%" res)))
~~~

ここでは、キューが空になるまで繰り返し走査し、利用可能な値を pop して res リストに push する単一のタスクを投入しています。

出力は次のとおりです。

~~~lisp
    LPARALLEL-USER> (test-basic-queue)
    9604 9409 9216 9025 8836 8649 8464 8281 8100 7921 7744 7569 7396 7225 7056 6889 6724 6561 6400 6241 6084 5929 5776 5625 5476 5329 5184 5041 4900 4761 4624 4489 4356 4225 4096 3969 3844 3721 3600 3481 3364 3249 3136 3025 2916 2809 2704 2601 2500 2401 2304 2209 2116 2025 1936 1849 1764 1681 1600 1521 1444 1369 1296 1225 1156 1089 1024 961 900 841 784 729 676 625 576 529 484 441 400 361 324 289 256 225 196 169 144 121 100 81 64 49 36 25 16 9 4 1 0
    NIL
~~~

###    タスクを kill する

ここで `lparallel:kill-task` 関数について少し触れておくのがよいでしょう。この関数は、タスクが応答しない場合に有用です。lparallel のドキュメントは、これを最後の手段としてのみ使うべきだと明確に述べています。

作成されたすべてのタスクには、デフォルトで :default というカテゴリが割り当てられます。動的プロパティ `*task-category*` がこの値を保持しており、（後で見るように）別の値へ動的に束縛できます。

~~~lisp
;;; kill default tasks
(defun test-kill-all-tasks ()
  (let ((channel (make-channel))
        (stream *query-io*))
    (dotimes (i 10)
      (submit-task
          channel
          (lambda (x)
            (sleep (random 10))
            (format stream "~d~%" (* x x))) (random 10)))
    (sleep (random 2))
    (kill-tasks :default)))
~~~

サンプル実行:

~~~lisp
LPARALLEL-USER> (test-kill-all-tasks)
16
1
8
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
~~~

10 個のタスクを作成していたため、8 個の kernel ワーカースレッドはすべて、それぞれ 1 つのタスクで忙しかったはずです。カテゴリ :default のタスクを kill すると、これらのスレッドもすべて kill され、再生成が必要になります（これは高コストな操作です）。これが `lparallel:kill-tasks` を避けるべき理由の一部です。

上の例では、実行中のすべてのタスクが :default カテゴリに属していたため、すべて kill されました。特定のタスクだけを kill したい場合は、それらのタスクを作成するときに `*task-category*` を束縛し、`lparallel:kill-tasks` を呼び出すときにカテゴリを指定すれば実現できます。

たとえば、引数を二乗するタスクと三乗するタスクという 2 つのカテゴリがあるとします。それぞれに ’squaring-tasks と ’cubing-tasks というカテゴリを割り当てます。そして、ランダムに選んだカテゴリ ’squaring-tasks または ’cubing-tasks のタスクを kill します。

コードは次のとおりです。

~~~lisp
;;; kill tasks of a randomly chosen category
(defun test-kill-random-tasks ()
  (let ((channel (make-channel))
        (stream *query-io*))
    (let ((*task-category* 'squaring-tasks))
      (dotimes (i 5)
        (submit-task channel
                     (lambda (x)
                       (sleep (random 5))
                       (format stream "~%[Squaring] ~d = ~d"
                               x (* x x))) i)))
    (let ((*task-category* 'cubing-tasks))
      (dotimes (i 5)
        (submit-task channel
                    (lambda (x)
                       (sleep (random 5))
                       (format stream "~%[Cubing] ~d = ~d"
                               x (* x x x))) i)))
    (sleep 1)
    (if (evenp (random 10))
        (progn
          (print "Killing squaring tasks")
          (kill-tasks 'squaring-tasks))
        (progn
          (print "Killing cubing tasks")
          (kill-tasks 'cubing-tasks)))))
~~~

サンプル実行は次のとおりです。

~~~lisp
LPARALLEL-USER> (test-kill-random-tasks)

[Cubing] 2 = 8
[Squaring] 4 = 16
[Cubing] 4
 = [Cubing] 643 = 27
"Killing squaring tasks"
4
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.

[Cubing] 1 = 1
[Cubing] 0 = 0

LPARALLEL-USER> (test-kill-random-tasks)

[Squaring] 1 = 1
[Squaring] 3 = 9
"Killing cubing tasks"
5
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.

[Squaring] 2 = 4
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.

[Squaring] 0 = 0
[Squaring] 4 = 16
~~~

### promises と futures を使う

Promises と Futures は非同期プログラミングのサポートを提供します。

lparallel の用語では、`lparallel:promise` は、値を与えることで fulfilled される結果のプレースホルダーです。promise オブジェクト自体は `lparallel:promise` を使って作成し、`lparallel:fulfill` マクロを使って promise に値を与えます。

promise がすでに fulfilled されているかどうかを確認するには、`lparallel:fulfilledp` 述語関数を使えます。最後に、`lparallel:force` 関数を使って promise から値を取り出します。この関数は操作が完了するまでブロックすることに注意してください。

まず非常に単純な例で、これらの概念を固めましょう。

~~~lisp
(defun test-promise ()
  (let ((p (promise)))
    (loop
       do (if (evenp (read))
              (progn
                (fulfill p 'even-received!)
                (return))))
    (force p)))
~~~

これにより次の出力が生成されます。

~~~lisp
LPARALLEL-USER> (test-promise)
5
1
3
10
EVEN-RECEIVED!
~~~

説明: この単純な例は、偶数が入力されるまで単に永久にループし続けます。ループ内で `lparallel:fulfill` を使って promise を fulfilled し、その後 `lparallel:force` で force することで値を関数から返します。

次に、もう少し大きな例を見てみましょう。promise が fulfilled されるのを待ちたくなく、その代わり現在の処理に有用な作業をさせたいとします。次の例のように、promise の fulfillment を明示的に外部へ委譲できます。

引数を二乗する関数があるとしましょう。議論のために、その処理には長い時間がかかるとします。クライアントコードからそれを呼び出し、二乗された値が利用可能になるまで待ちたいとします。


~~~lisp
(defun promise-with-threads ()
  (let ((p (promise))
        (stream *query-io*)
        (n (progn
             (princ "Enter a number: ")
             (read))))
    (format t "In main function...~%")
    (bt:make-thread
     (lambda ()
         (sleep (random 10))
         (format stream "Inside thread... fulfilling promise~%")
         (fulfill p (* n n))))
    (bt:make-thread
     (lambda ()
         (loop
            when (fulfilledp p)
            do (return)
            do (progn
                 (format stream "~d~%" (random 100))
                 (sleep (* 0.01 (random 100)))))))
    (format t "Inside main function, received value: ~d~%"
            (force p))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (promise-with-threads)
Enter a number: 19
In main function...
44
59
90
34
30
76
Inside thread... fulfilling promise
Inside main function, received value: 361
NIL
~~~

説明: この例にはそれほど多くのことはありません。promise オブジェクト p を作成し、ランダムな時間 sleep した後、値を与えて promise を fulfill するスレッドを生成します。

一方、メインスレッドでは、promise が fulfilled されているかどうかを確認し続ける別のスレッドを生成します。まだであれば、いくつかのランダムな数を表示して確認を続けます。promise が fulfilled されると、示したようにメインスレッドで `lparallel:force` を使って値を取り出せます。

これは、promise を作成したコードが promise の fulfillment を待つ必要なしに、別のスレッドが promise を fulfill できることを示しています。前述のとおり `lparallel:force` はブロッキング呼び出しなので、これは特に重要です。実際に値が利用可能になるまで、promise の force を遅らせたいのです。

promises を使う際にもう 1 つ注意すべき点は、promise が一度 fulfilled されると、同じオブジェクトに対して force を呼び出しても常に同じ値が返ることです。つまり、promise は正常には一度だけ fulfilled できます。

たとえば次のとおりです。

~~~lisp
(defun multiple-fulfilling ()
  (let ((p (promise)))
    (dotimes (i 10)
      (fulfill p (random 100))
      (format t "~d~%" (force p)))))
~~~

これにより次の出力が得られます。

~~~lisp
LPARALLEL-USER> (multiple-fulfilling)
15
15
15
15
15
15
15
15
15
15
NIL
~~~

では、future は promise とどう違うのでしょうか？

`lparallel:future` は、単に並列に実行される promise です。そのため、`lparallel:promise` のデフォルトの使い方のようにメインスレッドをブロックしません。もちろん lparallel ライブラリによって、自身のスレッドで実行されます。

future の単純な例です。

~~~lisp
(defun test-future ()
  (let ((f (future
             (sleep (random 5))
             (print "Hello from future!"))))
    (loop
       when (fulfilledp f)
       do (return)
       do (sleep (* 0.01 (random 100)))
         (format t "~d~%" (random 100)))
    (format t "~d~%" (force f))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (test-future)
5
19
91
11
Hello from future!
NIL
~~~

説明: これは `promise-with-threads` の例とまったく似ています。ただし 2 つの違いがあります。まず、`lparallel:future` マクロにも本体があります。これにより future は自分自身を fulfill できます。つまり、future の本体の実行が完了するとすぐに、`lparallel:fulfilledp` はその future オブジェクトに対して常に true を返します。

次に、future 自体はライブラリによって別スレッドに生成されるため、現在のスレッドの実行をあまり妨げません。これは、現在のスレッドをブロックしないよう fulfillment コード用に明示的なスレッドが必要だった promise-with-threads の例で見た promises とは異なります。

最も興味深い点は、（Dan Friedman らが提唱した実際の理論の観点でも）Future は概念上 Promise を fulfill するものだということです。つまり、promise は将来のある時点で何らかの値が生成されるという契約であり、future はまさにその仕事を行う「何か」です。

これは、lparallel ライブラリを使う場合でも、future の基本的な使い方は promise を fulfill することだ、という意味です。つまり promise-with-threads のようなハックをユーザーが書く必要はありません。

この点を示すため、小さな例を見てみましょう（かなり作為的な例であることは認めます）。

シナリオは次のとおりです。数を読み込み、その二乗を計算したいとします。そこで、この作業を別の関数にオフロードし、自分自身の作業を続けます。結果が準備できたら、こちらが介入しなくてもコンソールに表示されてほしいとします。

コードは次のようになります。

~~~lisp
;;; Callback example using promises and futures
(defun callback-promise-future-demo ()
  (let* ((p (promise))
         (stream *query-io*)
         (n (progn
              (princ "Enter a number: ")
              (read)))
         (f (future
              (sleep (random 10))
              (fulfill p (* n n))
              (force (future
                       (format stream "Square of ~d = ~d~%"
                               n (force p)))))))
    (loop
       when (fulfilledp f)
       do (return)
       do (sleep (* 0.01 (random 100))))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (callback-promise-future-demo)
Enter a number: 19
Square of 19 = 361
NIL
~~~

説明: まず、生成された二乗値を保持するための promise を作成します。これが p オブジェクトです。入力値はローカル変数 n に格納されます。

次に future オブジェクト f を作成します。この future は単に入力値を二乗し、その値で promise を fulfill します。最後に、出力を適切なタイミングで表示したいので、示したように出力文字列を表示するだけの無名 future を force します。

これは Node のような環境に非常によく似ていることに注意してください。そこでは、呼び出された関数が作業を終えたときに callback が呼ばれるという理解のもと、callback 関数を他の関数に渡します。

最後に、次のスニペットは（ブロッキングな `lparallel:force` 呼び出しを使っていても、別スレッド上なので）依然として問題ないことに注意してください。


~~~lisp
(force (future
(format stream "Square of ~d = ~d~%" n (force p))))
~~~

まとめると、一般的な使用イディオムは次のとおりです。**非同期計算の結果を保持するオブジェクトを promises として定義し、それらの promises を fulfill するために futures を使う**。

### cognates を使う - Common Lisp の対応物の並列版

Cognates は、おそらく lparallel ライブラリの存在理由です。これらの構文こそが、lparallel に真の parallelism を提供します。ただし、これらの構文のほとんど（すべてではないにせよ）は futures と promises の上に構築されていることに注意してください。

簡潔に言えば、cognates は Common Lisp の対応物の並列版となることを意図した関数です。ただし、Common Lisp に対応物を持たない lparallel 独自の cognates もいくつかあります。

ここで、cognates には基本的に 2 種類あることを知っておくことが重要です。

-    細粒度の parallelism のための構文: `defpun`、`plet`、`plet-if` など。
-   並列操作を行う明示的な関数とマクロ -
    `pmap`、`preduce`、`psort`、`pdotimes` など。

最初の場合、操作自体に対する明示的な制御はあまりありません。ライブラリ自身が可能な範囲でフォームを最適化し並列化する、という事実にほぼ依存します。この記事では、2 つ目のカテゴリの cognates に焦点を当てます。

たとえば、cognate 関数 `lparallel:pmap` は Common Lisp の対応物である `map` とまったく同じですが、並列に実行されます。例で示しましょう。

長さが 3 から 10 まで変化するランダムな文字列のリストがあり、その長さを vector に集めたいとします。

まず、ランダム文字列を生成する helper 関数を用意しましょう。

~~~lisp
(defvar *chars*
  (remove-duplicates
   (sort
    (loop for c across "The quick brown fox jumps over the lazy dog"
       when (alpha-char-p c)
       collect (char-downcase c))
    #'char<)))

(defun get-random-strings (&optional (count 100000))
  "generate random strings between lengths 3 and 10"
  (loop repeat count
     collect
       (concatenate 'string  (loop repeat (+ 3 (random 8))
                           collect (nth (random 26) *chars*)))))
~~~

Common Lisp の map による解決策は次のようになります。

~~~lisp
;;; map demo
(defun test-map ()
  (map 'vector #'length (get-random-strings 100)))
~~~

テスト実行してみましょう。

~~~lisp
LPARALLEL-USER> (test-map)
#(7 5 10 8 7 5 3 4 4 10)
~~~

そして、これが `lparallel:pmap` による対応版です。

~~~lisp
;;;pmap demo
(defun test-pmap ()
  (pmap 'vector #'length (get-random-strings 100)))
~~~

これにより次の出力が得られます。

~~~lisp
LPARALLEL-USER> (test-pmap)
#(8 7 6 7 6 4 5 6 5 7)
LPARALLEL-USER>
~~~

test-map と test-pmap の定義から分かるように、`lparallel:map` 関数と `lparallel:pmap` 関数の構文はまったく同じです（ほぼ同じ、というべきでしょう。`lparallel:pmap` には追加の optional 引数がいくつかあります）。

便利な cognate 関数とマクロをいくつか挙げます（明示的に示したものを除き、すべて関数です）。cognates はかなり多くありますが、各カテゴリを例で代表できるよう、いくつかを選びました。

#### lparallel:pmap: map の並列版。

すべての mapping 関数（`lparallel:pmap`、**lparallel:pmapc**、`lparallel:pmapcar` など）は、2 つの特別なキーワード引数を取ることに注意してください。

- `:size`: 処理する入力 sequence の要素数を指定します。
- `:parts`: sequence を分割する並列 part 数を指定します。

~~~lisp
    ;;; pmap - function
    (defun test-pmap ()
      (let ((numbers (loop for i below 10
                        collect i)))
        (pmap 'vector (lambda (x)
                          (* x x))
              :parts (length numbers)
              numbers)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pmap)

    #(0 1 4 9 16 25 36 49 64 81)
~~~

#### lparallel:por: or の並列版。

動作としては、引数のうち最初の non-nil 要素を返します。ただし、このマクロの並列性により、その要素は変化します。


~~~lisp
    ;;; por - macro
    (defun test-por ()
      (let ((a 100)
            (b 200)
            (c nil)
            (d 300))
        (por a b c d)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (dotimes (i 10)
                      (print (test-por)))

    300
    300
    100
    100
    100
    300
    100
    100
    100
    100
    NIL
~~~

通常の or 演算子の場合、常に最初の non-nil 要素、すなわち 100 を返していたでしょう。


#### lparallel:pdotimes: dotimes の並列版。

このマクロも optional な `:parts` 引数を取ることに注意してください。


~~~lisp
    ;;; pdotimes - macro
    (defun test-pdotimes ()
      (pdotimes (i 5)
        (declare (ignore i))
        (print (random 100))))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pdotimes)

    39
    29
    81
    42
    56
    NIL
~~~

####  lparallel:pfuncall: funcall の並列版。


~~~lisp
    ;;; pfuncall - macro
    (defun test-pfuncall ()
      (pfuncall #'* 1 2 3 4 5))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pfuncall)

    120
~~~

####    lparallel:preduce: reduce の並列版。

この非常に重要な関数も、2 つの optional keyword 引数を取ります。`:parts`（説明したものと同じ意味）と `:recurse` です。`:recurse` が non-nil の場合、引数に対して `lparallel:preduce` を再帰的に適用します。そうでなければ、デフォルトで reduce を使います。

~~~lisp
    ;;; preduce - function
    (defun test-preduce ()
      (let ((numbers (loop for i from 1 to 100
                        collect i)))
        (preduce #'+
                 numbers
                 :parts (length numbers)
                 :recurse t)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-preduce)

    5050
~~~

####    lparallel:premove-if-not: remove-if-not の並列版。

これは関数型プログラミングの用語でいう “filter” と本質的に同等です。


~~~lisp
    ;;; premove-if-not
    (defun test-premove-if-not ()
      (let ((numbers (loop for i from 1 to 100
                        collect i)))
        (premove-if-not #'evenp numbers)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-premove-if-not)

    (2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54
     56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100)
~~~

####    lparallel:pevery: every の並列版。


~~~lisp
    ;;; pevery - function
    (defun test-pevery ()
      (let ((numbers (loop for i from 1 to 100
                        collect i)))
        (list (pevery #'evenp numbers)
              (pevery #'integerp numbers))))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pevery)

    (NIL T)
~~~

この例では 2 つの確認を行っています。まず、範囲 [1,100] のすべての数が偶数かどうか。次に、同じ範囲のすべての数が整数かどうかです。

#### lparallel:count: count の並列版。

~~~lisp
    ;;; pcount - function
    (defun test-pcount ()
      (let ((chars "The quick brown fox jumps over the lazy dog"))
        (pcount #\e chars)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pcount)

    3
~~~

####    lparallel:psort: sort の並列版。


~~~lisp
    ;;; psort - function
    (defstruct person
      name
      age)

    (defun test-psort ()
      (let* ((names (list "Peter" "Sybil" "Basil" "Candy" "Olga"))
             (people (loop for name in names
                        collect (make-person :name name
                                             :age (+ (random 20)
                                                     20)))))
        (print "Before sorting...")
        (print people)
        (fresh-line)
        (print "After sorting...")
        (psort
         people
         (lambda (x y)
             (< (person-age x)
                (person-age y)))
         :test #'=)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-psort)

    "Before sorting..."
    (#S(PERSON :NAME "Peter" :AGE 24) #S(PERSON :NAME "Sybil" :AGE 20)
     #S(PERSON :NAME "Basil" :AGE 22) #S(PERSON :NAME "Candy" :AGE 23)
     #S(PERSON :NAME "Olga" :AGE 33))

    "After sorting..."
    (#S(PERSON :NAME "Sybil" :AGE 20) #S(PERSON :NAME "Basil" :AGE 22)
     #S(PERSON :NAME "Candy" :AGE 23) #S(PERSON :NAME "Peter" :AGE 24)
     #S(PERSON :NAME "Olga" :AGE 33))
~~~

この例では、まず人に関する情報を保存するための person 型の構造体を定義します。次に、ランダムに生成された年齢（20 から 39 の間）を持つ 7 人のリストを作成します。最後に、年齢の非減少順でソートします。

### エラーハンドリング

lparallel がエラーハンドリングをどのように扱うか（ヒント: `lparallel:task-handler-bind`）については、
[lparallel-error-handling](https://z0ltan.wordpress.com/2016/09/10/basic-concurrency-and-parallelism-in-common-lisp-part-4b-parallelism-using-lparallel-error-handling/)
を読んでください。


## Slime でスレッドを監視・制御する

**M-x slime-list-threads**（*slime-selector* からショートカット **t** でもアクセスできます）は、実行中のスレッドを名前と状態付きで一覧表示します。

現在行のスレッドは **k** で kill できます。kill したいスレッドが多い場合は、複数行を選択して **k** を押すと、選択範囲内のすべてのスレッドを kill できます。

**g** はスレッド一覧を更新します。しかし、多くのスレッドが開始・停止している場合、毎回 **g** を押すのは面倒かもしれません。そのため `slime-threads-update-interval` という変数があります。数値 X に設定すると、スレッド一覧は X 秒ごとに自動更新されます。妥当な値は 0.5 でしょう。

[Slime tips](https://slime-tips.tumblr.com/) に感謝します。


## 参考資料

もちろん、lparallel ライブラリを使って並列計算を行うための関数、オブジェクト、イディオムは他にもたくさんあります。この記事はそれらの表面をかすめているにすぎません。しかし、操作の一般的な流れはここで十分に示されています。さらに読むには、次の資料が役立つでしょう。

- [ドキュメントを含む lparallel ライブラリの公式ホームページ](https://lparallel.org/)
- [The Common Lisp Hyperspec](https://www.lispworks.com/documentation/HyperSpec/Front/)、そしてもちろん
- 使用している Common Lisp 処理系の
  マニュアル。[SBCL については、公式マニュアルへのリンクがここにあります](http://www.sbcl.org/manual/)
- 尊敬すべき Edi Weitz による [Common Lisp recipes](http://weitz.de/cl-recipes/)。
- [Awesome-cl#parallelism-and-concurrency](https://github.com/CodyReichert/awesome-cl#parallelism-and-concurrency) リストにある、より多くの concurrency および threading ライブラリ。
