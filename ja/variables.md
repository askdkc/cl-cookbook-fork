---
title: 変数
---

あなたは初めての Common Lisp program を書いていて（ようこそ！）、variables を宣言したいとします。どんな選択肢があるでしょうか。

迷ったら、下に示すように top-level parameters には `defparameter` を使ってください。

<!-- Cookbook のほとんどの節とは異なり、学生やその他の
初心者が集中しやすいように、ここでは TLDR; を先頭に置いていません。 -->


## `defparameter`: top-level 変数

top-level variables を宣言するには、次のように `defparameter` を使います。

```lisp
(defparameter *name* "me")

(defun hello (&optional name)
  "Say hello."
  (format t "Hello ~a!" (or name *name*)))
```

`defparameter` は省略可能な第 3 引数として、variable の docstring を受け取ります。

```lisp
(defparameter *name* "me"
   "Default name to say hello to.")
```

inline docstrings は Common Lisp の interactive experience の重要な部分です。coding sessions 中に何度も出会うでしょう（そして私たち lispers は普通、Lisp を長時間動かしたままにします）。Emacs と Slime では、`C-c C-d d`（`Alt-x slime-describe-symbol`）で symbol の docstring を尋ねられます。programmatically に docstring を尋ねることもできます。

~~~lisp
(documentation '*name* 'variable)
~~~

私たちは `*name*` *symbol* の documentation を尋ねています。それが保持しているものではありません。そのため `'*name*` に quote が付いています（これは `(quote *name*)` の短縮形です）。別の "doc-type" は `'function` です。Common Lisp では variables と functions は異なる "namespaces" に住んでおり、それがここに現れています。

値のない `defparameter` form については後で触れます。

### defparameter の再定義

Common Lisp の coding session は通常長く続き、非常に interactive です。Lisp を動かしたままにして、作業しながら interaction します。これは Emacs と Slime、Vim、Atom と SLIMA、VSCode と Alive、Lem…その他の editor、または terminal から行えます。

つまり、次のことができます。

1- 最初の defparameter を書く

```lisp
(defparameter *name* "me")
```

これを REPL に書くか、.lisp file に書いて shortcut で compile+load します（Slime ではこの expression 上で `C-c C-c`（Alt-x `slime-compile-defun`）、または current buffer 全体を compile and load する `C-c C-k`（Alt-x `slime-compile-and-load-file`））。単純な terminal REPL で作業している場合は、.lisp file を `(load …)` できます。

これで running image に `*name*` variable が存在します。

2- defparameter 行を編集する:

```lisp
(defparameter *name* "you")
```

そして同じ方法で changes を load します。REPL でも `C-c C-c` でも構いません。これで `*name*` variable は新しい値 "you" を持ちます。

`defvar` なら再定義されません。


## `defvar`: 再定義しない

`defvar` は top-level *variables* を定義し、それらを再定義から守ります。

`defvar` を re-load しても current value は消されません。これには `setf` を使う必要があります。


```lisp
(defvar *names-cache* (list)
  "Store a list of names we said \"hello\" to.")

(defun hello (&optional (name *name*))
   (pushnew name *names-cache* :test #'string-equal)
   (format t "hello ~a!" name))
```

使ってみましょう。

```lisp
CL-USER> (hello)
hello you!
NIL
CL-USER> *names-cache*
("you")
CL-USER> (hello "lisper")
hello lisper!
NIL
CL-USER> *names-cache*
("lisper" "you")
```

（`C-c C-c`、`C-c C-k`、または REPL で）`defvar` 行を再定義すると、`*names-cache*` はどうなるでしょうか。

変わりません。そして *それは良いことです*。

実際、この variable は user-visible parameter ではなく、すぐ直接使うものではありませんが、program correctness や strength などにとって重要です。これが webserver の cache を保持していると想像してください。新しい code を load するときにそれを消したくはありません。development 中、current file を reload するために `C-c C-k` をたくさん押しますし、production で running app を reload することもあります。しかし、触れずにおきたいものがあります。database connection なら、code を compile するたびに nil に戻して接続し直したくはありません。

defvar の variable value を変更するには `setf` を使う必要があります。

もちろん Slime にはこのための shortcut があります。`setf` の代わりに、`C-M-x`（Control+ Alt + x）、別名 interactive function `slime-eval-defun`（これは `slime-re-evaluate-defvar` を呼びます）を使えます。

```
Evaluate the current toplevel form.

Use "slime-re-evaluate-defvar" if the from starts with "(defvar".
```


## "\*earmuff\*" convention

`*name*` を "\*earmuffs\*" の間に書いたことに注目してください。これは重要な convention で、lexical scopes 内で top-level variables を override しないように助けてくれます。

```lisp
(defparameter name "lisper")

;; later…
(let ((name "something else"))
   ;;  ^^^ top-level name を override します。見つけにくい bug の原因になります。
   …)
```

earmuffs を使うと、これは feature になります。

```lisp
(defparameter *db-name* "db.db")

(defun connect (&optional (db-name *db-name*))
  (sqlite:connect db-name))

(let ((*db-name* "another.db"))
  (connect))
  ;;^^^^  *db-name* を default にする db-name optional parameter は、今 "another.db" を見ます。
```

ちなみに、このような use-case では、`let` binding を abstract する `with-…` macros をよく見かけます。

```lisp
(with-db "another.db"
  (connect))
```

さらにちなみに、[earmuff](https://www.wordreference.com/definition/earmuff) は冬に耳（ただし耳だけ）を覆うものです。現実より映画で見たことが多いかもしれません。最後に残る言葉は、自分を大事にし、暖かくして、earmuffs を使いましょう、です。

## グローバル変数は "dynamic scope" に作られる

top-level parameters と variables は、いわゆる *dynamic scope* に作られます。それらはどこからでもアクセスできます。function definitions から（私たちがやったように）、`let` bindings の中から、などです。

Lisp では、これらを [*dynamic variables* または *special*](https://cl-community-spec.github.io/pages/Dynamic-Variables.html) とも呼びます。

どこからでも "special" と *proclaiming* することで作成することも可能です。これは日常的に行うことでは本当にありませんが、Lisp では何でも可能です ;)

> dynamic variable は、それを bind する form の dynamic extent の外側から参照できます。そのような variable は "global variable" と呼ばれることがありますが、あらゆる点で、global environment に binding がたまたま存在している dynamic variable にすぎません。dynamic environment に存在する場合と本質的に同じです。[Hyper Spec]


## `setf`: 値を変更する

任意の variable は `setf` で変更できます。

```lisp
(setf *name* "Alice")
;; => "Alice"
```

これは新しい値を返します。

実際、`setf` は value と variable の *pairs* を受け取ります。

~~~lisp
(setf *name* "Bob"
      *db-name* "app.db")
;; => "app.db"
~~~

最後の値を返しました。

まだ宣言されていない variable に `setf` すると何が起きるでしょうか。一般には動きますが warning が出ます。

```lisp
;; in SBCL 2.5.8
CL-USER> (setf *foo* "foo")
; in: SETF *FOO*
;     (SETF CL-USER::*FOO* "foo")
;
; caught WARNING:
;   undefined variable: CL-USER::*FOO*
;
; compilation unit finished
;   Undefined variable:
;     *FOO*
;   caught 1 WARNING condition
"foo"
```

返された "foo" が見えるので、動作はしました。variables は先に `defparameter` または `defvar` で宣言してください。

興味深いので、`setf` の docstring 全体を読んでみましょう。

```txt
Takes pairs of arguments like SETQ. The first is a place and the second
is the value that is supposed to go into that place. Returns the last
value. The place argument may be any of the access forms for which SETF
knows a corresponding setting form.
```

`setq` は別の macro ですが、今ではあまり使われません。`setf` はより多くの "places" に対して動くからです。functions や多くのものを setf できます。


## `let`, `let*`: lexical scopes を作る

`let` により、限られた scope で variables を定義したり、top-level variables を一時的に override したりできます。

下では、2 つの variables は `let` の parenthesis の間にだけ存在します。

```lisp
(let* ((a 2)
       (square (* a a)))
   (format t "the square of ~a is ~a" a square))
   ;; ここまでは問題ありません

(format t "the value of a is: ~a" a)
;; => ERROR: the variable A is unbound
```

"unbound" とは、variable が何にも bind されていないことを意味します。NIL にすら bind されていません。その symbol は存在するかもしれませんが、何にも associated されていません。

`let` が作る scope の直後では、variables `a` と `square` はもう存在しません。

Lisp reader が `format` expression を読むと、`a` symbol を読みます。この symbol は global environment に存在しますが、bound されていません。

> 考える材料: variable name を書いて Lisp reader に読ませるという事実は symbol を作りますが、それを何にも bind しません。

2 つの variables は、`let` binding の内側の任意の form からアクセスできます。2 つ目の `let` を作ると、その *environment* は前のものを inherit します（上で宣言した variables が見えます。ありがたいことです！）。

```lisp
(defparameter *name* "test")

(defun log (square)
  (format t "name is ~s and square is ~a" *name* square))

(let* ((a 2)
       (square (* a a)))
  ;; 最初の environment の内側
  (let ((*name* "inside let"))
    ;; 2 番目の environment の内側、
    ;; dynamic scope にアクセスします。
    (log square)))
;;  => name is "inside let" and square is 4
;;  => NIL

(print *name*)
;; => "test"
;;    ^^^^ let の外側では dynamic scope の値に戻ります。
```

let の中で関数を定義することもできます。その場合、この function definition は compile time に周囲の let からの binding を「見ます」。これは closure であり、functions の章で扱います。

"lexical scope" は単に次のものです。

> establishing form の内部の空間的または textual region に制限された scope。関数への parameters の names は通常 lexically scoped です。[Hyper Spec]

言い換えると、variable の scope は source code 内での位置によって決まります。これは今日の best practice です。最も驚きが少ない方法です。source code を見れば scope を *見る* ことができます。

### `let` vs `let*`

ところで、`let` の syntax は何で、`let*` との違いは何でしょうか。

`let*` は互いに依存する variables を宣言できます。

`let` の基本的な使い方は、初期値のない variables の list を宣言することです。それらは `nil` に初期化されます。

```lisp
(let (variable1 variable2 variable3) ;; variables はデフォルトで nil に初期化されます。
  ;; ここで使う
  …)

;; Example:
(let (a b square)
  (setf a 2)
  (setf square (* a a))
  (list a b square))
;; => (2 NIL 4)

;; まったく同じ:
(let (a
      b
      square)
  …)
```

`(a 2)` のような elements の "pairs" を使うことで default values を与えられます。

```lisp
(let ((a 2)     ;; <-- initial value
       square)  ;; <-- "pair" ではありませんが still one element: defaults to NIL.
  (setf square (* a a))
  (list a square))
```

はい、`((` が 2 つ続きます！これが Common Lisp の syntax です。数える必要はありません。`let` の後に現れるものは variable definitions です。通常は 1 行に 1 つです。

let の logic は body にあり、意味のある indentation を持ちます。Lisp code は indentation に基づいて読めます。見ている project がそれを尊重していないなら、それは低品質な project です。

`square` を nil のままにしたことに注目してください。これを `a` の square にしたいのですが、次のようにできるでしょうか。

```lisp
(let ((a 2)
      (square (* a a))) ;; WARN:
  …)
```

ここではできません。これが `let` の limitation です。`let*` が必要です。

2 つの `let` を書くこともできます。

```lisp
(let ((a 2))
  (let ((square (* a a)))
    (list a square)))
;; => (2 4)
```

これは `let*` と等価です。

```lisp
(let* ((a 2)
       (square (* a a)))
  …)
```

`let` は互いに依存しない variables を宣言するためのもので、`let*` は 1 つずつ読まれ、ある variable が *previous* なものに依存できる variables を宣言するためのものです。

これは *valid ではありません*。

```lisp
(let* ((square (* a a))  ;; WARN!
       (a 2))
   (list a square))
;; => debugger:
;; The variable A is unbound.
```

error message は明快です。`(square (* a a))` を読む時点で、`a` は unknown です。

### let の中の setf

さらに明確にしましょう。`let` binding で *shadowed* された任意の値に `setf` できます。let の外に出ると、variables は current *environment* の値に戻ります。

これは分かっています。

```lisp
(defparameter *name* "test")

(let ((*name* "inside let"))
  (format t "*name* inside let: ~s" *name*))
;; => *name* inside let: "inside let"

(format t "*name* outside let: ~s" *name*)
;; => *name* outside let: "test"
```

let binding によって shadowed された dynamic parameter を setf します。

```lisp
(defparameter *name* "test")

(defun change-name ()
   ;; ただし bad style です。
   ;; functions の中で variables を mutate しないようにし、
   ;; arguments を受け取り fresh data structures を返すようにしてください。
   (setf *name* "set!"))
   ;;    ^^^^^ dynamic environment から、または let lexical scope から。

(let ((*name* "inside let"))
  (change-name)
  (format t "*name* inside let: ~s" *name*))
;; => *name* inside let: "set!"

(format t "*name* outside let: ~s" *name*)
;; => *name* outside let: "test"
```


### 定義した variables を使わないとき

compiler の warnings を読みましょう :)

下では、`b` が定義されているが使われていないと教えてくれます。SBCL は *compile time* に有用な warnings を出すのがかなり得意です（`C-c C-c`（point の expression を compile and load）、`C-c C-k`（file 全体）、または `load` を使うたびに）。

~~~lisp
(let (a b square)
  (list a square))
;; =>
; caught STYLE-WARNING:
;   The variable B is defined but never used.
~~~

この例は REPL で動きます。SBCL の REPL は常に expressions を compile するからです。

これは処理系によって変わる可能性があります。

typo を捕まえるのに素晴らしいです。

```lisp
(let* ((a 2)
       (square (* a a)))
  (list a squale))
  ;;         ^^^ typo
```

これを .lisp file（または `Alt-x slime-scratch` lisp buffer）で compile すると、2 つの warnings が出て、editor はそれぞれを別の色で underline します。

![](assets/let-example-squale.png "まともな editor は compilation warnings を highlight します。")

- まず、"square" は定義されているが使われていない
- 次に、"squale" は undefined variable である

REPL で snippet を実行すると 2 つの warnings が出ますが、snippet が実行されるため、interactive debugger が表示され、"The variable SQUALE is unbound" という error が出ます。


## unbound 変数

"unbound" variables は何にも bind されていません。nil にすら bind されていません。その symbol は存在するかもしれませんが、associated value はありません。

このような variables は次のように作れます。

```lisp
(defvar *connection*)
```

この `defvar` form は正しいものです。default value を与えていないため、variable は unbound です。

variable（または function）が bound されているかは `boundp`（または `fboundp`）で確認できます。`p` は "predicate" を表します。

variable（または function）を unbound にするには `makunbound`（または `fmakunbound`）を使えます。

`defparameter` form は initial argument を必要とすることに注意してください。


## グローバル変数は thread safe

threads で global bindings に access したり set したりすることを恐れないでください。各 thread は variable の独自 copy を持ちます。したがって、`let` bindings などで別の値に bind できます。これは良いことです。

危険があるのは、単一の source of truth が必要で、variable を threads 間で share しなければならない場合だけです。lock を使えます（とても簡単です）が、それは別の話題です。

## 補遺: `defconstant`

`defconstant` は、何かが constant であり変更されるべきでないことを言うためのものですが、実際には `defconstant` は面倒です。`defparameter` を使い、新しい style の earmuffs による convention を追加してください。

```lisp
(defparameter +pi+ pi
  "Just to show that pi exists but has no earmuffs. Now it does. You shouldn't change a variable with +-style earmuffs, it's a constant.")
```

`defconstant` が面倒なのは、少なくとも SBCL では interactive debugger を通じた validation を求めずに再定義できないためです。development 中にはこれをしばしば行うかもしれません。さらに default test は `eql` なので、string を与えると常に constant が再定義されたと考えます。見てください（各行を順番に 1 行ずつ evaluate してください）。

```lisp
(defconstant +best-lisper+ :me)
;; ここまでは問題ありません。

(defconstant +best-lisper+ :me)
;; ここまでは問題ありません。何も再定義していません。

(defconstant +best-lisper+ :you)
;; => constant が再定義されており、interactive debugger が出ます（SBCL）:

The constant +BEST-LISPER+ is being redefined (from :ME to :YOU)
   [Condition of type SB-EXT:DEFCONSTANT-UNEQL]
See also:
  Common Lisp Hyperspec, DEFCONSTANT [:macro]
  SBCL Manual, Idiosyncrasies [:node]

Restarts:
 0: [CONTINUE] Go ahead and change the value.
 1: [ABORT] Keep the old value.
 2: [RETRY] Retry SLIME REPL evaluation request.
 3: [*ABORT] Return to SLIME's top level.
 4: [ABORT] abort thread (#<THREAD tid=573581 "repl-thread" RUNNING {120633D123}>)

;; => 0 (zero) を押すか、"Continue" restart をクリックして value の変更を受け入れます。
```

strings を constants にした場合:

```lisp
(defconstant +best-name+ "me")
;; ここまでは問題ありません。新しい constant を作ります。

(defconstant +best-name+ "me")
;; => interactive debugger!!

The constant +BEST-NAME+ is being redefined (from "me" to "me")
…
```

equality 章で見るように、2 つの strings は低レベルの equality operator である `eql` では equal ではありません（pointer を考えてください）。それらは `equal`（または `string-equal`）です。

これは `defconstant` documentation です。

> global constant を定義し、value が constant であり code に compile され得ることを述べます。variable がすでに value を持ち、これが new value と EQL でない場合、その code は portable ではありません（undefined behavior）。第 3 引数は variable の optional documentation string です。

`eql` の件は spec にあります。constant を再定義するときに implementation が何をすべきかは定義されていないため、処理系によって変わる可能性があります。

次を見ることを勧めます。

- [Alexandria's define-constant](https://alexandria.common-lisp.dev/draft/alexandria.html#Data-and-Control-Flow)。`:test` keyword があります（ただし再定義ではやはり error になります）。
- [Serapeum の `defconst`](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#defconst-symbol-init-optional-docstring)
- `cl:defparameter` ;)


## ガイドラインとベストプラクティス

いくつかの style guidelines:

- top-level parameters は file の先頭にすべて作る
- まず parameters を定義し、その後 variables を定義する
- docstrings を使う
- compiler の warnings を読む
- functions は top-level parameters に頼るより、arguments を受け取る方が良い
- functions は top-level binding を mutate（modify）すべきではありません。代わりに新しい data structure を作り、関数の return value を別の関数への parameter として使い、data が 1 つの関数から別の関数へ流れるようにしてください。
- parameters に最適なもの: webserver port、default value…その他 user-facing parameters
- variables に最適なもの: long-living で internal な variables、cache、DB connections…
- defconstant のことは忘れてよい
- 迷ったら `defparameter` を使う
- function parameter の default が global variable である pattern は typical で idiomatic です。

```lisp
;; STR library から。
(defvar *whitespaces* (list #\Backspace #\Tab #\Linefeed #\Newline #\Vt #\Page
                            #\Return #\Space #\Rubout
                            ;; 簡潔にするため編集
                            ))

(defun trim-left (s &key (char-bag *whitespaces*))
  "Removes all characters in `char-bag` (default: whitespaces) at the beginning of `s`."
  (when s
   (string-left-trim char-bag s)))
```

default value は function call でも構いません。

```lisp
;; Lem editor から
(defun buffer-modified-p (&optional (buffer (current-buffer)))
  "Return T if 'buffer' has been modified, NIL otherwise."
  (/= 0 (buffer-%modified-p buffer)))
```

- global variables に対するこれらの let bindings も idiomatic です: `(let ((*name* "other")) …)`。

## TLDR;

top-level variables には `defparameter` を使います。

lexical scope には `let` または `let*` を使います。両者の違いは知っておくべきですが、迷ったら `let*` から始めてください。

```lisp
(let* ((a 2)
       (square (* a a)))
   (format t "the square of ~a is ~a" a square))
```

variables を変更するには `setf` を使います。
