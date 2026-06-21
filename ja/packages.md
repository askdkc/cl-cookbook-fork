---
title: Packages
---

参照: [The Complete Idiot's Guide to Common Lisp パッケージ][guide]

<a id="package-"></a>

## パッケージを作成する

パッケージ definition の例です。これは name を取り、通常は Common Lisp のシンボルと関数を `:use` したいはずです。

~~~lisp
(defpackage :my-package
  (:use :cl))
~~~

このパッケージ用の code を書き始めるには、その中へ入ります。

~~~lisp
(in-package :my-package)
~~~

この `in-package` マクロは、あなたをパッケージの「中」に置きます。

- 新しい変数や関数は、このパッケージ、つまりこのパッケージの "namespace" に作られます。
- パッケージ prefix を使わずに、このパッケージのすべてのシンボルを直接呼び出せます。

試してみてください。

REPL 上でパッケージを試すためにも `in-package` を使えます。新しい Lisp REPL session では、私たちは CL-USER パッケージの「中」にいます。これは通常のパッケージです。

例を示しましょう。新しい .lisp file を開き、パッケージの中に関数を持つ新しいパッケージを作ります。

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

### パッケージからシンボルに access する

パッケージを定義する、またはパッケージを load する (Quicklisp 経由、または `.asd` system definition の dependency として定義されている場合) と、colon を delimiter として使い、`package:a-symbol` でそのシンボルに access できます。

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

hello 関数をパッケージ name で "namespace" する必要があります。

~~~lisp
CL-USER> (my-package::hello)
"Hello from my package."
~~~

関数を export しましょう。

<a id="symbol--export-"></a>

### シンボルを export する

`defpackage` declaration を拡張し、次のように "hello" 関数を export します。

~~~lisp
(defpackage :my-package
  (:use :cl)
  (:export
   #:hello))
~~~

これを compile すると (Slime では `C-c C-c`)、今度は single colon で呼び出せます。

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

次に、パッケージ prefix なしですぐ access できるように、個別のシンボルを import したくなるかもしれません。


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

パッケージ definition の外から `import` 関数を使うこともできます。

~~~lisp
CL-USER> (import 'ppcre:regex-replace)
CL-USER> (regex-replace …)
~~~

<a id="symbol--import-"></a>

### すべてのシンボルを import する

別のパッケージから何を import するかを注意深く選ぶほうがよい practice ですが (下を読んでください)、`:use` ですべてのシンボルを一度に import することもできます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

これで、`cl-ppcre` から export されたすべての変数、関数、マクロに、あなたの `my-package` パッケージから access できます。

`use-package` 関数を使うこともできます。

~~~lisp
CL-USER> (use-package 'cl-ppcre)
~~~

その対になる、`use-package` の import を取り消すものは… `unuse-package` です。


<a id="package--use--bad-practice-"></a>

### パッケージを "use" することが bad practice とされる理由

`:use` は広く使われている idiom です。次のように書けます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

すると、`cl-ppcre` (別名 `ppcre`) から export された **すべての** シンボルが、あなたのパッケージで直接使えるようになります。しかし、自分が control している project 内の別パッケージを `use` する場合を除き、これは bad practice と考えるべきです。実際、external パッケージがシンボルを追加すると、あなたのシンボルと衝突する可能性があります。あるいは、あなたが追加したシンボルが external シンボルを隠し、warning に気づかないかもしれません。

[この詳しい説明](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) (読むことをおすすめします) を引用すると、要旨は次のとおりです。

> 現代の code では、USE は完全に control している internal パッケージを除いて悪い考えです。internal パッケージでは、別パッケージのシンボルを変更しながら新しい DEFUN を作っていることを忘れるまでは、それなりに筋が通ります。USE があるため、Alexandria は今日では自分自身に新しいシンボルを追加することすらできません。それは、外部 source 由来の同じ名前のシンボルをすでに持つ別パッケージと name collision を起こすかもしれないからです。


<a id="package--symbol--list--do-external-symbols"></a>

## パッケージ内のすべてのシンボルを list する (do-external-symbols)

Common Lisp は、パッケージのシンボルを反復するためのマクロをいくつか提供します。特に興味深いものは
[`DO-SYMBOLS` と `DO-EXTERNAL-SYMBOLS`][do-sym] です。`DO-SYMBOLS` はパッケージから access 可能なシンボルを反復し、`DO-EXTERNAL-SYMBOLS` は external シンボルだけを反復します (これらは実質的なパッケージ API と見なせます)。

"PACKAGE" という名前のパッケージの export 済みシンボルをすべて print するには、次のように書けます。

~~~lisp
(do-external-symbols (s (find-package "PACKAGE"))
  (print s))
~~~

これらのシンボルをすべて list に集めることもできます。

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

`defpackage` form 内で PLN を設定することもできます。PLN の効果は完全に `mypackage` 内に限られます。つまり、`nickname` は、そこでも定義されていない限り他のパッケージでは動きません。そのため、他のライブラリで意図しないパッケージ name clash が起きる心配はありません。

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

パッケージに nickname を追加する別の機能もあります。関数 [`RENAME-PACKAGE`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm) を使うと、パッケージの name と nickname を置き換えられます。しかし、それを使うと、他のライブラリが元の name や nickname でそのパッケージに access できなくなるかもしれません。これを使う場面はほとんどありません。代わりにパッケージ Local Nicknames を使ってください。

<a id="package--nickname"></a>

### パッケージが提供する nickname

パッケージを定義するとき、user experience を良くするために nickname を与えるのは簡単です。しかしこの mechanism は *global* です。ここで定義した nickname は、どこにある他のすべてのパッケージからも見えます。よく使うパッケージに短い name を与えようとしていたなら、別のパッケージと conflict する可能性があります。だからこそ *package-local* nickname が現れました。代わりにそれを使うべきです。

とはいえ、`prove` パッケージからの例を示します。

~~~lisp
(defpackage prove
  (:nicknames :cl-test-more :test-more)
  (:export #:run
           #:is
           #:ok)
~~~

その後、user はパッケージ name の代わりに nickname を使ってこのパッケージを参照できます。例:

~~~lisp
(prove:run)
(cl-test-more:is)
(test-more:ok)
~~~

Common Lisp は 1 つのパッケージに複数の nickname を定義することを許していますが、nickname が多すぎると user にとって保守の複雑さが増える可能性があります。したがって nickname は意味があり、わかりやすいものにするべきです。例:

~~~lisp
(defpackage #:iterate
  (:nicknames #:iter))

(defpackage :cl-ppcre
  (:nicknames :ppcre)
~~~


### Package locks

パッケージ `common-lisp` と SBCL の内部実装用パッケージは、`sb-ext` を含め、default で lock されています。

加えて、user-defined パッケージも lock されるよう宣言でき、その場合 user は変更できません。シンボル table を変更したり、そのシンボルが名前を付けている関数を redefine しようとするとエラーになります。

より詳しい情報は [SBCL][sbcl-package-lock] と [CLisp][clisp-package-lock] の document から得られます。

たとえば、次の code を試すとします。

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

それでも変更が必要な場合は、[cl-package-lock][cl-package-lock] というパッケージを使ってパッケージ lock を無視できます。例:

~~~lisp
(cl-package-locks:without-package-locks
  (rename-package :alexandria :alex))
~~~

## 参照

- [Package Local Nicknames in Common Lisp](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) article。

[guide]: http://www.flownet.com/gat/packages.pdf
[do-sym]: http://www.lispworks.com/documentation/HyperSpec/Body/m_do_sym.htm
[loop]: http://www.lispworks.com/documentation/HyperSpec/Body/06_a.htm
[rename-package]: http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm
[sbcl-package-lock]: http://www.sbcl.org/manual/#Package-Locks
[clisp-package-lock]: https://clisp.sourceforge.io/impnotes/pack-lock.html
[cl-package-lock]: https://www.cliki.net/CL-PACKAGE-LOCKS
