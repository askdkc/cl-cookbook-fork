---
title: エラーと例外処理
---

Common Lisp には、ほかの言語に見られるようなエラー処理と condition 処理の仕組みがあり、さらにそれ以上のことができます。

condition とは何でしょうか？

> 例外処理をサポートする言語（Java、C++、Python など）と同じく、condition は多くの場合「例外的」な状況を表します。しかし、それらの言語以上に、*Common Lisp の condition は、必ずしもエラー状態に起因しない、プログラムロジック上の分岐が必要になる一般的な状況を表すことができます*。Lisp 開発の非常に対話的な性質（REPL と組み合わせた Lisp イメージ）を考えると、これは Java や、非常に原始的な REPL しか持たない Python のような言語よりも、Lisp のような言語では完全に理にかなっています。ただし多くの場合、このシステムが提供する対話性を必要としない（あるいは許可すらしない）かもしれません。ありがたいことに、同じシステムは非対話モードでも同じようにうまく機能します。
>
> [z0ltan](https://z0ltan.wordpress.com/2016/08/06/conditions-and-restarts-in-common-lisp/)

順を追って見ていきましょう。追加の資料は後半にあります。

## Throwing/catching と signaling/handling

Common Lisp には throw と catch の概念がありますが、これは C++ や Java の throwing/catching とは異なる概念を指します。Common Lisp の [`throw`](https://www.lispworks.com/documentation/HyperSpec/Body/s_throw.htm) と [`catch`](https://www.lispworks.com/documentation/HyperSpec/Body/s_catch.htm)（[Ruby](https://ruby-doc.com/docs/ProgrammingRuby/html/tut_exceptions.html#S4) と同じく！）は制御の移動のための仕組みであり、condition を扱うものではありません。

Common Lisp では condition は *signaled* され、signaled された condition に応じてコードを実行する過程を *handling* と呼びます。Java や C++ と違い、condition を handle することは、ただちにスタックが巻き戻されることを意味しません。スタックを巻き戻すかどうか、どの状況でそうするかは、個々の handler 関数が決めます。

## すべてのエラーを無視し、nil を返す

関数が失敗し得ることを知っていて、それをただ無視したい場合があります。そのときは [ignore-errors][ignore-errors] を使います。

~~~lisp
(ignore-errors
  (/ 3 0))
; in: IGNORE-ERRORS (/ 3 0)
;     (/ 3 0)
;
; caught STYLE-WARNING:
;   Lisp error during constant folding:
;   arithmetic error DIVISION-BY-ZERO signalled
;   Operation was (/ 3 0).
;
; compilation unit finished
;   caught 1 STYLE-WARNING condition
NIL
#<DIVISION-BY-ZERO {1008FF5F13}>
~~~

ありがたいことに `division-by-zero` の警告は得られますが、コードは実行され、2 つの値を返します。`nil` と、signal された condition です。何を返すかは選べませんでした。

Slime では右クリックで condition を `inspect` できることを思い出してください。


## `handler-case` ですべての error condition を扱う

<!-- we will say "handling" for handler-bind -->

`ignore-errors` は [handler-case][handler-case] から作られています。前の例を、一般的な `error` を handle する形で書けますが、今度は好きなものを返せます。

~~~lisp
(handler-case (/ 3 0)
  (error (c)
    (format t "We handled an error.~&")
    (values 0 c)))
; in: HANDLER-CASE (/ 3 0)
;     (/ 3 0)
;
; caught STYLE-WARNING:
;   Lisp error during constant folding:
;   Condition DIVISION-BY-ZERO was signalled.
;
; compilation unit finished
;   caught 1 STYLE-WARNING condition
We handled an error.
0
#<DIVISION-BY-ZERO {1004846AE3}>
~~~

ここでも 2 つの値、0 と signal された condition を返しました。

`handler-case` の一般形は次のとおりです。

~~~lisp
(handler-case (code that can error out)
   (condition-type (the-condition) ;; <-- optional argument
      (code))
   (another-condition (the-condition)
       ...))
~~~

`handler-case` に続く `(code that can error out)` は 1 つのフォームでなければなりません。複数の式を書きたい場合は `progn` で包みます。


## 特定の condition を扱う

どの condition を扱うか指定できます。

~~~lisp
(handler-case (/ 3 0)
  (division-by-zero (c)
    (format t "Got division by zero: ~a~%" c)))
;; …
;; Got division by zero: arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;; NIL
~~~

これは、ほかの言語で知られる「通常の」例外処理に最も近い仕組みです。C++ と Java の `throw`/`try`/`catch`、Python の `raise`/`try`/`except`、Ruby の `raise`/`begin`/`rescue` などです。しかし、Common Lisp ではもっと多くのことができます。

## condition と restart を完全に制御する: `handler-bind`

[handler-bind][handler-bind] は、condition が signal されたときに何が起きるかを完全に制御したい場合に使います。スタックを巻き戻しません。この点は次の節で示します。デバッガと restarts を、対話的にもプログラム的にも使えるようにします。

一般形は次のとおりです。

~~~lisp
(handler-bind ((a-condition #'function-to-handle-it)
               (another-one #'another-function))
    (code that can...)
    (...error out…)
    (... with an implicit PROGN))
~~~

例:

~~~lisp
(defun handler-bind-example ()
  (handler-bind
        ((error (lambda (c)
                  (format t "we handle this condition: ~a" c)
                  ;; この return-from を外して試すと、エラーは対話的デバッガまで伝播する。
                  (return-from handler-bind-example))))
      (format t "starting example…~&")
      (error "oh no")))
~~~

`handler-case` と比べると構文が「逆」になっていることに気づくでしょう。先に bindings があり、次に（暗黙の progn 内の）フォームがあります。

handler が通常どおり戻った場合（condition の処理を辞退した場合）、condition は別の handler を探して伝播し続け、最終的に対話的デバッガに到達します。

これも `handler-case` との違いです。handler 関数が `return-from handler-bind-example` で呼び出し元関数から明示的に戻らなければ、エラーは伝播し続け、対話的デバッガが表示されます。

この挙動は、プログラムが simple condition を signal したときに特に便利です。simple condition はエラーではないため（下の「condition 階層」を参照）、デバッガを起動しません。condition（アプリケーション内で何かが起きたという signal）に対して何か処理を行い、プログラムを続行できます。

あるライブラリがすべての condition を処理せず、いくつかをこちらへ伝播させる場合、スタックの深い場所にある restarts（`restart-case` により確立されたもの）を見ることができます。そのライブラリが呼び出した別ライブラリが確立した restarts も含まれます。

### handler-bind はスタックを巻き戻さない

`handler-bind` では、*すべての呼び出しフレームを含む完全なスタックトレースを見られます*。`handler-case` を使うと、condition が処理されるまでのプログラム実行の多くの段階を「忘れ」ます。コールスタックが巻き戻されるためです。`handler-bind` はスタックを巻き戻しません。これを示します。

デモのため、Quicklisp でインストールできる `trivial-backtrace` ライブラリを使います。

    (ql:quickload "trivial-backtrace")

これは `sb-debug:print-backtrace` など、処理系のプリミティブを包むラッパーです。

次のコードを考えます。`main` 関数は、最終的に `error` を signal して失敗する関数の連鎖を呼び出します。main 関数でエラーを処理し、バックトレースを出力します。

~~~lisp
(defun f0 ()
  (error "oh no"))

(defun f1 ()
  (f0))

(defun f2 ()
  (f1))

(defun main ()
  (handler-case (f2)
    (error (c)
      (format t "in main, we handle: ~a" c)
      (trivial-backtrace:print-backtrace c))))
~~~

これがバックトレースです（最初のフレームだけ）。

```
CL-REPL> (main)
in main, we handle: oh no
Date/time: 2025-07-04-11:25!
An unhandled error condition has been signalled: oh no

Backtrace for: #<SB-THREAD:THREAD "repl-thread" RUNNING {1008695453}>
0: […]
1: (TRIVIAL-BACKTRACE:PRINT-BACKTRACE … )
2: (MAIN)
[…]
```

ここまでは問題ありません。"Date/time" と "An unhandled error condition…" というメッセージを出しているのは `trivial-backtrace` です。

次に、`handler-bind` を使った場合の stacktrace と比較します。

```lisp
(defun main-no-stack-unwinding ()
  (handler-bind
      ((error (lambda (c)
                (format t "in main, we handle: ~a" c)
                (trivial-backtrace:print-backtrace c)
                (return-from main-no-stack-unwinding))))
    (f2)))
```

```
CL-REPL> (main-no-stack-unwinding)
in main, we handle: oh no
Date/time: 2025-07-04-11:32!
An unhandled error condition has been signalled: oh no


Backtrace for: #<SB-THREAD:THREAD "repl-thread" RUNNING {1008695453}>
0: …
1: (TRIVIAL-BACKTRACE:PRINT-BACKTRACE …)
2: …
3: …
4: (ERROR "oh no")
5: (F0)
6: (F1)
7: (MAIN-NO-STACK-UNWINDING)
```

その通りです。main 関数から `f1` と `f0` を通ってエラーに至る、すべてのコールスタックが見えます。`handler-case` を使ったときのバックトレースに、この 2 つの中間関数はありませんでした。エラーが signal され、コールスタックを伝播するにつれて、スタックが *unwound*（「ほどかれた」「短くされた」）され、情報を失ったからです。


### どちらをいつ使うか

失敗する状況を予期しているなら、`handler-case` で十分です。たとえば HTTP リクエストの文脈では、400 番台のエラーを想定するのは普通です。

~~~lisp
;; dexador ライブラリを使う。
(handler-case (dex:get "http://bad-url.lisp")
  (dex:http-request-failed (e)
    ;; 4xx または 5xx HTTP エラー: 起こり得るので問題ない。
    (format *error-output* "The server returned ~D" (dex:response-status e))))
~~~

その他の例外的な状況では、おそらく `handler-bind` が欲しくなります。たとえば、何が問題だったかを処理し、バックトレースを出力したい場合、または手動でデバッガを起動し（下記参照）、正確に何が起きたかを見たい場合です。

## condition の有無にかかわらずコードを実行する（"finally"）（unwind-protect）

ほかの `try`/`catch`/`finally` フォームにおける "finally" 部分は [unwind-protect][unwind-protect] で行います。

これは `with-open-file` のような "with-" マクロで使われる構文で、処理後に必ずファイルを閉じます。

この例では:

~~~lisp
(unwind-protect (/ 3 0)
  (format t "This place is safe.~&"))
~~~

SBCL ソース:

```lisp
(sb-xc:defmacro with-open-file ((stream filespec &rest options)
                                &body body)
  (multiple-value-bind (forms decls) (parse-body body nil)
    (let ((abortp (sb-xc:gensym)))
      `(let ((,stream (open ,filespec ,@options))
             (,abortp t))
         ,@decls
         (unwind-protect
              (multiple-value-prog1
                  (progn ,@forms)
                (setq ,abortp nil))
           (when ,stream
             (close ,stream :abort ,abortp)))))))
```

単純化すると:

```lisp
(defmacro with-open-file ((stream filespec) &body body)
  `(let ((,stream (open ,filespec)))
    (unwind-protect
      (progn ,@body)
     (when ,stream
       (close ,stream)))))
```

なぜなら、次を:

```lisp
(let ((stream (open "filename.txt" :direction :input :if-does-not-exist :create :if-exists :overwrite)))
    (unwind-protect
      (format stream "hello file")
     (when stream
       (close stream))))
```

次のように単純に書きたいからです。

```lisp
(with-open-file (f "filename.txt" …)
  (format stream "hello"))
```

対話的デバッガは*表示されます*（`handler-bind` などは使っていません）が、それでもその後にメッセージは出力されます。

## condition を定義し作る

[define-condition][define-condition] で condition を定義し、[make-condition][make-condition] でそれを作成（初期化）します。

~~~lisp
(define-condition my-division-by-zero (error)
  ())

(make-condition 'my-division-by-zero)
;; #<MY-DIVISION-BY-ZERO {1005A5FE43}>
~~~

condition を作るときにより多くの情報を与えた方がよいので、slots を使いましょう。

~~~lisp
(define-condition my-division-by-zero (error)
  ((dividend :initarg :dividend
             :initform nil
             :reader dividend)) ;; <-- (dividend condition) で dividend を得られる。必要なら CLOS チュートリアルを参照。
  (:documentation "Custom error when we encounter a division by zero.")) ;; よい習慣 ;)
~~~

これで、コード内で condition を signal するときに、後で利用される情報を埋め込めます。

~~~lisp
(make-condition 'my-division-by-zero :dividend 3)
;; #<MY-DIVISION-BY-ZERO {1005C18653}>
~~~

<div class="info-box info">
<p>
<strong>Note:</strong> <a href="clos.html">Common Lisp Object System</a> についてまだ十分でない場合の、クラスに関する簡単なおさらいです。
</p>
</div>

~~~lisp
(make-condition 'my-division-by-zero :dividend 3)
;;                                   ^^ これが ":initarg"
~~~

そして `:reader dividend` は、`my-division-by-zero` オブジェクトの dividend に対する "getter" である*総称関数*を作りました。

~~~lisp
(make-condition 'my-division-by-zero :dividend 3)
;; #<MY-DIVISION-BY-ZERO {1005C18653}>
(dividend *)
;; 3
~~~

`:accessor` なら getter と setter の両方になります。

つまり、`define-condition` の一般形は通常のクラス定義のように見え、感じられます。ただし似ていても、condition は standard object ではありません。

違いの 1 つは、slots に対して `slot-value` を使えないことです。


## condition を signal する: error, cerror, warn, signal

[error][error] は 2 通りに使えます。

- `(error "some text")`: [simple-error][simple-error] 型の condition を signal します。
- `(error 'my-error :message "We did this and that and it didn't work.")`: `message` slot に値を与えたカスタム condition を作成し signal します。

どちらの場合も、condition が handle されなければ、`error` は対話的デバッガを開き、ユーザーは実行を続けるための restart を選べます。

上で定義した独自 condition 型では、次のようにできます。

~~~lisp
(error 'my-division-by-zero :dividend 3)
;; これは次のショートカット
(error (make-condition 'my-division-by-zero :dividend 3))
~~~

`cerror` は `error` に似ていますが、ユーザーが実行を続けるために使える `continue` restart を自動的に確立します。最初の引数として文字列を受け取り、この文字列はその restart のユーザーに見える report として使われます。

`warn` はデバッガには入りません（warning condition は [warning][warning] を subclass して作ります）。condition が handle されなければ、代わりに警告を error output へ記録します。

何も出力したくなく、デバッガにも入りたくないが、何らかの注目すべき状況が起きたことを上位レベルへ signal したい場合は、[signal][signal] を使います。

その状況は、コードの通常動作中に情報を渡すことから、エラーのような重大な状況まで何でも構いません。たとえば、操作中の進捗を追跡するために使えます。`percent` slot を持つ condition を作り、進捗があるたびに signal し、上位コードがそれを handle してユーザーに表示できます。詳しくは下の資料を参照してください。

### condition 階層

`simple-error` の class precedence list は `simple-error, simple-condition, error, serious-condition, condition, t` です。

`simple-warning` の class precedence list は `simple-warning, simple-condition, warning, condition, t` です。


### カスタムエラーメッセージ（:report）

ここまで、エラーを signal したとき、デバッガには次のデフォルトテキストが表示されていました。

```
Condition COMMON-LISP-USER::MY-DIVISION-BY-ZERO was signalled.
   [Condition of type MY-DIVISION-BY-ZERO]
```

condition 宣言に `:report` 関数を与えることで、もっとよくできます。

~~~lisp
(define-condition my-division-by-zero (error)
  ((dividend :initarg :dividend
             :initform nil
             :accessor dividend))
  ;; :report はデバッガ内のメッセージ:
  (:report (lambda (condition stream)
     (format stream
             "You were going to divide ~a by zero.~&"
             (dividend condition)))))
~~~

すると:

~~~lisp
(error 'my-division-by-zero :dividend 3)
;; Debugger:
;;
;; You were going to divide 3 by zero.
;;    [Condition of type MY-DIVISION-BY-ZERO]
~~~


## stacktrace を調べる

これはもう 1 つの簡単なおさらいであり、Slime チュートリアルではありません。デバッガでは、stacktrace、関数呼び出しへの引数、エラーのあるソース行への移動（Slime では `v`）、そのコンテキストでのコード実行（`e`）などができます。

多くの場合、バグのある関数を編集し、（Slime の `C-c C-c` ショートカットで）コンパイルし、"RETRY" restart を選んで、コードが通ることを確認できます。

これはすべてコンパイラオプション、つまりデバッグ、速度、安全性のどれ向けに最適化されているかに依存します。

[デバッグセクション](debugging.html)を参照してください。


## Restarts、デバッガ内の対話的な選択肢

Restarts はデバッガ内で得られる選択肢です。デバッガには常に `RETRY` と `ABORT` があります。

restart を *handling* することで、エラーが起きなかったかのように（スタック上で見たように）操作をやり直せます。


### assert の任意 restart を使う

単純な形では、`assert` は私たちが知っているとおりに動きます。

~~~lisp
(assert (realp 3))
;; NIL = passed
~~~

アサーションが失敗すると、デバッガに入るよう促されます。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y)))
  (/ x y))

(divide 3 0)
;; The assertion (NOT #1=(ZEROP Y)) failed with #1# = T.
;;    [Condition of type SIMPLE-ERROR]
;;
;; Restarts:
;;  0: [CONTINUE] Retry assertion.
;;  1: [RETRY] Retry SLIME REPL evaluation request.
;;  …
~~~

値を変更する選択肢を提供する任意パラメータも受け取ります。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y))
          (y)   ;; 変更できる値のリスト。
          "Y can not be zero. Please change it") ;; カスタムエラーメッセージ。
  (/ x y))
~~~

これで、Y の値を変更する新しい restart が得られます。

~~~lisp
(divide 3 0)
;; Y can not be zero. Please change it
;;    [Condition of type SIMPLE-ERROR]
;;
;; Restarts:
;;  0: [CONTINUE] Retry assertion with new value for Y.  <--- new restart
;;  1: [RETRY] Retry SLIME REPL evaluation request.
;;  …
~~~

それを選ぶと、REPL で新しい値の入力を求められます。

```
The old value of Y is 0.
Do you want to supply a new value?  (y or n) y

Type a form to be evaluated:
2
3/2  ;; and our result.
```


### restarts を定義する（restart-case）

これは便利ですが、もっと独自の選択肢が欲しいこともあります。[restart-case][restart-case] で関数呼び出しを包むことで、一覧の先頭に restarts を追加できます。

~~~lisp
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()  ;; <-- "RETURN-ZERO" という新しい restart を作る
      0)
    (divide-by-one ()
      (/ x 1))))
(divide-with-restarts 3 0)
~~~

*任意のエラー*の場合（これは `handler-bind` で改善します）、デバッガの先頭にこの 2 つの新しい選択肢が表示されます。

![](simple-restarts.png)

これで問題ありませんが、より人間に分かりやすい "reports" を書きましょう。

~~~lisp
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()
      :report "Return 0"  ;; <-- 追加
      0)
    (divide-by-one ()
      :report "Divide by 1"
      (/ x 1))))
(divide-with-restarts 3 0)
;; Nicer restarts:
;;  0: [RETURN-ZERO] Return 0
;;  1: [DIVIDE-BY-ONE] Divide by 1
~~~

こちらの方がよいですが、上の `assert` の例で行ったように operand を変更する機能がありません。


### restart で変数を変更する

定義した 2 つの restarts は、新しい値を求めませんでした。これを行うには、restart に `:interactive` lambda 関数を追加し、ユーザーに新しい値を入力方法で尋ねます。ここでは通常の `read` を使います。

~~~lisp
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()
      :report "Return 0"
      0)
    (divide-by-one ()
      :report "Divide by 1"
      (/ x 1))
    (set-new-divisor (value)
      :report "Enter a new divisor"
      ;;
      ;; ユーザーに新しい値を尋ねる:
      :interactive (lambda () (prompt-new-value "Please enter a new divisor: "))
      ;;
      ;; 新しい値で divide 関数を呼ぶ…
      ;; …おそらく不正入力を再び handle しながら！
      (divide-with-restarts x value))))

(defun prompt-new-value (prompt)
  (format *query-io* prompt) ;; *query-io*: ユーザー問い合わせ用の特別なストリーム。
  (force-output *query-io*)  ;; ユーザーが入力内容を見られるようにする。
  (list (read *query-io*)))  ;; リストを返さなければならない。

(divide-with-restarts 3 0)
~~~

呼び出すと新しい restart が提示され、新しい値を入力し、結果を得ます。

~~~
(divide-with-restarts 3 0)
;; Debugger:
;;
;; 2: [SET-NEW-DIVISOR] Enter a new divisor
;;
;; Please enter a new divisor: 10
;;
;; 3/10
~~~

グラフィカルユーザーインターフェイスの方がよいですか？ GNU/Linux では `zenity` コマンドラインインターフェイスを使えます。

~~~lisp
(defun prompt-new-value (prompt)
  (list
   (let ((input
          ;; プログラムの出力を文字列へ捕捉する。
          (with-output-to-string (s)
            (let* ((*standard-output* s))
              (uiop:run-program `("zenity"
                                  "--forms"
                                  ,(format nil "--add-entry=~a" prompt))
                                :output s)))))
     ;; 文字列を得たので、数値が欲しい。
     ;; parse-integer や parse-number ライブラリなども使える。
     (read-from-string input))))
~~~

もう一度試すと、新しい数値を尋ねる小さなウィンドウが出るはずです。

![](assets/zenity-prompt.png)

これは楽しいですが、それだけではありません。restarts を手動で選ぶことは、常に（あるいは頻繁に）満足できるものではありません。そして restart を *handling* することで、エラーが起きなかったかのように、スタック上で見た操作をやり直せます。


### restarts をプログラムから呼び出す（handler-bind, invoke-restart）

condition を signal し得るコードがあるとします。ここでは `divide-with-restarts` がゼロ除算に関するエラーを signal する可能性があります。やりたいのは、上位レベルのコードがそれを自動的に handle し、適切な restart を呼ぶことです。

これは `handler-bind` と [invoke-restart][invoke-restart] でできます。

~~~lisp
(defun divide-and-handle-error (x y)
  (handler-bind
      ((division-by-zero (lambda (c)
                           (format t "Got error: ~a~%" c) ;; エラーメッセージ
                           (format t "and will divide by 1~&")
                           (invoke-restart 'divide-by-one))))
    (divide-with-restarts x y)))

(divide-and-handle-error 3 0)
;; Got error: arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;; and will divide by 1
;; 3
~~~


### ほかの restarts を使う（find-restart）

[find-restart][find-restart] を使います。

`find-restart 'name-of-restart` は、指定された名前で最も新しく束縛された restart、または `nil` を返します。


### restarts を隠す、表示する

Restarts は隠せます。`restart-case` では、`:report` と `:interactive` に加えて、`:test` キーも受け取ります。

~~~lisp
(restart-case
   (return-zero ()
     :test (lambda ()
             (some-test))
    ...
~~~

## デバッガを手動で起動する

`handler-bind` で condition を handle しており、condition オブジェクトが（上の例のように）`c` 変数に束縛されているとします。さらに、たとえば `*devel-mode*` というパラメータが、本番環境ではないことを示しているとします。この condition に対してデバッガを起動すると便利かもしれません。次を使います。

~~~lisp
(invoke-debugger c)
~~~

本番環境では、代わりに `trivial-backtrace:print-backtrace` でバックトレースを出力できます。


## デバッガを無効にする

本番環境では、デバッガをオフにして lisp プログラムを実行できます。各処理系にはコマンドラインスイッチがあります。SBCL では次のとおりです。

    $ sbcl --disable-debugger

（これは `--script` と `--non-interactive` では暗黙に指定されます）。



## まとめ

これで、本番コードを書く準備ができました！


## 資料

* [Practical Common Lisp: "Beyond Exception Handling: Conditions and Restarts"](http://gigamonkeys.com/book/beyond-exception-handling-conditions-and-restarts.html) - 定番チュートリアル。より多くの説明とプリミティブ。
* Common Lisp Recipes、第 12 章、E. Weitz
* [language reference](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node317.html)
* [Video tutorial: introduction on conditions and restarts](http://nklein.com/2011/03/tutorial-introduction-to-conditions-and-restarts/)、Patrick Stein による。
* [Condition Handling in the Lisp family of languages](http://www.nhplace.com/kent/Papers/Condition-Handling-2001.html)
* [z0ltan.wordpress.com](https://z0ltan.wordpress.com/2016/08/06/conditions-and-restarts-in-common-lisp/)（このレシピが大きく基づいている記事）

## 関連項目

* [Algebraic effects - You can touch this !](http://jacek.zlydach.pl/blog/2019-07-24-algebraic-effects-you-can-touch-this.html) - conditions と restarts を使って、長時間実行される計算の進捗報告と中止を実装する方法。対話的または GUI の文脈でも利用可能。
* [A tutorial on conditions and restarts](https://github.com/stylewarning/lisp-random/blob/master/talks/4may19/root.lisp) - 実関数の根の計算を題材にしたもの。著者により 2019 年 5 月の Bay Area Julia meetup で発表されました（[talk slides here](https://github.com/stylewarning/talks/blob/master/4may19-julia-meetup/Bay%20Area%20Julia%20Users%20Meetup%20-%204%20May%202019.pdf)）。
* [lisper.in](https://lisper.in/restarts#signaling-validation-errors) - csv ファイルの parsing と restarts の成功例。[旅行会社での事例](https://www.reddit.com/r/lisp/comments/7k85sf/a_tutorial_on_conditions_and_restarts/drceozm/)。
* [https://github.com/svetlyak40wt/python-cl-conditions](https://github.com/svetlyak40wt/python-cl-conditions) - Python における CL condition system の実装。
* [https://github.com/phoe/portable-condition-system](https://github.com/phoe/portable-condition-system) - Common Lisp における CL condition system の portable 実装。

## 謝辞

* `handler-bind` 部分について、[`@vindarel` の Udemy 動画講座](https://www.udemy.com/course/common-lisp-programming/?referralCode=2F3D698BBC4326F94358)。


[ignore-errors]: http://www.lispworks.com/documentation/HyperSpec/Body/m_ignore.htm
[handler-case]: http://www.lispworks.com/documentation/HyperSpec/Body/m_hand_1.htm
[handler-bind]: http://www.lispworks.com/documentation/HyperSpec/Body/m_handle.htm
[define-condition]: http://www.lispworks.com/documentation/HyperSpec/Body/m_defi_5.htm
[make-condition]: http://www.lispworks.com/documentation/HyperSpec/Body/f_mk_cnd.htm
[error]: http://www.lispworks.com/documentation/HyperSpec/Body/e_error.htm#error
[simple-error]: http://www.lispworks.com/documentation/HyperSpec/Body/e_smp_er.htm
[simple-warning]: http://www.lispworks.com/documentation/HyperSpec/Body/e_smp_wa.htm
[signal]: http://www.lispworks.com/documentation/HyperSpec/Body/f_signal.htm
[restart-case]: http://www.lispworks.com/documentation/HyperSpec/Body/m_rst_ca.htm
[invoke-restart]: http://www.lispworks.com/documentation/HyperSpec/Body/f_invo_1.htm#invoke-restart
[find-restart]: http://www.lispworks.com/documentation/HyperSpec/Body/f_find_r.htm#find-restart
[unwind-protect]: http://www.lispworks.com/documentation/HyperSpec/Body/s_unwind.htm
