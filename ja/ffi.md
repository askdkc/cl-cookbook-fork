---
title: 外部関数インターフェイス
---

ANSI Common Lisp 標準はこの話題に触れていません。そのため、ここで言えることのほとんどは OS と実装に依存します。しかし現在では、移植性があり使いやすい C 外部関数インターフェイスである [CFFI](https://github.com/cffi/cffi) ライブラリを使えます。

> CFFI、すなわち Common Foreign Function Interface は、Common Lisp 向けの移植可能な FFI であることを目指しています。さまざまな Common Lisp 実装のネイティブ FFI の API の違いを抽象化します。

すぐに例を見てみましょう。


## CFFI: `math.h` ヘッダファイルの C 関数を呼び出す

`defcfun` を使って、`math.h` の外部 C 関数 [ceil](https://en.cppreference.com/w/c/numeric/math/ceil) とインターフェイスします。

[defcfun](https://cffi.common-lisp.dev/manual/html_node/defcfun.html) は cffi ライブラリのマクロで、指定した名前の関数を生成します。

~~~lisp
CL-USER> (cffi:defcfun ("ceil" c-ceil) :double (number :double))
~~~

"ceil" という C 関数を Lisp 側では "c-ceil" と呼び、引数を1つ取り、それは double float で、戻り値も double float の数値である、と指定しています。

上の関数を `macrostep-expand` でマクロ展開すると次のようになります。

~~~lisp
(progn
  nil
  (defun c-ceil (number)
    (let ((#:g312 number))
      (cffi-sys:%foreign-funcall "ceil" (:double #:g312 :double) :convention
				 :cdecl :library :default))))
~~~

`ceil` ではなく `c-ceil` と呼んだ理由は、これは C のラッパーだとわかるようにするための、この例だけの都合です。組み込みの Common Lisp 関数やマクロを指す名前ではないので、"ceil" という名前にしてもかまいません。

`math.h` 由来の c-ceil 関数ができたので、使ってみましょう。double float を渡す必要があります。

~~~lisp
CL-USER> (c-ceil 5.4d0)
6.0d0
~~~

見てのとおり、動きます。期待どおり double が `6.0d0` に切り上げられました。

もう1つ試してみましょう。今度は [floor](https://en.cppreference.com/w/c/numeric/math/floor) を使います。この Common Lisp 関数はすでに存在するため、"floor" とは名付けられませんでした。

~~~lisp
CL-USER> (cffi:defcfun ("floor" c-floor) :double (number :double))
C-FLOOR
CL-USER> (c-floor 5d0)
5.0d0
CL-USER> (c-floor 5.4d0)
5.0d0
~~~

いいですね。

もう1つ、引き続き double float で math.h の `sqrt` を試しましょう。

~~~lisp
CL-USER> (cffi:defcfun ("sqrt" c-sqrt) :double (number :double))
C-SQRT
CL-USER> (c-sqrt 36.50d0)
6.041522986797286d0
~~~

新しい `c-sqrt` を使って算術演算もできます。

~~~lisp
CL-USER> (+ 2 (c-sqrt 3d0))
3.732050807568877d0
~~~

新しく輝く `c-sqrt` を使って double のリストを map し、すべての平方根を取ることさえできます。

~~~lisp
CL-USER> (mapcar #'c-sqrt '(3d0 4d0 5d0 6d0 7.5d0 12.75d0))
(1.7320508075688772d0 2.0d0 2.23606797749979d0 2.449489742783178d0
 2.7386127875258306d0 3.570714214271425d0)
~~~
