---
title: 数値
---

Common Lisp には、integer、rational、floating point、complex など、豊富な数値型があります。

参考資料:

* Common Lisp the Language, 2nd Edition の [`Numbers`][numbers]
* [`Numbers, Characters and Strings`][numbers-characters-strings]
  (Practical Common Lisp)

## はじめに

### integer 型

Common Lisp は `bignum` と呼ばれる真の integer 型を提供します。これは machine word size ではなく、利用可能な総 memory 量だけに制限されます。たとえば次の値は 64 bit integer を大きく overflow します。

~~~lisp
* (expt 2 200)
1606938044258990275541962092341162602522202993782792835301376
~~~

効率のため、integer は固定 bit 数に制限できます。これは `fixnum` 型と呼ばれます。表現可能な integer の範囲は次で得られます。

~~~lisp
* most-positive-fixnum
4611686018427387903
* most-negative-fixnum
-4611686018427387904
~~~

integer を操作する、または integer を返す function には次のものがあります。

* [`isqrt`][isqrt] は、自然数の正確な正の平方根以下で最大の integer を返します。

~~~lisp
* (isqrt 10)
3
* (isqrt 4)
2
~~~

* [`gcd`][gcd] は Greatest Common Denominator を求めます。
* [`lcm`][lcm] は Least Common Multiple を求めます。

他の low-level programming language と同じく、Common Lisp は hexadecimal や 36 までの radix の literal 表記を提供します。例:

~~~lisp
* #xFF
255
* #2r1010
10
* #4r33
15
* #8r11
9
* #16rFF
255
* #36rz
35
~~~

### rational 型

[`ratio`][ratio] 型の rational number は、分子と分母という 2 つの `bignum` から構成されます。そのため、どちらも任意の大きさにできます。

~~~lisp
* (/ (1+ (expt 2 100)) (expt 2 100))
1267650600228229401496703205377/1267650600228229401496703205376
~~~

これは [`integer`][integer] と同じく [`rational`][rational] class の subtype です。

### floating point 型

[Common Lisp the Language, 2nd Edition, section 2.1.3][book-cl-2.1.3] を参照してください。

floating point 型は、連続した real number を有限個の bit で表そうとします。つまり多くの real number は正確には表現できず、近似されます。特に 10 進表現と内部の 2 進表現を相互変換するとき、これは厄介な驚きにつながることがあります。floating point number を扱うなら、[What Every Computer Scientist Should Know About Floating-Point Arithmetic][article-floating-point-arithmetic] を読むことを強く勧めます。

Common Lisp standard は複数の floating point 型を許します。精度が低い順に `short-float`、`single-float`、`double-float`、`long-float` です。これらの精度は implementation dependent であり、すべての型が 1 つの floating point precision だけを持つ implementation もありえます。

定数 [`short-float-epsilon`, `single-float-epsilon`, `double-float-epsilon` and `long-float-epsilon`][float-constants] は floating point 型の精度の目安を与えるもので、implementation dependent です。

特に ECL は `long-float` を C の `long double` に基づけているため、より高い精度を持ちます。

```
CL-USER> (lisp-implementation-type)
"ECL"
CL-USER> most-positive-single-float
3.4028235e38
CL-USER> most-positive-double-float
1.7976931348623157d308
CL-USER> most-positive-long-float
1.189731495357231765l4932
```

#### floating point literal

floating point number を読むとき、default の型は special variable [`*read-default-float-format*`][read-default-float-format] で設定されます。default は `SINGLE-FLOAT` なので、数値を double precision として確実に読ませたい場合は末尾に `d0` suffix を付けます。

~~~lisp
* (type-of 1.24)
SINGLE-FLOAT

* (type-of 1.24d0)
DOUBLE-FLOAT
~~~

他の suffix は `s` (short)、`f` (single float)、`d` (double float)、`l` (long float)、`e` (default、通常は single float) です。

default の型は変更できますが、`single-float` 型を仮定している package を壊す可能性がある点に注意してください。

~~~lisp
* (setq *read-default-float-format* 'double-float)
* (type-of 1.24)
DOUBLE-FLOAT
~~~

一部の language と違って、数値の末尾に decimal point を 1 つ付けても float にはならない点に注意してください。

~~~lisp
* (type-of 10.)
(INTEGER 0 4611686018427387903)

* (type-of 10.0)
SINGLE-FLOAT
~~~

#### floating point error

floating point calculation の結果が大きすぎる場合、floating point overflow が発生します。[SBCL][SBCL] (および他の implementation) では default で error condition になります。

~~~lisp
* (exp 1000)
; Evaluation aborted on #<FLOATING-POINT-OVERFLOW {10041720B3}>.
~~~

この error は handle できます。また、この behaviour を変更して `+infinity` を返すようにもできます。SBCL では次のようにします。

~~~lisp
* (sb-int:set-floating-point-modes :traps '(:INVALID :DIVIDE-BY-ZERO))

* (exp 1000)
#.SB-EXT:SINGLE-FLOAT-POSITIVE-INFINITY

* (/ 1 (exp 1000))
0.0
~~~

これで計算は error condition なしに静かに続行されます。

floating overflow error を無効にする同様の機能は [CCL][CCL] にもあります。

~~~lisp
* (set-fpu-mode :overflow nil)
~~~

SBCL では floating point mode を調べられます。

~~~lisp
* (sb-int:get-floating-point-modes)
(:TRAPS (:OVERFLOW :INVALID :DIVIDE-BY-ZERO) :ROUNDING-MODE :NEAREST
 :CURRENT-EXCEPTIONS NIL :ACCRUED-EXCEPTIONS NIL :FAST-MODE NIL)
~~~

#### 任意精度

任意の高精度計算には、QuickLisp に [computable-reals][computable-reals] library があります。

~~~lisp
* (ql:quickload :computable-reals)
* (use-package :computable-reals)

* (sqrt-r 2)
+1.41421356237309504880...

* (sin-r (/r +pi-r+ 2))
+1.00000000000000000000...
~~~

print する精度は `*PRINT-PREC*` で設定され、default は 20 です。

~~~lisp
* (setq *PRINT-PREC* 50)
* (sqrt-r 2)
+1.41421356237309504880168872420969807856967187537695...
~~~

### complex 型

complex number には 5 種類があります。実部と虚部は同じ型でなければならず、rational またはいずれかの floating point 型 (short、single、double、long) にできます。

complex value は `#C` reader macro または function [`complex`][complex] で作成できます。reader macro では、実部と虚部に expression を使うことはできません。

~~~lisp
* #C(1 1)
#C(1 1)

* #C((+ 1 2) 5)
; Evaluation aborted on #<TYPE-ERROR expected-type: REAL datum: (+ 1 2)>.

* (complex (+ 1 2) 5)
#C(3 5)
~~~

異なる型を混ぜて構築した場合、両方の part により高精度の型が使われます。

~~~lisp
* (type-of #C(1 1))
(COMPLEX (INTEGER 1 1))

* (type-of #C(1.0 1))
(COMPLEX (SINGLE-FLOAT 1.0 1.0))

* (type-of #C(1.0 1d0))
(COMPLEX (DOUBLE-FLOAT 1.0d0 1.0d0))
~~~

complex number の実部と虚部は [`realpart` and `imagpart`][realpart-and-imaginary] で取り出せます。

~~~lisp
* (realpart #C(7 9))
7
* (imagpart #C(4.2 9.5))
9.5
~~~

#### complex arithmetic

Common Lisp の mathematical function は一般に complex number を扱え、本来の結果が complex number である場合は complex number を返します。例:

~~~lisp
* (sqrt -1)
#C(0.0 1.0)

* (exp #C(0.0 0.5))
#C(0.87758255 0.47942555)

* (sin #C(1.0 1.0))
#C(1.2984576 0.63496387)
~~~

## string から number を読む

[`parse-integer`][parse-integer] function は string から integer を読みます。

[parse-number][parse-number] library は任意の expression を evaluate できないため、信頼できない input に対してより安全に使えるはずです。float も parse できます。

~~~lisp
* (ql:quickload :parse-number)
* (use-package :parse-number)

* (parse-number "23.4e2")
2340.0
6
~~~

[Serapeum][serapeum] library にももちろん `parse-float` function があります。たとえば double float のように、出力の型を指定することもできます。

~~~lisp
* (ql:quickload "serapeum")
* (serapeum:parse-float "23.4e2" :type 'double-float)
2340.0d0
;;    ^^ double
~~~

string と number の相互変換については [strings section][strings] を参照してください。

## number の変換

ほとんどの numerical function は必要に応じて型を自動変換します。`coerce` function は、numeric type を含む object をある型から別の型へ変換します。

[Common Lisp the Language, 2nd Edition, section 12.6][book-cl-12.6] を参照してください。

### float を rational に変換する

[`rational` and `rationalize` functions][rational-and-rationalize] は real numeric argument を rational に変換します。`rational` は floating point argument が正確だと仮定します。`rationalize` は floating point number がその精度の範囲でしか正確でないという事実を利用するため、より単純な rational number を見つけられることがよくあります。

### rational を integer に変換する

計算結果が rational number で、その分子が分母の倍数である場合、自動的に integer に変換されます。

~~~lisp
* (type-of (* 1/2 4))
(INTEGER 0 4611686018427387903)
~~~

## floating-point number と rational number の丸め

[`ceiling`, `floor`, `round` and `truncate`][ceiling-functions] function は floating point number または rational number を integer に変換します。結果と input の差が第 2 戻り値として返るため、input は 2 つの出力の和になります。

~~~lisp
* (ceiling 1.42)
2
-0.58000004

* (floor 1.42)
1
0.41999996

* (round 1.42)
1
0.41999996

* (truncate 1.42)
1
0.41999996
~~~

negative number では `floor` と `truncate` に違いがあります。

~~~lisp
* (truncate -1.42)
-1
-0.41999996

* (floor -1.42)
-2
0.58000004

* (ceiling -1.42)
-1
-0.41999996
~~~

類似の function `fceiling`、`ffloor`、`fround`、`ftruncate` は、argument と同じ型の floating point として結果を返します。

~~~lisp
* (ftruncate 1.3)
1.0
0.29999995

* (type-of (ftruncate 1.3))
SINGLE-FLOAT

* (type-of (ftruncate 1.3d0))
DOUBLE-FLOAT
~~~

## number の比較

[Common Lisp the Language, 2nd Edition, Section 12.3][book-cl-12.3] を参照してください。

`=` predicate は、すべての argument が数値的に等しい場合に `T` を返します。floating point number の比較には、すべての real number を表現できず error が蓄積するという性質のため、ある程度の誤差の余地が含まれる点に注意してください。

定数 [`single-float-epsilon`][single-float-epsilon] は、1.0 に加えたとき `=` comparison が fail する最小の number です。

~~~lisp
* (= (+ 1s0 5e-8) 1s0)
T
* (= (+ 1s0 6e-8) 1s0)
NIL
~~~

これは `single-float` が常に `6e-8` 以内の精度を持つという意味ではない点に注意してください。

~~~lisp
* (= (+ 10s0 4e-7) 10s0)
T
* (= (+ 10s0 5e-7) 10s0)
NIL
~~~

むしろ、これは `single-float` が約 7 桁の精度を持つという意味です。一連の計算を行うと error が蓄積し、より大きな error margin が必要になることがあります。この場合は絶対差を比較できます。

~~~lisp
* (< (abs (- (+ 10s0 5e-7)
             10s0))
     1s-6)
T
~~~

`=` で number を比較するときは、型が混在していてもかまいません。数値と型の両方を test するには `eql` を使います。

~~~lisp
* (= 3 3.0)
T

* (eql 3 3.0)
NIL
~~~

## number の series を操作する

多くの Common Lisp function は sequence を操作します。sequence は list または vector (1D array) です。[mapping][mapping] の section を参照してください。

multidimensional array に対する operation は [this section][arrays] で説明しています。

number の「infinite」sequence を含む lazy sequence を定義し操作する library もあります。例:

* [Clazy][clazy] は QuickLisp にあります。
* [folio2][folio2] は QuickLisp にあります。効率的な sequence のための
* [Series][series] package への interface を含みます。
* [lazy-seq][lazy-seq].

## Roman numeral を扱う

`format` function は `~@r` directive で number を roman numeral に変換できます。

~~~lisp
* (format nil "~@r" 42)
"XLII"
~~~

roman numeral を読むための [gist by tormaroe][gist-tormaroe] があります。

## random number の生成

[`random`][random] function は、その argument の型に応じて integer または floating point の random number を生成します。

~~~lisp
* (random 10)
7

* (type-of (random 10))
(INTEGER 0 4611686018427387903)
* (type-of (random 10.0))
SINGLE-FLOAT
* (type-of (random 10d0))
DOUBLE-FLOAT
~~~

SBCL では [Mersenne Twister][mersenne-twister] pseudo-random number generator が使われています。詳細は [SBCL manual の 7.13][sbcl-7.13] section を参照してください。

random seed は [`*random-state*`][random-state] に保存され、その内部表現は implementation dependent です。function [`make-random-state`][make-random-state] は、新しい random state を作成したり、既存の state を copy したりするために使えます。

同じ random number の集合を複数回使うには、`(make-random-state nil)` で現在の `*random-state*` の copy を作成します。

~~~lisp
* (dotimes (i 3)
    (let ((*random-state* (make-random-state nil)))
      (format t "~a~%"
              (loop for i from 0 below 10 collecting (random 10)))))

(8 3 9 2 1 8 0 0 4 1)
(8 3 9 2 1 8 0 0 4 1)
(8 3 9 2 1 8 0 0 4 1)
~~~

これは loop 内で 10 個の random number を生成しますが、毎回 sequence は同じです。なぜなら `*random-state*` special variable が、`let` form の前でその state の copy に dynamic binding されるからです。

その他の資料:

* [random-state][random-state] package は QuickLisp で利用でき、複数の portable random number generator を提供します。

## bit-wise operation

Common Lisp は bit-wise arithmetic operation を行うための function も多く提供しています。よく使われるものを、対応する C/C++ 表現と一緒に以下に示します。

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
  <thead>
    <tr>
      <th>Common Lisp</th>
      <th>C/C++</th>
      <th>説明</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>(logand a b c)</td>
      <td>a & b & c</td>
      <td>複数 operand の bit-wise AND</td>
    </tr>
    <tr>
      <td>(logior a b c)</td>
      <td>a | b | c</td>
      <td>複数 operand の bit-wise OR</td>
    </tr>
    <tr>
      <td>(lognot a)</td>
      <td>~a</td>
      <td>単一 operand の bit-wise NOT</td>
    </tr>
    <tr>
      <td>(logxor a b c)</td>
      <td>a ^ b ^ c</td>
      <td>複数 operand の bit-wise exclusive or (XOR)</td>
    </tr>
    <tr>
      <td>(ash a 3)</td>
      <td>a << 3</td>
      <td>bit-wise left shift</td>
    </tr>
    <tr>
      <td>(ash a -3)</td>
      <td>a >> 3</td>
      <td>bit-wise right shift</td>
    </tr>
  </tbody>
</table>
<!-- epub-exclude-start -->
<br>
<!-- epub-exclude-end -->

negative number は two's-complement として扱われます。忘れてしまった場合は [Wiki page][twos-complements] を参照してください。

例:

~~~lisp
* (logior 1 2 4 8)
15
;; 説明:
;;   0001
;;   0010
;;   0100
;; | 1000
;; -------
;;   1111

* (logand 2 -3 4)
0

;; 説明:
;;   0010 (2)
;;   1101 (-3 の two's complement)
;; & 0100 (4)
;; -------
;;   0000

* (logxor 1 3 7 15)
10

;; 説明:
;;   0001
;;   0011
;;   0111
;; ^ 1111
;; -------
;;   1010

* (lognot -1)
0
;; 説明:
;;   11 -> 00

* (lognot -3)
2
;; 説明:
;;   101 -> 010

* (ash 3 2)
12
;; 説明:
;;   11 -> 1100

* (ash -5 -2)
-2
;; 説明
;;   11011 -> 110
~~~

より詳しい説明や他の bit-wise function については [CLHS page][logand-functions] を参照してください。

## 付録: number tower

<!-- epub-exclude-start -->
<div style="text-align: center">
    <img src="numbertower.png" alt="Number Types in Common Lisp"/>
</div>
<!-- epub-exclude-end -->

<!-- pdf-include-start
![](numbertower.png)
   pdf-include-end -->

*太字で実線の box に入っている type は、通常よく使うものです。*


[numbers]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node16.html#SECTION00610000000000000000
[numbers-characters-strings]: http://www.gigamonkeys.com/book/numbers-characters-and-strings.html
[isqrt]: http://clhs.lisp.se/Body/f_sqrt_.htm
[gcd]: http://clhs.lisp.se/Body/f_gcd.htm
[lcm]: http://clhs.lisp.se/Body/f_lcm.htm#lcm
[ratio]: http://clhs.lisp.se/Body/t_ratio.htm
[rational]: http://clhs.lisp.se/Body/t_ration.htm#rational
[integer]: http://clhs.lisp.se/Body/t_intege.htm#integer
[book-cl-2.1.3]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node19.html
[article-floating-point-arithmetic]: https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html
[float-constants]: http://clhs.lisp.se/Body/v_short_.htm
[read-default-float-format]: http://clhs.lisp.se/Body/v_rd_def.htm
[SBCL]: http://www.sbcl.org/
[CCL]: https://ccl.clozure.com/
[computable-reals]: http://quickdocs.org/computable-reals/
[complex]: http://clhs.lisp.se/Body/f_comp_2.htm#complex
[realpart-and-imaginary]: http://clhs.lisp.se/Body/f_realpa.htm
[parse-integer]: http://clhs.lisp.se/Body/f_parse_.htm
[parse-number]: https://github.com/sharplispers/parse-number
[serapeum]: https://github.com/ruricolist/serapeum/
[strings]: https://lispcookbook.github.io/cl-cookbook/strings.html#converting-a-string-to-a-number
[book-cl-12.6]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node130.html
[rational-and-rationalize]: http://clhs.lisp.se/Body/f_ration.htm
[ceiling-functions]: http://www.lispworks.com/documentation/HyperSpec/Body/f_floorc.htm
[book-cl-12.3]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node124.html
[single-float-epsilon]: http://clhs.lisp.se/Body/v_short_.htm
[mapping]: https://lispcookbook.github.io/cl-cookbook/data-structures.html#mapping-map-mapcar-remove-if-not
[arrays]: https://lispcookbook.github.io/cl-cookbook/arrays.html
[clazy]: https://common-lisp.net/project/clazy/
[series]: https://github.com/tokenrove/series/wiki/Documentation
[lazy-seq]: https://github.com/fredokun/lisp-lazy-seq
[folio2]: https://github.com/mikelevins/folio2
[gist-tormaroe]: https://gist.github.com/tormaroe/90ddd9dc7cc191040be4
[random]: http://clhs.lisp.se/Body/f_random.htm#random
[mersenne-twister]: https://en.wikipedia.org/wiki/Mersenne_Twister
[sbcl-7.13]: http://www.sbcl.org/manual/#Random-Number-Generation
[random-state]: http://clhs.lisp.se/Body/v_rnd_st.htm#STrandom-stateST
[make-random-state]: http://clhs.lisp.se/Body/f_mk_rnd.htm
[random-state]: http://quickdocs.org/random-state/
[logand-functions]: http://www.lispworks.com/documentation/HyperSpec/Body/f_logand.htm
[twos-complements]: https://en.wikipedia.org/wiki/Twos_complement
