Cookbook への貢献ありがとうございます。以下のガイドラインに従ってください。一部は単なる慣習ですが、一部は epub 生成にとって重要です。

## 見出し

- （重要）章の最初の section は subsection にしてください: `## title`（実際、epub での section 名は chapter 名になります）。

- 見出しは文のように書き、最初の単語だけを大文字にします。

- 関数を参照する場合は、markdown syntax も使ってください（backtics）。

## リスト

- 番号付き bullet list（`1.`）は最初の level でのみ使ってください。次の入れ子 level では、通常の番号なし list を使います。
- list は最初の item の前に newline を置く必要があります。


## コードの書式

- 関数は通常 backtics で参照してください。markdown の時代に大文字化する必要はありません。FUNCTION ではなく `function` と書いてください。

- 主流の style に合わせてコードを indent してください。わからない場合は Emacs の `lisp-mode` がどうするかを確認してください。

## コードスニペット

- コードスニペットには `~~~lisp` を使ってください。

- スニペットは行頭から始める必要があります。`~~~lisp` code fence を indent しないでください。

- コードスニペットの前後には newline が必要です。

```

Here's a snippet:

~~~lisp
(defun oh ())
~~~

This snippet...
```

- 例にとって非常に重要でない限り、"CL-USER> " のような lisp prompt は書かないでください。これは主に copy-paste しやすくするためです。

- スニペットの結果を示すには、スニペットが1行だった場合は同じ行に `;; => result` を使います。そうでない場合は次のようにできます。

~~~lisp
(print :abc)
;; :abc
~~~

結果が大きい場合は、comment なしの別の code block を使ってください。

- 行は 64 文字を超えないようにしてください。そうしないと PDF で切り詰められ、横スクロールバーが表示されます。


## EPUB の注意点

### 埋め込みコンテンツ

youtube 動画などの埋め込みコンテンツを乱用すべきではありません。

次の flag で EPUB 生成から除外してください。

    <!-- epub-exclude-start -->
    <!-- epub-exclude-end -->

### 内部リンク（EPUB 用）

EPUB reader で内部リンクが動くように、markdown link を調整する必要があります。リンクを追加するには `fix-epub-links.sed` を参照するか、GitHub で声をかけてください。

## PDF の注意点

### 画像

現在は markdown source を Typst へ変換してから PDF にしているため、HTML の `<img>` tag は処理されません。

`![](path/to/image.png)` syntax は問題なく動きますが、HTML tag は `max-width` などの CSS attribute を設定するのに便利です。

したがって、画像を追加するには次のようにしてください。

```txt
<img src="assets/sockets-lisp-chat.gif"
     width="470" height="247" alt="Chat app demo between two browser windows"/>

<!-- pdf-include-start
![](assets/sockets-lisp-chat.gif)
   pdf-include-end -->
```

最初の IMG は HTML render と EPUB でそのまま動きます。一方、HTML comment の間にある2つ目は常に無視されますが、PDF をビルドするとき（`make pdf`）には存在するようにしています。
