---
title: CLOS の基礎
---


CLOS は "Common Lisp Object System" の略で、どの言語でも利用できるオブジェクトシステムの中でも、おそらく最も強力なものの 1 つです。

その機能には次のようなものがあります。

* **動的**であり、Lisp REPL で扱うのが楽しくなります。たとえば、クラス定義を変更すると、こちらで制御できる一定の規則に従って既存のオブジェクトが更新されます。
* **multiple dispatch** と **multiple inheritance** をサポートします。
* クラス定義とメソッド定義が結び付いていない点で、多くのオブジェクトシステムとは異なります。
* 優れた **introspection** 機能を持ちます。
* **meta-object protocol** によって提供されます。これは CLOS への標準インターフェイスを提供し、新しいオブジェクトシステムを作るためにも使えます。

この名前に属する機能は、1984 年の Steele による "Common Lisp, the Language" 初版の出版から、その 10 年後に ANSI 標準として言語が正式化されるまでの間に Common Lisp 言語へ追加されました。

このページは CLOS の使い方を十分に理解できるようにすることを目指しますが、MOP については簡単な導入にとどめます。

これらの主題を深く学ぶには、次の 2 冊が必要です。

- [Object-Oriented Programming in Common Lisp: a Programmer's Guide to CLOS](http://www.communitypicks.com/r/lisp/s/17592186046723-object-oriented-programming-in-common-lisp-a-programmer), by Sonya Keene,
- [the Art of the Metaobject Protocol](http://www.communitypicks.com/r/lisp/s/17592186045709-the-art-of-the-metaobject-protocol), by Gregor Kiczales, Jim des Rivières et al.

あわせて次も参照してください。

- Peter Seibel による [Practical Common Lisp](http://www.gigamonkeys.com/book/object-reorientation-generic-functions.html) (online) の導入。
-  [Common Lisp, the Language](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node260.html#SECTION003200000000000000000)
- リファレンスとして、完全な [CLOS-MOP specifications](https://clos-mop.hexstreamsoft.com/)。


##  クラスとインスタンス

### まず試す

クラス定義、オブジェクト作成、スロットアクセス、特定クラスに特殊化したメソッド、継承を示す例から始めましょう。

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)))

;; => #<STANDARD-CLASS PERSON>

(defvar p1 (make-instance 'person :name "me" ))
;;                                 ^^^^ initarg
;; => #<PERSON {1006234593}>

(name p1)
;;^^^ accessor
;; => "me"

(lisper p1)
;; => nil
;;    ^^ initform (slot unbound by default)

(setf (lisper p1) t)


(defclass child (person)
  ())

(defclass child (person)
  ((can-walk-p
     :accessor can-walk-p
     :initform t)))
;; #<STANDARD-CLASS CHILD>

(can-walk-p (make-instance 'child))
;; T
~~~

### クラスの定義 (defclass)

CLOS で新しいデータ型を定義するために使うマクロは `defclass` です。

先ほどは次のように使いました。

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)))
~~~

これにより、`person` という CLOS 型 (またはクラス) と、`name` および `lisper` という 2 つのスロットが得られます。

~~~lisp
(class-of p1)
#<STANDARD-CLASS PERSON>

(type-of p1)
PERSON
~~~

`defclass` の一般形は次のとおりです。

```
(defclass <class-name> (list of super classes)
  ((slot-1
     :slot-option slot-argument)
   (slot-2, etc))
  (:optional-class-option
   :another-optional-class-option))
```

つまり、私たちの `person` クラスは別のクラスを明示的には継承していません (空の括弧 `()` を受け取っています)。
しかし、それでもデフォルトでクラス `t` と `standard-object` から継承しています。
下の「継承」を参照してください。

スロットオプションなしの最小限のクラス定義は次のように書けます。

~~~lisp
(defclass point ()
  (x y z))
~~~

あるいはスロット指定子すらなく、`(defclass point () ())` と書くこともできます。

### オブジェクトの作成 (make-instance)

クラスのインスタンスは `make-instance` で作成します。

~~~lisp
(defvar p1 (make-instance 'person :name "me" ))
~~~

一般に、コンストラクタを定義するのはよい習慣です。

~~~lisp
(defun make-person (name &key lisper)
  (make-instance 'person :name name :lisper lisper))
~~~

これには、必要な引数を制御できるという直接的な利点があります。
この時点では、クラス自体ではなく、コンストラクタをパッケージから export すべきです。

### スロット

#### 常に使える関数 (slot-value)

任意のスロットへいつでもアクセスするための関数は `(slot-value <object> <slot-name>)` です。

上の `point` クラスはスロットアクセサを定義していませんでした。


```lisp
(defvar pt (make-instance 'point))

(inspect pt)
The object is a STANDARD-OBJECT of type POINT.
0. X: "unbound"
1. Y: "unbound"
2. Z: "unbound"
```

型 `POINT` のオブジェクトは得られましたが、**スロットはデフォルトでは unbound** です。
アクセスしようとすると `UNBOUND-SLOT` コンディションが発生します。

~~~lisp
(slot-value pt 'x) ;; => condition: the slot is unbound
~~~


`slot-value` は `setf` できます。

~~~lisp
(setf (slot-value pt 'x) 1)
(slot-value pt 'x) ;; => 1
~~~

#### 初期値とデフォルト値 (initarg, initform)

- `:initarg :foo` は、このスロットに値を与えるために `make-instance` へ渡せるキーワードです。

~~~lisp
(make-instance 'person :name "me")
~~~

(繰り返しますが、スロットはデフォルトでは unbound です)

- `:initform <val>` は、initarg を指定しなかった場合の *デフォルト値* です。
  このフォームは、必要になるたびに `defclass` のレキシカル環境で評価されます。

スロットを明確に必須にするため、次のようなテクニックを見ることがあります。

~~~lisp
(defclass foo ()
    ((a
      :initarg :a
      :initform (error "you didn't supply an initial value for slot a"))))
;; #<STANDARD-CLASS FOO>

(make-instance 'foo) ;; => enters the debugger.
~~~


#### getter と setter (accessor, reader, writer)

- `:accessor foo`: accessor は **getter** であり **setter** でもあります。
  その引数は **generic function** になる名前です。

~~~lisp
(name p1) ;; => "me"

(type-of #'name)
STANDARD-GENERIC-FUNCTION
~~~

- `:reader` と `:writer` は期待どおりのことをします。`setf` できるのは `:writer` だけです。

これらのどれも指定しなくても、`slot-value` は使えます。

1 つのスロットに複数の `:accessor`、`:reader`、`:initarg` を与えることもできます。


状況によってスロットへのアクセスを短く書くため、2 つのマクロを紹介します。

1- `with-slots` は、複数の slot-value 呼び出しを短く書けるようにします。
第 1 引数はスロット名のリストです。
第 2 引数は CLOS インスタンスへ評価されます。
その後に省略可能な宣言と暗黙の `progn` が続きます。
本体の評価中、レキシカルには、これらの名前を変数として参照することは、対応するインスタンスのスロットを `slot-value` で参照することと同じです。


~~~lisp
(with-slots (name lisper)
    c1
  (format t "got ~a, ~a~&" name lisper))
~~~

または

~~~lisp
(with-slots ((n name)
             (l lisper))
    c1
  (format t "got ~a, ~a~&" n l))
~~~

2- `with-accessors` も同様ですが、スロットのリストではなく accessor 関数のリストを取ります。
マクロ内で変数を参照すると、accessor 関数の呼び出しと同じになります。

~~~lisp
(with-accessors ((name        name)
                  ^^variable  ^^accessor
                 (lisper lisper))
            p1
          (format t "name: ~a, lisper: ~a" name lisper))
~~~

#### クラススロットとインスタンススロット

`:allocation` は、このスロットが *local* か *shared* かを指定します。

* スロットはデフォルトで *local* です。つまり、クラスのインスタンスごとに異なる値を持てます。この場合、`:allocation` は `:instance` です。

* *shared* スロットは、そのクラスのすべてのインスタンスで常に同じ値になります。これは `:allocation :class` で設定します。

次の例では、`p2` のクラススロット `species` の値を変更すると、そのクラスのすべてのインスタンス (それらがすでに存在しているかどうかにかかわらず) に影響することに注目してください。

~~~lisp
(defclass person ()
  ((name :initarg :name :accessor name)
   (species
      :initform 'homo-sapiens
      :accessor species
      :allocation :class)))

;; 既存のインスタンスからスロット "lisper" が削除されたことに注意。
(inspect p1)
;; The object is a STANDARD-OBJECT of type PERSON.
;; 0. NAME: "me"
;; 1. SPECIES: HOMO-SAPIENS
;; > q

(defvar p2 (make-instance 'person))

(species p1)
(species p2)
;; HOMO-SAPIENS

(setf (species p2) 'homo-numericus)
;; HOMO-NUMERICUS

(species p1)
;; HOMO-NUMERICUS

(species (make-instance 'person))
;; HOMO-NUMERICUS

(let ((temp (make-instance 'person)))
    (setf (species temp) 'homo-lisper))
;; HOMO-LISPER
(species (make-instance 'person))
;; HOMO-LISPER
~~~

#### スロットのドキュメント

各スロットは `:documentation` オプションを 1 つ受け取れます。
`documentation` でそのドキュメントを取得するには、スロットオブジェクトを取得する必要があります。
これは [closer-mop](https://github.com/pcostanza/closer-mop) のようなライブラリを使うと移植性のある形で行えます。例:

~~~lisp
(closer-mop:class-direct-slots (find-class 'my-class))
;; => スロット (オブジェクト) のリスト
(find 'my-slot * :key #'closer-mop:slot-definition-name)
;; => 目的のスロットを名前で探す
(documentation * t) ; そのドキュメントを取得する
~~~

ただし一般には、スロットではなくスロット accessor をドキュメント化するほうがよいかもしれません。
スロットは実装詳細であり、公開インターフェイスの一部ではない、という見方が広くあります。

#### スロット型

`:type` スロットオプションは、期待どおりの仕事をしないかもしれません。
CLOS に慣れていないなら、このセクションは飛ばし、自分のコンストラクタで手動でスロット型をチェックすることをおすすめします。

実際、スロット型がチェックされるかどうかは未定義です。[Hyperspec](http://www.lispworks.com/documentation/HyperSpec/Body/m_defcla.htm#defclass) を参照してください。

これを行う実装は少数です。Clozure CL は行います。SBCL はバージョン 1.5.9 (2019 年 11 月) 以降、または safety が高い場合 (`(declaim (optimise safety))`) に行います。

別の方法で行うには、[this Stack-Overflow answer](https://stackoverflow.com/questions/51723992/how-to-force-slots-type-to-be-checked-during-make-instance) を参照してください。また、契約プログラミングライブラリ [quid-pro-quo](https://github.com/sellout/quid-pro-quo) も参照してください。


### find-class, class-name, class-of

~~~lisp
(find-class 'point)
;; #<STANDARD-CLASS POINT 275B78DC>

(class-name (find-class 'point))
;; POINT

(class-of my-point)
;; #<STANDARD-CLASS POINT 275B78DC>

(typep my-point (class-of my-point))
;; T
~~~

CLOS クラスもまた CLOS クラスのインスタンスであり、下の例のように、そのクラスが何かを調べられます。

~~~lisp
(class-of (class-of my-point))
;; #<STANDARD-CLASS STANDARD-CLASS 20306534>
~~~

<u>Note</u>: これは MOP への最初の導入です。始めるだけなら必要ありません!

オブジェクト `my-point` は `point` という名前のクラスのインスタンスであり、`point` という名前のクラス自体は `standard-class` という名前のクラスのインスタンスです。
`standard-class` という名前のクラスは、`my-point` の *metaclass* (つまりクラスのクラス) であると言います。
後で見るように、metaclass はうまく活用できます。



### サブクラスと継承

上で示したように、`child` は `person` のサブクラスです。

すべてのオブジェクトはクラス `standard-object` と `t` から継承します。

すべての child インスタンスは `person` のインスタンスでもあります。

~~~lisp
(type-of c1)
;; CHILD

(subtypep (type-of c1) 'person)
;; T

(ql:quickload "closer-mop")
;; ...

(closer-mop:subclassp (class-of c1) 'person)
;; T
~~~

[closer-mop](https://github.com/pcostanza/closer-mop) ライブラリは、CLOS/MOP 操作を行うための移植性のある定番の方法です。


サブクラスは親のすべてのスロットを継承し、そのスロットオプションを上書きできます。
Common Lisp はこのプロセスを動的にしており、REPL セッションに適しています。
さらに、その一部を制御することもできます (特定のスロットが削除、更新、追加されたときに何かをする、など)。

したがって、`child` の **class precedence list** は次のようになります。

    child <- person <-- standard-object <- t

これは次で取得できます。

~~~lisp
(closer-mop:class-precedence-list (class-of c1))
;; (#<standard-class child>
;;  #<standard-class person>
;;  #<standard-class standard-object>
;;  #<sb-pcl::slot-class sb-pcl::slot-object>
;;  #<sb-pcl:system-class t>)
~~~

しかし、`child` の **direct superclass** は次だけです。

~~~lisp
(closer-mop:class-direct-superclasses (class-of c1))
;; (#<standard-class person>)
~~~

さらに `class-direct-[subclasses, slots, default-initargs]` や多くの関数でクラスを調べられます。

スロットの結合にはいくつかの規則があります。

- `:accessor` と `:reader` は、継承したすべてのスロットからの accessor と reader の **union** によって結合されます。

- `:initarg`: 継承したすべてのスロットからの初期化引数の **union** です。

- `:initform`: **最も特定的な** デフォルト初期値フォーム、つまり precedence list 内でそのスロットに対して最初に現れる `:initform` が得られます。

- `:allocation` は継承されません。定義中のクラスだけで制御され、デフォルトは `:instance` です。


最後に重要な注意として、継承はかなり誤用しやすく、多重継承ではその危険がさらに増えます。少し注意してください。
`foo` が本当に `bar` を継承したいのか、それとも `foo` のインスタンスが `bar` を含むスロットを持ちたいのかを自問してください。
一般的な指針として、`foo` と `bar` が「同じ種類のもの」なら継承で混ぜるのは正しいですが、本当に別々の概念なら、スロットを使って分けておくべきです。


### 多重継承

CLOS は多重継承をサポートします。


~~~lisp
(defclass baby (child person)
  ())
~~~

親クラスのリストで最初にあるクラスが最も特定的です。
`child` のスロットは `person` のスロットより優先されます。
この例では、`baby` を定義する前に `child` と `person` の両方が定義されている必要があることに注意してください。


### クラスの再定義と変更

このセクションでは 2 つの話題を簡単に扱います。

- 既存クラスの再定義。これはコード例を追っている間にすでに行ったかもしれず、開発中には自然に行うことです。
- あるクラスのインスタンスを別のクラスのインスタンスに変えること。CLOS の強力な機能ですが、あまり頻繁には使わないでしょう。

詳細は軽く流します。MOP が公開するメソッドを実装することで、すべて設定可能だと言えば十分です。

クラスを再定義するには、新しい `defclass` フォームを評価するだけです。
それが古い定義の代わりになり、既存のクラスオブジェクトが更新され、**そのクラスのすべてのインスタンス** (および再帰的にそのサブクラス) は **新しい定義を反映するよう遅延更新されます**。
新しい `defclass` 以外を再コンパイルする必要も、オブジェクトを無効化する必要もありません。少し考えてみてください。これはすごいことです!

たとえば、私たちの `person` クラスでは:

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)))

(setf p1 (make-instance 'person :name "me" ))
~~~

スロットの変更、追加、削除...

~~~lisp
(lisper p1)
;; NIL

(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform t        ;; <-- from nil to t
    :accessor lisper)))

(lisper p1)
;; NIL (of course!)

(lisper (make-instance 'person :name "You"))
;; T

(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)
   (age               ;; <-- new slot
    :initarg :arg
    :initform 18      ;; <-- default value
    :accessor age)))

(age p1)
;; => 18。正しい。この新しいスロットのデフォルト initform。

(slot-value p1 'bwarf)
;; => "the slot bwarf is missing from the object #<person…>"

(setf (age p1) 30)
(age p1) ;; => 30

(defclass person ()
  ((name
    :initarg :name
    :accessor name)))

(slot-value p1 'lisper) ;; => slot lisper is missing.
(lisper p1) ;; => there is no applicable method for the generic function lisper when called with arguments #(lisper).
~~~


インスタンスのクラスを変更するには `change-class` を使います。

~~~lisp
(change-class p1 'child)
;; 新しいクラスのスロットも設定できる:
(change-class p1 'child :can-walk-p nil)

(class-of p1)
;; #<STANDARD-CLASS CHILD>

(can-walk-p p1)
;; T
~~~

上の例では、私は `child` になり、デフォルトで true である `can-walk-p` スロットを継承しました。


### Pretty printing

ここまでオブジェクトを表示するたびに、次のような出力が得られました。

    #<PERSON {1006234593}>

これでは多くを語っていません。

もっと情報を表示したい場合はどうでしょうか。たとえば:

    #<PERSON me lisper: t>

Pretty printing は、このクラス向けに generic `print-object` メソッドを特殊化することで行います。

~~~lisp
(defmethod print-object ((obj person) stream)
      (print-unreadable-object (obj stream :type t)
        (with-accessors ((name name)
                         (lisper lisper))
            obj
          (format stream "~a, lisper: ~a" name lisper))))
~~~

これは次を返します。

~~~lisp
p1
;; #<PERSON me, lisper: T>
~~~

`print-unreadable-object` は `#<...>` を出力します。これは、このオブジェクトを reader が読み戻せないことを示します。
`:type t` 引数は、オブジェクト型のプレフィックス、つまり `PERSON` を出力するよう求めます。
これがないと `#<me, lisper: T>` になります。

ここでは `with-accessors` マクロを使いましたが、単純な場合はもちろん次で十分です。

~~~lisp
(defmethod print-object ((obj person) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~a, lisper: ~a" (name obj) (lisper obj))))
~~~

注意: デフォルトで束縛されていないスロットにアクセスしようとするとエラーになります。`slot-boundp` を使ってください。


参考までに、次はデフォルトの挙動を再現します。

~~~lisp
(defmethod print-object ((obj person) stream)
  (print-unreadable-object (obj stream :type t :identity t)))
~~~

ここで `:identity` を `t` にすると `{1006234593}` というアドレスが出力されます。

### 伝統的な Lisp 型のクラス

ここでは、CLOS を使うために CLOS オブジェクトが必要なわけではない、という点に近づきます。

ありがたいことに、前のセクションで紹介した関数は、CLOS インスタンス<u>ではない</u> Lisp オブジェクトにも使えます。

~~~lisp
(find-class 'symbol)
;; #<BUILT-IN-CLASS SYMBOL>
(class-name *)
;; SYMBOL
(eq ** (class-of 'symbol))
;; T
(class-of ***)
;; #<STANDARD-CLASS BUILT-IN-CLASS>
~~~

ここで、シンボルはシステムクラス `symbol` のインスタンスであることがわかります。
これは、対応する Lisp 型と同じ名前のクラスが存在することを言語が要求する 75 個のケースの 1 つです。
これらの多くは CLOS 自体 (たとえば型 `standard-class` と同名の CLOS クラスの対応) またはコンディション system (実装によって CLOS クラスで構築されているかもしれないし、そうでないかもしれないもの) に関係しています。
しかし、「伝統的な」Lisp 型に関係する対応が 33 個残っています。

<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
}
th {
  text-align: left;
}
</style>

<table>
  <tbody>
    <tr>
      <td>array</td>
      <td>hash-table</td>
      <td>readtable</td>
    </tr>
    <tr>
      <td>bit-vector</td>
      <td>integer</td>
      <td>real</td>
    </tr>
    <tr>
      <td>broadcast-stream</td>
      <td>list</td>
      <td>sequence</td>
    </tr>
    <tr>
      <td>character</td>
      <td>logical-pathname</td>
      <td>stream</td>
    </tr>
    <tr>
      <td>complex</td>
      <td>null</td>
      <td>string</td>
    </tr>
    <tr>
      <td>concatenated-stream</td>
      <td>number</td>
      <td>string-stream</td>
    </tr>
    <tr>
      <td>cons</td>
      <td>package</td>
      <td>symbol</td>
    </tr>
    <tr>
      <td>echo-stream</td>
      <td>pathname</td>
      <td>synonym-stream</td>
    </tr>
    <tr>
      <td>file-stream</td>
      <td>random-state</td>
      <td>t</td>
    </tr>
    <tr>
      <td>float</td>
      <td>ratio</td>
      <td>two-way-stream</td>
    </tr>
    <tr>
      <td>function</td>
      <td>rational</td>
      <td>vector</td>
    </tr>
  </tbody>
</table>
<!-- epub-exclude-start -->
<br>
<!-- epub-exclude-end -->

すべての「伝統的な」Lisp 型がこのリストに含まれるわけではないことに注意してください。
(`atom`、`fixnum`、`short-float`、およびシンボルで表されない型を考えてみてください。)


`t` が存在するのは興味深いことです。
すべての Lisp オブジェクトが型 `t` であるのと同じように、すべての Lisp オブジェクトは `t` という名前のクラスのメンバーでもあります。
これは同時に複数のクラスに属する単純な例であり、後である程度詳しく考える *inheritance* の問題を持ち出します。

~~~lisp
(find-class t)
;; #<BUILT-IN-CLASS T 20305AEC>
~~~

Lisp 型に対応するクラスに加えて、定義したすべての structure 型にも CLOS クラスがあります。

~~~lisp
(defstruct foo)
FOO

(class-of (make-foo))
;; #<STRUCTURE-CLASS FOO 21DE8714>
~~~

`structure-object` の metaclass はクラス `structure-class` です。
「伝統的な」Lisp オブジェクトの metaclass が `standard-class`、`structure-class`、`built-in-class` のどれであるかは実装依存です。
制約:

`built-in-class`: `make-instance` を使えず、`slot-value` を使えず、`defclass` で変更できず、サブクラスを作成できません。

`structure-class`: `make-instance` は使えません。`slot-value` は動くかもしれません (実装依存)。アプリケーションの structure 型をサブクラス化するには `defstruct` を使います。既存の `structure-class` を変更した結果は未定義です。完全な再コンパイルが必要になるかもしれません。

`standard-class`: これらの制約はありません。

### イントロスペクション

いくつかのイントロスペクション関数はすでに見ました。

最善の選択肢は、[closer-mop](https://github.com/pcostanza/closer-mop) ライブラリを知り、[CLOS & MOP specifications](https://clos-mop.hexstreamsoft.com/) を手元に置いておくことです。

さらに多くの関数:

```
closer-mop:class-default-initargs
closer-mop:class-direct-default-initargs
closer-mop:class-direct-slots
closer-mop:class-direct-subclasses
closer-mop:class-direct-superclasses
closer-mop:class-precedence-list
closer-mop:class-slots
closer-mop:classp
closer-mop:extract-lambda-list
closer-mop:extract-specializer-names
closer-mop:generic-function-argument-precedence-order
closer-mop:generic-function-declarations
closer-mop:generic-function-lambda-list
closer-mop:generic-function-method-class
closer-mop:generic-function-method-combination
closer-mop:generic-function-methods
closer-mop:generic-function-name
closer-mop:method-combination
closer-mop:method-function
closer-mop:method-generic-function
closer-mop:method-lambda-list
closer-mop:method-specializers
closer-mop:slot-definition
closer-mop:slot-definition-allocation
closer-mop:slot-definition-initargs
closer-mop:slot-definition-initform
closer-mop:slot-definition-initfunction
closer-mop:slot-definition-location
closer-mop:slot-definition-name
closer-mop:slot-definition-readers
closer-mop:slot-definition-type
closer-mop:slot-definition-writers
closer-mop:specializer-direct-generic-functions
closer-mop:specializer-direct-methods
closer-mop:standard-accessor-method
```


### 参考

#### Slime によるクラスシンボルの export

コマンド **M-x slime-export-class** は、クラスシンボルをパッケージ定義の ":export" 節に追加します。
これにより、多数のシンボルを一度に export できます。

次のクラスがあるとします。

~~~lisp
(defclass test ()
  ((foo :accessor foo)
   (bar :reader bar)))
~~~

"M-x slime-export-class RET test RET" を使うと、"test"、"foot"、"bar" が export されます。

残念ながら、クラス定義からスロットを削除しても export 節からは削除されません。

これは structure でも動作します (SBCL と Clozure CL のみ)。


#### defclass/std: クラスを短く書く

[defclass/std](https://github.com/EuAndreh/defclass-std) ライブラリは、より短い `defclass` フォームを書くためのマクロを提供します。

デフォルトでは、スロット定義に accessor、initarg、`nil` への initform を追加します。

これは:

~~~lisp
(defclass/std example ()
  ((slot1 slot2 slot3)))
~~~

次へ展開されます。

~~~lisp
(defclass example ()
  ((slot1
    :accessor slot1
    :initarg :slot1
    :initform nil)
   (slot2
     :accessor slot2
     :initarg :slot2
     :initform nil)
   (slot3
     :accessor slot3
     :initarg :slot3
     :initform nil)))
~~~

これはもっと多くのことができ、非常に柔軟です。
ただし Common Lisp コミュニティではあまり使われていません。自己責任で使ってください。


## メソッド

### まず試す
冒頭の `person` クラスと `child` クラスを思い出してください。

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)))
;; => #<STANDARD-CLASS PERSON>

(defclass child (person)
  ())
;; #<STANDARD-CLASS CHILD>

(setf p1 (make-instance 'person :name "me"))
(setf c1 (make-instance 'child :name "Alice"))
~~~

以下ではメソッドを作成し、特殊化し、メソッド combination (before, after, around) と qualifier を使います。

~~~lisp
(defmethod greet (obj)
  (format t "Are you a person ? You are a ~a.~&" (type-of obj)))
;; style-warning: Implicitly creating new generic function common-lisp-user::greet.
;; #<STANDARD-METHOD GREET (t) {1008EE4603}>

(greet :anything)
;; Are you a person ? You are a KEYWORD.
;; NIL
(greet p1)
;; Are you a person ? You are a PERSON.

(defgeneric greet (obj)
  (:documentation "say hello"))
;; STYLE-WARNING: redefining COMMON-LISP-USER::GREET in DEFGENERIC
;; #<STANDARD-GENERIC-FUNCTION GREET (2)>

(defmethod greet ((obj person))
  (format t "Hello ~a !~&" (name obj)))
;; #<STANDARD-METHOD GREET (PERSON) {1007C26743}>

(greet p1) ;; => "Hello me !"
(greet c1) ;; => "Hello Alice !"

(defmethod greet ((obj child))
  (format t "ur so cute~&"))
;; #<STANDARD-METHOD GREET (CHILD) {1008F3C1C3}>

(greet p1) ;; => "Hello me !"
(greet c1) ;; => "ur so cute"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Method combination: before, after, around.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod greet :before ((obj person))
  (format t "-- before person~&"))
#<STANDARD-METHOD GREET :BEFORE (PERSON) {100C94A013}>

(greet p1)
;; -- before person
;; Hello me

(defmethod greet :before ((obj child))
  (format t "-- before child~&"))
;; #<STANDARD-METHOD GREET :BEFORE (CHILD) {100AD32A43}>
(greet c1)
;; -- before child
;; -- before person
;; ur so cute

(defmethod greet :after ((obj person))
  (format t "-- after person~&"))
;; #<STANDARD-METHOD GREET :AFTER (PERSON) {100CA2E1A3}>
(greet p1)
;; -- before person
;; Hello me
;; -- after person

(defmethod greet :after ((obj child))
  (format t "-- after child~&"))
;; #<STANDARD-METHOD GREET :AFTER (CHILD) {10075B71F3}>
(greet c1)
;; -- before child
;; -- before person
;; ur so cute
;; -- after person
;; -- after child

(defmethod greet :around ((obj child))
  (format t "Hello my dear~&"))
;; #<STANDARD-METHOD GREET :AROUND (CHILD) {10076658E3}>
(greet c1) ;; Hello my dear


;; call-next-method

(defmethod greet :around ((obj child))
  (format t "Hello my dear~&")
  (when (next-method-p)
    (call-next-method)))
;; #<standard-method greet :around (child) {100AF76863}>

(greet c1)
;; Hello my dear
;; -- before child
;; -- before person
;; ur so cute
;; -- after person
;; -- after child

;;;;;;;;;;;;;;;;;
;; &key の追加
;;;;;;;;;;;;;;;;;

;; generic method に "&key" を追加するには、まずその定義を削除する必要がある。
(fmakunbound 'greet)  ;; Slime では: C-c C-u (slime-undefine-function)
(defmethod greet ((obj person) &key talkative)
  (format t "Hello ~a~&" (name obj))
  (when talkative
    (format t "blah")))

(defgeneric greet (obj &key &allow-other-keys)
  (:documentation "say hi"))

(defmethod greet (obj &key &allow-other-keys)
  (format t "Are you a person ? You are a ~a.~&" (type-of obj)))

(defmethod greet ((obj person) &key talkative &allow-other-keys)
  (format t "Hello ~a !~&" (name obj))
  (when talkative
    (format t "blah")))

(greet p1 :talkative t) ;; ok
(greet p1 :foo t) ;; これも ok


;;;;;;;;;;;;;;;;;;;;;;;

(defgeneric greet (obj)
  (:documentation "say hello")
  (:method (obj)
    (format t "Are you a person ? You are a ~a~&." (type-of obj)))
  (:method ((obj person))
    (format t "Hello ~a !~&" (name obj)))
  (:method ((obj child))
    (format t "ur so cute~&")))

;;;;;;;;;;;;;;;;
;;; Specializers
;;;;;;;;;;;;;;;;

(defgeneric feed (obj meal-type)
  (:method (obj meal-type)
    (declare (ignorable meal-type))
    (format t "eating~&")))

(defmethod feed (obj (meal-type (eql :dessert)))
    (declare (ignorable meal-type))
    (format t "mmh, dessert !~&"))

(feed c1 :dessert)
;; mmh, dessert !

(defmethod feed ((obj child) (meal-type (eql :soup)))
    (declare (ignorable meal-type))
    (format t "bwark~&"))

(feed p1 :soup)
;; eating
(feed c1 :soup)
;; bwark
~~~


### Generic function (defgeneric, defmethod)

`generic function` は、一連のメソッドと関連付けられ、呼び出されたときにそれらを dispatch する Lisp 関数です。
同じ関数名を持つすべてのメソッドは、同じ generic 関数に属します。

`defmethod` フォームは `defun` に似ています。
コード本体を関数名に関連付けますが、その本体は、引数の型がラムダリストで宣言されたパターンに一致する場合にだけ実行されます。

optional、keyword、`&rest` 引数を持てます。

`defgeneric` フォームは generic 関数を定義します。
対応する `defgeneric` なしで `defmethod` を書くと、generic 関数が自動的に作成されます (例を参照)。

一般に `defgeneric` を書くのはよい考えです。
デフォルト実装やドキュメントを追加できます。

~~~lisp
(defgeneric greet (obj)
  (:documentation "says hi")
  (:method (obj)
    (format t "Hi")))
~~~

メソッドのラムダリストの必須パラメータは、次の 3 つの形式のいずれかを取れます。

1- 単純な変数:

~~~lisp
(defmethod greet (foo)
  ...)
~~~

このメソッドは任意の引数を取れ、常に applicable です。

変数 `foo` は通常どおり対応する引数値に束縛されます。

2- 変数と **specializer**。例:

~~~lisp
(defmethod greet ((foo person))
  ...)
~~~

この場合、変数 `foo` は、その引数が specializer クラス `person` *またはそのサブクラス* (`child` など) である場合にのみ、対応する引数に束縛されます (実際、"child" も "person" です)。

いずれかの引数がその specializer に一致しない場合、そのメソッドは *applicable* ではなく、それらの引数では実行できません。
"there is no applicable メソッド for the generic 関数 xxx when called with 引数 yyy" のようなエラーメッセージが出ます。

**特殊化できるのは必須パラメータだけです**。optional な `&key` 引数では特殊化できません。


3- 変数と **eql specializer**

~~~lisp
(defmethod feed ((obj child) (meal-type (eql :soup)))
    (declare (ignorable meal-type))
    (format t "bwark~&"))

(feed c1 :soup)
;; "bwark"
~~~

単純なシンボル (`:soup`) の代わりに、eql specializer には任意の Lisp フォームを使えます。
これは defmethod と同じタイミングで評価されます。

ラムダリストの形式が generic 関数の形と *congruent* である限り、同じ関数名で specializer の異なるメソッドをいくつでも定義できます。
システムは最も *specific* な applicable メソッドを選び、その本体を実行します。
最も specific なメソッドとは、specializer が引数の `class-precedence-list` の先頭に最も近いものです (ラムダリストの左側にあるクラスほど specific です)。
specializer を持つメソッドは、何も持たないメソッドより specific です。


**注意:**

-   通常の関数と同じ関数名でメソッドを定義するのはエラーです。本当にそうしたい場合は shadowing 機構を使ってください。

-   既存の generic メソッドのラムダリストに `keys` や `rest` 引数を追加または削除するには、`fmakunbound` (または Slime で関数上にカーソルを置いて `C-c C-u` (slime-undefine-function)) で宣言を削除し、やり直す必要があります。そうしないと次のようになります。

```
attempt to add the method
  #<STANDARD-METHOD NIL (#<STANDARD-CLASS CHILD>) {1009504233}>
to the generic function
  #<STANDARD-GENERIC-FUNCTION GREET (2)>;
but the method and generic function differ in whether they accept
&REST or &KEY arguments.
```

-   メソッドは再定義できます (通常の関数とまったく同じです)。

-   メソッドが定義される順序は関係ありません。ただし、特殊化の対象になるクラスはすでに存在している必要があります。

-   特殊化されていない引数は、だいたいクラス `t` に特殊化されていることと同等です。唯一の違いは、すべての特殊化された引数は暗黙に「参照された」ものとみなされることです (`declare ignore` の意味で)。

-   各 `defmethod` フォームは、クラス `standard-method` の CLOS インスタンスを生成し、返します。

- `eql` specializer は文字列ではそのまま動きません。実際、文字列の比較には `equal` または `equalp` が必要です。ただし、文字列を変数に代入し、その変数を `eql` specializer と関数呼び出しの両方で使えます。

- 同じ関数名を持つすべてのメソッドは同じ generic 関数に属します。

- `defclass` で定義されたすべてのスロット accessor と reader はメソッドです。同じ generic 関数上の他のメソッドを上書きしたり、上書きされたりできます。


[defmethod on the CLHS](http://www.lispworks.com/documentation/lw70/CLHS/Body/m_defmet.htm) も参照してください。

### Multimethod

Multimethod は、generic 関数の必須パラメータを複数明示的に特殊化します。

それらは特定のクラスに属しません。
つまり、他の言語で必要になるかもしれないように、このメソッドを置くのに最適なクラスを決める必要はありません。

~~~lisp
(defgeneric hug (a b)
   (:documentation "Hug between two persons."))
;; #<STANDARD-GENERIC-FUNCTION HUG (0)>

(defmethod hug ((a person) (b person))
  :person-person-hug)

(defmethod hug ((a person) (b child))
  :person-child-hug)
~~~

詳しくは [Practical Common Lisp](http://www.gigamonkeys.com/book/object-reorientation-generic-functions.html#multimethods) を読んでください。

<a id="setter--setf-ing-methods"></a>

### setter の制御 (setf-ing メソッド)

Lisp では、関数やメソッドに対応する `setf` 版を定義できます。
これは、オブジェクトの更新方法をより細かく制御したい場合に使えます。

~~~lisp
(defmethod (setf name) (new-val (obj person))
  (if (equalp new-val "james bond")
    (format t "Dude that's not possible.~&")
    (setf (slot-value obj 'name) new-val)))

(setf (name p1) "james bond") ;; -> no rename
~~~

Python を知っているなら、この挙動は `@property` デコレータで提供されるものです。


<a id="dispatch--next-method"></a>

### Dispatch 機構と next メソッド


generic 関数が呼び出されたとき、アプリケーションがメソッドを直接呼び出すことはできません。
dispatch 機構は次のように進みます。

1.  applicable メソッドのリストを計算する
2.  適用可能なメソッドがなければエラーを通知する
3.  applicable メソッドを specificity の順にソートする
4.  最も specific なメソッドを呼び出す

私たちの `greet` generic 関数には 3 つの applicable メソッドがあります。

~~~lisp
(closer-mop:generic-function-methods #'greet)
(#<STANDARD-METHOD GREET (CHILD) {10098406A3}>
 #<STANDARD-METHOD GREET (PERSON) {1009008EC3}>
 #<STANDARD-METHOD GREET (T) {1008E6EBB3}>)
~~~

メソッドの実行中、残りの applicable メソッドには *local function* `call-next-method` を介してアクセスできます。
この関数はメソッド本体内でレキシカルスコープを持ちますが、indefinite extent を持ちます。
次に specific なメソッドを呼び出し、そのメソッドが返した値をそのまま返します。
次のいずれかで呼び出せます。

*   引数なし。この場合、*next method* はこのメソッドとまったく同じ引数を受け取ります。

*   明示的な引数。この場合、新しい引数に applicable なメソッドのソート済み集合が、generic 関数が最初に呼ばれたときに計算されたものと同じでなければなりません。

例:

~~~lisp
(defmethod greet ((obj child))
  (format t "ur so cute~&")
  (when (next-method-p)
    (call-next-method)))
;; STYLE-WARNING: REDEFINING GREET (#<STANDARD-CLASS CHILD>) in DEFMETHOD
;; #<STANDARD-METHOD GREET (child) {1003D3DB43}>

(greet c1)
;; ur so cute
;; Hello Alice !
~~~

後続のメソッドがないときに `call-next-method` を呼び出すと、エラーが通知されます。
next メソッドが存在するかどうかは、local 関数 `next-method-p` を呼び出して調べられます (これもレキシカルスコープと indefinite extent を持ちます)。

最後に、すべてのメソッド本体は、そのメソッドの generic 関数と同じ名前の block を確立することに注意してください。
その名前に対して `return-from` すると、囲んでいる generic 関数の呼び出しではなく、現在のメソッドから抜けます。


<a id="qualifiers-and-method-combination"></a>

### Method qualifier (before, after, around)

「まず試す」の例で、`:before`、`:after`、`:around` *qualifier* の使い方をいくつか見ました。

- `(defmethod foo :before (obj) (...))`
- `(defmethod foo :after (obj) (...))`
- `(defmethod foo :around (obj) (...))`

CLOS が提供する *standard メソッド combination* フレームワークでは、デフォルトでこれら 3 つの qualifier のどれか 1 つだけを使えます。
制御の流れは次のとおりです。

- **before-method** は、文字どおり applicable な primary メソッドの前に呼ばれます。before-method が複数ある場合は **すべて** 呼ばれます。最も specific な before-method が最初に呼ばれます (person より child が先)。
- 最も specific な applicable **primary method** (qualifier のないメソッド) が呼ばれます (1 つだけ)。
- applicable な **after-method** がすべて呼ばれます。最も specific なものは *最後* に呼ばれます (person の after-method、その後 child の after-method)。

**generic 関数は primary メソッドの値を返します**。
before メソッドや after メソッドの値は無視されます。
それらは副作用のために使われます。

そして **around-method** があります。
これは、ここまで説明した中核機構を包むラッパーです。
返り値を捕まえたり、primary メソッドの周囲に環境を用意したりするのに便利です (catch、lock、実行時間計測など)。

dispatch 機構が around-method を見つけると、それを呼び出して結果を返します。
around-method に `call-next-method` があれば、次に applicable な around-method を呼び出します。
primary メソッドに到達して初めて、before-method と after-method の呼び出しを始めます。

したがって、generic 関数の完全な dispatch 機構は次のようになります。

1.  applicable メソッドを計算し、qualifier に従って別々のリストへ分ける。
2.  適用可能なプライマリメソッドがなければエラーを通知する。
3.  各リストを specificity の順にソートする。
4.  最も specific な `:around` メソッドを実行し、それが返すものを返す。
5.  `:around` メソッドが `call-next-method` を呼び出した場合、次に specific な `:around` メソッドを実行する。
6.  最初から `:around` メソッドがなかった場合、または `:around` メソッドが `call-next-method` を呼び出したが、呼び出すべき後続の `:around` メソッドがない場合、次のように進む。

    a.  すべての `:before` メソッドを順に実行する。返り値は無視し、`call-next-method` や `next-method-p` の呼び出しは許可しない。

    b.  最も specific な primary メソッドを実行し、それが返すものを返す。

    c.  primary メソッドが `call-next-method` を呼び出した場合、次に specific な primary メソッドを実行する。

d.  プライマリメソッドが `call-next-method` を呼び出したものの、呼び出すべき後続のプライマリメソッドがない場合はエラーを通知する。

    e.  primary メソッドの完了後、すべての `:after` メソッドを **<u>逆</u>** 順で実行する。返り値は無視し、`call-next-method` や `next-method-p` の呼び出しは許可しない。

玉ねぎのように考えるとよいでしょう。最も外側の層にすべての `:around` メソッドがあり、中間層に `:before` と `:after` メソッドがあり、内側に primary メソッドがあります。


<a id="method-combination"></a>

### その他のメソッド combination

先ほど見たデフォルトのメソッド combination type は `standard` という名前ですが、他のメソッド combination type も利用でき、もちろん自分で定義することもできます。

組み込み型は次のとおりです。

    progn + list nconc and max or append min

これらの型は Lisp operator にちなんで名付けられていることに気づくでしょう。
実際、それらが行うのは、その名前の Lisp operator 呼び出しの内側で applicable な primary メソッドを結合するフレームワークを定義することです。
たとえば、`progn` combination type を使うことは、**すべての** primary メソッドを順に呼び出すことと同等です。

~~~lisp
(progn
  (method-1 args)
  (method-2 args)
  (method-3 args))
~~~

ここでは standard 機構と異なり、与えられたオブジェクトに applicable なすべての primary メソッドが、最も specific なものから呼び出されます。

combination type を変更するには、`defgeneric` の `:method-combination` オプションを設定し、それをメソッドの qualifier として使います。

~~~lisp
(defgeneric foo (obj)
  (:method-combination progn))

(defmethod foo progn ((obj obj))
   (...))
~~~

**progn** の例:

~~~lisp
(defgeneric dishes (obj)
   (:method-combination progn)
   (:method progn (obj)
     (format t "- clean and dry.~&"))
   (:method progn ((obj person))
     (format t "- bring a person's dishes~&"))
   (:method progn ((obj child))
     (format t "- bring the baby dishes~&")))
;; #<STANDARD-GENERIC-FUNCTION DISHES (3)>

(dishes c1)
;; - bring the baby dishes
;; - bring a person's dishes
;; - clean and dry.

(greet c1)
;; ur so cute  --> 最も applicable なメソッドだけが呼ばれた。
~~~

同様に、`list` 型を使うことは、メソッドの値のリストを返すことと同等です。

~~~lisp
(list
  (method-1 args)
  (method-2 args)
  (method-3 args))
~~~

~~~lisp
(defgeneric tidy (obj)
  (:method-combination list)
  (:method list (obj)
    :foo)
  (:method list ((obj person))
    :books)
  (:method list ((obj child))
    :toys))
;; #<STANDARD-GENERIC-FUNCTION TIDY (3)>

(tidy c1)
;; (:toys :books :foo)
~~~

**Around method** は受け付けられます。

~~~lisp
(defmethod tidy :around (obj)
   (let ((res (call-next-method)))
     (format t "I'm going to clean up ~a~&" res)
     (when (> (length res)
              1)
       (format t "that's too much !~&"))))

(tidy c1)
;; I'm going to clean up (toys book foo)
;; that's too much !
~~~

これらの operator は `before`、`after`、`around` メソッドをサポートしないことに注意してください (実際、それらを入れる余地がもうありません)。
around メソッドはサポートされ、そこでは `call-next-method` が許可されますが、primary メソッド内で `call-next-method` を呼び出すことはサポートされません。
すべての primary メソッドが呼ばれるため、それは冗長ですし、あるものを *呼ばない* ほうがぎこちなくなります。

CLOS では、Lisp 関数、マクロ、special form のいずれであっても、新しい operator をメソッド combination type として定義できます。
必要を感じたら、書籍を参照してください。

<a id="method-combination--trace"></a>

### デバッグ: メソッド combination の trace

メソッド combination を [trace](http://www.xach.com/clhs?q=trace) することは可能ですが、これは実装依存です。

SBCL では `(trace foo :methods t)` を使えます。[this post by an SBCL core developer](http://christophe.rhodes.io/notes/blog/posts/2018/sbcl_method_tracing/) を参照してください。

たとえば、次の generic があるとします。

~~~lisp
(defgeneric foo (x)
  (:method (x) 3))
(defmethod foo :around ((x fixnum))
  (1+ (call-next-method)))
(defmethod foo ((x integer))
  (* 2 (call-next-method)))
(defmethod foo ((x float))
  (* 3 (call-next-method)))
(defmethod foo :before ((x single-float))
  'single)
(defmethod foo :after ((x double-float))
 'double)
~~~

これを trace します。

~~~lisp
(trace foo :methods t)

(foo 2.0d0)
  0: (FOO 2.0d0)
    1: ((SB-PCL::COMBINED-METHOD FOO) 2.0d0)
      2: ((METHOD FOO (FLOAT)) 2.0d0)
        3: ((METHOD FOO (T)) 2.0d0)
        3: (METHOD FOO (T)) returned 3
      2: (METHOD FOO (FLOAT)) returned 9
      2: ((METHOD FOO :AFTER (DOUBLE-FLOAT)) 2.0d0)
      2: (METHOD FOO :AFTER (DOUBLE-FLOAT)) returned DOUBLE
    1: (SB-PCL::COMBINED-METHOD FOO) returned 9
  0: FOO returned 9
9
~~~

### defgeneric と defmethod の違い: 再定義

`defgeneric` 本体の中でメソッドを宣言する場合と、複数の `defmethod` を書く場合には違いがあります。
この 2 つの方法は、メソッドの再定義を異なる形で扱います。
`defgeneric` は、本体内にもう存在しないメソッドを削除します。

以下では、`person` と `child` に特殊化した 2 つの `defmethod` を使って、新しい generic 関数を定義します。

~~~lisp
(defmethod goodbye ((p person))
  (format t "goodbye ~a.~&" (name p)))

(defmethod goodbye ((c child))
  (format t "love you lil' one <3~&"))
~~~

`(goodbye (make-instance 'person :name "you"))` で試せます。

さて、作業セッションの後半で、`child` に特殊化したものはもう不要だと判断したとします。
そのソースコードを削除します。
しかし、**そのメソッドはまだ image 内に存在します**。
下で見るように、プログラム的にメソッドを削除する必要があります。

`defgeneric` を使っていれば、すべてのメソッドは更新、追加、削除されていたでしょう。
すでに 3 つのメソッドを持つ `tidy` generic 関数を定義しました。

~~~lisp
(defgeneric tidy (obj)
  (:method-combination list)
  (:method list (obj)
    :foo)
  (:method list ((obj person))
    :books)
  (:method list ((obj child))
    :toys))
~~~

これは person や child など任意のオブジェクト型で動作します。
文字列で試してください: `(tidy "tidy what?")`。動作します。

次に、この宣言を `defgeneric` から削除します。


~~~lisp
(defgeneric tidy (obj)
  (:method-combination list)
  ;;(:method list (obj)  ;; <--- commented out
  ;;  :foo)
  (:method list ((obj person))
    :books)
  (:method list ((obj child))
    :toys))
~~~

もう一度呼び出してみると、"no applicable method" エラーが出ます。

```
There is no applicable method for the generic function
  #<STANDARD-GENERIC-FUNCTION TRADESIGNAL::TIDY (2)>
when called with arguments
  ("tidy what?").
```

開発中にこれが重要かどうかは場合によりますが、知っておくと Lisp image をソースコードと同期した状態に保つ助けになります。
そうでなければ、古いメソッドが邪魔になったときに削除できます。

### メソッドの削除

まず、メソッドオブジェクトを探す必要があります。

~~~lisp
(find-method #'goodbye nil (list (find-class 'child)))
;; => #<STANDARD-METHOD GOODBYE (CHILD) {10073EFD73}>
~~~

`find-method` は引数として、関数参照、qualifier (before、after、around など)、クラス specializer のリストを取ります。

メソッドが見つかったら、`remove-method` を使います。

`(fmakunbound 'goodbye)` を使うこともできますが、これは *すべての* メソッドを unbound にします。


## MOP

ここでは、meta-object protocol が提供するフレームワークを使う例をいくつか集めます。
これは Lisp のオブジェクトシステムを支配する、設定可能なオブジェクトシステムです。
高度な概念に触れるので、初めて読む人も心配しないでください。
Common Lisp Object System を使い始めるために、このセクションを理解する必要はありません。

ここでは MOP について多くは説明しませんが、その可能性が見えたり、一部の CL ライブラリがどのように作られているかを理解する助けになる程度には説明できればと思います。
導入部で参照した書籍を読むことをおすすめします。


### Metaclass

metaclass は他のクラスの挙動を制御するために必要です。

*予告したとおり、ここでは多くを語りません。[metaclasses](https://en.wikipedia.org/wiki/Metaclass) や [CLOS](https://en.wikipedia.org/wiki/Common_Lisp_Object_System) については Wikipedia も参照してください*。

標準の metaclass は `standard-class` です。

~~~lisp
(class-of p1) ;; #<STANDARD-CLASS PERSON>
~~~

しかし、これを自分たちのものに変更し、**インスタンスの作成を数えられる** ようにします。
同じ仕組みは、データベースシステムの主キーを自動インクリメントするため (Postmodern や Mito ライブラリはこのようにしています)、オブジェクト作成をログに記録するため、などに使えます。

私たちの metaclass は `standard-class` を継承します。

~~~lisp
(defclass counted-class (standard-class)
  ((counter :initform 0)))
#<STANDARD-CLASS COUNTED-CLASS>

(unintern 'person)
;; person の metaclass を変更するために必要。
;; または (setf (find-class 'person) nil)
;; https://stackoverflow.com/questions/38811931/how-to-change-classs-metaclass#38812140

(defclass person ()
  ((name
    :initarg :name
    :accessor name))
  (:metaclass counted-class)) ;; <- metaclass
;; #<COUNTED-CLASS PERSON>
;;   ^^^ もう standard-class ではない。
~~~

`:metaclass` クラスオプションは 1 回だけ現れます。

実際には、`validate-superclass` を実装するよう求めるメッセージが出たはずです。
そこで、引き続き `closer-mop` ライブラリを使います。

~~~lisp
(defmethod closer-mop:validate-superclass ((class counted-class)
                                           (superclass standard-class))
  t)
~~~

これで新しい `person` インスタンスの作成を制御できます。

~~~lisp
(defmethod make-instance :after ((class counted-class) &key)
  (incf (slot-value class 'counter)))
;; #<STANDARD-METHOD MAKE-INSTANCE :AFTER (COUNTED-CLASS) {1007718473}>
~~~

`:after` qualifier が最も安全な選択であることに注目してください。
標準メソッドを通常どおり実行させ、新しいインスタンスを返させます。

`&key` は必要です。`make-instance` には initarg が渡されることを思い出してください。

ではテストします。

~~~lisp
(defvar p3 (make-instance 'person :name "adam"))
#<PERSON {1007A8F5B3}>

(slot-value p3 'counter)
;; => error。新しいスロットは person クラス上にはない。
(slot-value (find-class 'person) 'counter)
;; 1

(make-instance 'person :name "eve")
;; #<PERSON {1007AD5773}>
(slot-value (find-class 'person) 'counter)
;; 2
~~~

動作しています。


### インスタンス初期化の制御 (initialize-instance)

オブジェクトインスタンスの作成をさらに制御するには、`initialize-instance` メソッドを特殊化できます。
これは `make-instance` によって、新しいインスタンスが作成された直後、ただしデフォルトの initarg と initform でまだ初期化されていない時点で呼び出されます。

primary メソッドを作るとスロットの初期化を妨げるため、after メソッドを作ることが推奨されています (Keene)。

~~~lisp
(defmethod initialize-instance :after ((obj person) &key)
;; arglist の &key に注意:                    ^^^^
  (do something with obj))
~~~

典型的な例は初期値の検証です。
ここでは person の名前が 3 文字より長いことをチェックします。

~~~lisp
(defmethod initialize-instance :after ((obj person) &key)
  (with-slots (name) obj
    (assert (>= (length name) 3))))
~~~

そのため、この呼び出しはもう動きません。

~~~lisp
(make-instance 'person :name "me")
;; The assertion (>= #1=(LENGTH NAME) 3) failed with #1# = 2.
;;   [Condition of type SIMPLE-ERROR]
~~~

interactive debugger に入り、restart (continue、retry、abort) の選択肢が提示されます。

ついでに、debugger 機能を使って "name" を変更する選択肢を提供する assertion を示します。
debugger から変更できる place のリストを `assert` に渡します。

~~~lisp
(defmethod INITIALIZE-INSTANCE :after ((obj person) &key)
  (with-slots (name) obj
    (assert (>= (length name) 3)
            (name)  ;; <-- place のリスト
            "The value of name is ~a. It should be longer than 3 characters." name)))
~~~

次のようになります。

```
The value of name is me. It should be longer than 3 characters.
   [Condition of type SIMPLE-ERROR]

Restarts:
 0: [CONTINUE] Retry assertion with new value for NAME.
                               ^^^^^^^^^^^^ 新しい restart
 1: [RETRY] Retry SLIME REPL evaluation request.
 2: [*ABORT] Return to SLIME's top level.
```


別の説明です。CLOS の `make-instance` 実装は 2 段階です。
新しいオブジェクトを割り当て、それからそのオブジェクトとすべての `make-instance` キーワード引数を generic 関数 `initialize-instance` に渡します。
実装者やアプリケーション作者は、インスタンスのスロットを初期化するために `initialize-instance` 上に `:after` メソッドを定義します。
システムが提供する primary メソッドは、(a) クラス定義時に与えられた `:initform` と `:initarg` の値、および (b) `make-instance` から渡されたキーワードに関してこれを行います。
他のメソッドは必要に応じてこの挙動を拡張できます。
たとえば、特定のスロットを埋めるためのデータベースアクセスを呼び出す追加キーワードを受け付けるかもしれません。
`initialize-instance` のラムダリストは次のとおりです。

~~~
initialize-instance instance &rest initargs &key &allow-other-keys
~~~

### インスタンス更新の制御 (update-instance-for-redefined-class)

座標と直径を持つ "circle" クラスを作ったとします。
後で、直径を半径に置き換えることにしました。
既存のすべてのオブジェクトを賢く更新したいとします。
半径は直径の値を 2 で割った値になるべきです。
`update-instance-for-redefined-class` を使います。

そのパラメータは次のとおりです。

- instance: 更新中のオブジェクトインスタンス
- added-slots: 追加されたスロットのリスト
- discarded-slots: 破棄されたスロットのリスト
- property-list: 元のインスタンスで値を持っていたすべての discarded-slots のスロット名と値を捕捉した plist
- initargs: 初期化引数リスト。下では `&key` がそれらを受け取ります。

そしてオブジェクトを返します。

実際にはこのメソッドを直接呼ぶのではなく、`:before` メソッドを使います。

~~~lisp
(defmethod update-instance-for-redefined-class
    :before ((obj circle) added deleted plist-values &key)
  (format t "plist values: ~a~&" plist-values)
  (let ((diameter (getf plist-values 'diameter)))
    (setf (radius obj) (/ diameter 2))))
~~~

試し方は次のとおりです。`circle` クラスから始めます。

~~~lisp
(defclass circle ()
  ((diameter :accessor diameter :initform 9)))
~~~

そして circle オブジェクトを作成します。

~~~lisp
(make-instance 'circle)
~~~

それを inspect するか、diameter の値を確認します。

次に新しいクラス定義を書いてコンパイルします。

~~~lisp
(defclass circle ()
  ((radius :accessor radius)))
~~~

まだ何も起こらず、"plist values" の print 出力は見えません。

そのオブジェクトを inspect するか `describe` してください。そこで更新され、`radius` スロットが見つかります。

既存オブジェクトは遅延更新されます。

詳しくは [HyperSpec](https://www.lispworks.com/documentation/HyperSpec/Body/f_upda_1.htm) または [Community Spec](https://cl-community-spec.github.io/pages/update_002dinstance_002dfor_002dredefined_002dclass.html) を参照してください。

### 新しいクラスへのインスタンス更新の制御 (update-instance-for-different-class)

今度は `circle` クラスで作業しているが、必要なのは `surface` 種のオブジェクトだけだと気づいたとします。
circle クラスを完全に捨てる一方で、既存オブジェクトをこの新しいクラスへ更新し、新しいスロットを賢く計算したいとします。
`update-instance-for-different-class` を使います。

詳しくは [HyperSpec](https://www.lispworks.com/documentation/HyperSpec/Body/f_update.htm) または [Community Spec](https://cl-community-spec.github.io/pages/update_002dinstance_002dfor_002ddifferent_002dclass.html) を参照してください。

### qualifier と型に一致するメソッドを探す

指定した *qualifier* の集合 (`:around` メソッドなど) と、より重要な *specializer* (そのメソッドが dispatch する型) を持つメソッドが存在するかを確認したいとします。

たとえば、この章では `person` オブジェクト向けに `print-object` メソッドを特殊化しました。

```lisp
(defmethod print-object ((obj person) stream)
```

今、イントロスペクションを使うプログラムで、そのような関数が存在するかを確認し、その参照を取得したいとします。

`find-method` を使います。

~~~lisp
(find-method #'print-object nil '(person t))
;;          ^^^ シンボルだけでなく関数オブジェクト
;; => <STANDARD-METHOD COMMON-LISP:PRINT-OBJECT (PERSON T) {1204FA0B83}>
~~~

第 1 引数 `nil` は qualifier のリストです。
`:around`、`:before`、`:after` メソッドには関心がないので `nil` のままにします。
リストとして `'(:around)` を使うこともできます。

第 2 引数はメソッド引数の型のリストです。
`print-object` は person とストリームの 2 つの引数を取ります。
generic 関数への参照を得るには `'(t t)` を使えます。
person と任意のストリームに特殊化したメソッドへの参照を得るには `'(person t)` を使います。

そのようなメソッドが存在しない場合、`find-method` はエラーを通知します。

```
There is no method on
#<STANDARD-GENERIC-FUNCTION COMMON-LISP::PRINT-OBJECT (1)> with no
qualifiers and specializers
(… …)
condition of type simple-error
```

最後の optional 引数 `errorp` を `nil` に設定しない限り、そうなります。


### 最後に

さらに多くのことは書籍を参照してください!
