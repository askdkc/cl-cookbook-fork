---
title: マクロ
---

コンピュータサイエンスでは、_macro_ という語は一般に、プログラミング言語への構文拡張を意味します。（注: この名前は、多くの第 2 世代アセンブリ言語で便利だった "macro-instruction" という語に由来します。macro-instruction は単一の命令のように見えますが、実際には一連の命令へ展開されます。この基本的な考え方は、その後 C プリプロセッサなどで何度も使われてきました。"macro" という名前は、指しているものとあまり関係がない響きなので理想的ではないかもしれませんが、私たちはこの名前と付き合っていくしかありません。）多くの言語にマクロ機能はありますが、Lisp のマクロほど強力なものはありません。Lisp マクロの基本機構は単純ですが、微妙な複雑さもあるため、使いこなすには少し練習が必要です。

## マクロの仕組み

マクロは、_別の Lisp コードらしきもの_ を操作し、それを実行可能な Lisp に（より近い形へ）変換する、普通の Lisp コードです。少し複雑に聞こえるかもしれないので、簡単な例を見てみましょう。2 つの変数を同じ値に設定する [`setq`](http://www.lispworks.com/documentation/HyperSpec/Body/s_setq.htm) の変種がほしいとします。つまり、次のように書いたとき、

~~~lisp
(setq2 x y (+ z 3))
~~~

`z`=8 なら、`x` と `y` の両方が 11 に設定される、というものです。（これが何に役立つかは思いつきませんが、例として使います。）

`setq2` を関数として定義できないことは明らかです。もし `x`=50 で `y`=_-5_ なら、この関数は 50、_-5_、11 という値を受け取るだけで、どの変数を設定すべきかを知ることができません。本当に言いたいのは、あなた（Lisp システム）が次を見たら、

```lisp
(setq2 v1 v2 e)
```

次と同等に扱ってほしい、ということです。

```lisp
(progn
  (setq v1 e)
  (setq v2 e))
```

厳密にはこれはまだ正しくありませんが、今のところは十分です。マクロを使うと、入力パターン <code>(setq2 <i>v<sub>1</sub></i> <i>v<sub>2</sub></i> <i>e</i>)</code> を出力パターン `(progn ...)` へ変換するプログラムを指定することで、まさにこれを実現できます。

### クォート

`setq2` マクロは次のように定義できます。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (list 'progn (list 'setq v1 e) (list 'setq v2 e)))
~~~

これは 2 つの変数と 1 つの式を引数として受け取ります。

そしてコード片を返します。Lisp ではコードがリストで表現されるので、コードを表すリストをそのまま返せます。

ここでは *quote* も使っています。これは *special operator* です（関数でもマクロでもなく、Lisp の中核をなす少数の special operator の 1 つです）。

*quoted* なオブジェクトはそれ自身へ評価されます。つまり、そのまま返されます。

- `(+ 1 2)` は `3` に評価されますが、`(quote (+ 1 2))` は `(+ 1 2)` に評価されます。
- `(quote (foo bar baz))` は `(foo bar baz)` に評価されます。
- `'` は `quote` の省略記法です。`(quote foo)` と `'foo` は等価で、どちらも `foo` に評価されます。

したがって、このマクロは次の部品を返します。

- symbol `progn`
- 2 つ目のリスト。これは次を含みます。
  - symbol `setq`
  - 変数 `v1`: マクロ内ではこの変数は評価されないことに注意してください。
  - 式 `e`: これも評価されません。
- `v2` を含む 2 つ目のリスト。

次のように使えます。

```lisp
(defparameter v1 1)
(defparameter v2 2)
(setq2 v1 v2 3)
;; 3
```

確認すると、`v1` と `v2` は `3` に設定されています。


### Macroexpand

マクロを書き始めるのは、生成したいコードが分かってからです。書き始めたら、そのマクロが実際にどんなコードを生成するか確認できると非常に便利です。そのための関数が `macroexpand` です。これは関数なので、展開したいコードをリストとして渡します（つまり、渡すコード片をクォートします）。

~~~lisp
(macroexpand '(setq2 v1 v2 3))
;; (PROGN (SETQ V1 3) (SETQ V2 3))
;; T
~~~

よし、マクロは望んだコードへ展開されています。

さらに興味深い例です。

~~~lisp
(macroexpand '(setq2 v1 v2 (+ z 3)))
;; (PROGN (SETQ V1 (+ z 3)) (SETQ V2 (+ z 3)))
;; T
~~~

ここで式 `e`、つまり `(+ z 3)` は評価されていないことを確認できます。引数の評価をカンマ `,` で制御する方法は後で見ます。

### 注: Slime の小技

Slime では、展開したい s-expression の左括弧の位置にカーソルを置き、``M-x
slime-macroexpand-[1,all]`` または ``C-c M-m`` を実行すると macroexpand を呼び出せます。

~~~lisp
[|](setq2 v1 v2 3)
;^ cursor
; C-c M-m
; =>
; (PROGN (SETQ V1 3) (SETQ V2 3))
~~~

もう 1 つの小技です。マクロ名の上で ``C-c C-w m``（または ``M-x
slime-who-macroexpands``）を入力すると、そのマクロが展開されたすべての場所を含む新しいバッファが得られます。その後、通常どおり ``C-c C-k``（``slime-compile-and-load-file``）を入力すれば、それらをすべて再コンパイルできます。


### マクロ VS 関数

このマクロは、次の関数定義にとても近いものです。

~~~lisp
(defun setq2-function (v1 v2 e)
  (list 'progn (list 'setq v1 e) (list 'setq v2 e)))
~~~

`(setq2-function 'x 'y '(+ z 3))` を評価したとします（各引数は *quoted* されているので、関数呼び出し時には評価されません）。すると次が得られます。

```lisp
(progn (setq x (+ z 3)) (setq y (+ z 3)))
```

これは完全に普通の Lisp の計算であり、唯一面白い点は、その出力が実行可能な Lisp コード片だということです。`defmacro` が行うのは、この関数を暗黙に作り、`(setq2 x y (+ z 3))` という形の式が見つかるたびに、フォームの部品、すなわち `x`、`y`、`(+ z 3)` を引数として `setq2-function` を呼び出すようにすることです。得られたコード片は `setq2` の呼び出しを置き換え、最初からその新しいコード片がそこにあったかのように実行が続きます。マクロフォームは新しいコード片へ _展開（expand）_ されると言われます。

### 評価コンテキスト

これがすべてです。ただし、もちろん、そこから非常に多くの微妙な帰結が生まれます。主な帰結は、_`setq2` マクロにとっての実行時_ が _そのコンテキストにとってのコンパイル時_ だということです。たとえば、Lisp システムがある関数をコンパイルしている途中で `(setq2 x y (+ z 3))` という式を見つけたとします。コンパイラの仕事は、ソースコードを機械語やバイトコードなどの実行可能なものへ変換することです。したがって、コンパイラはソースコードを実行するのではなく、いろいろな神秘的な方法でそれを処理します。しかし、`setq2` 式を見つけた瞬間、コンパイラは突然 `setq2` マクロ本体の実行へ切り替えなければなりません。先ほど述べたように、これは普通の Lisp コードなので、原理的には他の Lisp コードができることは何でもできます。つまり、コンパイラが動いているとき、Lisp の（実行時）システム全体が存在していなければならない、ということです。

もう一度強調しておきます。コンパイル時には、言語全体を自由に使えます。

初心者はよく次のような間違いをします。`setq2` マクロが、その `e` 引数を結果に埋め込む前に何らかの複雑な変換をする必要があるとします。この変換は Lisp の手続き `some-computation` として書けるとします。初心者はしばしば次のように書きます。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (let ((e1 (some-computation e)))
    (list 'progn (list 'setq v1 e1) (list 'setq v2 e1))))

(defmacro some-computation (exp) ...) ;; _Wrong!_
~~~

間違いは、いったんマクロが呼び出されると Lisp システムが「マクロ世界」に入り、その世界のものは当然すべて `defmacro` で定義しなければならない、と考えることです。これは誤ったイメージです。正しいイメージは、`defmacro` によって _普通の Lisp 世界_ へ踏み込む、ただしそこで主に操作する対象が Lisp コードである、というものです。その段階に入ったら、通常の Lisp 関数定義を使います。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (let ((e1 (some-computation e)))
    (list 'progn (list 'setq v1 e1) (list 'setq v2 e1))))

(defun some-computation (exp) ...) ;; _Right!_
~~~

この間違いの理由の 1 つは、C のような他の言語では、プリプロセッサマクロを起動すると実際に別世界へ入るからかもしれません。そこでは任意の C プログラムを実行することはできません。それが可能だとしたら何を意味するか、少し考えてみる価値はあるでしょう。

もう 1 つの微妙な帰結は、マクロの引数が舞台裏の仮想的な関数（この例では `setq2-function` と呼んだもの）へどのように分配されるかを、明確に書かなければならないことです。ほとんどの場合、これは簡単です。マクロ定義では `&optional`、`&rest`、`&key` など通常の `lambda` リスト構文をすべて使えます。ただし、仮引数に束縛されるのはマクロフォームの部品であって、それらの値ではありません（値はたいてい不明です。なぜなら、これはマクロフォームにとってのコンパイル時だからです）。したがって、次のようにマクロを定義したとします。

~~~lisp
(defmacro foo (x &optional y &key (cxt 'null)) ...)
~~~

すると、

- `(foo a)` と呼ぶと、パラメータの値は `x=a`、`y=nil`、`cxt=null` です。
- `(foo (+ a 1) (- y 1))` と呼ぶと、`x=(+ a 1)`、`y=(- y 1)`、`cxt=null` です。
- `(foo a b :cxt (zap zip))` では、`x=a`、`y=b`、`cxt=(zap zip)` です。


変数の値は、実際の式 `(+ a 1)` や `(zap zip)` であることに注意してください。これらの式の値が既知である必要はなく、値を持つ必要すらありません。マクロはそれらを好きなように扱えます。たとえば、さらに役に立たない `setq` の変種として <code>(setq-reversible <i>e<sub>1</sub></i> <i>e<sub>2</sub></i> <i>d</i>)</code> を考えます。これは <i>d=</i><code>:normal</code> なら <code>(setq <i>e<sub>1</sub></i> <i>e<sub>2</sub></i>)</code> のように振る舞い、_d=_`:backward` なら <code>(setq <i>e<sub>2</sub></i> <i>e<sub>1</sub></i>)</code> のように振る舞います。次のように定義できます。

~~~lisp
(defmacro setq-reversible (e1 e2 direction)
  (case direction
    (:normal (list 'setq e1 e2))
    (:backward (list 'setq e2 e1))
    (t (error "Unknown direction: ~a" direction))))
~~~

展開は次のようになります。

~~~lisp
(macroexpand '(setq-reversible x y :normal))
(SETQ X Y)
T
(macroexpand '(setq-reversible x y :backward))
(SETQ Y X)
T
~~~

誤った方向を渡すと、

~~~lisp
(macroexpand '(setq-reversible x y :other-way-around))
~~~

エラーになり、デバッガへ入ります。

バッククォートとカンマの仕組みは次の節で見ますが、修正版は次のとおりです。

~~~lisp
(defmacro setq-reversible (v1 v2 direction)
  (case direction
    (:normal (list 'setq v1 v2))
    (:backward (list 'setq v2 v1))
    (t `(error "Unknown direction: ~a" ,direction))))
    ;; ^^ backquote                    ^^ comma: backquote の中で値を取り出す。

(macroexpand '(SETQ-REVERSIBLE v1 v2 :other-way-around))
;; (ERROR "Unknown direction: ~a" :OTHER-WAY-AROUND)
;; T
~~~

これで `(setq-reversible v1 v2 :other-way-around)` を呼ぶと、やはりエラーとデバッガは発生しますが、少なくとも `macroexpand` の時点では発生しません。

<a name="2-backquote"></a>

## バッククォートとカンマ

次へ進む前に、マクロ定義に不可欠な Lisp 記法を導入する必要があります。ただし技術的には、これはマクロそのものからは独立しています。それが _backquote facility_ です。上で見たように、マクロの主な仕事は、結局のところ Lisp コード片を定義することです。つまり `(list 'prog (list 'setq ...) ...)` のような式を評価することになります。これらの式が複雑になるにつれ、読みにくく書きにくくなります。欲しくなるのは、式の骨組みを示し、その一部を新しい式で埋め込める記法です。バッククォートはそれを提供します。上の `list` 式の代わりに、次のように書けます。

~~~lisp
  `(progn (setq ,v1 ,e) (setq ,v2 ,e))
;;^ backquote   ^   ^         ^   ^ commas
~~~

バッククォート（`）文字は、それに続く式の中で、カンマが前についていないすべての部分式はクォートされ、カンマが前についているすべての部分式は評価される、ということを示します。

これはデータ補間として考え、使うことができます。

~~~lisp
`(v1 = ,v1) ;; => (V1 = 3)
~~~


バッククォートについては、ほとんどこれだけです。ただし、追加で 2 つ指摘しておくことがあります。

#### Comma-splice ,@

まず、"`,e`" ではなく "`,@e`" と書くと、_e_ の値が結果に _spliced_（「結合」「合成」「差し込み」）されます。`v` が `(oh boy)` に等しいなら、

~~~lisp
`(zap ,@v ,v)
~~~

は次のように評価されます。

~~~lisp
(zap oh boy (oh boy))
;;   ^^^^^ v の要素（2 要素）が splice される。
;;          ^^ v 自身（リスト）
~~~

2 番目の `v` はその値で置き換えられます。最初のものは、その値の要素で置き換えられます。もし `v` の値が `()` なら、それは完全に消えます。`(zap ,@v ,v)` の値は `(zap ())` になり、これは `(zap nil)` と同じです。

#### Quote-comma ',

バッククォートの文脈にいて、式を文字どおり表示したいときは、quote と comma の組み合わせを使うしかありません。

~~~lisp
(defmacro explain-exp (exp)
  `(format t "~S = ~S" ',exp ,exp))
  ;;                   ^^

(explain-exp (+ 2 3))
;; (+ 2 3) = 5
~~~

自分で確かめてみましょう。

~~~lisp
;; quote をまったく使わない defmacro:
(defmacro explain-exp (exp)
  (format t "~a = ~a" exp exp))
(explain-exp v1)
;; V1 = V1

;; backquote と comma で exp の値を取り出す:
(defmacro explain-exp (exp)
  ;; 誤った例
  `(format t "~a = ~a" exp ,exp))
(explain-exp v1)
;; => error: The variable EXP is unbound.

;; そこで quote-comma を使う:
(defmacro explain-exp (exp)
  `(format t "~a = ~a" ',exp ,exp))
(explain-exp (+ 1 2))
;; (+ 1 2) = 3
~~~


#### ネストしたバッククォート

次に、バッククォート式の中に別のバッククォート式が現れたらどうなるのか、疑問に思うかもしれません。答えは、バッククォートが本質的に読めず書けないものになる、ということです。ネストしたバッククォートを使うのは、たいてい退屈なデバッグ作業になります。理由は、私のあまり謙虚ではない意見では、バッククォートの定義が間違っているからです。カンマは最も内側のバッククォートと対応しますが、本来のデフォルトは最も外側と対応すべきです。とはいえ、ここは愚痴を言う場所ではありません。ネストしたバッククォートの正確な振る舞いと例については、お気に入りの Lisp リファレンスを参照してください。

#### バッククォートでリストを作る

バッククォートの問題の 1 つは、一度覚えると、リストを作るあらゆる場面で使いたくなることです。たとえば、次のように書くかもしれません。

~~~lisp
(mapcan (lambda (x)
          (cond ((symbolp x) `((,x)))
                ((> x 10) `(,x ,x))
                (t '())))
        some-list)
~~~

これは `some-list` = `(a 6 15)` のとき `((a) 15 15)` を返します。問題は、[`mapcan`](http://www.lispworks.com/documentation/HyperSpec/Body/f_mapc_.htm) が [`lambda`](http://www.lispworks.com/documentation/HyperSpec/Body/s_lambda.htm) 式から返された結果を破壊的に変更することです。その式が返すリストが "[fresh](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_f.htm#fresh)"、つまりその `lambda` 式の他の呼び出しで返された構造とは（[`eq`](http://www.lispworks.com/documentation/HyperSpec/Body/f_eq.htm) の意味で）別物である、と確信できるでしょうか。今回の例では、綿密に調べれば fresh でなければならないことが分かります。しかし一般に、バッククォートは毎回 fresh なリストを返す義務を負いません（返すかどうかは実装依存です）。上の例が次のように変更されたとします。

~~~lisp
(mapcan (lambda (x)
          (cond ((symbolp x) `((,x)))
                ((> x 10) `(,x ,x))
                ((>= x 0) `(low))
                (t '())))
        some-list)
~~~

このときバッククォートは `(low)` を `'(low)` のように扱うかもしれません。そのリストはロード時に割り当てられ、`lambda` が評価されるたびに同じ記憶領域の塊が返されます。したがって `some-list` = `(a 6 15)` で式を評価すると、`((a) low 15 15)` が得られますが、副作用として定数 `(low)` が破壊されて `(low 15 15)` になります。その後、たとえば `some-list` = `(8 oops)` で式を評価すると、結果は `(low 15 15 (oops))` になり、最初は `'(low)` だった「定数」は `(low 15 15 (oops))` になっています。（注: ここで例示したバグは他の形でも現れ、初心者だけでなく経験豊富なプログラマも何度も痛い目を見ています。一般形は、何かの値として生成された定数リストが、後で破壊的に変更されるというものです。このバグに対する第一の防衛線は、どんなリストも破壊的に変更しないことです。初心者にとっては、これが最後の防衛線でもあります。自分たちをもう少し洗練されていると思っている人にとって、次の防衛線は [`nconc`](http://www.lispworks.com/documentation/HyperSpec/Body/f_nconc.htm) や `mapcan` を使うたびに非常に注意深く考えることです。）

このバグを直すには、`mapcan` の代わりに `(map 'list ...)` と書けます。しかし、どうしても `mapcan` を使うなら、式を次のように書きます。

~~~lisp
(mapcan (lambda (x)
          (cond ((symbolp x) (list `(,x)))
                ((> x 10) (list x x))
                ((>= x 0) (list 'low))
                (t '())))
        some-list)
~~~

個人的には、バッククォートは _S 式_、つまりシンボル、数値、文字列からなる階層的な式で、長さが変化するものとして概念化されていないものを作る場合にだけ使うのが好みです。たとえば、私は次のようには書きません。

~~~lisp
(setq sk `(,x ,@sk))
~~~

`sk` がスタックとして使われている、つまり通常の処理の中で [`pop`](http://www.lispworks.com/documentation/HyperSpec/Body/m_pop.htm) されるなら、私は `(push x sk)` と書きます。そうでなければ `(setq sk (cons x sk))` と書きます。

<a name="LtohTOCentry-3"></a>

## マクロを正しく書く

最初の節で、私の `setq2` の定義は厳密には正しくないと言いました。ここでそれを直します。

`x`_=8_ のとき `(setq2 x y (+ x 2))` と書いたとします。上で与えた定義によれば、このフォームは次へ展開されます。

~~~lisp
(progn
  (setq x (+ x 2))
  (setq y (+ x 2)))
~~~

そのため `x` は 10 になり、`y` は 12 になります。実際、マクロ展開は次のとおりです。

~~~lisp
(macroexpand '(setq2 x y (+ x 2)))
;;(PROGN (SETQ X (+ X 2)) (SETQ Y (+ X 2)))
~~~

おそらくこれは、そのマクロに期待される動作ではありません（もちろん、そうでないとは限りませんが）。もう 1 つの問題例は `(setq2 x y (pop l))` です。これは `l` を 2 回 pop してしまいます。これもおそらく正しくありません。

解決策は、式 `e` を 1 回だけ評価し、一時変数に保存してから、`v1` と `v2` をそれに設定することです。

### Gensym

一時変数を作るには、`gensym` 関数を使います。これは他のどこにも現れないことが保証された fresh な変数を返します。マクロは次のようになるべきです。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (let ((tempvar (gensym)))
    `(let ((,tempvar ,e))
       (progn (setq ,v1 ,tempvar)
              (setq ,v2 ,tempvar)))))
~~~

これで `(setq2 x y (+ x 2))` は次へ展開されます。

~~~lisp
(let ((#:g2003 (+ x 2)))
  (progn (setq x #:g2003) (setq y #:g2003)))
~~~

ここで `gensym` はシンボル `#:g2003` を返しています。このような妙な表示になるのは、reader がそれを認識しないからです。（それを reader が認識する必要もありません。なぜなら、そのシンボルはそれを含むコードがコンパイルされるまでの間だけ存在すればよいからです。）

練習: この新しい版が `(setq2 x y (pop l1))` の場合に正しく動作することを確認してください。

練習: バッククォートを使わずに、この新しい版のマクロを書いてみてください。できなければ、その練習は正しくできています。そして、バッククォートが何のためにあるかを学んだことになります。

この節の教訓は、マクロ内のどの式がいつ評価されるかを慎重に考えることです。同じ式が出力に 2 回埋め込まれる状況（最初のマクロ設計における `e` のようなもの）に注意してください。複雑なマクロでは、式が評価される順序が、書かれている順序と異なる場合にも気をつけてください。これはマクロの利用者を必ずつまずかせます。たとえ利用者が自分だけであってもです。<a name="LtohTOCentry-4"></a>

## マクロは何のためにあるか

マクロは Lisp に構文拡張を作るためのものです。マクロは悪い考えだ、ユーザーに任せてはいけない、などと言われることがあります。ばかげています。自分の手続きを定義して言語を拡張するのと同じくらい、構文的に言語を拡張するのは合理的です。たしかに、あなたのコードを気軽に読む人は、マクロ定義を見なければコードを理解できないかもしれません。しかし、関数定義を見なければ理解できないのも同じです。複数のファイルに散らばった [`defmethod`](http://www.lispworks.com/documentation/HyperSpec/Body/m_defmet.htm) の方が、マクロよりはるかに不明瞭さに寄与しますが、それは別の長話です。

私が有用だと思う構文拡張の種類を眺める前に、一般に _有用ではない_ 構文拡張、あるいはマクロ以外の手段で実現した方がよいものを指摘しておきます。初心者の中には、マクロは関数を open-code するために便利だと考える人がいます。たとえば、次のように定義する代わりに、

~~~lisp
(defun sqone (x)
  (let ((y (+ x 1))) (* y y)))
~~~

次のように定義するかもしれません。

~~~lisp
(defmacro sqone (x)
  `(let ((y (+ ,x 1))) (* y y)))
~~~

すると `(sqone (* z 13))` は次へ展開されます。

~~~lisp
(let ((y (+ (* z 13) 1)))
  (* y y))
~~~

これは正しいですが、労力の無駄です。第一に、節約される時間はほぼ確実に無視できます。本当に `sqone` をインライン展開することが重要なら、`sqone` を定義する前に `(declaim (inline sqone))` を置けます（ただし、コンパイラがこの宣言に従う義務はありません）。第二に、`sqone` をマクロとして定義すると、`(mapcar #'sqone ll)` と書くことも、それ以外に呼び出す以外のことをすることも不可能になります。

しかし、マクロには正当な用途が山ほどあります。`(^ (x) ...)` と書けるなら、なぜ `(lambda (x) ...)` と書くのでしょう。`^` をマクロとして定義すればよいのです。

```lisp
(defmacro ^ (&rest body)
  `(lambda ,@body))
```

多くの人は、特に大きな `lambda` 式と一緒に使うとき、`mapcar` や `mapcan` は少し分かりにくいと感じます。次のようなものを書く代わりに、

~~~lisp
(mapcar (lambda (x)
          (let ((y (hairy-fun1 x))
                (z (hairy-fun2 x)))
            (dolist (y1 y)
              (dolist (z1 z)
                _... and further meaningless_
                _space-filling nonsense..._
                ))))
        list)
~~~

次のように書きたいかもしれません。

~~~lisp
(for (x :in list)
     (let ((y (hairy-fun1 x))
           (z (hairy-fun2 x)))
       (dolist (y1 y)
         (dolist (z1 z)
           _... and further meaningless_
           _space-filling nonsense..._
           ))))
~~~

このマクロは次のように定義できます。

~~~lisp
(defmacro for (listspec exp)
  ;;           ^^ listspec = (x :in list), 長さ 3 のリスト。
  ;;                    ^^ exp = 残りのコード。
  (cond
    ((and (= (length listspec) 3)
          (symbolp (first listspec))
          (eq (second listspec) ':in))
     `(mapcar (lambda (,(first listspec))
                ,exp)
              ,(third listspec)))
    (t (error "Ill-formed for spec: ~A" listspec)))))
~~~

（これは Chris Riesbeck によるマクロの簡略版です。）

このマクロで keyword `:in` が果たす役割について、少し立ち止まって考える価値があります。これは「局所的な構文マーカー」のように機能します。Lisp から見れば意味はありませんが、マクロ自身にとっては構文上の道しるべになります。このようなマーカーを _guide symbols_ と呼ぶことにします。（ここでの役割は些細に見えるかもしれませんが、`for` マクロを一般化して複数のリスト引数や本体内の暗黙の `progn` を許すなら、`:in` は引数がどこで終わり、本体がどこから始まるかを知らせる上で重要になります。）

マクロの guide シンボルが [keyword パッケージ](http://www.lispworks.com/documentation/HyperSpec/Body/11_abc.htm) にあることは厳密には必要ではありませんが、2 つの理由から良い考えです。第一に、何か独自のことが起きていることを読み手に目立たせます。`(for ((x in (foobar a b 'oof))) (something-hairy x (list x)))` のようなフォームは、`x` の前の二重括弧のためにすでに少し奇妙に見えます。しかし "`:in`" を使うと、それがより明白になります。

第二に、guide シンボルの存在を確認するために、マクロ定義で `(eq (second listspec) ':in)` と書いたことに注意してください。もし `:in` ではなく `in` を使っていたら、_自分の_ `in` がどのパッケージに住み、マクロ利用者の `in` がどのパッケージに住むかを考えなければなりません。問題を避ける方法の 1 つは次のように書くことです。

~~~lisp
(and (symbolp (second listspec))
     (eq (intern (symbol-name (second listspec))
                 :keyword)
         ':in))
~~~

もう 1 つは次のように書くことです。

~~~lisp
(and (symbolp (second listspec))
     (string= (symbol-name (second listspec)) (symbol-name 'in)))
~~~

どちらも特に明快でも美しくもありません。keyword パッケージは、ホームが本質的に関係ないシンボルの置き場所を提供するためにあります。使えばよいのです。（注: ANSI Lisp では `(symbol-name 'in)` の代わりに `"IN"` と書けますが、シンボル名を大文字へ変換しない Lisp 実装もあります。大文字変換という考え全体は恥ずかしい遺物だと思っているので、私はそうした実装にも移植できるコードを書くようにしています。）

もう 1 つ例を見てみましょう。これは便利なマクロを示すと同時に、後の議論で使う補助関数を提供します。Lisp では新しいシンボルを作りたいことがよくありますが、それらを構築するには `gensym` だけでは不十分なことがあります。`build-symbol` という代替機能の説明は次のとおりです。

> <code>(build-symbol [(:package <em>p</em>)] <em>-pieces-</em>)</code> は、指定された _pieces_ を連結してシンボルを作り、_p_ によって指定された方法で intern します。_pieces_ の各要素について、それが ...
>
> *   ... string: その文字列が新しいシンボル名へ追加されます。
> *   ... symbol: そのシンボルの名前が新しいシンボル名へ追加されます。
> *   ... <code>(:< <em>e</em>)</code> という形の式: _e_ は文字列、シンボル、number のいずれかへ評価されるべきです。_e_ の値を `princ` で表示した文字列が新しいシンボル名へ連結されます。
> *   ... <code>(:++ <em>p</em>)</code> という形の式: _p_ は place 式（つまり `setf` の第 1 引数として適切なもの）で、その値は整数であるべきです。その値は 1 増やされ、新しい値が新しいシンボル名へ連結されます。
>
> `:package` 指定が省略された場合、デフォルトは `*package*` の値です。_p_ が `nil` ならシンボルはどこにも intern されません。そうでなければ、パッケージ designator（通常はパッケージと同じ名前を持つ keyword）へ評価されるべきです。

たとえば、`x` = `foo` で `*x-num*` = 8 のとき `(build-symbol (:< x) "-" (:++ *x-num*))` は、`*x-num*` を 9 に設定し、`FOO-9` に評価されます。もう一度評価すると、結果は `FOO-10` になり、以下同様です。

明らかに、`build-symbol` は関数として実装できません。マクロでなければなりません。実装は次のとおりです。

~~~lisp
(defmacro build-symbol (&rest list)
  (let ((p (find-if (lambda (x)
                      (and (consp x)
                           (eq (car x) ':package)))
                    list)))
    (when p
      (setq list (remove p list)))
    (let ((pkg (cond ((eq (second p) 'nil)
                      nil)
                     (t `(find-package ',(second p))))))
      (cond (p
             (cond (pkg
                    `(values (intern ,(symstuff list) ,pkg)))
                   (t
                    `(make-symbol ,(symstuff list)))))
            (t
             `(values (intern ,(symstuff list))))))))

(defun symstuff (list)
  `(concatenate 'string
     ,@(for (x :in list)
            (cond ((stringp x)
                   `',x)
                  ((atom x)
                   `',(format nil "~a" x))
                  ((eq (car x) ':<)
                   `(format nil "~a" ,(second x)))
                  ((eq (car x) ':++)
                   `(format nil "~a" (incf ,(second x))))
                  (t
                   `(format nil "~a" ,x))))))
~~~

（別の方法として、`symstuff` が <code>(format nil <em>format-string -forms-</em>)</code> という形の単一の呼び出しを返すようにしてもよいでしょう。このとき _forms_ は _pieces_ から導かれ、_format-string_ は ~a と文字列が交互に並んだものになります。）

ときには、マクロが一時的にだけ、構文上の足場のようなものとして必要になることがあります。12 個の関数を定義する必要があるが、それらが 4 個ずつの典型的な 3 グループに分かれているとします。

~~~lisp
(defun make-a-zip (y z)
  (vector 2 'zip y z))
(defun test-whether-zip (x)
  (and (vectorp x) (eq (aref x 1) 'zip)))
(defun zip-copy (x) ...)
(defun zip-deactivate (x) ...)

(defun make-a-zap (u v w)
  (vector 3 'zap u v w))
(defun test-whether-zap (x) ...)
(defun zap-copy (x) ...)
(defun zap-deactivate (x) ...)

(defun make-a-zep ()
  (vector 0 'zep))
(defun test-whether-zep (x) ...)
(defun zep-copy (x) ...)
(defun zep-deactivate (x) ...)
~~~

省略された部分は、同じような名前の関数ではすべて同じだとします。（つまり、`zep-deactivate` の "..." は `zip-deactivate` の "..." と同じコード、という具合です。）ここでは具体性のため、もっともらしさはともかく、`zip`、`zap`、`zep` は奇妙な小さなデータ構造のように振る舞っているとします。関数はかなり大きくなり得るので、デバッグしながらすべてを同期させ続けるのは退屈です。代替案はマクロを使うことです。

~~~lisp
(defmacro odd-define (name buildargs)
  `(progn (defun ,(build-symbol make-a- (:< name))
                                ,buildargs
            (vector ,(length buildargs) ',name ,@buildargs))
          (defun ,(build-symbol test-whether- (:< name)) (x)
            (and (vectorp x) (eq (aref x 1) ',name))
          (defun ,(build-symbol (:< name) -copy) (x)
            ...)
          (defun ,(build-symbol (:< name) -deactivate) (x)
            ...))))

(odd-define zip (y z))
(odd-define zap (u v w))
(odd-define zep ())
~~~

このマクロの使用がすべてこの 1 か所にまとまっているなら、[macrolet](http://www.lispworks.com/documentation/HyperSpec/Body/s_flet_.htm) を使ってローカルマクロにした方が明快かもしれません。

~~~lisp
(macrolet ((odd-define (name buildargs)
             `(progn
                (defun ,(build-symbol make-a- (:< name))
                                        ,buildargs
                    (vector ,(length buildargs)
                            ',name
                             ,@buildargs))
                  (defun ,(build-symbol test-whether- (:< name))
                         (x)
                    (and (vectorp x) (eq (aref x 1) ',name))
                  (defun ,(build-symbol (:< name) -copy) (x)
                    ...)
                  (defun ,(build-symbol (:< name) -deactivate) (x)
                    ...)))))
(odd-define zip (y z))
(odd-define zap (u v w))
(odd-define zep ()))
~~~

最後に、マクロは「コマンド言語」を定義するために不可欠です。_command_ は、ユーザーが Lisp の read-eval-print loop と対話するときに使う短い名前の関数です。短い名前が便利で可能なのは、タイプしやすくしたい一方で、その名前が他のコマンドと衝突するかどうかはあまり気にしないからです。2 つのコマンド名が衝突したら、片方を変えればよいのです。

例として、マクロをデバッグする小さなコマンド言語を定義してみましょう。（実際に便利だと感じるかもしれません。）コマンドは `ex` と `fi` の 2 つだけです。これらは「現在のフォーム」、つまり macro-expanded される対象またはその展開結果を追跡します。

1.  <code>(ex [<em>form</em>])</code>: _form_ が与えられていればそれに、そうでなければ現在のフォームに `macroexpand-1` を適用し、その結果を現在のフォームにします。その後、現在のフォームを pretty-print します。
2.  <code>(fi <em>s</em> [<em>k</em>])</code>: 現在のフォームのうち、`car` が _s_ である _k_ 番目の部分式を探します。(_k_ のデフォルトは 0 です。) その部分式を現在のフォームにし、pretty-print します。

`hair-squared` というマクロをデバッグしようとしているとします。このマクロは複雑なものへ展開され、その中にシンボル `odd-define` で始まるマクロフォームが含まれています。その部分フォームにバグがあると疑っています。次のコマンドを発行できます。

~~~lisp
(ex (hair-squared ...))
(PROGN (DEFUN ...)
         (ODD-DEFINE ZIP (U V W))
         ...)

(fi odd-define)
(ODD-DEFINE ZIP (U V W))

(ex)
(PROGN (DEFUN MAKE-A-ZIP (U V W) ...)
   ...)
~~~

繰り返しますが、`ex` と `fi` は関数にはできないことが明らかです。ただし、引数の前に quote を打つことを厭わないなら、簡単に関数にできます。しかし、コマンドで "quote" をよく使うのは不適切に思えることがあります。第一に、キーストロークを節約しようとしている文脈でそれをタイプする必要があるのは面倒です。特に、その引数が常にクォートされるならなおさらです。第二に、多くの場合、単に不自然に見えます。引数の 1 つとしてシンボルを受け取り、それをある値に設定するコマンドがあるなら、<code>(<em>command</em> 'x ...)</code> と書くのは、<code>(<em>command</em> x ...)</code> と書くより奇妙です。なぜなら、そのコマンドを `setq` の変種として考えたいからです。

`ex` と `fi` は次のように定義できます。

~~~lisp
(defvar *current-form*)

(defmacro ex (&optional (form nil form-supplied))
  `(progn
     (pprint (setq *current-form*
                   (macroexpand-1
                    ,(cond (form-supplied
                            `',form)
                           (t '*current-form*)))))
     (values)))

(defmacro fi (s &optional (k 0))
  `(progn
     (pprint (setq *current-form*
                   (find-nth-occurrence ',s *current-form* ,k)))
     (values)))
~~~

`ex` マクロは `macroexpand-1` への呼び出しを含むフォームへ展開されます。`macroexpand-1` は組み込み関数で、`car` がマクロ名であるフォームに対して、マクロ展開を 1 ステップ行います。（別のフォームが与えられた場合は、そのフォームを変更せずに返します。）`pprint` は引数を pretty-print する組み込み関数です。`ex` と `fi` は read-eval-print loop で使うので、展開が返す値はすべて印字されます。ここでは展開は副作用のために実行されるので、展開が `(values)` を返すようにして、値をまったく返さないようにします。

Lisp 実装によっては、read-eval-print loop が通常 `pprint` を使って結果を印字します。そのような実装では、`ex` と `fi` が何も印字せず、単に `*current-form*` の値を返すように単純化できます。read-eval-print loop がそれをきれいに印字してくれるからです。判断して使ってください。

`find-nth-occurrence` の定義は練習問題として残しておきます。現在のフォームを設定して印字するだけのコマンド <code>(cf <em>e</em>)</code> も定義したくなるかもしれません。

注意点を 1 つ。一般に、コマンド言語はマクロと関数の混合からなり、それを定義する人（そして普通は唯一の利用者）にとって便利であることが主な考慮事項になります。あるコマンドが、ときどき一部の引数を評価したがっているように見えるなら、そのコマンドを 2 つ（またはそれ以上）のバージョンとして定義するか、1 つの関数として定義して、評価を防ぐために引数をクォートしてもらうかを決める必要があります。前の段落で述べた `cf` コマンドについては、`cf` を関数にしたいユーザーもいれば、マクロにしたいユーザーもいるでしょう。

## define-symbol-macro, symbol-macrolet

これら 2 つのマクロは、別のより複雑なフォームへの「ショートカット」として振る舞うシンボルを定義できるようにします。

仕様の言葉では、これらは「指定されたシンボルのマクロ展開に影響を与える仕組みを提供する」ものです。

`define-symbol-macro` はグローバル環境に影響します（`defparameter`、`defun` などと同様です）。`symbol-macrolet` は `let` のようにローカルスコープで使います。

データ構造の節で例を示しました。構造体を使います。

~~~lisp
(defstruct ship x-position y-position x-velocity y-velocity)
~~~

そのスロット accessor は `ship-x-position` などです。

すべての異なる structure スロットにアクセスしなければならない `move-ship` 関数を書きます。

~~~lisp
(defun move-ship (ship)
  (psetf (ship-x-position ship)
           (+ (ship-x-position ship) (ship-x-velocity ship))
         (ship-y-position ship)
           (+ (ship-y-position ship) (ship-y-velocity ship)))
   ship)
~~~

しかし、これは冗長です。そこで、`x` が `ship-x-position` へ展開されるようにローカルシンボルマクロを使います。

`symbol-macrolet` は次のような形で、構文は `let` に似ています。

~~~lisp
(symbol-macrolet ((x (ship-x-position ship))
                  (y (other-form ship)))
    (use x and y here))
~~~

関数の中で使ってみましょう。

~~~lisp
(defun move-ship (ship)
  (symbol-macrolet                   ;; <---- LET のようなもの
      ((x (ship-x-position ship))    ;; <---- (symbol (expansion form)) のリスト
       (y (ship-y-position ship))
       (xv (ship-x-velocity ship))
       (yv (ship-y-velocity ship)))
    (psetf x (+ x xv)                ;; <----- 本体で x を使う
           y (+ y yv))
    ship))
~~~

コンパイル時、マクロ展開の段階で `x` はフォーム `(ship-x-position ship)` へ展開され、関数はそのフォームを使ってコンパイルされます。

詳しくは [Community Spec](https://cl-community-spec.github.io/pages/symbol_002dmacrolet.html) を読んでください。


## 関連項目

* [A gentle introduction to Compile-Time Computing — Part 1](https://medium.com/@MartinCracauer/a-gentle-introduction-to-compile-time-computing-part-1-d4d96099cea0)
* [Safely dealing with scientific units of variables at compile time (a gentle introduction to Compile-Time Computing — part 3)](https://medium.com/@MartinCracauer/a-gentle-introduction-to-compile-time-computing-part-3-scientific-units-8e41d8a727ca)
* 次の動画は、[cbaggers](https://github.com/cbaggers/) による ["Little bits of
Lisp"](https://www.youtube.com/user/CBaggers/playlists) シリーズのものです。マクロについて 2 時間ほど話しており、compiler マクロのような初歩から高度な概念までを示しています。
[https://www.youtube.com/watch?v=ygKXeLKhiTI](https://www.youtube.com/watch?v=ygKXeLKhiTI)
Emacs でマクロ（とその展開）を操作する方法も示しています。

[![video](assets/youtube-little-bits-lisp.jpg)](https://www.youtube.com/watch?v=ygKXeLKhiTI)

* 記事 "Reader Macros in Common Lisp": https://lisper.in/reader-macros
