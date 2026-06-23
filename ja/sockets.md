---
title: ソケットによる TCP/UDP プログラミング
---

これは [usockets](https://github.com/usocket/usocket) を使った Common Lisp での TCP/IP と UDP/IP の client/server プログラミングの短いガイドです。


## TCP/IP

いつものように、quicklisp を使って usocket をロードします。

    (ql:quickload "usocket")

ここでサーバーを作成する必要があります。呼び出す必要がある主要な関数は2つあります。`usocket:socket-listen` と `usocket:socket-accept` です。

`usocket:socket-listen` はポートにバインドして待ち受けます。これはソケットオブジェクトを返します。受け付ける接続が来るまで、このオブジェクトで待つ必要があります。そこで `usocket:socket-accept` が登場します。これはブロッキング呼び出しで、接続が作られたときにだけ返ります。その接続に固有の新しいソケットオブジェクトを返します。その後、その接続を使ってクライアントと通信できます。

では、自分のミスによって直面した問題は何だったでしょうか。

ミス1 - 最初、`socket-accept` はストリームオブジェクトを返すと思っていました。違います……。これはソケットオブジェクトを返します。振り返ればそれが正しく、自分のミスで時間を失いました。ソケットに書き込みたいなら、この新しいソケットから対応するストリームを実際に取得する必要があります。ソケットオブジェクトにはストリームスロットがあり、それを明示的に使う必要があります。どうやってそれを知るのでしょうか。`(describe connection)` が助けになります。

ミス2 - 新しいソケットとサーバーのソケットの両方を閉じる必要があります。これもまたかなり明白ですが、最初のコードでは接続だけを閉じていたため、ソケットが使用中という問題に何度も遭遇しました。もちろん、待ち受けるときにソケットを再利用するという選択肢もあります。

これらのミスを乗り越えれば、残りはかなり簡単です。接続とサーバーのソケットを閉じれば、それで完了です。


~~~lisp
(defun create-server (port)
  (let* ((socket (usocket:socket-listen "127.0.0.1" port))
	 (connection (usocket:socket-accept socket :element-type
                     'character)))
    (unwind-protect
        (progn
	      (format (usocket:socket-stream connection)
                  "Hello World~%")
	      (force-output (usocket:socket-stream connection)))
      (progn
	    (format t "Closing sockets~%")
	    (usocket:socket-close connection)
        (usocket:socket-close socket)))))
~~~

次はクライアントです。この部分は簡単です。サーバー port に接続するだけで、サーバーから読めるはずです。ここで私が犯した唯一のばかげたミスは、read-line ではなく read を使ったことでした。そのため、サーバーから "Hello" だけが見えていました。散歩に出て戻ってきてから問題を見つけ、修正しました。


~~~lisp
(defun create-client (port)
  (usocket:with-client-socket (socket stream "127.0.0.1" port
                                      :element-type 'character)
    (unwind-protect
         (progn
           (usocket:wait-for-input socket)
           (format t "Input is: ~a~%" (read-line stream)))
      (usocket:socket-close socket))))
~~~

では、これをどう実行するのでしょうか。REPL が2つ必要です。1つはサーバー用、もう1つはクライアント用です。両方の REPL でこのファイルをロードします。最初の REPL でサーバーを作成します。

    (create-server 12321)

これで、2つ目の REPL でクライアントを実行する準備ができました。

    (create-client 12321)

Voilà! 2つ目の REPL に "Hello World" が表示されるはずです。


## UDP/IP

プロトコルとして、UDP はコネクションレスです。そのため、接続をバインドして受け付けるという概念はありません。代わりに `socket-connect` だけを行いますが、特定のポートでデータを待つ UDP ソケットを作るために、特定のパラメータの組を渡します。

では、自分のミスによって直面した問題は何だったでしょうか。
ミス1 - TCP と違い、`socket-connect` にホストとポートを渡しません。それを行うと、パケットを送信したいと示していることになります。代わりに `nil` を渡しますが、データを受け取りたいアドレスとポートに `:local-host` と `:local-port` を設定します。この部分を理解するには少し時間がかかりました。ドキュメントがそれを扱っていなかったからです。代わりに [blackthorn-engine-3d](https://code.google.com/p/blackthorn-engine-3d/source/browse/src/examples/usocket/usocket.lisp) のコードを少し読むことが大いに助けになりました。

また、UDP はコネクションレスなので、誰でもいつでもデータを送れます。そのため、どのホスト／ポートからデータを受け取ったのかを知る必要があります。そうすれば、そこへ応答できます。そのため、`socket-receive` に複数の値を束縛し、それらの値を使って通信相手の「クライアント」へデータを送り返します。

~~~lisp
(defun create-server (port buffer)
  (let* ((socket (usocket:socket-connect nil nil
					:protocol :datagram
					:element-type '(unsigned-byte 8)
					:local-host "127.0.0.1"
					:local-port port)))
    (unwind-protect
	 (multiple-value-bind (buffer size client receive-port)
	     (usocket:socket-receive socket buffer 8)
	   (format t "~A~%" buffer)
	   (usocket:socket-send socket (reverse buffer) size
				:port receive-port
				:host client))
      (usocket:socket-close socket))))
~~~


次は送信側／受信側です。この部分はかなり簡単です。ソケットを作成し、そこへデータを送信し、データを受け取ります。

~~~lisp
(defun create-client (port buffer)
  (let ((socket (usocket:socket-connect "127.0.0.1" port
					 :protocol :datagram
					 :element-type '(unsigned-byte 8))))
    (unwind-protect
	 (progn
	   (format t "Sending data~%")
	   (replace buffer #(1 2 3 4 5 6 7 8))
	   (format t "Receiving data~%")
	   (usocket:socket-send socket buffer 8)
	   (usocket:socket-receive socket buffer 8)
	   (format t "~A~%" buffer))
      (usocket:socket-close socket))))
~~~


では、これをどう実行するのでしょうか。ここでも REPL が2つ必要です。1つはサーバー用、もう1つはクライアント用です。両方の REPL でこのファイルをロードします。最初の REPL でサーバーを作成します。

    (create-server 12321 (make-array 8 :element-type '(unsigned-byte 8)))

これで、2つ目の REPL でクライアントを実行する準備ができました。

    (create-client 12321 (make-array 8 :element-type '(unsigned-byte 8)))

Voilà! 最初の REPL にはベクトル `#(1 2 3 4 5 6 7 8)` が表示され、2つ目には `#(8 7 6 5 4 3 2 1)` が表示されるはずです。


## クレジット

このガイドはもともと [shortsightedsid](https://gist.github.com/shortsightedsid/71cf34282dfae0dd2528) に由来します。
