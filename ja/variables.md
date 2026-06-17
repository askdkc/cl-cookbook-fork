---
title: 変数
---

あなたは初めての Common Lisp program を書いていて（ようこそ！）、変数を宣言したいと思っています。どんな選択肢がありますか？

迷ったら、以下に示すようにトップレベルのパラメータには `defparameter` を使ってください。

<!-- Cookbook のほとんどの節とは異なり、学生やその他の
初心者が集中しやすいように、ここでは TLDR; を先頭に置いていません。 -->


## `defparameter`: トップレベル変数

トップレベル変数を宣言するには、次のように `defparameter` を使います。

```lisp
(defparameter *name* "me")

(defun hello (&optional name)
  "Say hello."
  (format t "Hello ~a!" (or name *name*)))
```

`defparameter` はオプション(省略可能)の第3引数として変数のドキュメント文字列を受け取れます：

```lisp
(defparameter *name* "me"
   "Default name to say hello to.")
```

インラインのドキュメント文字列はCommon Lispのインタラクティブな体験において重要な要素です。コーディングセッション中に出会うことになります（私たちLisperはたいていLispを長時間起動しっぱなしにしています）。EmacsとSlimeでは、`C-c C-d d`（`Alt-x slime-describe-symbol`）でシンボルのドキュメント文字列を参照できます。プログラムから参照することもできます：

~~~lisp
(documentation '*name* 'variable)
~~~

ここでは `*name*` が保持している値ではなく、`*name*` というシンボルのドキュメントを求めているため、`'*name*`（`(quote *name*)` の略記）のようにクォートしています。もう1つの「ドキュメントの種類」は `'function` です。Common Lispでは変数と関数は異なる「名前空間」に存在しており、それがここにも現れています。

値なしの `defparameter` については後述します。

### defparameter の再定義

Common Lispのコーディングセッションは通常、長時間にわたりとてもインタラクティブです。Lispを起動したまま、作業しながら対話を続けます。これはEmacsとSlime、Vim、AtomとSLIMA、VSCodeとAlive、Lem……その他のエディタ、あるいはターミナルから行います。

つまり、次のようなことができます：

1. 最初の defparameter を書く

```lisp
(defparameter *name* "me")
```

REPLに直接書くか、.lispファイルに書いてSlimでショートカットを使ってコンパイル＆ロードします（その式の上で `C-c C-c`（Alt-x `slime-compile-defun`）、または現在のバッファ全体をコンパイル・ロードするなら `C-c C-k`（Alt-x `slime-compile-and-load-file`））。シンプルなターミナルREPLで作業しているなら `(load …)` で.lispファイルを読み込めます）。

これで `*name*` 変数が実行中のイメージに存在するようになります。

2. defparameter の行を編集する:

```lisp
(defparameter *name* "you")
```

同じ方法で変更をロードします：REPLから、または `C-c C-c` で。これで `*name*` 変数は新しい値 "you" を持ちます。

`defvar` なら再定義されません。


## `defvar`: 再定義なし

`defvar` はトップレベルの変数を定義し、再定義から保護します。

`defvar` を再ロードしても現在の値は消去されません。変更するには setf を使う必要があります。


```lisp
(defvar *names-cache* (list)
  "Store a list of names we said \"hello\" to.")

(defun hello (&optional (name *name*))
   (pushnew name *names-cache* :test #'string-equal)
   (format t "hello ~a!" name))
```

実際に使ってみましょう：

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

`defvar` 行を再定義した場合（`C-c C-c`、`C-c C-k`、または REPL で）、`*names-cache*` はどうなるでしょうか。

変わりません。そして *それは良いことです* 。

実際、この変数はユーザーが直接目にするパラメータではなく、即座の用途はありませんが、プログラムの正確性や堅牢性などにとって重要です。Webサーバーのキャッシュを保持していると想像してください：新しいコードをロードするたびにそれを消去したくはありません。開発中は `C-c C-k` を連打して現在のファイルを何度もリロードしますし、本番環境で実行中のアプリをリロードすることもできますが、触れたくないものが確かにあります。データベース接続であれば、コードをコンパイルするたびに nil に戻して再接続したくはないでしょう。

`defvar` の変数値を変更するには `setf` を使う必要があります。

もちろん Slime にはこのためのショートカットがあります。`setf` の代わりに、`C-M-x`（Control+ Alt + x）、すなわちインタラクティブ関数 `slime-eval-defun`（これは `slime-re-evaluate-defvar` を呼びます）を使えます。

```
現在のトップレベルフォームを評価します。

フォームが "(defvar" で始まる場合は "slime-re-evaluate-defvar" を使います。
```


## " \*イヤーマフ\* " 規約

`*name*` のように「*イヤーマフ*」で囲んで書いているのに気づきましたか。これはレキシカルスコープ内でトップレベル変数を上書きしないようにするための重要な規約です。

```lisp
(defparameter name "lisper")

;; later…
(let ((name "something else"))
   ;;  ^^^ トップレベルの name を上書きする。見つけにくいバグになりうる。
   …)
```

イヤーマフを使えばこれが機能になります：

```lisp
(defparameter *db-name* "db.db")

(defun connect (&optional (db-name *db-name*))
  (sqlite:connect db-name))

(let ((*db-name* "another.db"))
  (connect))
  ;; ^^^^  db-nameオプションパラメータ（デフォルトは *db-name*）は "another.db" を見るようになる。
```

ちなみに、このようなユースケースでは `let` バインディングを抽象化した `with-…` マクロがよく見られます。

```lisp
(with-db "another.db"
  (connect))
```

余談ですが、[earmuff(イヤーマフ)](https://www.wordreference.com/definition/earmuff) とは冬に耳（だけ）を覆うものです。現実よりも映画で見たことがある人の方が多いかもしれません。最後にひと言：自分を大切にして、暖かくして、イヤーマフを使いましょう。

## グローバル変数は「ダイナミックスコープ」内に作られる

トップレベルのパラメータや変数はいわゆるダイナミックスコープ内に作られます。関数定義の中からも（先ほどのように）、`let` バインディングの中からも、どこからでもアクセスできます。

Lisp では、これらを [*ダイナミック変数*または*スペシャル変数*](https://cl-community-spec.github.io/pages/Dynamic-Variables.html) とも呼びます。

任意の場所から `proclaiming` を使って "special" と宣言することで作ることも可能です。日常的にやることではありませんが、Lispでは何でも可能ですから ;)

> ダイナミック変数は、それをバインドするフォームのダイナミックエクステントの外から参照することができる。そのような変数は「グローバル変数」と呼ばれることもあるが、あらゆる意味で単なるダイナミック変数であり、そのバインディングがたまたまグローバル環境に存在しているにすぎない。[Hyper Spec]


## `setf`: 値の変更

どんな変数も `setf` で変更できます:

```lisp
(setf *name* "Alice")
;; => "Alice"
```

新しい値が返ります。

実際、`setf` は値と変数のペアを複数受け取れます：

~~~lisp
(setf *name* "Bob"
      *db-name* "app.db")
;; => "app.db"
~~~

最後の値が返されます。

まだ宣言されていない変数を `setf` するとどうなるでしょうか？ たいていは動作しますが警告が出ます：

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

返り値の "foo" が見えるので動作はしています。ただし、変数は先に `defparameter` や `defvar` で宣言してください。

`setf` のドキュメント文字列全体を読んでみましょう。興味深いことが書いてあります：

```txt
SETQ と同様にペアの引数を取る。最初はplace（場所）で、2番目はそのplaceに入れるべき値。最後の値を返す。place引数は、SETFが対応する設定フォームを知っているアクセスフォームであれば何でもよい。
```

`setq` も別のマクロですが、`setf` がより多くの「place」に対して動作するため、今では `setq` はほとんど使われません。関数やあらゆるものを `setf` できます。


## `let`, `let*`: レキシカルスコープの作成

`let` は限られたスコープ内で変数を定義したり、トップレベル変数を一時的にオーバーライドしたりするために使います。

下の例では、2つの変数は `let` のカッコの中でのみ存在します：

```lisp
(let* ((a 2)
       (square (* a a)))
   (format t "the square of ~a is ~a" a square))
   ;; ここまでは問題ありません

(format t "the value of a is: ~a" a)
;; => ERROR: the variable A is unbound
```

「unbound（未束縛）」とは、変数が NIL にさえ束縛されていないことを意味します。シンボル自体は存在するかもしれませんが、何にも関連付けられていません。

`let` のスコープが終わった直後、変数 `a` と `square` はもう存在しません。

Lispリーダーが `format` 式を読んだとき、グローバル環境には `a` シンボルが存在しますが、束縛されていません。

> 考えてみてください：変数名を書いてLispリーダーがそれを読むとシンボルは作られますが、何にも束縛されるわけではありません。

2つの変数は `let` バインディングの中のどんなフォームからもアクセスできます。2つ目の `let` を作ると、その*環境*は前のものを継承します（上で宣言した変数が見えます。当然ですが！）。

```lisp
(defparameter *name* "test")

(defun log (square)
  (format t "name is ~s and square is ~a" *name* square))

(let* ((a 2)
       (square (* a a)))
  ;; 最初の環境の中
  (let ((*name* "inside let"))
    ;; 2つ目の環境の中、
    ;; ダイナミックスコープにアクセスしている。
    (log square)))
;;  => name is "inside let" and square is 4
;;  => NIL

(print *name*)
;; => "test"
;;    ^^^^ letの外に出たので、ダイナミックスコープの値に戻る。
```

let の中で関数を定義することもできます。そうすることで関数定義はコンパイル時に周囲の let からのバインディングを「見る」ことになります。これはクロージャであり、関数の章で扱います。

「レキシカルスコープ」とは単純に言えば、

> 設立フォーム内の空間的またはテキスト的な領域に限定されたスコープ。関数のパラメータ名は通常レキシカルスコープを持つ。[Hyper Spec]

言い換えれば、変数のスコープはソースコード上の位置によって決まります。これは今日のベストプラクティスです。最も驚きの少ない方法です：ソースコードを見ればスコープが見えるのです。

### `let` と `let*`

ところで、`let` の構文とは何で、`let*` との違いは何でしょうか？

`let*` では互いに依存する変数を宣言できます。

`let` の基本的な使い方は、初期値なしで変数のリストを宣言することです。変数は `nil` で初期化されます：

```lisp
(let (variable1 variable2 variable3) ;; 変数はデフォルトで nil に初期化される。
  ;; ここで使う
  …)

;; 例：
(let (a b square)
  (setf a 2)
  (setf square (* a a))
  (list a b square))
;; => (2 NIL 4)

;; まったく同じ：
(let (a
      b
      square)
  …)
```

`(a 2)` のように「ペア」の要素を使うことでデフォルト値を与えられます：

```lisp
(let ((a 2)     ;; <-- 初期値
       square)  ;; <-- 「ペア」ではないが、1要素として NIL がデフォルト。
  (setf square (* a a))
  (list a square))
```

`((` が2つ連続しています！ これがCommon Lispの構文です。数える必要はありません。`let` の後に来るのは変数の定義です。通常は1行に1つです。

letのロジックは意味のあるインデントとともにボディに書かれます。Lispのコードはインデントで読めます。あなたが見ているプロジェクトがこれを守っていなければ、それは低品質なプロジェクトです。

`square` を `nil` のままにしておいたことに注意してください。`a` の2乗にしたいのですが、こんなことはできるでしょうか？

```lisp
(let ((a 2)
      (square (* a a))) ;; 警告：
  …)
```

ここではできません。これが `let` の制限です。`let*` が必要です。

2つの `let` を書くこともできます：

```lisp
(let ((a 2))
  (let ((square (* a a)))
    (list a square)))
;; => (2 4)
```

これは `let*` と等価です：

```lisp
(let* ((a 2)
       (square (* a a)))
  …)
```

`let` は互いに依存しない変数を宣言するためのもので、`let*` は順番に読まれ、後の変数が前の変数に依存できる変数を宣言するためのものです。

これは無効です：

```lisp
(let* ((square (* a a))  ;; WARN!
       (a 2))
   (list a square))
;; => debugger:
;; The variable A is unbound.
```

エラーメッセージは明確です。`(square (* a a))` を読んでいる時点では、`a` は未知です。

### let の中の setf

さらに明確にしましょう:`let` バインディングで *シャドウされている* 値であっても `setf` できます。ますが、let の外に出ると変数は現在の *環境* の値に戻ります。ります。

これはわかっていることです：

```lisp
(defparameter *name* "test")

(let ((*name* "inside let"))
  (format t "*name* inside let: ~s" *name*))
;; => *name* inside let: "inside let"

(format t "*name* outside let: ~s" *name*)
;; => *name* outside let: "test"
```

let バインディングでシャドウされたダイナミックパラメータを setf する：

```lisp
(defparameter *name* "test")

(defun change-name ()
   ;; ただし、スタイルとしては悪い。
   ;; 関数の中で変数をミューテートしないようにして、
   ;; 引数を受け取り、新しいデータ構造を返すようにすること。
   (setf *name* "set!"))
   ;; ^^^^  ダイナミック環境から、またはletのレキシカルスコープから。

(let ((*name* "inside let"))
  (change-name)
  (format t "*name* inside let: ~s" *name*))
;; => *name* inside let: "set!"

(format t "*name* outside let: ~s" *name*)
;; => *name* outside let: "test"
```


### 定義した変数を使わないとき

コンパイラの警告を読みましょう :)

下の例では、`b` が定義されているが一度も使われていないことを教えてくれます。SBCLは *コンパイル時*（式をポイントでコンパイル・ロードする `C-c C-c`（`slime-compile-defun`）、ファイル全体の `C-c C-k`、または `load` を使うたびに）に有用な警告を出すことが得意です。

~~~lisp
(let (a b square)
  (list a square))
;; =>
; caught STYLE-WARNING:
;   The variable B is defined but never used.
~~~

SBCLのREPLは常に式をコンパイルするため、この例はREPLで動作します。

実装によっては動作が異なる場合があります。

タイポを発見するのに最適です！

```lisp
(let* ((a 2)
       (square (* a a)))
  (list a squale))
  ;;         ^^^ typo
```

これを .lisp file（または `Alt-x slime-scratch` lisp buffer）でコンパイルすると、2つの警告が出て、エディタはそれぞれを2つの異なる色でアンダーラインを引きます：

![](assets/let-example-squale.png "まともな editor は compilation warnings を highlight します。")

- 1つ目：「square」が定義されているが一度も使われていない
- 2つ目：「squale」は未定義変数である。

REPLでこのスニペットを実行すると、2つの警告が出た後、スニペットが実行されるので「The variable SQUALE is unbound」というエラーでインタラクティブデバッガが起動します。


## 未束縛変数

「unbound（未束縛）」変数は、NIL にさえ束縛されていません。シンボルは存在するかもしれませんが、関連付けられた値を持ちません。

このような変数は次のように作れます：

```lisp
(defvar *connection*)
```

この `defvar` フォームは正しいです。デフォルト値を与えていないので：変数は未束縛です。

変数（または関数）が束縛されているかどうかは `boundp`（または `fboundp`）で確認できます。末尾の `p` は「predicate（述語）」の意味です。

変数（または関数）を未束縛にするには `makunbound`（または `fmakunbound`）を使います。

なお、`defparameter` フォームには初期引数が必須です。


## グローバル変数はスレッドセーフ

スレッド内でグローバルバインディングにアクセスしたり set したりすることを怖がる必要はありません。各スレッドは変数の独自のコピーを持ちます。結果として、`let` バインディングなどで別の値に束縛することもできます。これは良いことです。

問題になるのは、真に単一の情報源を求める場合、つまりスレッド間で変数を共有したいときだけです。ロックを使えば（非常に簡単ですが）対処できます。ただしそれはまた別の話題です。

## 付録： `defconstant`

`defconstant` は、何かが constant であり変更されるべきでないことを言うためのものですが、実際には `defconstant` は面倒です。`defparameter` を使い、新しいスタイルのイヤーマフによる規約を加えてください：

```lisp
(defparameter +pi+ pi
  "piが存在するがイヤーマフがないことを示すため。これでイヤーマフを付けた。+-スタイルのイヤーマフの変数は変更すべきでない、定数扱いだ。")
```

`defconstant` が扱いにくい理由は、少なくともSBCLでは、インタラクティブデバッガによる確認なしに再定義できないからです。開発中は頻繁に再定義しますし、デフォルトのテストが `eql` であるため、文字列を与えると定数が常に再定義されたと見なします。（以下の各行を順番に1つずつ評価してみてください）：

```lisp
(defconstant +best-lisper+ :me)
;; ここまでは問題なし。

(defconstant +best-lisper+ :me)
;; ここまでは問題なし：何も再定義していない。

(defconstant +best-lisper+ :you)
;; => 定数が再定義されようとしており、インタラクティブデバッガが起動する（SBCL）：

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

;; => 0（ゼロ）を押すか「Continue」リスタートをクリックして値の変更を受け入れる。
```

文字列を定数にした場合：

```lisp
(defconstant +best-name+ "me")
;; ここまでは問題なし、新しい定数を作成。

(defconstant +best-name+ "me")
;; => インタラクティブデバッガが起動！！

The constant +BEST-NAME+ is being redefined (from "me" to "me")
…
```

等値の章で見るように、2つの文字列は低レベルの等値演算子（ポインタを考えてみてください）である `eql` では等しくなく、`equal`（または `string-equal` ）では等しくなります。

`defconstant` のドキュメントにはこう書かれています：

> グローバル定数を定義し、その値は定数でありコードにコンパイルされる可能性があることを宣言する。変数がすでに値を持っており、それが新しい値と EQL でない場合、そのコードはポータブルでない（未定義動作）。3番目の引数は変数に対するオプションのドキュメント文字列。

`eql` の件は仕様にありますが、定数を再定義したときに実装が何をすべきかは定義されていないため、実装によって異なる場合があります。

以下を参照することをお勧めします：

- [Alexandria's define-constant](https://alexandria.common-lisp.dev/draft/alexandria.html#Data-and-Control-Flow)。`:test` キーワードを持つ（ただし再定義ではやはりエラーになります）。
- [Serapeum の `defconst`](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#defconst-symbol-init-optional-docstring)
- `cl:defparameter` ;)


## ガイドラインとベストプラクティス

スタイルに関するガイドラインをいくつか：

- トップレベルのパラメータはすべてファイルの先頭に作成する
- パラメータを先に定義し、次に変数を定義する
- ドキュメント文字列を使う
- コンパイラの警告を読む
- 関数はトップレベルのパラメータに依存するよりも、引数を受け取る方が良い
- 関数はトップレベルのバインディングをミューテート（変更）すべきでない。代わりに新しいデータ構造を作成し、関数の戻り値を別の関数のパラメータとして使い、データが関数から関数へと流れるようにすること
- パラメータは「Webサーバーのポート」や「デフォルト値」など、ユーザーが目にするパラメータに最適
- 変数はキャッシュやDBコネクションなど、長期間存続し内部的な変数に最適
- defconstant は忘れてよい
- 迷ったら `defparameter` を使う
- 関数パラメータのデフォルトをグローバル変数にするパターンは典型的でイディオマティック：

```lisp
;; STRライブラリより。
(defvar *whitespaces* (list #\Backspace #\Tab #\Linefeed #\Newline #\Vt #\Page
                            #\Return #\Space #\Rubout
                            ;; 簡略化のため省略
                            ))

(defun trim-left (s &key (char-bag *whitespaces*))
  "Removes all characters in `char-bag` (default: whitespaces) at the beginning of `s`."
  (when s
   (string-left-trim char-bag s)))
```

デフォルト値は関数呼び出しにすることもできます：

```lisp
;; Lemエディタより
(defun buffer-modified-p (&optional (buffer (current-buffer)))
  "Return T if 'buffer' has been modified, NIL otherwise."
  (/= 0 (buffer-%modified-p buffer)))
```

- グローバル変数への let バインディング `(let ((*name* "other")) …)` もイディオマティックです。

## まとめ

トップレベル変数には `defparameter` を使ってください。

レキシカルスコープには `let` または `let*` を使ってください。両者の違いは知っておくべきですが、迷ったら `let*` から始めましょう：

```lisp
(let* ((a 2)
       (square (* a a)))
   (format t "the square of ~a is ~a" a square))
```

変数の変更には `setf` を使ってください。
