---
title: 関数
---

<a name="return"></a>

## 名前付き関数: `defun`

名前付き関数は `defun` keyword で作成します。基本形は次のとおりです。

~~~lisp
(defun function-name (zero or some arguments)
  "docstring"
  (code of function body))
~~~

戻り値は body の最後の式が返す値です (詳しくは下を参照)。"return xx" statement はありません。

たとえば:

~~~lisp
(defun hello-world ()
  ;;               ^^ argument なし
  (print "hello world!"))
~~~

呼び出してみます。

~~~lisp
(hello-world)
;; "hello world!"  <-- 出力
;; "hello world!"  <-- string が返る
~~~

`print` 関数は 1 つの引数を standard output に print し、*さらにそれを返します*。そのため "hello world!" がこの関数の戻り値になります。


## argument

<a id="required-argument"></a>

### 基本形: required 引数

引数は次のように追加します。

~~~lisp
(defun hello (name)
  "Say hello to `name'."
  (format t "hello ~a !~&" name))
;; HELLO
~~~

(`~a` は変数を *aesthetically* に print するために最もよく使われる `format` directive で、`~&` は newline を print します)

関数を呼び出します。

~~~lisp
(hello "me")
;; hello me !  <-- これは `format` により print される
;; NIL         <-- 戻り値: `format t` は string を
;;                 standard output に print し nil を返す
~~~

正しい数の引数を指定しないと、明示的なエラーメッセージとともに interactive debugger に入ります。

   (hello)

> invalid number of arguments: 0

### optional argument: `&optional`

optional 引数は lambda list の `&optional` keyword の後に宣言します。これらは順序を持ち、続けて現れなければなりません。

この関数は:

~~~lisp
(defun hello (name &optional age gender) …)
~~~

次のように呼び出す必要があります。

~~~lisp
(hello "me") ;; required argument への値、
             ;; optional argument は 0 個
(hello "me" "7")  ;; age への値
(hello "me" 7 :h) ;; age と gender への値
~~~

### 名前付き parameter: `&key`

引数の順序を覚えるのがいつも便利とは限りません。そのため、引数を名前で渡せます。`&key argname` で宣言し、関数 call では `:argname "value"` で設定し、関数 body では通常の変数として `argname` を使います。

キー引数のデフォルト値は `nil` です。

~~~lisp
(defun hello (name &key happy)
  "If `happy' is `t', print a smiley"
  (format t "hello ~a " name)
  (when happy
    (format t ":)~&")))
~~~

次の call が可能です。

    (hello "me")
    (hello "me" :happy t)
    (hello "me" :happy nil) ;; 不要、(hello "me") と同等

一方、これは valid ではありません: `(hello "me" :happy)`:

> odd number of &KEY arguments

複数のキーパラメータを持つ関数宣言の例です。

~~~lisp
(defun hello (name &key happy lisper cookbook-contributor-p) …)
~~~

これは 0 個以上のキーパラメータを任意の順序で指定して呼び出せます。

~~~lisp
(hello "me" :lisper t)
(hello "me" :lisper t :happy t)
(hello "me" :cookbook-contributor-p t :happy t)
~~~

最後に、キーはプログラムから選択できます（変数にできます）。

~~~lisp
(let ((key :happy)
      (val t))
  (hello "me" key val))
;; hello me :)
;; NIL
~~~

<a id="optional-parameter--key-parameter-"></a>
<a id="optional--key-"></a>

#### オプショナルパラメータとキーパラメータの混在

一般には style warning になりますが、可能です。

~~~lisp
(defun hello (&optional name &key happy)
  (format t "hello ~a " name)
  (when happy
    (format t ":)~&")))
~~~

SBCL では次のようになります。

~~~
; in: DEFUN HELLO
;     (SB-INT:NAMED-LAMBDA HELLO
;         (&OPTIONAL NAME &KEY HAPPY)
;       (BLOCK HELLO (FORMAT T "hello ~a " NAME) (WHEN HAPPY (FORMAT T ":)~&"))))
;
; caught STYLE-WARNING:
;   &OPTIONAL and &KEY found in the same lambda list: (&OPTIONAL (NAME "John") &KEY
;                                                      HAPPY)
;
; compilation unit finished
;   caught 1 STYLE-WARNING condition
~~~

呼び出すことはできます。

~~~lisp
(hello "me" :happy t)
;; hello me :)
;; NIL
~~~

<a id="key-parameter--default-value"></a>
<a id="key--default-"></a>

### キーパラメータのデフォルト値

ラムダリストでは、次の `(happy t)` のような組を使ってオプショナル引数やキー引数にデフォルト値を与えます。

~~~lisp
(defun hello (name &key (happy t))
~~~

これで `happy` は default で true です。

<a id="key-parameter-"></a>
<a id="key-"></a>

### キーパラメータは指定されたか?

この tip は必要なら今は飛ばしてかまいませんが、便利になることがあるので後で戻ってきてください。

キーパラメータのデフォルト値は `nil` だと見ました（`(defun hello (name &key happy) …)`）。しかし、「値がデフォルトで NIL である」ことと「利用者が NIL を指定した」ことはどう区別できるでしょうか。

default 値を設定するには 2 要素の list を使うことを見ました。

`&key (happy t)`

この疑問に答えるには、次のような triple を使います。

`&key (happy t happy-p)`

ここで `happy-p` は key が渡されたかどうかを知るための *predicate* 変数として働きます (`-p` を使うのは convention にすぎないので、好きな名前を付けられます)。渡されていれば `T` になります。

これで、`:happy` が明示的に NIL に設定された場合は sad face を print します。default では print しません。

~~~lisp
(defun hello (name &key (happy nil happy-p))
  (format t "Key supplied? ~a~&" happy-p)
  (format t "hello ~a " name)
  (when happy-p
    (if happy
      (format t ":)")
      (format t ":("))))
~~~

### 可変個数の argument: `&rest`

関数に可変個数の引数を受け取らせたいことがあります。`&rest <variable>` を使います。この `<variable>` は list になります。

~~~lisp
(defun mean (x &rest numbers)
    (/ (apply #'+ x numbers)
       (1+ (length numbers))))
~~~

~~~lisp
(mean 1)
(mean 1 2)  ;; => 3/2 (そう、ratio として print される)
(mean 1 2 3 4 5) ;;  => 3
~~~

<a id="key-argument--allow-other-keys"></a>

### key 引数を定義し、さらに他も許す: `&allow-other-keys`

見てみましょう。

~~~lisp
(defun hello (name &key happy)
  (format t "hello ~a~&" name))

(hello "me" :lisper t)
;; => Error: unknown keyword argument
~~~

一方で:

~~~lisp
(defun hello (name &key happy &allow-other-keys)
  (format t "hello ~a~&" name))

(hello "me" :lisper t)
;; hello me
~~~

引数を受け渡ししたり、関数をより高い level で操作したりするとき、`&allow-other-keys` が必要になることがあります。

実例です。常に `:if-exists :supersede` を使って file を open する関数を定義しますが、他の key はそのまま `open` 関数に渡します。

~~~lisp
(defun open-supersede (f &rest other-keys &key &allow-other-keys)
  (apply #'open f :if-exists :supersede other-keys))
~~~

`:if-exists` 引数が重複した場合、最初に渡したものが優先されます。


## 戻り値

関数の戻り値は、body で最後に実行された form が返す値です。

non-local exit の方法 (`return-from <function name> <value>`) もありますが、通常は必要ありません。

Common Lisp には multiple return 値という概念もあります。

### multiple return value

multiple 値を返すことは、結果の list を返すこととは**違います**。

#### 簡単な例

1 つの値を返す関数を定義します。

~~~lisp
(defun foo ()
  :a)
~~~

次に、この関数 call の結果を変数に設定します。

~~~lisp
(defparameter *var* (foo))
~~~

`*var*` は今 `:a` です。これはごく普通の behaviour です。

今度は `values` を使って、この関数が *multiple values* を返すようにします。

~~~lisp
(foo ()
  (values :a :b :c))
~~~

そして再びその結果を `*var*` に設定します。

~~~lisp
(setf *var* (foo))
~~~

`*var*` の値は何でしょうか。*:a のままです*。残りの値を capture するようには要求していないので、`:b` と `:c` は捨てられました。

これは実際とても便利です。関数が以前より多くの multiple 値を返すように変更しても、call site を変更したり refactor したりする必要がありません。

<a id="multiple-value--values"></a>

#### multiple 値を返す: `values`

関数 `values` は multiple 値を返すために使います。

~~~lisp
(values 'a 'b)
;; => A
;; => B
~~~

引数なしで `values` を call すると、値をまったく返しません。

これは `nil` を返すこととは違います。

下で説明する関数を使って multiple 値を capture しない限り、他の関数から見えて使われるのは最初の値だけです。

~~~lisp
(+ (values 1 2 3) (values 10 20 30))
;; => 11
~~~

`values` は list を作りません。

<a id="multiple-value-cl-built-in-"></a>

#### multiple 値がある理由。CL built-in を見る

ほとんどの Common Lisp form は 1 つの値を返しますが、関数が複数の値 (または 0 個) を返せると便利なことがあります。

たとえば `round` は、丸めた結果と、丸めのために取り除かれた量という 2 つの値を返します。

~~~lisp
(round 10.33333333)
;; => 10
;; => 0.33333302
~~~

ほとんどの場合は丸めた値だけが必要ですが、何らかの理由で remainder を知りたいなら capture できます。関数が計算したすべての値がほとんどの場合に使われると予想するなら、結果を list、CLOS instance、*etc.,* にまとめて返す方がよいでしょう。multiple 値は、最初の値が最も頻繁に必要で、後の値はあまり使われない場合にだけ使います。

同様に、hash-table の内容を取得すると 2 つの値が返ります。結果と、その key が見つかったかどうかを示す boolean です。下を参照してください。

<a id="multiple-value--capture-multiple-value-bindnth-valuemultiple-value-list-"></a>

#### multiple 値の capture: `multiple-value-bind`、`nth-value`、`multiple-value-list` など

multiple 値を capture する最も一般的な方法は `multiple-value-bind` です。

~~~lisp
(multiple-value-bind (c d) (values 1 2)
  (list c d))
;; => (1 2)

;; 次のように indent されることも多い:
(multiple-value-bind (c d)
    (values 1 2)
  (list c d))
~~~

これは `let` による束縛のように動作します。値 `c` と `d` は `multiple-value-bind` のスコープ内に存在します。

返される値の数と、bind する変数の数は一致していなくてもかまいません。値が多すぎる場合、余分なものは捨てられます。bind する変数が多すぎる場合、余分な変数は `nil` に設定されます。

~~~lisp
(multiple-value-bind (a b) (values 1 2 3 4)
  (list a b))
;; =>(1 2)
~~~

~~~lisp
(multiple-value-bind (a b) (values 1)
  (list a b))
;; => (1 NIL)
~~~

関数 `values` は `setf` 可能で、これを値の capture に使うこともできます。

~~~lisp
(let (c d)
  (setf (values c d) (values 1 2))
  (list c d))
;; => (1 2)
~~~

同等の `multiple-value-setq` も使えます。

~~~lisp
(let (c d)
  (multiple-value-setq (c d) (values 3 4))
  (list c d))
;; => (3 4)
~~~

また、`multiple-value-call` で multiple 値を直接関数 call に送り込めます。

~~~lisp
(multiple-value-call #'list (values 1 2 3))
;; => (1 2 3)
~~~

関数 `multiple-value-list` は上の code と同等です。

~~~lisp
(multiple-value-list (values 1 2 3))
;; => (1 2 3)
~~~~

逆に、`values-list` で list を multiple return 値に変換できます。

~~~lisp
(values-list '(1 2 3))
;; => 1
;; => 2
;; => 3
~~~

`nth-value` で特定の値を選択できます。

~~~lisp
(nth-value 0 (values :a :b :c))  ;; => :A
(nth-value 2 (values :a :b :c))  ;; => :C
(nth-value 9 (values :a :b :c))  ;; => NIL
~~~

ここでも、`values` は list とは違うことを改めて強調しておきます。

~~~lisp
(nth-value 0 (list :a :b :c)) ;; => (:A :B :C)
;; => リストはそれ自体で 1 つのデータ構造

(nth-value 1 (list :a :b :c)) ;; => NIL
;; => capture する 2 番目の value はない
~~~

<a id="multiple-value-"></a>

#### 成功または失敗を報告するために multiple 値を使う

multiple 値の典型的な用途は、`nil` が見つかった場合と lookup failure を区別することです。たとえば `gethash` は 2 つの値を返します。1 つ目は lookup の結果です。何も見つからなければ `nil` かもしれませんが、hashtable に実際に保存されている `nil` かもしれません。2 つ目の戻り値は lookup が成功したかどうかを示す flag です。

~~~lisp
(defvar *hash* (make-hash-table))
(setf (gethash 'a *hash*) 12)
(setf (gethash 'b *hash*) nil)
~~~

~~~lisp
(gethash 'a *hash*)
;; => 12           <--- 1 番目の戻り値: 結果
;; => T            <--- 2 番目の戻り値: key が見つかった

(gethash 'b *hash*)
;; => NIL
;; => T

(gethash 'c *hash*)
;; => NIL
;; => NIL          <---- この key は見つからなかった
~~~

## anonymous function: `lambda`

anonymous 関数は `lambda` で作成します。

~~~lisp
(lambda (x) (print x))
~~~

lambda は `funcall` または `apply` で呼び出せます (下を参照)。

quote されていない list の最初の element が lambda 式なら、その lambda が呼び出されます。

~~~lisp
((lambda (x) (print x)) "hello")
;; hello
~~~

<a id="function--programmatically--funcall--apply"></a>

## 関数を programmatically に呼び出す: `funcall` と `apply`

`funcall` は引数の数がわかっているときに使います。一方 `apply` は、たとえば `&rest` から得た list に対して使えます。

~~~lisp
(funcall #'+ 1 2)
(apply #'+ '(1 2))
~~~

`apply` について覚えておくべきことが 1 つあります。非常に大きな list には使えません。関数の引数 list には長さの制限があります。

この制限は変数 `call-arguments-limit` で確認できます。これは処理系に依存します。SBCL ではかなり大きい (4611686018427387903) ですが、任意の長さの引数に関数を適用する別の選択肢があります。それが `reduce` です。

### `reduce`

`reduce` は任意の長さのリストやベクトルに関数を適用するために使います。関数を 2 つの引数で繰り返し呼び出し、引数リストを走査します。

たとえば、上のように `apply` を使う代わりに:

    (apply #'min '(22 1 2 3)) ;; 非常に大きな list を想像してください

`reduce` を使えます。

    (reduce #'min '(22 1 2 3))

引数が 1000 elements の長さなら、`apply` は `min` 関数を 1000 個の引数で呼び出します。一方 `reduce` は `min` を毎回 2 個の引数で (ほぼ) 1000 回呼び出します。

`reduce` は list を走査します。つまり次のようになります。

- まず `min` が引数 22 と 1 で呼ばれ、中間結果 1 を生成します。
- `min` はこの中間結果を最初の引数とし、引数 list の次の引数である 2 とともに再び呼ばれます。中間結果はまた 1 です。
- `min` は引数 1 と 3 で再び呼ばれ、最終結果 1 を返します。

trace できます。

~~~lisp
CL-USER> (trace min)
CL-USER> (reduce #'min '(22 1 2 3))
  0: (MIN 22 1)
  0: MIN returned 1
  0: (MIN 1 2)
  0: MIN returned 1
  0: (MIN 1 3)
  0: MIN returned 1
1
~~~

完全な signature は次のとおりです。

```lisp
(reduce function sequence &key key from-end start end initial-value)
```

ここで `key`、`from-end`、`start`、`end` は他の組み込み関数にも見られるキー引数です（データ構造の章を参照）。`:initial-value` が与えられた場合、最初のサブシーケンスの前に置かれます。

`reduce` の詳細は Community Spec を読んでください。

- [https://cl-community-spec.github.io/pages/reduce.html](https://cl-community-spec.github.io/pages/reduce.html)


<a id="function--single-quote---sharpsign-quote--"></a>

### 名前で関数を参照する: single quote `'` か sharpsign-quote `#'` か?

上の例では `#'` を使いましたが、single quote も動作し、実際の code でも見かけます。どちらを使うべきでしょうか。

一般には `#'` を使う方が安全です。lexical scope を尊重するからです。見てみましょう。

~~~lisp
(defun foo (x)
  (* x 100))

(flet ((foo (x) (1+ x)))
  (funcall #'foo 1))
;; => 2、期待どおり

;; しかし:

(flet ((foo (x) (1+ x)))
  (funcall 'foo 1))
;; => 100
~~~

`#'` は実際には `(function …)` の shorthand です。

~~~lisp
(function +)
;; #<FUNCTION +>

(flet ((foo (x) (1+ x)))
  (print (function foo))
  (funcall (function foo) 1))
;; #<FUNCTION (FLET FOO) {1001C0ACFB}>
;; 2
~~~

`function` または `#'` shorthand を使うと local 関数を参照できます。代わりにシンボルを `funcall` に渡すと、呼び出されるのは常に *global environment* でそのシンボルによって名付けられた関数です。

さらに、`#'` は関数を値として保持します。関数が再定義されても、`#'` でこの関数を参照している束縛は元の動作を実行し続けます。

関数をパラメータに代入してみます。

~~~lisp
(defparameter *foo-caller* #'foo)
(funcall *foo-caller* 1)
;; => 100
~~~

ここで `foo` を再定義しても、`*foo-caller*` の behaviour は変わりません。

~~~lisp
(defun foo (x) (1+ x))
;; WARNING: redefining CL-USER::FOO in DEFUN
;; FOO

(funcall *foo-caller* 1)
;; 100  ;; 2 ではない
~~~

caller を single quote の `'foo` で bind すると、関数は runtime に解決されます。

~~~lisp
(defun foo (x) (* x 100))  ;; 元の behavior に戻す
(defparameter *foo-caller-2* 'foo)
;; *FOO-CALLER-2*
(funcall *foo-caller-2* 1)
;; 100

;; 定義を変更する:
(defun foo (x) (1+ x))
;; WARNING: redefining CL-USER::FOO in DEFUN
;; FOO

;; もう一度試す:
(funcall *foo-caller-2* 1)
;; 2
~~~

どの behaviour が望ましいかは用途によります。一般には sharpsign-quote を使う方が驚きが少ないです。しかし tight loop を実行していて live-update mechanism (game や live visualisation を考えてください) が欲しい場合は、loop が user の新しい関数 definition を拾うように single quote を使いたいかもしれません。


<a id="higher-order-function-function--function"></a>

## higher order function: 関数を返す関数

関数を返す関数を書くのは十分に簡単です。

~~~lisp
(defun adder (n)
  (lambda (x) (+ x n)))
;; ADDER
~~~

ここでは、[`function`](http://www.lispworks.com/documentation/HyperSpec/Body/t_fn.htm) _type_ の _object_ を返す関数 `adder` を定義しました。

結果として得られる関数を呼び出すには、`funcall` または `apply` を使う必要があります。

~~~lisp
(adder 5)
;; #<CLOSURE (LAMBDA (X) :IN ADDER) {100994ACDB}>
(funcall (adder 5) 3)
;; 8
~~~

すぐに呼び出そうとすると illegal 関数 call になります。

~~~lisp
((adder 3) 5)
In: (ADDER 3) 5
    ((ADDER 3) 5)
Error: Illegal function call.
~~~

実際、CL では関数と変数に異なる _namespace_ があります。つまり、評価される form の中での位置によって、同じ _name_ が別のものを指すことがあります。

~~~lisp
;; symbol foo は何にも bound されていない:
CL-USER> (boundp 'foo)
NIL
CL-USER> (fboundp 'foo)
NIL
;; variable を作る:
CL-USER> (defparameter foo 42)
FOO
CL-USER> foo
42
;; これで foo は "bound" されている:
CL-USER> (boundp 'foo)
T
;; しかし function としてはまだ違う:
CL-USER> (fboundp 'foo)
NIL
;; では function を定義する:
CL-USER> (defun foo (x) (* x x))
FOO
;; これで symbol foo は function としても bound された:
CL-USER> (fboundp 'foo)
T
;; function を取得する:
CL-USER> (function foo)
#<FUNCTION FOO>
;; 短縮表記:
CL-USER> #'foo
#<FUNCTION FOO>
;; 呼び出す:
(funcall (function adder) 5)
#<CLOSURE (LAMBDA (X) :IN ADDER) {100991761B}>
;; そして lambda を呼び出す:
(funcall (funcall (function adder) 5) 3)
8
~~~

少し単純化すると、Common Lisp の各シンボルには情報を保存する「セル」が（少なくとも）2 つあると考えられます。1 つは「値セル」と呼ばれ、シンボルに束縛された値を保持できます。[`boundp`](http://www.lispworks.com/documentation/HyperSpec/Body/f_boundp.htm) を使うと、シンボルが大域環境で値に束縛されているかを検査できます。シンボルの値セルには [`symbol-value`](http://www.lispworks.com/documentation/HyperSpec/Body/f_symb_5.htm) でアクセスできます。


もう 1 つは「関数セル」と呼ばれ、シンボルに大域的に束縛された関数の定義を保持できます。この場合、シンボルはその定義に _fbound_ されていると言います。[`fboundp`](http://www.lispworks.com/documentation/HyperSpec/Body/f_fbound.htm) を使うと、シンボルが関数に束縛されているかを検査できます。シンボルの関数セルには、大域環境では [`symbol-function`](http://www.lispworks.com/documentation/HyperSpec/Body/f_symb_1.htm) でアクセスできます。


さて、_symbol_ が評価されると、_variable_ として扱われ、その値 cell が返されます (単に `foo`)。_compound form_、つまり _cons_ が評価され、その _car_ がシンボルなら、このシンボルの関数 cell が使われます (`(foo 3)` のように)。


Common Lisp では Scheme と異なり、評価される compound form の car を任意の form にすることはできません。シンボルでない場合、それは `(lambda lambda-list form*)` の形をした _lambda expression_ でなければなりません。

これが上で得たエラーメッセージの理由です。`(adder 3)` はシンボルでも lambda 式でもありません。

compound form の car でシンボル `*my-fun*` を使えるようにしたいなら、その _function cell_ に明示的に何かを保存する必要があります (通常これはマクロ [`defun`](http://www.lispworks.com/documentation/HyperSpec/Body/m_defun.htm) が行ってくれます)。

~~~lisp
;;; 上からの続き
CL-USER> (fboundp '*my-fun*)
NIL
CL-USER> (setf (symbol-function '*my-fun*) (adder 3))
#<CLOSURE (LAMBDA (X) :IN ADDER) {10099A5EFB}>
CL-USER> (fboundp '*my-fun*)
T
CL-USER> (*my-fun* 5)
8
~~~

詳しくは [form evaluation](http://www.lispworks.com/documentation/HyperSpec/Body/03_aba.htm) についての CLHS section を読んでください。

## Closures

クロージャを使うとレキシカルな束縛を保持できます。これは、毎回関数に渡したくない状態を保存するときに便利です。利便性のためだけでなく、状態変数を外部からアクセス可能な名前空間に置かずに済みます。

~~~lisp
(let ((limit 3)
      (counter -1))
    (defun my-counter ()
      (if (< counter limit)
          (incf counter)
          (setf counter 0))))

(my-counter)
0
(my-counter)
1
(my-counter)
2
(my-counter)
3
(my-counter)
0
~~~

または同様に:

~~~lisp
(defun repeater (n)
  (let ((counter -1))
     (lambda ()
       (if (< counter n)
         (incf counter)
         (setf counter 0)))))

(defparameter *my-repeater* (repeater 3))
;; *MY-REPEATER*
(funcall *my-repeater*)
0
(funcall *my-repeater*)
1
(funcall *my-repeater*)
2
(funcall *my-repeater*)
3
(funcall *my-repeater*)
0
~~~

counter generator に加えて、lexical クロージャのもう 1 つの一般的な用途は memoization、つまり計算にコストがかかる関数の以前の結果を cache することです。下の memoize されていない Fibonacci 関数は、すぐに計算時間がかなりかかるようになります。

~~~lisp
(defun fibonacci (n)
  (if (<= n 1)
      n
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(time (fibonacci 40))
;; Evaluation took:
;;   2.843 seconds of real time
;;   2.841360 seconds of total run time (2.796188 user, 0.045172 system)
;;   99.93% CPU
;;   0 bytes consed
;; 102334155
~~~

以前に計算した結果を hash table に保存すると高速化できます。`defvar` を使うこともできますが、これはクロージャに適した用途です。1 つの関数だけが使う変数を namespace に追加せずに済むからです。

~~~lisp
(let ((memo (make-hash-table)))
  (defun fibonacci (n)
    (let ((value (gethash n memo)))
      (cond ((<= n 1) n)
            (value value)
            (t (setf (gethash n memo)
                     (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))))))

(time (fibonacci 40))
;; Evaluation took:
;;   0.000 seconds of real time
;;   0.000016 seconds of total run time (0.000015 user, 0.000001 system)
;;   100.00% CPU
;;   0 bytes consed
;; 102334155
~~~

memoization ライブラリはいくつかあり、その一部はこの lexical クロージャと caching の mechanism をマクロで wrap しています。

詳しくは [Practical Common Lisp](http://www.gigamonkeys.com/book/variables.html) を参照してください。

## `setf` function

関数 name は、最初のシンボルが `setf` である 2 つのシンボルの list にすることもできます。このとき最初の引数は新しい値です。

~~~lisp
(defun (setf function-name) (new-value other optional arguments)
  body)
~~~

この mechanism は CLOS メソッドでよく使われます。

例に向けて進めましょう。square を表す hash-table を操作するとします。この hash-table に square の width を保存します。

~~~lisp
(defparameter *square* (make-hash-table))
(setf (gethash :width *square*) 21)
~~~

プログラムの life cycle 中、上で行ったように `setf` で square の width を変更できます。

square area を計算する関数を定義します。dimension と重複するため、これは hash-table には保存しません。

~~~lisp
(defun area (square)
  (expt (gethash :width square) 2))
~~~

ここで programming 上の必要から、square の `*area*` を変更し、それを square の dimension に反映できると非常に便利な状況になったとします。プログラムのアプリケーションインターフェイスにとって、次のような setf-function を定義すると扱いやすくなります。

~~~lisp
(defun (setf area) (new-area square)
  (let ((width (sqrt new-area)))
    (setf (gethash :width square) width)))
~~~

これで次のようにできます。

~~~lisp
(setf (area *square*) 100)
;; => 10.0
~~~

square を確認すると (`describe`、`inspect` など)、新しい width が設定されています。

### setf-function: optional argument

setf-function が持つ mandatory 引数は、新しい値 1 つだけである点に注意してください。2 番目以降の引数は optional です。たとえば [Lem editor codebase](https://github.com/lem-project/lem/blob/main/src/buffer/internal/buffer.lisp) から:


~~~lisp
(defun (setf current-buffer) (buffer)
  "Change the current buffer."
  (check-type buffer buffer)
  (setf *current-buffer* buffer))
~~~

この setf-function は global パラメータ (`*current-buffer*`) を新しい値に設定します。

2 つより多い引数を持つ setf-function も定義できます。

~~~lisp
(defun (setf area) (new-area square x y &key log)
  (list new-area square x y log))
~~~

使ってみます。

~~~lisp
(setf (area 'square 1 2 :log t) 9)
~~~


<a id="currying-functions"></a>

## Currying

### concept

関連する概念に _[currying](https://en.wikipedia.org/wiki/Currying)_ があります。functional language から来たなら馴染みがあるかもしれません。前の section を読んだ後なら、これはかなり簡単に実装できます。

~~~lisp
CL-USER> (defun curry (function &rest args)
           (lambda (&rest more-args)
	           (apply function (append args more-args))))
CURRY
CL-USER> (funcall (curry #'+ 3) 5)
8
CL-USER> (funcall (curry #'+ 3) 6)
9
CL-USER> (setf (symbol-function 'power-of-ten) (curry #'expt 10))
#<Interpreted Function "LAMBDA (FUNCTION &REST ARGS)" {482DB969}>
CL-USER> (power-of-ten 3)
1000
~~~

<a id="alexandria-library-"></a>

### Alexandria ライブラリを使う

やり方がわかったので、Quicklisp にある [Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Data-and-Control-Flow) ライブラリの実装を使うありがたみもわかるでしょう。

~~~lisp
(ql:quickload "alexandria")

(defun adder (foo bar)
  "Add the two arguments."
  (+ foo bar))

(defvar add-one (alexandria:curry #'adder 1) "Add 1 to the argument.")

(funcall add-one 10)  ;; => 11

(setf (symbol-function 'add-one) add-one)
(add-one 10)  ;; => 11
~~~

## ドキュメント

- function: <http://www.lispworks.com/documentation/HyperSpec/Body/t_fn.htm#function>
- ordinary lambda list: <http://www.lispworks.com/documentation/HyperSpec/Body/03_da.htm>
- multiple-value-bind: <http://clhs.lisp.se/Body/m_multip.htm>
