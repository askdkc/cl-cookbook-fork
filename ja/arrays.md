---
title: 多次元配列
---

Common Lisp は多次元配列をネイティブにサポートしており、1 次元配列には `vectors` と呼ばれる特別な扱いがあります。配列は汎用化されており、任意の型（`element-type t`）の要素を含められます。また、`single-float` や `integer` など、特定の型の要素だけを含むよう特殊化することもできます。出発点としては、Peter Seibel による [Practical Common Lisp Chapter 11, Collections](http://www.gigamonkeys.com/book/collections.html) がよいでしょう。

配列に対する一般的な operation の早見表は、[配列とベクトル](data-structures.html) の section にあります。

配列を操作するために [Quicklisp](https://www.quicklisp.org/beta/) で利用できるライブラリには、次のものがあります。

- [array-operations](https://github.com/Lisp-Stat/array-operations) は lisp-stat project 由来で、
  `generate`, `permute`, `displace`, `flatten`, `split`,
  `combine`, `reshape` 関数を定義します。また、要素ごとの
  演算に使う `each` も定義します。これは [bendudson/array-operations](https://github.com/bendudson/array-operations) の fork であり、さらにそれは original
  author による [tpapp/array-operations](https://github.com/tpapp/array-operations) の fork です。
- [cmu-infix](https://github.com/rigetticomputing/cmu-infix) は、
  多次元配列用の添字構文を含みます。
- [lla](https://github.com/tpapp/lla) は linear algebra 用ライブラリで、BLAS と LAPACK
  ライブラリを呼び出します。多くの CL linear algebra パッケージと違って
  直感的な関数 name を使い、ネイティブ配列だけでなく
  CLOS オブジェクトに対しても動作できます。

この page では built-in の多次元配列でできることを扱いますが、制限もあります。特に次の点です。

* 外部 language の配列との interoperability。たとえば BLAS、LAPACK、GSL のようなライブラリを呼び出す場合です。
* arithmetic operator やその他の mathematical operator を、配列を扱えるように拡張すること。たとえば `a` や `b` が配列のときに `(+ a b)` が動くようにする場合です。

これら 2 つの問題は、ネイティブ配列を特殊なケースとして持つ拡張配列クラスを CLOS で定義することで解決できます。この手法を採用し、[Quicklisp](https://www.quicklisp.org/beta/) 経由で利用できるライブラリには、次のものがあります。

* [matlisp](https://github.com/bharath1097/matlisp/)。その一部は
  下の section で説明します。
* [MGL-MAT](https://github.com/melisgl/mgl-mat)。manual があり、
  BLAS と CUDA へのバインディングを提供します。これは machine
  learning ライブラリ [MGL](https://github.com/melisgl/mgl) で使われています。
* [cl-ana](https://github.com/ghollisjr/cl-ana/wiki)。manual 付きのデータ分析
  パッケージで、配列に対する operation を含みます。
* [Antik](https://www.common-lisp.net/project/antik/)。GNU Scientific Library
  へのバインディングである [GSLL](https://common-lisp.net/project/gsll/) で使われています。

比較的新しく活発に開発されているパッケージとして [MAGICL](https://github.com/rigetticomputing/magicl) があります。これは BLAS と LAPACK ライブラリのラッパーを提供します。執筆時点ではこのパッケージは Quicklisp に含まれておらず、SBCL と CCL でのみ動きます。特に複素配列に焦点を当てているようですが、それだけに限定されているわけではありません。install するには、たとえば Linux/Unix では quicklisp の `local-projects` directory に repository を clone します。

~~~bash
$ cd ~/quicklisp/local-projects
$ git clone https://github.com/rigetticomputing/magicl.git
~~~

dependency (BLAS、LAPACK、Expokit) の install 手順は [github web pages](https://github.com/rigetticomputing/magicl) にあります。低水準ルーチンは外部関数を wrap しているため、たとえば `magicl.lapack-cffi::%zgetrf` のような Fortran name を持ちます。これらの関数の一部には高水準インターフェイスも存在します。[source directory](https://github.com/rigetti/magicl/blob/master/src/high-level/) と [documentation](https://github.com/quil-lang/magicl/blob/master/doc/high-level.md) を参照してください。

さらに進むと、Common Lisp 上に domain specific language が構築されており、配列を使った numerical calculation に利用できます。執筆時点で、これらの中でも最も広く使われ support されているものは次です。

* [Maxima](http://maxima.sourceforge.net/documentation.html)
* [Axiom](https://github.com/daly/axiom)


[CLASP](https://github.com/drmeister/clasp) は、[LLVM](http://llvm.org/) を使って Common Lisp と他の language (特に C++) との interoperability を容易にすることを目指す project です。この project の主要なアプリケーションの 1 つは numerical/scientific computing です。

## 作成

関数 [CLHS: make-array](http://clhs.lisp.se/Body/f_mk_ar.htm) は、単一の値で満たされた配列を作成できます。

~~~lisp
* (defparameter *my-array* (make-array '(3 2) :initial-element 1.0))
*MY-ARRAY*
* *my-array*
#2A((1.0 1.0) (1.0 1.0) (1.0 1.0))
~~~

より複雑な配列値は、まず配列を作り、その後、各要素を反復して値を埋めることで生成できます（要素へのアクセスについては下の section を参照してください）。

[array-operations](https://github.com/tpapp/array-operations) ライブラリは、この iteration を wrap して配列を作成する便利な関数 `generate` を提供します。

~~~lisp
* (ql:quickload :array-operations)
To load "array-operations":
  Load 1 ASDF system:
    array-operations
; Loading "array-operations"

(:ARRAY-OPERATIONS)

* (aops:generate #'identity 7 :position)
#(0 1 2 3 4 5 6)
~~~

`array-operations` の nickname は `aops` であることに注意してください。`generate` 関数はキー `:subscripts` を渡すことで配列の添字も反復できます。さらに多くの例は [Array Operations manual on generate](https://lisp-stat.dev/docs/manuals/array-operations/#generate) を参照してください。

### 乱数

uniform distribution から引いた random number を含む 3x3 配列を作るには、`generate` を使って CL の [random](http://clhs.lisp.se/Body/f_random.htm) 関数を呼び出せます。

~~~lisp
* (aops:generate (lambda () (random 1.0)) '(3 3))
#2A((0.99292254 0.929777 0.93538976)
    (0.31522608 0.45167792 0.9411855)
    (0.96221936 0.9143338 0.21972346))
~~~

[alexandria](https://common-lisp.net/project/alexandria/) パッケージを使った、mean が 0、standard deviation が 1 の Gaussian (normal) random number の配列です。

~~~lisp
* (ql:quickload :alexandria)
To load "alexandria":
  Load 1 ASDF system:
    alexandria
; Loading "alexandria"

(:ALEXANDRIA)

* (aops:generate #'alexandria:gaussian-random 4)
#(0.5522547885338768d0 -1.2564808468164517d0 0.9488161476129733d0
  -0.10372852118266523d0)
~~~

これは特に効率的ではないことに注意してください。要素ごとに関数呼び出しが必要であり、`gaussian-random` は 2 つの乱数を返しますが、そのうち 1 つしか使われません。

より効率的な実装や、より広い範囲の確率分布を扱うために、Quicklisp で利用できるパッケージがあります。一覧は [CLiki](https://www.cliki.net/statistics) を参照してください。

<a id="element--access"></a>

## 要素へのアクセス

配列の個々の要素にアクセスするには、[aref](http://clhs.lisp.se/Body/f_aref.htm) と [row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) 関数があります。

[aref](http://clhs.lisp.se/Body/f_aref.htm) 関数は、配列の dimension 数と同じ数の index 引数を取ります。indexing は 0 から始まり、C と同じ row-major ですが、Fortran とは異なります。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (aref *a* 0)
1
* (aref *a* 3)
4
* (defparameter *b* #2A((1 2 3) (4 5 6)))
*B*
* (aref *b* 1 0)
4
* (aref *b* 0 2)
3
~~~

これらの index の範囲は [array-dimensions](http://clhs.lisp.se/Body/f_ar_d_1.htm) で調べられます。

~~~
* (array-dimensions *a*)
(4)
* (array-dimensions *b*)
(2 3)
~~~

また、配列の rank を調べ、その後で各 dimension の size を query できます。

~~~lisp
* (array-rank *a*)
1
* (array-dimension *a* 0)
4
* (array-rank *b*)
2
* (array-dimension *b* 0)
2
* (array-dimension *b* 1)
3
~~~

配列を loop するには、次のような nested loop を使えます。

~~~lisp
* (defparameter a #2A((1 2 3) (4 5 6)))
A
* (destructuring-bind (n m) (array-dimensions a)
    (loop for i from 0 below n do
      (loop for j from 0 below m do
        (format t "a[~a ~a] = ~a~%" i j (aref a i j)))))

a[0 0] = 1
a[0 1] = 2
a[0 2] = 3
a[1 0] = 4
a[1 1] = 5
a[1 2] = 6
NIL
~~~

これを multiple dimension に対して行う utility マクロが `nested-loop` です。

~~~lisp
(defmacro nested-loop (syms dimensions &body body)
  "Iterates over a multidimensional range of indices.

   SYMS must be a list of symbols, with the first symbol
   corresponding to the outermost loop.

   DIMENSIONS will be evaluated, and must be a list of
   dimension sizes, of the same length as SYMS.

   Example:
    (nested-loop (i j) '(10 20) (format t '~a ~a~%' i j))

  "
  (unless syms (return-from nested-loop `(progn ,@body))) ; No symbols

  ;; Generate gensyms for dimension sizes
  (let* ((rank (length syms))
         ;; reverse our symbols list,
         ;; since we start from the innermost.
         (syms-rev (reverse syms))
         ;; innermost dimension first:
         (dims-rev (loop for i from 0 below rank
                         collecting (gensym)))
         ;; start with innermost expression
         (result `(progn ,@body)))
    ;; Wrap previous result inside a loop for each dimension
    (loop for sym in syms-rev for dim in dims-rev do
         (unless (symbolp sym)
           (error "~S is not a symbol. First argument to nested-loop must be a list of symbols" sym))
         (setf result
               `(loop for ,sym from 0 below ,dim do
                     ,result)))
    ;; Add checking of rank and dimension types,
    ;; and get dimensions into gensym list.
    (let ((dims (gensym)))
      `(let ((,dims ,dimensions))
         (unless (= (length ,dims) ,rank)
           (error "Incorrect number of dimensions: Expected ~a but got ~a" ,rank (length ,dims)))
         (dolist (dim ,dims)
           (unless (integerp dim)
             (error "Dimensions must be integers: ~S" dim)))
         ;; dimensions reversed so that innermost is last:
         (destructuring-bind ,(reverse dims-rev) ,dims
           ,result)))))
~~~

これにより、2 次元配列の contents は次のように print できます。

~~~lisp
* (defparameter a #2A((1 2 3) (4 5 6)))
A
* (nested-loop (i j) (array-dimensions a)
      (format t "a[~a ~a] = ~a~%" i j (aref a i j)))

a[0 0] = 1
a[0 1] = 2
a[0 2] = 3
a[1 0] = 4
a[1 1] = 5
a[1 2] = 6
NIL
~~~

[Note: このマクロは array-operations の [this fork](https://github.com/bendudson/array-operations) で利用できますが、Quicklisp にはありません]

### Row major indexing

場合によっては、特に要素ごとの演算では、次元数は重要ではありません。次元数に依存しない code を書くには、[row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) によって単一の flattened index を使い、配列要素にアクセスできます。配列の size は [array-total-size](http://clhs.lisp.se/Body/f_ar_tot.htm) で与えられ、flattened index は 0 から始まります。

~~~lisp
* (defparameter a #2A((1 2 3) (4 5 6)))
A
* (array-total-size a)
6
* (loop for i from 0 below (array-total-size a) do
     (setf (row-major-aref a i) (+ 2.0 (row-major-aref a i))))
NIL
* a
#2A((3.0 4.0 5.0) (6.0 7.0 8.0))
~~~

### Infix syntax

[cmu-infix](https://github.com/rigetticomputing/cmu-infix) ライブラリは、mathematical 式を読みやすくできる少し異なる syntax を提供します。

~~~lisp
* (ql:quickload :cmu-infix)
To load "cmu-infix":
  Load 1 ASDF system:
    cmu-infix
; Loading "cmu-infix"

(:CMU-INFIX)

* (named-readtables:in-readtable cmu-infix:syntax)
(("COMMON-LISP-USER" . #<NAMED-READTABLE CMU-INFIX:SYNTAX {10030158B3}>)
 ...)

* (defparameter arr (make-array '(3 2) :initial-element 1.0))
ARR

* #i(arr[0 1] = 2.0)
2.0

* arr
#2A((1.0 2.0) (1.0 1.0) (1.0 1.0))
~~~

行列同士の乗算は次のように実装できます。

~~~lisp
(let ((A #2A((1 2) (3 4)))
      (B #2A((5 6) (7 8)))
      (result (make-array '(2 2) :initial-element 0.0)))

     (loop for i from 0 to 1 do
           (loop for j from 0 to 1 do
                 (loop for k from 0 to 1 do
                       #i(result[i j] += A[i k] * B[k j]))))
      result)
~~~

別の行列乗算の実装については、下の線形代数 section を参照してください。

<a id="element-wise-operations"></a>

## 要素ごとの演算

同じ size の 2 つの数値配列を掛け合わせるには、[array-operations](https://github.com/Lisp-Stat/array-operations) ライブラリの `each` に関数を渡します。

~~~lisp
* (aops:each #'* #(1 2 3) #(2 3 4))
#(2 6 12)
~~~

効率を高めるために `aops:each*` 関数があります。これは結果配列を specialize するため、最初の引数に type を取ります。

配列のすべての element に constant を加えるには、次のようにします。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (aops:each (lambda (it) (+ 42 it)) *a*)
#(43 44 45 46)
* *a*
#(1 2 3 4)
~~~

`each` は destructive ではなく、新しい配列を作ることに注意してください。`each` へのすべての引数は同じ size の配列でなければならないため、`(aops:each #'+ 42 *a*)` は valid ではありません。

<a id="expression--vectorize"></a>
<a id="vectorize"></a>

### 式のベクトル化

上の `each` 関数に代わる方法として、配列のすべての要素を反復するマクロを使えます。

~~~lisp
(defmacro vectorize (variables &body body)
  ;; Check that variables is a list of only symbols
  (dolist (var variables)
    (if (not (symbolp var))
        (error "~S is not a symbol" var)))

    ;; Get the size of the first variable, and create a new array
    ;; of the same type for the result
    `(let ((size (array-total-size ,(first variables)))  ; Total array size (same for all variables)
           (result (make-array (array-dimensions ,(first variables)) ; Returned array
                               :element-type (array-element-type ,(first variables)))))
       ;; Check that all variables have the same sizeo
       ,@(mapcar (lambda (var) `(if (not (equal (array-dimensions ,(first variables))
                                                (array-dimensions ,var)))
                                    (error "~S and ~S have different dimensions" ',(first variables) ',var)))
              (rest variables))

       (dotimes (indx size)
         ;; Locally redefine variables to be scalars at a given index
         (let ,(mapcar (lambda (var) (list var `(row-major-aref ,var indx))) variables)
           ;; User-supplied function body now evaluated for each index in turn
           (setf (row-major-aref result indx) (progn ,@body))))
       result))
~~~

[Note: このマクロの expanded version は array-operations の [this
fork](https://github.com/bendudson/array-operations) で利用できますが、Quicklisp にはありません]

これは次のように使えます。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (vectorize (*a*) (* 2 *a*))
#(2 4 6 8)
~~~

式の body（`vectorize` 式の 2 番目の form）の中では、シンボル `*a*` は単一の要素に束縛されます。つまり、組み込みの数学関数を使えるということです。

~~~lisp
* (defparameter a #(1 2 3 4))
A
* (defparameter b #(2 3 4 5))
B
* (vectorize (a b) (* a (sin b)))
#(0.9092974 0.28224 -2.2704074 -3.8356972)
~~~

さらに `cmu-infix` と組み合わせられます。

~~~lisp
* (vectorize (a b) #i(a * sin(b)) )
#(0.9092974 0.28224 -2.2704074 -3.8356972)
~~~

### BLAS を呼び出す

高速な行列操作のために、いくつかのパッケージが BLAS のラッパーを提供しています。

quicklisp の [lla](https://github.com/tpapp/lla) パッケージは、いくつかの関数への call を含みます。

<a id="array--scale-"></a>

#### 配列を scale する

constant factor による scaling です。

~~~lisp
* (defparameter a #(1 2 3))
* (lla:scal! 2.0 a)
* a
#(2.0d0 4.0d0 6.0d0)
~~~

#### AXPY

これは `a * x + y` を計算します。ここで `a` は constant、`x` と `y` は配列です。`lla:axpy!` 関数は destructive で、最後の引数 (`y`) を変更します。

~~~lisp
* (defparameter x #(1 2 3))
A
* (defparameter y #(2 3 4))
B
* (lla:axpy! 0.5 x y)
#(2.5d0 4.0d0 5.5d0)
* x
#(1.0d0 2.0d0 3.0d0)
* y
#(2.5d0 4.0d0 5.5d0)
~~~

`y` 配列が complex の場合、この operation はこれらの operator の complex number version を呼び出します。

~~~lisp
* (defparameter x #(1 2 3))
* (defparameter y (make-array 3 :element-type '(complex double-float)
                                :initial-element #C(1d0 1d0)))
* y
#(#C(1.0d0 1.0d0) #C(1.0d0 1.0d0) #C(1.0d0 1.0d0))

* (lla:axpy! #C(0.5 0.5) a b)
#(#C(1.5d0 1.5d0) #C(2.0d0 2.0d0) #C(2.5d0 2.5d0))
~~~

<a id="dot-product"></a>

#### 内積

2 つのベクトルの内積です。

~~~lisp
* (defparameter x #(1 2 3))
* (defparameter y #(2 3 4))
* (lla:dot x y)
20.0d0
~~~

<a id="reductions"></a>

### 畳み込み

[reduce](http://clhs.lisp.se/Body/f_reduce.htm) 関数は、ベクトル（1 次元配列）を含むシーケンスに対して動作しますが、多次元配列には動作しません。これを回避するには、多次元配列を displaced して 1 次元ベクトルを作成できます。displaced 配列は元の配列と storage を共有するため、データのコピーを必要としない高速な演算です。

~~~lisp
* (defparameter a #2A((1 2) (3 4)))
A
* (reduce #'max (make-array (array-total-size a) :displaced-to a))
4
~~~

`array-operations` パッケージには `flatten` があり、displaced 配列、つまりデータをコピーしない配列を返します。

~~~lisp
* (reduce #'max (aops:flatten a))
~~~

SBCL extension の [array-storage-vector](http://www.sbcl.org/manual/#index-array_002dstorage_002dvector) は、同じことを実現する効率的ですが移植性のない方法を提供します。

~~~lisp
* (reduce #'max (array-storage-vector a))
4
~~~

ときには、より複雑な reduction が必要です。たとえば 2 つの配列の maximum absolute difference を求める場合です。上のメソッドを使うと次のようにできます。

~~~lisp
* (defparameter a #2A((1 2) (3 4)))
A
* (defparameter b #2A((1 3) (5 4)))
B
* (reduce #'max (aops:flatten
                  (aops:each
                    (lambda (a b) (abs (- a b))) a b)))
2
~~~

これは中間結果を保持する配列の割り当てを伴い、大きな配列では非効率になり得ます。上で定義した `vectorize` と同様に、割り当てを行わないマクロを次のように定義できます。

~~~lisp
(defmacro vectorize-reduce (fn variables &body body)
  "Performs a reduction using FN over all elements in a vectorized expression
   on array VARIABLES.

   VARIABLES must be a list of symbols bound to arrays.
   Each array must have the same dimensions. These are
   checked at compile and run-time respectively.
  "
  ;; Check that variables is a list of only symbols
  (dolist (var variables)
    (if (not (symbolp var))
        (error "~S is not a symbol" var)))

  (let ((size (gensym)) ; Total array size (same for all variables)
        (result (gensym)) ; Returned value
        (indx (gensym)))  ; Index inside loop from 0 to size

    ;; Get the size of the first variable
    `(let ((,size (array-total-size ,(first variables))))
       ;; Check that all variables have the same size
       ,@(mapcar (lambda (var) `(if (not (equal (array-dimensions ,(first variables))
                                                (array-dimensions ,var)))
                                    (error "~S and ~S have different dimensions" ',(first variables) ',var)))
              (rest variables))

       ;; Apply FN with the first two elements (or fewer if size < 2)
       (let ((,result (apply ,fn (loop for ,indx below (min ,size 2) collecting
                                      (let ,(map 'list (lambda (var) (list var `(row-major-aref ,var ,indx))) variables)
                                        (progn ,@body))))))

         ;; Loop over the remaining indices
         (loop for ,indx from 2 below ,size do
            ;; Locally redefine variables to be scalars at a given index
              (let ,(mapcar (lambda (var) (list var `(row-major-aref ,var ,indx))) variables)
                ;; User-supplied function body now evaluated for each index in turn
                (setf ,result (funcall ,fn ,result (progn ,@body)))))
         ,result))))

~~~

[Note: このマクロは array-operations の [this fork](https://github.com/bendudson/array-operations) で利用できますが、Quicklisp にはありません]

このマクロを使うと、任意の shape の配列 A における maximum 値は次のように求められます。

~~~lisp
* (vectorize-reduce #'max (a) a)
~~~

同じ shape でありさえすれば、任意の shape の 2 つの配列 A と B の maximum absolute difference は次です。

~~~lisp
* (vectorize-reduce #'max (a b) (abs (- a b)))
~~~

<a id="linear-algebra"></a>

## 線形代数

いくつかのパッケージが BLAS と LAPACK ライブラリへのバインディングを提供しています。たとえば次です。

- [lla](https://github.com/tpapp/lla)
- [MAGICL](https://github.com/rigetticomputing/magicl)

利用可能なパッケージのより長い list は [CLiki's linear algebra page](https://www.cliki.net/linear%20algebra) にあります。

下の例では lla パッケージがロードされています。

~~~lisp
* (ql:quickload :lla)

To load "lla":
  Load 1 ASDF system:
    lla
; Loading "lla"
.
(:LLA)
~~~

<a id="matrix-multiplication"></a>

### 行列の乗算

[lla](https://github.com/tpapp/lla) の関数 `mm` は、ベクトル同士、行列とベクトル、行列同士の乗算を行います。

<a id="vector-dot-product"></a>

#### ベクトルの内積

一方のベクトルは行ベクトルとして、もう一方は列ベクトルとして扱われることに注意してください。

~~~lisp
* (lla:mm #(1 2 3) #(2 3 4))
20
~~~

<a id="matrix-vector-product"></a>

#### 行列とベクトルの積

~~~lisp
* (lla:mm #2A((1 1 1) (2 2 2) (3 3 3))  #(2 3 4))
#(9.0d0 18.0d0 27.0d0)
~~~

これは `A[i j] * x[j]` について `j` の sum を実行しています。

<a id="matrix-matrix-multiply"></a>

#### 行列同士の乗算

~~~lisp
* (lla:mm #2A((1 2 3) (1 2 3) (1 2 3))  #2A((2 3 4) (2 3 4) (2 3 4)))
#2A((12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0))
~~~

これは `A[i j] * B[j k]` において `j` について sum しています。

返される配列の type は単純配列で、element type `double-float` に specialised されていることに注意してください。

~~~lisp
* (type-of (lla:mm #2A((1 0 0) (0 1 0) (0 0 1)) #(1 2 3)))
(SIMPLE-ARRAY DOUBLE-FLOAT (3))
~~~

<a id="outer-product"></a>

#### 外積

[array-operations](https://github.com/Lisp-Stat/array-operations) パッケージには、一般化された[外積](https://en.wikipedia.org/wiki/Outer_product)関数が含まれます。

~~~lisp
* (ql:quickload :array-operations)
To load "array-operations":
  Load 1 ASDF system:
    array-operations
; Loading "array-operations"

(:ARRAY-OPERATIONS)
* (aops:outer #'* #(1 2 3) #(2 3 4))
#2A((2 3 4) (4 6 8) (6 9 12))
~~~

これは新しい 2 次元配列 `A[i j] = B[i] * C[j]` を作成しています。この `outer` 関数は任意個の input と、multiple dimension を持つ input を取れます。

<a id="matrix-inverse"></a>

### 逆行列

密行列の逆行列は `invert` で計算できます。

~~~lisp
* (lla:invert #2A((1 0 0) (0 1 0) (0 0 1)))
#2A((1.0d0 0.0d0 -0.0d0) (0.0d0 1.0d0 -0.0d0) (0.0d0 0.0d0 1.0d0))
~~~

e.g

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter b (lla:invert a))
B
* (lla:mm a b)
#2A((1.0d0 2.220446049250313d-16 0.0d0)
    (0.0d0 1.0d0 0.0d0)
    (0.0d0 1.1102230246251565d-16 0.9999999999999998d0))
~~~

逆行列を直接計算することは、特に大きな行列では一般におすすめできません。代わりに [LU 分解](https://en.wikipedia.org/wiki/LU_decomposition)を計算し、複数回の逆行列計算に使えます。

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter b (lla:mm a #(1 2 3)))
B
* (lla:solve (lla:lu a) b)
#(1.0d0 2.0d0 3.0d0)
~~~

<a id="singular-value-decomposition"></a>

### 特異値分解

`svd` 関数は、与えられた行列の[特異値分解](https://en.wikipedia.org/wiki/Singular-value_decomposition)を計算し、得られる 3 つの行列を格納するスロットを持つオブジェクトを返します。

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter a-svd (lla:svd a))
A-SVD
* a-svd
#S(LLA:SVD
   :U #2A((-0.6494608633564334d0 0.7205486773948702d0 0.24292013188045855d0)
          (-0.3744175632000917d0 -0.5810891192666799d0 0.7225973455785591d0)
          (-0.6618248071322363d0 -0.3783451320875919d0 -0.6471807210432038d0))
   :D #S(CL-NUM-UTILS.MATRIX:DIAGONAL-MATRIX
         :ELEMENTS #(5.593122609997059d0 1.2364443401235103d0
                     0.43380279311714376d0))
   :VT #2A((-0.2344460799312531d0 -0.7211054639318696d0 -0.6519524104506949d0)
           (0.2767642134809678d0 -0.6924017945853318d0 0.6663192365460215d0)
           (-0.9318994611765425d0 -0.02422116311440764d0 0.3619070730398283d0)))
~~~

対角行列（特異値）とベクトルには関数でアクセスできます。

~~~lisp
(lla:svd-u a-svd)
#2A((-0.6494608633564334d0 0.7205486773948702d0 0.24292013188045855d0)
    (-0.3744175632000917d0 -0.5810891192666799d0 0.7225973455785591d0)
    (-0.6618248071322363d0 -0.3783451320875919d0 -0.6471807210432038d0))

* (lla:svd-d a-svd)
#S(CL-NUM-UTILS.MATRIX:DIAGONAL-MATRIX
   :ELEMENTS #(5.593122609997059d0 1.2364443401235103d0 0.43380279311714376d0))

* (lla:svd-vt a-svd)
#2A((-0.2344460799312531d0 -0.7211054639318696d0 -0.6519524104506949d0)
    (0.2767642134809678d0 -0.6924017945853318d0 0.6663192365460215d0)
    (-0.9318994611765425d0 -0.02422116311440764d0 0.3619070730398283d0))
~~~


## Matlisp

[Matlisp](https://github.com/bharath1097/matlisp/) scientific computation ライブラリは、BLAS と LAPACK 関数のラッパーを含み、配列に対する高性能な演算を提供します。quicklisp でロードできます。

~~~lisp
* (ql:quickload :matlisp)
~~~

`matlisp` の nickname は `m` です。各シンボルの前に `matlisp:` や `m:` と入力するのを避けるには、matlisp を use する自分用のパッケージを定義できます（[PCL のパッケージ節](http://www.gigamonkeys.com/book/programming-in-the-large-packages-and-symbols.html)を参照）。

~~~lisp
* (defpackage :my-new-code
     (:use :common-lisp :matlisp))
#<PACKAGE "MY-NEW-CODE">

* (in-package :my-new-code)
~~~

また、`#i` infix reader (`cmu-infix` と同じ name であることに注意) を使うには、次を実行します。

~~~lisp
* (named-readtables:in-readtable :infix-dispatch-table)
~~~

### 作成 tensors

~~~lisp
* (matlisp:zeros '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.000    0.000
  0.000    0.000
>
~~~

default では行列の格納型が `double-float` であることに注意してください。`zeros`、`ones`、`eye` を使って複素配列を作るには、type を指定します。

~~~lisp
* (matlisp:zeros '(2 2) '((complex double-float)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: (COMPLEX DOUBLE-FLOAT)>| #(2 2)
  0.000    0.000
  0.000    0.000
>
~~~

`zeros` と `ones` に加えて、単位行列を作る `eye` があります。

~~~lisp
* (matlisp:eye '(3 3) '((complex double-float)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: (COMPLEX DOUBLE-FLOAT)>| #(3 3)
  1.000    0.000    0.000
  0.000    1.000    0.000
  0.000    0.000    1.000
>
~~~

#### Range

1 次元配列を生成するには `range` と `linspace` 関数があります。

~~~lisp
* (matlisp:range 1 10)
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(9)
 1   2   3   4   5   6   7   8   9
>
~~~

`range` 関数は final 引数を integer に切り下げます。

~~~lisp
* (matlisp:range 1 -3.5)
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: SINGLE-FLOAT>| #(5)
 1.000   0.000   -1.000  -2.000  -3.000
>
* (matlisp:range 1 3.3)
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: SINGLE-FLOAT>| #(3)
 1.000   2.000   3.000
>
~~~

Linspace は少しより一般的で、返される値は end point を含みます。

~~~lisp
* (matlisp:linspace 1 10)
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(10)
 1   2   3   4   5   6   7   8   9   10
>
~~~

~~~lisp
* (matlisp:linspace 0 (* 2 pi) 5)
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(5)
 0.000   1.571   3.142   4.712   6.283
>
~~~

現在 `linspace` は real input を必要とし、complex number では動きません。

#### 乱数

~~~lisp
* (matlisp:random-uniform '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.7287       0.9480
  2.6703E-2    0.1834
>
~~~

~~~lisp
(matlisp:random-normal '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.3536    -1.291
 -0.3877    -1.371
>
~~~

他の distribution 用の関数もあり、`random-exponential`、`random-beta`、`random-gamma`、`random-pareto` などが含まれます。

#### Reader macro

`#d` と `#e` reader マクロは、`double-float` と `single-float` tensor を作る方法を提供します。

~~~lisp
* #d[1,2,3]
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(3)
 1.000   2.000   3.000
>

* #d[[1,2,3],[4,5,6]]
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    2.000    3.000
  4.000    5.000    6.000
>
~~~

comma separator が必要であることに注意してください。

<a id="array--tensor-"></a>

#### 配列から tensor へ

Common Lisp 配列はコピーによって Matlisp tensor に変換できます。

~~~lisp
* (copy #2A((1 2 3)
            (4 5 6))
        '#.(tensor 'double-float))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    2.000    3.000
  4.000    5.000    6.000
>
~~~

dimension を指定して `tensor` クラスの instance を作成することもできます。`tensor` オブジェクトの内部ストレージは、スロット `store` 内の 1 次元配列 (`simple-vector`) です。

たとえば、`double-float` type の tensor を作るには次のようにします。

~~~lisp
(make-instance (tensor 'double-float)
    :dimensions  (coerce '(2) '(simple-array index-type (*)))
    :store (make-array 2 :element-type 'double-float))
~~~

<a id="tensor--array-"></a>

#### tensor から配列へ

配列の store にはスロットを使ってアクセスできます。

~~~lisp
* (defparameter vec (m:range 0 5))
* vec
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(5)
 0   1   2   3   4
>
* (slot-value vec 'm:store)
#(0 1 2 3 4)
~~~

multidimensional tensor も 1 次元配列に格納され、Common Lisp 配列で使われる row-major ordering ではなく column-major order で格納されます。したがって displaced 配列は transpose されます。

tensor の contents は配列へコピーできます。

~~~lisp
* (let ((tens (m:ones '(2 3))))
    (m:copy tens 'array))
#2A((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

または list へコピーできます。

~~~lisp
* (m:copy (m:ones '(2 3)) 'cons)
((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

<a id="element-access"></a>

### 要素へのアクセス

`ref` 関数は標準 CL 配列に対する `aref` に相当し、setf-able でもあります。

~~~lisp
* (defparameter a (matlisp:ones '(2 3)))

* (setf (ref a 1 1) 2.0)
2.0d0
* a
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    1.000    1.000
  1.000    2.000    1.000
>
~~~

<a id="element-wise-operations-1"></a>

### 要素ごとの演算

`matlisp` とともにロードされる `matlisp-user` パッケージには、tensor の要素ごとに演算する関数が含まれます。

~~~lisp
* (matlisp-user:* 2 (ones '(2 3)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  2.000    2.000    2.000
  2.000    2.000    2.000
>
~~~

これには arithmetic operator '+', '-', '*', '/' と 'expt' だけでなく、`sqrt`,`sin`,`cos`,`tan`、hyperbolic 関数、およびそれらの inverse も含まれます。`#i` reader マクロはこれらの多くを認識し、`matlisp-user` 関数を使います。

~~~lisp
* (let ((a (ones '(2 2)))
        (b (random-normal '(2 2))))
     #i( 2 * a + b ))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.9684    3.250
  1.593     1.508
>

* (let ((a (ones '(2 2)))
        (b (random-normal '(2 2))))
     (macroexpand-1 '#i( 2 * a + b )))
(MATLISP-USER:+ (MATLISP-USER:* 2 A) B)
~~~
