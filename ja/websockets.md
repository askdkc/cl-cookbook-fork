---
title: WebSockets
---

Common Lisp エコシステムには、WebSocket server を構築するための方法がいくつかあります。まず、古典的な Common Lisp 向け web server である [Hunchentoot](https://edicl.github.io/hunchentoot/) の拡張として書かれた、優れた [Hunchensocket](https://github.com/joaotavora/hunchensocket) があります。私は両方を使ったことがあり、どちらもすばらしいものだと思っています。

しかし今回は、同じく優れた [websocket-driver](https://github.com/fukamachi/websocket-driver) を使い、[Clack](https://github.com/fukamachi/clack) で WebSocket server を構築します。Common Lisp の web development community は Clack ecosystem を少し好む傾向を示しています。Clack は Hunchentoot を含むさまざまな backend に対して統一された interface を提供するからです。つまり、Clack を使えば、好みの backend を選べます。

以下では、簡単な chat server を構築し、web browser から接続します。この tutorial は、進めながら REPL に code を入力できるように書かれていますが、何かを見落とした場合に備えて、最後に完全な code listing もあります。

最初の step として、quicklisp で必要な library をロードします。

~~~lisp

(ql:quickload '(clack websocket-driver alexandria))

~~~


## websocket-driver の考え方

websocket-driver では、WebSocket connection は `ws` class の instance であり、event-driven API を公開します。WebSocket instance を `on` という method の第2引数として渡すことで、event handler を登録します。たとえば、`(on :message my-websocket #'some-message-handler)` を呼び出すと、新しい message が到着するたびに `some-message-handler` が呼び出されます。

`websocket-driver` API は、次の event 用 handler を提供します。

- `:open`: connection が開かれたとき。引数なしの handler を期待します。
- `:message` message が到着したとき。受け取った message を1つの引数として取る handler を期待します。
- `:close` connection が閉じたとき。切断された connection の "code" と "reason" という2つの keyword arg を持つ handler を期待します。
- `:error` 何らかの protocol level error が発生したとき。error message を1つの引数として取る handler を期待します。

chat server では3つの case を扱う必要があります。新しい user が channel に入ったとき、user が channel に message を送ったとき、そして user が退出したときです。

## Chat Server Logic 用の handler を定義する

この section では、event handler が最終的に呼び出す関数を定義します。これらは chat server logic を管理する helper function です。WebSocket server は次の section で定義します。

まず、user が server に接続したら、他の user が誰の chat かわかるように、その user に nickname を与える必要があります。また、個々の WebSocket connection を nickname に対応付ける data structure も必要です。

~~~lisp

;; make a hash table to map connections to nicknames
(defvar *connections* (make-hash-table))

;; and assign a random nickname to a user upon connection
(defun handle-new-connection (con)
  (setf (gethash con *connections*)
        (format nil "user-~a" (random 100000))))

~~~

次に、user が room に chat を送ったとき、room の残りの user に通知されるべきです。server が受け取る message には、それを送った user の nickname が前置されます。

~~~lisp

(defun broadcast-to-room (connection message)
  (let ((message (format nil "~a: ~a"
                         (gethash connection *connections*)
                         message)))
    (loop :for con :being :the :hash-key :of *connections* :do
          (websocket-driver:send con message))))
~~~

最後に、user が browser tab を閉じる、または別ページへ移動することで channel を離れたら、room へその変更を通知し、その user の connection を `*connections*` table から削除するべきです。

~~~lisp
(defun handle-close-connection (connection)
  (let ((message (format nil " .... ~a has left."
                         (gethash connection *connections*))))
    (remhash connection *connections*)
    (loop :for con :being :the :hash-key :of *connections* :do
          (websocket-driver:send con message))))
~~~

## Server を定義する

Clack を使う場合、server は `clack:clackup` に関数を渡すことで起動されます。ここでは `chat-server` という関数を定義し、`(clack:clackup #'chat-server :port 12345)` を呼び出して起動します。

Clack server function は、単一の plist を引数として受け取ります。その plist は request に関する environment information を含み、system によって提供されます。この chat server はその environment を使いませんが、さらに学びたい場合は Clack の documentation を確認できます。

browser が server に接続すると、websocket が instance 化され、support したい各 event 用の handler が定義されます。その後、WebSocket "handshake" が browser へ送り返され、connection が確立されたことを示します。仕組みは次のとおりです。

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

これで、port `12345` で動く server を起動できます。

~~~lisp
;; Keep the handler around so that
;; you can stop your server later on:
(defvar *chat-handler* (clack:clackup #'chat-server :port 12345))
~~~


## 簡単な HTML Chat Client

これで server と話す方法が必要です。Clack を使って、chat を表示して送信する web page を提供する簡単な application を定義します。まず web page です。

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

quote の escape は少し面倒なので、HTML を file に入れる方を好むかもしれません。この tutorial の目的では、page data を `defvar` に保持する方が単純でした。

`client-server` 関数は HTML content を提供しているだけだとわかります。今度は port `8080` で起動しましょう。

~~~lisp
(defvar *client-handler* (clack:clackup #'client-server :port 8080))
~~~

## 確認してみよう

今度は browser tab を2つ開き、それぞれ `http://localhost:8080` を指すようにすると、chat app が見えるはずです。

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
