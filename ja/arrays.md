---
title: 多次元配列
---

Common Lisp は多次元配列をネイティブにサポートしており、1 次元配列には「ベクトル」という特別な扱いがあります。配列は汎用化されており、任意の型（`element-type t`）の要素を含められます。また、`single-float` や `integer` など、特定の型の要素だけを含むよう特殊化することもできます。出発点としては、Peter Seibel による [Practical Common Lisp 第11章「コレクション」](http://www.gigamonkeys.com/book/collections.html) がよいでしょう。

配列に対する一般的な操作の早見表は、[配列とベクトル](data-structures.html) の節にあります。

配列を操作するために [Quicklisp](https://www.quicklisp.org/beta/) で利用できるライブラリには、次のものがあります。

- [array-operations](https://github.com/Lisp-Stat/array-operations) は Lisp-Stat プロジェクトに由来し、
  `generate`, `permute`, `displace`, `flatten`, `split`,
  `combine`, `reshape` 関数を定義します。また、要素ごとの
  演算に使う `each` も定義します。これは [bendudson/array-operations](https://github.com/bendudson/array-operations) のフォークであり、さらにこれは原作者による [tpapp/array-operations](https://github.com/tpapp/array-operations) から派生しています。
- [cmu-infix](https://github.com/rigetticomputing/cmu-infix) は、
  多次元配列用の添字構文を含みます。
- [lla](https://github.com/tpapp/lla) は線形代数用ライブラリで、BLAS と LAPACK
  ライブラリを呼び出します。多くの Common Lisp 線形代数パッケージと違って
  直感的な関数名を使い、ネイティブ配列だけでなく
  CLOS オブジェクトに対しても動作できます。

このページでは組み込みの多次元配列でできることを扱いますが、制限もあります。特に次の点です。

* 外部言語の配列との相互運用性。たとえば BLAS、LAPACK、GSL のようなライブラリを呼び出す場合です。
* 算術演算子やその他の数学演算子を、配列も扱えるように拡張すること。たとえば `a` や `b` が配列のときに `(+ a b)` が動作するようにする場合です。

これら 2 つの問題は、ネイティブ配列を特殊なケースとして持つ拡張配列クラスを CLOS で定義することで解決できます。この手法を採用し、[Quicklisp](https://www.quicklisp.org/beta/) 経由で利用できるライブラリには、次のものがあります。

* [matlisp](https://github.com/bharath1097/matlisp/)。その一部は
  下の節で説明します。
* [MGL-MAT](https://github.com/melisgl/mgl-mat)。マニュアルがあり、
  BLAS と CUDA へのバインディングを提供します。これは機械学習ライブラリ
  [MGL](https://github.com/melisgl/mgl) で使われています。
* [cl-ana](https://github.com/ghollisjr/cl-ana/wiki)。マニュアル付きのデータ分析
パッケージで、配列に対する操作を含みます。
* [Antik](https://www.common-lisp.net/project/antik/)。GNU Scientific Library（GNU 科学技術計算ライブラリ）
  へのバインディングである [GSLL](https://common-lisp.net/project/gsll/) で使われています。

比較的新しく活発に開発されているパッケージとして [MAGICL](https://github.com/rigetticomputing/magicl) があります。これは BLAS と LAPACK ライブラリのラッパーを提供します。執筆時点ではこのパッケージは Quicklisp に含まれておらず、SBCL と CCL でのみ動きます。特に複素配列に焦点を当てているようですが、それだけに限定されているわけではありません。インストールするには、たとえば Linux/Unix では Quicklisp の `local-projects` ディレクトリにリポジトリをクローンします。

~~~bash
$ cd ~/quicklisp/local-projects
$ git clone https://github.com/rigetticomputing/magicl.git
~~~

依存ライブラリ（BLAS、LAPACK、Expokit）のインストール手順は [GitHub のページ](https://github.com/rigetticomputing/magicl)にあります。低水準ルーチンは外部関数をラップしているため、たとえば `magicl.lapack-cffi::%zgetrf` のような Fortran の名前を持ちます。これらの関数の一部には高水準インターフェイスも存在します。[ソースディレクトリ](https://github.com/rigetti/magicl/blob/master/src/high-level/)と[ドキュメント](https://github.com/quil-lang/magicl/blob/master/doc/high-level.md)を参照してください。

さらに、Common Lisp 上に構築されたドメイン固有言語を、配列を使った数値計算に利用できます。執筆時点で、これらの中でも最も広く使われ、活発にサポートされているものは次のとおりです。

* [Maxima](http://maxima.sourceforge.net/documentation.html)
* [Axiom](https://github.com/daly/axiom)


[CLASP](https://github.com/drmeister/clasp) は、[LLVM](http://llvm.org/) を使って Common Lisp と他の言語（特に C++）との相互運用を容易にすることを目指すプロジェクトです。このプロジェクトの主要な用途の 1 つが、数値計算と科学技術計算です。

## 作成

関数 [CLHS: make-array](http://clhs.lisp.se/Body/f_mk_ar.htm) は、単一の値で満たされた配列を作成できます。

~~~lisp
* (defparameter *my-array* (make-array '(3 2) :initial-element 1.0))
*MY-ARRAY*
* *my-array*
#2A((1.0 1.0) (1.0 1.0) (1.0 1.0))
~~~

より複雑な配列値は、まず配列を作り、その後、各要素を反復して値を埋めることで生成できます（要素へのアクセスについては下の節を参照してください）。

[array-operations](https://github.com/tpapp/array-operations) ライブラリは、この反復処理をラップして配列を作成する便利な関数 `generate` を提供します。

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

`array-operations` のニックネームは `aops` です。`generate` 関数はキー `:subscripts` を渡すことで配列の添字も反復できます。さらに多くの例は [array-operations の `generate` マニュアル](https://lisp-stat.dev/docs/manuals/array-operations/#generate) を参照してください。

### 乱数

一様分布から得た乱数を含む 3 × 3 配列を作るには、`generate` から Common Lisp の [random](http://clhs.lisp.se/Body/f_random.htm) 関数を呼び出します。

~~~lisp
* (aops:generate (lambda () (random 1.0)) '(3 3))
#2A((0.99292254 0.929777 0.93538976)
    (0.31522608 0.45167792 0.9411855)
    (0.96221936 0.9143338 0.21972346))
~~~

[Alexandria](https://common-lisp.net/project/alexandria/) パッケージを使って、平均 0、標準偏差 1 のガウス分布（正規分布）に従う乱数の配列を作る例です。

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

[aref](http://clhs.lisp.se/Body/f_aref.htm) 関数は、配列の次元数と同じ数のインデックス引数を取ります。インデックスは 0 から始まります。要素の格納順序は C と同じ行優先ですが、Fortran とは異なります。

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

各インデックスの範囲は [array-dimensions](http://clhs.lisp.se/Body/f_ar_d_1.htm) で調べられます。

~~~
* (array-dimensions *a*)
(4)
* (array-dimensions *b*)
(2 3)
~~~

また、配列のランク（次元数）を調べてから、各次元のサイズを取得することもできます。

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

配列を反復処理するには、次のような入れ子のループを使えます。

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

この処理を多次元に対して行う補助マクロが `nested-loop` です。

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

これにより、2 次元配列の内容を次のように表示できます。

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

[注: このマクロは array-operations の[このフォーク](https://github.com/bendudson/array-operations)で利用できますが、Quicklisp には収録されていません]

<a id="row-major-indexing"></a>

### 行優先順でのインデックス指定

場合によっては、特に要素ごとの演算では、次元数は重要ではありません。次元数に依存しないコードを書くには、[row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) で一次元化した単一のインデックスを使い、配列要素へアクセスできます。配列全体の要素数は [array-total-size](http://clhs.lisp.se/Body/f_ar_tot.htm) で得られ、一次元化したインデックスは 0 から始まります。

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

<a id="infix-syntax"></a>

### 中置記法

[cmu-infix](https://github.com/rigetticomputing/cmu-infix) ライブラリは、数式を読みやすく記述できる別の構文を提供します。

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

別の行列乗算の実装については、下の線形代数の節を参照してください。

<a id="element-wise-operations"></a>

## 要素ごとの演算

同じサイズの 2 つの数値配列を掛け合わせるには、[array-operations](https://github.com/Lisp-Stat/array-operations) ライブラリの `each` に関数を渡します。

~~~lisp
* (aops:each #'* #(1 2 3) #(2 3 4))
#(2 6 12)
~~~

効率を高めるために `aops:each*` 関数があります。これは結果の配列を特殊化するため、最初の引数に型を取ります。

配列のすべての要素に定数を加えるには、次のようにします。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (aops:each (lambda (it) (+ 42 it)) *a*)
#(43 44 45 46)
* *a*
#(1 2 3 4)
~~~

`each` は破壊的ではなく、新しい配列を作ることに注意してください。`each` に渡す配列はすべて同じサイズでなければならないため、`(aops:each #'+ 42 *a*)` は正しくありません。

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

[注: このマクロの拡張版は array-operations の[このフォーク](https://github.com/bendudson/array-operations)で利用できますが、Quicklisp には収録されていません]

これは次のように使えます。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (vectorize (*a*) (* 2 *a*))
#(2 4 6 8)
~~~

式の本体（`vectorize` 式の 2 番目のフォーム）の中では、シンボル `*a*` は単一の要素に束縛されます。つまり、組み込みの数学関数を使えるということです。

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

Quicklisp の [lla](https://github.com/tpapp/lla) パッケージは、いくつかの BLAS 関数を呼び出す機能を提供します。

<a id="array--scale-"></a>
<a id="scale-"></a>

#### 配列をスケーリングする

定数倍する演算です。

~~~lisp
* (defparameter a #(1 2 3))
* (lla:scal! 2.0 a)
* a
#(2.0d0 4.0d0 6.0d0)
~~~

#### AXPY

これは `a * x + y` を計算します。ここで `a` は定数、`x` と `y` は配列です。`lla:axpy!` 関数は破壊的で、最後の引数（`y`）を変更します。

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

`y` 配列が複素数の場合、この演算は各演算子の複素数版を呼び出します。

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

[reduce](http://clhs.lisp.se/Body/f_reduce.htm) 関数は、ベクトル（1 次元配列）を含むシーケンスに対して動作しますが、多次元配列には動作しません。これを回避するには、多次元配列を参照する 1 次元の displaced 配列を作成できます。displaced 配列は元の配列と記憶領域を共有するため、データをコピーせずに高速に処理できます。

~~~lisp
* (defparameter a #2A((1 2) (3 4)))
A
* (reduce #'max (make-array (array-total-size a) :displaced-to a))
4
~~~

`array-operations` パッケージには `flatten` があり、displaced 配列、つまりデータをコピーせず元の配列と記憶領域を共有する配列を返します。

~~~lisp
* (reduce #'max (aops:flatten a))
~~~

SBCL 拡張の [array-storage-vector](http://www.sbcl.org/manual/#index-array_002dstorage_002dvector) は、同じことを実現する効率的ですが移植性のない方法を提供します。

~~~lisp
* (reduce #'max (array-storage-vector a))
4
~~~

ときには、より複雑な畳み込みが必要です。たとえば、2 つの配列の差の絶対値の最大値を求める場合です。上の方法を使うと次のようにできます。

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

[注: このマクロは array-operations の[このフォーク](https://github.com/bendudson/array-operations)で利用できますが、Quicklisp には収録されていません]

このマクロを使うと、任意の形状の配列 A における最大値を次のように求められます。

~~~lisp
* (vectorize-reduce #'max (a) a)
~~~

形状が同じであれば、任意の形状の 2 つの配列 A と B について、差の絶対値の最大値を次のように求められます。

~~~lisp
* (vectorize-reduce #'max (a b) (abs (- a b)))
~~~

<a id="linear-algebra"></a>

## 線形代数

いくつかのパッケージが BLAS と LAPACK ライブラリへのバインディングを提供しています。たとえば次です。

- [lla](https://github.com/tpapp/lla)
- [MAGICL](https://github.com/rigetticomputing/magicl)

利用可能なパッケージのより詳しい一覧は [CLiki の線形代数ページ](https://www.cliki.net/linear%20algebra)にあります。

下の例では LLA パッケージがロードされています。

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

これは `A[i j] * x[j]` を `j` について総和したものです。

<a id="matrix-matrix-multiply"></a>

#### 行列同士の乗算

~~~lisp
* (lla:mm #2A((1 2 3) (1 2 3) (1 2 3))  #2A((2 3 4) (2 3 4) (2 3 4)))
#2A((12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0))
~~~

これは `A[i j] * B[j k]` を `j` について総和したものです。

返される配列は単純配列で、要素型が `double-float` に特殊化されていることに注意してください。

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

これは新しい 2 次元配列 `A[i j] = B[i] * C[j]` を作成しています。`outer` 関数は任意個の入力を受け取れ、多次元の入力にも対応します。

<a id="matrix-inverse"></a>

### 逆行列

密行列の逆行列は `invert` で計算できます。

~~~lisp
* (lla:invert #2A((1 0 0) (0 1 0) (0 0 1)))
#2A((1.0d0 0.0d0 -0.0d0) (0.0d0 1.0d0 -0.0d0) (0.0d0 0.0d0 1.0d0))
~~~

たとえば:

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

[Matlisp](https://github.com/bharath1097/matlisp/) は科学技術計算ライブラリです。BLAS と LAPACK 関数のラッパーを含み、配列に対する高性能な演算を提供します。Quicklisp でロードできます。

~~~lisp
* (ql:quickload :matlisp)
~~~

`matlisp` のニックネームは `m` です。各シンボルの前に `matlisp:` や `m:` と入力せずに済むよう、Matlisp を使用する独自のパッケージを定義できます（[PCL のパッケージ節](http://www.gigamonkeys.com/book/programming-in-the-large-packages-and-symbols.html)を参照）。

~~~lisp
* (defpackage :my-new-code
     (:use :common-lisp :matlisp))
#<PACKAGE "MY-NEW-CODE">

* (in-package :my-new-code)
~~~

また、`#i` 中置記法リーダー（`cmu-infix` と同じ名前であることに注意）を使うには、次を実行します。

~~~lisp
* (named-readtables:in-readtable :infix-dispatch-table)
~~~

<a id="tensors"></a>

### テンソルの作成

~~~lisp
* (matlisp:zeros '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.000    0.000
  0.000    0.000
>
~~~

デフォルトでは、行列の格納型は `double-float` です。`zeros`、`ones`、`eye` を使って複素配列を作るには、型を指定します。

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

<a id="range"></a>

#### 数列

1 次元配列を生成するには `range` と `linspace` 関数があります。

~~~lisp
* (matlisp:range 1 10)
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(9)
 1   2   3   4   5   6   7   8   9
>
~~~

`range` 関数は最後の引数を整数に切り下げます。

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

`linspace` はもう少し汎用的で、返される値に終点を含みます。

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

現在、`linspace` への入力は実数でなければならず、複素数には対応していません。

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

他の確率分布に対応する関数もあり、`random-exponential`、`random-beta`、`random-gamma`、`random-pareto` などが含まれます。

<a id="reader-macro"></a>

#### リーダーマクロ

`#d` と `#e` リーダーマクロを使うと、`double-float` と `single-float` のテンソルを作成できます。

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

カンマ区切りが必要であることに注意してください。

<a id="array--tensor-"></a>
<a id="tensor-"></a>

#### 配列からテンソルへ

Common Lisp 配列は、コピーして Matlisp のテンソルへ変換できます。

~~~lisp
* (copy #2A((1 2 3)
            (4 5 6))
        '#.(tensor 'double-float))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    2.000    3.000
  4.000    5.000    6.000
>
~~~

次元を指定して `tensor` クラスのインスタンスを作成することもできます。`tensor` オブジェクトの内部記憶領域は、スロット `store` 内の 1 次元配列（`simple-vector`）です。

たとえば、`double-float` 型のテンソルを作るには次のようにします。

~~~lisp
(make-instance (tensor 'double-float)
    :dimensions  (coerce '(2) '(simple-array index-type (*)))
    :store (make-array 2 :element-type 'double-float))
~~~

<a id="tensor--array-"></a>
<a id="tensor--1"></a>

#### テンソルから配列へ

テンソルの内部データにはスロットを使ってアクセスできます。

~~~lisp
* (defparameter vec (m:range 0 5))
* vec
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(5)
 0   1   2   3   4
>
* (slot-value vec 'm:store)
#(0 1 2 3 4)
~~~

多次元テンソルも 1 次元配列に格納されますが、その順序は Common Lisp 配列で使われる行優先ではなく列優先です。したがって、displaced 配列として参照すると行列は転置されます。

テンソルの内容は配列へコピーできます。

~~~lisp
* (let ((tens (m:ones '(2 3))))
    (m:copy tens 'array))
#2A((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

リストへコピーすることもできます。

~~~lisp
* (m:copy (m:ones '(2 3)) 'cons)
((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

<a id="element-access"></a>

### 要素へのアクセス

`ref` 関数は標準 Common Lisp 配列に対する `aref` に相当し、`setf` も可能です。

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

`matlisp` とともにロードされる `matlisp-user` パッケージには、テンソルの要素ごとに演算する関数が含まれます。

~~~lisp
* (matlisp-user:* 2 (ones '(2 3)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  2.000    2.000    2.000
  2.000    2.000    2.000
>
~~~

これには算術演算子 `+`、`-`、`*`、`/`、`expt` だけでなく、`sqrt`、`sin`、`cos`、`tan`、双曲線関数、およびそれらの逆関数も含まれます。`#i` リーダーマクロはこれらの多くを認識し、`matlisp-user` の関数を使います。

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
