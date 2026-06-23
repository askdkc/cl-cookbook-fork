---
title: パッケージ
---

参照: [The Complete Idiot's Guide to Common Lisp パッケージ][guide]

<a id="package-"></a>

## パッケージを作成する

パッケージ定義の例です。これは名前を取り、通常は Common Lisp のシンボルと関数を `:use` したいはずです。

~~~lisp
(defpackage :my-package
  (:use :cl))
~~~

このパッケージ用のコードを書き始めるには、その中へ入ります。

~~~lisp
(in-package :my-package)
~~~

この `in-package` マクロは、あなたをパッケージの「中」に置きます。

- 新しい変数や関数は、このパッケージ、つまりこのパッケージの「名前空間」に作られます。
- パッケージの接頭辞を使わずに、このパッケージのすべてのシンボルを直接呼び出せます。

試してみてください。

REPL 上でパッケージを試すためにも `in-package` を使えます。新しい Lisp REPL セッションでは、私たちは CL-USER パッケージの「中」にいます。これは通常のパッケージです。

例を示しましょう。新しい .lisp ファイルを開き、パッケージの中に関数を持つ新しいパッケージを作ります。

~~~lisp
;; in test-package.lisp
(defpackage :my-package
  (:use :cl))

(in-package :my-package)

(defun hello ()
  (print "Hello from my package."))
~~~

この "hello" 関数は "my-package" の中にあります。まだ export されていません。

それを呼び出す方法を見るには、下へ進んでください。

<a id="package--symbol--access-"></a>
<a id="access-"></a>

### パッケージからシンボルにアクセスする

パッケージを定義するか読み込むと（Quicklisp 経由、または `.asd` システム定義の依存関係として定義されている場合）、コロンを区切り文字として使い、`package:a-symbol` でそのシンボルにアクセスできます。

例:

~~~lisp
(str:concat …)
~~~

シンボルが export されていない場合 (つまり "private" な場合) は、double colon を使います。

~~~lisp
(package::non-exported-symbol)
(my-package::hello)
~~~

例を続けます。REPL で、`CL-USER` ではなく `my-package` にいることを確認してください。そこで "hello" を直接呼び出せます。

~~~lisp
CL-USER> (in-package :my-package)
#<PACKAGE "MY-PACKAGE">
;; ^^^ this is the package object. You can right click or call INSPECT on it.
MY-PACKAGE> (hello)
;; ^^^^ the REPL shows you the current package.
"Hello from my package."
~~~

しかし今度は CL-USER パッケージに戻り、"hello" を呼び出してみます。エラーになります。

~~~lisp
MY-PACKAGE> (in-package :cl-user)
#<PACKAGE "COMMON-LISP-USER">
CL-USER> (hello)

=> you get the interactive debugger that says:

The function COMMON-LISP-USER::HELLO is undefined.

(quit)
~~~

hello 関数をパッケージ名で名前空間修飾する必要があります。

~~~lisp
CL-USER> (my-package::hello)
"Hello from my package."
~~~

関数を export しましょう。

<a id="symbol--export-"></a>

### シンボルを export する

`defpackage` 宣言を拡張し、次のように "hello" 関数を export します。

~~~lisp
(defpackage :my-package
  (:use :cl)
  (:export
   #:hello))
~~~

これをコンパイルすると (Slime では `C-c C-c`)、今度はコロン1つで呼び出せます。

~~~lisp
CL-USER> (my-package:hello)
~~~

`export` 関数を使うこともできます。

~~~lisp
(in-package :my-package)
(export #:hello)
~~~

観察:

- sharpsign なしで `:hello` を export しても動きますが、常に新しいシンボルを作ります。`#:` notation は新しいシンボルを作りません。より正確には、現在のパッケージに新しいシンボルを *intern* しません。これは細部であり、この時点では使うかどうかは個人の好みです。特に他のライブラリからシンボルを import して re-export するとき、シンボル namespace を散らかさずに済むため役立つことがあります。そうすれば editor のシンボル completion は関連する結果だけを表示します。この時点の私たちには有用ではないので、心配はいりません。

次に、パッケージ接頭辞なしですぐアクセスできるように、個別のシンボルをインポートしたくなるかもしれません。


<a id="package--symbol--import-"></a>

### 別のパッケージからシンボルを import する

必要なシンボルだけを `:import-from` で正確に import できます。

~~~lisp
(defpackage :my-package
  (:import-from :ppcre #:regex-replace)
  (:use :cl))
~~~

これで `my-package` の中から、`ppcre` パッケージ prefix なしで `regex-replace` を呼び出せます。`regex-replace` はあなたのパッケージ内の新しいシンボルです。これは export されません。

明示的な import なしに `(:import-from :ppcre)` と書かれているのを見ることがあります。これは ASDF の *package inferred system* を使う人の助けになります。

パッケージ定義の外から `import` 関数を使うこともできます。

~~~lisp
CL-USER> (import 'ppcre:regex-replace)
CL-USER> (regex-replace …)
~~~

<a id="symbol--import-"></a>

### すべてのシンボルを import する

別のパッケージから何を import するかを注意深く選ぶほうがよい習慣ですが (下を読んでください)、`:use` ですべてのシンボルを一度に import することもできます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

これで、`cl-ppcre` からエクスポートされたすべての変数、関数、マクロに、`my-package` パッケージからアクセスできます。

`use-package` 関数を使うこともできます。

~~~lisp
CL-USER> (use-package 'cl-ppcre)
~~~

その対になる、`use-package` の import を取り消すものは… `unuse-package` です。


<a id="package--use--bad-practice-"></a>
<a id="use--bad-practice-"></a>

### パッケージを "use" することが悪い慣行とされる理由

`:use` は広く使われているイディオムです。次のように書けます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

すると、`cl-ppcre` (別名 `ppcre`) から export された **すべての** シンボルが、あなたのパッケージで直接使えるようになります。しかし、自分が管理しているプロジェクト内の別パッケージを `use` する場合を除き、これは悪い習慣と考えるべきです。実際、外部のパッケージがシンボルを追加すると、あなたのシンボルと衝突する可能性があります。あるいは、あなたが追加したシンボルが外部のシンボルを隠し、警告に気づかないかもしれません。

[この詳しい説明](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) (読むことをおすすめします) を引用すると、要旨は次のとおりです。

> 現代のコードでは、USE は完全に管理している内部パッケージを除いて悪い考えです。内部パッケージでは、別パッケージのシンボルを変更しながら新しい DEFUN を作っていることを忘れるまでは、それなりに筋が通ります。USE があるため、Alexandria は今日では自分自身に新しいシンボルを追加することすらできません。それは、外部のソース由来の同じ名前のシンボルをすでに持つ別パッケージと名前の衝突を起こすかもしれないからです。


<a id="package--symbol--list--do-external-symbols"></a>

## パッケージ内のすべてのシンボルを list する (do-external-symbols)

Common Lisp は、パッケージのシンボルを反復するためのマクロをいくつか提供します。特に興味深いものは
[`DO-SYMBOLS` と `DO-EXTERNAL-SYMBOLS`][do-sym] です。`DO-SYMBOLS` はパッケージからアクセス可能なシンボルを反復し、`DO-EXTERNAL-SYMBOLS` は外部シンボルだけを反復します（これらは実質的なパッケージ API と見なせます）。

"PACKAGE" という名前のパッケージの export 済みシンボルをすべて print するには、次のように書けます。

~~~lisp
(do-external-symbols (s (find-package "PACKAGE"))
  (print s))
~~~

これらのシンボルをすべてリストに集めることもできます。

~~~lisp
(let (symbols)
  (do-external-symbols (s (find-package "PACKAGE"))
    (push s symbols))
  symbols)
~~~

または [`LOOP`][loop] で行えます。

~~~lisp
(loop for s being the external-symbols of (find-package "PACKAGE")
  collect s)
~~~

[`with-package-iterator`](https://cl-community-spec.github.io/pages/with_002dpackage_002diterator.html) も参照してください。

## Package nickname

#### Package Local Nicknames (PLN)

import したパッケージに local name を与えると、typing を減らせて便利なことがあります。特に、import したパッケージがよい global nickname を提供していない場合です。

多くの処理系 (SBCL, CCL, ECL, Clasp, ABCL, ACL, LispWorks >= 7.2…) はパッケージ Local Nicknames (PLN) を support しています。


PLN を使うには、たとえば ad-hoc に local nickname を試したい場合、単に次のようにできます。

~~~lisp
(uiop:add-package-local-nickname :a :alexandria)
(a:iota 12) ; (0 1 2 3 4 5 6 7 8 9 10 11)
~~~

`defpackage` フォーム内で PLN を設定することもできます。PLN の効果は完全に `mypackage` 内に限られます。つまり、`nickname` は、そこでも定義されていない限り他のパッケージでは動きません。そのため、他のライブラリで意図しないパッケージ名の衝突が起きる心配はありません。

~~~lisp
(defpackage :mypackage
  (:use :cl)
  (:local-nicknames (:nickname :original-package-name)
                    (:alex :alexandria)
                    (:re :cl-ppcre)))

(in-package :mypackage)

;; You can use :nickname instead of :original-package-name
(nickname:some-function "a" "b")
~~~

パッケージにニックネームを追加する別の機能もあります。関数 [`RENAME-PACKAGE`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm) を使うと、パッケージの名前とニックネームを置き換えられます。しかし、それを使うと、他のライブラリが元の名前やニックネームでそのパッケージにアクセスできなくなる可能性があります。これを使う場面はほとんどありません。代わりにパッケージローカルニックネームを使ってください。

<a id="package--nickname"></a>

### パッケージが提供する nickname

パッケージを定義するとき、利用者の使い勝手を良くするために nickname を与えるのは簡単です。しかしこの仕組みは *global*（全体）です。ここで定義した nickname は、どこにある他のすべてのパッケージからも見えます。よく使うパッケージに短い名前を与えようとしていたなら、別のパッケージと衝突する可能性があります。だからこそ *package-local*（パッケージローカル）な nickname が現れました。代わりにそれを使うべきです。

とはいえ、`prove` パッケージからの例を示します。

~~~lisp
(defpackage prove
  (:nicknames :cl-test-more :test-more)
  (:export #:run
           #:is
           #:ok)
~~~

その後、利用者はパッケージ名の代わりに nickname を使ってこのパッケージを参照できます。例:

~~~lisp
(prove:run)
(cl-test-more:is)
(test-more:ok)
~~~

Common Lisp は 1 つのパッケージに複数の nickname を定義することを許していますが、nickname が多すぎると利用者にとって保守の複雑さが増える可能性があります。したがって nickname は意味があり、わかりやすいものにするべきです。例:

~~~lisp
(defpackage #:iterate
  (:nicknames #:iter))

(defpackage :cl-ppcre
  (:nicknames :ppcre)
~~~


### パッケージロック

パッケージ `common-lisp` と SBCL の内部実装用パッケージは、`sb-ext` を含め、デフォルトでロックされています。

加えて、ユーザー定義のパッケージもロックされるよう宣言でき、その場合ユーザーは変更できません。シンボルテーブルを変更したり、そのシンボルが名前を付けている関数を再定義しようとするとエラーになります。

より詳しい情報は [SBCL][sbcl-package-lock] と [CLisp][clisp-package-lock] のドキュメントから得られます。

たとえば、次のコードを試すとします。

~~~lisp
(asdf:load-system :alexandria)
(rename-package :alexandria :alex)
~~~

次のエラーが出ます (SBCL の場合)。

~~~
Lock on package ALEXANDRIA violated when renaming as ALEX while
in package COMMON-LISP-USER.
   [Condition of type PACKAGE-LOCKED-ERROR]
See also:
  SBCL Manual, Package Locks [:node]

Restarts:
 0: [CONTINUE] Ignore the package lock.
 1: [IGNORE-ALL] Ignore all package locks in the context of this operation.
 2: [UNLOCK-PACKAGE] Unlock the package.
 3: [RETRY] Retry SLIME REPL evaluation request.
 4: [*ABORT] Return to SLIME's top level.
 5: [ABORT] abort thread (#<THREAD "repl-thread" RUNNING {10047A8433}>)

...
~~~

それでも変更が必要な場合は、[cl-package-lock][cl-package-lock] というパッケージを使ってパッケージのロックを無視できます。例:

~~~lisp
(cl-package-locks:without-package-locks
  (rename-package :alexandria :alex))
~~~

## 参照

- [Package Local Nicknames in Common Lisp](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) の記事。

[guide]: http://www.flownet.com/gat/packages.pdf
[do-sym]: http://www.lispworks.com/documentation/HyperSpec/Body/m_do_sym.htm
[loop]: http://www.lispworks.com/documentation/HyperSpec/Body/06_a.htm
[rename-package]: http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm
[sbcl-package-lock]: http://www.sbcl.org/manual/#Package-Locks
[clisp-package-lock]: https://clisp.sourceforge.io/impnotes/pack-lock.html
[cl-package-lock]: https://www.cliki.net/CL-PACKAGE-LOCKS
