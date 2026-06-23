---
title: WebSockets
---

Common Lisp エコシステムには、WebSocket サーバーを構築するための方法がいくつかあります。まず、古典的な Common Lisp 向け web サーバーである [Hunchentoot](https://edicl.github.io/hunchentoot/) の拡張として書かれた、優れた [Hunchensocket](https://github.com/joaotavora/hunchensocket) があります。私は両方を使ったことがあり、どちらもすばらしいものだと思っています。

しかし今回は、同じく優れた [websocket-driver](https://github.com/fukamachi/websocket-driver) を使い、[Clack](https://github.com/fukamachi/clack) で WebSocket サーバーを構築します。Common Lisp の web 開発コミュニティは Clack のエコシステムを少し好む傾向を示しています。Clack は Hunchentoot を含むさまざまなバックエンドに対して統一されたインターフェイスを提供するからです。つまり、Clack を使えば、好みのバックエンドを選べます。

以下では、簡単な chat サーバーを構築し、web ブラウザから接続します。このチュートリアルは、進めながら REPL にコードを入力できるように書かれていますが、何かを見落とした場合に備えて、最後に完全なコードの一覧もあります。

最初のステップとして、quicklisp で必要なライブラリをロードします。

~~~lisp

(ql:quickload '(clack websocket-driver alexandria))

~~~


## websocket-driver の考え方

websocket-driver では、WebSocket 接続は `ws` クラスのインスタンスであり、イベント駆動型 API を公開します。WebSocket インスタンスを `on` というメソッドの第2引数として渡すことで、イベントハンドラを登録します。たとえば、`(on :message my-websocket #'some-message-handler)` を呼び出すと、新しいメッセージが到着するたびに `some-message-handler` が呼び出されます。

`websocket-driver` API は、次のイベント用ハンドラを提供します。

- `:open`: 接続が開かれたとき。引数なしのハンドラを期待します。
- `:message` メッセージが到着したとき。受け取ったメッセージを1つの引数として取るハンドラを期待します。
- `:close` 接続が閉じたとき。切断された接続の "code" と "reason" という2つのキーワード引数を持つハンドラを期待します。
- `:error` 何らかのプロトコルレベルのエラーが発生したとき。エラーメッセージを1つの引数として取るハンドラを期待します。

chat サーバーでは3つの場面を扱う必要があります。新しいユーザーがチャンネルに入ったとき、ユーザーがチャンネルにメッセージを送ったとき、そしてユーザーが退出したときです。

<a id="chat-server-logic--handler-"></a>

## chat サーバーのロジック用のハンドラを定義する

この節では、イベントハンドラが最終的に呼び出す関数を定義します。これらは chat サーバーのロジックを管理する補助関数です。WebSocket サーバーは次の節で定義します。

まず、ユーザーがサーバーに接続したら、他のユーザーが誰の発言かわかるように、そのユーザーにニックネームを与える必要があります。また、個々の WebSocket 接続をニックネームに対応付けるデータ構造も必要です。

~~~lisp

;; make a hash table to map connections to nicknames
(defvar *connections* (make-hash-table))

;; and assign a random nickname to a user upon connection
(defun handle-new-connection (con)
  (setf (gethash con *connections*)
        (format nil "user-~a" (random 100000))))

~~~

次に、ユーザーがルームにメッセージを送ったとき、ルームの残りのユーザーに通知されるべきです。サーバーが受け取るメッセージには、それを送ったユーザーのニックネームが前置されます。

~~~lisp

(defun broadcast-to-room (connection message)
  (let ((message (format nil "~a: ~a"
                         (gethash connection *connections*)
                         message)))
    (loop :for con :being :the :hash-key :of *connections* :do
          (websocket-driver:send con message))))
~~~

最後に、ユーザーがブラウザのタブを閉じる、または別ページへ移動することでチャンネルを離れたら、ルームへその変更を通知し、そのユーザーの接続を `*connections*` テーブルから削除するべきです。

~~~lisp
(defun handle-close-connection (connection)
  (let ((message (format nil " .... ~a has left."
                         (gethash connection *connections*))))
    (remhash connection *connections*)
    (loop :for con :being :the :hash-key :of *connections* :do
          (websocket-driver:send con message))))
~~~

<a id="server-"></a>

## サーバーを定義する

Clack を使う場合、サーバーは `clack:clackup` に関数を渡すことで起動されます。ここでは `chat-server` という関数を定義し、`(clack:clackup #'chat-server :port 12345)` を呼び出して起動します。

Clack サーバー関数は、単一の plist を引数として受け取ります。その plist はリクエストに関する環境情報を含み、システムによって提供されます。この chat サーバーはその環境を使いませんが、さらに学びたい場合は Clack のドキュメントを確認できます。

ブラウザがサーバーに接続すると、websocket がインスタンス化され、対応したい各イベント用のハンドラが定義されます。その後、WebSocket の "handshake" がブラウザへ送り返され、接続が確立されたことを示します。仕組みは次のとおりです。

~~~lisp
(defun chat-server (env)
  (let ((ws (websocket-driver:make-server env)))

    (websocket-driver:on :open ws
                         (lambda () (handle-new-connection ws)))

    (websocket-driver:on :message ws
                         (lambda (msg)
                           (broadcast-to-room ws msg)))

    (websocket-driver:on :close ws
                         (lambda (&key code reason)
                           (declare (ignore code reason))
                           (handle-close-connection ws)))

    (lambda (responder)
      (declare (ignore responder))
      ;; Send the handshake:
      (websocket-driver:start-connection ws))))
~~~

これで、ポート `12345` で動くサーバーを起動できます。

~~~lisp
;; Keep the handler around so that
;; you can stop your server later on:
(defvar *chat-handler* (clack:clackup #'chat-server :port 12345))
~~~


<a id="html-chat-client"></a>

## 簡単な HTML チャットクライアント

これでサーバーと話す方法が必要です。Clack を使って、chat を表示して送信する web ページを提供する簡単なアプリケーションを定義します。まず web ページです。

~~~lisp

(defvar *html*
  "<!doctype html>

<html lang=\"en\">
<head>
  <meta charset=\"utf-8\">
  <title>LISP-CHAT</title>
</head>

<body>
    <ul id=\"chat-echo-area\">
    </ul>
    <div style=\"position:fixed; bottom:0;\">
        <input id=\"chat-input\" placeholder=\"say something\" >
    </div>
    <script>
     window.onload = function () {
         const inputField = document.getElementById(\"chat-input\");

         function receivedMessage(msg) {
             let li = document.createElement(\"li\");
             li.textContent = msg.data;
             document.getElementById(\"chat-echo-area\").appendChild(li);
         }

         const ws = new WebSocket(\"ws://localhost:12345/chat\");
         ws.addEventListener('message', receivedMessage);

         inputField.addEventListener(\"keyup\", (evt) => {
             if (evt.key === \"Enter\") {
                 ws.send(evt.target.value);
                 evt.target.value = \"\";
             }
         });
     };

    </script>
</body>
</html>
")


(defun client-server (env)
    (declare (ignore env))
    `(200 (:content-type "text/html")
          (,*html*)))

~~~

クォートのエスケープは少し面倒なので、HTML をファイルに入れる方を好むかもしれません。このチュートリアルの目的では、ページデータを `defvar` に保持する方が単純でした。

`client-server` 関数は HTML の内容を提供しているだけだとわかります。今度はポート `8080` で起動しましょう。

~~~lisp
(defvar *client-handler* (clack:clackup #'client-server :port 8080))
~~~

## 確認してみよう

今度はブラウザのタブを2つ開き、それぞれ `http://localhost:8080` を指すようにすると、チャットアプリが見えるはずです。

<img src="assets/sockets-lisp-chat.gif"
     width="470" height="247" alt="Chat app demo between two browser windows"/>

<!-- pdf-include-start
![](assets/sockets-lisp-chat.gif)
   pdf-include-end -->

## すべてのコード

~~~lisp
(ql:quickload '(clack websocket-driver alexandria))

(defvar *connections* (make-hash-table))

(defun handle-new-connection (con)
  (setf (gethash con *connections*)
        (format nil "user-~a" (random 100000))))

(defun broadcast-to-room (connection message)
  (let ((message (format nil "~a: ~a"
                         (gethash connection *connections*)
                         message)))
    (loop :for con :being :the :hash-key :of *connections* :do
          (websocket-driver:send con message))))

(defun handle-close-connection (connection)
  (let ((message (format nil " .... ~a has left."
                         (gethash connection *connections*))))
    (remhash connection *connections*)
    (loop :for con :being :the :hash-key :of *connections* :do
          (websocket-driver:send con message))))

(defun chat-server (env)
  (let ((ws (websocket-driver:make-server env)))
    (websocket-driver:on :open ws
                         (lambda () (handle-new-connection ws)))

    (websocket-driver:on :message ws
                         (lambda (msg)
                           (broadcast-to-room ws msg)))

    (websocket-driver:on :close ws
                         (lambda (&key code reason)
                           (declare (ignore code reason))
                           (handle-close-connection ws)))
    (lambda (responder)
      (declare (ignore responder))
      (websocket-driver:start-connection ws))))

(defvar *html*
  "<!doctype html>

<html lang=\"en\">
<head>
  <meta charset=\"utf-8\">
  <title>LISP-CHAT</title>
</head>

<body>
    <ul id=\"chat-echo-area\">
    </ul>
    <div style=\"position:fixed; bottom:0;\">
        <input id=\"chat-input\" placeholder=\"say something\" >
    </div>
    <script>
     window.onload = function () {
         const inputField = document.getElementById(\"chat-input\");

         function receivedMessage(msg) {
             let li = document.createElement(\"li\");
             li.textContent = msg.data;
             document.getElementById(\"chat-echo-area\").appendChild(li);
         }

         const ws = new WebSocket(\"ws://localhost:12345/\");
         ws.addEventListener('message', receivedMessage);

         inputField.addEventListener(\"keyup\", (evt) => {
             if (evt.key === \"Enter\") {
                 ws.send(evt.target.value);
                 evt.target.value = \"\";
             }
         });
     };

    </script>
</body>
</html>
")

(defun client-server (env)
  (declare (ignore env))
  `(200 (:content-type "text/html")
     (,*html*)))

(defvar *chat-handler* (clack:clackup #'chat-server :port 12345))
(defvar *client-handler* (clack:clackup #'client-server :port 8080))
~~~
