---
title: Web Scraping
---

Common Lisp で web scraping を行うための道具立てはかなり揃っており、使っていて快適です。この短い tutorial では、http request を行い、html を parse し、content を抽出し、非同期 request を行う方法を見ます。

ここでの単純な課題は、CL Cookbook の index page にある link の一覧を抽出し、それらに到達できるか確認することです。

次の library を使います。

- [Dexador](https://github.com/fukamachi/dexador) - HTTP client
  (由緒ある Drakma を置き換えることを目指しています)。
- [Plump](https://shinmera.github.io/plump/) - 壊れた HTML にも対応する markup parser。
- [Lquery](https://shinmera.github.io/lquery/) - Plump の結果から content を抽出するための DOM 操作
  library。
- [lparallel](https://lparallel.org/pmap-family/) - parallel programming 用 library (詳しくは [process section](process.html) を読んでください)。

始める前に、Quicklisp でこれらの library を install しましょう。

~~~lisp
(ql:quickload '("dexador" "plump" "lquery" "lparallel"))
~~~

## HTTP Requests

まずは簡単なことからです。Dexador を install します。そして `get` function を使います。

~~~lisp
(defvar *url* "https://lispcookbook.github.io/cl-cookbook/")
(defvar *request* (dex:get *url*))
~~~

これは複数の値を返します。page content 全体、return code
(200)、response header、uri、stream です。

```
"<!DOCTYPE html>
 <html lang=\"en\">
  <head>
    <title>Home &ndash; the Common Lisp Cookbook</title>
    […]
    "
200
#<HASH-TABLE :TEST EQUAL :COUNT 19 {1008BF3043}>
#<QURI.URI.HTTP:URI-HTTPS https://lispcookbook.github.io/cl-cookbook/>
#<CL+SSL::SSL-STREAM for #<FD-STREAM for "socket 192.168.0.23:34897, peer: 151.101.120.133:443" {100781C133}>>

```

思い出してください。Slime では object を右クリックして inspect できます。

## CSS selector で parse し、content を抽出する

html を parse して content を抽出するために `lquery` を使います。

- [https://shinmera.github.io/lquery/](https://shinmera.github.io/lquery/)

まず html を内部 data structure へ parse する必要があります。
`(lquery:$ (initialize <html>))` を使います。

~~~lisp
(defvar *parsed-content* (lquery:$ (initialize *request*)))
;; => #<PLUMP-DOM:ROOT {1009EE5FE3}>
~~~

lquery は内部で [Plump](https://shinmera.github.io/plump/) を使います。

次に CSS selector で link を抽出します。

__Note__: 関心のある element の CSS selector を知るには、browser でその element を右クリックし、"Inspect element" を選びます。すると browser の web dev tool の inspector が開き、page structure を調べられます。

抽出したい link は、`id` が "content" の page 内にあり、通常の list element (`li`) に含まれています。

試してみましょう。

~~~lisp
(lquery:$ *parsed-content* "#content li")
;; => #(#<PLUMP-DOM:ELEMENT li {100B3263A3}> #<PLUMP-DOM:ELEMENT li {100B3263E3}>
;;  #<PLUMP-DOM:ELEMENT li {100B326423}> #<PLUMP-DOM:ELEMENT li {100B326463}>
;;  #<PLUMP-DOM:ELEMENT li {100B3264A3}> #<PLUMP-DOM:ELEMENT li {100B3264E3}>
;;  #<PLUMP-DOM:ELEMENT li {100B326523}> #<PLUMP-DOM:ELEMENT li {100B326563}>
;;  #<PLUMP-DOM:ELEMENT li {100B3265A3}> #<PLUMP-DOM:ELEMENT li {100B3265E3}>
;;  #<PLUMP-DOM:ELEMENT li {100B326623}> #<PLUMP-DOM:ELEMENT li {100B326663}>
;;  […]
~~~

うまく動きました。ここでは plump element の vector が得られます。

これらの element が何であるかを簡単に確認したいところです。html 全体を見るには、lquery の行を `(serialize)` で終えます。

~~~lisp
(lquery:$  *parsed-content* "#content li" (serialize))
#("<li><a href=\"license.html\">License</a></li>"
  "<li><a href=\"getting-started.html\">Getting started</a></li>"
  "<li><a href=\"editor-support.html\">Editor support</a></li>"
  […]
~~~

また、その *textual* content (html 内で user に見える text) を見るには、代わりに `(text)` を使えます。

~~~lisp
(lquery:$  *parsed-content* "#content" (text))
#("License" "Editor support" "Strings" "Dates and Times" "Hash Tables"
  "Pattern Matching / Regular Expressions" "Functions" "Loop" "Input/Output"
  "Files and Directories" "Packages" "Macros and Backquote"
  "CLOS (the Common Lisp Object System)" "Sockets" "Interfacing with your OS"
  "Foreign Function Interfaces" "Threads" "Defining Systems"
  […]
  "Pascal Costanza’s Highly Opinionated Guide to Lisp"
  "Loving Lisp - the Savy Programmer’s Secret Weapon by Mark Watson"
  "FranzInc, a company selling Common Lisp and Graph Database solutions.")
~~~

よさそうです。必要なものを操作できていることがわかります。次に `href` を取得するには、lquery の doc を少し見れば `(attr
"some-name")` を使えばよいことがわかります。


~~~lisp
(lquery:$  *parsed-content* "#content li a" (attr :href))
;; => #("license.html" "editor-support.html" "strings.html" "dates_and_times.html"
;;  "hashes.html" "pattern_matching.html" "functions.html" "loop.html" "io.html"
;;  "files.html" "packages.html" "macros.html"
;;  "/cl-cookbook/clos-tutorial/index.html" "os.html" "ffi.html"
;;  "process.html" "systems.html" "win32.html" "testing.html" "misc.html"
;;  […]
;;  "http://www.nicklevine.org/declarative/lectures/"
;;  "http://www.p-cos.net/lisp/guide.html" "https://leanpub.com/lovinglisp/"
;;  "https://franz.com/")
~~~

*Note*: `attr` の後に `(serialize)` を使うと error になります。

これで page の link の list (正確には vector) が得られました。次に、それらに到達できるかを確認して検証する async program を書きます。

外部 resource:

- [CSS selectors](https://developer.mozilla.org/en-US/docs/Glossary/CSS_Selector)

## Async requests

この例では、上で得た url の list を取り、それらに到達できるか確認します。これは非同期で行いたいのですが、利点を見るために、まず同期的に実行します。

まず email address を除外するために少し filter する必要があります (CSS selector でできたかもしれません)。

url の vector を variable に入れます。

~~~lisp
(defvar *urls* (lquery:$  *parsed-content* "#content li a" (attr :href)))
~~~

"mailto:" で始まる element を削除します ([strings](strings.html) page を少し見ると助けになります)。

~~~lisp
(remove-if (lambda (it)
              (string= it "mailto:" :start1 0
                                    :end1 (length "mailto:")))
           *urls*)
;; => #("license.html" "editor-support.html" "strings.html" "dates_and_times.html"
;;  […]
;;  "process.html" "systems.html" "win32.html" "testing.html" "misc.html"
;;  "license.html" "http://lisp-lang.org/"
;;  "https://github.com/CodyReichert/awesome-cl"
;;  "http://www.lispworks.com/documentation/HyperSpec/Front/index.htm"
;;  […]
;;  "https://franz.com/")
~~~

実際には、任意の sequence (vector を含む) に対して動く `remove-if` を書く前に、結果が実際に `nil` または `t` になることを確認するため、`(map 'vector …)` で試しました。

余談ですが、Quicklisp で利用できる "str" library には便利な `starts-with-p` function があります。したがって次のようにも書けます。

~~~lisp
(map 'vector (lambda (it)
                (str:starts-with-p "mailto:" it))
             *urls*)
~~~

ついでに、web scraping に関係ない内容をあまり書きすぎないよう、"http" で始まる link だけを対象にします。

~~~lisp
(remove-if-not (lambda (it)
                 (string= it "http" :start1 0 :end1 (length "http")))
               *)
~~~

よし、この結果を別の variable に入れます。

~~~lisp
(defvar *filtered-urls* *)
~~~

ここから本題です。各 url について request し、return code が 200 であることを確認します。特定の error は無視しなければなりません。実際、request は timeout することも、redirect されることも (これは望みません)、error code を返すこともあります。

実際に近い条件にするため、timeout する link を list に追加します。

~~~lisp
(setf (aref *filtered-urls* 0) "http://lisp.org")  ;; :/
~~~

error を無視し、その場合は `nil` を返す単純な方法を取ります。すべてうまくいけば、200 であるはずの return code を返します。

冒頭で見たように、`dex:get` は return code を含む多くの値を返します。ここでは `multiple-value-bind` で全てを受け取る代わりに、`nth-value` でこの値だけに access します。また、error の場合に nil を返す `ignore-errors` を使います。`handler-case` を使って specific error type を扱うこともできます (dexador の documentation の例を参照してください)。

(*ignore-errors には、error が起きたとき、それがどの element から来たのかを返せないという注意点があります。それでもここでの目的は達成できます。*)


~~~lisp
(map 'vector (lambda (it)
  (ignore-errors
    (nth-value 1 (dex:get it))))
  *filtered-urls*)
~~~

次が得られます。

```
#(NIL 200 200 200 200 200 200 200 200 200 200 NIL 200 200 200 200 200 200 200
  200 200 200 200)
```

動きますが、*非常に長い時間がかかりました*。正確にはどれくらいでしょうか。`(time …)` で測ります。

```
Evaluation took:
  21.554 seconds of real time
  0.188000 seconds of total run time (0.172000 user, 0.016000 system)
  0.87% CPU
  55,912,081,589 processor cycles
  9,279,664 bytes consed
```

21 秒です。明らかにこの同期 method は効率的ではありません。timeout する link に 10 秒待っています。async version を書いて測定する時です。

`lparallel` を install し、[その documentation](https://lparallel.org/) を見たところ、parallel map の [pmap](https://lparallel.org/pmap-family/) が欲しいものに見えます。しかも変更は一語だけです。試してみましょう。

~~~lisp
(time (lparallel:pmap 'vector
  (lambda (it)
    (ignore-errors
      (let ((status (nth-value 1 (dex:get it)))) status)))
  *filtered-urls*)
;;  Evaluation took:
;;  11.584 seconds of real time
;;  0.156000 seconds of total run time (0.136000 user, 0.020000 system)
;;  1.35% CPU
;;  30,050,475,879 processor cycles
;;  7,241,616 bytes consed
;;
;;#(NIL 200 200 200 200 200 200 200 200 200 200 NIL 200 200 200 200 200 200 200
;;  200 200 200 200)
~~~

やりました。timeout する request を 1 つ 10 秒待つため、まだ 10 秒以上かかっています。しかしそれ以外では http request がすべて parallel に進むため、ずっと高速です。

到達できない url を取得し、それらを list から削除し、sync と async の場合の実行時間を測ってみましょうか。

行うことは、return code だけを返す代わりに、それが valid かを確認して url を返すことです。

~~~lisp
... (if (and status (= 200 status)) it) ...
(defvar *valid-urls* *)
~~~

いくつかの `nil` を含む url の vector が得られます。実のところ、到達できない url は 1 つだけだと思っていたのですが、もう 1 つ発見しました。あなたがこの tutorial を試す前に、修正を push できていることを願います。

では、それらは何でしょうか。status code は見ましたが url は見ていません。すべての url の vector と、valid なものの vector があります。単純にそれらを set として扱い、差分を計算します。これで悪いものがわかります。そのためには vector を list に変換する必要があります。

~~~lisp
(set-difference (coerce *filtered-urls* 'list)
                (coerce *valid-urls* 'list))
;; => ("http://lisp-lang.org/" "http://www.psg.com/~dlamkins/sl/cover.html")
~~~

見つかりました。

ちなみに、valid url の list を同期的に確認するには、私の環境では real time で 8.280 秒かかり、async では 2.857 秒でした。

CL での web scraping を楽しんでください。


さらに役立つ library:

- [VCR](https://github.com/tsikov/vcr) を使うと、repeatable test を設定したり、REPL での experiment を少し高速化するための store and replay utility として使えます。
- [cl-async](https://github.com/orthecreedence/cl-async)、
  [carrier](https://github.com/orthecreedence/carrier)、およびその他の
  network、parallelism、concurrency library は
  [awesome-cl](https://github.com/CodyReichert/awesome-cl) list、
  [Cliki](http://www.cliki.net/)、または
  [Quickdocs](https://quickdocs.org/-/search?q=web) で探せます。
