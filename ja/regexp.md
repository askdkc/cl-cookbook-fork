---
title: 正規表現
---

[ANSI Common Lisp 標準](http://www.lispworks.com/documentation/HyperSpec/index.html)には正規表現の機能は含まれていませんが、この用途のライブラリはいくつか存在します。たとえば [cl-ppcre](https://github.com/edicl/cl-ppcre) です。

さらに多くのリンクについては、対応する [Cliki: regexp](http://www.cliki.net/Regular%20Expression) ページも参照してください。

一部の CL 処理系、特に [CLISP](http://clisp.sourceforge.net/impnotes.html#regexp) と [ALLEGRO CL](https://franz.com/support/documentation/current/doc/regexp.htm) は正規表現の機能を含んでいることに注意してください。迷った場合は、マニュアルを確認するかベンダーに尋ねてください。

以下の説明は完全なものにはほど遠いので、CL-PPCRE ライブラリに付属するリファレンスマニュアルを忘れずに確認してください。

## PPCRE

[CL-PPCRE](https://github.com/edicl/cl-ppcre)（Portable Perl-compatible 正規表現の略）は、Common Lisp 向けの移植可能な正規表現ライブラリで、幅広い機能と優れた性能を備えています。多くの Common Lisp 処理系へ移植されており、Quicklisp 経由で簡単にインストールできます（または依存関係として追加できます）。

~~~lisp
(ql:quickload "cl-ppcre")
~~~

CL-PPCRE ライブラリ関数による基本操作を以下に説明します。


### マッチするパターンを探す: scan, create-scanner

`scan` 関数は与えられたパターンとのマッチを試み、成功すると4つの値を多値で返します。すなわち、マッチの開始位置、終了位置、そしてレジスタのマッチの開始と終了を表す2つの配列です。失敗すると `NIL` を返します。

正規表現パターンは `create-scanner` 関数呼び出しでコンパイルできます。他の関数から使える「scanner」が作成されます。

例:

~~~lisp
(let ((ptrn (ppcre:create-scanner "(a)*b")))
  (ppcre:scan ptrn "xaaabd"))
~~~

これは次と同じ結果を返します。

~~~lisp
(ppcre:scan "(a)*b" "xaaabd")
~~~

ただし、式の解析とコンパイルは一度だけ行われるため、繰り返し `scan` を呼ぶ場合に必要な時間は少なくなります。


### 情報を抽出する

CL-PPCRE は、マッチした断片を抽出する方法をいくつか提供します。

#### all-matches, all-matches-as-strings

`all-matches-as-strings` 関数はとても便利です。マッチのリストを返します。

~~~lisp
(ppcre:all-matches-as-strings "\\d+" "numbers: 1 10 42")
;; => ("1" "10" "42")
~~~

`all-matches` 関数も似ていますが、位置のリストを返します。

~~~lisp
(ppcre:all-matches "\\d+" "numbers: 1 10 42")
;; => (9 10 11 13 14 16)
~~~

よく見てください。実際には、すべてのマッチの開始位置と終了位置を含むリストを返しています。9 と 10 は最初の数値（1）の開始と終了、という具合です。

この例の文字列から整数を抽出したい場合は、結果に `parse-integer` をマップするだけです。

~~~lisp
CL-USER> (ppcre:all-matches-as-strings "\\d+" "numbers: 1 10 42")
;; ("1" "10" "42")
CL-USER> (mapcar #'parse-integer *)
(1 10 42)
~~~

2つの関数は通常の `:start` と `:end` キーワード引数を受け付けます。さらに、`all-matches-as-strings` は `:sharedp` 引数を受け付けます。

> SHAREDP が真の場合、部分文字列は TARGET-STRING と構造を共有することがあります。

#### count-matches（2.1.2、2024年4月で追加）

`(count-matches regex target-string)` は、`target-string` に対する `regex` のすべてのマッチ数を返します。


~~~lisp
CL-USER> (ppcre:count-matches "a" "foo bar baz")
2

CL-USER> (ppcre:count-matches "\\w*" "foo bar baz")
6
~~~



#### scan-to-strings, register-groups-bind

`scan-to-strings` 関数は `scan` に似ていますが、位置ではなく対象文字列の部分文字列を返します。この関数は成功時に2つの値を返します。マッチ全体の文字列と、マッチしたレジスタに対応する部分文字列（または NIL）の配列です。

`register-groups-bind` 関数は、与えられたパターンを対象文字列に対してマッチさせ、マッチした断片を与えられた変数に束縛します。

~~~lisp
(ppcre:register-groups-bind (first second third fourth)
      ("((a)|(b)|(c))+" "abababc" :sharedp t)
    (list first second third fourth))
;; => ("c" "a" "b" "c")
~~~

CL-PPCRE は、マッチした断片を変数に代入する前に関数を呼び出すための短縮形も提供しています。

~~~lisp
(ppcre:register-groups-bind
  (fname lname (#'parse-integer date month year))
      ("(\\w+)\\s+(\\w+)\\s+(\\d{1,2})\\.(\\d{1,2})\\.(\\d{4})"
       "Frank Zappa 21.12.1940")
    (list fname lname date month year))
;; => ("Frank" "Zappa" 21 12 1940)
~~~

### テキストを置換する: regex-replace, regex-replace-all

~~~lisp
(ppcre:regex-replace "a" "abc" "A") ;; => "Abc"
;; or
(let ((pat (ppcre:create-scanner "a")))
  (ppcre:regex-replace pat "abc" "A"))
~~~

### S式構文（parse tree）

cl-ppcre は、文字列の代わりに S 式として正規表現を受け取ることもできます。これは "parse tree"（解析木）構文と呼ばれ、バックスラッシュのエスケープを避けられます。

~~~lisp
;; Match one or more digits:
(ppcre:scan '(:greedy-repetition 1 nil :digit-class)
            "abc123def")
;; => 3, 6, #(), #()
~~~

これは次と等価です。

~~~lisp
(ppcre:scan "\\d+" "abc123def")
~~~

ここでは `scan` を使いましたが、`all-matches-as-strings` や、正規表現を引数として受け取る任意の関数も使えます。つまり Lisp らしい正規表現を使うわけです。

`parse-string` を使うと、文字列表現と木構造の表現を相互に変換できます（これは例から学ぶための優れた方法です）。

~~~lisp
(ppcre:parse-string "(\\d+)-(\\w+)")
;; => (:SEQUENCE
;;     (:REGISTER
;;      (:GREEDY-REPETITION 1 NIL :DIGIT-CLASS))
;;     #\-
;;     (:REGISTER
;;      (:GREEDY-REPETITION 1 NIL :WORD-CHAR-CLASS)))
~~~

木構造の形式は、プログラムからパターンを組み立てる場合に便利です。

~~~lisp
(defun match-tag (tag-name)
  "Build a regex matching an XML opening tag."
  `(:sequence
    "<" ,tag-name
    (:greedy-repetition 0 nil
      (:inverted-char-class #\>))
    ">"))

(ppcre:scan (match-tag "div") "<div class='x'>")
;; => 0, 16, #(), #()

(ppcre:all-matches-as-strings (match-tag "div") "<div class='x'>")
;; => ("<div class='x'>")
~~~

一般的な木構造の要素は次のとおりです。

| 木構造の形式 | 文字列での等価表現 |
|---|---|
| `:digit-class` | `\d` |
| `:word-char-class` | `\w` |
| `:whitespace-char-class` | `\s` |
| `(:greedy-repetition 0 nil x)` | `x*` |
| `(:greedy-repetition 1 nil x)` | `x+` |
| `(:greedy-repetition 0 1 x)` | `x?` |
| `(:register x)` | `(x)` |
| `(:alternation x y)` | `x\|y` |
| `(:sequence x y)` | `xy` |

完全な parse tree 構文については、[cl-ppcre docs](https://edicl.github.io/cl-ppcre/#create-scanner2) を参照してください。

## さらに見る

- [common-lisp-libraries.readthedocs.io の cl-ppcre](https://common-lisp-libraries.readthedocs.io/cl-ppcre/) を参照し、`do-matches`、`do-matches-as-strings`、`do-register-groups`、`do-scans`、`parse-string`、`regex-apropos`、`quote-meta-chars`、`split` などを読んでください。
