---
title: ストリーム
---

ストリームは、Common Lisp における入出力の標準的な抽象化です。ファイルから読み込むとき、端末へ書き込むとき、ネットワークソケットで通信するとき、あなたはストリームを使っています。

多くの組み込み関数はストリーム引数を持ちます。省略可能な場合もあります。

```lisp
(print object &optional stream)

(format stream control-string &rest format-arguments)

(defmethod print-object (object stream) &body body)

(with-open-file (stream filespec …) &body body)
```

この章では、ストリームの種類、作成と利用の方法、そしてストリームプロトコルの拡張方法を扱います。

<a id="stream-"></a>

## そもそもストリームとは何か

ストリームは、ある方向（または複数の方向）から別の方向（または複数の方向）へ流れるデータを表します。小さく明確に区切られたデータ量も、場合によっては無限のデータ量も表せます。

英語では、"stream" は小川、途切れない流れ、そして音声や動画の配信を表すことがあります。

ストリームを扱うとき、私たちはストリーム全体を捕まえて _その後で_ 作業するのではなく、目の前を通り過ぎるデータを見ます。川を通る船を数えるとき、川全体をバケツに集めてから捕まえた船の数を数えるわけではありません。小さな CSV ファイルを読むときは、ファイル全体を一度に読み込んでから解析できますが、とても大きいファイルを扱う場合は streaming API が必要になり、作業を論理的なまとまりに分けることになります。


<a id="stream--1"></a>

## ストリームの基本

ストリームは、文字またはバイトの入力元や出力先を表すオブジェクトです。標準はいくつかのストリームの種類を定義しています。

- **Input streams** は読み取りをサポートします（`read-char` と `unread-char`、`read-byte`、`read-line`、`read`）。
- **Output streams** は書き込みをサポートします（`write-char`、`write-byte`、`write-string`、`format`）。
- **Bidirectional streams** はその両方をサポートします。

これとは別に、ストリームは要素型を持ちます。

- **文字ストリーム**は文字を運びます。`read-char`、`read-line`、`format`、およびこの章のほとんどの例がデフォルトで使うものです。
- **バイナリストリーム**はバイトを運び、通常は `(unsigned-byte 8)` のような要素型で宣言されます。

ストリームが何をサポートしているかはテストできます。

~~~lisp
(input-stream-p *standard-input*)   ;; => T
(output-stream-p *standard-output*) ;; => T
(stream-element-type *standard-input*)
;; => CHARACTER
~~~

<a id="stream--2"></a>

## 標準ストリーム変数

Common Lisp は、デフォルトで束縛されているいくつかのグローバルなストリーム変数を提供します。

| 変数 | 目的 |
|---|---|
| `*standard-input*` | デフォルト入力（端末または REPL） |
| `*standard-output*` | デフォルト出力（端末または REPL） |
| `*error-output*` | エラー／警告メッセージ |
| `*trace-output*` | `trace` からの出力 |
| `*debug-io*` | 対話的なデバッグ用 I/O |
| `*query-io*` | ユーザーへの yes/no 質問 |
| `*terminal-io*` | 実際の端末ストリーム |

`read`、`print`、`format` のような関数は、ストリームを指定しない場合、デフォルトでこれらを使います。

~~~lisp
;; これらは等価です。
(print "hello")
(print "hello" *standard-output*) ;; または (print "hello" t)

(format *standard-output* "hello") ;; または (format t "hello")
~~~

出力をリダイレクトするために、これらを再束縛できます。

### プログラム出力の捕捉またはリダイレクト

たとえば、通常は標準出力に出力する関数の出力を、文字列として捕捉したいでしょうか。

一般には、この形の `let` による束縛を使えます。

~~~lisp
(let ((*standard-output* some-other-stream))
  (print "hello"))  ;; または別の関数呼び出し。
  ;; some-other-stream に print されます
~~~

この（少し込み入った）例では、文字列ストリームを作成し、`*standard-output*` をそれに束縛します。

```lisp
(with-output-to-string (s)
 (let ((*standard-output* s))
   ;; ここにいくつかの関数呼び出し…
   (princ "hello")
   (princ " ")
   (princ "streams")))
;; => "hello streams"
```

`princ` を使ってオブジェクトの「見やすい」表現を出力しています。`print` ならクォートと改行も出力します。

ちなみに、この例は次のように短くできます。

```lisp
(with-output-to-string (*standard-output*)
  (princ "hello")
  (princ " ")
  (princ "streams"))
```

## ファイルストリーム

ファイルストリームを作成するには `open` を使うか、ストリームが確実に閉じられる `with-open-file` マクロを使います。

~~~lisp
;; ファイルを 1 行ずつ処理する:
(with-open-file (my-file-stream "test.txt")
  ;;            ^^^ マクロ本体でこのシンボルを束縛します。
  (loop for line = (read-line my-file-stream nil)
        while line
        when (search "cat" line)
          do (format t "this line is about cats: ~s~&" line)))
~~~

~~~lisp
;; ファイルに書き込む:
(with-open-file (stream "/tmp/out.txt"
                 :direction :output
                 :if-exists :supersede)
  (format stream "Hello, streams!~%"))
~~~

`:direction` キーワードはストリームの種類を制御します。

- `:input`（デフォルト）- 読み取り専用
- `:output` - 書き込み専用
- `:io` - 読み取りと書き込み
- `:probe` - ファイルが存在するか確認して閉じるだけ

バイナリファイルの場合は `:element-type` を指定します。

~~~lisp
(with-open-file (stream "/tmp/data.bin"
                 :direction :output
                 :if-exists :supersede
                 :element-type '(unsigned-byte 8))
  (write-byte 72 stream)
  (write-byte 101 stream))
~~~

## 文字列ストリーム

文字列ストリームを使うと、文字列をストリームとして扱えます。これは、ファイルを使わずに出力を構築したり入力を解析したりするときに便利です。

### 文字列への書き込み: `with-output-to-string`

このマクロは、シンボルをストリームに束縛し、マクロ本体内でそのストリームに出力する関数を呼び出し、最後に文字列を作成できるようにします。

~~~lisp
(with-output-to-string (s)
  ;; より賢い処理…
  (format s "Hello, ")
  (format s "world!"))
;; => "Hello, world!"
~~~

`format`、`write-string`、その他のストリーム操作を使えます。

これは、出力先に `nil` を指定した `format` を使うことの、より柔軟な同等物と見なせます。

~~~lisp
(format nil "Hello, world!")
;; => "Hello, world!"
~~~

### 文字列からの読み取り: `with-input-from-string`

文字列からの読み取りは、小さなパーサー、REPL の補助、またはファイルシステムに触れずに入力を使いたいテストに便利です。

この例では、`read` がストリームからトークンを解析するため、`with-input-from-string` で入力ストリームを模倣する必要があります。

~~~lisp
;; 1 つの form を parse するには read-from-string も参照。
(with-input-from-string (s "123 456")
  (list (read s) (read s)))
;; => (123 456)
~~~

さらにオプションが必要なら次を参照してください。

- Community Spec の [`with-input-from-string`](https://cl-community-spec.github.io/pages/with_002dinput_002dfrom_002dstring.html) を読む


### `make-string-input-stream` と `make-string-output-stream`

マクロ form が不便な場合は、文字列ストリームを直接作成できます。これは、ある場所でストリームを作成し、後で消費する必要がある場合によく使われます。

~~~lisp
(let ((s (make-string-output-stream)))
  (format s "one ")
  (format s "two ")
  (format s "three")
  (get-output-stream-string s))
;; => "one two three"
~~~

~~~lisp
(let ((s (make-string-input-stream "hello")))
  (read-char s))
;; => #\h
~~~

## concatenated stream

`make-concatenated-stream` は、複数の input ストリームから順番に読み取るストリームを作成します。最初のストリームが尽きると、次のストリームから読み取りが続きます。複数の入力を既存の stream-consuming code に対して 1 つの連続した source のように見せたいときに便利です。

~~~lisp
(let* ((s1 (make-string-input-stream "Hello, "))
       (s2 (make-string-input-stream "world!"))
       (combined (make-concatenated-stream s1 s2)))
  (read-line combined))
;; => "Hello, world!"
~~~

## ブロードキャストストリーム

`make-broadcast-stream` は、複数のストリームに同時に出力を送るストリームを作成します。

~~~lisp
(with-output-to-string (s)
  (let ((broadcast (make-broadcast-stream *standard-output* s)))
     (format broadcast "to both")))
;; 端末に "to both" を出力します
;; => そして "to both" という文字列を返します。
~~~

または次のようにも書けます。

~~~lisp
(let* ((s (make-string-output-stream))
       (broadcast (make-broadcast-stream *standard-output* s)))
  (format broadcast "to both")
  (get-output-stream-string str))
~~~

これはコンソールとファイルの両方に同時にログを記録する場合に便利です。

### 出力を捨てる（/dev/null へ書き込む）

引数なしで `make-broadcast-stream` を呼ぶことは、`/dev/null` へ書き込むことの移植性のある同等物でもあります。そのストリームに送られた出力は捨てられます。

~~~lisp
(let ((sink (make-broadcast-stream)))
  (format sink "this goes nowhere"))
~~~

## 例: 1 つのレポート、複数の出力先

実際のプログラムでよくあるパターンは、出力を端末、ファイル、メモリ上の文字列のどれへ送るかを関数自身で決めるのではなく、ストリームを受け取る関数を書くことです。そうすると整形のコードを 1 か所に保て、再利用しやすくなります。

下では、ストリーム引数は省略可能な引数（`&key` 引数でも構いません）で、デフォルトは標準出力です。

~~~lisp
(defun write-expense-report (expenses &optional (stream t))
  "Write a small summary of our expenses."
  (format stream "Expense report~%")
  (format stream "==============~%")
  (dolist (entry expenses)
    (format stream "~a: ~,2f EUR~%" (first entry) (second entry)))
  (format stream "--------------~%")
  (format stream "Total: ~,2f EUR~%"
          (loop for entry in expenses
                sum (second entry))))
~~~

同じ関数を、今度は異なる出力先に向けられます。

~~~lisp
(let ((expenses '(("Books" 12.50)
                  ("Train" 24.10)
                  ("Lunch" 18.00))))
  ;; 1. REPL / 端末に出力する（デフォルト）
  (write-expense-report expenses)

  ;; 2. ファイルに保存する
  (with-open-file (out "/tmp/expenses.txt"
                       :direction :output
                       :if-exists :supersede)
    (write-expense-report expenses out))

  ;; 3. テストやメール本文用に文字列として捕捉する
  (with-output-to-string (out)
    (write-expense-report expenses out)))

;; => "Expense report
;; => ==============
;; => Books: 12.50 EUR
;; => Train: 24.10 EUR
;; => Lunch: 18.00 EUR
;; => --------------
;; => Total: 54.60 EUR
;; => "
~~~

<a id="stream--3"></a>

### 2 つのストリームに同時に書き込む

tee 風の出力、つまり Unix の `tee` コマンドのように同じ出力を 2 つのストリームに同時に書き込みたい場合も、ブロードキャストストリームで出力先を組み合わせられます。

~~~lisp
(let* ((expenses '(("Books" 12.50)
                   ("Train" 24.10)))
       (copy (make-string-output-stream))
       (tee (make-broadcast-stream *standard-output* copy)))
  (write-expense-report expenses tee)
  (get-output-stream-string copy))
~~~

<a id="two-way-stream--echo-stream"></a>

## 双方向ストリームとエコーストリーム

**双方向ストリーム** は、入力ストリームと出力ストリームを 1 つの双方向ストリームに束ねます。

~~~lisp
(let* ((in (make-string-input-stream "42"))
       (out (make-string-output-stream))
       (two-way (make-two-way-stream in out)))
  (format two-way "answer: ~a~%"
          (read two-way))
  (get-output-stream-string out))
;; => "answer: 42
;; "
~~~

**エコーストリーム** は双方向ストリームの一種で、入力ストリームから読み取ったすべてを出力ストリームにそのまま書き出します。これは対話セッションのログ記録や録画に便利です。

~~~lisp
(let* ((in (make-string-input-stream "hello"))
       (out (make-string-output-stream))
       (echo (make-echo-stream in out)))
  (read-char echo)  ;; #\h を読み取り、out にも書き込む
  (read-char echo)  ;; #\e を読み取り、out にも書き込む
  (get-output-stream-string out))
;; => "he"
~~~

## シノニムストリーム

シノニムストリームは間接参照として機能します。すべての操作を、あるシンボルの現在値であるストリームへ転送します。`*terminal-io*` は通常シノニムストリームです。

~~~lisp
(let* ((a-stream (make-string-input-stream "123"))
       (b-stream (make-string-input-stream "456"))
       (my-synonym (make-synonym-stream 'c-stream)))

  ;; シノニムストリームのシンボルを A に設定:
  (setf c-stream a-stream)
  (format t "reading stream A: ~a~&" (read my-synonym))

  ;; ストリームを B に切り替える:
  (setf c-stream b-stream)
  (format t "and now reading stream B: ~a~&" (read my-synonym)))
~~~

これにより、ストリームオブジェクト自体を変更せずに、シンボルの再束縛によってストリームの行き先をリダイレクトできます。

<a id="stream--buffer-finish-output"></a>

## 落とし穴: ストリームはバッファされることがある、`finish-output`

一部のストリームはバッファされることがあり、バッファされた出力はすぐに現れない可能性があることに注意してください。`finish-output` を使います。

起こり得ることは、バッファが短時間データを保持してからストリームに渡すということです。この仕組みは一般に、負荷がある状況で、入力元がストリームの処理能力より速くデータを供給する場合に便利です。

したがって、次のコードは通常移植性がなく、処理系や状況（忙しい端末で実行している等）に依存して変わる可能性があります。

~~~lisp
(write "enter an expression > ")
(read)
~~~

論理的には、プロンプト文字列を読んでから式を入力すると期待します。

しかし、端末にテキストが表示される前にブロッキングする `(read)` に入ってしまうことがあります。

すべてのストリーム output が時間どおりに書き込まれるようにするには、`finish-output` を使います。

~~~lisp
(write "enter an expression > ")
(finish-output)
(read)
~~~

`uiop` は `uiop:format!` も定義しており、これはストリームに出力する前後で `finish-output` を呼び出します。

[`force-output` と `clear-output`](https://cl-community-spec.github.io/pages/finish_002doutput.html) も参照してください（バッファの内容を出力し始めますが完了を待たず、出力操作の中止を試みます）。

<a id="stream--macro"></a>

## さらに多くのストリーム関数とマクロ

それらすべては [CLCS のストリーム辞書](https://cl-community-spec.github.io/pages/Streams-Dictionary.html) で参照できます。

### `listen`

[listen](https://cl-community-spec.github.io/pages/listen.html):

> input-stream から直ちに利用可能な文字がある場合 true を返し、それ以外の場合 false を返します。対話的でない input-stream では、ファイルの終端_1 の場合を除き listen は true を返します。ファイルの終端に遭遇した場合、listen は false を返します。listen は、input-stream がキーボードのような対話的なデバイスから文字を取得する場合に使うことを意図しています。


### `terpri, fresh-line`

[terpri](https://cl-community-spec.github.io/pages/terpri.html)
は常に出力ストリームに改行を書き込みます。

`fresh-line` は、ストリームが行頭にない場合にのみ改行を書き込みます。


### `y-or-n-p`, `yes-or-no-p`

[これらの関数](https://cl-community-spec.github.io/pages/y_002dor_002dn_002dp.html) は prompt を `*query-io*` に print し、ユーザー入力（1 文字の "y" または "n"、あるいは完全な "yes" または "no"）を待ち、boolean 値を返します。


### `with-open-stream`

[with-open-stream](https://cl-community-spec.github.io/pages/with_002dopen_002dstream.html)
は「ストリームに対して一連の操作を実行し、値を返した後、ストリームを閉じます」。

このマクロは、ストリームの context で式を実行し、その後確実に閉じるために使えます。

Lem editor からの例です。`make-buffer-output-stream` は editor buffer を作成し、そのストリームを開いたままにする primitive です。`with-open-stream` を使って content を書き込みます。

```lisp
(defun display-welcome ()
  (when *enable-welcome*
    ;; start buffer に welcome message を print する
    (with-open-stream (stream (make-buffer-output-stream (buffer-start-point (current-buffer))))
      (loop :with prefix := (/ (- (window-width (current-window)) *message-width*) 2)
            :for line :in (str:lines *message-content*)
            :do (format stream "~v@{~a~:*~}" prefix " ")
            :do (format stream "~a~%" line)))))
```


## Gray stream: protocol の拡張

標準のストリーム型は Common Lisp ランタイムによって実装されています。それらを使ってファイル、文字列、ソケット、端末のストリームを _利用_ できますが、通常の Common Lisp 入出力操作に対応する新しいストリームクラスの定義方法は標準化されていません。独自の動作を持つストリーム（たとえば、データを圧縮するストリーム、バイト数を数えるストリーム、文字を変換するストリーム、ファイル記述子ではなくアプリケーションオブジェクトから読み込むストリーム）が必要なら、**Gray ストリーム**を使えます。

Gray ストリームは de facto standard です。ANSI Common Lisp が final になる前に提案され、CLtL のストリーム章に基づいています。ANSI 標準には入りませんでしたが、人気のあるほとんどの処理系はこの protocol をサポートしています。実際には、`read-char`、`write-char`、`read-sequence`、`write-sequence` のような標準関数で動く custom ストリームを定義する通常の方法が Gray ストリームです。

[`trivial-gray-streams`](https://github.com/trivial-gray-streams/trivial-gray-streams)
ライブラリは portable インターフェイスを提供します。

これを使うには、下の `fundamental-character-output-stream` のような fundamental gray ストリームを subclass し、新しいストリームクラスに必要なメソッドを定義します。下の文字 output ストリームでは、`stream-write-char` と `stream-line-column` という 2 つのメソッドを定義しなければなりません。


~~~lisp
;; .asd 内:
;; :depends-on ("trivial-gray-streams")

(defclass counting-stream (trivial-gray-streams:fundamental-character-output-stream)
  ((inner :initarg :inner :reader inner-stream)
   (count :initform 0 :accessor char-count)))

(defmethod trivial-gray-streams:stream-write-char ((stream counting-stream) char)
  (incf (char-count stream))
  (write-char char (inner-stream stream)))

(defmethod trivial-gray-streams:stream-line-column ((stream counting-stream))
  nil)
~~~

そして次のように使います。

~~~lisp
(let* ((out (make-string-output-stream))
       (counting (make-instance 'counting-stream :inner out)))
  (write-string "hello" counting)
  (values (get-output-stream-string out)
          (char-count counting)))
;; => "hello"
;; => 5
~~~

### Gray stream: fundamental class

このライブラリは次のクラスを定義します。

```
trivial-gray-streams:fundamental-stream
trivial-gray-streams:fundamental-input-stream
trivial-gray-streams:fundamental-binary-stream
trivial-gray-streams:fundamental-output-stream
trivial-gray-streams:fundamental-character-stream
trivial-gray-streams:fundamental-binary-input-stream
trivial-gray-streams:fundamental-binary-output-stream
trivial-gray-streams:fundamental-character-input-stream
trivial-gray-streams:fundamental-character-output-stream
```

### Gray stream: method

実装すべき主要なメソッドはストリームの型に依存します。どのメソッドが必須で、どれが省略可能かに注意してください。

**character input streams** について:

- `stream-read-char` - 1 文字を読む。
  - ストリームが end-of-file の場合、シンボル `:eof` を返します。
- `stream-unread-char` - 文字を押し戻す。
- `stream-read-char-no-hang`（optional）- blocking しない文字 read
- `stream-read-line`（optional、performance のため）
- `stream-read-sequence`（optional、performance のため）

`` のすべての subclass は、最初の 2 つの関数のメソッドを定義しなければなりません。

**character output streams** について:

- `stream-write-char` - 1 文字を書き込む
- `stream-line-column` - 次の文字が書き込まれる column number を返す。このストリームで意味がない場合は NIL を返す。
- `stream-write-string`（optional、performance のため）
- `stream-write-sequence`（optional、performance のため）

**binary streams** について:

- `stream-read-byte`
- `stream-write-byte`
- `stream-read-sequence` / `stream-write-sequence`

シーケンス用メソッドにより、ストリームはデータのまとまった範囲を一度に移動できます。これは 1 文字または 1 バイトずつ読み書きするより、多くの場合はるかに高速です。

## 参考

- [CLHS: Streams](http://www.lispworks.com/documentation/HyperSpec/Body/21_.htm)
- [CLtL2: Streams](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node329.html)
- [trivial-gray-streams](https://github.com/trivial-gray-streams/trivial-gray-streams)
- [flexi-streams](https://edicl.github.io/flexi-streams/) - FLEXI-STREAMS は「実体のあるバイナリストリームまたは双方向型ストリームの上に重ねられ、各種の単一オクテットまたは複数オクテットの符号化方式で文字データを読み書きでき、その符号化方式を動的に変更できる仮想的な双方向型ストリーム」を実装します。また、文字列ストリームに似たメモリ上のバイナリストリームも提供します。
- [nontrivial-gray-streams](https://github.com/yitzchak/nontrivial-gray-streams) - Gray ストリーム protocol の拡張（Sequence Extensions、File Position Extensions…）。trivial-gray-streams とは異なり、fundamental ストリームクラスの独自 subclass を導入しません。代わりに、CL 処理系の fundamental ストリームクラスを直接 export します。
- [SBCL の双方向型ストリーム](https://www.sbcl.org/manual/#Bivalent-Streams) - 「双方向型ストリームは `character` と `(unsigned-byte 8)` の値をどちらも読み書きできます。引数 `:element-type :default` を指定して `open` を呼び出すことで作成します。このストリームでは、通常の入出力関数でバイナリデータと文字データの両方を読み書きできます。」
- [Allegro CL's simple-streams](https://franz.com/support/documentation/10.1/doc/streams.htm) - [SBCL の subset](https://www.sbcl.org/manual/#Simple-Streams) もあります。
