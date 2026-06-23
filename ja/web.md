---
title: Web 開発
---


Web 開発でも他の作業でも、Common Lisp の利点を活かせます。比類のない REPL は、動いている Web アプリと対話するのにも役立ちます。例外処理、性能、自己完結型実行ファイルを作れること、安定性、スレッドの扱い、強い型付けなどもあります。たとえば新しいルートを定義してすぐ試せます。動いているサーバーを再起動する必要はありません。*1 関数ずつ* 変更してコンパイルし（Slime ならおなじみの `C-c C-c`）、試せます。フィードバックは即座です。対話性の度合いも選べます。Web サーバーに例外処理を任せず対話デバッガを起動させることも、例外を処理してブラウザに Lisp のバックトレースを出すことも、404 エラーページを表示し標準出力にログを出すこともできます。自己完結型実行ファイルを作れるので、たとえば npm ベースのアプリに比べてデプロイは非常に楽です。実行ファイルをサーバーにコピーして実行するだけだからです。

アプリをデプロイしたあとでも、引き続き対話できます。依存関係のインストールが必要なときでもホットリロードが使えます。完全なライブリロードは使いたくない慎重な場面でも、たとえば利用者の設定ファイルをリロードする、といった用途にはこの能力が役立ちます。

ここでは、Web アプリ開発を始める助けとして、実績のある Web フレームワークと一般的なライブラリを紹介します。網羅を目指してはいませんし、上流のドキュメントの代わりにもなりません。フィードバックや貢献は歓迎します。

<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px;">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>INFO:</strong> Common Lisp の Web 開発に特化した新しいサイトがあります: <a href="https://web-apps-in-lisp.github.io/">Web Apps in Lisp, Know-how</a> (<a href="https://github.com/web-apps-in-lisp/web-apps-in-lisp.github.io/">sources</a>).
</div>


<!-- form creation, form validation -->

<!-- Javascript -->

## 概要

[Hunchentoot][hunchentoot] と [Clack][clack] は、よく耳にする 2 つのプロジェクトです。

Hunchentoot は次のようなものです。

> 動的なウェブサイトを構築するためのツールキットであり、同時に web サーバーでもあります。単体の web サーバーとして、Hunchentoot は HTTP/1.1 の chunking（両方向）、persistent connection（keep-alive）、SSL に対応しています。自動のセッション管理（cookie あり／なし）、ロギング、カスタマイズ可能なエラー処理、クライアントが送る GET/POST パラメータへの簡単なアクセスなども提供します。

これは Edi Weitz によるソフトウェアです（"Common Lisp Recipes"、`cl-ppcre`、そして [そのほか多数](https://edicl.github.io/)）。実績があり、堅牢です。これだけで多くのことができますが、従来型の Web フレームワークより摩擦が大きいこともあります。たとえば HTTP メソッドでルートを振り分けるのは少し面倒で、Caveman のような他のフレームワークでは組み込みのキーワードで済むところを、`:uri` 引数のための関数を書いて判定しなければなりません。

Clack は次のようなものです。

> Python の WSGI と Ruby の Rack に触発された、Common Lisp 向けの web アプリケーション環境です。

こちらも多作な lisper である [E. Fukamachi](https://github.com/fukamachi/) によるものです。実際には既定のサーバーとして Hunchentoot を使いますが、差し替え可能なアーキテクチャにより、非同期の [Woo](https://github.com/fukamachi/woo) のような別の web サーバーも使えます。Woo は [libev](http://software.schmorp.de/pkg/libev.html) のイベントループ上に構築されており、おそらく「あらゆるプログラミング言語の中で最速の web サーバー」でしょう。

さらに、非同期 HTTP サーバーの [Wookie](https://github.com/orthecreedence/wookie) と、その姉妹ライブラリである [cl-async](https://github.com/orthecreedence/cl-async) もあります。cl-async は、Node.js のバックエンドライブラリである libuv 上で動く、Common Lisp の汎用ノンブロッキングプログラミング向けライブラリです。

Clack は比較的新しくドキュメントも少なめで、Hunchentoot は事実上の標準です。そのため、このレシピでは後者に絞ります。もちろん貢献は歓迎です。

Web フレームワークは web サーバーの上に成り立ち、テンプレートシステム、データベースへのアクセス、セッション管理、REST API を組み立てる仕組みなど、Web 開発でよく使う機能を提供できます。

いくつかの web framework を挙げます。

- [Caveman][caveman] は E. Fukamachi によるものです。最初から、データベース管理、テンプレートエンジン（Djula）、プロジェクトのひな形生成、Flask や Sinatra 風のルーティングシステム、デプロイのオプション（mod_lisp または FastCGI）、コマンドラインからの Roswell サポートなどを備えています。
- [Radiance][radiance] は [Shinmera](https://github.com/Shinmera)（Qtools、Portacle、lquery など）による web アプリケーション環境で、通常の Web フレームワークより一般的です。ウェブサイトとアプリケーションをまとめて書けるので、全体としてのデプロイが楽になります。充実した [ドキュメント](https://shirakumo.github.io/radiance/)、[チュートリアル](https://github.com/Shirakumo/radiance-tutorial)、[モジュール](https://github.com/Shirakumo/radiance-contribs)、[画像掲示板](https://github.com/Shirakumo/purplish) や [ブログプラットフォーム](https://github.com/Shirakumo/reader) のような [事前作成済みアプリケーション](https://github.com/Shirakumo?utf8=%E2%9C%93&q=radiance&type=&language=) などがあります。例として [https://shinmera.com/](https://shinmera.com/)、[reader.tymoon.eu](https://reader.tymoon.eu/)、[events.tymoon.eu](https://events.tymoon.eu/) を見てください。
- [Snooze][snooze] は João Távora（Sly、Emacs の Yasnippet、Eglot など）によるもので、「REST ウェブサービスを中心に設計された URL ルーター」です。Snooze ではルートは単なる関数で、HTTP コンディションも単なる Lisp コンディションです。
- [cl-rest-server][cl-rest-server] は REST の web API を書くためのライブラリです。スキーマによる検証、ロギング用のアノテーション、キャッシュ、権限や認証、OpenAPI（Swagger）によるドキュメントなどを備えています。
- 最後に [Weblocks][weblocks] です。これは古くからある Common Lisp の Web フレームワークで、JavaScript を書かずに、また JavaScript にトランスパイルする Lisp を書かずに、ajax ベースの動的な web アプリケーションを書けます。2017 年以降、大規模な書き直しと更新が進んでいます。詳しくは後で見ます。

Web 向けライブラリの完全な一覧は、[awesome-cl の #network-and-internet](https://github.com/CodyReichert/awesome-cl#network-and-internet) と [Cliki](https://www.cliki.net/Web) を参照してください。多機能な静的サイトジェネレータを探しているなら [Coleslaw](https://github.com/coleslaw-org/coleslaw) を見てください。


## インストール

使うライブラリをインストールします。

~~~lisp
(ql:quickload '("hunchentoot" "caveman2" "spinneret"
                "djula" "easy-routes"))
~~~

Weblocks を試すには、そのドキュメントを参照してください。執筆時点の Quicklisp の Weblocks は、ここで扱いたいものではまだありません。

まずはローカルファイルを配信し、実行中のイメージで複数のローカルサーバーを動かします。

## シンプルな web サーバー

### ローカルファイルを配信する

#### Hunchentoot

次のように web サーバーを作成して起動します。

~~~lisp
(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor
                                  :port 4242))
(hunchentoot:start *acceptor*)
~~~

ポート 4242 に `easy-acceptor` のインスタンスを作って起動しています。これで [http://127.0.0.1:4242/](http://127.0.0.1:4242/) にアクセスできます。ドキュメントへのリンク付きのウェルカム画面が出て、コンソールにログが出るはずです。

既定では、Hunchentoot はソースツリーの `www/` ディレクトリからファイルを配信します。したがって、`easy-acceptor` のソース（Slime なら `M-.`）へ行くと、おそらく `~/quicklisp/dists/quicklisp/software/hunchentoot-v1.2.38/` にあり、そこに `www/` ディレクトリが見つかります。内容は次のとおりです。

- `errors/` ディレクトリ。エラーテンプレート `404.html` と `500.html` が入っています
- `img/` ディレクトリ
- `index.html` ファイル

別のディレクトリを配信したいなら、`easy-acceptor` に `:document-root` オプションを渡します。アクセサでスロットを設定することもできます。

~~~lisp
(setf (hunchentoot:acceptor-document-root *acceptor*)
      #p"path/to/www")
~~~

まず `index.html` を作りましょう。現在のディレクトリ（Lisp REPL の場所）に新しい `www/index.html` を作って、次を入れます。

~~~html
<html>
  <head>
    <title>Hello!</title>
  </head>
  <body>
    <h1>Hello local server!</h1>
    <p>
    We just served our own files.
    </p>
  </body>
</html>
~~~

別のポートで新しい acceptor を起動してみましょう。

~~~lisp
(defvar *my-acceptor* (make-instance 'hunchentoot:easy-acceptor
                                     :port 4444
                                     :document-root #p"www/"))
(hunchentoot:start *my-acceptor*)
~~~

[http://127.0.0.1:4444/](http://127.0.0.1:4444/) に行って違いを見てください。

同じ Lisp イメージの中に、別ポートの別 acceptor を作ったことに注意してください。これはもう十分に便利です。


<a id="server-"></a>

## インターネットからサーバーにアクセスする

### Hunchentoot

Hunchentoot なら特別なことは不要で、すぐにインターネットからサーバーを見られます。

VPS 上で次を評価すると、

    (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))

サーバーの IP ですぐに見えます。

止めるには `(hunchentoot:stop *)` を使います。

## ルーティング

### シンプルなルート

#### Hunchentoot

既存の関数をルートに結び付けるには、"prefix dispatch" を作って `*dispatch-table*` リストに push します。

~~~lisp
(defun hello ()
   (format nil "Hello, it works!"))

(push
  (hunchentoot:create-prefix-dispatcher "/hello.html" #'hello)
  hunchentoot:*dispatch-table*)
~~~

正規表現を使ったルートを作るには `create-regex-dispatcher` を使います。url-as-regexp には文字列、S 式、または cl-ppcre のスキャナを渡せます。

まだなら acceptor を作ってサーバーを起動してください。

~~~lisp
(defvar *server* (make-instance 'hunchentoot:easy-acceptor :port 4242))
(hunchentoot:start *server*)
~~~

[http://localhost:4242/hello.html](http://localhost:4242/hello.html) にアクセスします。

ログは REPL で確認できます。

```
127.0.0.1 - [2018-10-27 23:50:09] "get / http/1.1" 200 393 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0"
127.0.0.1 - [2018-10-27 23:50:10] "get /img/made-with-lisp-logo.jpg http/1.1" 200 12583 "http://localhost:4242/" "Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0"
127.0.0.1 - [2018-10-27 23:50:10] "get /favicon.ico http/1.1" 200 1406 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0"
127.0.0.1 - [2018-10-27 23:50:19] "get /hello.html http/1.1" 200 20 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0"
```

---

[define-easy-handler](https://edicl.github.io/hunchentoot/#define-easy-handler) を使うと、関数の作成と URI への束縛を一度に行えます。

形式は次のとおりです。

    define-easy-handler (function-name :uri <uri> …) (lambda list parameters)

ここで `<uri>` は文字列でも関数でもかまいません。

例:

~~~lisp
(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))
~~~

[http://localhost:4242/yo](http://localhost:4242/yo) にアクセスし、URL にパラメータを付けてみてください:
[http://localhost:4242/yo?name=Alice](http://localhost:4242/yo?name=Alice)。

ちょっと考えてみましょう。私たちは、このルートをポート 4242 の最初のアクセプタに追加するよう Hunchentoot に明示的に指示したわけではありません。別のアクセプタ（前節を参照）をポート 4444 で試してみましょう: [http://localhost:4444/yo?name=Bob](http://localhost:4444/yo?name=Bob)。これも動きます！ 実は `define-easy-handler` は `acceptor-names` パラメータを受け取ります。

> acceptor-names（これは評価されます）はシンボルのリストにでき、その場合ハンドラはそれらの名前のいずれかを持つアクセプタ内の DISPATCH-EASY-HANDLERS からのみ返されます（ACCEPTOR-NAME を参照）。acceptor-names はシンボル T にもでき、その場合ハンドラはすべてのアクセプタの DISPATCH-EASY-HANDLERS から返されます。


つまり `define-easy-handler` のシグネチャは次のとおりです。

    define-easy-handler (function-name &key uri acceptor-names default-request-type) (lambda list parameters)

また `default-parameter-type` もあり、これは後ほど URL パラメータを取得するために使います。

lambda list について知っておくべきキーもあります。ドキュメントを参照してください。


#### Easy-routes (Hunchentoot)

[easy-routes](https://github.com/mmontone/easy-routes) は Hunchentoot の上に乗るルート処理の拡張です。提供するものは次のとおりです。

- GET や POST のような HTTP メソッドに基づく **振り分け**（Hunchentoot ではこれが面倒です）
- URL のパスからの **引数の取り出し**
- **デコレータ**（ルート本体の前に実行する関数。通常は認証層の追加や、返すコンテンツタイプの変更に使います）
- ルート名と与えた URL パラメータからの **URL 生成**
- ルートの可視化
- その他いろいろ

使うときは、サーバーを `hunchentoot:easy-acceptor` ではなく `easy-routes:easy-routes-acceptor` で作ります。

~~~lisp
(setf *server* (make-instance 'easy-routes:easy-routes-acceptor))
~~~

補足: `routes-acceptor` もあります。違いは、`easy-routes-acceptor` は easy-routes でルートが見つからなかった場合に Hunchentoot の `*dispatch-table*` を順に見ていくことです。これにより、たとえば静的コンテンツを Hunchentoot の通常方式で配信できます。

ルートは次のように定義します。

~~~lisp
(easy-routes:defroute my-route-name ("/foo/:x" :method :get) (y &get z)
    (format nil "x: ~a y: ~a z: ~a" x y z))
~~~

ルートのシグネチャは 2 つの部分から成ります。

    ("/foo/:x" :method :get) (y &get z)

ここで `:x` はパスのパラメータを捕捉し、ルート本体の `x` 変数に束縛します。`y` と `&get z` は URL パラメータを定義し、HTTP リクエストボディから取り出す `&post` パラメータも使えます。

これらのパラメータには、`define-easy-handler` と同じく `:init-form` と `:parameter-type` オプションを指定できます。

では、Web アプリのロジックのもっと奥で、利用者を "/foo/3" へリダイレクトしたいとしましょう。URL を直書きする代わりに、**ルート名から URL を生成** できます。`easy-routes:genurl` を次のように使います。

~~~lisp
(easy-routes:genurl 'my-route-name :id 3)
;; => /foo/3

(easy-routes:genurl 'my-route-name :id 3 :y "yay")
;; => /foo/3?y=yay
~~~

**デコレータ**はルート本体の前に実行される関数です。装飾チェーンとルート本体の実行を続けるために、`next` 引数の関数を呼ぶ必要があります。例を示します。

~~~lisp
(defun @auth (next)
  (let ((*user* (hunchentoot:session-value 'user)))
    (if (not *user*)
	(hunchentoot:redirect "/login")
	(funcall next))))

(defun @html (next)
  (setf (hunchentoot:content-type*) "text/html")
  (funcall next))

(defun @json (next)
  (setf (hunchentoot:content-type*) "application/json")
  (funcall next))
(defun @db (next)
  (postmodern:with-connection *db-spec*
    (funcall next)))
~~~

詳しくは `easy-routes` の README を参照してください。

#### Caveman

[Caveman](caveman) にはルートを定義する 2 つの方法があります。`defroute` マクロと、Python 風の *アノテーション* である `@route` です。

~~~lisp
(defroute "/welcome" (&key (|name| "Guest"))
  (format nil "Welcome, ~A" |name|))

@route GET "/welcome"
(lambda (&key (|name| "Guest"))
  (format nil "Welcome, ~A" |name|))
~~~

URL パラメータを持つルートです（URL 内の `:name` に注意）。

~~~lisp
(defroute "/hello/:name" (&key name)
  (format nil "Hello, ~A" name))
~~~

「ワイルドカード」パラメータを定義することもできます。`splat` キーを使います。

~~~lisp
(defroute "/say/*/to/*" (&key splat)
  ; matches /say/hello/to/world
  (format nil "~A" splat))
;=> (hello world)
~~~

正規表現を有効にするには `:regexp t` を付けます。

~~~lisp
(defroute ("/hello/([\\w]+)" :regexp t) (&key captures)
  (format nil "Hello, ~A!" (first captures)))
~~~


<a id="get--post-parameter-"></a>

### GET と POST パラメータにアクセスする

#### Hunchentoot

まず、クエリパラメータはいつでも次のようにアクセスできます。

~~~lisp
(hunchentoot:parameter "my-param")
~~~

これは、すべてのハンドラに渡される既定の `*request*` オブジェクトに対して動作します。

`get-parameter` と `post-parameter` もあります。


先ほど `define-easy-handler` のいくつかのキーワードパラメータを見ました。ここでは `default-parameter-type` を導入します。

次のハンドラを定義しました。

~~~lisp
(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))
~~~

`name` 変数は既定で文字列です。確認してみましょう。

~~~lisp
(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~] you are of type ~a" name (type-of name)))
~~~

[http://localhost:4242/yo?name=Alice](http://localhost:4242/yo?name=Alice) に行くと、次が返ります。

    Hey Alice you are of type (SIMPLE-ARRAY CHARACTER (5))

別の型へ自動的に束縛するには `default-parameter-type` を使います。次の単純型のどれかを指定できます。

* `'string`（デフォルト）
* `'integer`
* `'character`（長さ 1 の文字列のみ受け付け、それ以外は nil になります）
* または `'boolean`

または複合リストです。

- `'(:list <type>)`
- `'(:array <type>)`
- `'(:hash-table <type>)`

ここで `<type>` は単純型です。

### JSON のリクエストボディにアクセスする

#### Hunchentoot

リクエスト本体を読むには `hunchentoot:raw-post-data` を使います。`:force-text t` を付けると、オクテットのベクトルではなく常に文字列を得られます。

それから、この文字列を好きな JSON ライブラリ（[jzon](https://github.com/Zulu-Inuoe/jzon/)、[shasht](https://github.com/yitzchak/shasht) など）で解析できます。

~~~lisp
(easy-routes route-api-demo ("/api/:id/update" :method :post) ()
   (let ((json (ignore-errors
                (jzon:parse (hunchentoot:raw-post-data :force-text t)))))
     (when json
        …)))
~~~


<!-- ## Sessions -->

<!-- todo ? -->

<!-- ## Cookies -->

## エラー処理

どのフレームワークでも、対話性の度合いは選べます。Web フレームワークは 404 ページを返して REPL に出力を出すこともできますし、対話 Lisp デバッガを起動することも、エラーを処理して HTML ページに Lisp のバックトレースを表示することもできます。

### Hunchentoot

エラー処理の挙動を選ぶには、次のグローバル変数を設定します。

- `*catch-errors-p*`: 未処理のエラーで対話デバッガを起動したいなら `nil` にします（もちろん開発時だけです）。

~~~lisp
(setf hunchentoot:*catch-errors-p* nil)
~~~

この挙動を細かく調整したいなら、汎用関数 `maybe-invoke-debugger` も参照してください。デバッグのために、特定のコンディションクラスに対して特化したくなるかもしれません（後述）。

- `*show-lisp-errors-p*`: ブラウザの HTML 出力にエラーを表示したいなら `t` にします。
- `*show-lisp-backtraces-p*`: HTML 出力で表示するエラー（`*show-lisp-errors-p*` が `t` のとき）にバックトレース情報を *含めたくない* なら `nil` にします（既定値は `t`、バックトレースを表示します）。

Hunchentoot にはコンディションクラスがあります。すべてのコンディションの上位クラスは `hunchentoot-condition` です。エラーの上位クラスは `hunchentoot-error` で、これは `hunchentoot-condition` の下位クラスです。

ドキュメントも参照してください: [https://edicl.github.io/hunchentoot/#conditions](https://edicl.github.io/hunchentoot/#conditions)


### Clack

Clack を使うなら、clack-errors のようなミドルウェアのプラグインが役立つでしょう: [https://github.com/CodyReichert/awesome-cl#clack-plugins](https://github.com/CodyReichert/awesome-cl#clack-plugins)

<img src="assets/clack-errors.png" width="800" alt="The clack-errors plugin shows the error message, a legible backtrace and environment variables."/>

<!-- pdf-include-start
![](assets/clack-errors.png)
   pdf-include-end -->

## Weblocks - "JavaScript 問題" を解く ©

[Weblocks][weblocks] は、ウィジェットベースでサーバーベースのフレームワークで、組み込みの ajax 更新機構を持っています。JavaScript を書かずに、また JavaScript にトランスパイルされる Lisp コードを書かずに、動的な web アプリケーションを書けます。

![](assets/weblocks-quickstart-check-task.gif)

Weblocks は、Slava Akhmechet、Stephen Compall、Leslie Polzer によって開発された古いフレームワークです。しばらく落ち着いたあと、Alexander Artemenko による非常に活発な更新、リファクタリング、書き直しが進んでいます。

もともとは継続（continuation）ベースでした（現在は除去されています）。そのため、Smalltalk の [Seaside](https://en.wikipedia.org/wiki/Seaside_(software)) の Lisp 版とも言えます。Haskell の Haste、OCaml の Eliom、Elixir の Phoenix LiveView などとも比較できます。

[Ultralisp](http://ultralisp.org/) のウェブサイトは、CL コミュニティで知られる本番運用中の Weblocks サイトの例です。

---

Weblocks の作業単位は *ウィジェット* です。見た目はクラス定義のようです。

~~~lisp
(defwidget task ()
   ((title
     :initarg :title
     :accessor title)
    (done
     :initarg :done
     :initform nil
     :accessor done)))
~~~

あとは、このウィジェットに対する `render` メソッドを定義するだけです。

~~~lisp
(defmethod render ((task task))
  "Render a task."
  (with-html
        (:span (if (done task)
                   (with-html
                         (:s (title task)))
                 (title task)))))
~~~

既定では Spinneret のテンプレートエンジンを使いますが、好きな別のものを束縛することもできます。

ajax イベントを起こすには、完全な Common Lisp で lambda を書きます。

~~~lisp
...
(with-html
  (:p (:input :type "checkbox"
    :checked (done task)
    :onclick (make-js-action
              (lambda (&key &allow-other-keys)
                (toggle task))))
...
~~~

関数 `make-js-action` は、サーバー上の Lisp 関数を呼び出すシンプルな JavaScript 関数を作り、必要なウィジェットの HTML を自動的に再描画します。この例では、1 つのタスクだけを再描画します。

魅力的に感じましたか？ このクイックスタートガイドの続きはこちらです: [http://40ants.com/weblocks/quickstart.html](http://40ants.com/weblocks/quickstart.html)。


## テンプレート

### Djula - HTML マークアップ

[Djula](https://github.com/mmontone/djula) は、Python の Django テンプレートエンジンを Common Lisp へ移植したものです。[優れたドキュメント](https://mmontone.github.io/djula/djula/)があります。

Caveman はこれをデフォルトで使いますが、それ以外の場合でもセットアップは難しくありません。まずテンプレートの置き場所を次のように宣言します。

~~~lisp
(djula:add-template-directory (asdf:system-relative-pathname "webapp" "templates/"))
~~~

そのうえで、使うテンプレートを宣言・コンパイルします。例を示します。

~~~lisp
(defparameter +base.html+ (djula:compile-template* "base.html"))
(defparameter +welcome.html+ (djula:compile-template* "welcome.html"))
~~~

Djula のテンプレートは次のようになります。`{\%` のバックスラッシュは Jekyll の制約です。

```
{\% extends "base.html" \%}
{\% block title %}Memberlist{\% endblock \%}
{\% block content \%}
  <ul>
  {\% for user in users \%}
    <li><a href="{{ user.url }}">{{ user.username }}</a></li>
  {\% endfor \%}
  </ul>
{\% endblock \%}
```

最後に、テンプレートを描画するにはルートの中で `djula:render-template*` を呼びます。

~~~lisp
(easy-routes:defroute root ("/" :method :get) ()
  (djula:render-template* +welcome.html+ nil
                          :users (get-users)
~~~

効率のため、Djula は描画前にテンプレートをコンパイルします。

[access](https://github.com/AccelerationNet/access/) ライブラリと並んで、Quicklisp で最もダウンロードされているライブラリの 1 つです。

#### Djula のフィルタ

フィルタは、変数の表示方法を変えるためのものです。Djula にはよくできた組み込みフィルタがあり、[ドキュメントも充実しています](https://mmontone.github.io/djula/djula/Filters.html#Filters)。[タグ](https://mmontone.github.io/djula/djula/Tags.html#Tags) と混同しないようにしてください。

見た目は `{{ name | lower }}` のようになります。ここで `lower` は既存のフィルタで、テキストを小文字にします。

フィルタは引数を取ることもあります。たとえば `{{ value | add:2 }}` は `add` フィルタを `value` と 2 で呼びます。

さらに、独自フィルタを定義するのも簡単です。やることは `def-filter` マクロを使うだけです。第 1 引数に変数を取り、追加の省略可能な引数も取れます。

一般形は次のとおりです。

~~~lisp
(def-filter :myfilter-name (value arg) ;; arg is optional
   (body))
~~~

使い方は `{{ value | myfilter-name }}` です。

`add` フィルタの定義例を示します。

~~~lisp
(def-filter :add (it n)
  (+ it (parse-integer n)))
~~~

独自フィルタを書いたら、すぐにアプリ全体で使えます。

フィルタは、単純でない書式化やロジックをテンプレートからバックエンドへ移すのに便利です。


### Spinneret - Lisp らしいテンプレート

[Spinneret](https://github.com/ruricolist/spinneret) は "Lisp らしい" HTML5 生成器です。見た目は次のようになります。

~~~lisp
(with-page (:title "Home page")
  (:header
   (:h1 "Home page"))
  (:section
   ("~A, here is *your* shopping list: " *user-name*)
   (:ol (dolist (item *shopping-list*)
          (:li (1+ (random 10)) item))))
  (:footer ("Last login: ~A" *last-login*)))
~~~

作者は、より有名な cl-who よりも、HTML を別々の関数やマクロに分けて組み立てるほうが簡単だと考えています。ただし、機能はそれだけではありません。

- 無効なタグや属性を警告します
- 深さに応じて見出しに自動で番号を振れます
- 既定で HTML を整形して出力し、改行を制御できます
- 埋め込みの markdown を理解します
- ドキュメント中のどこで生成関数が使われたかを知れます（`get-html-tag` を参照）

## 静的アセットを配信する

### Hunchentoot

Hunchentoot では `create-folder-dispatcher-and-handler prefix directory` を使います。

例:

~~~lisp
(push (hunchentoot:create-folder-dispatcher-and-handler
       "/static/" (merge-pathnames
                     "src/static" ; <-- starts without a /
                     (asdf:system-source-directory :myproject)))
      hunchentoot:*dispatch-table*)
~~~

これで、`/path/to/myproject/src/static/` にあるプロジェクトの静的ファイルは `/static/` プレフィックスで配信されます。

```html
<img src="/static/img/banner.jpg" />
```


## データベースに接続する

詳しくは [databases の節](databases.html) を見てください。Mito ORM は SQLite3、PostgreSQL、MySQL をサポートし、マイグレーションや DB スキーマのバージョン管理などもあります。

Caveman では、データベース接続は Lisp のセッション中ずっと生きており、各 HTTP リクエストで再利用されます。

### 利用者がログイン済みか確認する

フレームワークにはセッションを扱う方法が用意されています。ここでは、利用者がログイン済みか確認するためにルートを包む小さなマクロを作ります。

Caveman では `*session*` はセッションのデータを表すハッシュテーブルです。login と logout の関数は次のようになります。

~~~lisp
(defun login (user)
  "Log the user into the session"
  (setf (gethash :user *session*) user))

(defun logout ()
  "Log the user out of the session."
  (setf (gethash :user *session*) nil))
~~~

単純な述語を定義します。

~~~lisp
(defun logged-in-p ()
  (gethash :user cm:*session*))
~~~

そして `with-logged-in` マクロを定義します。

~~~lisp
(defmacro with-logged-in (&body body)
  `(if (logged-in-p)
       (progn ,@body)
       (render #p"login.html"
               '(:message "Please log-in to access this page."))))
~~~

利用者がログインしていなければセッションストアには何もなく、ログインページを描画します。問題なければマクロ本体を実行します。使い方は次のとおりです。

~~~lisp
(defroute "/account/logout" ()
  "Show the log-out page, only if the user is logged in."
  (with-logged-in
    (logout)
    (render #p"logout.html")))

(defroute ("/account/review" :method :get) ()
  (with-logged-in
    (render #p"review.html"
            (list :review (get-review (gethash :user *session*))))))
~~~

同様に使えます。


### パスワードを暗号化する

#### cl-bcrypt を使う

[cl-bcrypt](https://github.com/dnaeon/cl-bcrypt) はパスワードのハッシュ化と検証のためのライブラリです。使い方は次のとおり簡単です。

~~~lisp
;; 12 ラウンドの password オブジェクトを作る
(defparameter *password* (bcrypt:make-password "test" :cost 12 :identifier "2a"))
;; ハッシュを生成する
(bcrypt:password-hash *password*)
;; #(249 97 146 214 147 168 142 174 40 17 15 74 150 236 240 184 72 175 74 206 160 168 22)
;; 文字列表現
(defparameter *password-string* (bcrypt:encode *password*))
;; 保存済み文字列と "test" を比べて password を検証する
(bcrypt:password= "test" *password-string*)
;; T
(bcrypt:password= "correct horse battery staple" *password-string*)
;; NIL
~~~

#### 手動で (Ironclad を使う)

このレシピでは、暗号化と検証を自分で行います。デファクトスタンダードの [Ironclad](https://github.com/froydnj/ironclad) 暗号ツールキットと、[Babel](https://github.com/cl-babel/babel) の文字コードのエンコード／デコードライブラリを使います。

次のスニペットは、データベースに保存すべきパスワードハッシュを作ります。Ironclad は文字列ではなくバイトベクトルを期待する点に注意してください。

~~~lisp
(defun password-hash (password)
  (ironclad:pbkdf2-hash-password-to-combined-string
   (babel:string-to-octets password)))
~~~

`pbkdf2` は [RFC2898](https://tools.ietf.org/html/rfc2898) で定義されています。擬似乱数関数を使って、パスワードに基づく安全な暗号鍵を導出します。

次の関数は、利用者が有効かどうかを確認し、入力されたパスワードを検証します。有効で検証できたなら user-id を返し、それ以外はエラーが起きてもすべて nil を返します。自分のアプリケーションに合わせて調整してください。

~~~lisp
(defun check-user-password (user password)
  (handler-case
      (let* ((data (my-get-user-data user))
             (hash (my-get-user-hash data))
             (active (my-get-user-active data)))
        (when (and active (ironclad:pbkdf2-check-password (babel:string-to-octets password)
                                                          hash))
          (my-get-user-id data)))
    (condition () nil)))
~~~

次はデータベースにパスワードを設定する例です。パスワードを保存するときは `(password-hash password)` を使っています。残りは Web フレームワークと DB ライブラリに依存する部分です。

~~~lisp
(defun set-password (user password)
  (with-connection (db)
    (execute
     (make-statement :update :web_user
                     (set= :hash (password-hash password))
                     (make-clause :where
                                  (make-op := (if (integerp user)
                                                  :id_user
                                                  :email)
                                           user))))))
~~~

*Credit: [/r/learnlisp](https://www.reddit.com/r/learnlisp/comments/begcf9/can_someone_give_me_an_eli5_on_hiw_to_encrypt_and/) の `/u/arvid`*.

## 実行とビルド

<a id="application-"></a>

### ソースからアプリケーションを実行する

ソースから Lisp コードをスクリプトとして実行するには、処理系の `--load` スイッチを使えます。

次を確認する必要があります。

- プロジェクトの `.asd` のシステム宣言を読み込むこと（あるなら）
- 必要な依存をインストールすること（そのためには事前に Quicklisp を入れておく必要があります）
- アプリケーションのエントリポイントを実行すること

次のようなコマンドを使えます。

~~~lisp
;; run.lisp

(load "myproject.asd")

(ql:quickload "myproject")

(in-package :myproject)
(handler-case
    ;; START 関数が web server を起動します。
    (myproject::start :port (ignore-errors
                              (parse-integer
                                (uiop:getenv "PROJECT_PORT"))))
  (error (c)
    (format *error-output* "~&An error occurred: ~a~&" c)
    (uiop:quit 1)))
~~~

さらに、環境変数でアプリケーションのポートを設定できるようにしています。

ファイルは次のように実行できます。

    sbcl --load run.lisp

プロジェクトを読み込んだあと、web サーバーはバックグラウンドで起動します。おなじみの Lisp REPL が使えるので、動いているアプリケーションと対話できます。

自分の好きなエディタから、離れた場所にある実行中のアプリケーションに接続し、エディタでの変更を動いているインスタンスへコンパイルできます。後述の「リモートの Lisp イメージに接続する」を参照してください。


### 自己完結型実行ファイルを作る

他の Common Lisp アプリケーションと同様に、Web アプリもアセットを含めて 1 つの実行ファイルにまとめられます。配備はとても簡単です。サーバーにコピーして実行するだけです。

```
$ ./my-web-app
Hunchentoot server が起動しました。
localhost:9003 で待ち受けます。
```

[scripting#for-web-apps](scripting.html#for-web-apps) のレシピを参照してください。


### Travis CI や GitLab CI で継続的デリバリーを行う

[testing#continuous-integration](testing.html#continuous-integration) の節を見てください。


### Electron によるマルチプラットフォーム配信

Web アプリケーションのバイナリを作ったら、Electron ウィンドウからそれを参照できます。

[Ceramic](https://ceramic.github.io/) は、その作業をまとめてやってくれるツール群です。

使い方はこれだけです。

~~~lisp
;; Ceramic とアプリを読み込む
(ql:quickload '(:ceramic :our-app))

;; Ceramic の初期化
(ceramic:setup)
(ceramic:interactive)

;; アプリを起動する（ここでは Lucerne ベース）
(lucerne:start our-app.views:app :port 8000)

;; ブラウザのウィンドウを開く
(defvar window (ceramic:make-window :url "http://localhost:8000/"))

;; Ceramic を起動する
(ceramic:show-window window)
~~~

これを Linux、Mac、Windows へ配布できます。

さらにあります。

> Ceramic アプリケーションはネイティブコードにコンパイルされるため、性能を確保でき、ソースを公開しない商用アプリケーションも配布できます。

そのため、JS を minify する必要もありません。

## デプロイ

### 手動でデプロイする

シェルで実行ファイルを起動してバックグラウンドに回す（`C-z bg`）か、`tmux` のセッションの中で実行できます。最良ではありませんが、動きます。


### Systemd: デーモン化、クラッシュ時の再起動、ログの扱い

これは実際にはシステム固有の作業です。自分のシステムでのやり方を確認してください。

今では多くの GNU/Linux ディストロに Systemd が入っているので、簡単な例を示します。

Systemd でアプリケーションを配備するのは、設定ファイルを書くだけです。

```
$ sudo emacs -nw /etc/systemd/system/my-app.service
[Unit]
Description=systemd 上の Lisp app の例

[Service]
WorkingDirectory=/path/to/your/project/directory/
ExecStart=/usr/bin/make run  # or anything
Type=simple
Restart=on-failure

[Install]
WantedBy=network.target
```

すると、`start` するコマンドが使えます。

    sudo systemctl start my-app.service

サービスをインストールして、起動や再起動のあとに **アプリを起動** するコマンドもあります（それが "[Install]" 部分です）。

    sudo systemctl enable my-app.service

`status` も確認できます。

    systemctl status my-app.service

アプリケーションの **ログ** も見られます（stdout や stderr に書けば、Systemd がログに記録します）。

    journalctl -u my-app.service

（`-f` オプションでログの更新をリアルタイム表示でき、その場合は `-n 50` や `--lines` で表示行数を増やせます）

Systemd はクラッシュを処理し、**アプリケーションを再起動** します。それが `Restart=on-failure` の行です。

ただし、いくつか注意点があります。

- メインスレッドを動かしたままにしておく必要があります。そうしないと Systemd はアプリを正常に起動したと判断して、何もしていないと思い、正常停止してしまいます。起動時に Lisp REPL を出すだけでは不十分です。
  - このレシピの [scripting#for-web-apps](scripting.html#for-web-apps) で、Web サーバースレッドをどう生かしておくかを見てください。
  - 実行中の Lisp イメージに接続したいがアプリの REPL には入れない、という場合は [Swank サーバー](debugging.html#remote-debugging) を使います。
- 自動再起動のためにはアプリにクラッシュしてもらう必要があります。SBCL では `--disable-debugger` フラグを使いたくなります。
- Systemd は既定でアプリを root として実行します。Lisp にスタートアップファイル（`~/.sbclrc`）を読ませたい場合、とくに Quicklisp の設定のためには、`--userinit` フラグを使うか、`[service]` セクションで `User=xyz` を設定する必要があります。スタートアップファイルを使うときは、`(user-homedir-pathname)` の結果が利用者によって変わるので、Quicklisp の `setup.lisp` を見つけられないことがあります。


詳細: [https://www.freedesktop.org/software/systemd/man/systemd.service.html](https://www.freedesktop.org/software/systemd/man/systemd.service.html)

### Docker を使う

Common Lisp 向けの Docker イメージはいくつかあります。たとえば次のものです。

- [clfoundation/sbcl](https://hub.docker.com/r/clfoundation/sbcl/) は、SBCL の最新版、CI に便利な OS パッケージ群、Quicklisp を入れるスクリプトを含みます。
- [40ants/base-lisp-image](https://github.com/40ants/base-lisp-image) は Ubuntu LTS ベースで、SBCL、CCL、Quicklisp、Qlot、Roswell を含みます。
- [container-lisp/s2i-lisp](https://github.com/container-lisp/s2i-lisp) は CentOS ベースで、OpenShift の source-to-image を使って Quicklisp ベースの Common Lisp アプリケーションを再現可能な docker イメージとしてビルドするためのソースを含みます。


### Guix を使う

[GNU Guix](https://www.gnu.org/software/guix/) はトランザクション型のパッケージマネージャで、既存の OS の上に入れられるほか、宣言的なシステム設定をサポートする丸ごとのディストロでもあります。システム依存を含む自己完結型の tarball を配布できます。例として [Nyxt browser](https://github.com/atlas-engineer/nyxt/) を見てください。

### Nginx の背後で動かす

Lisp の web アプリを Nginx の背後で動かすのに、CL 特有のことは何もありません。始めるための例を示します。

Lisp アプリが web サーバー上で、IP アドレス 1.2.3.4、ポート 8001 で動いているとします。特別なことはありません。実際のドメイン名でアプリにアクセスしたいわけです（レート制限など、Nginx の他の利点も使いたい）。ドメイン名を買って、ドメイン名をサーバーの IP アドレスに結び付ける A タイプの DNS レコードを作ったとします。

Nginx でサーバーを設定し、"your-domain-name.org" からポート 80 に来る接続を、ローカルで動く Lisp アプリに送るよう指示します。

新しいファイル `/etc/nginx/sites-enabled/my-lisp-app.conf` を作り、次のプロキシディレクティブを追加します。

~~~lisp
server {
    listen www.your-domain-name.org:80;
    server_name your-domain-name.org www.your-domain-name.org;  # with and without www
    location / {
        proxy_pass http://1.2.3.4:8001/;
    }

    # Optional: serve static files with nginx, not the Lisp app.
    location /files/ {
        proxy_pass http://1.2.3.4:8001/files/;
    }
}
~~~

`proxy_pass http://1.2.3.4:8001/;` ではサーバーのパブリック IP アドレスを使っている点に注意してください。Hunchentoot のような Lisp の web サーバーがその IP で直接待ち受けていることもよくありますが、セキュリティ上の理由から Lisp アプリを localhost で動かしたいかもしれません。

nginx を再読み込みします（`reload` シグナルを送ります）。

    $ nginx -s reload

これで終わりです。`http://www.your-domain-name.org` から外部経由で Lisp アプリにアクセスできます。


### Heroku や他のサービスへデプロイする

[heroku-buildpack-common-lisp](https://gitlab.com/duncan-bayne/heroku-buildpack-common-lisp) と、Kubernetes、OpenShift、AWS など向けのインターフェイスライブラリが載っている [Awesome CL#deploy](https://github.com/CodyReichert/awesome-cl#deployment) を参照してください。


## 監視

[Prometheus.cl](https://github.com/deadtrickster/prometheus.cl) を見ると、SBCL と Hunchentoot のメトリクス（メモリ、スレッド、1 秒あたりのリクエスト数など）用の Grafana ダッシュボードが分かります。

## リモートの Lisp イメージに接続する

<!-- links should be relative, but transforming to PDF with Typst blocks on it -->

この節を参照してください: [debugging#remote-debugging](https://lispcookbook.github.io/cl-cookbook/debugging.html#remote-debugging)

## ホットリロード

これは [Quickutil](https://github.com/stylewarning/quickutil/blob/master/quickutil-server/) の例です。実際には先ほどの節を自動化したものです。

Makefile のターゲットがあります。

```lisp
hot_deploy:
	$(call $(LISP), \
		(ql:quickload :quickutil-server) (ql:quickload :swank-client), \
		(swank-client:with-slime-connection (conn "localhost" $(SWANK_PORT)) \
			(swank-client:slime-eval (quote (handler-bind ((error (function continue))) \
				(ql:quickload :quickutil-utilities) (ql:quickload :quickutil-server) \
				(funcall (symbol-function (intern "STOP" :quickutil-server))) \
				(funcall (symbol-function (intern "START" :quickutil-server)) $(start_args)))) conn)) \
		$($(LISP)-quit))
```

これはサーバー上で実行する必要があります（簡単な fabfile のコマンドで ssh 経由で呼べます）。その前に `fab update` でサーバー上に `git pull` 済みなので、新しいコードはあるがまだ動いていない状態です。ローカルの swank サーバーに接続し、新しいコードを読み込み、アプリを止めてすぐ起動し直します。


## 関連項目

- [Web Apps in Lisp, Know-how](https://web-apps-in-lisp.github.io/)
- [lisp-web-template-productlist](https://github.com/vindarel/lisp-web-template-productlist),
  Hunchentoot、Easy-Routes、Djula、Bulma CSS を使ったシンプルなプロジェクトテンプレート。
- [lisp-web-live-reload-example](https://github.com/vindarel/lisp-web-live-reload-example/) -
  実行中の web アプリと対話する方法を示すおもちゃのプロジェクト。
- [video: how to build a web app in Lisp · part 1](https://www.youtube.com/watch?v=h_noB1sI_e8) は Hunchentoot、easy-routes、Djula テンプレート、エラー処理、よくある落とし穴を扱っています。
- [Building a TLS 1.3 implementation in Common Lisp](https://atgreen.github.io/repl-yell/posts/pure-tls/)
- [Automatic TLS Certificates for Common Lisp with pure-tls/acme](https://atgreen.github.io/repl-yell/posts/pure-tls-acme/)

## 謝辞

- [https://lisp-journey.gitlab.io/web-dev/](https://lisp-journey.gitlab.io/web-dev/)

[hunchentoot]: https://edicl.github.io/hunchentoot
[clack]: https://github.com/fukamachi/clack
[caveman]: https://github.com/fukamachi/caveman
[radiance]: https://github.com/Shirakumo/radiance
[snooze]: https://github.com/joaotavora/snooze
[cl-rest-server]: https://github.com/mmontone/cl-rest-server
[weblocks]: https://github.com/40ants/weblocks
