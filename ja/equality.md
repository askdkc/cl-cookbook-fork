---
title: Equality
---

Common Lisp にはさまざまな equality function があります。`=`、`eq`、`eql`、`equal`、`equalp`、`string-equal`、`char-equal` などです。しかし違いは何でしょうか。例を使ってすべて説明します。

要するに:

- `=` は number 専用であり、`equal` は多くのものに対して期待どおりに動く equality predicate です。
- library を使わない限り、`=` や `equal` のような built-in operator を自分の class 用に overload することはできません。
- functional built-in (`remove-if`, `find` など) で string の sequence を操作していて、結果が得られず驚いたなら、おそらく `:test` key argument を忘れています。`(find "foo" '("hello" "foo") :test #'equal)`。
- generic predicate を使わないほうが、static analysis と performance は良くなります。


## `=` は number 用 (`NIL` に注意)

`=` function は 2 つ以上の number の value を比較します。

~~~lisp
(= 2 2) ;; => T
(= 2 2.0 2 2) ;; => T
(= 2 4/2) ;; => T

(= 2 42) ;; => NIL
~~~

しかし `=` は number 専用です。下の例では interactive debugger 付きの error が発生します。SBCL からの error message、condition type、backtrace を示します。

~~~lisp
(= 2 NIL)
;; => ERROR:
The value
  NIL
is not of type
  NUMBER
when binding SB-KERNEL::Y

   [Condition of type TYPE-ERROR]

Restarts:
  …

Backtrace:
  0: (SB-KERNEL:TWO-ARG-= 2 NIL) [external]
  1: (SB-VM::GENERIC-=)
  2: (= 2 NIL)
~~~

`SB-KERNEL::Y` が compiler の internal variable を参照している点に注意してください。いいえ、あなたの code に `Y` があるわけではありません。

結果として、number に対する equality check に NIL が含まれる可能性がある場合は、`equalp` を使うか、variable を `(or …
0)` で包むか、事前に `(null …)` で check できます。

## `eq` は low-level です。pointer、memory 上の位置と考えてください。

> (eq x y) は、x と y がまったく同一の object である場合に限り true です。

symbol と keyword には `eq` を使います。

これらは true です。

~~~lisp
(eq :a :a)
(eq 'a 'a)
~~~

object をそれ自身と比較すれば、それは `eq` です。

~~~lisp
(let ((x '(a . b)))
  (eq x x))
;; => T
~~~

`eq` は number、list、string、その他の compound object の比較には意味のある形では動きません。動くように見える場合はありますが、すべての implementation で true になるとは指定されていません。

そのため、私の implementation では `eq` は number に対して動きますが、あなたのものでは動かないかもしれません。

~~~lisp
(eq 2 2) ;; => T or NIL, this is not specified (it is T on my implementation).

;; However:
(eq
  49827139472193749213749218734917239479213749127394871293749123
  49827139472193749213749218734917239479213749127394871293749123) ;; => NIL on my implementation, and on yours?
~~~

理由は、implementation が同じ number に対して memory 上のまったく同じ位置を割り当てるかもしれないし、そうしないかもしれないからです。これは standard によって決められていません。

同様に、これらも implementation に依存するかもしれません。

~~~lisp
(eq '(a . b) '(a . b)) ;; might be true or false.
(eq #\a #\a) ;; true or false
~~~

list や string の比較は false です。

~~~lisp
(eq (list 'a) (list 'a)) ;; => NIL
(eq "a" "a") ;; => NIL
~~~

<!-- or unspecified? -->

これらの string (character の vector) が `eq` で equal でないのは、implementation が memory 上に 2 つの異なる string object を作ったかもしれないからです。


## `eql` は、同じ型の number と character にも使える、より一般的な `eq` です。

> `eql` predicate は、その argument が `eq` である場合、または同じ type の number で同じ value を持つ場合、または同じ character を表す character object である場合に true です。

有用性の観点では、`eq` < `eql` と言えます。

この number 比較は true になります。

~~~lisp
(eql 3 3) ;; => T
~~~

しかし注意してください。こちらは 3 と 3.0 が同じ type ではないため true ではありません
(integer と single float)。

~~~lisp
(eql 3 3.0) ;; => NIL
~~~

complex number の場合:

~~~lisp
(eql #c(3 -4) #c(3 -4)) ;; is true.
(eql #c(3 -4.0) #c(3 -4)) ;; is false (because of -4.0 and -4)
~~~

2 つの character の比較は動きます。

~~~lisp
(eql #\A #\A) ;; => T
~~~

そして、list や cons cell を意味のある形で比較することは、まだできません。

~~~lisp
(eql (cons 'a 'b) (cons 'a 'b)) ;; => NIL
~~~

## `equal` は string にも使えます (printed representation が似ている object 用)。

> `equal` predicate は、その argument が構造的に似た (isomorphic な) object である場合に true です。大まかな目安として、2 つの object は、その printed representation が同じである場合に限り `equal` です。

再び概念的には、`eq` < `eql` < `equal` と言えます。`eql` である任意の 2 つの object は `equal` でもあります。

異なる type の **number** は、まだ比較 **できません**。

~~~lisp
(equal 3 3.0) ;; => NIL
~~~

しかし **list** と cons cell は比較できるようになりました。実際、それらの printed representation は同じです。今回は memory 上で異なる object かどうかは関係ありません。

~~~lisp
(equal (cons 'a 'b) (cons 'a 'b)) ;; => T

(equal (list 'a) (list 'a)) ;; => T
~~~

**string** も比較できます。

~~~lisp
(equal "Foo" "Foo") ;; => T
~~~

memory 上で異なる object かどうかは関係ありません。

~~~lisp
(equal "Foo" (copy-seq "Foo")) ;; => T
~~~

case は重要です。実際、"FOO" は "foo" と同じようには print されません。

~~~lisp
(equal "FOO" "foo") ;; => NIL
~~~

structure や hash-table など他の object については、それらが `eq` (low-level equality) なら `equal` です。`equal` は内部へ降りて、そこに格納された value の equality を確認することはありません。

下に link している Community Spec でさらに読めます。


## `equalp` は string の case を無視し、number は numerical value を見ます。

> 2 つの object は、`equal` である場合、character であり alphabetic case や character の特定の他の attribute を無視する `char-equal` を満たす場合、異なる type であっても同じ numerical value を持つ number である場合、または component がすべて `equalp` である場合に `equalp` です。

順序を続けると、`eq` < `eql` < `equal` < `equalp` と言えます。
しかし一般的な有用性の点では、ほとんどの場合 `equalp` より `equal` を好むことになるでしょう。読み進めてください。

異なる type を持っていても、value を見て 2 つの **number** を比較できます。

~~~lisp
(equalp 3 3.0) ;; => T
~~~

number は「`=` のもとで同じなら」`equalp` です。これはよいことです。

次に **string** 比較に注意してください。

~~~lisp
(equalp "FOO" "foo") ;; => T
~~~

`equalp` は string に対して **case insensitive** です。string は character の sequence であり、`equalp` は character について case を無視する `char-equal` を使って、すべての component を比較するからです。

`equalp` が **array** を比較するとき、それらが specialize している type を無視します。そのため、string と array が equalp になることがあります。

~~~lisp
(equalp "x" #(#\x)) ;; => T
~~~

一方:

~~~lisp
(equal "x" #(#\x)) ;; => NIL
~~~

**structure** と **hash-table** については、`equalp` は内部へ降ります。

たとえば、2 つの hash-table を作ります (`serapeum:dict` shorthand を使います)。

~~~lisp
(dict :a 1 :b 2)
(dict :b 2 :a 1)
~~~

そして比較します。それらは equalp でしょうか。

~~~lisp
(equalp * **)
;; => T
~~~

ただし **equalp** は **object instance** の内部へは降りません。下の専用 section を見てください。

下に link している Community Spec でさらに読めます。


## その他の比較 function

### `null`

function `null` は、唯一の argument が NIL なら true を返します。

~~~lisp
(null '()) ;; => T
~~~


### 多くの CL built-in では default で `eql` が使われます

これは string を操作する newcomer によくある問題です。CL built-in function を使っていて、なぜ結果が得られないのか戸惑うことがあります。

これを見てください。

~~~lisp
(find "foo" (list "test" "foo" "bar"))
;; NIL
~~~

与えられた list に string "foo" が存在するか知りたいのです。NIL が返ります。何が起きているのでしょうか。

この CL built-in function は、sequence に対して動くものすべてと同様に、各 element を test するために `eql` を使います。しかし `(eql "foo" "foo")` は string には意味のある形では動きません。別の test function を使う必要があります。

これらの function はすべて `:test` keyword parameter を受け取り、test function を変更できます。

~~~lisp
(find "foo" (list "test" "foo" "bar") :test #'equal)
;; => "foo"
~~~

string の case を無視するには `equalp` も使えます。

~~~lisp
(find "FOO" (list "test" "foo" "bar") :test #'equalp)
;; => "foo"
~~~

これらの built-in function についての例は [data-structures](https://lispcookbook.github.io/cl-cookbook/data-structures.html) にさらにあります。

### `char-equal`

character を比較するための特別な operator があります。

> `char-equal` は alphabetic case と character の特定の他の attribute を無視します。


### string と `string-equal`

`string-equal` は、string と substring を比較するための specific function signature を持ちます (比較のための *start* と *end* boundary を指定できます)。ただし、これは `char-equal` を使うため、比較は case-*in*sensitive です。また symbol にも使えます。

~~~lisp
(string-equal :foo "foo") ;; => T
(string-equal :foo "FOO") ;; => T
~~~

これが docstring です。

```
STRING-EQUAL

This is a function in package COMMON-LISP

Signature
(string1 string2 &key (start1 0) end1 (start2 0) end2)

Given two strings (string1 and string2), and optional integers start1,
start2, end1 and end2, compares characters in string1 to characters in
string2 (using char-equal).
```

次の function もあります: ` string=; string/=; string<; string>; string<=; string>=; string-equal; string-not-equal; string-lessp; string-greaterp; string-not-greaterp; string-not-lessp`。

[strings.html](https://lispcookbook.github.io/cl-cookbook/strings.html) の page を参照してください。

### `tree-equal` で tree を比較する

こちらです。

> `tree-equal` は、X と Y が identical leaves を持つ isomorphic tree である場合に T を返します。


## 比較 function 表: (これ) と比較するには (あれ) の function を使う

```txt
To compare against...      Use...

Objects/Structs            EQ

NIL                        EQ (but the function NULL is more concise and probably cheaper)

T                          EQ (or just the value but then you don't care for the type)

Precise numbers            EQL

Floats                     =

Characters                 EQL or CHAR-EQUAL

Lists, Conses, Sequences   EQ (if you want the exact same object)
                           EQUAL (if you just care about elements)

Strings                    EQUAL (case-sensitive), EQUALP (case-insensitive)
                           STRING-EQUAL (if you throw symbols into the mix)

Trees (lists of lists)     TREE-EQUAL (with appropriate :TEST argument)
```

## 自分の object を比較する方法、別名 built-in function は object-oriented ではない

2 つの object が identical であり、memory 上で同じ object であることを check するには `eq` を使います。

自分の object を独自の logic で比較したい場合 (たとえば 2 つの "person" object は同じ name と surname を持つなら equal と見なす、など)、built-in function を specialize することはできません。自分の `person=` や同様の function を使うか、library を使ってください (下の link を参照)。

これは制限とも見なせますが、generic なものの代わりに specialised function を使うことには、(ずっと) 高速であるという利点があります。

例として、CLOS tutorial の `person` class を考えます。

```lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)))
```

2 つの person object を作ります。同じ name を持ちますが、2 つの異なる object です。

```lisp
(defparameter *p1* (make-instance 'person :name "me"))
(defparameter *p2-same-name* (make-instance 'person :name "me"))
```

2 つの object を比較するには `eq` を使います。

~~~lisp
(eq *p1* *p1*) ;; => T
(eq *p1* *p2-same-name*) ;; => NIL
~~~

異なる object を比較し、それらがいつ equal であるかを決めるために、独自の `person=` method を使います。

~~~lisp
(defmethod person= (p1 p2)
  (string= (name p1) (name p2)))

(person= *p1* *p2-same-name*)  ;; => T
~~~

どうしても `=` や `equal` を使いたい場合は、下を参照して library を使ってください。

## Coalescing: `compile-file` の含意

`(eql "a" "a")` の例に戻りましょう。これは NIL を返します。

これは REPL で NIL を返す、と正確に言う必要があります。interpreter は 2 つの string "a" を memory 上の同じ object と見なさないため、NIL を返します。

しかし compiler は object をまとめることがあります。

`compile-file` で file を compile すると、compiler は異なる object を coalesce しているかもしれません。"a" と "a" が似ている 2 つの literal string であることに気づき、それらを同じ memory location に保存しているかもしれません。

そのため、equality predicate が今度は T を返す可能性があります。

結論: 正しい equality predicate を使ってください。

これは、たとえば `(list 1 2 3)` (`list` function を使う) ではなく `'(1 2 3)` (quote を使う) のように、literal で定義した variable を変更すべきでない理由でもあります。

`compile` は object を coalesce することを許可されていない点に注意してください。


## Credits

- [CLtL2: Equality Predicates](http://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node74.html)
- compare table: [Stack-Overflow の Leslie P. Polzer](https://stackoverflow.com/questions/547436/whats-the-difference-between-eq-eql-equal-and-equalp-in-common-lisp)

## 参照

- [CL Community Spec の `equal`](https://cl-community-spec.github.io/pages/equal.html)
- [CL Community Spec の `equalp`](https://cl-community-spec.github.io/pages/equalp.html)
- [equals](https://github.com/karlosz/equals/) - Common Lisp 用 generic equality。
- [generic-cl](https://github.com/alex-gutev/generic-cl/) - CL built-in への generic function interface。
  - 自分の custom object に `=` や `<` を使えます。
