---
title: パフォーマンスチューニングとヒント
---

多くの Common Lisp 処理系はソースコードをアセンブリ言語に変換するため、一部のインタプリタ言語と比べて性能はとても良好です。

しかし、プログラムをもっと速くしたいこともあります。この章では CPU の力を引き出すためのいくつかの技法を紹介します。

## ボトルネックを見つける

### 実行時間を取得する

マクロ [`time`][time] はボトルネックを見つけるのにとても便利です。フォームを受け取り、それを評価し、下に示すように [`*trace-output*`][trace-output] にタイミング情報を出力します。

~~~lisp
* (defun collect (start end)
    "Collect numbers [start, end] as list."
    (loop for i from start to end
          collect i))

* (time (collect 1 10))

Evaluation took:
  0.000 seconds of real time
  0.000001 seconds of total run time (0.000001 user, 0.000000 system)
  100.00% CPU
  3,800 processor cycles
  0 bytes consed
~~~

`time` マクロを使うと、プログラムのどの部分が時間を取りすぎているか、またはメモリ（"bytes consed"）を使いすぎているかをかなり簡単に見つけられます。

ここで提供されるタイミング情報は、宣伝用の比較に十分な信頼性が保証されているわけではないことに注意してください。この章で示すように、チューニングの目的にだけ使うべきです。

### Lisp の統計的プロファイラを知る

処理系はそれぞれ独自のプロファイラを同梱しています。SBCL には、「古典的な、関数呼び出しごと」の決定的プロファイラである [sb-profile](http://www.sbcl.org/manual/#Deterministic-Profiler) と、統計的プロファイラである [sb-sprof](http://www.sbcl.org/manual/#Statistical-Profiler) があります。後者は `sb-profile:profile` のように関数を計測対象に組み込むのではなく、一定間隔でプログラムの実行のサンプルを取ることで動作します。

> common-lisp-package の関数、SBCL の内部、または計測のオーバーヘッドが過大なコードをプロファイリングする場合、決定的プロファイラより sb-sprof の方が便利かもしれません。

イメージに `sb-sprof` を読み込みます。

```lisp
(require :sb-sprof)
```

そしてマクロ `sb-sprof:with-profiling` を使います。詳細はそのドキュメントを参照してください。


### flamegraph とその他のトレース型プロファイラを使う

[cl-flamegraph](https://github.com/40ants/cl-flamegraph) は、FlameGraph の図を生成する SBCL 統計プロファイラのラッパーです。FlameGraph を使うと、コード内のボトルネックを視覚的に探せます。

![](assets/cl-flamegraph.png)

[tracer](https://github.com/TeMPOraL/tracer) も参照してください。これは SBCL 用のトレース型プロファイラです。その出力は Chrome または Chromium の Tracing Viewer（`chrome://tracing`）で表示するのに適しています。

ブラウザのインターフェイスを持つ拡張版 REPL である [ICL](https://github.com/atgreen/icl/) には、関数をプロファイルし、結果を対話的な flamegraph ビジュアライザで探索する組み込みコマンドがあります。ボトルネックを特定するために異なるビューを切り替えられます。


### アセンブリコードを確認する

関数 [`disassemble`][disassemble] は関数を受け取り、そのコンパイル済みコードを `*standard-output*` に出力します。例:

~~~lisp
* (defun plus (a b)
    (+ a b))
PLUS

* (disassemble 'plus)
; disassembly for PLUS
; Size: 37 bytes. Origin: #x52B8063B
; 3B:  498B5D60     MOV RBX, [R13+96]  ; no-arg-parsing entry point
                                       ; thread.binding-stack-pointer
; 3F:  48895DF8     MOV [RBP-8], RBX
; 43:  498BD0       MOV RDX, R8
; 46:  488BFE       MOV RDI, RSI
; 49:  FF14250102   CALL QWORD PTR [#x52100] ; GENERIC-+
; 50:  488B75E8     MOV RSI, [RBP-24]
; 54:  4C8B45F0     MOV R8, [RBP-16]
; 58:  488BE5       MOV RSP, RBP
; 5B:  F8           CLC
; 5C:  5D           POP RBP
; 5D:  C3           RET
; 5E:  CC0F         BREAK 15   ; Invalid argument count trap
~~~

上のコードは SBCL で評価されました。CLISP のような他の処理系では、`disassembly` は異なるものを返すかもしれません。

~~~lisp
* (defun plus (a b)
    (+ a b))
PLUS

* (disassemble 'plus)
Disassembly of function PLUS
2 required arguments
0 optional arguments
No rest parameter
No keyword parameters
4 byte-code instructions:
0     (LOAD&PUSH 2)
1     (LOAD&PUSH 2)
2     (CALLSR 2 55)                       ; +
5     (SKIP&RET 3)
NIL
~~~

これは、SBCL が Lisp コードを機械語にコンパイルする一方で、CLISP はそうしないためです。

<a id="declare-expression-"></a>

## declare 式を使う

[*declare expression*][declare] は、コンパイラに各種の最適化のヒントを与えるために使えます。これらのヒントは処理系依存であることに注意してください。SBCL のような一部の処理系はこの機能をサポートしており、詳細はそれぞれのドキュメントを参照できます。ここでは CLHS で触れられている基本的な技法だけを紹介します。

一般に、declare 式は特定のフォームの本体の先頭、または文脈が許す場合はドキュメント文字列の直後にだけ現れます。また、declare 式の内容は限られたフォームに制限されています。ここでは性能チューニングに関係するものをいくつか紹介します。

この節で紹介する最適化の手法は、選択した Lisp 処理系と強く結びついていることを覚えておいてください。`declare` を使う前に必ずそのドキュメントを確認してください。

### 速度と安全性

Lisp では、宣言 [`optimize`][optimize] を使ってコンパイラにいくつかの品質特性を指定できます。各品質には 0 から 3 の値を割り当てられ、0 は「まったく重要でない」、3 は「非常に重要」を意味します。

最も重要な品質は `safety` と `speed` かもしれません。

デフォルトでは、Lisp はコードの安全性を速度よりずっと重要だと見なします。しかし、より積極的な最適化のために重みを調整できます。

~~~lisp
* (defun max-original (a b)
    (max a b))
MAX-ORIGINAL

* (disassemble 'max-original)
; disassembly for MAX-ORIGINAL
; Size: 144 bytes. Origin: #x52D450EF
; 7A7:       8D46F1      lea eax, [rsi-15]               ; no-arg-parsing entry point
; 7AA:       A801        test al, 1
; 7AC:       750E        jne L0
; 7AE:       3C0A        cmp al, 10
; 7B0:       740A        jeq L0
; 7B2:       A80F        test al, 15
; 7B4:       7576        jne L5
; 7B6:       807EF11D    cmp byte ptr [rsi-15], 29
; 7BA:       7770        jnbe L5
; 7BC: L0:   8D43F1      lea eax, [rbx-15]
; 7BF:       A801        test al, 1
; 7C1:       750E        jne L1
; 7C3:       3C0A        cmp al, 10
; 7C5:       740A        jeq L1
; 7C7:       A80F        test al, 15
; 7C9:       755A        jne L4
; 7CB:       807BF11D    cmp byte ptr [rbx-15], 29
; 7CF:       7754        jnbe L4
; 7D1: L1:   488BD3      mov rdx, rbx
; 7D4:       488BFE      mov rdi, rsi
; 7D7:       B9C1030020  mov ecx, 536871873   ; generic->
; 7DC:       FFD1        call rcx
; 7DE:       488B75F0    mov rsi, [rbp-16]
; 7E2:       488B5DF8    mov rbx, [rbp-8]
; 7E6:       7E09        jle L3
; 7E8:       488BD3      mov rdx, rbx
; 7EB: L2:   488BE5      mov rsp, rbp
; 7EE:       F8          clc
; 7EF:       5D          pop rbp
; 7F0:       C3          ret
; 7F1: L3:   4C8BCB      mov r9, rbx
; 7F4:       4C894DE8    mov [rbp-24], r9
; 7F8:       4C8BC6      mov r8, rsi
; 7FB:       4C8945E0    mov [rbp-32], r8
; 7FF:       488BD3      mov rdx, rbx
; 802:       488BFE      mov rdi, rsi
; 805:       B929040020  mov ecx, 536871977   ; generic-=
; 80A:       FFD1        call rcx
; 80C:       4C8B45E0    mov r8, [rbp-32]
; 810:       4C8B4DE8    mov r9, [rbp-24]
; 814:       488B75F0    mov rsi, [rbp-16]
; 818:       488B5DF8    mov rbx, [rbp-8]
; 81C:       498BD0      mov rdx, r8
; 81F:       490F44D1    cmoveq rdx, r9
; 823:       EBC6        jmp L2
; 825: L4:   CC0A        break 10            ; error trap
; 827:       04          byte #X04
; 828:       13          byte #X13           ; OBJECT-NOT-REAL-ERROR
; 829:       FE9B01      byte #XFE, #X9B, #X01      ; RBX
; 82C: L5:   CC0A        break 10            ; error trap
; 82E:       04          byte #X04
; 82F:       13          byte #X13           ; OBJECT-NOT-REAL-ERROR
; 830:       FE1B03      byte #XFE, #X1B, #X03           ; RSI
; 833:       CC0A        break 10            ; error trap
; 835:       02          byte #X02
; 836:       19          byte #X19           ; INVALID-ARG-COUNT-ERROR
; 837:       9A          byte #X9A           ; RCX

* (defun max-with-speed-3 (a b)
    (declare (optimize (speed 3) (safety 0)))
    (max a b))
MAX-WITH-SPEED-3

* (disassemble 'max-with-speed-3)
; disassembly for MAX-WITH-SPEED-3
; Size: 92 bytes. Origin: #x52D452C3
; 3B:       48895DE0         mov [rbp-32], rbx                ; no-arg-parsing entry point
; 3F:       488945E8         mov [rbp-24], rax
; 43:       488BD0           mov rdx, rax
; 46:       488BFB           mov rdi, rbx
; 49:       B9C1030020       mov ecx, 536871873     ; generic->
; 4E:       FFD1             call rcx
; 50:       488B45E8         mov rax, [rbp-24]
; 54:       488B5DE0         mov rbx, [rbp-32]
; 58:       7E0C             jle L1
; 5A:       4C8BC0           mov r8, rax
; 5D: L0:   498BD0           mov rdx, r8
; 60:       488BE5           mov rsp, rbp
; 63:       F8               clc
; 64:       5D               pop rbp
; 65:       C3               ret
; 66: L1:   488945E8         mov [rbp-24], rax
; 6A:       488BF0           mov rsi, rax
; 6D:       488975F0         mov [rbp-16], rsi
; 71:       4C8BC3           mov r8, rbx
; 74:       4C8945F8         mov [rbp-8], r8
; 78:       488BD0           mov rdx, rax
; 7B:       488BFB           mov rdi, rbx
; 7E:       B929040020       mov ecx, 536871977      ; generic-=
; 83:       FFD1             call rcx
; 85:       488B45E8         mov rax, [rbp-24]
; 89:       488B75F0         mov rsi, [rbp-16]
; 8D:       4C8B45F8         mov r8, [rbp-8]
; 91:       4C0F44C6         cmoveq r8, rsi
; 95:       EBC6             jmp L0
~~~

見て分かるように、生成されたアセンブリコードはかなり短くなっています（92 bytes 対 144）。コンパイラは最適化を行えました。さらに型を宣言すれば、もっと良くできます。


### 型のヒント

[*型システム*][type] の章で述べたように、Lisp には比較的強力な型システムがあります。コンパイラが生成するコードのサイズを減らせるように型のヒントを与えられます。

~~~lisp
* (defun max-with-type (a b)
    (declare (optimize (speed 3) (safety 0)))
    (declare (type integer a b))
    (max a b))
MAX-WITH-TYPE

* (disassemble 'max-with-type)
; disassembly for MAX-WITH-TYPE
; Size: 42 bytes. Origin: #x52D48A23
; 1B:       488BF7           mov rsi, rdi                     ; no-arg-parsing entry point
; 1E:       488975F0         mov [rbp-16], rsi
; 22:       488BD8           mov rbx, rax
; 25:       48895DF8         mov [rbp-8], rbx
; 29:       488BD0           mov rdx, rax
; 2C:       B98C030020       mov ecx, 536871820    ; generic-<
; 31:       FFD1             call rcx
; 33:       488B75F0         mov rsi, [rbp-16]
; 37:       488B5DF8         mov rbx, [rbp-8]
; 3B:       480F4CDE         cmovl rbx, rsi
; 3F:       488BD3           mov rdx, rbx
; 42:       488BE5           mov rsp, rbp
; 45:       F8               clc
; 46:       5D               pop rbp
; 47:       C3               ret
~~~

生成されたアセンブリコードのサイズは約 1/3 まで縮みました。速度はどうでしょうか。

~~~lisp
* (time (dotimes (i 10000) (max-original 100 200)))
Evaluation took:
  0.000 seconds of real time
  0.000107 seconds of total run time (0.000088 user, 0.000019 system)
  100.00% CPU
  361,088 processor cycles
  0 bytes consed

* (time (dotimes (i 10000) (max-with-type 100 200)))
Evaluation took:
  0.000 seconds of real time
  0.000044 seconds of total run time (0.000036 user, 0.000008 system)
  100.00% CPU
  146,960 processor cycles
  0 bytes consed
~~~

型のヒントを指定することで、コードがずっと速く動くことが分かります。

しかし待ってください。間違った型を宣言すると何が起きるでしょうか。答えは「場合による」です。

たとえば、SBCL は型宣言を[独特なやり方][sbcl-type]で扱います。安全性のレベルに応じて異なるレベルの型検査を行います。安全性のレベルが 0 に設定されている場合、型検査は行われません。そのため、間違った型指定子は大きな損害を引き起こすかもしれません。

### `declaim` による型宣言の詳細

トップレベルで `declare` フォームを評価しようとすると、次のエラーが出るかもしれません。

~~~lisp
Execution of a form compiled with errors.
Form:
  (DECLARE (SPEED 3))
Compile-time error:
  There is no function named DECLARE.  References to DECLARE in some contexts
(like starts of blocks) are unevaluated expressions, but here the expression is
being evaluated, which invokes undefined behaviour.
   [Condition of type SB-INT:COMPILED-PROGRAM-ERROR]
~~~

これは型宣言に[スコープ][declare-scope]があるためです。上の例では、型宣言が関数に適用されるのを見ました。

開発中は、潜在的な問題をできるだけ早く見つけるために safety の重要度を上げることが普通は有用です。反対に、デプロイ後は speed の方が重要かもしれません。しかし、すべての関数に宣言式を指定するのは冗長すぎることがあります。

マクロ [`declaim`][declaim] はその可能性を提供します。ファイル内のトップレベルフォームとして使え、宣言はコンパイル時に作られます。

~~~lisp
* (declaim (optimize (speed 0) (safety 3)))
NIL

* (defun max-original (a b)
    (max a b))
MAX-ORIGINAL

* (disassemble 'max-original)
; disassembly for MAX-ORIGINAL
; Size: 181 bytes. Origin: #x52D47D9C
...

* (declaim (optimize (speed 3) (safety 3)))
NIL

* (defun max-original (a b)
    (max a b))
MAX-ORIGINAL

* (disassemble 'max-original)
; disassembly for MAX-ORIGINAL
; Size: 142 bytes. Origin: #x52D4815D
~~~

`declaim` はファイルの **コンパイル時** に動作することに注意してください。主に、一部の宣言をそのファイルにローカルにするために使われます。また、declaim のコンパイル時の副作用がファイルのコンパイル後も残るかどうかは規定されていません。


### 関数の型の宣言

もう 1 つ有用な宣言は `ftype` 宣言です。これは関数の引数の型と戻り値の型の関係を確立します。渡された引数の型が宣言された型と一致する場合、戻り値の型は宣言されたものと一致すると期待されます。そのため、1 つの関数に複数の `ftype` 宣言を関連付けられます。`ftype` 宣言は、関数が呼び出されるたびに引数の型を制限します。形は次のとおりです。

~~~lisp
 (declaim (ftype (function (arg1 arg2 ...) return-value)
                 function-name1))
~~~~

関数が `nil` を返す場合、その戻り値の型は `null` です。
この宣言は、それ自体では引数の型に制限をかけません。
与えられた引数が指定された型を持つ場合にのみ効果があります。そうでなければエラーは通知されず、宣言は効果を持ちません。たとえば、次の宣言は、関数 `square` への引数が `fixnum` なら、その関数の値も `fixnum` になることを示しています。

~~~lisp
(declaim (ftype (function (fixnum) fixnum) square))
(defun square (x) (* x x))
~~~~

`fixnum` 型と宣言されていない引数を与えると、最適化は行われません。

~~~lisp
(defun do-some-arithmetic (x)
  (the fixnum (+ x (square x))))
~~~~

では speed を最適化してみましょう。コンパイラは型が確定しないと述べます。

~~~lisp
(defun do-some-arithmetic (x)
  (declare (optimize (speed 3) (debug 0) (safety 0)))
  (the fixnum (+ x (square x))))

; compiling (DEFUN DO-SOME-ARITHMETIC ...)

; file: /tmp/slimeRzDh1R
 in: DEFUN DO-SOME-ARITHMETIC
;     (+ TEST-FRAMEWORK::X (TEST-FRAMEWORK::SQUARE TEST-FRAMEWORK::X))
;
; note: forced to do GENERIC-+ (cost 10)
;       unable to do inline fixnum arithmetic (cost 2) because:
;       The first argument is a NUMBER, not a FIXNUM.
;       unable to do inline (signed-byte 64) arithmetic (cost 5) because:
;       The first argument is a NUMBER, not a (SIGNED-BYTE 64).
;       etc.
;
; compilation unit finished
;   printed 1 note


      (disassemble 'do-some-arithmetic)
; disassembly for DO-SOME-ARITHMETIC
; Size: 53 bytes. Origin: #x52CD1D1A
; 1A:       488945F8         MOV [RBP-8], RAX   ; no-arg-parsing entry point
; 1E:       488BD0           MOV RDX, RAX
; 21:       4883EC10         SUB RSP, 16
; 25:       B902000000       MOV ECX, 2
; 2A:       48892C24         MOV [RSP], RBP
; 2E:       488BEC           MOV RBP, RSP
; 31:       E8C2737CFD       CALL #x504990F8    ; #<FDEFN SQUARE>
; 36:       480F42E3         CMOVB RSP, RBX
; 3A:       488B45F8         MOV RAX, [RBP-8]
; 3E:       488BFA           MOV RDI, RDX
; 41:       488BD0           MOV RDX, RAX
; 44:       E807EE42FF       CALL #x52100B50    ; GENERIC-+
; 49:       488BE5           MOV RSP, RBP
; 4C:       F8               CLC
; 4D:       5D               POP RBP
; 4E:       C3               RET
NIL
~~~~


ここで `x` に型宣言を追加すると、コンパイラは式 `(square x)` が `fixnum` だと仮定でき、fixnum 専用の `+` を使えます。

~~~lisp
(defun do-some-arithmetic (x)
  (declare (optimize (speed 3) (debug 0) (safety 0)))
  (declare (type fixnum x))
  (the fixnum (+ x (square x))))

       (disassemble 'do-some-arithmetic)

; disassembly for DO-SOME-ARITHMETIC
; Size: 48 bytes. Origin: #x52C084DA
; 4DA:       488945F8         MOV [RBP-8], RAX   ; no-arg-parsing entry point
; 4DE:       4883EC10         SUB RSP, 16
; 4E2:       488BD0           MOV RDX, RAX
; 4E5:       B902000000       MOV ECX, 2
; 4EA:       48892C24         MOV [RSP], RBP
; 4EE:       488BEC           MOV RBP, RSP
; 4F1:       E8020C89FD       CALL #x504990F8    ; #<FDEFN SQUARE>
; 4F6:       480F42E3         CMOVB RSP, RBX
; 4FA:       488B45F8         MOV RAX, [RBP-8]
; 4FE:       4801D0           ADD RAX, RDX
; 501:       488BD0           MOV RDX, RAX
; 504:       488BE5           MOV RSP, RBP
; 507:       F8               CLC
; 508:       5D               POP RBP
; 509:       C3               RET
NIL
~~~~

### コードのインライン化

宣言 [`inline`][inline] は、コンパイラがサポートしていれば関数呼び出しを関数本体で置き換えます。関数呼び出しのコストは節約できますが、コードサイズは増える可能性があります。`inline` を使う最適な状況は、小さいけれど頻繁に使われる関数でしょう。次のコードはコードのインライン化を促す方法と禁止する方法を示しています。

~~~lisp
;; globally defined function DISPATCH は open-coded にされるべきです。
;; implementation が inlining をサポートしており、NOTINLINE declaration が
;; この効果を上書きしない場合です。
(declaim (inline dispatch))
(defun dispatch (x) (funcall (get (car x) 'dispatch) x))

;; inlining が促される例です。
;; function DISPATCH は INLINE として定義されているため、
;; code inlining はデフォルトで促されます。
(defun use-dispatch-inline-by-default ()
  (dispatch (read-command)))

;; inlining が禁止される例です。
;; ここでの NOTINLINE はこの関数にだけ影響します。
(defun use-dispatch-with-declare-notinline  ()
  (declare (notinline dispatch))
  (dispatch (read-command)))

;; inlining が禁止される例です。
;; ここでの NOTINLINE は以後のすべての code に影響します。
(declaim (notinline dispatch))
(defun use-dispatch-with-declaim-noinline ()
  (dispatch (read-command)))

;; 指定したため inlining が促されます。
;; ここでの INLINE はこの関数にだけ影響します。
(defun use-dispatch-with-inline ()
  (declare (inline dispatch))
  (dispatch (read-command)))
~~~

インライン化された関数が変わった場合、すべての呼び出し元を再コンパイルしなければならないことに注意してください。

<a id="generic-function-"></a>

## 総称関数の最適化

### 静的ディスパッチを使う

総称関数は開発中に多くの利便性と柔軟性を提供します。しかし、その柔軟性にはコストがあります。総称メソッドは単純な関数よりずっと遅いのです。柔軟性が不要な場合、この性能上のコストは特に負担になります。

パッケージ [`inlined-generic-function`][inlined-generic-function] は、総称関数を静的ディスパッチに変換し、ディスパッチのコストをコンパイル時に移す関数を提供します。総称関数を `inlined-generic-function` として定義するだけで済みます。

**注意**

このパッケージは実験的と宣言されているため、本番環境の重要なソフトウェアでの利用は推奨されません。自己責任で使ってください。

~~~lisp
* (defgeneric plus (a b)
    (:generic-function-class inlined-generic-function))
#<INLINED-GENERIC-FUNCTION HELLO::PLUS (2)>

* (defmethod plus ((a fixnum) (b fixnum))
    (+ a b))
#<INLINED-METHOD HELLO::PLUS (FIXNUM FIXNUM) {10056D7513}>

* (defun func-using-plus (a b)
    (plus a b))
FUNC-USING-PLUS

* (defun func-using-plus-inline (a b)
    (declare (inline plus))
    (plus a b))
FUNC-USING-PLUS-INLINE

* (time
   (dotimes (i 100000)
     (func-using-plus 100 200)))
Evaluation took:
  0.018 seconds of real time
  0.017819 seconds of total run time (0.017800 user, 0.000019 system)
  100.00% CPU
  3 lambdas converted
  71,132,440 processor cycles
  6,586,240 bytes consed

* (time
   (dotimes (i 100000)
     (func-using-plus-inline 100 200)))
Evaluation took:
  0.001 seconds of real time
  0.000326 seconds of total run time (0.000326 user, 0.000000 system)
  0.00% CPU
  1,301,040 processor cycles
  0 bytes consed
~~~

一度インライン化されるとメソッドに加えた変更が反映されないため、インライン化はデフォルトでは有効になっていません。

[`*features*`][*features*] に `:inline-generic-function` フラグを追加すると、全体で有効化できます。

~~~lisp
* (push :inline-generic-function *features*)
(:INLINE-GENERIC-FUNCTION :SLYNK :CLOSER-MOP :CL-FAD :BORDEAUX-THREADS
:THREAD-SUPPORT :CL-PPCRE ALEXANDRIA.0.DEV::SEQUENCE-EMPTYP :QUICKLISP
:QUICKLISP-SUPPORT-HTTPS :SB-BSD-SOCKETS-ADDRINFO :ASDF3.3 :ASDF3.2 :ASDF3.1
:ASDF3 :ASDF2 :ASDF :OS-UNIX :NON-BASE-CHARS-EXIST-P :ASDF-UNICODE :ROS.INIT
:X86-64 :64-BIT :64-BIT-REGISTERS :ALIEN-CALLBACKS :ANSI-CL :AVX2
:C-STACK-IS-CONTROL-STACK :CALL-SYMBOL :COMMON-LISP :COMPACT-INSTANCE-HEADER
:COMPARE-AND-SWAP-VOPS :CYCLE-COUNTER :ELF :FP-AND-PC-STANDARD-SAVE ..)
~~~

このフィーチャが存在する場合、`notinline` と宣言されていない限り、インライン化可能なすべての総称関数がインライン化されます。

## 複数の戻り値

通常、`values` と `multiple-value-bind ` は "cons" しません。一方 `(cons a b)` の呼び出しはヒープに割り当てます。これらを使いましょう。

parcom ライブラリ [parcom][parcom] では、`cons` の代わりに `values` を使うことでメモリ使用量が 30% 減りました。

## スタックへの割り当て

`(declare (dynamic-extent your-variable))` により、ローカル変数をヒープではなくスタックに割り当ててほしいとコンパイラに伝えられます。関数が戻るとメモリは自動的に解放されます。


## ブロックコンパイル

SBCL は [version 2.0.2 でブロックコンパイルを得ました](https://mstmetent.blogspot.com/2020/02/block-compilation-fresh-in-sbcl-202.html)。これは CMUCL では 1991 年からありましたが、少し忘れられていました。

ブロックコンパイルは 1 行で有効化できます。

~~~lisp
(setq *block-compile-default* t)
~~~

ではこれは何でしょうか。

ブロックコンパイルは動的言語のよく知られた側面に対処します。グローバルなトップレベル関数への関数呼び出しは高価です。

> 静的にコンパイルされる言語よりはるかに高価です。遅い理由は、トップレベルで定義された関数の遅延束縛という性質にあります。プログラムが実行中に任意に再定義できるため、その関数が正しい数や型の引数で呼び出されているかについて実行時検査を強制されます。この種の呼び出しは Python（CMUCL と SBCL で使われるコンパイラであり、プログラミング言語と混同しないでください）で "full call" と呼ばれ、その呼び出し規約は最大限の実行時の柔軟性を許します。

しかしローカル呼び出し、つまりトップレベル関数の内側にあるもの（たとえば `lambda`、`labels`、`flet`）は高速です。

> これらの呼び出しは、静的な言語の関数呼び出しに近いものとして扱われるという意味で、より「静的」です。参照しているローカル関数と「一緒に」同時にコンパイルされ、コンパイル時に最適化できるためです。たとえば、呼び出し先の引数数がコンパイル時に分かるため、引数の検査はコンパイル時に行えます。full call の場合は、関数と、それが取る引数数が実行時の任意の時点で動的に変わり得るため、そうではありません。さらに、ローカル呼び出しの呼び出し規約では float のような unboxed な値を渡せる場合があります。これらは、full call の規約では使われない unboxed なレジスタに入れられるからです。full call の規約は boxed な引数および戻り値のレジスタを使わなければなりません。

つまりブロックコンパイルを有効にすると、コードが巨大な `labels` フォームになるようなものです。

アプリケーションによっては明白な、起こりうる欠点の 1 つは、実行時に関数を再定義できなくなることです。

`compile-file` に `:block-compile` キーワードを渡してブロックコンパイルを有効化することもできます。

~~~lisp
(defun foo (x y)
  (print (bar x y))
  (bar x y))

(defun bar (x y)
  (+ x y))

(defun fact (n)
  (if (zerop n)
      1
      (* n (fact (1- n)))))

> (compile-file "foo.lisp" :block-compile t :entry-points nil)
> (load "foo.fasl")

> (sb-disassem:disassemble-code-component #'foo)
~~~

アセンブリを調べると、

> FOO と BAR が同じコンポーネント（ローカル呼び出し付き）にコンパイルされ、両方とも有効な外部エントリポイントを持つことが分かるでしょう。これによりコードの局所性がかなり改善され、それでもファイルの外部（たとえば REPL）から FOO と BAR の両方を呼び出せます。[…]

しかしブロックコンパイルが追加する良い点はもう 1 つあります。

> 上で `:entry-points` nil を指定したことに注意してください。これは、ファイル内のすべての関数に外部エントリポイントをまだ作成するようコンパイラに伝えています。コードコンポーネント（つまりコンパイル済みのコンパイル単位、ここではファイル全体）の外から通常どおり呼び出せるようにしたいからです。

さらなる説明については、SBCL の現在の事実上のドキュメントである前述のブログ記事と、[CMUCL's documentation](https://cmucl.org/docs/cmu-user/html/Block-Compilation.html) を参照してください（CMUCL にあるフォームごとの細かい粒度（` (declaim (start-block ...)) ... (declaim (end-block ..))`）は、執筆時点の SBCL にはないことに注意してください）。

最後に、「ブロックコンパイルとインライン化は現状 [SBCL では] あまりうまく連携しない」ことに注意してください。

## 参考

* [CMUCL's Advanced Compiler Use and Efficiency Hints](https://cmucl.org/downloads/doc/cmu-user-2010-05-03/compiler-hint.html)。SBCL はここから来ています。
* [Common Lisp の最適化（parcom ライブラリ向け）](https://www.fosskers.ca/en/blog/optimizing-common-lisp)
* [Idiomatic Lisp and the nbody benchmark](https://www.stylewarning.com/posts/nbody/) (2026) - Lisp の DSL、C と同等の性能の達成、可読性、再利用性、そして Lisp 固有の追加の利点について。


[time]: http://www.lispworks.com/documentation/lw51/CLHS/Body/m_time.htm
[trace-output]: http://www.lispworks.com/documentation/lw71/CLHS/Body/v_debug_.htm#STtrace-outputST
[disassemble]: http://www.lispworks.com/documentation/lw60/CLHS/Body/f_disass.htm
[inlined-generic-function]: https://github.com/guicho271828/inlined-generic-function
[type]: type.html
[declare]: http://www.lispworks.com/documentation/lw71/CLHS/Body/s_declar.htm
[declare-scope]: http://www.lispworks.com/documentation/lw71/CLHS/Body/03_cd.htm
[optimize]: http://www.lispworks.com/documentation/lw71/CLHS/Body/d_optimi.htm
[sbcl-type]: http://sbcl.org/manual/index.html#Handling-of-Types
[declaim]: http://www.lispworks.com/documentation/lw71/CLHS/Body/m_declai.htm
[inline]: http://www.lispworks.com/documentation/lw51/CLHS/Body/d_inline.htm
[*features*]: http://www.lispworks.com/documentation/lw71/CLHS/Body/v_featur.htm
[parcom]: https://www.fosskers.ca/en/blog/optimizing-common-lisp
