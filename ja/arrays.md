---
title: 多次元配列
---

Common Lisp は多次元配列を native に support しており、1-D array には `vectors` と呼ばれる特別な扱いがあります。array は *generalised* で任意の type (`element-type t`) を含めることも、`single-float` や `integer` など specific type を含むよう *specialised* することもできます。出発点としては、Peter Seibel による [Practical Common Lisp Chapter 11, Collections](http://www.gigamonkeys.com/book/collections.html) がよいでしょう。

array に対する一般的な operation の quick reference は、[Arrays and vectors](data-structures.html) の section にあります。

array を操作するために [Quicklisp](https://www.quicklisp.org/beta/) で利用できる library には、次のものがあります。

- [array-operations](https://github.com/Lisp-Stat/array-operations) は lisp-stat project 由来で、
  `generate`, `permute`, `displace`, `flatten`, `split`,
  `combine`, `reshape` function を定義します。また、element-wise
  operation 用の `each` も定義します。これは [bendudson/array-operations](https://github.com/bendudson/array-operations) の fork であり、さらにそれは original
  author による [tpapp/array-operations](https://github.com/tpapp/array-operations) の fork です。
- [cmu-infix](https://github.com/rigetticomputing/cmu-infix) は、
  多次元 array 用の array indexing syntax を含みます。
- [lla](https://github.com/tpapp/lla) は linear algebra 用 library で、BLAS と LAPACK
  library を呼び出します。多くの CL linear algebra package と違って
  直感的な function name を使い、native array だけでなく
  CLOS object に対しても動作できます。

この page では built-in の多次元 array でできることを扱いますが、制限もあります。特に次の点です。

* foreign language array との interoperability。たとえば BLAS、LAPACK、GSL のような library を呼び出す場合です。
* arithmetic operator やその他の mathematical operator を、array を扱えるように拡張すること。たとえば `a` や `b` が array のときに `(+ a b)` が動くようにする場合です。

これら 2 つの問題は、native array を special case として持つ extended array class を CLOS で定義することで解決できます。この approach を取る [quicklisp](https://www.quicklisp.org/beta/) 経由で利用可能な library には、次があります。

* [matlisp](https://github.com/bharath1097/matlisp/)。その一部は
  下の section で説明します。
* [MGL-MAT](https://github.com/melisgl/mgl-mat)。manual があり、
  BLAS と CUDA への binding を提供します。これは machine
  learning library [MGL](https://github.com/melisgl/mgl) で使われています。
* [cl-ana](https://github.com/ghollisjr/cl-ana/wiki)。manual 付きの data analysis
  package で、array に対する operation を含みます。
* [Antik](https://www.common-lisp.net/project/antik/)。GNU Scientific Library の
  への binding である [GSLL](https://common-lisp.net/project/gsll/) で使われています。

比較的新しく活発に開発されている package として [MAGICL](https://github.com/rigetticomputing/magicl) があります。これは BLAS と LAPACK library の wrapper を提供します。執筆時点ではこの package は Quicklisp に含まれておらず、SBCL と CCL でのみ動きます。特に complex array に焦点を当てているようですが、それだけに限定されているわけではありません。install するには、たとえば Linux/Unix では quicklisp の `local-projects` directory に repository を clone します。

~~~bash
$ cd ~/quicklisp/local-projects
$ git clone https://github.com/rigetticomputing/magicl.git
~~~

dependency (BLAS、LAPACK、Expokit) の install 手順は [github web pages](https://github.com/rigetticomputing/magicl) にあります。low-level routine は foreign function を wrap しているため、たとえば `magicl.lapack-cffi::%zgetrf` のような Fortran name を持ちます。これらの function の一部には higher-level interface も存在します。[source directory](https://github.com/rigetti/magicl/blob/master/src/high-level/) と [documentation](https://github.com/quil-lang/magicl/blob/master/doc/high-level.md) を参照してください。

さらに進むと、Common Lisp 上に domain specific language が構築されており、array を使った numerical calculation に利用できます。執筆時点で、これらの中でも最も広く使われ support されているものは次です。

* [Maxima](http://maxima.sourceforge.net/documentation.html)
* [Axiom](https://github.com/daly/axiom)


[CLASP](https://github.com/drmeister/clasp) は、[LLVM](http://llvm.org/) を使って Common Lisp と他の language (特に C++) との interoperability を容易にすることを目指す project です。この project の主要な application の 1 つは numerical/scientific computing です。

## 作成

function [CLHS: make-array](http://clhs.lisp.se/Body/f_mk_ar.htm) は、単一の value で満たされた array を作成できます。

~~~lisp
* (defparameter *my-array* (make-array '(3 2) :initial-element 1.0))
*MY-ARRAY*
* *my-array*
#2A((1.0 1.0) (1.0 1.0) (1.0 1.0))
~~~

より複雑な array value は、まず array を作り、その後 element を反復して value を埋めることで生成できます (element access については下の section を参照してください)。

[array-operations](https://github.com/tpapp/array-operations) library は、この iteration を wrap して array を作成する便利な function `generate` を提供します。

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

`array-operations` の nickname は `aops` であることに注意してください。`generate` function は key `:subscripts` を渡すことで array subscript も反復できます。さらに多くの例は [Array Operations manual on generate](https://lisp-stat.dev/docs/manuals/array-operations/#generate) を参照してください。

### 乱数

uniform distribution から引いた random number を含む 3x3 array を作るには、`generate` を使って CL の [random](http://clhs.lisp.se/Body/f_random.htm) function を呼び出せます。

~~~lisp
* (aops:generate (lambda () (random 1.0)) '(3 3))
#2A((0.99292254 0.929777 0.93538976)
    (0.31522608 0.45167792 0.9411855)
    (0.96221936 0.9143338 0.21972346))
~~~

[alexandria](https://common-lisp.net/project/alexandria/) package を使った、mean が 0、standard deviation が 1 の Gaussian (normal) random number の array です。

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

これは特に効率的ではないことに注意してください。各 element ごとに function call が必要であり、`gaussian-random` は 2 つの random number を返しますが、そのうち 1 つしか使われません。

より効率的な implementation や、より広い範囲の probability distribution には、Quicklisp で利用できる package があります。一覧は [CLiki](https://www.cliki.net/statistics) を参照してください。

## element への access

array の個々の element に access するには、[aref](http://clhs.lisp.se/Body/f_aref.htm) と [row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) function があります。

[aref](http://clhs.lisp.se/Body/f_aref.htm) function は、array の dimension 数と同じ数の index argument を取ります。indexing は 0 から始まり、C と同じ row-major ですが、Fortran とは異なります。

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

また、array の rank を調べ、その後で各 dimension の size を query できます。

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

array を loop するには、次のような nested loop を使えます。

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

これを multiple dimension に対して行う utility macro が `nested-loop` です。

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

これにより、2D array の contents は次のように print できます。

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

[Note: この macro は array-operations の [this fork](https://github.com/bendudson/array-operations) で利用できますが、Quicklisp にはありません]

### Row major indexing

場合によっては、特に element-wise operation では、dimension の数は重要ではありません。dimension 数に依存しない code を書くには、[row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) によって単一の flattened index を使い、array element に access できます。array size は [array-total-size](http://clhs.lisp.se/Body/f_ar_tot.htm) で与えられ、flattened index は 0 から始まります。

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

[cmu-infix](https://github.com/rigetticomputing/cmu-infix) library は、mathematical expression を読みやすくできる少し異なる syntax を提供します。

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

matrix-matrix multiply operation は次のように実装できます。

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

別の matrix-multiply implementation については、下の linear algebra section を参照してください。

## Element-wise operations

同じ size の 2 つの number array を掛け合わせるには、[array-operations](https://github.com/Lisp-Stat/array-operations) library の `each` に function を渡します。

~~~lisp
* (aops:each #'* #(1 2 3) #(2 3 4))
#(2 6 12)
~~~

効率を高めるために `aops:each*` function があります。これは result array を specialize するため、最初の argument に type を取ります。

array のすべての element に constant を加えるには、次のようにします。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (aops:each (lambda (it) (+ 42 it)) *a*)
#(43 44 45 46)
* *a*
#(1 2 3 4)
~~~

`each` は destructive ではなく、新しい array を作ることに注意してください。`each` へのすべての argument は同じ size の array でなければならないため、`(aops:each #'+ 42 *a*)` は valid ではありません。

### expression の vectorize

上の `each` function に対する代替 approach は、array のすべての element を反復する macro を使うことです。

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

[Note: この macro の expanded version は array-operations の [this
fork](https://github.com/bendudson/array-operations) で利用できますが、Quicklisp にはありません]

これは次のように使えます。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (vectorize (*a*) (* 2 *a*))
#(2 4 6 8)
~~~

expression の body (`vectorize` expression の 2 番目の form) の中では、symbol `*a*` は single element に bind されます。つまり built-in mathematical function を使えるということです。

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

fast matrix manipulation のために、いくつかの package が BLAS の wrapper を提供しています。

quicklisp の [lla](https://github.com/tpapp/lla) package は、いくつかの function への call を含みます。

#### array を scale する

constant factor による scaling です。

~~~lisp
* (defparameter a #(1 2 3))
* (lla:scal! 2.0 a)
* a
#(2.0d0 4.0d0 6.0d0)
~~~

#### AXPY

これは `a * x + y` を計算します。ここで `a` は constant、`x` と `y` は array です。`lla:axpy!` function は destructive で、最後の argument (`y`) を変更します。

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

`y` array が complex の場合、この operation はこれらの operator の complex number version を呼び出します。

~~~lisp
* (defparameter x #(1 2 3))
* (defparameter y (make-array 3 :element-type '(complex double-float)
                                :initial-element #C(1d0 1d0)))
* y
#(#C(1.0d0 1.0d0) #C(1.0d0 1.0d0) #C(1.0d0 1.0d0))

* (lla:axpy! #C(0.5 0.5) a b)
#(#C(1.5d0 1.5d0) #C(2.0d0 2.0d0) #C(2.5d0 2.5d0))
~~~

#### Dot product

2 つの vector の dot product です。

~~~lisp
* (defparameter x #(1 2 3))
* (defparameter y #(2 3 4))
* (lla:dot x y)
20.0d0
~~~

### Reductions

[reduce](http://clhs.lisp.se/Body/f_reduce.htm) function は vector (1D array) を含む sequence に対して動作しますが、多次元 array には動作しません。これを回避するには、多次元 array を displaced して 1D vector を作成できます。displaced array は original array と storage を共有するため、data copy を必要としない fast operation です。

~~~lisp
* (defparameter a #2A((1 2) (3 4)))
A
* (reduce #'max (make-array (array-total-size a) :displaced-to a))
4
~~~

`array-operations` package には `flatten` があり、displaced array、つまり data を copy しない array を返します。

~~~lisp
* (reduce #'max (aops:flatten a))
~~~

SBCL extension の [array-storage-vector](http://www.sbcl.org/manual/#index-array_002dstorage_002dvector) は、同じことを達成する efficient だが portable ではない方法を提供します。

~~~lisp
* (reduce #'max (array-storage-vector a))
4
~~~

ときには、より複雑な reduction が必要です。たとえば 2 つの array の maximum absolute difference を求める場合です。上の method を使うと次のようにできます。

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

これは intermediate result を保持する array の allocation を伴い、大きな array では非効率になり得ます。上で定義した `vectorize` と同様に、allocate しない macro を次のように定義できます。

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

[Note: この macro は array-operations の [this fork](https://github.com/bendudson/array-operations) で利用できますが、Quicklisp にはありません]

この macro を使うと、任意の shape の array A における maximum value は次のように求められます。

~~~lisp
* (vectorize-reduce #'max (a) a)
~~~

同じ shape でありさえすれば、任意の shape の 2 つの array A と B の maximum absolute difference は次です。

~~~lisp
* (vectorize-reduce #'max (a b) (abs (- a b)))
~~~

## Linear algebra

いくつかの package が BLAS と LAPACK library への binding を提供しています。たとえば次です。

- [lla](https://github.com/tpapp/lla)
- [MAGICL](https://github.com/rigetticomputing/magicl)

利用可能な package のより長い list は [CLiki's linear algebra page](https://www.cliki.net/linear%20algebra) にあります。

下の例では lla package が load されています。

~~~lisp
* (ql:quickload :lla)

To load "lla":
  Load 1 ASDF system:
    lla
; Loading "lla"
.
(:LLA)
~~~

### Matrix multiplication

[lla](https://github.com/tpapp/lla) function `mm` は vector-vector、matrix-vector、matrix-matrix multiplication を行います。

#### Vector dot product

一方の vector は row vector として、もう一方は column として扱われることに注意してください。

~~~lisp
* (lla:mm #(1 2 3) #(2 3 4))
20
~~~

#### Matrix-vector product

~~~lisp
* (lla:mm #2A((1 1 1) (2 2 2) (3 3 3))  #(2 3 4))
#(9.0d0 18.0d0 27.0d0)
~~~

これは `A[i j] * x[j]` について `j` の sum を実行しています。

#### Matrix-matrix multiply

~~~lisp
* (lla:mm #2A((1 2 3) (1 2 3) (1 2 3))  #2A((2 3 4) (2 3 4) (2 3 4)))
#2A((12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0))
~~~

これは `A[i j] * B[j k]` において `j` について sum しています。

返される array の type は simple array で、element type `double-float` に specialised されていることに注意してください。

~~~lisp
* (type-of (lla:mm #2A((1 0 0) (0 1 0) (0 0 1)) #(1 2 3)))
(SIMPLE-ARRAY DOUBLE-FLOAT (3))
~~~

#### Outer product

[array-operations](https://github.com/Lisp-Stat/array-operations) package には generalised [outer product](https://en.wikipedia.org/wiki/Outer_product) function が含まれます。

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

これは新しい 2D array `A[i j] = B[i] * C[j]` を作成しています。この `outer` function は任意個の input と、multiple dimension を持つ input を取れます。

### Matrix inverse

dense matrix の direct inverse は `invert` で計算できます。

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

direct inverse を計算することは、特に大きな matrix では一般におすすめできません。代わりに [LU decomposition](https://en.wikipedia.org/wiki/LU_decomposition) を計算し、複数の inversion に使えます。

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter b (lla:mm a #(1 2 3)))
B
* (lla:solve (lla:lu a) b)
#(1.0d0 2.0d0 3.0d0)
~~~

### Singular value decomposition

`svd` function は、与えられた matrix の [singular value decomposition](https://en.wikipedia.org/wiki/Singular-value_decomposition) を計算し、返される 3 つの matrix 用の slot を持つ object を返します。

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

diagonal matrix (singular value) と vector は function で access できます。

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

[Matlisp](https://github.com/bharath1097/matlisp/) scientific computation library は、BLAS と LAPACK function の wrapper を含む、array に対する high performance operation を提供します。quicklisp で load できます。

~~~lisp
* (ql:quickload :matlisp)
~~~

`matlisp` の nickname は `m` です。各 symbol の前に `matlisp:` や `m:` と入力するのを避けるには、matlisp を use する自分用の package を定義できます ([PCL section on packages](http://www.gigamonkeys.com/book/programming-in-the-large-packages-and-symbols.html) を参照)。

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

default では matrix storage type は `double-float` であることに注意してください。`zeros`、`ones`、`eye` を使って complex array を作るには、type を指定します。

~~~lisp
* (matlisp:zeros '(2 2) '((complex double-float)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: (COMPLEX DOUBLE-FLOAT)>| #(2 2)
  0.000    0.000
  0.000    0.000
>
~~~

`zeros` と `ones` に加えて、identity matrix を作る `eye` があります。

~~~lisp
* (matlisp:eye '(3 3) '((complex double-float)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: (COMPLEX DOUBLE-FLOAT)>| #(3 3)
  1.000    0.000    0.000
  0.000    1.000    0.000
  0.000    0.000    1.000
>
~~~

#### Range

1D array を生成するには `range` と `linspace` function があります。

~~~lisp
* (matlisp:range 1 10)
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(9)
 1   2   3   4   5   6   7   8   9
>
~~~

`range` function は final argument を integer に切り下げます。

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

Linspace は少しより一般的で、返される value は end point を含みます。

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

他の distribution 用の function もあり、`random-exponential`、`random-beta`、`random-gamma`、`random-pareto` などが含まれます。

#### Reader macro

`#d` と `#e` reader macro は、`double-float` と `single-float` tensor を作る方法を提供します。

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

#### array から tensor へ

Common Lisp array は copy によって Matlisp tensor に変換できます。

~~~lisp
* (copy #2A((1 2 3)
            (4 5 6))
        '#.(tensor 'double-float))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    2.000    3.000
  4.000    5.000    6.000
>
~~~

dimension を指定して `tensor` class の instance を作成することもできます。`tensor` object の internal storage は、slot `store` 内の 1D array (`simple-vector`) です。

たとえば、`double-float` type の tensor を作るには次のようにします。

~~~lisp
(make-instance (tensor 'double-float)
    :dimensions  (coerce '(2) '(simple-array index-type (*)))
    :store (make-array 2 :element-type 'double-float))
~~~

#### tensor から array へ

array store は slot を使って access できます。

~~~lisp
* (defparameter vec (m:range 0 5))
* vec
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(5)
 0   1   2   3   4
>
* (slot-value vec 'm:store)
#(0 1 2 3 4)
~~~

multidimensional tensor も 1D array に格納され、Common Lisp array で使われる row-major ordering ではなく column-major order で格納されます。したがって displaced array は transpose されます。

tensor の contents は array へ copy できます。

~~~lisp
* (let ((tens (m:ones '(2 3))))
    (m:copy tens 'array))
#2A((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

または list へ copy できます。

~~~lisp
* (m:copy (m:ones '(2 3)) 'cons)
((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

### Element access

`ref` function は standard CL array に対する `aref` に相当し、setf-able でもあります。

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

### Element-wise operations

`matlisp` が load されたときに load される `matlisp-user` package には、tensor に対して element-wise に操作する function が含まれます。

~~~lisp
* (matlisp-user:* 2 (ones '(2 3)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  2.000    2.000    2.000
  2.000    2.000    2.000
>
~~~

これには arithmetic operator '+', '-', '*', '/' と 'expt' だけでなく、`sqrt`,`sin`,`cos`,`tan`、hyperbolic function、およびそれらの inverse も含まれます。`#i` reader macro はこれらの多くを認識し、`matlisp-user` function を使います。

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
