---
title: ストリーム
---

ストリームは、Common Lisp における入出力の標準的な抽象化です。ファイルから読み込むとき、端末へ書き込むとき、ネットワークソケットで通信するとき、あなたはストリームを使っています。

多くの組み込み関数は stream 引数を持ちます。省略可能な場合もあります。

```lisp
(print object &optional stream)

(format stream control-string &rest format-arguments)

(defmethod print-object (object stream) &body body)

(with-open-file (stream filespec …) &body body)
```

この章では、stream の種類、作成と利用の方法、そして stream protocol の拡張方法を扱います。

## そもそも stream とは何か

stream は、ある方向（または複数の方向）から別の方向（または複数の方向）へ流れるデータを表します。小さく明確に区切られたデータ量も、場合によっては無限のデータ量も表せます。

英語では、"stream" は小川、途切れない流れ、そして音声や動画の broadcast を表すことがあります。

stream を扱うとき、私たちは stream 全体を捕まえて _その後で_ 作業するのではなく、目の前を通り過ぎるデータを見ます。川を通る boat を数えるとき、川全体を bucket に集めてから捕まえた boat の数を数えるわけではありません。小さな CSV ファイルを読むときは、ファイル全体を一度に読み込んでから parse できますが、とても大きいファイルを扱う場合は streaming API が必要になり、作業を論理的な chunk に分けることになります。


## stream の基本

stream は、文字または byte の source や sink を表す object です。標準はいくつかの stream type を定義しています。

- **Input streams** は読み取りをサポートします（`read-char` と `unread-char`、`read-byte`、`read-line`、`read`）。
- **Output streams** は書き込みをサポートします（`write-char`、`write-byte`、`write-string`、`format`）。
- **Bidirectional streams** はその両方をサポートします。

これとは別に、stream は element type を持ちます。

- **Character streams** は文字を運びます。`read-char`、`read-line`、`format`、およびこの章のほとんどの例がデフォルトで使うものです。
- **Binary streams** は byte を運び、通常は `(unsigned-byte 8)` のような element type で宣言されます。

stream が何をサポートしているかはテストできます。

~~~lisp
(input-stream-p *standard-input*)   ;; => T
(output-stream-p *standard-output*) ;; => T
(stream-element-type *standard-input*)
;; => CHARACTER
~~~

## 標準 stream 変数

Common Lisp は、デフォルトで bound されているいくつかの global stream variables を提供します。

| 変数 | 目的 |
|---|---|
| `*standard-input*` | デフォルト入力（端末または REPL） |
| `*standard-output*` | デフォルト出力（端末または REPL） |
| `*error-output*` | error/warning メッセージ |
| `*trace-output*` | `trace` からの出力 |
| `*debug-io*` | 対話的な debugging I/O |
| `*query-io*` | ユーザーへの yes/no 質問 |
| `*terminal-io*` | 実際の terminal stream |

`read`、`print`、`format` のような関数は、stream を指定しない場合、デフォルトでこれらを使います。

~~~lisp
;; これらは等価です。
(print "hello")
(print "hello" *standard-output*) ;; または (print "hello" t)

(format *standard-output* "hello") ;; または (format t "hello")
~~~

出力を redirect するために、これらを rebind できます。

### プログラム出力の捕捉または redirect

たとえば、通常は standard output に print する関数の出力を、文字列として捕捉したいでしょうか。

一般には、この形の `let` binding を使えます。

~~~lisp
(let ((*standard-output* some-other-stream))
  (print "hello"))  ;; または別の関数呼び出し。
  ;; some-other-stream に print されます
~~~

この（少し込み入った）例では、string stream を作成し、`*standard-output*` をそれに bind します。

```lisp
(with-output-to-string (s)
 (let ((*standard-output* s))
   ;; ここにいくつかの関数呼び出し…
   (princ "hello")
   (princ " ")
   (princ "streams")))
;; => "hello streams"
```

`princ` を使って object の「aesthetic」な表現を print しています。`print` なら quote と newline も print します。

ちなみに、この例は次のように短くできます。

```lisp
(with-output-to-string (*standard-output*)
  (princ "hello")
  (princ " ")
  (princ "streams"))
```

## file stream

file stream を作成するには `open` を使うか、stream が確実に閉じられる `with-open-file` macro を使います。

~~~lisp
;; ファイルを 1 行ずつ処理する:
(with-open-file (my-file-stream "test.txt")
  ;;            ^^^ macro body でこの symbol を bind します。
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

`:direction` keyword は stream type を制御します。

- `:input`（デフォルト）- 読み取り専用
- `:output` - 書き込み専用
- `:io` - 読み取りと書き込み
- `:probe` - ファイルが存在するか確認して閉じるだけ

binary file の場合は `:element-type` を指定します。

~~~lisp
(with-open-file (stream "/tmp/data.bin"
                 :direction :output
                 :if-exists :supersede
                 :element-type '(unsigned-byte 8))
  (write-byte 72 stream)
  (write-byte 101 stream))
~~~

## string stream

string stream を使うと、文字列を stream として扱えます。これは、ファイルを使わずに出力を構築したり入力を parse したりするときに便利です。

### 文字列への書き込み: `with-output-to-string`

この macro は、symbol を stream に bind し、macro body 内でその stream に print する関数を呼び出し、最後に文字列を作成できるようにします。

~~~lisp
(with-output-to-string (s)
  ;; より賢い処理…
  (format s "Hello, ")
  (format s "world!"))
;; => "Hello, world!"
~~~

`format`、`write-string`、その他の stream operation を使えます。

これは、destination に `nil` を指定した `format` を使うことの、より柔軟な同等物と見なせます。

~~~lisp
(format nil "Hello, world!")
;; => "Hello, world!"
~~~

### 文字列からの読み取り: `with-input-from-string`

文字列からの読み取りは、小さな parser、REPL helper、または filesystem に触れずに入力を使いたい test に便利です。

この例では、`read` が stream から token を parse するため、`with-input-from-string` で input stream を emulate する必要があります。

~~~lisp
;; 1 つの form を parse するには read-from-string も参照。
(with-input-from-string (s "123 456")
  (list (read s) (read s)))
;; => (123 456)
~~~

さらに option が必要なら次を参照してください。

- Community Spec の [`with-input-from-string`](https://cl-community-spec.github.io/pages/with_002dinput_002dfrom_002dstring.html) を読む


### `make-string-input-stream` と `make-string-output-stream`

macro form が不便な場合は、string stream を直接作成できます。これは、ある場所で stream を作成し、後で消費する必要がある場合によく使われます。

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

`make-concatenated-stream` は、複数の input streams から順番に読み取る stream を作成します。最初の stream が尽きると、次の stream から読み取りが続きます。複数の入力を既存の stream-consuming code に対して 1 つの連続した source のように見せたいときに便利です。

~~~lisp
(let* ((s1 (make-string-input-stream "Hello, "))
       (s2 (make-string-input-stream "world!"))
       (combined (make-concatenated-stream s1 s2)))
  (read-line combined))
;; => "Hello, world!"
~~~

## broadcast stream

`make-broadcast-stream` は、複数の stream に同時に output を送る stream を作成します。

~~~lisp
(with-output-to-string (s)
  (let ((broadcast (make-broadcast-stream *standard-output* s)))
     (format broadcast "to both")))
;; terminal に "to both" を print します
;; => そして "to both" string を返します。
~~~

または次のようにも書けます。

~~~lisp
(let* ((s (make-string-output-stream))
       (broadcast (make-broadcast-stream *standard-output* s)))
  (format broadcast "to both")
  (get-output-stream-string str))
~~~

これは console と file の両方に同時に logging する場合に便利です。

### output を捨てる（/dev/null へ書き込む）

引数なしで `make-broadcast-stream` を呼ぶことは、`/dev/null` へ書き込むことの portable な同等物でもあります。その stream に送られた output は捨てられます。

~~~lisp
(let ((sink (make-broadcast-stream)))
  (format sink "this goes nowhere"))
~~~

## 例: 1 つの report、複数の destination

実際の program でよくある pattern は、output を terminal、file、in-memory string のどれへ送るかを関数自身で決めるのではなく、stream を受け取る関数を書くことです。そうすると formatting code を 1 か所に保て、再利用しやすくなります。

下では、stream 引数は optional argument（`&key` argument でも構いません）で、デフォルトは standard output です。

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

同じ関数を、今度は異なる destination に向けられます。

~~~lisp
(let ((expenses '(("Books" 12.50)
                  ("Train" 24.10)
                  ("Lunch" 18.00))))
  ;; 1. REPL / terminal に print する（デフォルト）
  (write-expense-report expenses)

  ;; 2. file に保存する
  (with-open-file (out "/tmp/expenses.txt"
                       :direction :output
                       :if-exists :supersede)
    (write-expense-report expenses out))

  ;; 3. test や email body 用に string として捕捉する
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

### 2 つの stream に同時に書き込む

tee 風の output、つまり Unix の `tee` command のように同じ output を 2 つの stream に同時に書き込みたい場合も、broadcast stream で destination を組み合わせられます。

~~~lisp
(let* ((expenses '(("Books" 12.50)
                   ("Train" 24.10)))
       (copy (make-string-output-stream))
       (tee (make-broadcast-stream *standard-output* copy)))
  (write-expense-report expenses tee)
  (get-output-stream-string copy))
~~~

## two-way stream と echo stream

**two-way stream** は、input stream と output stream を 1 つの bidirectional stream に束ねます。

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

**echo stream** は two-way stream の一種で、input stream から読み取ったすべてを output stream に echo します。これは interactive session の logging や recording に便利です。

~~~lisp
(let* ((in (make-string-input-stream "hello"))
       (out (make-string-output-stream))
       (echo (make-echo-stream in out)))
  (read-char echo)  ;; #\h を読み取り、out にも書き込む
  (read-char echo)  ;; #\e を読み取り、out にも書き込む
  (get-output-stream-string out))
;; => "he"
~~~

## synonym stream

synonym stream は indirection です。すべての operation を、ある symbol の現在値である stream に転送します。`*terminal-io*` は通常 synonym stream です。

~~~lisp
(let* ((a-stream (make-string-input-stream "123"))
       (b-stream (make-string-input-stream "456"))
       (my-synonym (make-synonym-stream 'c-stream)))

  ;; synonym stream symbol を A に設定:
  (setf c-stream a-stream)
  (format t "reading stream A: ~a~&" (read my-synonym))

  ;; streams を B に切り替える:
  (setf c-stream b-stream)
  (format t "and now reading stream B: ~a~&" (read my-synonym)))
~~~

これにより、stream object 自体を変更せずに、symbol の rebinding によって stream の行き先を redirect できます。

## 落とし穴: stream は buffer されることがある、`finish-output`

一部の stream は buffered されることがあり、buffered output はすぐに現れない可能性があることに注意してください。`finish-output` を使います。

起こり得ることは、buffer が短時間データを保持してから stream に渡すということです。この仕組みは一般に、負荷がある状況で、入力 source が stream の処理能力より速くデータを供給する場合に便利です。

したがって、次の snippet は通常 portable ではなく、処理系や context（忙しい terminal で実行している等）に依存して変わる可能性があります。

~~~lisp
(write "enter an expression > ")
(read)
~~~

論理的には、prompt string を読んでから expression を入力すると期待します。

しかし、terminal に text が表示される前に blocking `(read)` に入ってしまうことがあります。

すべての stream output が時間どおりに書き込まれるようにするには、`finish-output` を使います。

~~~lisp
(write "enter an expression > ")
(finish-output)
(read)
~~~

`uiop` は `uiop:format!` も定義しており、これは stream に print する前後で `finish-output` を呼び出します。

[force-output and clear-output](https://cl-community-spec.github.io/pages/finish_002doutput.html) も参照してください（buffer を空にし始めますが待機はせず、output operation の abort を試みます）。

## さらに多くの stream 関数と macro

それらすべては [streams dictionary on the CLCS](https://cl-community-spec.github.io/pages/Streams-Dictionary.html) で参照できます。

### `listen`

[listen](https://cl-community-spec.github.io/pages/listen.html):

> input-stream から直ちに利用可能な文字がある場合 true を返し、それ以外の場合 false を返します。non-interactive input-stream では、end of file_1 の場合を除き listen は true を返します。end of file に遭遇した場合、listen は false を返します。listen は、input-stream が keyboard のような interactive device から文字を取得する場合に使うことを意図しています。


### `terpri, fresh-line`

[terpri](https://cl-community-spec.github.io/pages/terpri.html)
は常に output stream に newline を書き込みます。

`fresh-line` は、stream が newline の先頭にない場合にのみ newline を書き込みます。


### `y-or-n-p`, `yes-or-no-p`

[これらの関数](https://cl-community-spec.github.io/pages/y_002dor_002dn_002dp.html) は prompt を `*query-io*` に print し、ユーザー入力（1 文字の "y" または "n"、あるいは完全な "yes" または "no"）を待ち、boolean value を返します。


### `with-open-stream`

[with-open-stream](https://cl-community-spec.github.io/pages/with_002dopen_002dstream.html)
は「stream に対して一連の operation を実行し、値を返し、その後 stream を閉じます」。

この macro は、stream の context で expression を実行し、その後確実に閉じるために使えます。

Lem editor からの例です。`make-buffer-output-stream` は editor buffer を作成し、その stream を開いたままにする primitive です。`with-open-stream` を使って content を書き込みます。

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

標準の stream type は Common Lisp runtime によって実装されています。それらを使うことで file、string、socket、terminal stream を _利用_ できますが、通常の Common Lisp I/O operation に参加する新しい stream class をどう定義するかは標準化されていません。custom stream behavior（たとえば、データを圧縮する stream、byte を数える stream、文字を変換する stream、file descriptor ではなく application object から読む stream）が必要なら、**Gray streams** を使えます。

Gray streams は de facto standard です。ANSI Common Lisp が final になる前に提案され、CLtL の stream 章に基づいています。ANSI 標準には入りませんでしたが、人気のあるほとんどの処理系はこの protocol をサポートしています。実際には、`read-char`、`write-char`、`read-sequence`、`write-sequence` のような標準関数で動く custom streams を定義する通常の方法が Gray streams です。

[`trivial-gray-streams`](https://github.com/trivial-gray-streams/trivial-gray-streams)
library は portable interface を提供します。

これを使うには、下の `fundamental-character-output-stream` のような fundamental gray stream を subclass し、新しい stream class に必要な methods を定義します。下の character output stream では、`stream-write-char` と `stream-line-column` という 2 つの methods を定義しなければなりません。


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

この library は次の classes を定義します。

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

実装すべき key methods は stream type に依存します。どの methods が必須で、どれが省略可能かに注意してください。

**character input streams** について:

- `stream-read-char` - 1 文字を読む。
  - stream が end-of-file の場合、symbol `:eof` を返します。
- `stream-unread-char` - 文字を押し戻す。
- `stream-read-char-no-hang`（optional）- blocking しない character read
- `stream-read-line`（optional、performance のため）
- `stream-read-sequence`（optional、performance のため）

`` のすべての subclass は、最初の 2 つの関数の method を定義しなければなりません。

**character output streams** について:

- `stream-write-char` - 1 文字を書き込む
- `stream-line-column` - 次の文字が書き込まれる column number を返す。この stream で意味がない場合は NIL を返す。
- `stream-write-string`（optional、performance のため）
- `stream-write-sequence`（optional、performance のため）

**binary streams** について:

- `stream-read-byte`
- `stream-write-byte`
- `stream-read-sequence` / `stream-write-sequence`

sequence methods により、stream はデータの whole slices を一度に移動できます。これは 1 文字または 1 byte ずつ読み書きするより、しばしばはるかに高速です。

## 参考

- [CLHS: Streams](http://www.lispworks.com/documentation/HyperSpec/Body/21_.htm)
- [CLtL2: Streams](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node329.html)
- [trivial-gray-streams](https://github.com/trivial-gray-streams/trivial-gray-streams)
- [flexi-streams](https://edicl.github.io/flexi-streams/) - FLEXI-STREAMS は「real binary または bivalent streams の上に layer でき、各種 single-octet または multi-octet encoding で character data を読み書きでき、その encoding を on the fly で変更できる "virtual" bivalent streams」を実装します。また、string streams に似た in-memory binary streams も提供します。
- [nontrivial-gray-streams](https://github.com/yitzchak/nontrivial-gray-streams) - Gray stream protocol の拡張（Sequence Extensions、File Position Extensions…）。trivial-gray-streams とは異なり、fundamental stream classes の独自 subclass を導入しません。代わりに、CL implementation の fundamental stream classes を直接 export します。
- [SBCL's bivalent streams](https://www.sbcl.org/manual/#Bivalent-Streams) - 「bivalent stream は `character` と `(unsigned-byte 8)` value の両方を読み書きするために使えます。bivalent stream は、引数 :element-type :default で open を呼び出すことで作成されます。そのような stream では、通常の input/output functions で binary data と character data の両方を読み書きできます。」
- [Allegro CL's simple-streams](https://franz.com/support/documentation/10.1/doc/streams.htm) - [SBCL の subset](https://www.sbcl.org/manual/#Simple-Streams) もあります。
