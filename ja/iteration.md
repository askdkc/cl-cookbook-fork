---
title: ループ、反復、マッピング
---

<!-- 最初の見出しの前に何らかの本文が必要 -->

## はじめに: loop, iterate, for, mapcar, series, transducers

### `loop` マクロ（組み込み）

**[loop](http://www.lispworks.com/documentation/lw51/CLHS/Body/m_loop.htm)**
は反復のための組み込みマクロです。

最も単純な形は `(loop (print "hello"))` です。これは永久に表示し続けます。

リストに対する単純な反復は次のようになります。

~~~lisp
(loop for x in '(1 2 3)
      do (print x))
;; =>
1
2
3
NIL
~~~

必要なものを表示しますが、戻り値は `nil` です。

リストを返したい場合は `collect` を使います。

~~~lisp
(loop for x in '(1 2 3)
      collect (* x 10))
;; => (10 20 30)
~~~

`loop` マクロは、ほとんどの Lisp 式とは異なり、s-expression を使わない複雑な内部 DSL を持っています。そのため、`loop` 式を読むときは、頭の半分を Lisp モードに、もう半分を `loop` モードにしておく必要があります。好きになるか嫌いになるかのどちらかです。たいていは、しばらく嫌いになってから好きになります。

`loop` 式は 4 つの部分からなると考えられます。

1. 反復される変数を設定する式
2. 条件付きで反復を終了する式
3. 各反復で何かを行う式
4. Loop が終了する直前に何かを行う式

さらに、`loop` 式は値を返せます。1 つの `loop` 式でこれらすべてを使うことはめったにありませんが、さまざまな方法で組み合わせられます。

loop clause は 2 つのスタイルで書けます。上のようにシンボルとして書くか、次のように keyword として書きます。

~~~lisp
(loop :for x :in '(1 2 3) :collect (* x 10))
~~~

ここでは `:for`、`:in`、`:collect` を keyword として書いています。


### `iterate` ライブラリ

**[iterate](https://common-lisp.net/project/iterate/doc/index.html)** is a
`loop` より単純で、より「Lisp らしく」、より予測しやすく、さらに拡張可能であることを目指した人気の反復マクロです。ただし組み込みではないので、import する必要があります。

    (ql:quickload "iterate")
    (use-package :iterate)

（同じパッケージで `loop` と Iterate を使うと、名前の衝突に遭遇するかもしれません。）

Iterate は次のように書きます。

~~~lisp
(iter (for i from 1 to 5)
  (collect (* i i)))
;; => (1 4 9 16 25)
~~~

Iterate には `display-iterate-clauses` も付属しており、かなり便利です。

~~~
(display-iterate-clauses '(for))
;; FOR PREVIOUS &OPTIONAL INITIALLY BACK     Previous value of a variable
;; FOR FIRST THEN            Set var on first, and then on subsequent iterations
;; ...
~~~

このページの `loop` 用の例の多くは、少し変更すれば Iterate でも有効です。

### `for` ライブラリ

**[for](https://github.com/Shinmera/for/)** is an extensible iteration macro
しばしば `loop` より短く書ける拡張可能な反復マクロです。「`loop` と違って拡張可能で分かりやすく、Iterate と違って code-walking を必要とせず拡張しやすい」とされています。

もう 1 つの利点として、すべてのデータ構造（list、vector、hash-table など）に対して使える 1 つの構文があります。迷ったら `for… over…` を使えばよいのです。

~~~lisp
(for:for ((x over your-data-structure))
   (print …))
~~~

これも quickload する必要があります。

    (ql:quickload "for")

### `map`, `mapcar` など（組み込み）

**`mapcar`** と `map` の例も示します。さらに、E. Weitz が "Common Lisp Recipes" 第 7 章でうまく分類している仲間の `mapcon`、`mapcan`、`maplist`、`mapc`、`mapl` も扱います。他の言語から来た人に最もなじみがあるのは、おそらく `mapcar` でしょう。これは関数と 1 つ以上のリストを引数に取り、リストの各 *element* に順番に関数を適用し、結果のリストを返します。

~~~lisp
(mapcar (lambda (it) (+ it 10)) '(1 2 3))
;; => (11 12 13)
~~~

`lambda` を使わずに関数を参照することもできます。その関数は正しい個数の引数を受け取れる必要があります。

~~~lisp
(mapcar #'1+ '(1 2 3))
;; => (2 3 4)

(mapcar #'+ '(1 2 3) '(10 20 30))
;; => (11 22 33)

(mapcar #'+ '(1 2 3) '(10 20 30) '(100 200 300))
;; => (111 222 333)
~~~

`map` は汎用的で、list や vector を引数として受け取り、結果の型を第 1 引数として要求します。

~~~lisp
(map 'vector (lambda (it) (+ it 10)) '(1 2 3))
;; => #(11 12 13)

(map 'list (lambda (it) (+ it 10)) #(1 2 3))
;; => (11 12 13)

(map 'string #'code-char '#(97 98 99))
;; => "abc"
~~~

**`map-into`** は破壊的な変種で、新しい sequence を割り当てる代わりに、既存の sequence へ結果を直接格納します。その結果 sequence は戻り値にもなります。

~~~lisp
(let ((result (make-list 3)))
  (map-into result #'+ '(1 2 3) '(10 20 30)))
;; => (11 22 33)
~~~

これは vector でも動作し、性能が重要なループで allocation を避けたいときに便利です。

~~~lisp
(let ((buf (make-array 4)))
  (map-into buf #'char-code "abcd")
  buf)
;; => #(97 98 99 100)
~~~

注: `map-into` は第 1 引数をその場で変更します。既存の buffer を再利用する必要がない場合は、`map` や `mapcar` を優先してください。

他の構文にも、状況によって利点があります。リストの *tail* を処理したり、戻り値を *concatenate* したり、何も返さなかったりします。その一部を見ていきます。

`mapcar` が好きでよく使い、lambda をもっと速く短く書きたいなら、次の単純なマクロを使えます。

~~~lisp
(defmacro ^ (&rest forms)
  `(lambda ,@forms))
~~~

例:

~~~lisp
(mapcar (^ (nb) (* nb 10)) '(1 2 3))
;; (10 20 30)
~~~

できあがりです。このレシピではこれ以上使いませんが、自由に使ってください。

### `series` ライブラリ

**[series](http://series.sourceforge.net/)** も気に入るかもしれません。これは sequence、ストリーム、loop の側面を組み合わせるものだと自称するライブラリです。Series 式は sequence に対する操作（つまり関数型プログラミング）のように見えますが、`loop` と同じ高い効率を達成できます。Series は "Common Lisp the Language" の付録 A で初めて登場しました（言語の一部になりかけたものです）。Series は次のように書きます。

~~~lisp
(collect
  (mapping ((x (scan-range :from 1 :upto 5)))
    (* x x)))
;; (1 4 9 16 25)
~~~

`series` は良いものですが、その関数名は今日の関数型言語で見かけるものとは異なります。["Generators
The Way I Want Them Generated"](https://cicadas.surf/cgit/colin/gtwiwtg.git/about/) ライブラリも気に入るかもしれません。これは `series` に似た lazy sequence ライブラリですが、より新しく、完全性では劣るものの、`take`、`filter`、`for`、`fold` といった語を持つ「現代的な」API を備えていて使いやすいです。

~~~lisp
(range :from 20)
;; #<GTWIWTG::GENERATOR! {1001A90CA3}>

(take 4 (range :from 20))
;; (20 21 22 23)
~~~

執筆時点で、GTWIWTG は GPLv3 の下でライセンスされています。

### `transducers` ライブラリ

**[transducers](https://codeberg.org/fosskers/cl-transducers)** パターンは 2023 年に Common Lisp へ移植され、"source" を効率よく反復するための関数型プログラミング idiom 一式を提供します。"source" は List や Vector のような単純な collection でもよく、巨大な file や無限データの generator でもありえます。

Transducers は...

- `map` や `filter` のような操作を、各 step の間で memory を割り当てずに連鎖できます。
- 特定の data type に縛られません。一度だけ実装すれば済みます。
- 「データ変換コード」を大幅に単純化します。
- 「lazy evaluation」とは無関係です。

最初の 1000 個の奇数整数の二乗和を求めてみましょう。

~~~lisp
(defpackage foo
  (:use :cl)
  (:local-nicknames (:t :transducers)))
;; => #<PACKAGE "FOO">

(t:transduce
  (t:comp (t:filter #'oddp)  ;; (2) 奇数だけを残す。
          (t:take 1000)      ;; (3) filter 後の最初の 1000 個の奇数を残す。
          (t:map (lambda (n) ;; (4) その 1000 個を二乗する。
                   (* n n))))
  #'+                        ;; (5) Reducer: すべての二乗を足し合わせる。
  (t:ints 1))                ;; (1) Source: すべての正の整数を生成する。
;; => 1333333000
~~~

ここでは `ints` が無限 generator であるにもかかわらず、最終結果に必要な数だけの値しか実際には作られません。

ユーザーは独自の transducer（`map` のような関数）や reducer（`+` のような関数）を自由に作り、望む方法で data ストリームを走査できます。それでいて memory 効率は非常に高く保てます。

詳しくは [README](https://codeberg.org/fosskers/cl-transducers)、[API](https://fosskers.github.io/cl-transducers/index.html)、または [original
Transducers document](https://clojure.org/reference/transducers) を参照してください。

## レシピ

### 永久にループする、return

~~~lisp
(loop (print "hello"))
~~~

`return` は結果を返せます。

~~~lisp
(loop for i in '(1 2 3)
      when (> i 1)
        return i)
;; => 2
~~~


### 決まった回数だけループする

#### dotimes

~~~lisp
(dotimes (n 3)
  (print n))
;; =>
0
1
2
NIL
~~~

ここで `dotimes` は `nil` を返します。値を返す方法は 2 つあります。まず、lambda list の中で result form を設定できます。

~~~lisp
(dotimes (n 3 :done)
  ;;          ^^^^^ result form。s-expression でもよい。
  (print n))
;; =>
0
1
2
:DONE
~~~

または、戻り値とともに `return` を使えます。

~~~lisp
(dotimes (i 3)
   (if (> i 1)
       (return :early-exit!)
     (print i)))
;; =>
0
1
:EARLY-EXIT!
~~~



#### loop… repeat

これは "Hello!" を 3 回表示し、`nil` を返します。

~~~lisp
(loop repeat 3
      do (format t "Hello!~%"))
;; =>
Hello!
Hello!
Hello!
NIL
~~~

`collect` を使うと、これはリストを返します。

~~~lisp
(loop repeat 3
      collect (random 10))
;; => (5 1 3)
~~~

#### Series

~~~lisp
(iterate ((n (scan-range :below 3)))
  (print n))
;; =>
0
1
2
NIL
~~~

### 無限にループする、循環リストを巡回する

まず、上で示したように、単に `(loop ...)` を使えば無限にループできます。ここでは、リスト上で永久にループする方法を示します。

最後の element をリスト自身に設定することで、無限リストを作れます。

~~~lisp
(loop with list-a = (list 1 2 3)
      with infinite-list = (setf (cdr (last list-a)) list-a)
      for item in infinite-list
      repeat 8
      collect item)
;; => (1 2 3 1 2 3 1 2)
~~~

図解: `(last (list 1 2 3))` は `(3)` です。これはリスト、より正確には `car` が 3 で `cdr` が NIL の cons cell です。復習には [data-structures chapter](data-structures.html) を参照してください。これは `(list 3)` の表現です。

~~~
[o|/]
 |
 3
~~~

`(list 1 2 3)` の表現:

```
[o|o]---[o|o]---[o|/]
 |       |       |
 1       2       3
```

最後の element の `cdr` をリスト自身に設定することで、自分自身へ戻るようにします。

`#=` 構文を使うと、記法上のショートカットが可能です。

~~~lisp
(defparameter *list-a* '#1=(1 2 3 . #1#))
(setf *print-circle* t)  ;; circular list を永久に表示しない
;; *list-a*
~~~

2 つの値の間だけで交互に切り替える必要があるなら、`for … then` を使います。

~~~lisp
(loop repeat 4
      for up = t then (not up)
      collect up)
;; (T NIL T NIL)
~~~

### Iterate の for ループ

list と vector について:

~~~lisp
(iter (for item in '(1 2 3))
  (collect (+ item 1)))
;; (2 3 4)

(iter (for i in-vector #(1 2 3))
  (collect (+ item 1)))
;; (2 3 4)
~~~

あるいは、list と vector のための一般化された反復 clause として `in-sequence` を使います（速度面のペナルティがあります）。

hash-table をループするのも簡単です。

~~~lisp
(let ((h (let ((h (make-hash-table)))
            (setf (gethash 'a h) 1)
            (setf (gethash 'b h) 2)
            h)))
   (iter (for (k v) in-hashtable h)
     (print k)))
;; =>
B
A
NIL
~~~

実際、次のものを反復する方法を知るには [こちら](https://common-lisp.net/project/iterate/doc/Sequence-Iteration.html) を見るか、`(display-iterate-clauses '(for))` を実行してください。

- symbol: `in-package`
- file または stream: `in-file` または `in-stream`
- element: `in-sequence`（sequence は vector または list です）。

### リストをループする

#### dolist

~~~lisp
(dolist (item '(1 2 3))
  (print item))
;; =>
1
2
3
NIL
~~~

`dolist` は `nil` を返します。

#### loop

`in` を使う場合は驚くことはありません。

~~~lisp
(loop for x in '(a b c)
      do (print x))
;; =>
A
B
C
NIL
~~~

~~~lisp
(loop for x in '(a b c)
      collect x)
;; => (A B C)
~~~

`on` を使うと、リストの `cdr` をループします。

~~~lisp
(loop for i on '(1 2 3) collect i)
;; => ((1 2 3) (2 3) (3))
~~~


#### mapcar

~~~lisp
(mapcar (lambda (x)
          (* x 10))
        '(1 2 3))
;; (10 20 30)
~~~

`mapcar` は lambda 関数の結果をリストとして返します。

#### Series
~~~lisp
(iterate ((item (scan '(1 2 3))))
  (print item))
;; =>
1
2
3
NIL
~~~

`scan-sublists` は `loop for ... on` に相当します。

~~~lisp
(iterate ((i (scan-sublists '(1 2 3))))
  (print i))
;; =>
(1 2 3)
(2 3)
(3)
NIL
~~~

<a id="vector--string-"></a>

### vector と文字列をループする

#### loop: `across`

~~~lisp
(loop for i across #(1 2 3) collect (+ i 1))
;; (2 3 4)
~~~

文字列は vector なので:

~~~lisp
(loop for i across "foo" do (format t "~a " i))
;; f o o
;; NIL
~~~

#### iterate: `in-vector`, `index-of-vector`, `in-string`

Iterate は array を反復するために `in-vector` を使います。

```lisp
(iter (for i in-vector #(100 20 3))
      (sum i))
```

`index-of-vector` を使うと、vector の index を変数へ直接割り当てられます。

~~~lisp
(iter (for i index-of-vector  #(100 20 3))
      (format t "~a " i))
;; => 0 1 2
~~~

#### Series

~~~lisp
(iterate ((i (scan #(1 2 3))))
  (print i))
;; =>
1
2
3
NIL
~~~

### 汎用 sequence をループする

#### loop（該当なし）

`loop` には、任意の種類の sequence をループする単一の keyword はありません。

#### iterate: `in-sequence`

iter では `in-sequence` を使って文字列、vector（したがって list も）を反復できます。

これは専用の反復構文より遅くなることがあります。

~~~lisp
(iter (for i in-sequence "foo" )
      (format t "~a " i))
;; => f o o
;; NIL

(iter (for i in-sequence '(1 2 3))
      (format t "~a " i))
;; => 1 2 3
;; NIL

(iter (for i in-sequence #(100 20 3))
      (format t "~a " i))
;; => 100 20 3
;; NIL
~~~

### hash-table をループする

hash-table の反復は、`loop` や他の組み込み、`iterate`、その他のライブラリで可能です。

hash table の性質上、entry が提供される順序を制御することは _できない_ ことに注意してください。

以降の例のために hash-table を作りましょう。

~~~lisp
(defparameter *my-hash-table* (make-hash-table))
(setf (gethash 'a *my-hash-table*) 1)
(setf (gethash 'b *my-hash-table*) 2)
~~~

<a id="key--value--loop-"></a>

#### key と値を `loop` する

key をループするには、これを使います。

~~~lisp
(loop :for k :being :the :hash-key :of *my-hash-table* :collect k)
;; (B A)
~~~

値をループする場合も考え方は同じですが、`:hash-key` の代わりに `:hash-value` keyword を使います。

~~~lisp
(loop :for v :being :the :hash-value :of *my-hash-table* :collect v)
;; (2 1)
~~~

key-value pair をループします。

~~~lisp
(loop :for k :being :the :hash-key
        :using (hash-value v) :of *my-hash-table*
      :collect (list k v))
;; ((B 2) (A 1))
~~~


#### maphash

`maphash` の lambda 関数は 2 つの引数、key と値を取ります。

~~~lisp
(maphash (lambda (key val)
           (format t "key: ~A value: ~A~%" key val))
         *my-hash-table*)
;; =>
key: A value: 1
key: B value: 2
NIL
~~~


#### with-hash-table-iterator

次のものも使えます。
[`with-hash-table-iterator`](http://www.lispworks.com/documentation/HyperSpec/Body/m_w_hash.htm),
これは（
[`macrolet`](http://www.lispworks.com/documentation/HyperSpec/Body/s_flet_.htm))
を経由して）第 1 引数を iterator に変換するマクロです。この iterator は呼び出されるたびに、hash table entry ごとに 3 つの値を返します。

- entry が返された場合に true になる generalized boolean
- entry の key
- entry の値

entry がもうない場合は、`nil` という 1 つの値だけが返されます。

例:

~~~lisp
;;; 上と同じ hash-table
CL-USER> (with-hash-table-iterator (my-iterator *my-hash-table*)
           (loop
              (multiple-value-bind (entry-p key value)
                  (my-iterator)
                (if entry-p
                    (format t "The value associated with the key ~S is ~S~%" key value)
                    (return)))))
;; =>
The value associated with the key A is 1
The value associated with the key B is 2
NIL
~~~

HyperSpec の次の注意に留意してください。

> 反復の暗黙の内部状態のいずれかが、呼び出しフォームを閉じ込めたクロージャを返すなどして、`with-hash-table-iterator` フォームの dynamic extent の外へ返された場合に何が起こるかは未規定です。

#### iterate: `in-hashtable`

`in-hashtable` を使います。

~~~lisp
(iter (for (k v) in-hashtable *my-hash-table*)
  (collect (list k v)))
;; ((B 2) (A 1))
~~~

#### Alexandria's `maphash-keys` and `maphash-values`

key または値（key だけ、または値だけ）を map するには、ここでも Alexandria の `maphash-keys` と `maphash-values` に頼れます。

#### Serapeum's `do-hash-table`

[Serapeum ライブラリ](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#hash-tables) には `do-hash-table` という do 風のマクロがあります。

    (do-hash-table (key value table &optional return) &body body)


#### for

`for` ライブラリでは `over` keyword を使います。

~~~lisp
(for:for ((it over *my-hash-table*))
  (print it))
;; =>
(A 1)
(B 2)
NIL
~~~

#### trivial-do:dohash

この話題が好きなので、もう 1 つ [trivial-do](https://github.com/yitzchak/trivial-do/) というライブラリを紹介します。これは `dolist` に似た `dohash` マクロを持っています。

~~~lisp
(dohash (key value *my-hash-table*)
  (format t "key: ~A, value: ~A~%" key value))
;; =>
key: A value: 1
key: B value: 2
NIL
~~~

#### Series

~~~lisp
(iterate (((k v) (scan-hash *my-hash-table*)))
  (format t "~&~a ~a~%" k v))
;; =>
A 1
B 2
NIL
~~~

### 2 つのリストを並行してループする

#### loop

~~~lisp
(loop for x in '(a b c)
      for y in '(1 2 3)
      collect (list x y))
;; ((A 1) (B 2) (C 3))
~~~

平坦なリストを返すには、`collect` の代わりに `nconcing` を使います。

~~~lisp
(loop for x in '(a b c)
      for y in '(1 2 3)
      nconcing (list x y))
;; (A 1 B 2 C 3)
~~~

片方のリストがもう片方より短い場合、loop は短い方の末尾で停止します。

~~~lisp
(loop for x in '(a b c)
      for y in '(1 2 3 4 5)
      collect (list x y))
;; ((A 1) (B 2) (C 3))
~~~

最も長いリストをループし、短い方の要素へ index で手動アクセスすることもできますが、すぐに非効率になります。代わりに、短いリストを延長するよう `loop` に指示できます。

~~~lisp
(loop for y in '(1 2 3 4 5)
      for x-list = '(a b c) then (cdr x-list)
      for x = (or (car x-list) 'z)
      collect (list x y))
;; ((A 1) (B 2) (C 3) (Z 4) (Z 5))
~~~

コツは、`for … = … then (cdr …)` という記法（`=` と `then` の役割に注意）によって、各反復で中間リストが（`cdr` により）短くなることです。最初は初期値の `'(a b c)` で、次に `cdr` の `(b c)`、次に `(c)`、最後に `NIL` になります。そして `(car NIL)` と `(cdr NIL)` はどちらも `NIL` を返すので、うまくいきます。


#### mapcar
~~~lisp
(mapcar (lambda (x y)
          (list x y))
        '(a b c)
        '(1 2 3))
;; ((A 1) (B 2) (C 3))
~~~

または単純に:

~~~lisp
(mapcar 'list '(a b c) '(1 2 3))
;; ((A 1) (B 2) (C 3))
~~~

平坦なリストを返します。

~~~lisp
(mapcan 'list '(a b c) '(1 2 3))
;; (A 1 B 2 C 3)
~~~

#### Series
~~~lisp
(collect
  (#Mlist (scan '(a b c))
          (scan '(1 2 3))))
;; ((A 1) (B 2) (C 3))
~~~

リストの長さが等しいと分かっている場合、より効率的な方法です。

~~~lisp
(collect
  (mapping (((x y) (scan-multiple 'list
                                  '(a b c)
                                  '(1 2 3))))
    (list x y)))
;; ((A 1) (B 2) (C 3))
~~~

平坦なリストを返します。

~~~lisp
(collect-append ; または collect-nconc
  (mapping (((x y) (scan-multiple 'list
                                  '(a b c)
                                  '(1 2 3))))
    (list x y)))
;; (A 1 B 2 C 3)
~~~


### ネストしたループ
#### loop

~~~lisp
(loop for x from 1 to 3
      collect (loop for y from 1 to x collect y))
;; ((1) (1 2) (1 2 3))
~~~

平坦なリストを返すには、最初の `collect` の代わりに `nconcing` を使います。

#### iterate

~~~lisp
(iter outer
  (for i below 2)
  (iter (for j below 3)
     (in outer (collect (list i j)))))
;; ((0 0) (0 1) (0 2) (1 0) (1 1) (1 2))
~~~

#### Series

~~~lisp
(collect
  (mapping ((x (scan-range :from 1 :upto 3)))
    (collect (scan-range :from 1 :upto x))))
;; ((1) (1 2) (1 2 3))
~~~


### 中間値を計算する

#### loop

各反復で値を計算する必要があるなら、`for var = ...` を使います。

~~~lisp
(loop for x from 1 to 3
      for y = (* x 10)
      collect y)
;; (10 20 30)
~~~

値を 1 回だけ計算すればよいなら、`with var = ...` を使います。

~~~lisp
(loop for x from 1 to 3
      for y = (* x 10)
      with z = x
      collect (list x y z))
;; ((1 10 1) (2 20 1) (3 30 1))
~~~

HyperSpec は `with` clause を次のように定義しています。

    with-clause ::= with var1 [type-spec] [= form1] {and var2 [type-spec] [= form2]}*

そのため、`=` の前に型を指定し、`with` を `and` でつなげられることが分かります。

~~~lisp
(loop for x from 1 to 3
      for y integer = (* x 10)
      with z integer = x
      collect (list x y z))
;; ((1 10 1) (2 20 1) (3 30 1))
~~~

~~~lisp
(loop for x upto 3
      with foo = :foo
      and bar = :bar
      collect (list x foo bar))
;; ((0 :FOO :BAR) (1 :FOO :BAR) (2 :FOO :BAR) (3 :FOO :BAR))
~~~

`for` に、各反復で呼び出される `then` clause を与えることもできます。

~~~lisp
(loop repeat 3
      for x = 10 then (incf x)
      collect x)
;; (10 11 12)
~~~

boolean を交互に切り替える小技です。

~~~lisp
(loop repeat 4
      for up = t then (not up)
      collect up)
;; (T NIL T NIL)
~~~

### カウンタ付きのループ
#### loop
リストを反復し、カウンタも並行して反復させます。最初に終了した clause（この場合はリストの末尾に到達すること）が、反復の終了時点を決めます。2 組の action が定義され、そのうち 1 つが条件付きで実行されます。（`do` が `when`、`unless`、`if` clause の直後にある場合、その action は test が `t` を返したときだけ実行されます。）

~~~lisp
(loop for x in '(a b c d e)
      for firstp = t then nil
      unless firstp
        do (format t ", ")
      do (format t "~A" x))
;; =>
A, B, C, D, E
NIL
~~~

上のループは、`if` とカウンタ変数 `y` を使って書くこともできます。

~~~lisp
(loop for x in '(a b c d e)
      for y from 1
      if (> y 1)
        do (format t ", ~A" x)
      else
        do (format t "~A" x))
;; =>
A, B, C, D, E
NIL
~~~

#### Series

複数の series を並行して反復し、無限 range を使うことで、カウンタを作れます。

~~~lisp
(iterate ((x (scan '(a b c d e)))
          (y (scan-range :from 1)))
  (when (> y 1)
    (format t ", "))
  (format t "~A" x))
;; =>
A, B, C, D, E
NIL
~~~

### 昇順と降順、上限と下限: `to` と `below`, `downto` と `above`

#### loop

`from… to…`:

~~~lisp
(loop for i from 0 to 3 collect i)
;; (0 1 2 3)
~~~

`from… below…`: これは 2 で止まります。

~~~lisp
(loop for i from 0 below 3 collect i)
;; (0 1 2)
~~~

同様に、`(3 2 1 0)` を得るには `from 3 downto 0` を使い、`(3 2 1)` を得るには `from 3 above 0` を使います。

#### Series

`:from ... :upto` は上限を含みます。

~~~lisp
(iterate ((i (scan-range :from 0 :upto 3)))
  (print i))
;; =>
0
1
2
3
NIL
~~~

`:from ... :below` は上限を含みません。

~~~lisp
(iterate ((i (scan-range :from 0 :below 3)))
  (print i))
;; =>
0
1
2
NIL
~~~


### ステップ
#### loop

`by` を使います。

~~~lisp
(loop for i from 1 to 10 by 2 collect i)
;; (1 3 5 7 9)
~~~

step clause は 1 回だけ評価されます。`by (1+ (random 3))` を使うと、次と同等です。

~~~lisp
(let ((step (1+ (random 3))))
  (loop for i from 1 to 10 by step
        do (print i)))
...
~~~

step は常に正の数でなければなりません。カウントダウンしたい場合は上を参照してください。

#### Series

`:by` を使います。

~~~lisp
(iterate ((i (scan-range :from 1 :upto 10 :by 2)))
  (print i))
~~~


### ループと条件分岐
#### loop

`if`、`else`、`finally` を使います。

~~~lisp
*(loop repeat 10
       for x = (random 100)
       if (evenp x)
         collect x into evens
       else
         collect x into odds
       finally (return (values evens odds)))
;; =>
(92 44 58 68)
(95 5 97 43 99 37)
~~~

```
(42 82 24 92 92)
(55 89 59 13 49)
```

`if` 本体で複数の clause を組み合わせるには、特別な構文（`and do`、`and count`）が必要です。

~~~lisp
(loop repeat 10
      for x = (random 100)
      if (evenp x)
        collect x into evens
        and do (format t "~a is even!~%" x)
      else
        collect x into odds
        and count t into n-odds
      finally (return (values evens odds n-odds)))
;; =>
46 is even!
8 is even!
76 is even!
58 is even!
0 is even!
(46 8 76 58 0)
(7 45 43 15 69)
5
~~~

#### iterate

上の例を iterate で翻訳する（あるいは最初から書く）のは分かりやすいです。

~~~lisp
(iter (repeat 10)
   (for x = (random 100))
   (if (evenp x)
       (progn
         (collect x into evens)
         (format t "~a is even!~%" x))
       (progn
         (collect x into odds)
         (count t into n-odds)))
   (finally (return (values evens odds n-odds))))
...
~~~

#### Series

前のループは Series では少し違った形になります。`split` は、与えられた boolean series に従って 1 つの series を複数に振り分けます。

~~~lisp
(let* ((number (#M(lambda (n)
                     (declare (ignore n))
                     (random 100))
                  (scan-range :below 10)))
       (parity (#Mevenp number)))
  (iterate ((n number) (p parity))
    (when p (format t "~a is even!~%" n)))
  (multiple-value-bind (evens odds) (split number parity)
    (values (collect evens)
            (collect odds)
            (collect-length odds))))
;; =>
24 is even!
92 is even!
92 is even!
46 is even!
(24 92 92 46)
(89 59 13 49 7 45)
6
~~~

`iterate` と 3 つの `collect` 式は逐次的に書かれていますが、実行される反復は `loop` の例と同じく 1 回だけであることに注意してください。

### clause でループを開始する（initially）

~~~lisp
(loop initially (format t "~a " 'loop-begin)
      for x below 3
      do (format t "~a " x))
;; =>
LOOP-BEGIN 0 1 2
NIL
~~~

`initially` form は loop code 全体の前、ループの「prologue」で評価されます。ループの終わりに対応するものは `finally` です。

その直後の `:for`、`:with`、`:as` clause で宣言された変数を変更しようとしても、*loop body の中では* 効果がありません。たとえば、下の initially で a と b を変更しようとすると次のようになります。

~~~lisp
(loop with a = 20 with b = 10
     initially (rotatef a b)  ;; 警告: a と b には遅すぎる。効果なし。
     for i from a to b
  do (print i))
;; => NIL
~~~

これは 10 から 20 までループするのに間に合うようには a と b を交換しません。20 から 10 へループすることになり、結果としてまったくループせず NIL を返します。

ただし、ループの最後で a と b の値を表示すると（`finally (format t "a is ~a, b is ~a" a b)` を試してください）、それらの値は交換されていることが分かります。なぜそうなるかを完全に理解するには、この loop snippet を macro-expand する必要があります（中間変数があります）。

`initially` は `iterate` にも存在します。


### test でループを終了する（until, while）
#### loop

~~~lisp
(loop for x in '(1 2 3 4 5)
      until (> x 3)
        collect x)
;; (1 2 3)
~~~

`while` を使っても同じです。

~~~lisp
(loop for x in '(1 2 3 4 5)
      while (< x 4)
        collect x)
;; (1 2 3)
~~~

#### Series

`until-if` で series を切り詰め、その結果から collect します。

~~~lisp
(collect
  (until-if (lambda (i) (> i 3))
            (scan '(1 2 3 4 5))))
;; (1 2 3)
~~~

### ループし、表示し、結果を返す
#### loop

`do` と `collect` は 1 つの式で組み合わせられます。

~~~lisp
(loop for x in '(1 2 3 4 5)
      while (< x 4)
        do (format t "x is ~a~&" x)
      collect x)
;; =>
x is 1
x is 2
x is 3
(1 2 3)
~~~

#### Series
mapping によって、副作用を実行しつつ item を collect できます。

~~~lisp
(collect
  (mapping ((x (until-if (complement (lambda (x) (< x 4)))
                         (scan '(1 2 3 4 5)))))
    (format t "x is ~a~&" x)
    x))
;; =>
x is 1
x is 2
x is 3
(1 2 3)
~~~


### 名前付きループと早期脱出
#### loop

特別な `loop named` 構文を使うと、`return-from` でループから早期脱出するために使える block を作れます。これは特にネストしたループで便利です。


~~~lisp
(loop named loop-1
      for x from 0 to 10 by 2
      do (loop for y from 0 to 100 by (1+ (random 3))
               when (< x y)
                 do (return-from loop-1 (values x y))))
;; =>
0
2
~~~

早期に返したいが、それでも `finally` clause は実行したいことがあります。その場合は [`loop-finish`](http://www.lispworks.com/documentation/HyperSpec/Body/m_loop_f.htm#loop-finish) を使います。

~~~lisp
(loop for x from 0 to 100
  do (print x)
  when (>= x 3)
    return x
  finally (print :done))  ;; <-- 表示されない
;; =»
0
1
2
3
3

(loop for x from 0 to 100
      do (print x)
      when (>= x 3)
        do (loop-finish)
      finally (print :done)
              (return x))
;; =>
0
1
2
3
:DONE
3
~~~

これは、何らかの計算を `finally` clause で行わなければならないときに最も必要になります。

#### when/return のための loop 省略形: thereis, never, always

いくつかの action は when/return の組み合わせに対する省略形を提供します。

~~~lisp
(loop for x in '(foo 2)
      thereis (numberp x))
;; T
~~~

~~~lisp
(loop for x in '(foo 2)
      never (numberp x))
;; NIL
~~~

~~~lisp
(loop for x in '(foo 2)
      always (numberp x))
;; NIL
~~~

これらは関数 `some`、`notany`、`every` に対応します。

~~~lisp
(some #'numberp '(foo 2))   => T
(notany #'numberp '(foo 2)) => NIL
(every #'numberp '(foo 2))  => NIL
~~~


#### Series

反復から早期に脱出するには、`return-from` で使う block を明示的に作ります。

~~~lisp
(block loop-1
  (iterate ((x (scan-range :from 0 :upto 10 :by 2)))
    (iterate ((y (scan-range :from 0 :upto 100 :by (1+ (random 3)))))
      (when (< x y)
        (return-from loop-1 (values x y))))))
;; =>
0
3
~~~

### 数える
#### loop
~~~lisp
(loop for i from 1 to 3 count (oddp i))
;; 2
~~~

#### Series
~~~lisp
(collect-length (choose-if #'oddp (scan-range :from 1 :upto 3)))
;; 2
~~~

### 合計
#### loop

~~~lisp
(loop for i from 1 to 3 sum (* i i))
;; 14
~~~

変数へ合計します。

~~~lisp
(loop for i from 1 to 3
      sum (* i i) into total
      do (print i)
      finally (return total))
;; =>
1
2
3
14
~~~


#### Series

~~~lisp
(collect-sum (#M(lambda (i) (* i i))
                (scan-range :from 1 :upto 3)))
;; 14
~~~

### max, min

#### loop

~~~lisp
(loop for i from 1 to 3 maximize (mod i 3))
;; 2
~~~

そして `minimize` があります。

#### Series

~~~lisp
(collect-max (#M(lambda (i) (mod i 3))
                (scan-range :from 1 :upto 3)))
;; 2
~~~
そして `collect-min` があります。

### 分配束縛、つまりリストや dotted pair に対するパターンマッチ

#### loop

~~~lisp
(loop for (a b) in '((x 1) (y 2) (z 3))
      collect (list b a))
;; ((1 X) (2 Y) (3 Z))
~~~

項を無視するには `nil` を使います。

~~~lisp
(loop for (nil . y) in '((1 . a) (2 . b) (3 . c)) collect y)
;; (A B C)
~~~

##### plist を反復する、またはリストを 2 要素ずつ反復する

リストを 2 item ずつ反復するには、`on`、`by`、destructuring を組み合わせます。

リストの残り（`cdr`）をループするために `on` を使います。

~~~lisp
(loop for rest on '(a 2 b 2 c 3)
      collect rest)
;; ((A 2 B 2 C 3) (2 B 2 C 3) (B 2 C 3) (2 C 3) (C 3) (3))
~~~

各反復で 1 element を飛ばすために `by` を使います（`(cddr list)` は `(rest (rest list))` と等価です）。

~~~lisp
(loop for rest on '(a 2 b 2 c 3) by #'cddr
      collect rest)
;; ((A 2 B 2 C 3) (B 2 C 3) (C 3))
~~~

次に destructuring を加えて、各反復で最初の 2 item だけを束縛します。

~~~lisp
(loop for (key value) on '(a 2 b 2 c 3) by #'cddr
      collect (list key (* 2 value)))
;; ((A 2) (B 4) (C 6))
~~~


#### Series
一般には `destructuring-bind` を使います。

~~~lisp
(collect
  (mapping ((l (scan '((x 1) (y 2) (z 3)))))
    (destructuring-bind (a b) l
      (list b a))))
~~~

ただし alist には `scan-alist` が用意されています。

~~~lisp
(collect
  (mapping (((a b) (scan-alist '((1 . a) (2 . b) (3 . c)))))
    (declare (ignore a))
    b))
;; (A B C)
~~~

### 変数の型を宣言する

型を宣言すると、compiler がコードを最適化する助けになります。SBCL はこれが得意なことで有名です。

machine code が最適化されたかどうかは、`disassembly` を呼び出して確認できます。

#### Loop

`:of-type` を使います。

~~~lisp
(loop :for i :of-type fixnum :below 10
   :for j :of-type fixnum :from 1
   :sum (* i j))
~~~

`fixnum`、`float`、`t`、`nil` のような単純な型では、`:of-type` を省略できます。

~~~lisp
(loop :for i fixnum :below 10
   :for j fixnum :from 1
   :sum (* i j))
~~~

`sum` や他の accumulation clause の後に型を指定することもできます。

~~~lisp
(loop for i fixnum below 10
   for j fixnum from 1
   sum (* i j) fixnum)
~~~

#### Iterate

`(declare (fixnum i))` を使います。

~~~lisp
(iter (for i below 10)
      (for j from 1)
      (declare (fixnum i))
      (sum (* i j)))
~~~


## loop にはない Iterate 固有の機能

Iterate には他にも固有の機能があります。

Common Lisp の初心者であれば、この節は後回しにしてまったく問題ありません。これらの機能に頼らずに Lisp を使い続けることも十分できます。ただし、いつか役に立つかもしれません。


### clause の順序が厳密でない

`loop` では、すべての `for` clause が loop body より前、たとえば `while` より前に現れる必要があります。`iter` ではこの順序に従わなくても問題ありません。

~~~lisp
(iter (for x in '(1 2 99))
  (while (< x 10))
  (for y = (print x))
  (collect (list x y)))
;; =>
1
2
((1 1) (2 2))
~~~

### accumulating clause をネストできる

`collect`、`appending`、その他の accumulating clause はどこにでも現れられます。

~~~lisp
(iter (for x in '(1 2 3))
  (case x
    (1 (collect :a))
    ;;  ^^ iter keyword。s-expression の中にネストされている。
    (2 (collect :b))))
~~~

### finder: `finding`

`iterate` には [finder](https://common-lisp.net/project/iterate/doc/Finders.html#Finders) があります。

> finder は、値が何らかの条件を満たす式である clause です。

`finding` の後に `maximizing`、`minimizing`、`such-that` を続けて使えます。

リストのリストから最長のリストを見つける方法です。

~~~lisp
(iter (for elt in '((a) (b c d) (e f)))
      (finding elt maximizing (length elt)))
;; (B C D)
~~~

LOOP でおおよそ同等のものを書くと次のようになります。

~~~lisp
(loop with max-elt = nil
      with max-key = 0
      for elt in '((a) (b c d) (e f))
      for key = (length elt)
      do
      (when (> key max-key)
        (setf max-elt elt
              max-key key))
      finally (return max-elt))
;; (B C D)
~~~

`such-that` clause は複数あってもかまいません。

~~~lisp
(iter (for i in '(7 -4 2 -3))
      (if (plusp i)
          (finding i such-that (evenp i))
        (finding (- i) such-that (oddp i))))
;; 2
~~~

`such-that #'evenp` や `such-that #'oddp` とも書けます。**`such-that 'oddp` は動作しないことに注意してください。**


### 制御フロー: `next-iteration`

これは "continue" のようなもので、loop にはありません。

> loop body の残りを飛ばし、ループの次の反復を開始します。

`iterate` には `first-iteration-p` と `(if-first-time then else)` もあります。

[control flow](https://common-lisp.net/project/iterate/doc/Control-Flow.html#Control-Flow) を参照してください。


### generator

generator は lazy で、明示的に指示されたときに次の値へ進みます。

`generate` と `next` を使います。

~~~lisp
(iter (for i in '(1 2 3 4 5))
      (generate c in-string "black")
      (if (oddp i) (next c))
      (format t "~a " c))
;; =>
b b l l a
NIL
~~~

### 変数のバックトラック（`previous`）VS 並行束縛

`iterate` では、変数の前回の値を取得できます。

~~~lisp
(iter (for el in '(a b c d e))
      (for prev-el previous el)
      (collect (list el prev-el)))
;; ((A NIL) (B A) (C B) (D C) (E D))
~~~

ただしこの場合は、`iterate` ではサポートされない `loop` の並行束縛 `and` を使っても実現できます。

~~~lisp
(loop for el in '(a b c d e)
      and prev-el = nil then el
      collect (list el prev-el))
;; ((A NIL) (B A) (C B) (D C) (E D))
~~~

### さらに多くの clause

- `in-string` は文字列を 1 文字ずつ反復するために明示的に使えます。loop では `across` を使います。

~~~lisp
(iter (for c in-string "hello")
      (collect c))
;; (#\h #\e #\l #\l #\o)
~~~

- `loop` は `collecting`、`nconcing`、`appending` を提供します。`iterate` はこれらに加えて、`adjoining`、`unioning`、`nunioning`、`accumulating` も持ちます。

~~~lisp
(iter (for el in '(a b c a d b))
      (adjoining el))
;; (A B C D)
~~~

（`adjoin` は集合操作です。）

- `loop` には `summing`、`counting`、`maximizing`、`minimizing` があります。`iterate` にはさらに `multiplying` と `reducing` もあります。Reducing は一般化された reduction builder です。

~~~lisp
(iter (with dividend = 100)
      (for divisor in '(10 5 2))
      (reducing divisor by #'/ initial-value dividend))
;; 1
~~~


### Iterate は拡張可能

~~~lisp
(defmacro dividing-by (num &key (initial-value 0))
  `(reducing ,num by #'/ initial-value ,initial-value))
;; DIVIDING-BY

(iter (for i in '(10 5 2))
      (dividing-by i :initial-value 100))
;; 1
~~~

ただし [さらに多くの内容があります。documentation を参照してください](https://common-lisp.net/project/iterate/doc/Rolling-Your-Own.html#Rolling-Your-Own)。

[CLSQL](http://clsql.kpe.io/manual/loop-tuples.html) のように `loop` を拡張するライブラリも見ましたが、それらは feature flag check（`#+(or allegro clisp-aloop cmu openmcl
sbcl scl)`）だらけで、内部 module（`ansi-loop::add-loop-path`、`sb-loop::add-loop-path` など）を呼び出します。

## do と do*, tagbody と go: 汎用で低レベルな反復構文

組み込みの `do` マクロは汎用の primitive です。

実際には、日常的な用途では `loop`、`dotimes`、その仲間の方がよく使われます。`do` は、複数の stepping 変数を明示的に制御したいとき、反復本体で tag と `go` を使いたいとき、あるいは独自の反復構文を作るためにマクロ内で使う際に `loop` DSL より Lisp らしい括弧を好むときに便利です。

初心者としては、`do` をすぐに学ぶ *必要* はありませんが、いつか戻ってくるべきです。

### `do` の構造

`do` は次のものから構成されます。

- 変数を定義し、任意で初期値と反復方法を定義する binding のリスト
- 次を含むリスト
  - test form: true に評価されると反復が停止します。
  - 反復の結果として返すもの。単純な form 1 つでも複数でも構いません。暗黙の progn で包まれます。
- macro body

下の例では、マクロ body 内で `i` に束縛される 1 つの変数だけを step します。0 から始まり、各反復で `(1+ i)` の結果を得ます。

`(>= i 5)` が true になると反復は終了し、`i` を返します。

~~~lisp
(do ((i 0 (1+ i)))  ;; <-- var + init form + step form
                    ;;     これ以上 binding はない
    ((>= i 5) i)    ;; <-- test form + result
  (print i))
;; =>
0
1
2
3
4
;; => 5
~~~

0 から 4 を表示し、5 を返していることに注意してください。最後の反復の冒頭で step form が評価され、`i` が 5 に束縛され、その後 test form `(>= i 5)` が true になったので、数値 5 が返されました。

この snippet は次と等価です。

```lisp
(loop for i from 0 below 5
  do (print i)
  finally (return i))
```

複数の変数を並行して step できます。ここで「並行」とは、`let` と同じく、作られるときに互いを見ないこと、そして各 step で *互いの新しい値* を見ないことを意味します。

この例では、`i` と `j` という 2 つの binding を step します。

~~~lisp
(do ((i 0 (1+ i))
     (j 10 (- 10 i)))
    ((>= i 5) (list i j))
  (format t "i=~a j=~a~%" i j))
~~~

indentation と、それらを囲む括弧の組に注意してください。別の indentation にすると次のようになります。

~~~lisp
(do (
     (i 0  (1+ i))
     (j 10 (- 10 i))
    ; ^ ^^ ^^^
    ; var init step
    )
    …
~~~

`j` の initialization form が `i` に依存していないことを見てください。`j` は step form でだけ `i` を使います。

結果は次のとおりです。

```
i=0 j=10
i=1 j=10
i=2 j=9
i=3 j=8
i=4 j=7
;; => (5 6)
```

`do*` マクロとの違いは下を読んでください。


### 複数の result form

上の例では、単に `i`、`j`、`(list i j)` を返していました。これらは 1 つの Lisp form です。

複数の result form を書けます。それらは `progn` で包まれているかのように評価されます。したがって、最後の式の結果が返されます。

~~~lisp
(do* ((i 0 (1+ i)))
      ((>= i 5) (print "hey it's time to return") i i i)
      ;;        ^^   PROGN 内にあるかのような result form    ^^
    (print i))
…
;; => 5
~~~


### `do*`: `let*` のように文を逐次的に反復する

`do*` は似ていますが、`let*` のように変数を逐次的に束縛します（各変数は initialization form で前の変数を見ることができます）。また、各 step の冒頭で、各変数は他の binding の *新しい値* を見ます。

上と同じ例を `do*` で書くと次のようになります。

~~~lisp
(do* ((i 0 (1+ i))
      (j 10 (- 10 i)))
     ((>= i 5) (list i j))
  (format t "i=~a j=~a~%" i j))
;; =>
i=0 j=10
i=1 j=9
i=2 j=8
i=3 j=7
i=4 j=6
;; => (5 5)
~~~

結果が異なることを見てください。2 回目の反復（initialization step の後の最初の反復）の冒頭で `i` は 1 です。逐次束縛のため、`j` は以前の値 0 ではなく、*今は* `i` を 1 として見るので、`j` は 9 になります。

また、`do` を使った次の例は、`j` が initialization form で `i` を参照しているため compile できません。`do*` を使うべきでした。

~~~lisp
;; COMPILE できない。DO* を使う
(do ((i 0 (1+ i))
     (j i (* 2 i)))
     ;; ^^ 前の binding を参照している。
    ((>= i 5) i)
  (format t "i is ~a, j is ~a~&" i j))
~~~

コンパイル警告が表示されます。

> ; caught WARNING:
>;   undefined variable: COMMON-LISP-USER::I

それでも REPL で実行すると、"The 変数 I is unbound." という runtime エラーになります。

`do*` を使えます。


### 暗黙の `block`: `return` を使う

`do/do*` は、`nil` という名前の暗黙の `block` で囲まれています。

その結果、`(return)` を使えます（暗黙に nil という名前の block から return します。そうでなければ `return-from block-name` を使うことになります）。

~~~lisp
(do* ((i 0 (1+ i))
      (j i (* 2 i)))
     ((>= i 5) i)
  (when (> i 2)
    (return i))   ;; <----- return が動作する
  (format t "i is ~a, j is ~a~&" i j))

i is 0, j is 0
i is 1, j is 2
i is 2, j is 4
;; => 3
~~~

### 暗黙の `tagbody`: `go` を使う

`do/do*` の body は暗黙の `tagbody` で包まれています。

macro-expansion で確認しましょう。

```lisp
(macroexpand-1 '(do ((i 0 (1+ i)))
    ((>= i 5) i)
  (print i))
  )

(BLOCK NIL
  (LET* ((I 0))
    (DECLARE (IGNORABLE I))
    (TAGBODY
      (GO #:G318)
     #:G317
      (TAGBODY (PRINT I))
      (PSETQ I (1+ I))
     #:G318
      (UNLESS (>= I 5) (GO #:G317))
      (RETURN-FROM NIL (PROGN I)))))
```

つまり、反復 body の中で tag と `go` を使えます。

~~~lisp
(do ((i 0 (1+ i)))
     ((>= i 5) i)

  ;; body の開始。

  (when (= i 1)
    (go tag1))
  (when (= i 2)
    (go tag2))

  (go end)

 tag1      ;; <---------- 暗黙の tagbody 内の tag。
  (print "hello tag 1")
  (go end)

 tag2
  (print "hello tag 2")
  (go end)

 end
  (print i)
  )
~~~

これは次を出力します。

~~~lisp
0
"hello tag 1"
1
"hello tag 2"
2
3
4
;; => 5
~~~

tag を賢く使う方法は読者への練習問題として残します。ただし初心者向けではありません。

### 初心者に `do` は必要か

`do` を使うべきでしょうか。好きなものを使ってください。ただし初心者なら、まず `dotimes`、`dolist`、そして危ないことができる程度の `loop` を学びましょう。`loop` だけでも長くやっていけます。

- 詳しくは [Community Spec](https://cl-community-spec.github.io/pages/do.html) を読んでください。

## 独自の series scanner

同じ種類のオブジェクトをよく scan するなら、そのための独自 scanner を書けます。反復そのものを切り出せるということです。上の 2 要素リストのリストを scan する例を使い、1 番目の element の series と 2 番目の element の series を返す scanner を書きます。

~~~lisp
(defun scan-listlist (listlist)
  (declare (optimizable-series-function 2))
  (map-fn '(values t t)
          (lambda (l)
            (destructuring-bind (a b) l
              (values a b)))
          (scan listlist)))

(collect
  (mapping (((a b) (scan-listlist '((x 1) (y 2) (z 3)))))
    (list b a)))
~~~

## より短い series 式

次の series 式を考えます。

~~~lisp
(collect-sum (mapping ((i (scan-range :length 5)))
                    (* i 2)))
~~~

これは必要以上に少し長くなっています。`mapping` form の唯一の目的は変数 `i` を束縛することで、`i` は 1 か所でしか使われていません。Series には、この式を次のように単純化できる「隠れ機能」があります。

~~~lisp
(collect-sum (* 2 (scan-range :length 5)))
~~~

これは implicit mapping と呼ばれ、`series::install` の呼び出しで有効化できます。

~~~lisp
(series::install :implicit-map t)
~~~

implicit mapping を使う場合、上で示した `#M` reader マクロは不要になります。

## Loop の落とし穴

- 関数型構文でよく使われる keyword `it` は、loop keyword として認識されることがあります。loop の中では使わないでください。

~~~lisp
(loop for i from 1 to 5 when (evenp i) collect it)
;; (T T)
~~~

## Iterate の落とし穴

関数 `count` で壊れます。

~~~lisp
(iter (for i from 1 to 10)
      (sum (count i '(1 3 5))))
~~~

組み込みの `count` 関数を認識せず、代わりにコンディションを signal します。

`loop` では動作します。

~~~lisp
(loop for i from 1 to 10
    sum (count i '(1 3 5 99)))
;; 3
~~~


## 付録: loop keyword の一覧

**Name Clause**

```
named
```

**Variable Clauses**

```
initially finally for as with
```

**Main Clauses**

```
do collect collecting append
appending nconc nconcing into count
counting sum summing maximize return loop-finish
maximizing minimize minimizing doing
thereis always never if when
unless repeat while until
```

これらは clause を導入しません。

```
= and it else end from upfrom
above below to upto downto downfrom
in on then across being each the hash-key
hash-keys of using hash-value hash-values
symbol symbols present-symbol
present-symbols external-symbol
external-symbols fixnum float t nil of-type
```

ただし、何が keyword であるかを決めるのは parsing であることに注意してください。たとえば次では:

~~~lisp
(loop for key in hash-values)
~~~

`for` と `in` だけが keyword です。


©Dan Robertson on [Stack Overflow](https://stackoverflow.com/questions/52236803/list-of-loop-keywords).

## クレジットと参考文献

### Loop

* [Tutorial for the Common Lisp Loop Macro](http://www.ai.sri.com/pkarp/loop.html) by Peter D. Karp
* [Common Lisp's Loop Macro Examples for Beginners](http://www.unixuser.org/~euske/doc/cl/loop.html) by Yusuke Shinyama
* [Section 6.1 The LOOP Facility, of the draft Common Lisp Standard (X3J13/94-101R)](https://gitlab.com/vancan1ty/clstandard_build) - （draft）standard は Loop の開発、仕様、例についての背景情報を提供しています。[Single PDF file available](https://gitlab.com/vancan1ty/clstandard_build/-/blob/master/cl-ansi-standard-draft-w-sidebar.pdf)
* [26. Loop by Jon L White, edited and expanded by Guy L. Steele Jr.](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node235.html) - "Common Lisp the Language, 2nd Edition" から。上の draft と強く関連し、補足コメントと例を含みます。

### Iterate

* [The Iterate Manual](https://common-lisp.net/project/iterate/doc/index.html) - by Jonathan Amsterdam and Luís Oliveira
* [iterate - Pseudocodic Iteration](https://common-lisp-libraries.readthedocs.io/iterate/) - by Shubhamkar Ayare
* [Loop v Iterate - SabraOnTheHill](https://sites.google.com/site/sabraonthehill/loop-v-iter)
* [Comparing loop and iterate](https://web.archive.org/web/20170713081006/https://items.sjbach.com/211/comparing-loop-and-iterate) - by Stephen Bach（web archive）

### Series

* [Common Lisp the Language (2nd Edition) - Appendix A. Series](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node347.html)
* [SERIES for Common Lisp - Richard C. Waters](http://series.sourceforge.net/)

### その他

* 関連項目: [more functional constructs](https://lisp-journey.gitlab.io/blog/snippets-functional-style-more/)（do-repeat, take,…）
