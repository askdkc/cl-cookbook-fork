---
title: 文字列
---

Common Lisp の文字列についてまず知っておくべきなのは、文字列は配列であり、したがってシーケンスでもあるという点です。つまり、配列やシーケンスに適用できる概念はすべて文字列にも当てはまります。特定の文字列関数が見つからないときは、より一般的な [配列関数やシーケンス関数](http://www.gigamonkeys.com/book/collections.html) も探してください。ここでは、文字列に対して、そして文字列に対してできることの一部だけを扱います。

ほとんどの Common Lisp 実装に含まれる ASDF3 には、[Utilities for Implementation- and OS- Portability (UIOP)](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/README.md) も含まれています。UIOP には文字列を扱う関数（`strcat`、`string-prefix-p`、`string-enclosed-p`、`first-char`、`last-char`、`split-string`、`stripln`）があります。

Quicklisp で使える外部ライブラリには、さらに機能を増やしたり、短く書けたりするものがあります。

- [str](https://github.com/vindarel/cl-str) は `trim`、`words`、`unwords`、`lines`、`unlines`、`concat`、`split`、`shorten`、`repeat`、`replace-all`、`starts-with-p`、`ends-with-p`、`blankp`、`emptyp` などを定義します。
- [Serapeum](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#strings) は、文字列操作関数を多数含む大きなユーティリティ集です。
- [cl-change-case](https://github.com/rudolfochrist/cl-change-case) には、文字列を camelCase、param-case、snake_case などへ変換する関数があります。これらは `str` にも含まれています。
- [mk-string-metrics](https://github.com/cbaggers/mk-string-metrics) には、さまざまな文字列メトリクス（Damerau-Levenshtein、Hamming、Jaro、Jaro-Winkler、Levenshtein など）を効率よく計算する関数があります。
- `cl-ppcre` も便利です。たとえば `ppcre:replace-regexp-all` があります。[正規表現](regexp.html) の節も参照してください。


最後に、`format` 構文に取り組むときは、次の資料を見逃さないでください。

* 公式の [CLHS ドキュメント](http://www.lispworks.com/documentation/HyperSpec/Body/22_c.htm)
* [クイックリファレンス](http://clqr.boundp.org/)
* [HexstreamSoft の CLHS 要約](https://www.hexstreamsoft.com/articles/common-lisp-format-reference/clhs-summary/#subsections-summary-table)
* この文書の末尾にある format ディレクティブ一覧
* Slime のヒントとして、`C-c C-d ~` のあとに format ディレクティブの文字を入力すると、そのドキュメントを開けます。TAB 補完で一覧できます。これも `ivy-mode` や `helm-mode` だとより便利です。

## 文字列を作る

文字列はダブルクォートで作れますが、ほかにも次の方法があります。

- `format nil` を使うと *出力せず* に新しい文字列を返します（`format` の例は後ろに出ます）。

~~~lisp
(defparameter *person* "you")
(format nil "hello ~a" *person*) ;; => "hello you"
~~~

- `make-string count` は指定した長さの文字列を作ります。`:initial-element` で指定した文字は `count` 回繰り返されます。

~~~lisp
(make-string 3 :initial-element #\♥) ;; => "♥♥♥"
~~~


## 部分文字列へアクセスする

文字列はシーケンスなので、`subseq` 関数で部分文字列へアクセスできます。文字列のインデックスは、いつも通り 0 始まりです。3 番目のオプション引数は、部分文字列に含まれない最初の文字のインデックスであり、部分文字列の長さではありません。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (subseq *my-string* 8)
"Marx"
CL-USER> (subseq *my-string* 0 7)
"Groucho"
CL-USER> (subseq *my-string* 1 5)
"rouc"
~~~

`subseq` を `setf` と組み合わせれば、部分文字列を変更することもできます。

~~~lisp
CL-USER> (defparameter *my-string* (string "Harpo Marx"))
*MY-STRING*
CL-USER> (subseq *my-string* 0 5)
"Harpo"
CL-USER> (setf (subseq *my-string* 0 5) "Chico")
"Chico"
CL-USER> *my-string*
"Chico Marx"
~~~

ただし、文字列は "stretchable" ではありません。HyperSpec には次のようにあります。 "部分シーケンスと新しいシーケンスの長さが等しくない場合、短いほうの長さが置換される要素数を決める"。例を示します。

~~~lisp
CL-USER> (defparameter *my-string* (string "Karl Marx"))
*MY-STRING*
CL-USER> (subseq *my-string* 0 4)
"Karl"
CL-USER> (setf (subseq *my-string* 0 4) "Harpo")
"Harpo"
CL-USER> *my-string*
"Harp Marx"
CL-USER> (subseq *my-string* 4)
" Marx"
CL-USER> (setf (subseq *my-string* 4) "o Marx")
"o Marx"
CL-USER> *my-string*
"Harpo Mar"
~~~

## 個々の文字へアクセスする

`char` 関数で、文字列の個々の文字へアクセスできます。`char` は `setf` とも一緒に使えます。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (char *my-string* 11)
#\x
CL-USER> (char *my-string* 7)
#\Space
CL-USER> (char *my-string* 6)
#\o
CL-USER> (setf (char *my-string* 6) #\y)
#\y
CL-USER> *my-string*
"Grouchy Marx"
~~~

`schar` もあります。効率が重要なら、適切な場面では `schar` のほうが少し速いことがあります。

文字列は配列であり、したがってシーケンスでもあるので、より一般的な `aref` や `elt` も使えます（`char` のほうが効率的に実装されていることもありますが）。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (aref *my-string* 3)
#\u
CL-USER> (elt *my-string* 8)
#\M
~~~

文字列中の各文字には整数コードがあります。認識できるコードの範囲や Lisp がそれを表示できるかどうかは、実装の文字セット対応、たとえば ISO-8859-1 や Unicode に直接関係します。以下は SBCL での UTF-8 の例です。UTF-8 は文字を 1 〜 4 バイトで表します。最初の例は先頭 128 文字の外にある文字、つまり通常のラテン文字集合の外にある文字を示します。2 番目の例は、255 を超える多バイト符号化を示します。Lisp reader が文字名で往復できる点にも注目してください。

~~~lisp
CL-USER> (stream-external-format *standard-output*)

:UTF-8
CL-USER> (code-char 200)

#\LATIN_CAPITAL_LETTER_E_WITH_GRAVE
CL-USER> (char-code #\LATIN_CAPITAL_LETTER_E_WITH_GRAVE)

200
CL-USER> (code-char 2048)
#\SAMARITAN_LETTER_ALAF

CL-USER> (char-code #\SAMARITAN_LETTER_ALAF)
2048
~~~

対応する文字の範囲と符号化については、UTF-8 の Wikipedia 記事を参照してください。

## 文字列から文字を削除・置換する

文字列を操作できる（シーケンス）関数はたくさんあります。ここでは例だけ示します。詳しくは HyperSpec のシーケンス辞書を見てください。

文字列から 1 文字を `remove` します。

~~~lisp
CL-USER> (remove #\o "Harpo Marx")
"Harp Marx"
CL-USER> (remove #\a "Harpo Marx")
"Hrpo Mrx"
CL-USER> (remove #\a "Harpo Marx" :start 2)
"Harpo Mrx"
CL-USER> (remove-if #'upper-case-p "Harpo Marx")
"arpo arx"
~~~

1 文字の置換には、`substitute`（非破壊的）か `replace`（破壊的）を使えます。

~~~lisp
CL-USER> (substitute #\u #\o "Groucho Marx")
"Gruuchu Marx"
CL-USER> (substitute-if #\_ #'upper-case-p "Groucho Marx")
"_roucho _arx"
CL-USER> (defparameter *my-string* (string "Zeppo Marx"))
*MY-STRING*
CL-USER> (replace *my-string* "Harpo" :end1 5)
"Harpo Marx"
CL-USER> *my-string*
"Harpo Marx"
~~~


## 文字列を連結する

名前の通りです。`concatenate` が役立ちます。これは汎用シーケンス関数なので、最初の引数に結果型を指定する必要があります。

~~~lisp
CL-USER> (concatenate 'string "Karl" " " "Marx")
"Karl Marx"
CL-USER> (concatenate 'list "Karl" " " "Marx")
(#\K #\a #\r #\l #\Space #\M #\a #\r #\x)
~~~

UIOP なら `strcat` を使います。

~~~lisp
CL-USER> (uiop:strcat "karl" " " "marx")
~~~

また、`str` ライブラリなら `concat` を使います。

~~~lisp
CL-USER> (str:concat "foo" "bar")
~~~

ただし、文字列を多くの部分から組み立てるなら、`concatenate` を何度も呼ぶのは無駄に見えます。データの形に応じて、ほかにも少なくとも 3 通りのよい方法があります。1 文字ずつ文字列を作るなら、`fill-pointer` が 0 の、`character` 型のサイズ可変なベクトルにして、`vector-push-extend` を使います。こうすると、文字列のおおよその長さが分かるならシステムへヒントも渡せます（`vector-push-extend` の第 3 引数参照）。

~~~lisp
CL-USER> (defparameter *my-string* (make-array 0
                              :element-type 'character
                              :fill-pointer 0
                              :adjustable t))
*MY-STRING*
CL-USER> *my-string*
""
CL-USER> (dolist (char '(#\Z #\a #\p #\p #\a))
    (vector-push-extend char *my-string*))
NIL
CL-USER> *my-string*
"Zappa"
~~~

文字列を任意のオブジェクト（シンボル、数値、文字、文字列など）の（印字表現）から組み立てる場合は、出力ストリーム引数を `nil` にして `format` を使えます。こうすると `format` は、指定した出力を文字列として返します。

~~~lisp
CL-USER> (format nil "This is a string with a list ~A in it"
             '(1 2 3))
"This is a string with a list (1 2 3) in it"
~~~

`format` のミニ言語が持つ繰り返し構文を使えば、`concatenate` を模倣できます。

~~~lisp
CL-USER> (format nil "The Marx brothers are:~{ ~A~}."
             '("Groucho" "Harpo" "Chico" "Zeppo" "Karl"))
"The Marx brothers are: Groucho Harpo Chico Zeppo Karl."
~~~

`format` はもっと多くの処理ができますが、その構文は比較的難解です。この最後の例のあと、詳細は CLHS の整形出力に関する節で確認できます。

~~~lisp
CL-USER> (format nil "The Marx brothers are:~{ ~A~^,~}."
             '("Groucho" "Harpo" "Chico" "Zeppo" "Karl"))
"The Marx brothers are: Groucho, Harpo, Chico, Zeppo, Karl."
~~~

さまざまなオブジェクトの印字表現から文字列を作るもう 1 つの方法は、`with-output-to-string` を使うことです。この便利なマクロの値は、マクロ本体の中で文字列ストリームへ出力されたものをすべて含む文字列です。つまり、必要なら `format` の全機能も自由に使えます。

~~~lisp
CL-USER> (with-output-to-string (stream)
           (dolist (char '(#\Z #\a #\p #\p #\a #\, #\Space))
             (princ char stream))
           (format stream "~S - ~S" 1940 1993))
"Zappa, 1940 - 1993"
~~~

## 文字列を 1 文字ずつ処理する

`map` 関数で、文字列を 1 文字ずつ処理できます。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (map 'string (lambda (c) (print c)) *my-string*)
#\G
#\r
#\o
#\u
#\c
#\h
#\o
#\Space
#\M
#\a
#\r
#\x
"Groucho Marx"
~~~

`loop` を使ってもできます。

~~~lisp
CL-USER> (loop for char across "Zeppo"
               collect char)
(#\Z #\e #\p #\p #\o)
~~~

## 文字列を文字ごと・単語ごとに逆順にする

文字ごとに逆順にするのは、組み込みの `reverse` 関数（または破壊的版の `nreverse`）で簡単です。

~~~lisp
CL-USER> (defparameter *my-string* (string "DSL"))
*MY-STRING*
CL-USER> (reverse *my-string*)
"LSD"
~~~

単語ごとに逆順にするワンライナーは、CL にはありません。Perl のように split と join で済ませるわけにはいきません。`split-sequence` のような外部ライブラリを使うか、自分で実装する必要があります。

`str` ライブラリを使った例です。

~~~lisp
CL-USER> (defparameter *singing* "singing in the rain")
*SINGING*
CL-USER> (str:words *SINGING*)
("singing" "in" "the" "rain")
CL-USER> (reverse *)
("rain" "the" "in" "singing")
CL-USER> (str:unwords *)
"rain the in singing"
~~~

外部依存なしの別解もあります。

~~~lisp
CL-USER> (defun split-by-one-space (string)
    "Returns a list of substrings of string
    divided by ONE space each.
    Note: Two consecutive spaces will be seen as
    if there were an empty string between them."
    (loop for i = 0 then (1+ j)
          as j = (position #\Space string :start i)
          collect (subseq string i j)
          while j))
SPLIT-BY-ONE-SPACE
CL-USER> (split-by-one-space "Singing in the rain")
("Singing" "in" "the" "rain")
CL-USER> (split-by-one-space "Singing in the  rain")
("Singing" "in" "the" "" "rain")
CL-USER> (split-by-one-space "Cool")
("Cool")
CL-USER> (split-by-one-space " Cool ")
("" "Cool" "")
CL-USER> (defun join-string-list (string-list)
    "Concatenates a list of strings
and puts spaces between the elements."
    (format nil "~{~A~^ ~}" string-list))
JOIN-STRING-LIST
CL-USER> (join-string-list '("We" "want" "better" "examples"))
"We want better examples"
CL-USER> (join-string-list '("Really"))
"Really"
CL-USER> (join-string-list '())
""
CL-USER> (join-string-list
          (nreverse
           (split-by-one-space
            "Reverse this sentence by word")))
"word by sentence this Reverse"
~~~

## Unicode 文字列を扱う

ここでは [SBCL の文字列操作](http://www.sbcl.org/manual/index.html#String-operations) を使います。より一般には、[SBCL の Unicode サポート](http://www.sbcl.org/manual/index.html#Unicode-Support) を参照してください。


### Unicode 文字列をアルファベット順に並べる

比較関数に `string-lessp` を使って Unicode 文字列を並べるのは、期待どおりではありません。

~~~lisp
CL-USER> (sort '("Aaa" "Ééé" "Zzz") #'string-lessp)
("Aaa" "Zzz" "Ééé")
~~~

[SBCL](http://www.sbcl.org/manual/#String-operations) では `sb-unicode:unicode<` を使います。

~~~lisp
CL-USER> (sort '("Aaa" "Ééé" "Zzz") #'sb-unicode:unicode<)
("Aaa" "Ééé" "Zzz")
~~~

### 文字列をグラフェム・文・行・単語に分割する

これらの関数は SBCL の [`sb-unicode`](http://www.sbcl.org/manual/#String-operations) を使います。SBCL 専用です。

`sb-unicode:sentences` を使うと、既定の文分割規則に従って文字列を文に分けられます。

`sb-unicode:lines` を使うと、`:margin` キーワード引数で指定した幅を超えない行に分割できます。結合文字は常に基底文字と一緒に保たれ、行末のスペース（ただし他の空白は除く）は削除されます。`:margin` を指定しない場合、既定値は 80 文字です。

~~~lisp
CL-USER> (sb-unicode:lines "A first sentence. A second somewhat long one." :margin 10)
("A first"
 "sentence."
 "A second"
 "somewhat"
 "long one.")
~~~

`sb-unicode:words` と `sb-unicode:graphemes` も参照してください。

ヒント: フィーチャフラグを使えば、これらの関数を SBCL でだけ実行するようにできます。

    #+sbcl
    (runs on sbcl)
    #-sbcl
    (runs on other implementations)

## 大文字小文字を制御する

Common Lisp には、文字列の大文字小文字を制御する関数がいくつかあります。

~~~lisp
CL-USER> (string-upcase "cool")
"COOL"
CL-USER> (string-upcase "Cool")
"COOL"
CL-USER> (string-downcase "COOL")
"cool"
CL-USER> (string-downcase "Cool")
"cool"
CL-USER> (string-capitalize "cool")
"Cool"
CL-USER> (string-capitalize "cool example")
"Cool Example"
~~~

これらの関数は `:start` と `:end` キーワード引数を取るので、文字列の一部だけを操作することもできます。先頭に `N` が付いた破壊的版もあります。

~~~lisp
CL-USER> (string-capitalize "cool example" :start 5)
"cool Example"
CL-USER> (string-capitalize "cool example" :end 5)
"Cool example"
CL-USER> (defparameter *my-string* (string "BIG"))
*MY-STRING*
CL-USER> (defparameter *my-downcase-string* (nstring-downcase *my-string*))
*MY-DOWNCASE-STRING*
CL-USER> *my-downcase-string*
"big"
CL-USER> *my-string*
"big"
~~~

次の点に注意してください。HyperSpec によると、

> STRING-UPCASE、STRING-DOWNCASE、STRING-CAPITALIZE は文字列を変更しません。ただし、変換が必要な文字がない場合、処理系の裁量により、結果は元の文字列またはそのコピーのどちらかになります。

このため、次の例の最後の結果は実装依存です。"BIG" になるか "BUG" になるかは実装次第です。確実にしたいなら `copy-seq` を使ってください。

~~~lisp
CL-USER> (defparameter *my-string* (string "BIG"))
*MY-STRING*
CL-USER> (defparameter *my-upcase-string* (string-upcase *my-string*))
*MY-UPCASE-STRING*
CL-USER> (setf (char *my-string* 1) #\U)
#\U
CL-USER> *my-string*
"BUG"
CL-USER> *my-upcase-string*
"BIG"
~~~

### `format` 関数を使う

`format` 関数には、単語の大文字小文字を変えるディレクティブがあります。

#### 小文字にする: `~( ~)`

~~~lisp
CL-USER> (format t "~(~a~)" "HELLO WORLD")
hello world
~~~


#### 各単語の先頭を大文字にする: `~:( ~)`

~~~lisp
CL-USER> (format t "~:(~a~)" "HELLO WORLD")
Hello World
NIL
~~~

#### 最初の単語だけ先頭を大文字にする: `~@( ~)`

~~~lisp
CL-USER> (format t "~@(~a~)" "hello world")
Hello world
NIL
~~~

#### 大文字にする: `~@:( ~)`

ここではコロンと `@` を再利用しています。

~~~lisp
CL-USER> (format t "~@:(~a~)" "hello world")
HELLO WORLD
NIL
~~~


## 文字列の両端から空白を取り除く

空白だけでなく、任意の文字を取り除くこともできます。`string-trim`、`string-left-trim`、`string-right-trim` は、第 2 引数の部分文字列を返し、第 1 引数に含まれる文字を先頭や末尾から削除します。第 1 引数には任意の文字シーケンスを渡せます。

~~~lisp
CL-USER> (string-trim " " " trim me ")
"trim me"
CL-USER> (string-trim " et" " trim me ")
"rim m"
CL-USER> (string-left-trim " et" " trim me ")
"rim me "
CL-USER> (string-right-trim " et" " trim me ")
" trim m"
CL-USER> (string-right-trim '(#\Space #\e #\t) " trim me ")
" trim m"
CL-USER> (string-right-trim '(#\Space #\e #\t #\m) " trim me ")
~~~

注意: 先ほどの大文字小文字の節で述べた注意点は、ここにも当てはまります。

## シンボルと文字列を相互変換する

`intern` 関数は、文字列をシンボルに "変換" します。正確には、その文字列（第 1 引数）が表すシンボルが、パッケージ（第 2 引数。省略時は現在のパッケージ）ですでに参照可能かどうかを調べ、必要ならそのパッケージに登録します。ここでは関連する概念や、この関数の第 2 戻り値まで説明しません。詳しくは CLHS のパッケージの章を参照してください。

文字列の大文字小文字が重要である点に注意してください。

~~~lisp
CL-USER> (in-package "COMMON-LISP-USER")
#<The COMMON-LISP-USER package, 35/44 internal, 0/9 external>
CL-USER> (intern "MY-SYMBOL")
MY-SYMBOL
NIL
CL-USER> (intern "MY-SYMBOL")
MY-SYMBOL
:INTERNAL
CL-USER> (export 'MY-SYMBOL)
T
CL-USER> (intern "MY-SYMBOL")
MY-SYMBOL
:EXTERNAL
CL-USER> (intern "My-Symbol")
|My-Symbol|
NIL
CL-USER> (intern "MY-SYMBOL" "KEYWORD")
:MY-SYMBOL
NIL
CL-USER> (intern "MY-SYMBOL" "KEYWORD")
:MY-SYMBOL
:EXTERNAL
~~~

逆に、シンボルから文字列へ変換するには `symbol-name` か `string` を使います。

~~~lisp
CL-USER> (symbol-name 'MY-SYMBOL)
"MY-SYMBOL"
CL-USER> (symbol-name 'my-symbol)
"MY-SYMBOL"
CL-USER> (symbol-name '|my-symbol|)
"my-symbol"
CL-USER> (string 'howdy)
"HOWDY"
~~~

## 文字と文字列を相互変換する

`coerce` を使えば、長さ 1 の文字列を文字に変換できます。文字のシーケンスを文字列へ変換することもできます。ただし、文字を文字列にするには `coerce` は使えません。その場合は `string` を使います。

~~~lisp
CL-USER> (coerce "a" 'character)
#\a
CL-USER> (coerce (subseq "cool" 2 3) 'character)
#\o
CL-USER> (coerce "cool" 'list)
(#\c #\o #\o #\l)
CL-USER> (coerce '(#\h #\e #\y) 'string)
"hey"
CL-USER> (coerce (nth 2 '(#\h #\e #\y)) 'character)
#\y
CL-USER> (defparameter *my-array* (make-array 5 :initial-element #\x))
*MY-ARRAY*
CL-USER> *my-array*
#(#\x #\x #\x #\x #\x)
CL-USER> (coerce *my-array* 'string)
"xxxxx"
CL-USER> (string 'howdy)
"HOWDY"
CL-USER> (string #\y)
"y"
CL-USER> (coerce #\y 'string)
#\y can't be converted to type STRING.
   [Condition of type SIMPLE-TYPE-ERROR]
~~~

## 文字列の要素を探す

`find`、`position`、およびそれぞれの `…-if` 系を使って、適切な `:test` パラメータ付きで文字列内の文字を探せます。

~~~lisp
CL-USER> (find #\t "Tea time." :test #'equal)
#\t
CL-USER> (find #\t "Tea time." :test #'equalp)
#\T
CL-USER> (find #\z "Tea time." :test #'equalp)
NIL
CL-USER> (find-if #'digit-char-p "Tea time.")
#\1
CL-USER> (find-if #'digit-char-p "Tea time." :from-end t)
#\0

CL-USER> (position #\t "Tea time." :test #'equal)
4   ;; <= the first lowercase t
CL-USER> (position #\t "Tea time." :test #'equalp)
0    ;; <= the first capital T
CL-USER> (position-if #'digit-char-p "Tea time is at 5'00.")
15
CL-USER> (position-if #'digit-char-p "Tea time is at 5'00." :from-end t)
18
~~~

あるいは `count` などを使って、文字列中の文字を数えます。

~~~lisp
CL-USER> (count #\t "Tea time." :test #'equal)
1  ;; <= equal ignores the capital T
CL-USER> (count #\t "Tea time." :test #'equalp)
2  ;; <= equalp counts the capital T
CL-USER> (count-if #'digit-char-p "Tea time is at 5'00.")
3
CL-USER> (count-if #'digit-char-p "Tea time is at 5'00." :start 18)
1
~~~

## 文字列の部分文字列を探す

`search` 関数で、文字列の部分文字列を探せます。

~~~lisp
CL-USER> (search "we" "If we can't be free we can at least be cheap")
3
CL-USER> (search "we" "If we can't be free we can at least be cheap"
          :from-end t)
20
CL-USER> (search "we" "If we can't be free we can at least be cheap"
          :start2 4)
20
CL-USER> (search "we" "If we can't be free we can at least be cheap"
          :end2 5 :from-end t)
3
CL-USER> (search "FREE" "If we can't be free we can at least be cheap")
NIL
CL-USER> (search "FREE" "If we can't be free we can at least be cheap"
          :test #'char-equal)
15
~~~

## 文字列を数値に変換する

### 整数へ: `parse-integer`

CL には、整数を表す文字列を対応する数値へ変換する `parse-integer` 関数があります。第 2 戻り値は、解析が止まった位置のインデックスです。

~~~lisp
CL-USER> (parse-integer "42")
42
2
CL-USER> (parse-integer "42" :start 1)
2
2
CL-USER> (parse-integer "42" :end 1)
4
1
CL-USER> (parse-integer "42" :radix 8)
34
2
CL-USER> (parse-integer " 42 ")
42
3
CL-USER> (parse-integer " 42 is forty-two" :junk-allowed t)
42
3
CL-USER> (parse-integer " 42 is forty-two")

Error in function PARSE-INTEGER:
   There's junk in this string: " 42 is forty-two".
~~~

`parse-integer` は `#X` のような基数指定を理解しませんし、他の数値型を解析する組み込み関数もありません。その場合は `read-from-string` を使えます。

### 文字列から複数の整数を取り出す: `ppcre:all-matches-as-strings`

これは正規表現の章でも紹介しますが、この話題のついでに挙げておくと、とても便利です。

~~~lisp
CL-USER> (ppcre:all-matches-as-strings "-?\\d+" "42 is 41 plus 1")
;; ("42" "41" "1")

CL-USER> (mapcar #'parse-integer *)
;; (42 41 1)
~~~

### 任意の数値へ: `read-from-string`

この関数を使うと完全な reader が有効になる点に注意してください。脆弱性の原因になり得ます。代わりに `parse-number` や `parse-float` のようなライブラリを使うべきです。

~~~lisp
CL-USER> (read-from-string "#X23")
35
4
CL-USER> (read-from-string "4.5")
4.5
3
CL-USER> (read-from-string "6/8")
3/4
3
CL-USER> (read-from-string "#C(6/8 1)")
#C(3/4 1)
9
CL-USER> (read-from-string "1.2e2")
120.00001
5
CL-USER> (read-from-string "symbol")
SYMBOL
6
CL-USER> (defparameter *foo* 42)
*FOO*
CL-USER> (read-from-string "#.(setq *foo* \"gotcha\")")
"gotcha"
23
CL-USER> *foo*
"gotcha"
~~~

### `read-from-string` を安全に使う

少なくとも、外部から来たデータを読むなら、次のようにします。

~~~lisp
(let ((cl:*read-eval* nil))
  (read-from-string "…"))
~~~

これで read 時にコードが評価されるのを防げます。これにより、最後の `#.` reader マクロの例は動かなくなります。"can't read #. while *READ-EVAL* is NIL" というエラーになります。

さらに、別の reader マクロを導入するカスタム readtable からも守りたいなら、次のようにします。

~~~lisp
(with-standard-io-syntax
  (let ((cl:*read-eval* nil))
    (read-from-string "…")))
~~~


### 浮動小数へ: `parse-float` ライブラリ

`parse-integer` のように他の数値型を解析する組み込み関数はありません。外部ライブラリ [parse-float](https://github.com/soemraws/parse-float) はまさにそれを行います。`read-from-string` を使わないので、安全に使えます。

~~~lisp
CL-USER> (ql:quickload "parse-float")
CL-USER> (parse-float:parse-float "1.2e2")
120.00001
5
~~~

LispWorks にも [parse-float](http://www.lispworks.com/documentation/lw51/LWRM/html/lwref-228.htm) 関数があります。

`[parse-number](https://github.com/sharplispers/parse-number)` も参照してください。


## 数値を文字列に変換する

一般関数 `write-to-string`、またはその簡易版 `prin1-to-string` / `princ-to-string` を使うと、数値を文字列に変換できます。`write-to-string` では、`:base` キーワード引数で 1 回だけ出力基数を変えられます。全体の基数を変えるなら、既定値 10 の `*print-base*` を設定します。Lisp では、有理数は文字列化しても 2 つの整数の比として表されることを覚えておいてください。

~~~lisp
CL-USER> (write-to-string 250)
"250"
CL-USER> (write-to-string 250.02)
"250.02"
CL-USER> (write-to-string 250 :base 5)
"2000"
CL-USER> (write-to-string (/ 1 3))
"1/3"
~~~

## 文字列を比較する

一般関数 `equal` と `equalp` で、2 つの文字列が等しいかを確認できます。文字列は要素ごとに比較され、`equal` は大文字小文字を区別し、`equalp` は区別しません。ほかにも文字列専用の比較関数がたくさんあります。文字の実装依存属性を使うなら、こちらを使いたくなるでしょう。その場合は実装のドキュメントを確認してください。

例をいくつか示します。なお、不等を調べる関数はすべて、最初に一致しない位置を一般化ブールとして返します。より柔軟性が必要なら、汎用シーケンス関数 `mismatch` も使えます。

~~~lisp
CL-USER> (string= "Marx" "Marx")
T
CL-USER> (string= "Marx" "marx")
NIL
CL-USER> (string-equal "Marx" "marx")
T
CL-USER> (string< "Groucho" "Zeppo")
0
CL-USER> (string< "groucho" "Zeppo")
NIL
CL-USER> (string-lessp "groucho" "Zeppo")
0
CL-USER> (mismatch "Harpo Marx" "Zeppo Marx" :from-end t :test #'char=)
3
~~~

さらに `string/=`, `string-not-equal`, `string-not-lessp`, `string-not-greaterp` もあります。

<a id="string-formatting-format"></a>

## 文字列の整形: `format`

`format` 関数には、文字列、数値、リストの出力、再帰処理、Lisp 関数の呼び出しなど、たくさんのディレクティブがあります。ここでは、文字列を出力・整形するいくつかの要点に絞ります。

以下の例では、映画のリストを使います。

~~~lisp
(defparameter *movies* '(
    (1 "Matrix" 5)
    (10 "Matrix Trilogy swe sub" 3.3)))
~~~


### `format` の構造

format ディレクティブは `~` で始まります。`A` や `a` のような末尾の文字（大小文字は区別しません）がディレクティブを決めます。その間に、カンマ区切りのオプションやパラメータを入れられます。さらに、一部のディレクティブはコロンやアットマークの修飾子を受け取り、挙動を変えます。たとえば `D` ディレクティブでは、コロンを付けると 3 桁ごとにカンマが入り、アットマークを付けると正の数にプラス記号が付きます。

~~~lisp
(format nil "~d" 2025)
;; => "2025"
(format nil "~:d" 2025)
;; => "2,025"
(format nil "~@d" 2025)
;; => "+2025"
(format nil "~@:d" 2025)
;; => "+2,025"
~~~

アットマーク修飾子を付けると、`R` ディレクティブは英語の基数ではなくローマ数字を出力します。

~~~lisp
(format nil "~r" 2025)
;; => "two thousand twenty-five"
(format nil "~@r" 2025)
;; => "MMXXV"
~~~

2 つの修飾子を同時に使っても意味のある解釈がない場合、結果は未定義か、別の意味になります。

チルダを出すには `~~`、10 個のチルダを出すには `~10~` を使います。

ほかのディレクティブには次のものがあります。

- `R`: ローマ数字（例: 英語で出力）: `(format t "~R" 20)` => "twenty"。
- `$`: 通貨: `(format t "~$" 21982)` => 21982.00
- `D`, `B`, `O`, `X`: 10 進、2 進、8 進、16 進。
- `F`: 固定小数点形式の浮動小数点数。
- `P`: 複数形: `(format nil "~D famil~:@P/~D famil~:@P" 7 1)` => "7 families/1 family"

### 基本プリミティブ: `~A` / `~a` (Aesthetics)

`(format t "~a" *movies*)` がもっとも基本的な使い方です。

`t` は `*standard-output*` に出力します。

~~~lisp
(format nil "~a" *movies*)
;; => "((1 Matrix 5) (10 Matrix Trilogy swe sub 3.3))"
~~~

ここで `nil` は、`format` に新しい文字列を返すよう指示します。


### 標準出力に出すか新しい文字列を返すか: `t` / `nil`

上で見たように、`(format t …)` は `*standard-output*` に出力し、`(format nil …)` は新しい文字列を返します。

では、次を見てください。

~~~lisp
(format t "~a" *movies*)
;; =>
((1 Matrix 5) (10 Matrix Trilogy swe sub 3.3))
NIL
~~~

`format` は標準出力に *出力* し、NIL を *返します*。

しかし今度は次のようになります。

~~~lisp
(format nil "~a" *movies*)
;; =>
"((1 Matrix 5) (10 Matrix Trilogy swe sub 3.3))"
~~~

`format` は文字列を返しました。


<a id="newlines--and-"></a>

### 改行: `~%` と `~&`

`~%` は改行文字です。`~10%` は改行を 10 個出力します。

`~&` は、出力ストリームがすでに行頭にある場合は改行を出力しません。

<a id="tabs"></a>

### タブ

`~T` を使います。`~10T` も使えます。

インデントには `i` も使えます。


<a id="justifying-text--add-padding-on-the-right"></a>

### テキストの位置揃え / 右側にパディングを足す

`~2a` のように数値をパラメータとして使います。

~~~lisp
(format nil "~20a" "yo")
;; "yo                  "
~~~

~~~lisp
(mapcar (lambda (it)
           (format t "~2a ~a ~a~%" (first it) (second it) (third it)))
         *movies*)
~~~

```
1  Matrix 5
10 Matrix Trilogy swe sub 3.3
```

さらに広げると、次のようになります。

~~~lisp
(mapcar (lambda (it)
          (format t "~2a ~25a ~2a~%" (first it) (second it) (third it)))
        *movies*)
~~~

```
1  Matrix                    5
10 Matrix Trilogy swe sub    3.3
```

テキストは右寄せされます（これはオプション `:` を使う場合です）。

<a id="justifying-on-the-left-"></a>

#### 左寄せ: `@`

`~2@A` のように `@` を使います。

~~~lisp
(format nil "~20@a" "yo")
;; "                  yo"
~~~

~~~lisp
(mapcar (lambda (it)
           (format nil "~2@a ~25@a ~2a~%" (first it) (second it) (third it)))
        *movies*)
~~~

```
 1                    Matrix 5
10    Matrix Trilogy swe sub 3.3
```

<a id="justifying-decimals"></a>

### 小数の桁揃え

`~,2F` では、2 が小数点以下の桁数で、F が浮動小数点数のディレクティブです。
`(format t "~,2F" 20.1)` => "20.10".

`~2,2f` の場合は次のようになります。

~~~lisp
(mapcar (lambda (it)
          (format t "~2@a ~25a ~2,2f~%" (first it) (second it) (third it)))
        *movies*)
~~~

```
 1 Matrix                    5.00
10 Matrix Trilogy swe sub    3.30
```

これで十分です。

### 反復

反復構文 `~{str~}` で、リストから文字列を作れます。

~~~lisp
(format nil "~{~A, ~}" '(a b c))
;; "A, B, C, "
~~~

最後の要素のあとにカンマとスペースを出さないよう、`~^` を使います。

~~~lisp
(format nil "~{~A~^, ~}" '(a b c))
;; "A, B, C"
~~~

`~:{str~}` は似ていますが、サブリストのリスト向けです。

~~~lisp
(format nil "~:{~S are ~S. ~}" '((pigeons birds) (dogs mammals)))
;; "PIGEONS are BIRDS. DOGS are MAMMALS. "
~~~

`~@{str~}` は `~{str~}` に似ていますが、1 つのリスト引数ではなく、残りの引数すべてを反復用の引数リストとして使います。

~~~lisp
(format nil "~@{~S are ~S. ~}" 'pigeons 'birds 'dogs 'mammals)
;; "PIGEONS are BIRDS. DOGS are MAMMALS. "
~~~

### format 文字列を組み立てる (`~v`, `~?`)

文字列を揃えたいけれど、幅が変数そのものになることがあります。`(format nil "~30a" "foo")` のように固定値を書くわけにはいきません。そこで `v` ディレクティブを使います。カンマ区切りの先頭パラメータの代わりに使えます。

~~~lisp
(let ((padding 30))
    (format nil "~va" padding "foo"))
;; "foo                           "
~~~

実行時に完全な format ディレクティブを差し込みたいこともあります。そこで `?` ディレクティブです。

~~~lisp
(format nil "~?" "~30a" '("foo"))
;;                       ^ a list
~~~

あるいは `~@?` を使います。

~~~lisp
(format nil "~@?" "~30a" "foo" )
;;                       ^ not a list
~~~

もちろん、あらかじめ format 文字列を組み立てることもできます。

~~~lisp
(let* ((length 30)
      (directive (format nil "~~~aa" length)))
 (format nil directive "foo"))
~~~

### 条件付き整形

数値を指定して、複数の候補から 1 つを選びます。

~~~lisp
(format nil "~[dog~;cat~;bird~:;default~]" 0)
;; "dog"

(format nil "~[dog~;cat~;bird~:;default~]" 1)
;; "cat"
~~~

数値が範囲外なら、`~:;` のあとにある既定値が返ります。

~~~lisp
(format nil "~[dog~;cat~;bird~:;default~]" 9)
;; "default"
~~~

`~:*` と組み合わせると、不規則複数形を実装できます。

~~~lisp
(format nil "I saw ~r el~:*~[ves~;f~:;ves~]." 0)
;; => "I saw zero elves."
(format nil "I saw ~r el~:*~[ves~;f~:;ves~]." 1)
;; => "I saw one elf."
(format nil "I saw ~r el~:*~[ves~;f~:;ves~]." 2)
;; => "I saw two elves."
~~~

## ストリームへ出した内容を捕捉する

`(with-output-to-string (mystream) …)` の中では、`mystream` に書き込まれたものがすべて捕捉され、文字列として返されます。

~~~lisp
(defun greet (name &key (stream t))
   ;; by default, print to standard output.
   (format stream "hello ~a" name))

(let ((output (with-output-to-string (stream)
                (greet "you" :stream stream))))
   (format t "Output is: '~a'. It is indeed a ~a, aka a string.~&" output (type-of output)))
;; Output is: 'hello you'. It is indeed a (SIMPLE-ARRAY CHARACTER (9)), aka a string.
;; NIL
~~~

## 文字列を整える

次の例では [cl-slug](https://github.com/EuAndreh/cl-slug/) ライブラリを使います。このライブラリは内部で文字列を 1 文字ずつ走査し、`ppcre:regex-replace-all` を使っています。

    (ql:quickload "cl-slug")

読み込むと `slug` プレフィックスで使えます。

主な関数は、Web サイトの URL に向いた slug へ文字列を変換することです。

~~~lisp
(slug:slugify "My new cool article, for the blog (V. 2).")
;; "my-new-cool-article-for-the-blog-v-2"
~~~

### アクセント付き文字を取り除く

`slug:asciify` を使うと、アクセント付き文字を ASCII 相当へ置き換えられます。

~~~lisp
(slug:asciify "ñ é ß ğ ö")
;; => "n e ss g o"
~~~

この関数は多くの（西洋）言語をサポートしています。

~~~
slug:*available-languages*
((:TR . "Türkçe (Turkish)") (:SV . "Svenska (Swedish)") (:FI . "Suomi (Finnish)")
 (:UK . "українська (Ukrainian)") (:RU . "Ру́сский (Russian)") (:RO . "Română (Romanian)")
 (:RM . "Rumàntsch (Romansh)") (:PT . "Português (Portuguese)") (:PL . "Polski (Polish)")
 (:NO . "Norsk (Norwegian)") (:LT . "Lietuvių (Lithuanian)") (:LV . "Latviešu (Latvian)")
 (:LA . "Lingua Latīna (Latin)") (:IT . "Italiano (Italian)") (:EL . "ελληνικά (Greek)")
 (:FR . "Français (French)") (:EO . "Esperanto") (:ES . "Español (Spanish)") (:EN . "English")
 (:DE . "Deutsch (German)") (:DA . "Dansk (Danish)") (:CS . "Čeština (Czech)")
 (:CURRENCY . "Currency"))
~~~

### 句読点を取り除く

`(str:remove-punctuation s)` または `(str:no-case s)`（`(cl-change-case:no-case s)` と同じ）を使います。

~~~lisp
(str:remove-punctuation "HEY! What's up ??")
;; "HEY What s up"

(str:no-case "HEY! What's up ??")
;; "hey what s up"
~~~

これらは 1 つの ppcre Unicode 正規表現で句読点を取り除きます（`(ppcre:regex-replace-all "[^\\p{L}\\p{N}]+"`。`p{L}` は "letter" カテゴリ、`p{N}` はあらゆる数値文字です）。

## 付録

### すべての format ディレクティブ

すべてのディレクティブは大文字小文字を区別しません。`~A` は `~a` と同じです。

```
$ - Monetary Floating-Point
% - Newline
& - Fresh-line
( - Case Conversion
) - End of Case Conversion
* - Go-To
/ - Call Function
; - Clause Separator
< - Justification
< - Logical Block
> - End of Justification
? - Recursive Processing
A - Aesthetic
B - Binary
C - Character
D - Decimal
E - Exponential Floating-Point
F - Fixed-Format Floating-Point
G - General Floating-Point
I - Indent
Missing and Additional FORMAT Arguments
Nesting of FORMAT Operations
Newline: Ignored Newline
O - Octal
P - Plural
R - Radix
S - Standard
T - Tabulate
W - Write
X - Hexadecimal
[ - Conditional Expression
] - End of Conditional Expression
^ - Escape Upward
_ - Conditional Newline
{ - Iteration
| - Page
} - End of Iteration
~ - Tilde
```

### Slime のヘルプ

* `~A` のような `format` ディレクティブを調べるには、`M-x common-lisp-hyperspec-format` を使います。これは `C-c C-d ~` に割り当てられており、TAB 補完も使えます。


## 文字列と文字の型の階層

*実線のノードは具体的な型、破線のノードは型エイリアスです。たとえば `'string` は任意サイズの文字配列、`(array character (*))` の別名です。*

<div style="text-align: center">
    <img src="string-and-chars.png" alt="String and Character Types in Common Lisp"/>
</div>

<!-- pdf-include-start
![](string-and-chars.png)
   pdf-include-end -->


## 関連項目

* [Pretty Printer](https://cl-community-spec.github.io/pages/Examples-of-using-the-Pretty-Printer.html#Examples-of-using-the-Pretty-Printer): `*print-length*`、`*print-right-margin*`、`pprint-tabular` など
* [表データを整形出力する](https://gist.github.com/WetHat/a49e6f2140b401a190d45d31e052af8f) ASCII アートの Jupyter Notebook チュートリアル
