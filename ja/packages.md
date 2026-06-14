---
title: Packages
---

参照: [The Complete Idiot's Guide to Common Lisp Packages][guide]

## package を作成する

package definition の例です。これは name を取り、通常は Common Lisp の symbol と function を `:use` したいはずです。

~~~lisp
(defpackage :my-package
  (:use :cl))
~~~

この package 用の code を書き始めるには、その中へ入ります。

~~~lisp
(in-package :my-package)
~~~

この `in-package` macro は、あなたを package の「中」に置きます。

- 新しい variable や function は、この package、つまりこの package の "namespace" に作られます。
- package prefix を使わずに、この package のすべての symbol を直接呼び出せます。

試してみてください。

REPL 上で package を試すためにも `in-package` を使えます。新しい Lisp REPL session では、私たちは CL-USER package の「中」にいます。これは通常の package です。

例を示しましょう。新しい .lisp file を開き、package の中に function を持つ新しい package を作ります。

~~~lisp
;; in test-package.lisp
(defpackage :my-package
  (:use :cl))

(in-package :my-package)

(defun hello ()
  (print "Hello from my package."))
~~~

この "hello" function は "my-package" の中にあります。まだ export されていません。

それを呼び出す方法を見るには、下へ進んでください。

### package から symbol に access する

package を定義する、または package を load する (Quicklisp 経由、または `.asd` system definition の dependency として定義されている場合) と、colon を delimiter として使い、`package:a-symbol` でその symbol に access できます。

例:

~~~lisp
(str:concat …)
~~~

symbol が export されていない場合 (つまり "private" な場合) は、double colon を使います。

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

しかし今度は CL-USER package に戻り、"hello" を呼び出してみます。error になります。

~~~lisp
MY-PACKAGE> (in-package :cl-user)
#<PACKAGE "COMMON-LISP-USER">
CL-USER> (hello)

=> you get the interactive debugger that says:

The function COMMON-LISP-USER::HELLO is undefined.

(quit)
~~~

hello function を package name で "namespace" する必要があります。

~~~lisp
CL-USER> (my-package::hello)
"Hello from my package."
~~~

function を export しましょう。

### symbol を export する

`defpackage` declaration を拡張し、次のように "hello" function を export します。

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

`export` function を使うこともできます。

~~~lisp
(in-package :my-package)
(export #:hello)
~~~

観察:

- sharpsign なしで `:hello` を export しても動きますが、常に新しい symbol を作ります。`#:` notation は新しい symbol を作りません。より正確には、現在の package に新しい symbol を *intern* しません。これは細部であり、この時点では使うかどうかは個人の好みです。特に他の library から symbol を import して re-export するとき、symbol namespace を散らかさずに済むため役立つことがあります。そうすれば editor の symbol completion は関連する結果だけを表示します。この時点の私たちには有用ではないので、心配はいりません。

次に、package prefix なしですぐ access できるように、個別の symbol を import したくなるかもしれません。


### 別の package から symbol を import する

必要な symbol だけを `:import-from` で正確に import できます。

~~~lisp
(defpackage :my-package
  (:import-from :ppcre #:regex-replace)
  (:use :cl))
~~~

これで `my-package` の中から、`ppcre` package prefix なしで `regex-replace` を呼び出せます。`regex-replace` はあなたの package 内の新しい symbol です。これは export されません。

明示的な import なしに `(:import-from :ppcre)` と書かれているのを見ることがあります。これは ASDF の *package inferred system* を使う人の助けになります。

package definition の外から `import` function を使うこともできます。

~~~lisp
CL-USER> (import 'ppcre:regex-replace)
CL-USER> (regex-replace …)
~~~

### すべての symbol を import する

別の package から何を import するかを注意深く選ぶほうがよい practice ですが (下を読んでください)、`:use` ですべての symbol を一度に import することもできます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

これで、`cl-ppcre` から export されたすべての variable、function、macro に、あなたの `my-package` package から access できます。

`use-package` function を使うこともできます。

~~~lisp
CL-USER> (use-package 'cl-ppcre)
~~~

その対になる、`use-package` の import を取り消すものは… `unuse-package` です。


### package を "use" することが bad practice とされる理由

`:use` は広く使われている idiom です。次のように書けます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

すると、`cl-ppcre` (別名 `ppcre`) から export された **すべての** symbol が、あなたの package で直接使えるようになります。しかし、自分が control している project 内の別 package を `use` する場合を除き、これは bad practice と考えるべきです。実際、external package が symbol を追加すると、あなたの symbol と衝突する可能性があります。あるいは、あなたが追加した symbol が external symbol を隠し、warning に気づかないかもしれません。

[この詳しい説明](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) (読むことをおすすめします) を引用すると、要旨は次のとおりです。

> 現代の code では、USE は完全に control している internal package を除いて悪い考えです。internal package では、別 package の symbol を変更しながら新しい DEFUN を作っていることを忘れるまでは、それなりに筋が通ります。USE があるため、Alexandria は今日では自分自身に新しい symbol を追加することすらできません。それは、外部 source 由来の同じ名前の symbol をすでに持つ別 package と name collision を起こすかもしれないからです。


## Package 内のすべての Symbol を list する (do-external-symbols)

Common Lisp は、package の symbol を反復するための macro をいくつか提供します。特に興味深いものは
[`DO-SYMBOLS` と `DO-EXTERNAL-SYMBOLS`][do-sym] です。`DO-SYMBOLS` は package から access 可能な symbol を反復し、`DO-EXTERNAL-SYMBOLS` は external symbol だけを反復します (これらは実質的な package API と見なせます)。

"PACKAGE" という名前の package の export 済み symbol をすべて print するには、次のように書けます。

~~~lisp
(do-external-symbols (s (find-package "PACKAGE"))
  (print s))
~~~

これらの symbol をすべて list に集めることもできます。

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

import した package に local name を与えると、typing を減らせて便利なことがあります。特に、import した package がよい global nickname を提供していない場合です。

多くの implementation (SBCL, CCL, ECL, Clasp, ABCL, ACL, LispWorks >= 7.2…) は Package Local Nicknames (PLN) を support しています。


PLN を使うには、たとえば ad-hoc に local nickname を試したい場合、単に次のようにできます。

~~~lisp
(uiop:add-package-local-nickname :a :alexandria)
(a:iota 12) ; (0 1 2 3 4 5 6 7 8 9 10 11)
~~~

`defpackage` form 内で PLN を設定することもできます。PLN の効果は完全に `mypackage` 内に限られます。つまり、`nickname` は、そこでも定義されていない限り他の package では動きません。そのため、他の library で意図しない package name clash が起きる心配はありません。

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

package に nickname を追加する別の機能もあります。function [`RENAME-PACKAGE`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm) を使うと、package の name と nickname を置き換えられます。しかし、それを使うと、他の library が元の name や nickname でその package に access できなくなるかもしれません。これを使う場面はほとんどありません。代わりに Package Local Nicknames を使ってください。

### Package が提供する nickname

package を定義するとき、user experience を良くするために nickname を与えるのは簡単です。しかしこの mechanism は *global* です。ここで定義した nickname は、どこにある他のすべての package からも見えます。よく使う package に短い name を与えようとしていたなら、別の package と conflict する可能性があります。だからこそ *package-local* nickname が現れました。代わりにそれを使うべきです。

とはいえ、`prove` package からの例を示します。

~~~lisp
(defpackage prove
  (:nicknames :cl-test-more :test-more)
  (:export #:run
           #:is
           #:ok)
~~~

その後、user は package name の代わりに nickname を使ってこの package を参照できます。例:

~~~lisp
(prove:run)
(cl-test-more:is)
(test-more:ok)
~~~

Common Lisp は 1 つの package に複数の nickname を定義することを許していますが、nickname が多すぎると user にとって保守の複雑さが増える可能性があります。したがって nickname は意味があり、わかりやすいものにするべきです。例:

~~~lisp
(defpackage #:iterate
  (:nicknames #:iter))

(defpackage :cl-ppcre
  (:nicknames :ppcre)
~~~


### Package locks

package `common-lisp` と SBCL internal implementation package は、`sb-ext` を含め、default で lock されています。

加えて、user-defined package も lock されるよう宣言でき、その場合 user は変更できません。symbol table を変更したり、その symbol が名前を付けている function を redefine しようとすると error になります。

より詳しい情報は [SBCL][sbcl-package-lock] と [CLisp][clisp-package-lock] の document から得られます。

たとえば、次の code を試すとします。

~~~lisp
(asdf:load-system :alexandria)
(rename-package :alexandria :alex)
~~~

次の error が出ます (SBCL の場合)。

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

それでも変更が必要な場合は、[cl-package-lock][cl-package-lock] という package を使って package lock を無視できます。例:

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
