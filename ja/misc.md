---
title: その他
---


<a name="opt"></a>

## 複雑なデータ構造を再利用する

関数を「関数型」らしく振る舞わせたい、つまり副作用なしに[fresh](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_f.htm#fresh)な結果を返したい場合があります。一方で、既存のデータを破壊的に再利用して変更したい場合もあります。例として [`append`](http://www.lispworks.com/documentation/HyperSpec/Body/f_append.htm) と [`nconc`](http://www.lispworks.com/documentation/HyperSpec/Body/f_nconc.htm) の違いを考えてください。

実は、オプショナル引数（またはキーワード引数）を使えば、どちらも実現できます。例を見てみましょう。2つの行列 `m1` と `m2` を引数に取り、`m1` と `m2` に依存したサイズの結果行列を計算して返す `complex-matrix-stuff` という関数を書いているとします。新しい結果を返すには、たとえば `(make-appropriate-result-matrix-for m1 m2)` で作られる空の行列が必要です。

この関数を古典的な教科書風に実装すると、おおよそ次のようになります。

~~~lisp
(defun complex-matrix-stuff (m1 m2)
  (let ((result (make-appropriate-result-matrix-for m1 m2)))
    ;; ... compute storing the results in RESULT
    result))
~~~

そして次のように使います。

~~~lisp
(setq some-matrix (complex-matrix-stuff A B))
~~~

しかし、次のように書いてはどうでしょうか。

~~~lisp
(defun complex-matrix-stuff (m1 m2
                             &optional
                             (result
                              (make-appropriate-result-matrix-for m1 m2)))
  ;; ... compute storing the results in RESULT
  result)
~~~

これで両方の使い方ができます。次のように、その場で「結果を作る」ことは今までどおりできます。

~~~lisp
(setq some-matrix (complex-matrix-stuff A B))
~~~

しかし、以前に割り当てた行列を（破壊的に）再利用することもできます。

~~~lisp
(complex-matrix-stuff A B some-appropriate-matrix-I-built-before)
~~~

または、関数を次のように使えます。

~~~lisp
(setq some-other-matrix
      (complex-matrix-stuff A B some-appropriate-matrix-I-built-before))
~~~

この場合、最終的には次のようになります。

~~~lisp
* (eq some-other-matrix some-appropriate-matrix-I-built-before)

T
~~~


<a name="adjust"></a>

## `SUBSEQ` で新しいシーケンスを cons する代わりに `ADJUST-ARRAY` を使う

シーケンスを扱うほとんどの CL 関数は `start` と `end` キーワードを受け付けるので、実際に部分シーケンスを作らずに、その部分シーケンス上で動作させることができます。つまり、次の代わりに

~~~lisp
(count #\a (subseq long-string from to))
~~~

当然、次を使うべきです。

~~~lisp
(count #\a long-string :start from :end to)
~~~

これは同じ結果を返しますが、不要な中間部分シーケンスを作りません。

しかし、新しいデータを作ることを避けられないように見える場合もあります。キーが文字列であるハッシュテーブルを考えてください。探しているキーが別の文字列の部分文字列である場合、おそらく次のように書くことになります。

~~~lisp
(gethash (subseq original-string from to)
         hash-table)
~~~

しかし、そうする必要はありません。_1つの_ [displaced](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_d.htm#displaced_array) 文字列を作り、[`adjust-array`](http://www.lispworks.com/documentation/HyperSpec/Body/f_adjust.htm) で何度も再利用できます。

~~~lisp
(let ((substring (make-array 0
                             :element-type 'character
                             :displaced-to ""
                             :displaced-index-offset 0)))
  ;; more code
  (gethash
   (adjust-array substring (- to from)
                 :displaced-to original-string
                 :displaced-index-offset from)
   hash-table)
  ;; even more code
  )
~~~
