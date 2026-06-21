---
title: 等価性
---

Common Lisp には、等価性を判定するためのさまざまな関数があります。`=`、`eq`、`eql`、`equal`、`equalp`、`string-equal`、`char-equal` などです。これらの違いを例とともに説明します。

要点は次のとおりです。

- `=` は数値専用です。`equal` は、リストや文字列など多くの値を通常期待する方法で比較します。
- ライブラリを使わない限り、`=` や `equal` のような標準関数を自作のクラス向けに特殊化することはできません。
- `find` などで文字列のシーケンスを検索しても結果が得られない場合は、`:test` キーワード引数を確認してください。たとえば `(find "foo" '("hello" "foo") :test #'equal)` とします。
- 汎用的な述語を介さず、用途に合った比較関数を直接使うほうが、静的解析や性能の面で有利になることがあります。


## `=` は数値用（`NIL` に注意）

`=` 関数は、2 つ以上の数値が数値的に等しいかどうかを比較します。

~~~lisp
(= 2 2) ;; => T
(= 2 2.0 2 2) ;; => T
(= 2 4/2) ;; => T

(= 2 42) ;; => NIL
~~~

ただし、`=` は数値専用です。次の例は型エラーとなり、対話デバッガに入ります。ここでは SBCL のエラーメッセージ、コンディションの型、バックトレースを示します。

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

`SB-KERNEL::Y` は処理系内部の変数を指しています。プログラム中に `Y` という変数があるわけではありません。

したがって、数値の比較対象に `NIL` が含まれる可能性がある場合は、`equalp` を使う、変数を `(or … 0)` で包む、または事前に `(null …)` で確認する、といった方法が使えます。

<a id="eq--low-level-pointermemory-"></a>
<a id="eq--low-level-memory-"></a>

## `eq` はオブジェクトの同一性を判定する

> `(eq x y)` は、`x` と `y` が同一のオブジェクトである場合に限り真になります。

シンボルやキーワードの比較には `eq` を使います。

次の式はいずれも真になります。

~~~lisp
(eq :a :a)
(eq 'a 'a)
~~~

オブジェクトをそれ自身と比較すると、`eq` は真になります。

~~~lisp
(let ((x '(a . b)))
  (eq x x))
;; => T
~~~

数値や文字、およびリストや文字列などの複合オブジェクトを、値や内容に基づいて比較する目的では `eq` は使えません。動作するように見える場合もありますが、すべての処理系で真になることは規定されていません。

たとえば、ある処理系では数値に対する `eq` が真になっても、別の処理系では真にならないことがあります。

~~~lisp
(eq 2 2) ;; => T または NIL（規格では結果が保証されない）

;; 一方、大きな整数では次のようになることがある
(eq
  49827139472193749213749218734917239479213749127394871293749123
  49827139472193749213749218734917239479213749127394871293749123) ;; => 処理系によっては NIL
~~~

これは、数値を同一のオブジェクトとして表現するかどうかが処理系によって異なり、規格では定められていないためです。

同様に、次の結果も処理系に依存します。

~~~lisp
(eq '(a . b) '(a . b)) ;; T または NIL
(eq #\a #\a)           ;; T または NIL
~~~

実行時にそれぞれ別個に作られたリストや文字列は、内容が同じでも `eq` ではありません。

~~~lisp
(eq (list 'a) (list 'a)) ;; => NIL
(eq (copy-seq "a") (copy-seq "a")) ;; => NIL
~~~

この例では、内容が同じでも別々のオブジェクトが作られているため、`eq` は偽になります。


<a id="eql--number--character--eq-"></a>

## `eql` は、同じ型の数値と文字にも使える、より一般的な `eq`

> `eql` 述語は、引数同士が `eq` である場合、同じ型かつ同じ値の数値である場合、または同じ文字を表す文字オブジェクトである場合に真になります。

有用性の観点では、`eq` < `eql` と言えます。

次の数値比較は真になります。

~~~lisp
(eql 3 3) ;; => T
~~~

ただし、次の比較は偽になります。`3` と `3.0` の型が異なるためです（整数と単精度浮動小数点数）。

~~~lisp
(eql 3 3.0) ;; => NIL
~~~

複素数の場合は次のようになります。

~~~lisp
(eql #c(3 -4) #c(3 -4))       ;; => T
(eql #c(3 -4.0) #c(3 -4))     ;; => NIL（-4.0 と -4 の型が異なるため）
~~~

文字も比較できます。

~~~lisp
(eql #\A #\A) ;; => T
~~~

一方、リストやコンスセルの内容を比較することはできません。

~~~lisp
(eql (cons 'a 'b) (cons 'a 'b)) ;; => NIL
~~~

<a id="equal--string--printed-representation--object-"></a>

## `equal` は文字列やリストの構造も比較する

> `equal` 述語は、引数同士が構造的に同等（同型）である場合に真になります。大まかな目安としては、印字表現が同じオブジェクト同士は `equal` であると考えられます。

概念的には、`eq` < `eql` < `equal` と表せます。`eql` である 2 つのオブジェクトは、必ず `equal` でもあります。

ただし、型が異なる **数値** は、数値的に同じ値でも等価とは判定されません。

~~~lisp
(equal 3 3.0) ;; => NIL
~~~

一方、**リスト**やコンスセルは、その構造と要素を比較できます。別々に作られたオブジェクトでも構いません。

~~~lisp
(equal (cons 'a 'b) (cons 'a 'b)) ;; => T

(equal (list 'a) (list 'a)) ;; => T
~~~

**文字列**も比較できます。

~~~lisp
(equal "Foo" "Foo") ;; => T
~~~

別々のオブジェクトでも、内容が同じなら真になります。

~~~lisp
(equal "Foo" (copy-seq "Foo")) ;; => T
~~~

文字列の大文字と小文字は区別されます。

~~~lisp
(equal "FOO" "foo") ;; => NIL
~~~

構造体やハッシュテーブルなどのオブジェクトについては、同一のオブジェクト、つまり `eq` である場合に限り `equal` になります。`equal` は、その内部に格納された値を再帰的には比較しません。

詳しくは、末尾にリンクした Community Spec を参照してください。


<a id="equalp--string--case-number--numerical-value-"></a>

## `equalp` は文字列の大小を区別せず、数値を数値的に比較する

> 2 つのオブジェクトは、`equal` である場合、大文字と小文字などの属性を無視する `char-equal` で等しい文字である場合、型が異なっても数値的に同じ値を持つ場合、またはすべての構成要素が `equalp` である場合に `equalp` です。

順序を続けると、`eq` < `eql` < `equal` < `equalp` と言えます。
ただし、一般的には `equalp` より `equal` のほうが適切な場合が多いでしょう。

型が異なる **数値** でも、数値的な値を比較できます。

~~~lisp
(equalp 3 3.0) ;; => T
~~~

数値は、`=` で等しければ `equalp` でも等しくなります。

次の **文字列** の比較に注目してください。

~~~lisp
(equalp "FOO" "foo") ;; => T
~~~

`equalp` は文字列の大文字と小文字を区別しません。文字列は文字のシーケンスであり、`equalp` は文字の大小を無視する `char-equal` を使って、すべての構成要素を比較するからです。

`equalp` で **配列** を比較するときは、配列の要素型の違いが無視されます。そのため、文字列と文字のベクターが `equalp` になることがあります。

~~~lisp
(equalp "x" #(#\x)) ;; => T
~~~

一方、`equal` では偽になります。

~~~lisp
(equal "x" #(#\x)) ;; => NIL
~~~

**構造体**と**ハッシュテーブル**については、`equalp` は内部の要素も比較します。

たとえば、`serapeum:dict` という略記を使って 2 つのハッシュテーブルを作ります。

~~~lisp
(dict :a 1 :b 2)
(dict :b 2 :a 1)
~~~

これらを比較すると、`equalp` は真になります。

~~~lisp
(equalp * **)
;; => T
~~~

ただし、**equalp** は CLOS の**インスタンス**のスロットまでは比較しません。後述の節を参照してください。

詳しくは、末尾にリンクした Community Spec を参照してください。


<a id="function"></a>

## その他の比較関数

### `null`

関数 `null` は、引数が `NIL` なら真を返します。

~~~lisp
(null '()) ;; => T
~~~


### 多くの Common Lisp 標準関数は既定で `eql` を使う

これは、文字列を扱い始めた人がよく遭遇する問題です。Common Lisp の標準関数を使っても、期待した結果が得られないことがあります。

次の例を見てください。

~~~lisp
(find "foo" (list "test" "foo" "bar"))
;; NIL
~~~

このリストに文字列 `"foo"` が存在するか調べていますが、`NIL` が返ります。何が起きているのでしょうか。

`find` は、既定では各要素の比較に `eql` を使います。しかし、`eql` は文字列の内容を比較しません。文字列の内容を比較できる別の述語を指定する必要があります。

`find` などの関数は `:test` キーワード引数を受け取り、比較に使う述語を変更できます。

~~~lisp
(find "foo" (list "test" "foo" "bar") :test #'equal)
;; => "foo"
~~~

文字列の大文字と小文字を区別しない場合は、`equalp` も使えます。

~~~lisp
(find "FOO" (list "test" "foo" "bar") :test #'equalp)
;; => "foo"
~~~

これらの標準関数については、[データ構造](https://lispcookbook.github.io/cl-cookbook/data-structures.html)にも例があります。

### `char-equal`

文字を比較するための関数として `char-equal` があります。

> `char-equal` は、大文字と小文字、および文字の一部の属性を無視して比較します。


<a id="string--string-equal"></a>

### 文字列と `string-equal`

`string-equal` は文字列およびその一部分を比較します。比較する範囲の *start* と *end* を指定できます。文字の比較には `char-equal` を使うため、大文字と小文字は区別しません。また、文字列指定子としてシンボルも渡せます。

~~~lisp
(string-equal :foo "foo") ;; => T
(string-equal :foo "FOO") ;; => T
~~~

次はそのドキュメント文字列です。

```
STRING-EQUAL

This is a function in package COMMON-LISP

Signature
(string1 string2 &key (start1 0) end1 (start2 0) end2)

Given two strings (string1 and string2), and optional integers start1,
start2, end1 and end2, compares characters in string1 to characters in
string2 (using char-equal).
```

文字列の比較には、ほかにも `string=`、`string/=`、`string<`、`string>`、`string<=`、`string>=`、`string-equal`、`string-not-equal`、`string-lessp`、`string-greaterp`、`string-not-greaterp`、`string-not-lessp` があります。

詳しくは[文字列](https://lispcookbook.github.io/cl-cookbook/strings.html)を参照してください。

### `tree-equal` で木を比較する

> `tree-equal` は、`X` と `Y` が同じ葉を持つ同型の木である場合に `T` を返します。


<a id="function------function-"></a>

## 比較対象と使用する関数

```txt
比較対象                    使用する関数

オブジェクト／構造体        EQ

NIL                         EQ（ただし NULL のほうが簡潔で、おそらく低コスト）

T                           EQ（または値そのものを条件式として使う）

型も含めた数値              EQL

数値                        =

文字                        EQL または CHAR-EQUAL

リスト、コンス              EQ（同一のオブジェクトか調べる場合）
                            EQUAL（要素の内容を比較する場合）

配列                        EQ（同一のオブジェクトか調べる場合）
                            EQUALP（要素の内容を比較する場合）

文字列                      EQUAL（大文字と小文字を区別する）
                            EQUALP（大文字と小文字を区別しない）
                            STRING-EQUAL（シンボルも比較対象に含める場合）

木（リストのリスト）        TREE-EQUAL（適切な :TEST 引数を指定する）
```

<a id="object--built-in-function--object-oriented-"></a>

## 自作のオブジェクトを比較する

2 つの変数が同一のオブジェクトを指しているか確認するには、`eq` を使います。

自作のオブジェクトを独自の基準で比較したい場合もあります。たとえば、2 つの `person` オブジェクトについて、名前と姓が同じなら等価とみなす場合です。そのために Common Lisp の標準関数を特殊化することはできません。`person=` のような独自の関数を定義するか、ライブラリを使ってください（末尾のリンクを参照）。

これは制約ともいえますが、汎用的な比較関数ではなく、用途に特化した関数を使うことで性能上有利になる場合があります。

例として、CLOS チュートリアルの `person` クラスを使います。

```lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)))
```

同じ名前を持つ、別々の `person` オブジェクトを 2 つ作ります。

```lisp
(defparameter *p1* (make-instance 'person :name "me"))
(defparameter *p2-same-name* (make-instance 'person :name "me"))
```

オブジェクトの同一性は `eq` で比較できます。

~~~lisp
(eq *p1* *p1*) ;; => T
(eq *p1* *p2-same-name*) ;; => NIL
~~~

オブジェクトが等価となる条件を独自に定めるには、`person=` のようなメソッドを定義します。

~~~lisp
(defmethod person= (p1 p2)
  (string= (name p1) (name p2)))

(person= *p1* *p2-same-name*)  ;; => T
~~~

独自のオブジェクトにも `=` や `equal` を使いたい場合は、末尾で紹介しているライブラリを利用してください。

## オブジェクトの併合と `compile-file`

`(eql "a" "a")` の例に戻りましょう。REPL では、この式が `NIL` を返すことがあります。

これは、2 つの文字列リテラルが別々のオブジェクトとして読み込まれることがあるためです。

一方、コンパイラーはオブジェクトを併合することがあります。

`compile-file` でファイルをコンパイルすると、コンパイラーが複数の類似したリテラルを同一のオブジェクトとして扱う場合があります。たとえば、2 つの文字列リテラル `"a"` が併合される可能性があります。

その場合、同じ比較式が `T` を返す可能性があります。

したがって、比較対象に合った等価性述語を使う必要があります。

これは、`'(1 2 3)` のようなリテラルを破壊的に変更してはならない理由の一つでもあります。変更可能なリストが必要なら、`(list 1 2 3)` のように実行時に作成します。

なお、`compile` にはオブジェクトの併合が許されていません。


## 謝辞

- [CLtL2: Equality Predicates](http://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node74.html)
- 比較表: [Stack Overflow における Leslie P. Polzer の回答](https://stackoverflow.com/questions/547436/whats-the-difference-between-eq-eql-equal-and-equalp-in-common-lisp)

## 参照

- [CL Community Spec の `equal`](https://cl-community-spec.github.io/pages/equal.html)
- [CL Community Spec の `equalp`](https://cl-community-spec.github.io/pages/equalp.html)
- [equals](https://github.com/karlosz/equals/) - Common Lisp 向けの汎用的な等価性判定。
- [generic-cl](https://github.com/alex-gutev/generic-cl/) - Common Lisp 標準関数に対する総称関数インターフェイス。
  - 自作のオブジェクトに `=` や `<` を使えるようになります。
