---
title: 入出力
---

入出力のための便利なパターンをいくつか見てみましょう。

## ユーザー入力を求める: `y-or-n-p`, `yes-or-no-p`, `read`, `read-line`

[`y-or-n-p` と `yes-or-no-p`](https://cl-community-spec.github.io/pages/y_002dor_002dn_002dp.html) 関数はプロンプトを表示し、処理を止めて "yes" または "no" の入力（短い形式または長い形式）を待ちます。

[`read`](https://cl-community-spec.github.io/pages/read.html) 関数は、他の引数なしで呼び出されると処理を止めて入力を待ちますが、Lisp のフォームを読み取ります。

~~~lisp
CL-USER> (read)
|               ;; <---- point waiting for input.
~~~

`(1+ 2)` と入力すると、次の結果が見えます。

```lisp
(1+ 2)
```

3 が表示されると思いましたか。

もう一度試してみましょう。

~~~lisp
(read)
hello  ;; our input
HELLO  ;; return value: a symbol, hence capitalized

(read)
(list a b c)   ;; our input
(LIST A B C)   ;; return value: some s-expression.
~~~

結果は評価されて*いません*。

`read` 関数はソースコードを読み取ります。文字列ではありません。これは S 式を返します。

文字列が欲しい場合は、引用符の中に書いてください（または次の節を参照してください）。

まだコードを評価してはいません。そのためには `eval` があります。

~~~lisp
(read)
(1+ 2)  ;; input
(1+ 2)  ;; return value

(eval *)
;; 3
~~~

これが、最も原始的な REPL、つまり Read-Eval-Print-Loop を作る方法です。

~~~lisp
CL-USER> (loop (print (eval (read))))
(1+ 1)  ;; input

2 (1+ 2)  ;; result + my next input

3
~~~

上の行は永遠にループし、抜け出す方法はありません。ただし `(quit)` は別で、これはトップレベルの REPL も終了します。次は、`q` シンボル（文字列ではありません）を見たら終了する、とても単純なループです。

~~~lisp
(loop for input = (read)
      while (not (equal input 'q))
      do (print (eval input)))
~~~


### 入力を文字列として読む: `read-line`

入力を*文字列*として読むには、[`read-line`](https://cl-community-spec.github.io/pages/read_002dline.html) を使います。

~~~lisp
CL-USER> (defparameter *input* (read-line))
This is a longer input.
*INPUT*

CL-USER> *input*
"This is a longer input."
~~~

これは複数行を読みません。


## プログラムの標準出力をリダイレクトする

次のようにします。

~~~lisp
(let ((*standard-output* <some form generating a stream>))
  ...)
~~~

[`*standard-output*`](http://www.lispworks.com/documentation/HyperSpec/Body/v_debug_.htm) はダイナミック変数なので、`LET` フォームの本体の実行中にそれを参照するすべての箇所は、あなたが束縛したストリームを参照します。`LET` フォームを抜けると、通常実行であれ、関数全体を抜ける `RETURN-FROM` であれ、例外であれ、その他何であれ、`*STANDARD-OUTPUT*` の古い値が復元されます。（ちなみに、Common Lisp でグローバル変数が他の言語ほど壊れたものにならないのはこのためです。特定のフォームの実行中だけ束縛でき、そのフォームが終わった後に以前の値を失う危険がないので、かなり安全に使えます。すべての関数に渡される追加のパラメータのように振る舞います。）

プログラムの出力をファイルへ送るべき場合は、次のようにできます。

~~~lisp
(with-open-file (*standard-output* "somefile.dat"
                                   :direction :output
                                   :if-exists :supersede)
  ...)
~~~

[`with-open-file`](http://www.lispworks.com/documentation/HyperSpec/Body/m_w_open.htm) はファイルを開き、必要なら作成し、`*standard-output*` を束縛し、本体を実行し、ファイルを閉じ、`*standard-output*` を以前の値へ復元します。これ以上快適にはなりません。<a name="faith"></a>

<a id="stream-"></a>

## 文字ストリームによる忠実な出力

ここでいう _忠実な出力_ とは、0 から 255 の間のコードを持つ文字がそのまま書き出されることを意味します。つまり、ストリームに対して `(princ (code-char 0..255) s)` でき、8 ビットのバイトが書き出されると期待できるということです。Unicode と 16 ビットまたは 32 ビットの文字表現の時代には、これは自明ではありません。これは、ä、ß、þ といった文字の [`char-code`](http://www.lispworks.com/documentation/HyperSpec/Body/f_char_c.htm) が 0..255 の範囲にあることを要求するものでは*ありません*。実装は任意のコードを使えます。しかし、とりわけ `#\Newline` から CRLF への変換が起きないことは要求します。

Common Lisp には、文字の I/O とバイト（バイナリ）の I/O を区別する長い伝統があります。たとえば [`read-byte`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_by.htm) と [`read-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_cha.htm) は標準に含まれています。一部の実装では両方の関数を交換可能に呼べます。他の実装では、どちらか一方だけが許可されます。[simple ストリームの提案](https://www.cliki.net/simple-stream) は、両方が可能な _bivalent stream_ の概念を定義しています。

さまざまな element-type が有用なのは、一部のプロトコルがチャネル上で 8 ビットの出力を送信できることに依存しているからです。たとえば HTTP では、ヘッダは通常 ASCII であり、行終端として CRLF を使うべきです。一方でボディは MIME タイプ application/octet-stream を持つことができ、その場合 CRLF 変換はデータを破壊します。（これは、誤って設定された web サーバーが未知のファイルを text/plain の MIME タイプとして宣言したとき、MS-Windows 上の Netscape ブラウザが送信データを壊す仕組みです。text/plain はほとんどの Apache 設定でデフォルトです）。

以下は、実装依存の選択肢と振る舞い、および実験用のコードの一覧です。

### SBCL

任意のバイトを文字列にロードするには、`:iso-8859-1` の external format を使います。例:

~~~lisp
(uiop:read-file-string "/path/to/file" :external-format :iso-8859-1)
~~~

### CLISP

CLISP では、次を使うことで忠実な出力が可能です。

~~~lisp
:external-format
(ext:make-encoding :charset 'charset:iso-8859-1
                   :line-terminator :unix)
~~~

`(SETF (STREAM-ELEMENT-TYPE F) '(UNSIGNED-BYTE 8))` も使えます。ここで `SETF` できることは CLISP 固有の拡張です。`:EXTERNAL-FORMAT :UNIX` を使うと移植性の問題が発生します。MS-Windows 上のデフォルト文字セットは `CHARSET:CP1252` だからです。`CHARSET:CP1252` は、たとえば `(CODE-CHAR #x81)` の出力を許しません。

~~~
;*** - Character #\u0080 cannot be represented in the character set CHARSET:CP1252
~~~

コードが 127 を超える文字は ASCII で表現できません。

~~~
;*** - Character #\u0080 cannot be represented in the character set CHARSET:ASCII
~~~

### AllegroCL

`#+(AND ALLEGRO UNIX) :DEFAULT`（未テスト）- UNIX では十分なようですが、AllegroCL の MS-Windows 版では動かないでしょう。

### LispWorks

`:EXTERNAL-FORMAT '(:LATIN-1 :EOL-STYLE :LF)`（Marc Battyani により確認済み）

### 例

試すためのサンプルコードを示します。

~~~lisp
(defvar *unicode-test-file* "faithtest-out.txt")

(defun generate-256 (&key (filename *unicode-test-file*)
			  #+CLISP (charset 'charset:iso-8859-1)
                          external-format)
  (let ((e (or external-format
	       #+CLISP (ext:make-encoding :charset charset
                           :line-terminator :unix))))
    (describe e)
    (with-open-file (f filename :direction :output
		     :external-format e)
      (write-sequence
        (loop with s = (make-string 256)
	      for i from 0 to 255
	      do (setf (char s i) (code-char i))
	      finally (return s))
       f)
      (file-position f))))

;(generate-256 :external-format :default)
;#+CLISP (generate-256 :external-format :unix)
;#+CLISP (generate-256 :external-format 'charset:ascii)
;(generate-256)

(defun check-256 (&optional (filename *unicode-test-file*))
  (with-open-file (f filename :direction :input
		     :element-type '(unsigned-byte 8))
    (loop for i from 0
	  for c = (read-byte f nil nil)
	  while c
	  unless (= c i)
	  do (format t "~&Position ~D found ~D(#x~X)." i c c)
	  when (and (= i 33) (= c 32))
	  do (let ((c (read-byte f)))
	       (format t "~&Resync back 1 byte ~D(#x~X) - cause CRLF?." c c) ))
    (file-length f)))

#| CLISP
(check-256 *unicode-test-file*)
(progn (generate-256 :external-format :unix) (check-256))
; uses UTF-8 -> 385 bytes

(progn (generate-256 :charset 'charset:iso-8859-1) (check-256))

(progn (generate-256 :external-format :default) (check-256))
; uses UTF-8 + CRLF(on MS-Windows) -> 387 bytes

(progn (generate-256 :external-format
  (ext:make-encoding :charset 'charset:iso-8859-1 :line-terminator :mac)) (check-256))
(progn (generate-256 :external-format
  (ext:make-encoding :charset 'charset:iso-8859-1 :line-terminator :dos)) (check-256))
|#
~~~

<a name="bulk"></a>

## 高速な一括 I/O

大量のデータをコピーする必要があり、コピー元とコピー先がどちらもストリーム（同じ [element type](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_e.htm#element_type)）である場合、[`read-sequence`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_seq.htm) と [`write-sequence`](http://www.lispworks.com/documentation/HyperSpec/Body/f_wr_seq.htm) を使うと非常に高速です。

~~~lisp
(let ((buf (make-array 4096 :element-type (stream-element-type input-stream))))
  (loop for pos = (read-sequence buf input-stream)
        while (plusp pos)
        do (write-sequence buf output-stream :end pos)))
~~~
