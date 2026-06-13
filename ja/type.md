---
title: 型システム
---

Common Lisp には完全で柔軟な type system と、それに対応する type を調査・検査・操作する tools があります。custom types を作成し、variables や functions に type declarations を追加し、それによって compile-time warnings や errors を得られます。


## type を持つのは値であり、変数ではない

C/C++ のような一部の言語とは異なり、Lisp の変数は object[^1] のための *placeholders* にすぎません。変数に [`setf`][setf] すると、object がそこに「置かれ」ます。後で同じ変数に別の値を好きなように置けます。

これは、Common Lisp では **objects have types** であり、variables は type を持たない、という事実を意味します。C/C++ の背景から来た場合、最初は驚くかもしれません。

例:

~~~lisp
(defvar *var* 1234)
*VAR*

(type-of *var*)
(INTEGER 0 4611686018427387903)
~~~

関数 [`type-of`][type-of] は、与えられた object の type を返します。返される結果は [type-specifier][type-specifiers] です。この場合、最初の element が type で、残りはその type の追加情報（lower bound と upper bound）です。今のところ安全に無視できます。また、Lisp の integers には制限がないことも覚えておいてください。

では変数に [`setf`][setf] してみましょう。

~~~lisp
* (setf *var* "hello")
"hello"

* (type-of *var*)
(SIMPLE-ARRAY CHARACTER (5))
~~~

`type-of` が異なる結果を返すことが分かります。長さ 5 で内容の type が [`character`][character] の [`simple-array`][simple-array] です。これは、`*var*` が string `"hello"` に評価され、関数 `type-of` が実際には変数 `*var*` ではなく object `"hello"` の type を返すためです。

## 型階層

Lisp types の inheritance relationship は type graph から成り、すべての type の root は `T` です。例:

~~~lisp
* (describe 'integer)
COMMON-LISP:INTEGER
  [symbol]

INTEGER names the built-in-class #<BUILT-IN-CLASS COMMON-LISP:INTEGER>:
  Class precedence-list: INTEGER, RATIONAL, REAL, NUMBER, T
  Direct superclasses: RATIONAL
  Direct subclasses: FIXNUM, BIGNUM
  No direct slots.

INTEGER names a primitive type-specifier:
  Lambda-list: (&OPTIONAL (SB-KERNEL::LOW '*) (SB-KERNEL::HIGH '*))
~~~

関数 [`describe`][describe] は、symbol [`integer`][integer] が optional information として lower bound と upper bound を持つ primitive type-specifier であることを示します。同時に、これは built-in class でもあります。なぜでしょうか。

多くの Common Lisp types は CLOS classes として実装されています。一部の types は他の types の単なる "wrappers" です。各 CLOS class は対応する type に map されます。Lisp では、types は [`type specifiers`][type-specifiers] の使用によって間接的に参照されます。

関数 [`type-of`][type-of] と [`class-of`][class-of] にはいくつか違いがあります。`type-of` は与えられた object の type を type specifier format で返す一方、`class-of` は implementation details を返します。

~~~lisp
* (type-of 1234)
(INTEGER 0 4611686018427387903)

* (class-of 1234)
#<BUILT-IN-CLASS COMMON-LISP:FIXNUM>
~~~

## type の検査

関数 [`typep`][typep] は、第 1 引数が第 2 引数で指定された type であるかを検査するために使えます。

~~~lisp
* (typep 1234 'integer)
T
~~~

関数 [`subtypep`][subtypep] は、ある type が別の type を inherit しているかを調べるために使えます。2 つの値を返します。

- `T, T` は、第 1 引数が第 2 引数の sub-type であることを意味します。
- `NIL, T` は、第 1 引数が第 2 引数の sub-type *ではない* ことを意味します。
- `NIL, NIL` は「判定できない」ことを意味します。

例:

~~~lisp
* (subtypep 'integer 'number)
T
T

* (subtypep 'string 'number)
NIL
T
~~~

argument の type に応じて異なる action を行いたいことがあります。macro [`typecase`][typecase] が役に立ちます。

~~~lisp
* (defun plus1 (arg)
    (typecase arg
      (integer (+ arg 1))
      (string (concatenate 'string arg "1"))
      (t 'error)))
PLUS1

* (plus1 100)
101 (7 bits, #x65, #o145, #b1100101)

* (plus1 "hello")
"hello1"

* (plus1 'hello)
ERROR
~~~

## 型指定子

type specifier は type を指定する form です。上で述べたように、関数 `type-of` の return value と `typep` の第 2 引数はいずれも type specifiers です。

上で示したように、`(type-of 1234)` は `(INTEGER 0 4611686018427387903)` を返します。この種の type specifiers は compound type specifier と呼ばれます。これは、head が type を示す symbol である list です。残りの部分は補足情報です。

~~~lisp
* (typep #(1 2 3) '(vector number 3))
T
~~~

ここで type `vector` の補足情報は、それぞれ elements type と size です。

compound type specifier の残りの部分は `*` にできます。これは「何でも」を意味します。たとえば、type specifier `(vector number *)` は、任意個数の numbers から成る vector を表します。

~~~lisp
* (typep #(1 2 3) '(vector number *))
T
~~~

末尾の部分は省略でき、省略された elements は `*` として扱われます。

~~~lisp
* (typep #(1 2 3) '(vector number))
T

* (typep #(1 2 3) '(vector))
T
~~~

おそらく想像したとおり、上の type specifier は次のように短くできます。

~~~lisp
* (typep #(1 2 3) 'vector)
T
~~~

詳しくは [CLHS page][type-specifiers] を参照してください。

## 新しい type を定義する

macro [`deftype`][deftype] を使って新しい type-specifier を定義できます。

その argument list は、compound type specifier の残りの部分の elements への直接の mapping と理解できます。symbol type specifier を許すために、それらは optional として定義されます。

body は、与えられた argument がこの type かどうかを検査する macro であるべきです（[`defmacro`][defmacro] を参照）。

たとえば `member` を使って enum types を定義できます。

~~~lisp
(deftype fruit () '(member :apple :orange :pear))
~~~

ここで新しい data type を定義しましょう。その data type は最大 10 elements の array であるべきです。また、各 element は 10 未満の number であるべきです。例として次の code を見てください。

~~~lisp
* (defun small-number-array-p (thing)
    (and (arrayp thing)
      (<= (length thing) 10)
      (every #'numberp thing)
      (every (lambda (x) (< x 10)) thing)))

* (deftype small-number-array (&optional type)
    `(and (array ,type 1)
          (satisfies small-number-array-p)))

* (typep #(1 2 3 4) '(small-number-array number))
T

* (typep #(1 2 3 4) 'small-number-array)
T

* (typep #(1 2 3 4 100) 'small-number-array)
NIL

* (small-number-array-p '(1 2 3 4 5 6 7 8 9 0 1))
NIL
~~~

## 実行時の型検査

Common Lisp は macro [`check-type`][check-type] による run-time type checking をサポートしています。これは [`place`][place] と type specifier を arguments として受け取り、place の内容が与えられた type でない場合に [`type-error`][type-error] を signal します。

~~~lisp
* (defun plus1 (arg)
    (check-type arg number)
    (1+ arg))
PLUS1

* (plus1 1)
2 (2 bits, #x2, #o2, #b10)

* (plus1 "hello")
; Debugger entered on #<SIMPLE-TYPE-ERROR expected-type: NUMBER datum: "Hello">

The value of ARG is "Hello", which is not of type NUMBER.
   [Condition of type SIMPLE-TYPE-ERROR]
...
~~~


## コンパイル時の型検査

variables、function arguments などに対して、[`proclaim`][proclaim]、[`declaim`][declaim]（toplevel）、[`declare`][declare]（functions と macros の内部）を通じて type information を与えられます。

しかし、[CLOS section][clos] で紹介した `:type` slot と同様に、type declarations の効果は Lisp standard では undefined であり、implementation specific です。そのため、Lisp compiler が compile-time type checking を行う保証はありません。

とはいえ、それは可能です。そして SBCL は thorough type checking を行う処理系です。

まず、Lisp はすでに単純な type warnings を警告することを思い出しましょう。次の関数は誤って string と number を concatenate しようとしています。compile すると type warning が出ます。

~~~lisp
(defconstant +foo+ 3)
(defun bar ()
  (concatenate 'string "+" +foo+))
; caught WARNING:
;   Constant 3 conflicts with its asserted type SEQUENCE.
;   See also:
;     The SBCL Manual, Node "Handling of Types"
~~~

例は単純ですが、他の言語にはない能力をすでに示しており、development 中に実際に役立ちます ;)
では、さらに良くしていきます。


### 変数の型を宣言する

macro [`declaim`][declaim] を `type` declaration identifier とともに使います（他の identifiers は "ftype, inline, notinline, optimize…" です）。

global variable `*name*` が string であると宣言しましょう。REPL では次を任意の順序で入力できます。

~~~lisp
(declaim (type (string) *name*))
(defparameter *name* "book")
~~~

これを不正な type に設定しようとすると、ある処理系ではそのまま動くかもしれませんし、別の処理系では type error が出るかもしれません。

SBCL では `simple-type-error` が出ます。

~~~lisp
(setf *name* :me)
Value of :ME in (THE STRING :ME) is :ME, not a STRING.
   [Condition of type SIMPLE-TYPE-ERROR]
~~~

たとえば LispWorks と ECL では、warning や error なしで実行できます。

~~~lisp
(setf *name* :me)

*name*
:ME
~~~


custom types でも同じことができます。`list-of-strings` type を手早く宣言しましょう。

~~~lisp
(defun list-of-strings-p (list)
  "Return t if LIST is non nil and contains only strings."
  (and (consp list)
       (every #'stringp list)))

(deftype list-of-strings ()
  `(satisfies list-of-strings-p))
~~~

では `*all-names*` variables が string の list であると宣言しましょう。

~~~lisp
(declaim (type (list-of-strings) *all-names*))
;; そして不正な値で:
(defparameter *all-names* "")
;; まだ compile-time の時点で error を得ます:
Cannot set SYMBOL-VALUE of *ALL-NAMES* to "", not of type
(SATISFIES LIST-OF-STRINGS-P).
   [Condition of type SIMPLE-TYPE-ERROR]
~~~

### 型を合成する

type は合成できます。前の例に続けると:

~~~lisp
(declaim (type (or null list-of-strings) *all-names*))
~~~

### 関数の入力型と出力型を宣言する

再び `declaim` macro を使います。ただし単なる `type` ではなく `ftype (function …)` を使います。

~~~lisp
(declaim (ftype (function (fixnum) fixnum) add))
;;                         ^^input ^^output [optional]
(defun add (n)
  (+ n  1))
~~~

これにより compile time に良い type warnings が得られます。

関数を変更して、fixnum ではなく string を誤って返すようにすると、warning が出ます。

~~~lisp
(defun add (n)
  (format nil "~a" (+ n  1)))
; caught WARNING:
;   Derived type of ((GET-OUTPUT-STREAM-STRING STREAM)) is
;     (VALUES SIMPLE-STRING &OPTIONAL),
;   conflicting with the declared function return type
;     (VALUES FIXNUM &REST T).
~~~

`add` を別の関数の中で、string を期待する place に使うと warning が出ます。

~~~lisp
(defun bad-concat (n)
  (concatenate 'string (add n)))
; caught WARNING:
;   Derived type of (ADD N) is
;     (VALUES FIXNUM &REST T),
;   conflicting with its asserted type
;     SEQUENCE.
~~~

`add` を別の関数の中で使い、その関数が `add` の type と incompatible に見える argument types を宣言している場合も warning が出ます。

~~~lisp
(declaim (ftype (function (string)) bad-arg))
(defun bad-arg (n)
    (add n))
; caught WARNING:
;   Derived type of N is
;     (VALUES STRING &OPTIONAL),
;   conflicting with its asserted type
;     FIXNUM.
~~~

これはすべて実際に *compile time* に起こります。REPL でも、Slime の単純な `C-c C-c` でも、file を `load` するときでも同じです。

### &key parameters の宣言

`&key (:argument type)` を使います。

例:

    (declaim (ftype (function (string &key (:n integer))) foo))
    (defun foo (bar &key n) …)

### &rest parameters の宣言

これはやや分かりにくく、適切な場所に置いた `declare` が必要かもしれません。

以下では fruit type を宣言し、single fruit argument を使う関数を書きます。そのため `placing-order` を compile すると期待どおり type warning が出ます。

~~~lisp
(deftype fruit () '(member :apple :orange :pear))

(declaim (ftype (function (fruit)) one-order))
(defun one-order (fruit)
  (format t "Ordering ~S~%" fruit))

(defun placing-order ()
  (one-order :bacon))
~~~

しかしこの version では `&rest` parameters を使っており、type warning は出なくなります。

~~~lisp
(declaim (ftype (function (&rest fruit)) place-order))
(defun place-order (&rest selections)
  (dolist (s selections)
    (format t "Ordering ~S~%" s)))

(defun placing-orders ()
  (place-order :orange :apple :bacon)) ;; => type warning なし
~~~

declaration は正しいのですが、compiler はそれを check しません。適切な場所に置いた `declare` により compile-time warning が戻ります。

~~~lisp
(defun place-order (&rest selections)
  (dolist (s selections)
    (declare (type fruit s))      ;; <= declare
    (format t "Ordering ~S~%" s)))

(defun placing-orders ()
  (place-order :orange :apple :bacon))
~~~

=>

```
The value
  :BACON
is not of type
  (MEMBER :PEAR :ORANGE :APPLE)
```

portable code では、`assert` による run-time checks を追加するでしょう。


### class slot の型を宣言する

class slot は `:type` slot option を受け取ります。しかし一般には、initform の type を check するためには *使われません*。2019 年 11 月に release された [version 1.5.9][sbcl159] 以降の SBCL は、これらの warning を出すようになりました。つまり次の code は:

~~~lisp
(defclass foo ()
  ((name :type number :initform "17")))
~~~

compile time に warning を signal します。


Note: `make-instance` 中に slots の types を check する（compile time ではありません）data serialization/contract library である [sanity-clause][sanity-clause] も参照してください。


### 代替の type checking syntax: defstar, serapeum

[Serapeum](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#types) library は、次のような shortcut を提供します。

```lisp
 (-> mod-fixnum+ (fixnum fixnum) fixnum)
 (defun mod-fixnum+ (x y) ...)
```

[Defstar](https://github.com/lisp-mirror/defstar) library は、lambda list に type declarations を追加できる `defun*` macro を提供します。次のように見えます。

```lisp
(defun* sum ((a real) (b real))
   (+ a b))
```

さらに次も可能です。

* return type を関数定義または body 内で宣言する
* `_` placeholder により ignored variables を素早く宣言する
* 各 argument に assertions を追加する
* `defmethod`、`defparameter`、`defvar`、`flet`、`labels`、`let*`、`lambda` でも同じことを行う


### 制限

`satisfies` を含む complex types は、デフォルトでは関数 body の内部では check されず、boundary でだけ check されます。多くのことはしてくれますが、SBCL は statically typed language ほど多くは行いません。

integer を string で誤って increment する次の例を考えてください。

~~~lisp
(declaim (ftype (function () string) bad-adder))
(defun bad-adder ()
  (let ((res 10))
    (loop for name in '("alice")
       do (incf res name))  ;; <= bad
    (format nil "finally doing sth with ~a" res)))
~~~

この関数を compile しても type warning は signal されません。

しかし、問題のある行が関数の boundary にあれば warning が出ます。

~~~lisp
(defun bad-adder ()
  (let ((res 10))
    (loop for name in  '("alice")
       return (incf res name))))
; in: DEFUN BAD-ADDER
;     (SB-INT:NAMED-LAMBDA BAD-ADDER
;         NIL
;       (BLOCK BAD-ADDER
;         (LET ((RES 10))
;           (LOOP FOR NAME IN *ALL-NAMES* RETURN (INCF RES NAME)))))
;
; caught WARNING:
;   Derived type of ("a hairy form" NIL (SETQ RES (+ NAME RES))) is
;     (VALUES (OR NULL NUMBER) &OPTIONAL),
;   conflicting with the declared function return type
;     (VALUES STRING &REST T).
~~~

loop body 内で `the` declaration を使って compile-time warning を得ることもできます。

```lisp
       do (incf res (the string name)))
```

何を結論とできるでしょうか。これは code を小さな関数に分解するもう 1 つの理由です。


## 参考

- Martin Cracauer による記事 [Static type checking in SBCL](https://medium.com/@MartinCracauer/static-type-checking-in-the-programmable-programming-language-lisp-79bb79eb068a)
- 記事 [Typed List, a Primer](https://alhassy.github.io/TypedLisp) - Haskell との浅い比較をしながら、Lisp の fine-grained type hierarchy を探索します。
- [Coalton](https://github.com/coalton-lang/coalton/) library: Common Lisp を強化する、効率的で statically typed な functional programming language。これは Lisp に埋め込まれた DSL で、Haskell や Standard ML に似ていますが、non-statically-typed Lisp code と seamless に相互運用できます（逆も同様）。
- enum types と union types（ecase-of、etypecase-of）のための [Serapeum](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#ecase-of-type-x-body-body) による [compile-time の exhaustiveness type checking](https://dev.to/vindarel/compile-time-exhaustiveness-checking-in-common-lisp-with-serapeum-5c5i)。

---

[^1]: ここでの *object* という用語は Object-Oriented などとは関係ありません。「任意の Lisp datum」を意味します。

[defvar]: http://www.lispworks.com/documentation/lw51/CLHS/Body/m_defpar.htm
[setf]: http://www.lispworks.com/documentation/lw50/CLHS/Body/m_setf_.htm
[type-of]: http://www.lispworks.com/documentation/HyperSpec/Body/f_tp_of.htm
[type-specifiers]: http://www.lispworks.com/documentation/lw51/CLHS/Body/04_bc.htm
[number]: http://www.lispworks.com/documentation/lw61/CLHS/Body/t_number.htm
[typep]: http://www.lispworks.com/documentation/lw51/CLHS/Body/f_typep.htm
[subtypep]: http://www.lispworks.com/documentation/lw71/CLHS/Body/f_subtpp.htm
[string]: http://www.lispworks.com/documentation/lw71/LW/html/lw-426.htm
[simple-array]: http://www.lispworks.com/documentation/lw70/CLHS/Body/t_smp_ar.htm
[integer]: http://www.lispworks.com/documentation/lw71/CLHS/Body/t_intege.htm
[describe]: http://www.lispworks.com/documentation/lw51/CLHS/Body/f_descri.htm
[clos]: clos.html
[character]: http://www.lispworks.com/documentation/lcl50/ics/ics-14.html
[number]: http://www.lispworks.com/documentation/lw61/CLHS/Body/t_number.htm
[complex]: http://www.lispworks.com/documentation/lw70/CLHS/Body/t_comple.htm
[real]: http://www.lispworks.com/documentation/lw70/CLHS/Body/t_real.htm
[rational]: http://www.lispworks.com/documentation/HyperSpec/Body/t_ration.htm
[class-of]: http://www.lispworks.com/documentation/HyperSpec/Body/f_clas_1.htm
[typecase]: http://www.lispworks.com/documentation/lw60/CLHS/Body/m_tpcase.htm
[deftype]: http://www.lispworks.com/documentation/lw51/CLHS/Body/m_deftp.htm
[defmacro]: http://www.lispworks.com/documentation/lw70/CLHS/Body/m_defmac.htm
[check-type]: http://www.lispworks.com/documentation/HyperSpec/Body/m_check_.htm#check-type
[type-error]: http://www.lispworks.com/documentation/HyperSpec/Body/e_tp_err.htm#type-error
[place]: http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_p.htm#place
[proclaim]: http://www.lispworks.com/documentation/HyperSpec/Body/f_procla.htm
[declaim]: http://www.lispworks.com/documentation/HyperSpec/Body/m_declai.htm
[declare]: http://www.lispworks.com/documentation/HyperSpec/Body/s_declar.htm
[safety]: http://www.lispworks.com/documentation/HyperSpec/Body/d_optimi.htm#speed
[sbcl159]: http://www.sbcl.org/all-news.html#1.5.9
[sanity-clause]: https://github.com/fisxoj/sanity-clause
