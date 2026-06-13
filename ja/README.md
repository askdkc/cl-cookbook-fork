
<br />
<p align="center">

  <h1 align="center">The Common Lisp クックブック</h1>

  <p align="center">
    コードファーストな Common Lisp レシピ集。
	<br />
    <a href="https://lispcookbook.github.io/cl-cookbook/"><strong>オンラインで読む »</strong></a>
    <br />
    <br />
    <a href="https://github.com/LispCookbook/cl-cookbook/releases">ニュース</a>
    ·
    <a href="https://github.com/LispCookbook/cl-cookbook/releases">EPUB と PDF</a>
    ·
    <a href="https://github.com/LispCookbook/cl-cookbook/issues?q=is%3Aissue%20state%3Aopen%20label%3A%22good%20first%20issue%22">貢献する</a>
  </p>
</p>

クックブック は、理論的な背景をすべて説明するのではなく、さまざまなことを明快な形で行う方法を示す、非常に価値のある資料です。単に調べたいだけのこともあります。クックブック は [HyperSpec][hs] のような正式なドキュメントや [Practical Common Lisp][pcl] のような書籍を決して置き換えるものではありませんが、どの言語にもよい クックブック があるべきです。Common Lisp も例外ではありません。

CL クックブック は、初心者からより高度な開発者までを対象に、あらゆる種類のトピックを扱うことを目指しています。

<p align="center">
  <a href="https://lispcookbook.github.io/cl-cookbook/">
    <img src="https://lispcookbook.github.io/cl-cookbook/orly-cover.png" alt="Logo" max-width="150">
  </a>
</p>

## 貢献

クックブック への貢献ありがとうございます。

まず [style guide](STYLEGUIDE.md) を見てください。

新しい内容を追加するときは、正しくレンダリングされることを確認してください。

これには3つの方法があります。

### Jekyll をシステム全体にインストールする

最初の選択肢は、[Jekyll][jekyll] をグローバルにインストールし、このリポジトリをチェックアウトしたフォルダで `jekyll serve` を実行することです。

その後、`http://127.0.0.1:4000/cl-cookbook/` を開きます（最後の `/` が重要です）。

### Ruby gems を使ってシステムをローカルにインストールする

別の選択肢は、このリポジトリの Jekyll 版を Ruby gems でローカルにインストールすることです。bundler 1.17.3 はかなり古い Ruby 2.5 を必要とするため、`rbenv` を使ってインストールすることをおすすめします。

1. パッケージマネージャで [rbenv](https://github.com/rbenv/rbenv) をインストールするか、[こちらの手順](https://github.com/rbenv/rbenv#basic-github-checkout)に従って手動でインストールします。
2. [ruby-build](https://github.com/rbenv/ruby-build#installation) をインストールします。前の手順で手動インストールした場合は、ruby-build を rbenv plugin としてインストールすることをおすすめします。
3. `rbenv install 2.5.0` を実行して Ruby 2.5.0 をインストールします。`which gem` を実行して、`~/.rbenv/shims/gem` を指していることを確認します。
4. `gem install bundler -v 2.1.4` を実行して bundler をインストールします。
5. `cl-cookbook` ディレクトリへ `cd` し、`bundle install --path vendor/bundle` を実行して Jekyll をローカルにインストールします。
6. `bundle exec jekyll serve` を実行してサイトを生成し、ホストします。

### Docker container を使う

新しい Linux ベースのシステムに古い Ruby をインストールするのは少し面倒なことがあるため、別の選択肢として `docker` を使えます。

1. このディレクトリで `sudo docker build -t cl-cookbook .` を実行して container をビルドします。
2. このディレクトリから `sudo docker run -p 4000:4000 -v $(pwd):/cl-cookbook cl-cookbook` を実行して、container 内で Jekyll を実行します。
3. Web ブラウザを開き、`http://127.0.0.1:4000/cl-cookbook/` へ移動します。

このコマンドは現在の作業ディレクトリを container 内に mount します。incremental build が有効なので、container の再起動や再ビルドなしに最新の変更を確認できます。

### トラブルシューティング

システムに古いバージョンの ruby がインストールされていて、bundler install が失敗することがあります。これを直すには ruby を更新する必要があります。システム更新が選択肢でない場合は、[rbenv][rbenv] のインストールを検討してください。

~~~ sh
    # Check rbenv homepage for install instructions on systems other than Mac OS X
    brew install rbenv ruby-build

    # Add rbenv to bash so that it loads every time you open a terminal
    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
    source ~/.bash_profile

    # Install Ruby
    rbenv install 2.5.0
    rbenv global 2.5.0
    ruby -v
~~~

この後は通常どおり進められます。

1. `gem install bundler`
2. `bundle install --path vendor/bundle`
3. `bundle exec jekyll serve`

[CONTRIBUTING.md][contributing] ファイルも参照してください。

### EPUB と PDF をビルドする

EPUB だけをビルドするには `make epub`、PDF をビルドするには `make pdf` を実行します。両方をビルドするには `make epub+pdf` を実行します。`make-cookbook.lisp` を参照してください。

日本語版 EPUB は次で生成します。

~~~sh
npm install
make epub-ja
~~~

生成物は `ja/common-lisp-cookbook-ja.epub` です。`make epub-ja` は原典と同じ `make-cookbook.lisp` の処理を使い、`ja/` 以下の Markdown、`ja/metadata.txt`、`ja/epub.css`、`ja/orly-cover.png` を使って EPUB を作ります。コードブロックの syntax highlight には Shiki の light theme を使います。

必要な主な tool は `sbcl`、`pandoc`、`node`/`npm` です。`epubcheck` が入っている場合は、生成後に次で確認できます。

~~~sh
epubcheck ja/common-lisp-cookbook-ja.epub
~~~

epub には、ある程度新しいバージョンの [Calibre](https://calibre-ebook.com/) が必要です。簡単な binary installation が提供されています。

PDF については、2025-10-01 以降、[Typst](https://typst.app/) と [Pandoc >= 3.8](https://github.com/jgm/pandoc/releases/tag/3.8) が必要です。

出力からテキスト領域を除外するには（たとえば print format では意味のない埋め込み動画など）、次の flag を使います。

    <!-- epub-exclude-start -->
    <!-- epub-exclude-end -->

ビルドスクリプトはおおよそ次を行います。

- すべての markdown content を1つのファイルへ連結する
- yaml frontmatter を markdown title に変更する
- file から marked region を削除する
- EPUB で内部リンクが動くようにする
- PDF では、大きな .md ファイルを Pandoc で typst file へ変換し、その後 `typst compile` を実行する。これにより高品質な PDF が生成される。

`metadata.txt` の metadata をいくつか使います。

生成された EPUB は `epubcheck` で確認できます。

#### macOS でのビルドトラブルシューティング

次の error に遭遇した場合:

~~~
debugger invoked on a UIOP/RUN-PROGRAM:SUBPROCESS-ERROR in thread
#<THREAD tid=259 "main thread" RUNNING {1203FA81D3}>:
  Subprocess with command "sed -i \"s/title:/# /g\" full.md"
 exited with error code 1
~~~

これは `sed` program が GNU 版ではないことを意味します。`homebrew` を使って GNU 版をインストールしてください。

~~~sh
brew install gnu-sed
~~~

これで PATH に `gsed` が入るので、次のコマンドで book をビルドできます。

~~~sh
SED_CMD=gsed make epub
~~~

## 由来

これは SourceForge から移された [Common Lisp Cookbook][sf] の fork です。

このプロジェクトは Common Lisp クックブック をこの10年にふさわしいものにします。SourceForge にあった元の Common Lisp クックブック の開発は 2007 年に停止しました。その間、Common Lisp の世界では多くのことが起こりました。tool や implementation は改善され、使われなくなったものもあります。特に、Common Lisp user は今では [Quicklisp][ql] library manager の恩恵を受けられます。

主な目標は、content の更新と拡張に加えて、クックブック をより現代的で、よりアクセスしやすいものにすることです。

[sf]: http://cl-cookbook.sourceforge.net/
[ql]: https://www.quicklisp.org/
[hs]: http://www.lispworks.com/documentation/HyperSpec/Front/X_Master.htm
[pcl]: http://www.gigamonkeys.com/book/
[jekyll]: https://jekyllrb.com/docs/installation/
[rbenv]: https://github.com/rbenv/rbenv
[contributing]: CONTRIBUTING.md
[bundler-v2]: https://stackoverflow.com/questions/54087856/cant-find-gem-bundler-0-a-with-executable-bundle-gemgemnotfoundexceptio

## GNU Guix での開発

必要な software dependency がすべて利用可能になる development environment に入るには、project root directory で `guix shell` を実行します。提供されている Guix [manifest file](manifest.scm) は、Guix がそうするための [authorization](https://guix.gnu.org/manual/devel/en/html_node/Invoking-guix-shell.html) を与えた後、自動的に読み込まれます。

## 支援

クックブック を継続的に改善している個人を支援できます。Github Sponsors icon を参照してください。彼らに感謝します。
