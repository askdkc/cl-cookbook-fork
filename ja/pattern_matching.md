---
title: パターンマッチング
---

ANSI Common Lisp 標準には pattern matching の機能は含まれていませんが、この用途のためのライブラリは存在し、[Trivia](https://github.com/guicho271828/trivia) が community standard になりました。

pattern matching の概念の導入については、[Trivia's wiki](https://github.com/guicho271828/trivia/wiki/What-is-pattern-matching%3F-Benefits%3F) を参照してください。

Trivia は*非常に多くの* Lisp object に対して match でき、拡張可能です。

この library は Quicklisp にあります。

~~~lisp
(ql:quickload "trivia")
~~~

以下の例では、この library を `use` します。

~~~lisp
(use-package :trivia)
~~~

好みに応じて、テスト用の package を作成できます。

~~~lisp
(defpackage :trivia-tests (:use :cl :trivia))
(in-package :trivia-tests)
~~~


## よく使う destructuring pattern

### 単純な値に match する

`match` を使うと、変数を他の値に対して test できます。

~~~lisp
(let ((x 3))
  (match x
     (0 :no-match)
     (1 :still-no-match)
     (3 :yes)
     (_ :other)))
;; => :yes
~~~

list でも同じです。

~~~lisp
(let ((x (list :a)))
  (match x
    (0 :nope)
    (1 :still-nope)
    (3 :yes)
    ((list :a) :a-list) ;; <-- match (list :a) entirely. Next we'll match on the content.
    (_ :other)))
;; => :A-LIST
~~~

string でも動きます（CL 組み込みの `case` ではできません）。

~~~lisp
(let ((x "a string"))
  (match x
    ("a string" :a-string)
    (_ :other)))
;; => :A-STRING
~~~

この知識を使って、洗練された再帰的 Fibonacci 関数を書けます。

~~~lisp
(defun fib (n)
  (match n
    (0 0)
    (1 1)
    (_ (+ (fib (- n 1)) (fib (- n 2))))))
~~~

変数 `x` が複合データ構造である場合、その内容に対して match できるとより面白くなります。次の節では Trivia の pattern を使ってそれを行います。


### fall-through は `_`

fall-through case に、`cond` や `case` で使われる `t` ではなく `_`（underscore）を使ったことに注目してください。


### `cons`

`cons` pattern は list やその他の cons cell に match します。

match される object と pattern の長さは異なっていてもかまいません。下では、`y` は `x` に match されなかった残りすべてを受け取ります。

~~~lisp
(match '(1 2 3)
  ((cons x y)
  ; ^^ pattern
   (print x)
   (print y)))
;; |-> 1
;; |-> (2 3)
~~~

### `list`, `list*`

`list` は厳密な pattern で、match される object の長さが subpattern の長さと同じであることを期待します。

~~~lisp
(match '(something 2 3)
  ((list a b _)
   (values a b)))
SOMETHING
2
~~~

`_` placeholder がなければ match しません。

~~~lisp
(match '(something 2 3)
  ((list a b)
   (values a b)))
NIL
~~~

`list*` pattern は object の長さに関して柔軟です。

~~~lisp
(match '(something 2 3)
  ((list* a b)
   (values a b)))
SOMETHING
(2 3)
~~~

~~~lisp
(match '(1 2 . 3)
  ((list* _ _ x)
   x))
3
~~~

ただし、`list*` が object を1つだけ受け取る場合、その object が list であるかどうかに関係なく、その object が返されることに注意してください。

~~~lisp
(match #(0 1 2)
  ((list* a)
   a))
#(0 1 2)
~~~

これは HyperSpec における `list*` の定義に関係しています: http://clhs.lisp.se/Body/f_list_.htm.


### `vector`, `vector*`

`vector` は object が vector であるか、長さが同じか、そして内容が各 subpattern に match するかを確認します。

`vector*` も似ていますが、subpattern の長さ以上であることを許す soft-match variant と呼ばれます。

~~~lisp
(match #(1 2 3)
  ((vector _ x _)
   x))
;; -> 2
~~~

~~~lisp
(match #(1 2 3 4)
  ((vector _ x _)
   x))
;; -> NIL : does not match
~~~

~~~lisp
(match #(1 2 3 4)
  ((vector* _ x _)
   x))
;; -> 2 : soft match.
~~~

~~~
<vector-pattern> : vector      | simple-vector
                   bit-vector  | simple-bit-vector
                   string      | simple-string
                   base-string | simple-base-string | sequence
(<vector-pattern> &rest subpatterns)
~~~

### class と structure の pattern

等価な3つの style があります。

~~~lisp
(defstruct foo bar baz)
(defvar *x* (make-foo :bar 0 :baz 1)

(match *x*
  ;; make-instance style
  ((foo :bar a :baz b)
   (values a b))
  ;; with-slots style
  ((foo (bar a) (baz b))
   (values a b))
  ;; slot name style
  ((foo bar baz)
   (values bar baz)))
~~~

### `type`, `satisfies`

`type` pattern は object がその type であれば match します。`satisfies` は predicate が object に対して true を返す場合に match します。lambda form も受け付けます。

### `assoc`, `property`, `alist`, `plist`

これらの pattern はすべて、まず pattern が list かどうかを確認します。それが満たされると内容を取得し、値を subpattern に対して match します。`assoc` と `property` pattern は単一の値に match します。`alist` と `plist` pattern は実質的に複数の pattern を `and` します。

~~~lisp
(match '(:a 1 :b 2)
  ((property :a 1) 'found))
;; -> FOUND
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property :a n) n))
;; -> 1
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property :d n) n))
;; -> NIL
~~~

`cl:getf` と同様に、`property` pattern に default value を追加できます。`cl:getf` と異なり、その default が使われているかどうかを捕捉する flag をさらに追加できます。

~~~lisp
(match '(:a 1 :b 2)
  ((property :c c 3) c))
;; -> 3
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property :c c 3 foundp) (list c foundp)))
;; -> (3 NIL)
~~~

`property!` pattern は、key が実際に存在する場合にだけ match します。

~~~lisp
(match '(:a 1 :b 2)
  ((property :d n) (list n))
  (_ 'fail))
;; -> (NIL)
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property! :d n) (list n))
  (_ 'fail))
;; -> FAIL
~~~

`plist` を使うと、複数の property に match できます。

~~~lisp
(match '(:a 1 :b 2)
  ((plist :a 1 :b x) x))
;; -> 2
~~~

`assoc` pattern は association list に match します。`cl:assoc` と同じように `:test` keyword を取れます。

~~~lisp
(match '((a . 1) (b . 2) (c . 3))
  ((assoc 'a 1) 'ok))
;; -> OK
~~~

~~~lisp
(match '((a . 1) (b . 2) (c . 3))
  ((assoc 'b x) x))
;; -> 2
~~~

~~~lisp
(match '(("one" . 1) ("two" . 2))
  ((assoc "one" x :test #'string-equal) x))
;; -> 1
~~~

`alist` pattern は association list の複数の要素に match します。

~~~lisp
(match '((a . 1) (b . 2) (c . 3))
  ((alist ('a . 1) ('c . n)) n))
;; -> 3
~~~

### Array, simple-array, row-major-array pattern

https://github.com/guicho271828/trivia/wiki/Type-Based-Destructuring-Patterns#array-simple-array-row-major-array-pattern を参照してください。

## 論理に基づく pattern

任意の pattern をいくらかの logic と組み合わせられます。

### `and`, `or`

次のものは:

~~~lisp
(match x
  ((or (list 1 a)
       (cons a 3))
   a))
~~~

`(1 2)` と `(4 . 3)` の両方に match し、それぞれ 2 と 4 を返します。

### `not`

subpattern が match するときは match しません。subpattern で使われた変数は body から見えません。

## guard

guard を使うと、pattern を使い、さらに predicate に対して検証できます。

構文は `guard` + `subpattern` + `a test form`、そして body です。

~~~lisp
(match (list 2 5)
  ((guard (list x y)     ; subpattern1
          (= 10 (* x y))) ; test-form
   :ok))
~~~

subpattern が真なら test form が評価され、それも真なら subpattern1 に match します。


## pattern の入れ子

pattern は入れ子にできます。

~~~lisp
(match '(:a (3 4) 5)
  ((list :a (list _ c) _)
   c))
~~~

これは `4` を返します。

## さらに見る

[special patterns](https://github.com/guicho271828/trivia/wiki/Special-Patterns) を参照してください: `place`, `bind`, `access`。
