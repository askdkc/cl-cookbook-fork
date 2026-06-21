---
title: Common Lisp を始める
---

開発環境をインストールし、新しい Common Lisp プロジェクトを始めるための簡単な手順から始めます。

## 実装をインストールする

### パッケージマネージャを使う

どの Common Lisp 実装を使えばよいかわからない場合は、[SBCL](https://www.sbcl.org/) を試してください。

    apt-get install sbcl

Common Lisp は ANSI 標準ですが、実装が標準に加えて提供する機能は大きく異なることがあります。[Wikipedia の実装一覧](https://en.wikipedia.org/wiki/Common_Lisp#Implementations)を参照してください。

次の実装は Debian と、ほとんどの主要な Linux ディストリビューション向けにパッケージ化されています。

* [Steel Bank Common Lisp (SBCL)](http://www.sbcl.org/)
* [Embeddable Common Lisp (ECL)](https://gitlab.com/embeddable-common-lisp/ecl/)、C へコンパイルします。
* [CLISP](https://clisp.sourceforge.io/)

その他のよく知られた実装には次のものがあります。

* [ABCL](http://abcl.org/)、JVM と連携するための実装です。
* [ClozureCL](https://ccl.clozure.com/)、ビルド時間が非常に速い優れた実装です。
* [CLASP](https://github.com/drmeister/clasp)、LLVM を使ってネイティブコードへコンパイルし、C++ ライブラリと相互運用します。
* [SICL](https://github.com/robert-strandh/SICL)、新しいモジュール式の実装です。
* [LispWorks](http://www.lispworks.com/)（プロプライエタリ）
* [AllegroCL](https://franz.com/products/allegrocl/)（プロプライエタリ）

また、古い実装として次のものがあります。

* [CMUCL](https://gitlab.common-lisp.net/cmucl/cmucl)、Carnegie Mellon University で開発され、SBCL の派生元になった実装です。
* [GNU Common Lisp](https://en.wikipedia.org/wiki/GNU_Common_Lisp)
* ほかにもあります。


### macOS の場合

[homebrew](https://brew.sh) を使って SBCL をインストールします。

```shell
brew install sbcl
```

Homebrew で Emacs エディタをインストールすることもできますが、Common Lisp を使うために*必須*ではありません。ターミナルで SBCL を使う方法は後述します。また、Editor Support の節も参照してください。

```shell
brew tap d12frosted/emacs-plus
brew install emacs-plus
```


### Windows の場合

上記のすべての実装は Windows にインストールできます。

SBCL は [Chocolatey](https://community.chocolatey.org/packages/sbcl) で入手できますが、これは*公式の*インストール方法ではありません。

    > choco install sbcl

[plain-common-lisp](https://github.com/pascalcombier/plain-common-lisp/) も使えます。これは Windows 上でネイティブな Common Lisp 環境を得るための簡単な方法です。Emacs と Slime、Quicklisp、SBCL を数クリックでインストールできます。ワークスペース内でアーカイブを展開するだけです。

または、Emacs を自分でインストールして設定することもできます。

    > choco install emacs

### Docker を使う

すでに [Docker](https://docs.docker.com) を知っているなら、Common Lisp をかなり素早く始められます。[clfoundation/cl-devel](https://hub.docker.com/r/clfoundation/cl-devel) イメージには、最近の SBCL、CCL、ECL、ABCL に加えて、ホームディレクトリ（`/home/cl`）にインストール済みの Quicklisp が含まれているので、すぐにライブラリを `ql:quickload` できます。

Docker は GNU/Linux、Mac、Windows で動作します。

次のコマンドは必要なイメージ（圧縮状態で約 1.0GB）をダウンロードし、指定した場所にローカルのソースを Docker イメージ内へ入れ、SBCL REPL に入ります。

    docker run --rm -it -v /path/to/local/code:/home/cl/common-lisp/source clfoundation/cl-devel:latest sbcl

それでも Emacs と SLIME を使って開発したいので、SLIME を Docker 内の Lisp に接続する必要があります。その設定を助けるライブラリである [slime-docker](https://gitlab.common-lisp.net/cl-docker-images/slime-docker) を参照してください。

### asdf-vm パッケージマネージャを使う

[asdf-vm](http://asdf-vm.com/) ツールは、大きなランタイムとツールのエコシステムを管理するために使えます。

[Steel Bank Common Lisp (SBCL)](http://www.sbcl.org/) は [asdf-sbcl plugin](https://github.com/smashedtoatoms/asdf-sbcl) 経由で利用できます。

次のようにインストールします。

```shell
asdf plugin-add sbcl https://github.com/smashedtoatoms/asdf-sbcl.git
```

<a id="with-roswell"></a>

### Roswell を使う

[Roswell](https://github.com/roswell/roswell/wiki) は、次のような Common Lisp ツールです。

* 実装マネージャ: Common Lisp 実装（`ros install ecl`）、実装の正確なバージョン（`ros install sbcl/1.2.0`）のインストール、使うデフォルト実装の変更（`ros use ecl`）を簡単にします。
* スクリプティング環境（シェルから Lisp を実行したり、コマンドライン引数を取得したりするのを助けます）。
* プログラムのインストーラ。
* テスト環境（一般的な Continuous Integration プラットフォーム上も含めてテストを実行するため）。
* ビルドユーティリティ（イメージと実行ファイルを移植性のある方法でビルドするため）。

インストール方法はいくつかあり、wiki で見つかります（Debian パッケージ、Windows インストーラ、Brew/Linux Brew など）。


## REPL を起動する

コマンドラインで実装の実行ファイルを起動するだけで、REPL（Read Eval Print Loop）、つまり対話的インタプリタに入れます。

終了するには `(quit)` または `ctr-d` を使います（一部の実装）。

サンプルセッションを示します。`sbcl` バイナリを起動し、起動メッセージが表示され、Lisp プロンプト（`* `）に入り、lisp フォームを入力し、その後終了します。

```
user@debian:~$ sbcl
This is SBCL 2.1.11.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* (+ 1 2)

3
* (quit)
user@debian:~$
```


### ファイルをロード、再ロードする

REPL で Lisp コードを評価しました。おめでとうございます。もちろん、コードは `.lisp` ファイルに書きたくなるでしょう。

`sbcl --load myfile.lisp` を使うと、このファイルをロード、コンパイル、実行できます。トップレベルのコマンドが実行された後も Lisp プロセスは終了せず、REPL が表示されるので、作業を続けられます。

<!-- xxx: "compile" must be puzzling since this doesn't create a binary. -->

.lisp ファイルを編集した後、終了して SBCL コマンドを再び呼び出してファイルを `--load` する必要はありません。REPL 内から単に `load` できます。

```
$ sbcl --load myfile.lisp

a… bunch… of… awesome… stuff

* (load "myfile.lisp")
```

この `* ` の部分に気づきましたか。これはターミナルでのデフォルトの Lisp プロンプトです。エディタ内では通常、現在のパッケージを示す `CL-USER>` が表示されます。

エディタといえば、もちろん、よく設定されたエディタを使えば、はるかに対話的なワークフローを得られます。ただし、この方法でもすでに作業できます。

### より使いやすい REPL: rlwrap

少なくとも SBCL では、REPL はそのままだとあまり使いやすくありません。履歴（以前に入力したコマンド）を呼び出すための矢印キーが動かず、組み込み Lisp 関数の補完もありません。

`rlwrap` をインストールして使うことで、機能を少し強化できます。

| **オペレーティングシステム** | **コマンド**             |
|----------------------|--------------------------|
| Linux (Debian)       | `apt-get install rlwrap` |
| macOS                | `brew install rlwrap`    |
| Windows              | `choco install rlwrap`   |


次のように起動します。

    rlwrap sbcl

これにより、素のターミナル REPL に*ある程度*の使い勝手が加わります。ただし、このようなターミナル REPL で作業するかわりに、もっとよい編集体験を提供するようエディタを設定します。[editor-support](editor-support.html) を参照してください。

<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px;">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>TIP:</strong> CLISP 実装は、ターミナル向けによりよいデフォルト REPL を持っています（readline 機能、シンボル補完）。<code>clisp -on-error abort</code> を使えば、デバッガなしでエラーメッセージを得ることもできます。ちょっと試すには便利ですが、エディタを設定し、SBCL または CCL を使うことをおすすめします。
</div>


<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px; margin-top:1em;">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>TIP:</strong>
 rlwrap に <code>-c</code> スイッチを追加すると、ファイル名を自動補完できます。
</div>

### より使いやすい REPL: ICL

[ICL](https://github.com/atgreen/icl)、Interactive Common Lisp は、ターミナル向けの拡張 REPL です。システム上にあるどの実装でも動作します。多くの便利な機能をもたらします。よいエディタの代わりにはなりませんが、実際にそれを補完できます。

ICL は次を提供します。

- readline 風の編集を備えた**モダンな対話体験**: 永続的な履歴、タブ補完、拡張可能なコマンドシステム。
  - Lisp コードを理解しているので `rlwrap` より優れています。Lisp 組み込みや自分のコードに対して TAB 補完を提供します。
- ターミナルで動作します。
- Web ブラウザでも動作し、そこで
  - パッケージとシステムを閲覧できます。
  - ドキュメントをクリックして閲覧できます。
  - 対話的なデータインスペクタを使えます。
  - 特定の変数の内容を視覚的に表示できます（JSON 文字列、バイト配列内の画像など）。
    - 独自の可視化関数を定義できます。
    - 変数が変化するにつれて表現が更新されるのを監視できます。
  - パフォーマンスプロファイリング用の対話的な Speedscope フレームグラフを起動できます。
  - コードカバレッジレポートを実行できます（sb-cover を使用、SBCL のみ）。
  - そして、きっとほかにもあります。
- エディタ（Emacs）から起動し、ブラウザウィンドウの便利な機能すべてと接続することもできます。

ICL は初心者にもやさしいことにも注意してください。対話的デバッガを持ちません。その代わり、どんなエラーも処理し、エラーメッセージを表示し、プログラマが `,bt` コマンドでバックトレースを見られるようにします。

GNU/Linux ではビルド済みバイナリとパッケージ（.deb、.rpm）で、Windows では zip、exe、MSI インストーラでインストールできます。[GitHub releases](https://github.com/atgreen/icl/releases) を参照してください。ビルドも簡単です。

`icl` がパス上にあるなら、起動します。

    $ icl
    COMMON-LISP-USER>

REPL を起動する前に、`--load / -l` オプションでファイルを `load` することもできます。

    $ icl -l mycode.lisp
    your… output…
    COMMON-LISP-USER> (your-function-is-available)

楽しんでください。

類似のプロジェクトに `cl-repl` があります。エディタの節を参照してください。

ICL は LLM の助けを借りてコーディングされたプロジェクトです。


### 対話的デバッガ

Lisp は本質的に対話的なので、エラーが起きた場合はデバッガに入ります。場合によってはこれが煩わしいこともあるため、SBCL の `--disable-debugger` オプションを使いたくなるかもしれません。

また、上で見た `icl` は対話的デバッガを持たず、エラーメッセージを表示し、バックトレースを表示できるようにする点にも注意してください。

## ライブラリ

Common Lisp には、フリーソフトウェアライセンスの下で利用できる何千ものライブラリがあります。次を参照してください。

* [awesome-cl](https://github.com/CodyReichert/awesome-cl) リスト、ライブラリのキュレーションリストです。
* [Quickdocs](http://quickdocs.org/) - CL 向けライブラリドキュメントホスティングです。
* [Cliki](http://www.cliki.net/)、Common Lisp の wiki です。

### 用語

* Common Lisp の世界では、**package** はシンボルをまとめ、カプセル化を提供する方法です。これは C++ の namespace、Python の module、Java のパッケージに似ています。

* **system** は、.asd ファイルと一緒に束ねられた CL ソースファイルの集合です。.asd ファイルは、それらをどうコンパイルしロードするかを記述します。system とパッケージの間には一対一の関係があることが多いですが、これはまったく必須ではありません。system は他の system への依存を宣言できます。system は [ASDF](https://common-lisp.net/project/asdf/asdf.html)（Another System Definition Facility）によって管理されます。ASDF は `make` や `ld.so` に似た機能を提供し、事実上の標準になっています。

* Common Lisp のライブラリまたはプロジェクトは、通常、1つまたは複数の ASDF system から構成されます（そして1つの Quicklisp プロジェクトとして配布されます）。

### Quicklisp をインストールする

[Quicklisp](https://www.quicklisp.org/beta/) は単なるパッケージマネージャではありません。すべてのライブラリが一緒にビルドできることを保証する中央リポジトリ（*dist*）でもあります。

<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px; margin: 1em;">
<strong>SEE ALSO:</strong> 新しい <a href="https://github.com/ocicl/ocicl/">OCICL</a> パッケージマネージャも参照してください。コマンドラインツールを提供し、プロジェクトローカルの依存関係で動作し（詳細は後述）、デフォルトで HTTPS を使い、Quicklisp から独立したリポジトリです。</div>

Quicklisp は独自の *dist* を提供しますが、自分たちで構築することも可能です。

インストールするには、次のどちらかを行います。

1- 任意の場所でこのコマンドを実行します。

    curl -O https://beta.quicklisp.org/quicklisp.lisp

そして Lisp REPL に入り、このファイルをロードします。

    sbcl --load quicklisp.lisp

または

2- Debian パッケージをインストールします。

    apt-get install cl-quicklisp

そして REPL からロードします。

~~~lisp
(load "/usr/share/common-lisp/source/quicklisp/quicklisp.lisp")
~~~

次に、どちらの場合も、引き続き REPL から実行します。

~~~lisp
(quicklisp-quickstart:install)
~~~

これにより `~/quicklisp/` ディレクトリが作成され、Quicklisp はそこで状態とダウンロードしたプロジェクトを管理します。

必要なら、Quicklisp を別の場所へインストールできます。たとえば Unix システムで隠しフォルダへインストールするには次のようにします。

~~~lisp
;; optional
(quicklisp-quickstart:install :path "~/.quicklisp")
~~~

最後に、新しい Lisp セッションを開始するたびに常に Quicklisp をロードするには、次を実行します。

~~~lisp
(ql:add-to-init-file)
~~~

これは CL 実装の init ファイルへ適切な内容を追加します。そうしない場合、Quicklisp や Quicklisp 経由でインストールしたライブラリを使いたいすべてのセッションで、`(load "~/quicklisp/setup.lisp")` を実行する必要があります。

たとえば `~/.sbclrc` には次の内容が追加されます。

~~~lisp
#-quicklisp
  (let ((quicklisp-init (merge-pathnames
                          "quicklisp/setup.lisp"
                          (user-homedir-pathname))))
    (when (probe-file quicklisp-init)
      (load quicklisp-init)))
~~~

### ライブラリをインストールする

REPL で次を実行します。

~~~lisp
(ql:quickload "system-name")
~~~

たとえば、これは文字列操作ライブラリ "[str](https://github.com/vindarel/cl-str/)" をインストールします。

~~~lisp
(ql:quickload "str")
~~~

以上です。すぐに使えます。

~~~lisp
(str:title-case "HELLO LISP!")
~~~

<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px; margin: 1em;">
<strong>SEE MORE:</strong> <code>package:a-symbol</code> 記法を理解するには、<a href="packages.html">パッケージ page</a> の "Accessing シンボル from a package" 節を読んでください。
</div>

一度に複数のライブラリをインストールできます。ここでは、正規表現用の [cl-ppcre](https://edicl.github.io/cl-ppcre/) と、ユーティリティライブラリである [Alexandria](https://alexandria.common-lisp.dev/draft/alexandria.html) をインストールします。

~~~lisp
(ql:quickload '("str" "cl-ppcre" "alexandria"))
~~~

Lisp REPL でサードパーティライブラリを使いたいときはいつでも、この `ql:quickload` コマンドを実行できます。そのライブラリがすでにファイルシステム上にインストールされていることがわかれば、2回目はネットワークにアクセスしません。ライブラリはデフォルトで `~/quicklisp/dists/quicklisp/` にインストールされます。

また、多数の Common Lisp ライブラリが Debian でパッケージ化されていることにも注意してください。パッケージ名は通常 cl- prefix で始まります（すべてを一覧するには `apt-cache search --names-only "^cl-.*"` を使います）。

たとえば `cl-ppcre` ライブラリを使うには、まず `cl-ppcre` パッケージをインストールする必要があります。

次に、SBCL では次のように使えます。

~~~lisp
(require "asdf")
(require "cl-ppcre")
(cl-ppcre:regex-replace "fo+" "foo bar" "frob")
~~~

ここでは Quicklisp がインストールされていないふりをして、ファイルシステム上で利用できるモジュールを `require` でロードしています。迷ったら `ql:quickload` を使えます。

その他のコマンドについては Quicklisp のドキュメントを参照してください。たとえば Quicklisp のディストリビューションをアップグレードまたはロールバックする方法を見てください。


## 高度な依存関係管理

Common Lisp プロジェクトは、次のどのフォルダにも置けます。

- `~/quicklisp/local-projects`
- `~/common-lisp`,
- `~/.local/share/common-lisp/source`,

ここにインストールされたライブラリは、すべてのプロジェクトで自動的に利用可能になります。

完全な一覧については、次の値を参照してください。

~~~lisp
(asdf/source-registry:default-user-source-registry)
~~~

および

~~~lisp
asdf:*central-registry*
~~~

`*central-registry*` は `asdf` パッケージ内のトップレベル変数で、いわゆる "\*earmuffs\*" を使って書かれています。これは便利な慣習です。[変数](variables.html) 章を参照してください。

### ライブラリの自分用バージョンを用意する。プロジェクトを clone する。

上記の性質により、任意のライブラリを `~/quicklisp/local-projects/` ディレクトリへ clone すれば、それは ASDF（および Quicklisp）に見つけられ、すぐに利用可能になります。

~~~lisp
(asdf:load-system "system")
~~~

または

~~~lisp
(ql:quickload "system")
~~~

両者の実用上の違いは、`ql:quickload` は system がまだインストールされていない場合、まずインターネットから取得しようとすることです。

local-projects 内のシンボリックリンクが、好みの別の場所を指していても動作することに注意してください。

### プロジェクトローカルなライブラリバージョンを扱う方法

ライブラリを1つのプロジェクトだけのためにローカルへインストールする必要がある場合、または依存関係リストをアプリケーションと一緒に簡単に配布したい場合は、[Qlot](https://github.com/fukamachi/qlot) または [ocicl](https://github.com/ocicl/ocicl/) を使えます。

どちらのプロジェクトもコマンドラインツールを提供し、ロックファイル（`qlfile.lock` と `ocicl.csv`）で依存関係を固定でき、グローバルな Quicklisp インストールに触れずに依存関係をローカルへインストールして管理するコマンド（`qlot install`、`ocicl install`）を提供します。

もちろん、ほかのエコシステムで主流になっている依存関係管理スタイル、つまり `npm` や `pip` などを思い浮かべているでしょう。しかし、これらのツールをここで紹介しているのは、Common Lisp ではそれほど必要になることが少ないからです。

<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px; margin: 1em;">
<strong>NOTE:</strong> 初心者はまだプロジェクトローカルな依存関係について心配する必要はありません。グローバルな Quicklisp 依存関係と quicklisp/local-projects/ だけでかなり先まで進めます。自分にとって最も簡単なツールを選んでください（きっと Quicklisp です）。
</div>

理由は少なくとも2つあります。まず、言語（およびその実装）は非常に安定しています。たとえば実装が *lisp syntax* の破壊的変更を導入することは*決して*ありません。ときどき小さな破壊的変更が入りますが、それに気づくのはかなり熱心なユーザーだけです。次に、エコシステムも非常に安定しており、通常、*ライブラリ作者は安定性のルールに従います*。非推奨警告が 12（十二）年残り続けているのを見たことがあります。全体として、Common Lisp の世界の初心者は、プロジェクトローカルな依存関係について、それほど、あるいはまったく心配する必要がありません。

この用途のための別のツールもいくつか挙げておきます。

Quicklisp は [Quicklisp bundles](https://www.quicklisp.org/beta/bundles.html) も提供しています。これは Quicklisp からエクスポートされ、Quicklisp を介さずにロードできる、自己完結した system の集合です。

最後に、*dist* の構築を助ける [Quicklisp controller](https://github.com/quicklisp/quicklisp-controller) があります。

## プロジェクトで作業する

Quicklisp とエディタの準備ができたので、ファイルに Lisp コードを書き、REPL と対話し始められます。

しかし、既存のプロジェクトで作業したい、または新しいプロジェクトを作成したい場合は、どう進めればよいのでしょうか。`defpackage` の正しい順序は何でしょうか。.asd ファイルには何を書くべきでしょうか。プロジェクトを REPL にロードするにはどうすればよいでしょうか。

### 新しいプロジェクトを作成する

プロジェクト構造のひな形作成を助けるプロジェクトビルダがあります。ここでは [cl-project](https://github.com/fukamachi/cl-project) を好んで使います。これはテストの骨組みも設定します。

要するに次のとおりです。

~~~lisp
(ql:quickload "cl-project")
(cl-project:make-project #P"./path-to-project/root/")
~~~

これは次のようなディレクトリ構造を作成します。

```
|-- my-project.asd
|-- my-project-test.asd
|-- README.markdown
|-- README.org
|-- src
|   `-- my-project.lisp
`-- tests
    `-- my-project.lisp
```

ここで `my-project.asd` は次のようになります。

~~~lisp
(asdf:defsystem "my-project"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()  ;; <== list of Quicklisp dependencies
  :components ((:module "src"
                :components
                ((:file "my-project"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "my-project-test"))))
~~~

そして `src/my-project.lisp` は次のようになります。

~~~lisp
(defpackage footest
  (:use :cl))
(in-package :footest)
~~~

- ASDF documentation: [defining a system with defsystem](https://common-lisp.net/project/asdf/asdf.html#Defining-systems-with-defsystem)

### 既存のプロジェクトをロードする方法

新しいプロジェクトを作成した、または既存のプロジェクトがあり、それを REPL で扱いたい。しかし Quicklisp はそれを知りません。どうすればよいでしょうか。

まず、`~/common-lisp`、`~/.local/share/common-lisp/source/`、`~/quicklisp/local-projects` のいずれかに作成または clone すれば、追加の手間なしで `(ql:quickload …)` できます。

そうでない場合は、先に system 定義（`.asd`）をコンパイルしてロードする必要があります。SLIME で `slime-asdf` contrib がロードされているなら、`.asd` 内で `C-c C-k`（*slime-compile-and-load-file*）を入力し、その後 `(ql:quickload …)` できます。

`C-c C-k` の代わりに、プログラムから `(asdf:load-asd "my-project.asd")` を使うこともできます。

通常、この段階で REPL 内で system に「入る」ことになります。

~~~lisp
(in-package :my-project)
~~~

最後に、ソース（`my-project.lisp`）を `C-c C-k` でコンパイルするか、フォーム内で `C-c C-c`（*slime-compile-defun*）により eval して、その結果を REPL で確認できます。

もう1つの解決策は、ASDF の既知プロジェクト一覧を使うことです。

~~~lisp
;; startup file like ~/.sbclrc
(pushnew "~/to/project/" asdf:*central-registry* :test #'equal)
~~~

ASDF は Quicklisp に統合されているので、すぐに自分のプロジェクトを `quickload` できます。

Happy hacking !


## 追加設定

SBCL のデフォルトエンコーディング形式を utf-8 に設定したくなるかもしれません。

    (setf sb-impl::*default-external-format* :utf-8)

これは `~/.sbclrc` に追加できます。

REPL がすべてのシンボルを大文字で表示するのが嫌なら、次を追加します。

    (setf *print-case* :downcase)

<div class="info-box warning">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>Warning:</strong> これは、一部のパッケージの動作を壊す可能性があります。実際に <a href="https://github.com/fukamachi/mito/issues/45">Mito</a> で起きました。本番では避けてください。
</div>


## 関連項目

- [OCICL](https://github.com/ocicl/ocicl/) - ASDF system の配布と管理、コード lint、プロジェクトのひな形作成のための、quicklisp のモダンな代替です。
- [cl-cookieproject](https://github.com/vindarel/cl-cookieproject) - エントリポイントとユニットテストを備えた、すぐ使えるプロジェクトのためのプロジェクトスケルトンです。`src/` サブディレクトリ、追加のメタデータ、5AM テストスイート、バイナリをビルドする方法、CLI args 解析の例、Roswell 統合を含みます。

## クレジット

* [https://wiki.debian.org/CommonLisp](https://wiki.debian.org/CommonLisp)
