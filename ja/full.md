
 
#  Common Lisp Cookbook {#chapter-index}
 

> Cookbook, 名詞.
> 料理の作り方や調理に関するその他の情報を含む本。

Cookbook は、理論的な背景をすべて説明するのではなく、さまざまなことを明快な形で行う方法を示す、非常に価値のある資料です。単に調べたいだけのこともあります。Cookbook は HyperSpec のような正式なドキュメントや Practical Common Lisp のような書籍を決して置き換えるものではありませんが、どの言語にもよい cookbook があるべきです。Common Lisp も例外ではありません。

CL Cookbook は、初心者からより高度な開発者までを対象に、あらゆる種類のトピックを扱うことを目指しています。


# 内容

### はじめに

* [ライセンス](#chapter-license)
* [はじめに](#chapter-getting-started)
  * Common Lisp 実装をインストールする方法
  * Lisp REPL を起動する方法
  * Quicklisp でサードパーティライブラリをインストールする方法
  * プロジェクトで作業する方法
* [エディタ対応](#chapter-editor-support)
  * [Emacs を IDE として使う](#chapter-emacs-ide)
  * [LispWorks IDE](#chapter-lispworks)
  * [Alive で VSCode を使う](#chapter-vscode-alive)

### 言語の基礎

<p id="two-cols"></p>

* [変数](#chapter-variables)
* [関数](#chapter-functions)
* [データ構造](#chapter-data-structures)
* [文字列](#chapter-strings)
  + [format](#string-formatting-format)
* [正規表現](#chapter-regexp)
* [数値](#chapter-numbers)
* [等価性](#chapter-equality)
* [ループ、反復、マッピング](#chapter-iteration)
* [多次元配列](#chapter-arrays)
* [日付と時刻](#chapter-dates_and_times)
* [パターンマッチング](#chapter-pattern_matching)
* [入出力](#chapter-io)
* [ファイルとディレクトリ](#chapter-files)
* [CLOS (Common Lisp Object System)](#chapter-clos)

### 発展的なトピック

<p id="two-cols"></p>

* [パッケージ](#chapter-packages)
* [システムの定義](#chapter-systems)
* [エラーとコンディションの処理](#chapter-error_handling)
* [デバッグ](#chapter-debugging)
* [マクロとバッククォート](#chapter-macros)
* [型システム](#chapter-type)
* [並行性と並列性](#chapter-process)
* [パフォーマンスチューニング](#chapter-performance)
* [テストと継続的インテグレーション](#chapter-testing)
* [スクリプト。実行ファイルの構築](#chapter-scripting)
* [ストリーム](#chapter-streams)

### 外の世界

<p id="two-cols"></p>

* [OS との連携](#chapter-os)
* [データベース](#chapter-databases)
* [外部関数インターフェイス](#chapter-ffi)
* [動的ライブラリの構築](#chapter-dynamic-libraries)
* [GUI プログラミング](#chapter-gui)
* [ソケット](#chapter-sockets)
* [WebSockets][WebSockets]
* [Web 開発](#chapter-web)
* [ウェブスクレイピング](#chapter-web-scraping)



{{PDF-TOCS}}

   


## EPUB と PDF でダウンロード

Cookbook は EPUB 形式と PDF 形式でも利用できます。

[EPUB](https://github.com/askdkc/cl-cookbook-fork/releases/download/2026-06-24/common-lisp-cookbook-ja.epub) と [PDF](https://github.com/askdkc/cl-cookbook-fork/releases/download/2026-06-24/common-lisp-cookbook-ja.pdf) を直接ダウンロードできます。また、開発をさらに支援するために [**支払いたい金額を支払う**](https://github.com/sponsors/askdkc) こともできます。

2026 年以降、PDF は Typst で生成されており、品質が向上しています。


<a style="font-size: 16px; background-color: #4CAF50; color: white; padding: 16px; cursor: pointer;" href="https://github.com/sponsors/askdkc">
  寄付して PDF と EPUB をダウンロードする
</a>


ありがとうございます。


## 翻訳

Cookbook は次の言語に翻訳されています。

* [簡体字中国語](https://oneforalone.github.io/cl-cookbook-cn/#/) ([Github](https://github.com/oneforalone/cl-cookbook-cn))
* [ポルトガル語 (ブラジル)](https://lisp.com.br/cl-cookbook/) ([Github](https://github.com/commonlispbr/cl-cookbook))
* [日本語](https://askdkc.github.io/cl-cookbook-fork/ja/) ([Github](https://github.com/askdkc/cl-cookbook-fork))

## その他の CL リソース

<p id="two-cols"></p>

* [lisp-lang.org](http://lisp-lang.org/): 成功事例、チュートリアル、スタイルガイド
* [awesome-cl](https://github.com/CodyReichert/awesome-cl): ライブラリの厳選リスト
* 🖌️ [lisp-screenshots.org](https://www.lisp-screenshots.org/): 現在動作している Common Lisp アプリケーションのギャラリー
* [Lisp コミュニティ一覧](https://github.com/CodyReichert/awesome-cl#community)
* [Lisp Koans](https://github.com/google/lisp-koans/) - 多くの言語機能を段階的に学習者に案内する、言語学習用の演習です。
* [Learn X in Y minutes - Where X = Common Lisp](https://learnxinyminutes.com/docs/common-lisp/) - 要点を扱う小さな Common Lisp チュートリアルです。
* [Common Lisp ライブラリ Read the Docs](https://common-lisp-libraries.readthedocs.io/) - よく使われるライブラリのドキュメントを、現代的で見やすい Read The Docs のスタイルに移植したものです。
* [lisp-tips](https://github.com/lisp-tips/lisp-tips/issues/)
* [Common Lisp and CLOG チュートリアルシリーズ](https://github.com/rabbibotton/clog/blob/main/LEARN.md): Common Lisp と CLOG のチュートリアルです。CLOG は web 技術に基づく Common Lisp 向け GUI 風ライブラリです。
* Nick Levine による [Lisp and Elements of Style](http://web.archive.org/web/20190316190256/https://www.nicklevine.org/declarative/lectures/)
* Pascal Costanza の [Highly Opinionated Guide to Lisp](http://www.p-cos.net/lisp/guide.html)
* [Cliki](http://www.cliki.net/): Common Lisp の wiki
* 📹 [Common Lisp programming: from novice to effective developer](https://www.udemy.com/course/common-lisp-programming/?referralCode=2F3D698BBC4326F94358): Udemy 上の動画講座 (有料) で、Cookbook の主要な貢献者の一人によるものです。*"Udemy での私の仕事を支援してくれてありがとうございます。学生であれば無料クーポンを求めてください。"* vindarel

加えて、Jeff Dalton による [Common Lisp Pitfalls](https://github.com/LispCookbook/cl-cookbook/issues/479) もあります。



書籍

* Peter Seibel による [Practical Common Lisp](http://www.gigamonkeys.com/book/)
* Edmund Weitz による [Common Lisp Recipes](http://weitz.de/cl-recipes/)。2016 年出版。
* David S. Touretzky による [Common Lisp: A Gentle Introduction to Symbolic Computation](http://www-2.cs.cmu.edu/~dst/LispBook/)
* David B. Lamkins による [Successful Lisp: How to Understand and Use Common Lisp](https://successful-lisp.blogspot.com/p/httpsdrive.html)
* Paul Graham による [On Lisp](http://www.paulgraham.com/onlisptext.html)
* Guy L. Steele による [Common Lisp the Language, 2nd Edition](http://www-2.cs.cmu.edu/Groups/AI/html/cltl/cltl2.html)
  * [PDF 形式の CLtL2](https://github.com/mmontone/cltl2-doc)
* Peter Norvig と Kent Pitman による [A Tutorial on Good Lisp Style](https://www.cs.umd.edu/%7Enau/cmsc421/norvig-lisp-style.pdf)

発展的な書籍

* Mark Watson による [Loving Lisp - the Savy Programmer's Secret Weapon](https://leanpub.com/lovinglisp/)
* [Programming Algorithms](https://leanpub.com/progalgs) - Lisp の例を使って効率的なプログラムを書くための包括的なガイドです。


仕様

* Kent M. Pitman による [The Common Lisp HyperSpec](http://www.lispworks.com/documentation/HyperSpec/Front/index.htm) ([Dash](https://kapeli.com/dash)、[Zeal](https://zealdocs.org/)、[Velocity](https://velocity.silverlakesoftware.com/) でも利用できます)
* [The Common Lisp Community Spec](https://cl-community-spec.github.io/pages/index.html) - ANSI の仕様書ドラフトから生成された新しい表示で、誰でも編集する権利があります。

## さらにひと言

これは、O'Reilly が出版した [Perl Cookbook][perl] と似たものを Common Lisp 向けに提供することを目指す共同プロジェクトです。これが何であり、何でないかについての詳細は、[comp.lang.lisp][cll] のこの [スレッド][thread] にあります。

CL Cookbook に貢献したい場合は、pull request を送るか、課題を登録してください。

そう、あなたに話しています。私たちは貢献者を必要としています。足りない章を書いて追加する、未解決の質問を見つけて答えを提供する、バグ、誤字、文法エラーを見つけて報告する、などです。整形は心配しないでください。望むならプレーンテキストを送るだけでもかまいません。その後の整形はこちらで対応します。

ご協力にあらかじめ感謝します。

Github 上のページは最新に保たれています。オフラインでの閲覧用に [最新の zip ファイル][zip] をダウンロードすることもできます。詳しい情報は [Github のプロジェクトページ][gh] にあります。



[cll]: news:comp.lang.lisp
[perl]: http://www.oreilly.com/catalog/cookbook/
[thread]: http://groups.google.com/groups?threadm=m3it9soz3m.fsf%40bird.agharta.de
[toc]: http://www.oreilly.com/catalog/cookbook/
[zip]: https://github.com/LispCookbook/cl-cookbook/archive/master.zip
[gh]: https://github.com/LispCookbook/cl-cookbook
 
#  ライセンス {#chapter-license}
 

## 日本語訳

"Common Lisp Cookbook" を元の形式（Markdown）または「派生」形式（HTML、PDF、Typst など）で、変更の有無にかかわらず再配布および使用することは、次の条件を満たす限り許可されます。

* 再配布物は、上記の著作権表示、この条件、および次の免責事項を、文書自体および/または配布物に付属するその他の資料に再掲しなければなりません。

**重要:** この文書は Common Lisp Cookbook Project によって「現状のまま」提供され、明示または黙示のいかなる保証も否認されます。これには、商品性および特定目的への適合性に関する黙示の保証が含まれますが、それらに限定されません。いかなる場合においても、Common Lisp Cookbook Project は、この文書の使用に起因して何らかの形で発生した、直接的、間接的、付随的、特別、懲罰的、または結果的損害（代替商品またはサービスの調達、使用不能、データまたは利益の損失、事業中断を含みますが、それらに限定されません）について、契約、厳格責任、不法行為（過失その他を含む）その他いかなる責任理論に基づくものであっても、そのような損害の可能性を知らされていた場合であっても、責任を負いません。

LispCookbook Github Group 追補: この文書は現在、変更された形式で管理されています。

Copyright:
2015-2025 LispCookbook Github Group,
2002-2007 The Common Lisp Cookbook Project.

## Original

Redistribution and use of the "Common Lisp Cookbook" in its original form (Markdown)
or in 'derived' forms (HTML, PDF, Typst and so forth) with or without
modification, are permitted provided that the following condition is met:

* Redistributions must reproduce the above copyright notice, this and the
  following disclaimer in the document itself and/or other materials provided
  with the distribution.

**IMPORTANT:** This document is provided by the Common Lisp Cookbook Project "as
is" and any expressed or implied warranties, including, but not limited to, the
implied warranties of merchantability and fitness for a particular purpose are
disclaimed. In no event shall the Common Lisp Cookbook Project be liable for any
direct, indirect, incidental, special, exemplary, or consequential damages
(including, but not limited to, procurement of substitute goods or services;
loss of use, data, or profits; or business interruption) however caused and on
any theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use of this
documentation, even if advised of the possibility of such damage.

LispCookbook Github Group addendum: this document is now managed in a modified format.

Copyright:
2015-2025 LispCookbook Github Group,
2002-2007 The Common Lisp Cookbook Project.
 
#  まえがき {#chapter-foreword}
 

<!-- EPUB 版と PDF 版のためのものです -->

Common Lisp Cookbook は共同で作られている資料です。これまでに力を貸してくださったすべての方に感謝します。

<!-- この Cookbook が、日々の幅広い作業で Common Lisp を学ぶ助けになることを目指しています。 -->
<!-- Lisp 初学者にはチュートリアル（入門、関数、CLOS など）として、 -->
<!-- そして誰にとってもリファレンス（loop!）として使えます。 -->

これらの EPUB 版と PDF 版によって、学習体験がさらに実用的で楽しいものになることを願っています。


> Vincent "vindarel" Dardel、Cookbook contributors を代表して、2026年1月。
 
#  Common Lisp を始める {#chapter-getting-started}
 

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

[​]{#with-roswell}

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

これにより、素のターミナル REPL に*ある程度*の使い勝手が加わります。ただし、このようなターミナル REPL で作業するかわりに、もっとよい編集体験を提供するようエディタを設定します。[editor-support][Editor support] を参照してください。

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

* Common Lisp の世界では、**パッケージ**はシンボルをまとめ、カプセル化を提供する方法です。これは C++ の名前空間、Python のモジュール、Java のパッケージに似ています。

* **システム**は、.asd ファイルと一緒に束ねられた CL ソースファイルの集合です。.asd ファイルは、それらをどうコンパイルしロードするかを記述します。システムとパッケージの間には一対一の関係があることが多いですが、これはまったく必須ではありません。システムは他のシステムへの依存を宣言できます。システムは [ASDF](https://common-lisp.net/project/asdf/asdf.html)（Another System Definition Facility）によって管理されます。ASDF は `make` や `ld.so` に似た機能を提供し、事実上の標準になっています。

* Common Lisp のライブラリまたはプロジェクトは、通常、1つまたは複数の ASDF システムから構成されます（そして1つの Quicklisp プロジェクトとして配布されます）。

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
<strong>SEE MORE:</strong> <code>package:a-symbol</code> 記法を理解するには、<a href="#chapter-packages">パッケージ page</a> の "Accessing シンボル from a package" 節を読んでください。
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

`*central-registry*` は `asdf` パッケージ内のトップレベル変数で、いわゆる "\*earmuffs\*" を使って書かれています。これは便利な慣習です。[変数](#chapter-variables) 章を参照してください。

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
 
#  エディタサポート {#chapter-editor-support}
 

今でも定番のエディタは [Emacs](https://www.gnu.org/software/emacs/) ですが、選択肢はそれだけではありません。

このエコシステムに初めて触れる人には、まず ICL の拡張 REPL と `mine` を試してみることを勧めます。

## Emacs

[SLIME](https://github.com/slime/slime/) は Emacs 向けの Superior Lisp Interaction Mode です。実行中の Common Lisp プロセスとやり取りし、コンパイル、デバッグ、ドキュメント検索、クロスリファレンスなどを扱えます。多くの処理系で動作します。

[IDEmacs](https://codeberg.org/IDEmacs/IDEmacs) は、Emacs を初心者に使いやすくしようとする試みです。Common Lisp 用に Sly が同梱されています。Emacs v29 以降では、新しい `--init-directory` オプションのおかげで、.emacs 設定を汚さず一時的に IDEmacs を試せます。[Doom](https://github.com/doomemacs/doomemacs/blob/3e15fb36d7f94f0a218bda977be4d3f5da983a71/modules/lang/common-lisp/README.org#L9) や [Spacemacs](https://www.spacemacs.org/layers/LAYERS.html#lisp-dialects) など、ほかの Emacs ディストリビューションにも CL サポートが含まれています（それぞれ Sly と Slime）。

[plain-common-lisp](https://github.com/pascalcombier/plain-common-lisp/) は、**Windows** 向けに作られた、インストールしやすい Common Lisp 環境です。Emacs、SBCL、Slime、Quicklisp が同梱されています。また、Win32、Tk、IUP、ftw、Opengl で GUI ウィンドウを表示する方法も示しています。

[lisp-stat の Docker イメージ](https://lisp-stat.dev/blog/2026/03/09/getting-started/) には、すぐ使える Emacs が含まれています。

```
$ docker run --rm -it ghcr.io/lisp-stat/ls-dev:latest ls-repl
$ emacs
… then Alt-x slime
```


<img src="assets/plain-cl-slime-interaction.png"
     style="max-width: 800px" alt="Emacs and SLIME."/>


![](assets/plain-cl-slime-interaction.png)
   

<!-- todo: PDF generation: lacks IMG images -->


### Emacs を IDE として使う

["Using Emacs as an IDE"][Using Emacs as an IDE] を参照してください。


## Vim & Neovim

[Slimv](https://github.com/kovisoft/slimv) は、Vim 内で Common Lisp を扱うための本格的な環境です。

[Vlime](https://github.com/vlime/vlime) は Vim（および Neovim）向けの Common Lisp 開発環境で、Emacs の SLIME や Vim の SLIMV に似ています。

<img src="assets/slimv.jpg"
     style="width: 800px" alt="The Slimv plugin with an open REPL"/>


![](assets/slimv.jpg)
   

[cl-neovim](https://github.com/adolenc/cl-neovim/) を使うと、Common Lisp で Neovim プラグインを書けます。

[quicklisp.nvim](https://gitlab.com/HiPhish/quicklisp.nvim) は Quicklisp 向けの Neovim フロントエンドです。

[Slimv_box](https://github.com/justin2004/slimv_box) は、手早くインストールできるよう、Vim、SBCL、ABCL、tmux を Docker コンテナで提供します。

関連項目:

* [Lisp in Vim](https://susam.net/blog/lisp-in-vim.html) は使い方を実演し、Slimv と Vlime の両方を比較しています

## Mine: Common Lisp と Coalton のための単一ダウンロード IDE

`mine` は、*Common Lisp* と [Coalton](https://coalton-lang.github.io/)（Common Lisp の静的型付き関数型スーパーセット）の*両方*に対応した、まったく新しい（2026 年 4 月リリースの）ターミナルベース IDE です。

> `mine` は、Lisp プログラマがこのエコシステムを特徴づけるものとしてよく挙げる、対話的でインクリメンタルな開発ワークフローを体験するために必要なものをすべて備えた、単一ダウンロードの完全なアプリケーションです。ホットリロードやその場でのデバッグも含まれています。

- [Mine のホームページ](https://coalton-lang.github.io/mine/)
  - 👉 [Windows、MacOS、GNU/Linux 向けの最新リリースをダウンロード](https://github.com/coalton-lang/coalton/releases/latest)
- [Introducing mine, a Coalton and Common Lisp IDE](https://coalton-lang.github.io/20260424-mine/)
- youtube: [`mine` を紹介する動画](https://www.youtube.com/watch?v=qe3vDKQShKs)

<img src="assets/mine-screenshot.png"
     style="width: 80%" alt="The beginner friendly mine editor."/>

`mine` の機能:

- 重大なエラーから無害な最適化メモまで表示するインライン**診断**
- 読みやすいバックトレースを備えた統合**デバッガ**
- 定義へジャンプ（Lisper におなじみの meta-dot）
- パッケージニックネームを認識する**補完**
- 引数リストと関数型のリアルタイム表示
- シンタックスハイライト
- 自動インデント
- 構造編集
- **プロジェクト作成**とセットアップ
- 組み込みの **Quicklisp セットアップ**
- ネイティブコードコンパイラと実行ファイルビルダー

ぜひ試してみてください。

また、`mine` が少し変わっている点にも注意してください。

> mine は、かつての QBASIC や Borland Turbo 製品のように簡単であることを目指しています


## Pulsar（旧 Atom）

[SLIMA](https://github.com/neil-lindquist/slima) を参照してください。このパッケージを使うと、Common Lisp コードを対話的に開発でき、Atom、現在では [Pulsar](https://github.com/pulsar-edit/pulsar) をかなり優れた Lisp IDE にできます。主な機能は次のとおりです。

* REPL
* 統合デバッガ
  * （まだステップ実行デバッガではありません）
* 定義へジャンプ
* コードに基づく補完候補
* この関数をコンパイル、このファイルをコンパイル
* 関数引数の順序
* 統合プロファイラ
* 対話的なオブジェクト調査。

これは、Emacs の Slime と同じく Swank バックエンドに基づいています。

**重要なお知らせ**: 執筆時点では、SLIMA は最新の Slime ソースでは動作しません。[Slime 2.27](https://github.com/slime/slime/releases/tag/v2.27) で動作確認しました。SBCL 2.5.8 と SBCL 2.1.11.debian で動作しました。この 1 つの設定については、SLIMA のドキュメントに従ってください。

<img src="assets/atom-slime.png"
     style="width: 800px" alt="The SLIMA extension for Atom with an open Lisp REPL"/>


![](assets/atom-slime.png)
   

## VSCode

### OLIVE（2026 年 6 月時点の新規）

[OLIVE](https://github.com/kchanqvq/olive/) は新しい（2026 年 6 月公開の）"Old-school LIsp Vscode Extension" です。

Lisp Swank サーバとのやり取りを基盤としており、次の機能があります。

- 基本機能: コード補完、シンタックスハイライト、定義へ移動、ホバー時のドキュメント表示…
- REPL と対話的デバッガ
  - スタックフレームからソースへジャンプ、ローカル変数の表示など
- 現在のフォームのコンパイルと、異なるデバッグ設定でのファイル読み込み
- 現在のプロジェクト内で ASDF システム定義を見つけて読み込む
- マクロステッパ。

<img src="assets/olive-repl.png" style="max-width: 800px" alt="The new OLIVE VSCode plugin showing the REPL."/>


![](assets/olive-repl.png)
   

OLIVE と Alive の比較:

- OLIVE は、Emacs の Slime、Lem、Pulsar の SLIMA と同じく Swank サーバに基づいており、Common Lisp LSP より Common Lisp 向けには成熟しています。
- Alive の REPL は評価ごとに新しいスレッドを開始するため、一部の対話ができません。
- OLIVE は Alive より安定することを目指しています。
- そして可能なかぎり Emacs と Slime に近いものを目指しています。


### Alive

[Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive) は VSCode を強力な Common Lisp 開発環境にします。

これは LSP（cl-lsp 経由）に基づいており、現在は次をサポートしています。

- シンタックスハイライト
- コード補完
- コードフォーマッタ
- 定義へジャンプ
- スニペット
- REPL 連携
- 対話的デバッガ
  - フレームの再起動
  - フレーム内での eval（v0.4.4 以降）
- REPL 履歴
- インライン評価
- マクロ展開
- 逆アセンブル
- インスペクタ
- ホバーテキスト
- 関数引数と let 束縛のリネーム
- コード折りたたみ

<img src="assets/commonlisp-vscode-alive.png" style="width: 800px" alt="The Alive VSCode plugin showing the interactive debugger."/>


![](assets/commonlisp-vscode-alive.png)
   

### VSCode で Alive を使う

[Using VSCode with Alive][Using VSCode with Alive] を参照してください。

### commonlisp-vscode

[commonlisp-vscode extension](https://marketplace.visualstudio.com/items?itemName=ailisp.commonlisp-vscode) は [cl-lsp](https://github.com/ailisp/cl-lsp) 言語サーバ経由で動作し、ほかのエディタで動く LSP クライアントを書くこともできます。[Roswell](https://roswell.github.io/Home.html) に大きく依存しています。現在サポートしている機能は次のとおりです。

- REPL の実行
- コードの評価
- 自動インデント
- コード補完
- 定義へ移動
- ホバー時のドキュメント表示

<img src="assets/commonlisp-vscode.png" style="width: 800px" alt="The VSCode extension with a Lisp REPL, code completion and a mini-map."/>



![](assets/commonlisp-vscode.png)
   


## Intellij（新しく実験的）

[SLT](https://github.com/Enerccio/SLT) は JetBrains IDE スイート向けの新しい（2023 年 1 月公開の）プラグインです。修正版の SLIME/Swank プロトコルを使って SBCL と通信し、Common Lisp 向けの IDE 機能を提供します。

とても優れた[ユーザーガイド](https://github.com/Enerccio/SLT/wiki/User-Guide)があります。

執筆時点のバージョン 0.4 では、次をサポートしています。

- REPL
- シンボル補完
- 式を REPL に送る
- 対話的デバッグ、ブレークポイント
- ドキュメント表示
- クロスリファレンス
- 名前によるシンボル検索、グローバルなクラス/シンボル検索
- インスペクタ（読み取り専用）
- グラフィカルなスレッド一覧
- SDK サポート、Windows ユーザー向けの自動ダウンロード
- 複数処理系のサポート: SBCL、CCL、ABCL、AllegroCL。

*警告: このプラグインは Intellij のすべてのリリースで動作するとは限りません。こちらの更新されたフォークも参照してください: https://github.com/ivanbulanov/SLT/releases*

<img src="assets/jetbrains-slt.png" style="width: 800px" alt="SLT, a good Common Lisp plugin for JetBrains IDEs."/>


![](assets/jetbrains-slt.png)
   


## Eclipse

[Dandelion](https://github.com/Ragnaroek/dandelion) は Eclipse IDE 用のプラグインです。

Windows、Mac、Linux で利用でき、SBCL と CLISP の組み込みサポート、ほかの環境へ接続する機能、restart 付きの対話的デバッガ、マクロ展開、括弧対応の表示などを備えています。

<img src="assets/dandelion.png" style="width: 800px" alt="Dandelion, a simple Common Lisp plugin for Eclipse"/>


![](assets/dandelion.png)
   

## Lem

[Lem](https://github.com/lem-project/lem/) は汎用エディタです。Common Lisp で作られており、Common Lisp で土台から対話的に拡張でき、Common Lisp 開発に合わせて作られています。インストールすればすぐ作業を始められます。組み込みの LSP クライアントにより、Python、Go、Rust、JS、Clojure、Kotlin、Scheme、HTML、CSS など、[多くのプログラミング言語を標準でサポート](https://lem-project.github.io/modes/)しています。ディレクトリモード、優れた vim レイヤー、対話的な Git モードなどもあります。

インターフェイスは Emacs と SLIME に似ています（ショートカットも同じです）。ncurses フロントエンド、Web ビュー、（非推奨の）SDL2 フロントエンドが付属しています。3 つのプラットフォーム向けにビルド済みバイナリをダウンロードできます。

<img src="assets/lem-sdl2.png"
     style="width: 800px" alt="Lem running in a SDL2 GUI."/>


![](assets/lem-sdl2.png)
   

ターミナルですぐ REPL として起動できます。次のように実行します。

    lem --eval "(lem-lisp-mode:start-lisp-repl t)"

そのため、シェルエイリアスを用意したくなるでしょう。

    alias ilem='lem --eval "(lem-lisp-mode:start-lisp-repl t)"'

さらに次のものもあります。

* 🚀 [Lem on the cloud](https://www.youtube.com/watch?v=IMN7feOQOak)（動画プレゼンテーション）Rooms は Common Lisp で作られたテキストエディタ Lem を Cloud 上で動かし、複数ユーザーで利用できるようにする製品です。
  * Lem on the cloud は 2024 年 4 月時点の新しいものです。執筆時点ではプライベートベータです。

<img src="assets/lem1.png" style="width: 800px" title="Lem's REPL" alt="Lem running in the terminal with the Lisp REPL full screen, showing a completion window."/>


![](assets/lem1.png)
   


## Sublime Text

[Sublime Text](http://www.sublimetext.com/3) は現在、Common Lisp を十分にサポートしています。

まず "SublimeREPL" パッケージをインストールし、それから Tools/SublimeREPL のオプションで CL 処理系を選びます。

次に [Slyblime](https://github.com/s-clerc/slyblime) が、実行中の Lisp イメージとやり取りする IDE 風の機能を提供します。これは SLY の実装で、同じバックエンド（SLYNK）を使います。スタックフレーム調査付きデバッガなど、高度な機能を提供します。

<img src="assets/editor-sublime.png"
     style="width: 800px" alt="A Lisp REPL in Sublime Text"/>


![](assets/editor-sublime.png)
   


## LispWorks（プロプライエタリ）

[LispWorks](http://www.lispworks.com/) は、独自の統合開発環境（IDE）と、CAPI GUI ツールキットなどの独自機能を備えた Common Lisp 処理系です。これは**プロプライエタリ**で、**無料の制限版**を提供しています。

[LispWorks のレビューはこちら](#chapter-lispworks)で読めます。

<img src="assets/lispworks/two-sided-view.png" style="width: 800px" title="The LispWorks IDE" alt="The LispWorks listener and the editor in the Mate desktop environment"/>


![](assets/lispworks/two-sided-view.png)
   

## Zed（2026 年時点の新規）

[zed-cl](https://github.com/etyurkin/zed-cl) は [Zed](https://zed.dev) エディタ用の拡張機能です。

次を提供します。

- 型を意識したスマートなコード補完
- スマートなパラメータ補完（利用可能なら型情報を含む）
- LSP、tree-sitter
- Jupyter REPL 連携
- rainbow brackets サポート

執筆時点では、エディタプラグイン（LSP、tree-sitter、Jupyter の Rust crate）をビルドする必要があるため、Rust ツールチェーンが必要です。

*この拡張機能は LLM の助けを借りて組み立てられた可能性があります*。


## Geany（実験的）

[Geany-lisp](https://github.com/jasom/geany-lisp) は [Geany](https://geany.org/) エディタ用の実験的な lisp モードです。シンボル補完、スマートインデント、定義へジャンプ、現在のファイルのコンパイル、エラーと警告のハイライト、REPL、プロジェクトスケルトン作成機能を備えています。

<img src="assets/geany.png" style="width: 800px" alt="The Geany Lisp plugin showing compilation warnings"/>


![](assets/geany.png)
   


## Notebooks

[common-lisp-jupyter](https://github.com/yitzchak/common-lisp-jupyter) は Jupyter notebook 用の Common Lisp カーネルです。

[Lisp で書かれたライブ Jupyter notebook をこちらで見る](https://nbviewer.jupyter.org/github/yitzchak/common-lisp-jupyter/blob/master/examples/about.ipynb)ことができます。インストールは簡単です（Roswell、repo2docker、Docker レシピ）。

<img src="assets/jupyterpreview.png"
     style="width: 800px" alt="A Jupyter notebook running a Common Lisp kernel, exploring the Lorentz system of differential equations, showing a colorful 3D plot with interactive controls (note: the code in the screenshot is actually not Lisp!)"/>


![](assets/jupyterpreview.png)
   

[Darkmatter](https://github.com/tamamu/darkmatter) という、Common Lisp で作られた notebook 風の Common Lisp 環境もあります。


## REPL

### ICL - ターミナル向けの高機能拡張 REPL（NEW）

[ICL](https://github.com/atgreen/icl)、Interactive Common Lisp は、ターミナル向けの拡張 REPL です。システムにある任意の処理系で動作します。次のような非常に多くの便利な機能を提供します。

- 使いやすいターミナルベース REPL（コード補完など）
- ブラウザ REPL
  - パッケージとシステムのブラウザ付き
  - ドキュメントブラウザ
  - インスペクタ
  - 変数 "watcher"
  - データ可視化
  - flame graph プロファイリング
- Emacs と Slime または SLY との連携により、お気に入りのエディタからブラウザベースのツールを制御できます。

ビルド済みバイナリが用意されています。試してみてください！


### cl-repl - readline ベースのシンプルな ipython 風 REPL

[cl-repl](https://github.com/lisp-maintainers/cl-repl) は ipython 風の REPL です。シンボル補完、magic コマンドとシェルコマンド、複数行編集、ファイル内でのコマンド編集、シンプルなデバッガをサポートします。

バイナリとして利用できます。


<img src="assets/cl-repl.png"
     style="width: 500px" alt="cl-repl 0.4.1 runnning in the terminal, built with Roswell, featuring multi-line prompts and syntax highlighting."/>


![](assets/cl-repl.png)
   


## その他

ほかにも、多少開発が止まっているものも含め、いくつかのエディタがあります。また Allegro CL など、ほかの Lisp ベンダーの無料版もあります。

関連項目として、Web ベースの GUI ビルダーで Lisp エディタも付属する Common Lisp Omnificent GUI、[CLOG](https://github.com/rabbibotton/clog) も参照してください。
 
#  Emacs を IDE として使う {#chapter-emacs-ide}
 

このページでは、[Emacs](https://www.gnu.org/software/emacs/) を Lisp IDE として使うための導入を説明します。

大まかに 3 つの節に分けています。Slime（または Sly）のインストール方法、使い方、そして Lisp コードを扱うための Emacs 組み込みコマンドに関する補足情報です。

![Emacs の紹介画像](assets/emacs-teaser.png)

<!-- todo: C-u M-x slime and its configuration to work with multiple implementations -->

ところで、なぜ Emacs を使うのでしょうか。

* Emacs は Lisp コードを扱うための非常に優れたサポートを備えています
  * Slime-Swank の client-server モデルは LSP より前からあり、Common Lisp との統合ではずっと豊かです。
* ほぼすべての OS とすべての CL 処理系で動作し、軽量です
* Emacs はおそらく今後もあり続けます
* Emacs はマウスありでもなしでもうまく使えます
* Emacs は GUI モードでもターミナルでもうまく使えます
* 組み込みの tree-sitter と LSP サポート
* 優れた vim モード
* [Org-mode](http://orgmode.org) があるから
* [Magit](https://magit.vc/) があるから
* [Emacs Rocks !](http://emacsrocks.com) があるから
* 大きなユーザー層と膨大な拡張機能: [awesome-emacs](https://github.com/emacs-tw/awesome-emacs)。

## SLIME: Superior Lisp Interaction Mode for Emacs

[SLIME](http://common-lisp.net/project/slime/) は CL プログラミングの定番のメジャーモードです。強力で統合された、非常に対話的な開発環境にするための機能を多数備えています。

* 実行中の image に接続された REPL を Emacs 内で提供します
* Common Lisp のデバッガを Emacs インターフェイスと統合します
* シンボルの補完を提供します
* コードの評価、コンパイル、マクロ展開
* 相互参照
* ブレーク、ステップ実行、トレース
* 定義へのジャンプ
* オンラインドキュメント
* 関数、シンボル、システム名、ドキュメントのあいまい検索
* 対話的なオブジェクトインスペクタ
* 一般的な Common Lisp 処理系をすべてサポートします
* 複数の接続と複数のリスナーバッファ（mrepl）
* MELPA からすぐ利用できます
* 活発に保守されています。


## SLY: Sylvester the Cat's Common Lisp IDE

[SLY](https://github.com/joaotavora/sly) は SLIME の fork で、次の変更と機能を含みます。

* Emacs 自身の高機能な comint.el に基づく、全面的に再設計された REPL。あらゆるものを REPL にコピーできます。
* [Stickers](https://joaotavora.github.io/sly/#Stickers) 機能による、コードへのライブな注釈。
* オブジェクトをハイライトし、REPL のセッションを通じて安定して残る、番号付きの後方参照。
* 初期段階ながら機能する試作版の、可搬な注釈ベースのステッパ。
* 複数の REPL と複数のインスペクタ。
* 正規表現に対応した `M-x sly-apropos`。
* Contribs は第一級の SLY の構成要素で、デフォルトで有効、必要に応じて ASDF でロードされます。
  * [NAMED-READTABLES](https://github.com/joaotavora/sly-named-readtables) 対応
  * [macrostep.el](https://github.com/joaotavora/sly-macrostep)
  * [Quicklisp](https://github.com/joaotavora/sly-quicklisp)
  * [ASDF](https://github.com/mmgeorge/sly-asdf)
  * [Evaluation Overlays](https://git.sr.ht/~fosskers/sly-overlay)

一方で、いくつか不足や違いも見つかりました。

* Sly には `slime-call-defun`（C-c C-y）相当がありません。
  * これは残念です。私たちはかなり慣れているからです。下の「REPL にコードを送る」を参照してください。
* `slime-profile-*` 関数がありません（`sb-prof` の contrib がありません）。
* REPL に切り替えるショートカット `C-c C-z` は Slime のものと挙動が異なります（ソースファイルを残して横に REPL を表示する代わりに、ソースファイルを REPL ウィンドウで置き換えることがあります）。

Sly は [Doom Emacs](https://github.com/doomemacs/doomemacs/) にデフォルトで同梱されています。

## SLIME または SLY をインストールする

### 手動

Ubuntu では、SLIME は Emacs と SBCL と一緒に簡単にインストールできます。

    sudo apt install emacs slime sbcl

それ以外では、次のコードを `~/.emacs.d/init.el` ファイルに追加して SLIME をインストールします。

~~~lisp
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(defvar my-packages '(slime))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

(require 'slime)
~~~

Emacs と SBCL もインストール済みだと仮定します。

SLIME はかなりモジュール化されており、デフォルトでは最低限（SLIME REPL すら含まない）しか有効にならないため、次のようにより多くの機能を有効にしたくなるかもしれません。

~~~lisp
(require 'slime)
(slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl))
~~~

最後に、Slime に SBCL を使うよう伝えます。

~~~lisp
(setq inferior-lisp-program "sbcl")
~~~

これでキーボードの Alt-X を押して `slime` と入力し、Common Lisp を試せます。

（Alt-X は Emacs の世界ではよく `M-x` と書かれます。）

詳しくは[ドキュメント](https://common-lisp.net/project/slime/doc/html/)を参照してください（Info ページとしても利用できます）。

これで、前述のとおり `M-x slime` や `M-x slime-connect` で SLIME を実行できます。

関連項目:

- [Portacle](https://shinmera.github.io/portacle/) - Emacs、Slime、SBCL、git、必要な拡張機能を同梱した、可搬でマルチプラットフォームな CL 開発環境。手軽に始められる方法です。
  - ただし Portacle は現在古く、保守されていません。Emacs 27.1 を含んでおり、新しい MacOS では実行が面倒かもしれません。自己責任です。それでも使える場合はあり、更新の取り組みに参加できます。
* [emacs4cl](https://github.com/susam/emacs4cl) - 新規ユーザが素早く始めるための、チュートリアル付きの最小限の Emacs 設定。

### Doom Emacs

[Doom Emacs](https://github.com/doomemacs/doomemacs/) は人気の Emacs 設定です。Sly の統合を簡単に有効にできます。


[​]{#slime-fancy--contrib-packages}

### SLIME fancy と contrib パッケージ

SLIME の機能はパッケージといわゆる [contrib モジュール](https://common-lisp.net/project/slime/doc/html/Contributed-Packages.html) に分かれており、追加機能を使うにはロードする必要があります。前述の `slime-fancy` には次が含まれます。

* slime-autodoc
* slime-c-p-c
* slime-editing-commands
* slime-fancy-inspector
* slime-fancy-trace
* slime-fontifying-fu
* slime-fuzzy
* slime-mdot-fu
* slime-macrostep
* slime-presentations
* slime-references
* slime-repl
* slime-scratch
* slime-package-fu
* slime-trace-dialog
* [slime-mrepl](https://slime.common-lisp.dev/doc/html/slime_002dmrepl.html#slime_002dmrepl)（複数 REPL）

SLIME には [Helm-SLIME](https://github.com/emacs-helm/helm-slime) のような便利な拡張機能もあります。主な機能は次のとおりです。

- あいまい補完
- REPL と接続の一覧
- REPL 履歴のあいまい検索
- _apropos_ ドキュメントのあいまい検索


## SLIME（または SLY）で作業する

最初にやりたくなることの一つは、Lisp コードをコンパイルしてロードすることです。関数上で `C-c C-c`、またはファイル全体をコンパイルするには `C-c C-k` を使います。しかしそれだけではありません。続きを読んでください。

ここでは SLIME の関数名を示します。多くの場合 SLY でも似ています。

### ちょっとしたコツ: Emacs のメニューを使う

このページの情報は多くて圧倒されるかもしれませんが、ここで扱うコマンドやキーバインドは Emacs の Slime メニューの下で簡単に見つけられます。そのためメニューは*無効にしない*ことを勧めます。とても便利です。

見えない場合は `M-x menu-bar-mode RET` を呼び出します。

ターミナル版 Emacs（`emacs -nw`）では、`M-x menu-bar-open` でメニューを開けます。これはデフォルトで `f10` に割り当てられています。また、マウスが有効ならマウスも使えます（`M-:` または `*scratch*` バッファで `(xterm-mouse-mode +1)` を評価します）。

![](assets/slime-menu.png "Emacs' SLIME menu lists all available commands and keybindings.")


### コード補完

SLIME でシンボルを補完するには、組み込みの `C-c TAB` を使います。[company-mode](http://company-mode.github.io/) を使うとツールチップも得られます。

![](assets/emacs-company-elisp.png "Lisp symbols completion with company-mode tooltips.")

**REPL** では単に **TAB** です。

ほかの開いているバッファにある任意の文字列を補完するには、`M-/` に割り当てられた Emacs の hippie-expand を使います。

### SLIME で Lisp を評価・コンパイルする

**バッファ**全体をコンパイルするには `C-c C-k`（`slime-compile-and-load-file`）を押します。

**リージョン**は `M-x slime-compile-region` でコンパイルします。

**defun** はカーソルをその中に置き、`C-c C-c`（`slime-compile-defun`）を押してコンパイルします。

コードをコンパイルしたら、たとえば REPL で試せます。


コンパイルではなく**評価**するには:

- ポイントの前の **sexp** を評価するには、閉じ括弧の後にカーソルを置いて `C-x C-e`（`slime-eval-last-expression`）を押します。結果はミニバッファに表示されます。
- 同様に、`C-c C-p`（`slime-pprint-eval-last-expression`）を使うとポイント前の式を評価して整形表示します。結果は新しい "slime-description" バッファに表示されます。
- `M-x slime-eval-print-last-expression`（デフォルトでは未割り当て）を使うと、結果を同じファイルのカーソル下に出力します。
- リージョンは `C-c C-r` で評価します。
- defun は `C-M-x` で評価します。
- `C-c C-e`（`slime-interactive-eval`）を入力すると、現在のコンテキストで評価するコードを尋ねるプロンプトが出ます。結果はミニバッファに表示されます。前置引数付きなら、結果を現在のバッファに挿入します。
- 式の閉じ括弧の後にカーソルがあるとき、`C-c C-j`（`slime-eval-last-expression-in-repl`）を入力すると、この式を REPL に送って評価します。

メニューにある他のコマンドも参照してください。

では、コードを評価することとコンパイルすることにはどんな違いがあるのでしょうか。

### 評価とコンパイルの違い

コンパイルと評価のどちらを選ぶかには、いくつか実用上の違いがあります。

ただし SBCL のような処理系では、REPL にコードを書く場合や評価用ショートカットを使う場合でも、*明示的に別指定しない限り* 式は*常にコンパイル*されます。

そうは言っても一般には、トップレベルのフォームは*コンパイル*する方がよいです。理由は 2 つあります。

* トップレベルのフォームをコンパイルするとエディタ内で警告とエラーがハイライトされますが、評価ではされません。
* SLIME はコンパイル済みフォームの行番号を追跡しますが、トップレベルのフォームを評価するとファイルの行番号情報が失われます。これはその後のコード移動で問題になります。

`eval` は、トップレベルではない個々のフォームの結果を観察するのに今でも便利です。たとえば次の関数があるとします。


~~~lisp
(defun foo ()
  (let ((f (open "/home/mariano/test.lisp")))
    ...))
~~~

OPEN 式の末尾へ移動して評価（`C-x C-e`）し、結果を観察します。

```
=> #<SB-SYS:FD-STREAM for "file /mnt/e6b00b8f-9dad-4bf4-bd40-34b1e6d31f0a/home/marian/test.lisp" {1003AAAB53}>
```

また次の例では、カーソルを最後の括弧に置いて `C-x C-e` を押すと `let` を評価できます。

~~~lisp
(let ((n 20))
  (loop for i from 0 below n
     do (print i)))
~~~

REPL に数値が出力されるはずです。

下の「REPL にコードを送る」と `C-c C-j` のショートカットも参照してください。


### デバッグ

デバッグ用のコマンドは独立した [デバッグ](#chapter-debugging) の章で扱います。

### 定義へ移動する

任意のシンボルにカーソルを置き、`M-.`（`slime-edit-definition`）を押すとその定義へ移動します。戻るには `M-,` を押します。

[​]{#symbol--source--symbols-}

### 任意のシンボルへ移動し、現在のソース内のシンボルを一覧する

`C-u M-.`（前置引数付きの `slime-edit-definition`、`M-- M-.` としても利用可能）を使うと、シンボルを自動補完してそこへ移動できます。

このコマンドはカーソルがシンボル上にあっても常にシンボルを尋ねます。ロード済みの任意の定義で動作します。短い[デモ動画](https://www.youtube.com/watch?v=ZAEt73JHup8)があります。

これは、任意の Lisp シンボルに対して常に動く `imenu` の補完のようなものだと考えられます。最大の威力を得るには [Slime のあいまい補完][slime-fuzzy] も追加してください。

### 引数リスト

関数上にカーソルを置くと、SLIME はそのシグネチャをミニバッファに表示します。

よりよく見たい場合は、関数名の後で `C-c C-s` を試してください。

たとえば、`with-open-file` の使い方を忘れたとします。これを書きます。

```lisp
(with-open-file
```

ここで `C-c C-s`（`slime-complete-form`）を押すと、次が得られます。

```lisp
(with-open-file (stream filespec :direction direction
                                 :element-type element-type
                                 :if-exists if-exists
                                 :if-does-not-exist if-does-not-exist
                                 :external-format external-format
                                 :class class
                         )
           body...)
```

これはソースファイル（または REPL）に書き込まれます。

ミニバッファには引数のデフォルト値が表示されます。

### ドキュメントの参照

知っておくべき主なショートカットは次です。

- **C-c C-d d** はシンボルのドキュメントを新しいウィンドウに表示します（`describe` を使うのと同じ結果です）。

役立つかもしれないその他の割り当て:

- **C-c C-d f** は関数を説明します
- **C-c C-d h** は Web ブラウザを開いて Common Lisp Hyper Spec（CLHS）のシンボルのドキュメントを検索します。ただしシンボルにしか使えないため、さらに 2 つの割り当てがあります。
- **C-c C-d #** は reader マクロ用です
- **C-c C-d ~** は format ディレクティブ用です

ヘルプバッファは Slime の拡張 [slime-doc-contribs](https://github.com/mmontone/slime-doc-contribs) で強化できます。見やすいバッファにより多くの情報を表示し、ドキュメント表示コマンドに選択肢を追加します。

* **slime-help-package** は CL パッケージについての情報を表示します。エクスポートされた変数、コンディション、クラス、総称関数、関数、マクロとそのドキュメントをきれいに表示します。パッケージが何を提供するかを一目で見るのに優れています。
* **slime-help-system** は *システム* について同じことをします。
* **slime-help-apropos-documentation** はドキュメントが "PATTERN" に一致するシンボルを表示します。関数を探すのに便利です。
* ほかにもあります。

![](assets/slime-help.png)


### インスペクタ

REPL から `(inspect 'symbol)` を呼ぶか、ソースファイルから `C-c I` で呼び出せます。

[ドキュメント](https://slime.common-lisp.dev/doc/html/Inspector.html#Inspector) で使い方を確認してください。たとえば、`l` で前のオブジェクトに戻り、`*` でポイント位置のオブジェクトをコピーできます。

### マクロ展開

マクロの呼び出しを展開するには `C-c M-m` を使います。

### 警告の間を移動する

`C-c C-k` でファイルをコンパイルしてロードする場合（または `C-c C-c` で単一関数をコンパイルする場合）、コンパイル時の警告があっても対話デバッガは出ません。ソースファイルの横に開く専用の "`*slime-compilation*`" Emacs バッファ内に警告の一覧が表示されます。

警告の影響を受けたソースの各行は赤で下線が引かれます。

slime-compilation バッファの各警告はクリックでき、キーバインド `M-n` と `M-p`（`slime-[next, previous]-note`）により次または前の警告（"notes" または "annotations" と呼ばれます）へ素早く移動できます。

通常の Emacs のショートカットである [compilation-mode]( https://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation-Mode.html#Compilation-Mode) の C-x \`（Control-x とバッククォート）も使えます。

ソースの赤い注釈を見たくない場合は、`C-c M-c`、`slime-remove-notes` を使います。ただし自動で修正されるわけではありません。

コードにスタイル警告しかない場合、それらは slime-compilation バッファに捕捉されますが、バッファは自動ではポップアップしません。

これらのキーバインドはいつもどおり Emacs の Slime メニューから見つけられます。

参考: [https://slime.common-lisp.dev/doc/html/Compilation.html#Compilation](https://slime.common-lisp.dev/doc/html/Compilation.html#Compilation)。


[​]{#crossreferencing-symbol-}

### 相互参照: 誰が呼び出し、参照し、シンボルを設定しているかを調べる

Slime には便利な相互参照機能があります。たとえば、誰が関数を呼ぶか、誰がマクロを展開するか、グローバル変数がどこで使われているかを尋ねられます。

結果は新しいバッファに表示され、特定の対象を参照する場所が一覧されます。そこから Enter を押すと対応するソース行へ移動できます。さらに興味深いことに、その行で **C-c C-c** を押すとポイントの場所を再コンパイルできます。同様に **C-c C-k** はすべての参照を再コンパイルします。これはマクロ、インライン関数、定数を変更するときに便利です。

割り当ては次のとおりです（Slime のメニューにも表示されます）。

- **C-c C-w c**（`slime-who-calls`）関数の呼び出し元
- **C-c C-w m**（`slime-who-macroexpands`）マクロが展開される場所
- **C-c C-w r**（`slime-who-references`）グローバル変数の参照
- **C-c C-w b**（`slime-who-bind`）グローバル変数の束縛
- **C-c C-w s**（`slime-who-sets`）グローバル変数の設定箇所
- **C-c C-w a**（`slime-who-specializes`）シンボルに特化したメソッド
- **C-c >**（`slime-list-callees`）関数本体内で呼ばれるすべての関数を一覧します。
- **C-c <**（`slime-list-callers`）指定関数を呼ぶすべての関数を一覧します。

`slime-asdf` contrib が有効な場合、**C-c C-w d**（`slime-who-depends-on`）は依存する ASDF システムを一覧します。

一般的なキーバインドである **M-?** または **M-_**（`slime-edit-uses`）は上記すべてを組み合わせ、あらゆる種類の参照を一覧表示します。

### システムとの対話

Slime では、.asd ファイル内で通常の `C-c C-k` を使ってコンパイルしてロードし、その後 `ql:quickload`（または `asdf:load-system`）で実際にシステムをロードできます。SLIME は Lisp のシステムと対話するための、より対話的なコマンドを提供します。

- `M-x slime-load-system`: **ASDF システムを選択**するプロンプトを表示します。ASDF が Common Lisp のプロジェクトを見る場所から集めたプロジェクトを**自動補完**付きで選び、システムをコンパイルしてロードします。デフォルトのシステム名は、現在のバッファの作業ディレクトリで *.asd に一致する最初のファイルから取られます。
  - システム名は .asd のファイル名から推論されることに注意してください。内部で定義された本当のシステム名は異なる場合があります。
  - ASDF が Lisp のシステムをどこで探すかを理解するには、[getting started](#chapter-getting-started) のページの "How to load an existing project" の節を読んでください。
- `M-x slime-open-system`: 指定システムのすべてのソースファイル用に新しいバッファを開きます。
- `M-x slime-browse-system`: システムのファイルを閲覧する Dired バッファを開きます。
- `M-x slime-rgrep-system`: システムのベースディレクトリで `rgrep` を実行します。
- `M-x slime-isearch-system`: システムのファイルに対して `isearch` を実行します。
- `M-x slime-query-replace-system`: ASDF システムに対して `query-replace` を実行します。
- `M-x slime-save-system`: システムに属するすべてのファイルを保存します。
- `M-x slime-delete-system-fasls`: このシステムのキャッシュされた .fasl ファイルを削除します。

Sly のユーザーにはより多機能な `sly-load-system` コマンドがあり、現在のディレクトリと親ディレクトリで .asd ファイルを検索します。


### REPL との対話

SLIME REPL では、`,` を押すとコマンドのプロンプトが出ます。利用可能なシステムとパッケージに対して補完があります。例:

- `,load-system`
- `,reload-system`
- `,in-package`（.lisp ファイルでは `C-c M-p` も）
- `,restart-inferior-lisp`

ほかにも多数あります。通常、前節で示した対話的なコマンドには REPL のショートカットがあります。

`slime-quicklisp` contrib を使うと、`,ql` でインストール可能な全システムからシステムを自動補完してインストールできます。

さらに [Quicklisp-systems](https://github.com/mmontone/quicklisp-systems) という Slime の拡張を使うと、Emacs から Quicklisp のシステムを検索、閲覧、ロードできます。

### REPL にコードを送る

REPL にコードを書けますが、ソースファイルからコードと直接やり取りすることもできます。

**C-c C-j** は見ました。ポイントの式を REPL に送り、評価します。

**C-c C-y**（`slime-call-defun`）: コードを REPL に送ります（Sly にはありません）。

ポイントが defun 内にあり、C-c C-y が押された場合（下では [] をカーソル位置の目印として使います）

~~~lisp
(defun foo ()
 nil[])
~~~


すると `(foo [])` が REPL に挿入され、追加引数を書いて実行できます。


`foo` が REPL のパッケージとは異なるパッケージにあった場合、`(package:foo )` または `(package::foo )` が挿入されます。

この機能は、書いたばかりの関数をテストするのにとても便利です。

これは `defun` だけでなく、`defgeneric`、`defmethod`、`defmacro`、`define-compiler-macro` に対しても defun と同じように動作します。

`defvar`、`defparameter`、`defconstant` の場合は `[] *foo*` が挿入されます（シンボルの前にカーソルが置かれるため、簡単に関数呼び出しで包めます）。

defclass の場合: `(make-instance ‘class-name )`。

**デバッガ内のフレームへの呼び出しを挿入する**

SLDB のフレーム上で **C-y** を押すと、そのフレームへの呼び出しが REPL に挿入されます。例:

```
(/ 0) =>
…
1: (CCL::INTEGER-/-INTEGER 1 0)
…
```

**C-y** は `(CCL::INTEGER-/-INTEGER 1 0)` を挿入します。

（[Slime tips](https://slime-tips.tumblr.com/page/2) に感謝）


[​]{#packages-}

### パッケージを同期する

**C-c ~**（`slime-sync-package-and-default-directory`）: lisp ファイルのバッファで実行すると、REPL の現在のパッケージをそのファイルのパッケージに変更し、REPL の現在のディレクトリもファイルの親ディレクトリに設定します。

[​]{#symbols--export-}

### シンボルを export する

Slime はパッケージに export 宣言を追加するショートカットを提供します。実質的に一つまたは複数のシンボルを export したり、逆に un-export したりできます。

`slime-package-fu` contrib の **C-c x**（*slime-export-symbol-at-point*）: ポイントのシンボルを取り、対応する defpackage フォームの `:export` 節を変更します。またシンボルも export します。負の引数（C-u C-c x）付きで呼ぶと、シンボルを `:export` から削除し unexport します。

**M-x slime-export-class** も同じことをしますが、アクセサ、コンストラクタなど、構造体またはクラスによって定義されるシンボルが対象です。今のところ構造体では SBCL と Clozure CL でのみ動作します。クラスは MOP によりどこでも動くはずです。

カスタマイズ

`defpackage` でシンボルを表示するスタイルにはいくつかあり、デフォルトは uninterned シンボル（`#:foo`）を使います。これは変更できます。

キーワードを使うには、Emacs の init ファイルに次を追加します。


~~~lisp
(setq slime-export-symbol-representation-function
      (lambda (n) (format ":%s" n)))
~~~

または文字列:

~~~lisp
(setq slime-export-symbol-representation-function
 (lambda (n) (format "\"%s\"" (upcase n))))
~~~


### （任意）Hyper Spec（CLHS）を offline で参照する

[Common Lisp Hyper Spec](http://www.lispworks.com/documentation/common-lisp.html) は ANSI Common Lisp 標準の公式オンライン版です。[starting points](http://www.lispworks.com/documentation/HyperSpec/Front/StartPts.htm) から閲覧を始められます。短縮された [table of contents of highlights](http://www.lispworks.com/documentation/HyperSpec/Front/Hilights.htm)、[シンボル索引](http://www.lispworks.com/documentation/HyperSpec/Front/Hilights.htm)、用語集、総合索引があります。

2023 年 1 月以降、Common Lisp Community Spec があります: [https://cl-community-spec.github.io/pages/index.html](https://cl-community-spec.github.io/pages/index.html)。これは仕様書の新しい Web 表示です。より現代的な見た目です。

* *検索ボックス* があります
* *シンタックスハイライト* があります
* GitHub でホストされており、変更する権利があります: [https://github.com/fonol/cl-community-spec](https://github.com/fonol/cl-community-spec)

公式の Web サイトには検索バーがないため、CLHS 上のシンボルを他のツールですばやく参照したい場合は、次を使えます。

* Xach の website search utility: [https://www.xach.com/clhs?q=with-open-file](https://www.xach.com/clhs?q=with-open-file)
* l1sp.org website: [http://l1sp.org/search?q=with-open-file](http://l1sp.org/search?q=with-open-file)
* Duckduckgo または Brave Search の `!clhs` "bang" も使えます。

MacOS では [Dash](https://kapeli.com/dash)、GNU/Linux では [Zeal](https://zealdocs.org/)、Windows では [Velocity](https://velocity.silverlakesoftware.com/) を使って **CLHS をオフラインで閲覧**できます。

しかし Emacs からもオフラインで閲覧できます。CL パッケージをインストールし、Emacs 側を一つのコマンドで設定します。

~~~lisp
(ql:quickload "clhs")
(clhs:install-clhs-use-local)
~~~

次を Emacs configuration に追加します。

~~~lisp
(load "~/quicklisp/clhs-use-local.el" 'noerror)
~~~

これで `C-c C-d h` を使って、ポイントのシンボルを HyperSpec で参照できます。ブラウザが開きますが、URL が "file://home/" で始まることを見てください。ローカルファイルを開いています。

他のコマンドも利用できます。

* `#'`（sharpsign-quote）や `(`（left-parenthesis）のような reader マクロを参照したい場合は、`C-c C-d #` に割り当てられた `M-x common-lisp-hyperspec-lookup-reader-macro` を使います。
* `~A` のような `format` ディレクティブを参照するには、`C-c C-d ~` に割り当てられた `M-x common-lisp-hyperspec-format` を使います。
  * もちろん、Emacs のミニバッファのプロンプトで TAB 補完すれば利用可能な format ディレクティブをすべて見られます。
* 用語集の項目も参照できます（たとえば "defun" ではなく "function" を参照できます）。`C-c C-d g` に割り当てられた `M-x common-lisp-hyperspec-glossary-term` を使います。


## Emacs で作業する

この節では、Lisp コード一般を扱うため、またよくある操作を行うために最も役立つ Emacs のコマンドを学びます。

まず Emacs の組み込みドキュメントで道を見つける方法から始めます。学ぶべき技能が一つあるとすれば、これです。

Emacs の GUI とターミナルのインターフェイスの両方にメニューがあることを忘れないでください。利用可能なコマンドを発見する助けになります。見えない場合は、emacs の設定が隠していないことを確認してください。`M-x menu-bar-mode` でメニューを表示できます。

### 組み込みのドキュメント

Emacs には組み込みチュートリアルとドキュメントが付属します。さらに、自己ドキュメント化と自己発見性を備えたエディタであり、introspection によって現在のキーバインド、関数のドキュメント、利用可能な変数、ソースコード、チュートリアルなどを知ることができます。「x をするためのショートカットは何があるか」や「このキーバインドは実際に何をするのか」といった疑問を持ったとき、答えはほぼ確実に Emacs の中でキー操作一つ先にあります。Emacs で Emacs を滞りなく発見できるよう、いくつかのキーバインドを覚えるべきです。

この話題のヘルプはここにあります。

- [Help page: commands for asking Emacs about its commands](https://www.gnu.org/software/emacs/manual/html_node/emacs/Help.html#Help)

ヘルプのキーバインドは `C-h` または `F1` で始まります。重要なものは次です。

- `C-h k <keybinding>`: このキーバインドはどの関数を呼ぶか？
- `C-h f <function name>`: この関数にはどのキーバインドが関連付けられているか？
- `C-h a <topic>`: 指定された *topic* に名前が一致するコマンドの一覧を表示します。キーワード、キーワードのリスト、正規表現を受け付けます。
- `C-h i`: Info ページを表示します。主要な話題のメニューです。

Emacs パッケージの中には、さらに多くのヘルプを提供するものもあります。

[​]{#help--discoverability-packages}

### さらにヘルプと発見性を高めるパッケージ

キーの並びを入力し始めたものの、完全には思い出せないことがあります。また、関連する他のキーバインドが気になることもあります。そこで [which-key-mode](https://github.com/justbur/emacs-which-key) です。このパッケージは、入力したキーで始まる可能なキーバインドをすべて表示します。

たとえば、`C-x` の下に便利なキーバインドがあることは知っているけれど、どれかを覚えていないとします。`C-x` と入力し、半秒待つだけで、which-key が利用可能なものをすべて表示します。

![](assets/emacs-which-key-minibuffer.png)

`C-h` でも試してみてください。

組み込みの Emacs ヘルプの代替で、より多くの文脈情報を提供する [Helpful](https://github.com/Wilfred/helpful) も参照してください。

<img src="assets/emacs-helpful.png" style="height: 450px" alt="The Emacs helpful package shows detailed information about a symbol."/>


![](assets/emacs-helpful.png)
   


### 組み込みのチュートリアル

Emacs には独自のチュートリアルが付属しています。重要なキーバインドと概念を学ぶために一度見ておくとよいでしょう。

`M-x help-with-tutorial`（ここで `M-x` は `alt-x`）で呼び出します。



### 括弧を編集する

Emacs にはもちろん、S 式を扱う組み込みコマンドがあります。

#### S 式による前後・上下の移動と選択

`C-M-f` と `C-M-b`（`forward-sexp` と `backward-sexp`）を使うと、ポイントの S 式の終端（始端）や、同じ階層の次の式へ移動できます。`C-M-n` と `C-M-p`（next、previous）も似ています。

`C-M-u`（`backward-up-list`）と `C-M-d`（`down-list`）で S 式の木構造を上下に移動します。

`C-M-a`（lisp-mode では `beginning-of-defun` または `slime-beginning-of-defun`）と `C-M-e`（`end-of-defun` または `slime-end-of-defun`）でトップレベルの S 式の始端（または終端）へ移動します。たとえば現在の関数定義の先頭へ移動します。

S 式全体をハイライトするには `C-M-@` または `C-M-space`（どちらも `mark-sexp`）を使います。その後 `C-M-u` で選択範囲を「上方向」に広げ、`C-M-d` で括弧の一段下へ進めます。`mark-sexp` を繰り返し押すこともできます。

`M-)`（`move-past-close-and-reindent`）を使うと、現在のレキシカルブロックの終端へ移動し、新しい行を作ってインデントします。

`C-M-t`（`transpose-sexps`）を使うと、ポイントの S 式を前の S 式の前へ移動できます。

例:

```lisp
;; C-M-t を押し、異なる additions がどう動くかを観察します。

(defun c ()
  "another function"
  (let ((x 42))
    (+ x
       (+ 2 2)
     [](+ 3 3)  ; <-- cursor
       (+ 4 4))))

;; C-M-t =>

(defun c ()
  "another function"
  (let ((x 42))
    (+ x
       (+ 3 3)
       (+ 2 2)[]  ; <-- cursor moved too (now right before (+ 4 4)
       (+ 4 4))))
```

#### 行またはリージョンをコメントにする

`M-;` でコメントを挿入するかリージョンをコメントにし、`M-q` でテキストを整えます。

#### 括弧と S 式を削除する

ポイントの前方にある括弧の対を削除するには `M-x delete-pair` を使います。実際には対になる任意の記号（ダブルクォート、角括弧…）で動作します。

例:

~~~lisp
[](1 2 3)
;; M-x delete-pair =>
1 2 3
~~~

`C-M-k`（`kill-sexp`）と `C-M-backspace`（`backward-kill-sexp`）を使います（ただし注意: このキーバインドは GNU/Linux でシステムを再起動することがあります）。

たとえばポイントが `(progn` の前にある場合（[] をカーソルの位置として使います）:

~~~lisp
(defun d ()
  (if t
      (+ 3 3)
     [](progn
        (+ 1 1)
        (if t
            (+ 2 2)
            (+ 3 3)))
      (+ 4 4)))
~~~

`C-M-k` を押すと、次になります。

~~~lisp
(defun d ()
  (if t
      (+ 3 3)
      []
      (+ 4 4)))
~~~

#### raise: S 式を上へ移動する

現在の式を "raise" するには `M-x raise-sexp`（デフォルトでは未割り当て）を使います。これは一段上へ移動し、以前の式を消します。たとえばポイントが下の位置にある場合:

~~~lisp
(defun d ()
  (when t
    [](+ 3 3)
~~~

`raise-sexp` を呼ぶと、次になります。

~~~lisp
(defun d ()
  [](+ 3 3))
~~~

グローバルキーに割り当てられます。

~~~lisp
(keymap-global-set "M-+" #'raise-sexp) ;; M-+ originally unbound
~~~

#### S 式をインデントする

Lisp フォームのインデントは自動です。

TAB を押すと、誤ってインデントされたコードをインデントします。たとえば `(+ 3 3)` フォームの先頭にポイントを置いて TAB を押します。

~~~lisp
(progn
(+ 3 3))
~~~

正しく次のようになります。

~~~lisp
(progn
  (+ 3 3))
~~~

ポイントのフォームを再インデントするには `C-M-q`（`indent-sexp`）を使います。

~~~lisp
;; cursor を "(defun ..." の open parens に置き、
;; "C-M-q" を押して code を indent します:
[] (defun e ()
   "A badly indented function."
 (let ((x 20))
 (print x)))
~~~

次のようになります。

```lisp
(defun e ()
  "A correctly indented function."
  (let ((x 20))
    (print x)))
```

現在の関数定義をインデントするには `C-c M-q`（`slime-reindent-defun`）を使います。

~~~lisp
;; cursor を function 内のどこかに置き、
;; "C-M-q" を押して code を indent します:
(defun e ()
"A badly indented function."
(let ((x 20))
(loop for i from 0 to x
do (loop for j from 0 below 10
do (print j))
(if (< i 10)
(let ((z nil) )
(setq z (format t "x=~d" i))
(print z))))))

;; This is the result:

(defun e ()
  "A badly indented function (now correctly indented)."
  (let ((x 20))
    (loop for i from 0 to x
       do (loop for j from 0 below 10
             do (print j))
         (if (< i 10)
             (let ((z nil) )
               (setq z (format t "x=~d" i))
               (print z))))))
~~~

リージョンを選択して `M-x indent-region` を呼ぶこともできます。

#### 括弧を開閉する

Lisp の括弧を管理するのに、多くのキーバインドは（あるいはまったく）必要ないかもしれません。`M-x show-paren-mode` だけでも非常に便利です（下記参照）。とはいえ、役立つキーバインドもあります。

Slime REPL では、`C-return` または `M-return`（`slime-repl-closing-return`）で残りの括弧を閉じて入力文字列を評価できることを知っていましたか。

ソースファイルでは、必要な数の閉じ括弧を挿入するために `C-c C-]`（`slime-close-all-parens-in-sexp`）を使えます。

例:

```lisp
(defun example ()
  (when t
    (when (+ 1 2)
      nil[]  ;; <--- point

;; C-c C-]
;; =>

(defun example ()
  (when t
    (when (+ 1 2)
      nil)))
         ^^^ 3 closing ) were inserted.
```

ファイルでは、`M-(` で括弧の対（`()`）を挿入できます。同じキーバインドに前置引数 `C-u M-(` を付けると、カーソルの前の式を括弧の対で囲みます。

たとえば最初の括弧の前にカーソルがある状態から始めます。

~~~lisp
[](- 2 2)
~~~

`C-u M-(` を押して parens で囲みます。

~~~lisp
([](- 2 2))
;; now write anything.
(zerop (- 2 2))
~~~

数値の前置引数（`C-u 2 M-(`）を使うと、その数の S 式を囲みます。

さらに、不正な形の S 式を見つけるには `M-x check-parens` を使います。

括弧の利用を簡単にする追加パッケージもあります。

- `M-x show-paren-mode` は組み込みの Emacs モードで、対応する括弧の可視化を切り替えます。有効にすると、括弧の上にカーソルを置いたとき対応する括弧が見えます。Emacs の init ファイルで `(show-paren-mode t)` により初期化できます。グローバルなマイナーモードです（すべてのバッファ、すべての言語で動作します）。
 - **有効にすることを強く勧めます**。
- evil-mode（vim レイヤー）が有効な場合、`%` キーで対応する括弧に移動できます。
- `M-x electric-pair-mode` は組み込みの Emacs モードです。有効にすると、開き括弧を入力したとき対応する閉じ括弧を自動挿入し、その逆も行います（角括弧なども同様）。リージョンがアクティブな場合、括弧（角括弧など）はリージョンの周りに挿入されます。
- [Paredit (animated guide)](http://danmidwood.com/content/2014/11/21/animated-paredit.html) を使うと括弧を自動で対にして挿入できます。
- または [lispy-mode](https://github.com/abo-abo/lispy) もあります。Paredit のようなものですが、カーソルが括弧の直前または直後にあるときだけキーが動作を起こします。

[​]{#structured-editing--packages}

### （任意）構造化編集のパッケージ

組み込みの Emacs コマンドとモード（`show-paren-mode` は必須です。上記参照）に加えて、括弧やインデントのバランスを保つ助けになるパッケージがさらにあります。下の一覧は、[history of Lisp editing](https://github.com/shaunlebron/history-of-lisp-editing) による拡張の年代順にある程度並べています。

- [Paredit](https://www.emacswiki.org/emacs/ParEdit) - Paredit は定番です。必携のコマンド（S 式の移動、削除、分割、結合など）を定義します。
  ([visual tutorial](http://danmidwood.com/content/2014/11/21/animated-paredit.html))
- [Smartparens](https://github.com/Fuco1/smartparens) - Smartparens は括弧だけでなく対になるすべてのもの（html タグなど）を扱うため、Lisp 以外の言語向けの機能もあります。
- [Lispy](https://github.com/abo-abo/lispy) - Lispy は Paredit を再考し、ポイント位置に応じて動作する最短の割り当て（多くは 1 キー）を目指しています。
- [Paxedit](https://github.com/promethial/paxedit) - Paxedit は文脈（シンボル内、S 式内など）に基づくコマンドを追加し、空白の整理と文脈に応じたリファクタリングに力を入れています。
- [Parinfer](http://shaunlebron.github.io/parinfer/) - Parinfer はインデントに応じて括弧を自動修正するか、その逆を行います（または両方）。

個人的には、まず組み込み関数をよく知り、その後有名な Paredit や evil ユーザー向けの Lispy から着想を得ることを勧めます。さらに詳しくは [Wikemacs](http://wikemacs.org/wiki/Lisp_editing) を参照してください。


### コードを隠す/表示する

`C-x n n`（narrow-to-region）と `C-x n w` を使って元に戻します。

外部パッケージによる [code folding](http://wikemacs.org/wiki/Folding) も参照してください。

### 検索と置換

#### 前方/後方のインクリメンタル検索、正規表現検索、検索・置換

`C-s` は前方へのインクリメンタル検索を行います。たとえば検索文字列の各キーを入力するたびにソースファイルが最初の一致に向けて検索されます。一意になる文字だけを入力すればよいため、特定のテキストをかなり素早く見つけられます。同じ検索文字を使った繰り返し検索は、`C-s` を繰り返し押すことで行えます。

`C-r` は後方へのインクリメンタル検索を行います。

`C-s RET` と `C-r RET` はどちらも通常の文字列検索を行います（それぞれ前方と後方）。

`C-M-s` と `C-M-r` はどちらも正規表現検索を行います（それぞれ前方と後方）。

`M-%` は検索・置換を行い、`C-M-%` は正規表現の検索・置換を行います。


#### 出現箇所を探す（occur、grep）

`M-x grep`、`rgrep`、`occur` などを使います。

対話的な版として [helm-swoop](http://wikemacs.org/wiki/Helm-swoop)、helm-occur、[ag.el](https://github.com/Wilfred/ag.el) も参照してください。


## 質問と回答

### Emacs Lisp vs Common Lisp

Common Lisp 用に Emacs を Slime または Sly と一緒に使うために、Emacs Lisp を書く必要はありません。

ただし Emacs Lisp を学ぶことは役に立ちますし、CL と似ています（しかし異なります）。

*   ダイナミックスコープが至るところにあります
*   reader（または reader 関連）の関数がありません
*   CL でサポートされるすべての型をサポートしているわけではありません
*   CLOS の実装は不完全です（追加の EIEIO パッケージによる）
*   数の塔（numerical tower）のサポートがありません

Emacs Lisp 学習に役立つ資料:

*   [An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/eintr.html)
*   [Writing GNU Emacs Extensions](http://www.oreilly.com/catalog/gnuext/)
*   [Wikemacs](http://wikemacs.org/wiki/Category:Emacs_Lisp)

### LSP（Language Server Protocol）はどうか？

Common Lisp 向けの LSP サーバーとクライアントの移植版は存在しますが、高品質な IDE 連携を得るためにそれらが*必要*なわけではありません。実際、Slime/Swank は LSP のようなクライアント/サーバー型のアーキテクチャに従っていますが、Slime は LSP より何十年も前からあり、今でも LSP より lisper 向けにずっと多くの機能を提供しています。

### utf-8 エンコーディング

init file に次を設定したくなるかもしれません。

~~~lisp
(set-language-environment "UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
~~~

Sly では次のようにします。

~~~lisp
(setf sly-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)
        ))
~~~

これにより、SLIME で評価するファイルに非 ASCII 文字があるときの `ascii stream decoding error` を避けられます。


[​]{#default-cutcopypaste-keybindings}

### デフォルトの切り取り・コピー・貼り付け用キーバインド

*私はテキストのコピーと貼り付けに C-c、C-v などを使うことに慣れすぎていて、Emacs のデフォルトショートカットがまったくしっくりきません。*

幸い、解決策があります。[cua-mode](http://www.emacswiki.org/cgi-bin/wiki.pl?CuaMode) をインストールすれば、これらのショートカットを使い続けられます。

~~~lisp
;; C-z=Undo, C-c=Copy, C-x=Cut, C-v=Paste (needs cua.el)
(require 'cua) (CUA-mode t)
~~~


## 付録

### Slime REPL のショートカットすべて

REPL で動作するすべての Slime のショートカットのリファレンスです。

見るには REPL に移動し、`C-h m` と入力して Slime REPL map の節へ進みます。


```
REPL mode defined in ‘slime-repl.el’:
Major mode for interacting with a superior Lisp.
key             binding
                -

C-c             Prefix Command
C-j             slime-repl-newline-and-indent
RET             slime-repl-return
C-x             Prefix Command
ESC             Prefix Command
SPC             slime-space
  (that binding is currently shadowed by another mode)
,               slime-handle-repl-shortcut
DEL             backward-delete-char-untabify
<C-return>      slime-repl-closing-return
<C-down>        slime-repl-forward-input
<C-up>          slime-repl-backward-input
<return>        slime-repl-return

C-x C-e         slime-eval-last-expression

C-c C-c         slime-interrupt
C-c C-n         slime-repl-next-prompt
C-c C-o         slime-repl-clear-output
C-c C-p         slime-repl-previous-prompt
C-c C-s         slime-complete-form
C-c C-u         slime-repl-kill-input
C-c ESC         Prefix Command
C-c I           slime-repl-inspect

M-RET           slime-repl-closing-return
M-n             slime-repl-next-input
M-p             slime-repl-previous-input
M-r             slime-repl-previous-matching-input
M-s             slime-repl-next-matching-input

C-c C-z         run-lisp
  (that binding is currently shadowed by another mode)

C-M-x           lisp-eval-defun

C-M-q           indent-sexp

C-c M-e         macrostep-expand
C-c M-i         slime-fuzzy-complete-symbol
C-c M-o         slime-repl-clear-buffer
```

### その他すべての Slime のショートカット

ここで示した以上のものがあります。Slime には、ポイントのシンボルの関数定義を逆アセンブルしたり、インスペクタの操作方法を学んだり、関数のプロファイリングを切り替えたり、インデントや補完の方法を学んだり、複数の Lisp 接続を使ったり、[presentations を操作](https://slime.common-lisp.dev/doc/html/Presentations.html#Presentations)したりするショートカットがあります。

Slime モードによって定義されるデフォルトのキーバインドは次のとおりです。

見るには .lisp ファイルに移動し、`C-h m` と入力して Slime の節へ進みます。

```
Commands to compile the current buffer’s source file and visually
highlight any resulting compiler notes and warnings:
C-c C-k	- Compile and load the current buffer’s file.
C-c M-k	- Compile (but not load) the current buffer’s file.
C-c C-c	- Compile the top-level form at point.

Commands for visiting compiler notes:
M-n	- Goto the next form with a compiler note.
M-p	- Goto the previous form with a compiler note.
C-c M-c	- Remove compiler-note annotations in buffer.

Finding definitions:
M-.
- Edit the definition of the function called at point.
M-,
- Pop the definition stack to go back from a definition.

Documentation commands:
C-c C-d C-d	- Describe symbol.
C-c C-d C-a	- Apropos search.
C-c M-d	- Disassemble a function.

Evaluation commands:
C-M-x	- Evaluate top-level from containing point.
C-x C-e	- Evaluate sexp before point.
C-c C-p	- Evaluate sexp before point, pretty-print result.

Full set of commands:
key             binding
                -

C-c             Prefix Command
C-x             Prefix Command
ESC             Prefix Command
SPC             slime-space

C-c C-c         slime-compile-defun
C-c C-j         slime-eval-last-expression-in-repl
C-c C-k         slime-compile-and-load-file
C-c C-s         slime-complete-form
C-c C-y         slime-call-defun
C-c ESC         Prefix Command
C-c C-]         slime-close-all-parens-in-sexp
C-c x           slime-export-symbol-at-point
C-c ~           slime-sync-package-and-default-directory

C-M-a           slime-beginning-of-defun
C-M-e           slime-end-of-defun
M-n             slime-next-note
M-p             slime-previous-note

C-M-,           slime-previous-location
C-M-.           slime-next-location

C-c TAB         completion-at-point
C-c RET         slime-expand-1
C-c C-p         slime-pprint-eval-last-expression
C-c C-u         slime-undefine-function
C-c ESC         Prefix Command

C-c C-b         slime-interrupt
C-c C-d         slime-doc-map
C-c C-e         slime-interactive-eval
C-c C-l         slime-load-file
C-c C-r         slime-eval-region
C-c C-t         slime-toggle-fancy-trace
C-c C-v         Prefix Command
C-c C-w         slime-who-map
C-c C-x         Prefix Command
C-c C-z         slime-switch-to-output-buffer
C-c ESC         Prefix Command
C-c :           slime-interactive-eval
C-c <           slime-list-callers
C-c >           slime-list-callees
C-c E           slime-edit-value
C-c I           slime-inspect

C-x C-e         slime-eval-last-expression
C-x 4           Prefix Command
C-x 5           Prefix Command

C-M-x           slime-eval-defun
M-,             slime-pop-find-definition-stack
M-.             slime-edit-definition
M-?             slime-edit-uses
M-_             slime-edit-uses

C-c M-c         slime-remove-notes
C-c M-e         macrostep-expand
C-c M-i         slime-fuzzy-complete-symbol
C-c M-k         slime-compile-file
C-c M-q         slime-reindent-defun

C-c M-m         slime-macroexpand-all

C-c C-v C-d     slime-describe-presentation-at-point
C-c C-v TAB     slime-inspect-presentation-at-point
C-c C-v C-n     slime-next-presentation
C-c C-v C-p     slime-previous-presentation
C-c C-v C-r     slime-copy-presentation-at-point-to-repl
C-c C-v C-w     slime-copy-presentation-at-point-to-kill-ring
C-c C-v ESC     Prefix Command
C-c C-v SPC     slime-mark-presentation
C-c C-v d       slime-describe-presentation-at-point
C-c C-v i       slime-inspect-presentation-at-point
C-c C-v n       slime-next-presentation
C-c C-v p       slime-previous-presentation
C-c C-v r       slime-copy-presentation-at-point-to-repl
C-c C-v w       slime-copy-presentation-at-point-to-kill-ring
C-c C-v C-SPC   slime-mark-presentation

C-c C-w C-a     slime-who-specializes
C-c C-w C-b     slime-who-binds
C-c C-w C-c     slime-who-calls
C-c C-w RET     slime-who-macroexpands
C-c C-w C-r     slime-who-references
C-c C-w C-s     slime-who-sets
C-c C-w C-w     slime-calls-who
C-c C-w a       slime-who-specializes
C-c C-w b       slime-who-binds
C-c C-w c       slime-who-calls
C-c C-w d       slime-who-depends-on
C-c C-w m       slime-who-macroexpands
C-c C-w r       slime-who-references
C-c C-w s       slime-who-sets
C-c C-w w       slime-calls-who

C-c C-d C-a     slime-apropos
C-c C-d C-d     slime-describe-symbol
C-c C-d C-f     slime-describe-function
C-c C-d C-g     common-lisp-hyperspec-glossary-term
C-c C-d C-p     slime-apropos-package
C-c C-d C-z     slime-apropos-all
C-c C-d #       common-lisp-hyperspec-lookup-reader-macro
C-c C-d a       slime-apropos
C-c C-d d       slime-describe-symbol
C-c C-d f       slime-describe-function
C-c C-d g       common-lisp-hyperspec-glossary-term
C-c C-d h       slime-documentation-lookup
C-c C-d p       slime-apropos-package
C-c C-d z       slime-apropos-all
C-c C-d ~       common-lisp-hyperspec-format
C-c C-d C-#     common-lisp-hyperspec-lookup-reader-macro
C-c C-d C-~     common-lisp-hyperspec-format

C-c C-x c       slime-list-connections
C-c C-x n       slime-next-connection
C-c C-x p       slime-prev-connection
C-c C-x t       slime-list-threads

C-c M-d         slime-disassemble-symbol
C-c M-p         slime-repl-set-package

C-x 5 .         slime-edit-definition-other-frame

C-x 4 .         slime-edit-definition-other-window

C-c C-v M-o     slime-clear-presentations
```

[slime-fuzzy]: https://common-lisp.net/project/slime/doc/html/Fuzzy-Completion.html

## 関連項目

- [SLIME's documentation](https://slime.common-lisp.dev/doc/html/)
- **[Slime のビデオチュートリアル](https://www.youtube.com/watch?v=sBcPNr1CKKw)**（作者のチャンネルも素晴らしい内容が豊富です）
- Marco Baringer の [Slime チュートリアル](https://www.youtube.com/watch?v=NUpAvqa5hQw)
- [Common Lisp REPL exploration guide](https://bnmcgn.github.io/lisp-guide/lisp-exploration.html)。REPL で道を見つけるための、簡潔で厳選された要点集です。
- [Emacs4CL](https://github.com/susam/emacs4cl)。素の Emacs を Common Lisp プログラミング用に設定するための小さな DIY キットです。
- [slime-star](https://github.com/mmontone/slime-star)。SLIME 拡張の詰め合わせです。
  * doc contribs: ドキュメントを表示する、より豊かな slime-help と slime-info のバッファ。
  * Quicklisp systems: REPL から Quicklisp のシステムをロードする自動補完。
  * quicksearch 連携: Quicklisp、Github、Cliki で Common Lisp のリポジトリを検索。
  * Slime breakpoints: コードへの注釈なしでブレークポイントを視覚的に設定し、コードをステップ実行するボタンを得る。
  * Quicklisp apropos: Quicklisp ライブラリ全体の "apropos"。
  * Slime critic: Slime critic にコードをやさしく批評してもらう。
  * 対話的な print と trace のバッファ
  * 出力ストリーム用の専用 Emacs バッファ
* ANSI Common Lisp 仕様を Emacs Info 形式で参照できます。
  * Lisp system browser: Common Lisp 用の（開発中の）Smalltalk 風システムブラウザ。利用可能なパッケージとその関数、変数、マクロ、クラス、総称関数を閲覧するための複数のペインを得られます。
- [Slime tips](https://github.com/lisp-tips/lisp-tips/issues?q=state%3Aopen%20label%3A%22slime%22)
 
#  Alive で VSCode を使う {#chapter-vscode-alive}
 

[Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive)
拡張機能は [VSCode](https://code.visualstudio.com) を強力な
Common Lisp の開発プラットフォームにします。
対象プラットフォーム上で動作する Common Lisp の処理系以外に依存はありません。現在は次に対応しています。

- シンタックスハイライト
- コード補完
- コードフォーマッタ
- 定義へのジャンプ
- スニペット
- REPL 統合
- 対話的デバッガ
- REPL の履歴
- インライン評価
- マクロ展開
- 逆アセンブル
- インスペクタ
- ホバーテキスト
- 関数の引数や let の束縛のリネーム
- コードの折りたたみ

![](assets/commonlisp-vscode-alive.png)

### 前提条件

VSCode の Alive 拡張機能は ANSI Common Lisp と互換性があり、Alive REPL が正常に起動する限り、これらの手順はどの処理系でも動くはずです。例ではすべて SBCL を使います。

- [VsCode](https://code.visualstudio.com)。[コマンドライン](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
  がインストールされており、
  [Alive](https://marketplace.visualstudio.com/items?itemName=rheller.alive)
  拡張機能が動作しているもの。
- [SBCL](http://www.sbcl.org)

#### VSCode を REPL に接続する

![](assets/vscode-gifs/attach-repl.gif)

1. VSCode 内で、編集したい lisp ファイルを開きます。
   - まだない場合は、`hello.lisp` という新しいファイルを作成します。
2. VSCode 内で、上部メニューの `View/Command Palette` から Command Palette を開き、
   `Alive: Start REPL And Attach` を選んで、VSCode の REPL に接続された Swank サーバーを動かす SBCL インスタンスを起動します。
   - `REPL Connected` と書かれた小さなウィンドウがポップアップします。
   - `REPL Connected` メッセージが出ない場合は、上部メニューの `View:Output` から VSCode の
     Output を開き、プルダウンで `Swank Trace` を選びます。この出力は実行中の lisp イメージからの出力で、何がうまくいっていないのかを調べる出発点になります。

これで、稼働中の SBCL イメージのポート 4005 で動く Swank サーバーに接続された REPL を持つ VSCode インスタンスができました。ファイル内の文を評価でき、それらは実行中の SBCL インスタンスで処理されます。

_REPL を切断し、SBCL インスタンスを終了するには、上部メニューの `View/Command
Palette` から Command Palette を開き、`Alive: Detach from REPL` を選びます。_

すべての操作にはキーバインドがあります。必要に応じて調べ、変更してください。

### レシピ

_特に明記しない限り、すべてのレシピは、VSCode でファイルを開き、REPL が接続されている状態を前提とします。_

_式を評価するときは、評価したい S 式の中、または直後のどこかにカーソルを置いて、評価する式を選びます。_

#### 文をインラインで評価する

![](assets/vscode-gifs/in-line-eval.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選びます。
3. `=> 4 (3 bits, #x4, #o4,
   #b100)` と書かれた小さなポップアップが表示されます。これが結果です。

   _文をインラインで評価することは、それを REPL に送ることとまったく同じです。違いは表示方法だけです。_

#### 文を評価する

![](assets/vscode-gifs/eval.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Send To REPL` を選びます。
3. 式が REPL に表示され、結果も一緒に表示されます。

~~~lisp
CL-USER>
(+ 2 2)
4
CL-USER>
~~~

#### ファイルをコンパイルする

![](assets/vscode-gifs/compile.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(+ 2 2)
~~~

2. 上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Compile` を選びます。
3. REPL にコンパイルの詳細が表示され、ファイルシステムに fasl ファイルができます。

~~~
CL-USER>

; compiling file "/Users/jason/Desktop/hello.lisp" (written 14 SEP 2021 04:24:37 AM):


; wrote /Users/jason/Desktop/hello.fasl

; compilation finished in 0:00:00.001
~~~

#### 対話的デバッガを使って中断する

![](assets/vscode-gifs/debug-abort.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(defun divide (x y)
  (/ x y))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、`define`
   した関数を image にロードします。
3. 開いているファイルに新しい行を追加し、次を入力します。

~~~lisp
(divide 1 0)
~~~

4. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、divide 関数を image 内で実行します。
5. 対話的デバッガがポップアップします。`Restarts`
   の節で、選択肢 2 を選んで中断します。
6. エディタとまだ動いている REPL に戻り、何も起きなかったかのように続けられます。

#### 対話的デバッガを使って実行時に問題を修正する

![](assets/vscode-gifs/debug-fix.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y))
          (y)
          "The second argument can not be zero.")
  (/ x y))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、`define`
   した関数を image にロードします。
3. 開いているファイルに新しい行を追加し、次を入力します。

~~~lisp
(divide 1 0)
~~~

4. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで、divide 関数を image 内で実行します。
5. 対話的デバッガがポップアップします。`Restarts`
   の節で、選択肢 0 の "Retry assertion with new value for Y" を選びます。
6. ポップアップメニューに `y'` と入力します。
7. 次のポップアップメニューに `1` と入力します。
8. `=> 1 (1 bit, #x1, #o1,
   #b1)` と書かれた小さなポップアップが表示されるはずです。これは新しい値の結果です。デバッガへクラッシュした後、クラッシュの原因になった値を変更させてもらい、誤った `0` という値を入力しなかったかのように処理を進めた状態で、エディタとまだ動いている REPL に戻っています。

_デバッガでできることのさらなるアイデアは[エラー処理](error_handling.md)のページにあります。_

[​]{#macro--expand-}

#### マクロを展開する

![](assets/vscode-gifs/macro-expand.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(loop for x in '(a b c d e) do
     (print x))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Macro Expand` を選んで for-loop マクロを展開します。
3. 次のようなものが見えるはずです。

~~~lisp
(BLOCK NIL
  (LET ((X NIL)
        (#:LOOP-LIST-559
         (SB-KERNEL:THE* (LIST :USE-ANNOTATIONS T
                               :SOURCE-FORM '(A B C D E))
                         '(A B C D E))))
    (DECLARE (IGNORABLE #:LOOP-LIST-559)
             (IGNORABLE X))
    (TAGBODY
     SB-LOOP::NEXT-LOOP
      (SETQ X (CAR #:LOOP-LIST-559))
      (SETQ #:LOOP-LIST-559 (CDR #:LOOP-LIST-559))
      (PRINT X)
      (IF (ENDP #:LOOP-LIST-559)
          (GO SB-LOOP::END-LOOP))
      (GO SB-LOOP::NEXT-LOOP)
     SB-LOOP::END-LOOP)))
~~~

[​]{#function--disassemble-}

#### 関数を逆アセンブルする

![](assets/vscode-gifs/disassemble.gif)

1. エディタウィンドウの開いているファイルに、次を入力します。

~~~lisp
(defun hello (name)
  (format t "Hello, ~A~%" name))
~~~

2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Inline Eval` を選んで関数を image にロードします。
2. まだそうなっていなければ、最後の括弧の後にカーソルを置きます。上部メニューの `View/Command
   Palette` から Command Palette を開き、`Alive: Disassemble` を選んでコンパイル済み関数の機械語を出力します。
3. 次のように始まります。

~~~
; disassembly for HELLO
; Size: 172 bytes. Origin: #x70052478B4                       ; HELLO
; 8B4:       AC0A40F9         LDR R2, [THREAD, #16]           ; binding-stack-pointer
; 8B8:       4C0F00F9         STR R2, [CFP, #24]
; 8BC:       AC4642F9         LDR R2, [THREAD, #1160]         ; tls: *STANDARD-OUTPUT*
; 8C0:       9F8501F1         CMP R2, #97
; 8C4:       61000054         BNE L0
; 8C8:       4AFDFF58         LDR R0, #x7005247870            ; '*STANDARD-OUTPUT*
; 8CC:       4C1140F8         LDR R2, [R0, #1]
; 8D0: L0:   4C1700F9         STR R2, [CFP, #40]
; 8D4:       E0031BAA         MOV NL0, CSP
; 8D8:       7A0701F8         STR CFP, [CSP], #16
; 8DC:       EAFCFF58         LDR R0, #x7005247878            ; "Hello, "
; 8E0:       4B1740F9         LDR R1, [CFP, #40]
; 8E4:       B6FBFF58         LDR LEXENV, #x7005247858        ; #<SB-KERNEL:FDEFN WRITE-STRING>
; 8E8:       970080D2         MOVZ NARGS, #4
; 8EC:       FA0300AA         MOV CFP, NL0
; 8F0:       DE9240F8         LDR LR, [LEXENV, #9]
; 8F4:       C0033FD6         BLR LR
; 8F8:       3B039B9A         CSEL CSP, OCFP, CSP, EQ
; 8FC:       E0031BAA         MOV NL0, CSP
; 900:       7A0701F8         STR CFP, [CSP], #16
; 904:       4A2F42A9         LDP R0, R1, [CFP, #32]
; 908:       D6FAFF58         LDR LEXENV, #x7005247860        ; #<SB-KERNEL:FDEFN PRINC>
; 90C:       970080D2         MOVZ NARGS, #4
; 910:       FA0300AA         MOV CFP, NL0
; 914:       DE9240F8         LDR LR, [LEXENV, #9]
; 918:       C0033FD6         BLR LR
; 91C:       3B039B9A         CSEL CSP, OCFP, CSP, EQ
; 920:       E0031BAA         MOV NL0, CSP
; 924:       7A0701F8         STR CFP, [CSP], #16
; 928:       2A4981D2         MOVZ R0, #2633
; 92C:       4B1740F9         LDR R1, [CFP, #40]
; 930:       D6F9FF58         LDR LEXENV, #x7005247868        ; #<SB-KERNEL:FDEFN WRITE-CHAR>
; 934:       970080D2         MOVZ NARGS, #4
; 938:       FA0300AA         MOV CFP, NL0
; 93C:       DE9240F8         LDR LR, [LEXENV, #9]
; 940:       C0033FD6         BLR LR
; 944:       3B039B9A         CSEL CSP, OCFP, CSP, EQ
; 948:       EA031DAA         MOV R0, NULL
; 94C:       FB031AAA         MOV CSP, CFP
; 950:       5A7B40A9         LDP CFP, LR, [CFP]
; 954:       BF0300F1         CMP NULL, #0
; 958:       C0035FD6         RET
; 95C:       E00120D4         BRK #15                         ; Invalid argument count trap
~~~

#### Common Lisp システムのひな形を作成する

![](assets/vscode-gifs/skeleton.gif)

_このレシピは新しい Common Lisp システムを作成するため、稼働中の REPL は不要です。_

1. 新しいプロジェクト用に `experiment` というフォルダを作成します。
2. 新しく作成したディレクトリで vscode を開きます。

```bash
cd experiment
code .
```

3. 新しい Common Lisp システムを作成します。
  - VSCode 内で、上部メニューの
      `View/Command Palette` から Command Palette を開き、システムのひな形を生成します: `Alive: System Skeleton`
  - 前のコマンドは、次のディレクトリ構成を生成しているはずです。
      - experiment.asd
      - src/
        - app.lisp
      - test/
        - all.lisp

それらのファイルの内容は次のとおりです。

`experiment.asd`:

~~~lisp
(in-package :asdf-user)

(defsystem "experiment"
  :class :package-inferred-system
  :depends-on ("experiment/src/app")
  :description ""
  :in-order-to ((test-op (load-op "experiment/test/all")))
  :perform (test-op (o c) (symbol-call :test/all :test-suite)))

(defsystem "experiment/test"
  :depends-on ("experiment/test/all"))

(register-system-packages "experiment/src/app" '(:app))
(register-system-packages "experiment/test/all" '(:test/all))
~~~

`src/app.lisp`:

~~~lisp
(defpackage :app
  (:use :cl))

(in-package :app)
~~~

`test/all.lisp`:

~~~lisp
(defpackage :test/all
  (:use :cl
        :app)
  (:export :test-suite))

(in-package :test/all)

(defun test-suite ()
  (format T "Test Suite~%"))
~~~

### 任意のカスタム設定

#### Quicklisp と連携するよう VSCode Alive を設定する

quicklisp がインストール済みで、初期化時にロードされるよう設定されていると仮定すると、quicklisp はそのまま動きます。

#### 既定のコンテキストの CLPM と連携するよう VSCode Alive を設定する

[CLPM](https://clpm.dev) がインストール済みかつ設定済みであると仮定し、[vscode の設定を変更](https://code.visualstudio.com/docs/getstarted/settings)して次のようにします。

1. VSCode の設定に次を追加します。

```json
  "alive.swank.startupCommand":[
    "clpm",
    "exec",
    "--",
    "sbcl",
    "--eval",
    "(asdf:load-system :swank)",
    "--eval",
    "(swank:create-server)"
  ],
```

_これは既定の clpm コンテキストで sbcl を起動します。_

#### bundle の clpmfile を使う CLPM と連携するよう VSCode Alive を設定する

[CLPM](https://clpm.dev) がインストール済みかつ設定済みであり、
ホームディレクトリのルートに swank を開発用の依存として含む bundle が設定されていると仮定し、[vscode
の設定](https://code.visualstudio.com/docs/getstarted/settings)を変更して次のようにします。

1. VSCode の設定に次を追加します。

```json
  "alive.swank.startupCommand":[
    "clpm",
    "bundle",
    "exec",
    "--",
    "sbcl",
    "--eval",
    "(asdf:load-system :swank)",
    "--eval",
    "(swank:create-server)"
  ],
```

_これは bundle の clpm コンテキストで sbcl を起動します。_

#### Roswell と連携するよう VSCode Alive を設定する

[Roswell](https://roswell.github.io/) がインストール済みであると仮定し、
[vscode の設定](https://code.visualstudio.com/docs/getstarted/settings)を変更して次のようにします。

```json
  "alive.swank.startupCommand": [
    "ros",
    "run",
    "--eval",
    "(require :asdf)",
    "--eval",
    "(asdf:load-system :swank)",
    "--eval",
    "(swank:create-server)"
  ]
```

#### VSCode Alive を Docker コンテナに接続する

![](assets/vscode-gifs/docker-connect.gif)

_これらの手順は、リモート接続、wsl 接続、github Codespaces でも、それぞれ `Remote - SSH`、`Remote -
WSL`、`Github Codespaces` の拡張機能を使って動きます。拡張機能がインストールされていることを前提とします。この例では、[Containers 拡張機能がインストール済みかつ設定済み](https://code.visualstudio.com/docs/remote/containers)であることを確認してください。_

1. sbcl がインストールされた docker イメージを pull します。この例では最新の clfoundations sbcl を使います。

```sh
docker pull clfoundation/sbcl
```

2. docker イメージ内で bash を実行し、起動して動かし続けます。

```sh
docker run -it clfoundation/sbcl bash
```

3. VSCode の Side Bar で `Remote Explorer` のアイコンをクリックします。
4. Dev Containers の一覧で clfoundation/sbcl を右クリックし、`Attach to Container` を選びます。
5. 開いた新しい VSCode ウィンドウの Side Bar で、`Explorer` をクリックします。_ファイルがまだ表示されていない場合は、コンテナ内のファイルを表示するよう指定する必要があるかもしれません。_
6. コンテナ内のファイルを表示できたら、VSCode の `Side Bar` 内で右クリックし、`New File` を選びます。ファイル名を `hello.lisp` にします。
7. VSCode の Side Bar で `Extensions` のアイコンをクリックします。
8. `Alive` プラグインの `Install in Container...` ボタンをクリックします。
9. `hello.lisp` ファイルを開き、このレシピの冒頭にある "Connect VSCode to a
   REPL" の手順に従います。
10. これで、docker コンテナ内の SBCL イメージで動く Slime サーバーに接続された REPL を持つ VSCode が
    動いています。
 
#  LispWorks レビュー {#chapter-lispworks}
 

[LispWorks](http://www.lispworks.com/) は Common Lisp の処理系で、独自の統合開発環境（IDE）と、CAPI GUI ツールキットのような独自機能を備えています。これは**プロプライエタリ**で、**無料の制限版**も提供されています。

ここでは主にその IDE を見ていきます。Emacs と Slime に慣れた Lisp ユーザに何を提供できるのか、という観点です。短く言えば、扱いやすいグラフィカルステッパ、トレーサ、コードカバレッジブラウザ、クラスブラウザといった、より多くのグラフィカルツールがあります。ブレークポイントの設定と利用も Slime より簡単でした。

LispWorks はさらに統合されたツールも提供します。たとえばプロセス browser は Lisp イメージ内で実行中の全プロセスを一覧し、それらを停止、break、debug できます。また、多くの情報をグラフ形式で表示します。たとえば関数呼び出しのグラフや、作成された全ウィンドウのグラフです。

![Mate デスクトップ環境での LispWorks の listener と editor](assets/lispworks/two-sided-view.png "Mate デスクトップ環境での LispWorks の listener と editor")

## LispWorks の機能

LispWorks の機能をエディションとプラットフォーム別にまとめた表はここで見られます: [http://www.lispworks.com/products/features.html](http://www.lispworks.com/products/features.html)。

注目点:

- Windows、MacOS、Linux、Solaris、FreeBSD での 32-bit、64-bit、ARM サポート
- [CAPI 移植性のある GUI ツールキット](http://www.lispworks.com/documentation/lw61/CAPRM/html/capiref.htm): Windows、Cocoa、GTK+、Motif でネイティブな外観を提供します。
  - グラフィカルな "Interface Builder"（QtCreator のようなもの）が付属します（ただし MacOS では利用できません（mobile でも利用できません））
- Android と iOS 向けの [LispWorks for mobile runtime](http://www.lispworks.com/products/lw4mr.html)
- 最適化されたアプリケーション配布: LispWorks は tree shaker を使って、配布アプリケーションから未使用の Lisp コードを取り除けます。そのため、既存のオープンソース処理系より軽いバイナリを配布できます。
- 動的ライブラリとして配布できること
- Lisp から Java を呼ぶ、またはその逆を可能にする [Java インターフェイス](http://www.lispworks.com/documentation/lw71/LW/html/lw-113.htm)
- Objective-C と Cocoa のインターフェイス。drag and drop と multi-touch をサポート
- Foreign Language Interface
- SSL と IPv6 をサポートする TCP/UDP sockets
- ネイティブスレッドと symmetric multiprocessing、unicode サポート、その他すべての Common Lisp 機能、そしてその他すべての LispWorks Enterprise 機能

そしてもちろん、組み込み IDE があります。

LispWorks は産業界のさまざまな分野で使われています。開発元は [success stories の一覧](http://www.lispworks.com/success-stories/index.html)を管理しています。私たち自身が使えるソフトウェアとしては、[ScoreCloud](https://scorecloud.com/)（楽器を弾いたり、歌ったり、口笛を吹いたりすると楽譜を書いてくれる音楽記譜ソフトウェア）や [OpenMusic](https://github.com/openmusic-project/openmusic/)（オープンソースの作曲環境）が見事です。


### Free edition の制限

ダウンロード手順と制限は[ダウンロードページ](http://www.lispworks.com/downloads/index.html)に示されています。

制限は次のとおりです。

- **ヒープサイズの制限**があります。これを超えるとイメージは終了します。制限に近づくと警告が出ます。

何ができなくなるのでしょうか。例として、同じイメージ内で次のライブラリ群をまとめてロードすることはできません。

~~~lisp
(ql:quickload '("alexandria" "serapeum" "bordeaux-threads"
    "lparallel" "dexador" "hunchentoot" "quri"
    "cl-ppcre" "mito"))
~~~

- 各セッションには**5 時間の時間制限**があります。その後 LispWorks Personal は終了し、作業内容の保存や、一時ファイル削除などの後始末を行わない可能性があります。4 時間使用すると警告されます。

- **バイナリを作成できません**。実際、[save-image](http://www.lispworks.com/documentation/lw71/LW/html/lw-95.htm)、[deliver](http://www.lispworks.com/documentation/lw71/DV/html/delivery-4.htm#pgfId-852223)（スタンドアロン実行ファイルを作成するための*その*関数）、load-all-patches は利用できません。

- **初期化ファイルはロードされません**。Emacs で `~/.sbclrc` から Quicklisp を初期化することに慣れている場合、LispWorks を起動するたびに init file を手動でロードする必要があります（`(load #p"~/.your-init-file`））。

参考までに、起動ファイルに入れるために Quicklisp が提供するスニペットは次のとおりです。

~~~lisp
;; quicklisp を ~/quicklisp/ にインストールしている場合
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
~~~

これをリスナーのウィンドウに貼り付ける必要があります（`C-y` キー、y は "yank" の y です）。

- LispWorks Professional と Enterprise Editions の一部である階層化製品（CLIM、KnowledgeWorks、Common SQL、LispWorks ORB）は含まれていません。ただし、**CAPI ツールキットは試せます**。

インストール手順では、ダウンロードリンクを受け取るために HTML フォームへ入力し、次に利用規約とライセンスへの同意を求める最初のスクリプトを実行し、さらにソフトウェアをインストールする 2 つ目のスクリプトを実行します。

### ライセンスモデル

LispWorks には実際には 4 つの有料エディションがあります。ここで自分たちで説明しています: [http://www.lispworks.com/products/lispworks.html](http://www.lispworks.com/products/lispworks.html)。要約すると次のとおりです。

- Hobbyist edition: `save-image` と `load-all-patches` があり、minor version の更新を適用できます。明らかな制限はありませんが、非商用かつ非学術利用向けです。
- HobbyistDV edition: 実行ファイルを作成するための `deliver` 関数があります（これも非商用かつ非学術利用向け）。
- Professional edition: `deliver` 関数があり、商用および学術利用向けです。
- Enterprise edition: Common SQL インターフェイス、LispWorks ORB、KnowledgeWorks といったエンタープライズ向けモジュールを含みます。

執筆時点では、hobbyist edition のライセンスは 750 USD、pro version はその倍です。これらは LW のバージョンごと、プラットフォームごとに購入します。時間制限はありません。

<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> 提供元のリソースを必ず再確認し、遠慮なく問い合わせてください。
</div>


## LispWorks IDE

LispWorks IDE は自己完結していますが、Emacs と Slime から LispWorks という処理系を使うこともできます（下記参照）。IDE は Common Lisp イメージの*内部*で動作します。これは、Swank と Slime を通じて Lisp イメージと通信する外部プログラムである Emacs とは異なります。ユーザコードは同じプロセスで実行されます。

### エディタ

エディタは期待どおりの機能を提供します。TAB 補完のポップアップ、シンタックスハイライト、Emacs 風のキーバインド（`M-x` の拡張コマンドを含む）です。メニューは機能発見を助けます。

個人的には、編集体験はやや「素朴」だと感じました。たとえば:

- 改行後のインデントは自動ではなく、もう一度 TAB を押す必要があります。
- 自動補完はあいまい補完ではありません。
- ~~Paredit~~ に似たプラグイン（まったく新しい（2021）[Paredit for LispWorks](https://github.com/g000001/lw-paredit) はあります）や Lispy、Vim レイヤーはありません。

また、`M-.` に割り当てられた go-to-source 関数が組み込み Lisp シンボルではうまく動かないという問題もありました。どうやら LispWorks はあまり多くのソースコードを提供しておらず、主にエディタのコードだけのようです。Allegro CL のような別の商用 Lisp は、より多くのソースコードを提供しています。

エディタには興味深いタブがあります: Changed Definitions です。これは、選択に応じて、セッションの最初の編集、最後の保存、最後のコンパイル以降に再定義された関数とメソッドを一覧します。

関連項目:

- [Editor User Guide](http://www.lispworks.com/documentation/lw71/EDUG-U/html/eduser-u.htm)


### Keybindings

ほとんどのキーバインドは Emacs と似ていますが、すべてではありません。いくつかの違いを挙げます。

- **関数をコンパイルする**には、C-c C-c ではなく `C-S-c`（control、shift、c）を使います。
- **現在のバッファをコンパイルする**には、C-c C-k ではなく `C-S-b` を使います。

似ているものには次があります。

- `C-g` で今していることを取り消す
- `C-x C-s` で現在のバッファを保存
- `M-w` と `C-y` でコピーと貼り付け
- `M-b`、`M-f`、`C-a`、`C-e`… で単語単位の移動、行頭・行末への移動
- `C-k` で行末まで削除、`C-w` で選択リージョンを削除
- `M-.` でシンボルのソースを探す
- `C-x C-e` で現在の defun を評価
- …

便利な関数の中には、デフォルトでは keybinding がないものもあります。たとえば:

<!-- - delete selected text with `M-x delete-region` (or kill the region with `C-w`) -->

- `M-x Clear Listener` で REPL をクリア
- `Backward Kill Line`

KDE/Gnome 風の**古典的なキーバインド**を使うこともできます。Preferences メニュー、環境、Emulation タブへ進みます。

**Vim レイヤーはありません**。

### 名前でキーバインドを検索する

関数に対応するキーバインド、またはキーバインドから関数名を検索できます。メニュー（Help -> Editing -> Key to Command / Command to Key）か、Emacs と同じく `C-h` に続いてキーを押します。たとえば `C-h k` と入力してからキーバインドを入力すると、コマンド名が得られます。詳しくは `C-h ?` を見てください。

### IDE を調整する

キーバインドは変更できます。エディタの状態は `editor` パッケージからアクセスでき、エディタは CAPI フレームワークで構築されているため、`capi` インターフェイスも使えます。便利な関数には次があります。

~~~lisp
`
editor:bind-key
editor:defcommand
editor:current-point
editor:with-point  ;; ポイントの位置を保存
editor:move-point
editor:*buffer-list*
editor:*in-listener* ;; REPL 内にいるとき T を返す
…
~~~

キーを割り当てる方法は次のとおりです。

~~~lisp
;; 新しい行をインデントする。
;; デフォルトでは、Return 後にポイントはインデントされない。
(editor:bind-key "Indent New Line" #\Return :mode "Lisp")

;; 対を挿入する。
(editor:bind-key "Insert Parentheses For Selection" #\( :mode "Lisp")
(editor:bind-key "Insert Double Quotes For Selection"
   #\"
  :mode "Lisp")
~~~

新しいコマンドを定義する方法は次のとおりです。`)` キーで次の閉じ括弧を越えるようにします。


~~~lisp
(editor:defcommand "Move Over ()" (p)
  "Move past the next close parenthesis.
Any indentation preceeding the parenthesis is deleted."
  "Move past the next close parenthesis."
  ;; Thomas Hermann に感謝
  ;; https://github.com/ThomasHermann/LispWorks/blob/master/editor.lisp
  (declare (ignore p))
  (let ((point (editor:current-point)))
    (editor:with-point ((m point))
      (cond ((editor::forward-up-list m)
	     (editor:move-point point m)
             (editor::point-before point)
             (loop (editor:with-point ((back point))
                     (editor::back-to-indentation back)
                     (unless (editor:point= back point)
                       (return)))
                   (editor::delete-indentation point))
	     (editor::point-after point))
	    (t (editor:editor-error))))))

(editor:bind-key "Move Over ()" #\) :mode "Lisp")
~~~

special form のインデントを変更する方法は次のとおりです。

~~~lisp
(editor:setup-indent "if" 1 4 1)
~~~

関連項目:

- LispWorks のキーバインドの一覧: [https://www.nicklevine.org/declarative/lectures/additional/key-binds.html](https://www.nicklevine.org/declarative/lectures/additional/key-binds.html)

### リスナー

リスナーは期待どおりの REPL ですが、Slime とは少し違いがあります。

入力を行ごと、またはフォームごとに評価するのではなく、入力中に解析します。そのため、いくつかのエラーは即座に得られます。たとえば `(abc` と入力します。ここまでは問題ありません。次にコロンを入力して `(abc:` にすると、入力のすぐ上にエラーメッセージが表示されます。

```
Error while reading: Reader cannot find package ABC.

CL-USER 1 > (abc:
```

実際、ここで `abc:` はパッケージを参照していますが、そのようなパッケージは存在しません。

対話的デバッガは主にテキストベースですが、グラフィカルな要素でも操作できます。たとえばメニューバーの Abort ボタンを使うとトップレベルに戻ります。グラフィカルなデバッガを呼び出してスタックトレースを見て操作することもできます。ツールバーの一番端にある Debugger ボタンを参照してください。

![](assets/lispworks/toolbar-debugger.png)

スタックトレースに自分の関数名が表示されている場合（コードを REPL に直接書いたのではなく、ファイルに書いてコンパイルしていれば表示されます）、その名前をダブルクリックするとエディタに戻り、エラーを引き起こしたコードの部分がハイライトされます。


<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> これは Slime で <code>M-v</code> を押すのと同等です。
</div>

テキストベースのデバッガの代わりに、グラフィカルなデバッガがデフォルトで現れるよう選ぶこともできます。

リスナーは、Slime のカンマ `,` で始まるものに少し似た補助コマンドを提供します。

```
CL-USER 1 > :help

:bug-form <subject> &key <filename>
         Print out a bug report form, optionally to a file.
:get <variable> <command identifier>
         Get a previous command (found by its number or a symbol/subform within it) and put it in a variable.
:help    Produce this list.
:his &optional <n1> <n2>
         List the command history, optionally the last n1 or range n1 to n2.
:redo &optional <command identifier>
         Redo a previous command, found by its number or a symbol/subform within it.
:use <new> <old> &optional <command identifier>
         Do variant of a previous command, replacing old symbol/subform with new symbol/subform.
```


### Stepper。Breakpoints。

[stepper](http://www.lispworks.com/documentation/lw61/IDE-W/html/ide-w-496.htm) は、LispWorks が光る領域の一つです。

エディタウィンドウでコードを書いているとき、大きな赤い "Breakpoint" ボタン（または `M-x Stepper Breakpoint`）でブレークポイントを設定できます。これによりコードに赤い印が付きます。

次にそのコードが実行されると、包括的な Stepper のポップアップウィンドウが表示されます。内容は次のとおりです。

- ソースコード。評価中の式を示すインジケータ付き
- 2 つのタブを持つ下部のペイン:
  - バックトレース。途中の変数を表示し、プログラム実行中の変化を示します
  - リスナー。この関数呼び出しの文脈で式を評価できます
- stepper の操作ボタンを持つメニューバー: 次の式へ step into、次の関数呼び出しへ step、カーソルの位置まで実行、次のブレークポイントまで実行継続、など

![](assets/lispworks/stepper.gif)

それだけではありません。視覚的ではない、REPL 向けの stepper も便利です。評価中のフォームとその結果を表示します。

この例では、`:s` を使って現在のフォームとサブフォームを "step" します。通常のリスナーを使っており、プロンプト（ここでは小さな ` -> `）の後に任意の Lisp コードを書けます。またローカル変数（`X`）にもアクセスできます。

~~~lisp
CL-USER 4 > (defun my-abs (x)
              (cond ((> x 0) x) ((< x 0) (- x)) (t 0)))
CL-USER 5 > (step (my-abs -5))
(MY-ABS -5) -> :s
   -5 -> :s
   -5
   (COND ((> X 0) X) ((< X 0) (- X)) (T 0)) <=> (IF (> X 0) (PROGN X) (IF (< X 0) (- X) (PROGN 0)))
   ;; local variables へのアクセス:
   (IF (> X 0) (PROGN X) (IF (< X 0) (- X) (PROGN 0))) -> (format t "Is X equal to -5? ~a~&" (if (equal x -5) "yes" "no"))
Is X equal to -5? yes
   (IF (> X 0) (PROGN X) (IF (< X 0) (- X) (PROGN 0))) -> :s
      (> X 0) -> :s
         X -> :s
         -5
         0 -> :s
         0
      NIL
      (IF (< X 0) (- X) (PROGN 0)) -> :s
         (< X 0) -> :s
            X -> :s
            -5
            0 -> :s
            0
         T
         (- X) -> :s
            X -> :s
            -5
         5
      5
   5
5
~~~

利用可能な stepper のコマンドは次のとおりです（`:?` を参照）。

~~~
:s       Step this form and all of its subforms (optional +ve integer arg)
:st      Step this form without stepping its subforms
:si      Step this form without stepping its arguments if it is a function call
:su      Step up out of this form without stepping its subforms
:sr      Return a value to use for this form
:sq      Quit from the current stepper level
:bug-form <subject> &key <filename>
         Print out a bug report form, optionally to a file.
:get <variable> <command identifier>
         Get a previous command (found by its number or a symbol/subform within it) and put it in a variable.
:help    Produce this list.
:his &optional <n1> <n2>
         List the command history, optionally the last n1 or range n1 to n2.
:redo &optional <command identifier>
         Redo a previous command, found by its number or a symbol/subform within it.
:use <new> <old> &optional <command identifier>
         Do variant of a previous command, replacing old symbol/subform with new symbol/subform.
~~~

### クラスブラウザ

クラスブラウザを使うと、クラスのスロット、親クラス、利用可能なメソッドなどを調べられます。

単純なクラスを作りましょう。

~~~lisp
(defclass person ()
  ((name :accessor name
         :initarg :name
         :initform "")
   (lisper :accessor lisperp
           :initform t)))
~~~

次にクラスブラウザを呼び出します。

- リスナーの "Class" ボタンを使う
- またはメニューの 式 -> クラスを使う
- またはクラスにカーソルを置いて `M-x Describe class` を呼ぶ

![](assets/lispworks/class-browser.png)

これはいくつかのペインで構成されています。

- **クラス階層**。左にスーパークラス、右にサブクラスを表示し、下部に説明を表示します
- **スーパークラスビューア**。単純な図の形で表示します。サブクラスについても同様です
- **スロットのペイン**（デフォルト）
- 利用可能な **initargs**
- そのクラスの既存の **総称関数**
- そして **クラス優先順位リスト**

関数のペインは、そのクラスに適用可能なすべてのメソッドを一覧するため、CLOS オブジェクトシステムが提供する公開メソッドを見つけられます。たとえば `initialize-instance`、`print-object`、`shared-initialize` などです。ダブルクリックするとソースに移動できます。継承されたメソッドを含めないよう選ぶこともできます（"include inherited" のチェックボックスを参照）。

ツールバーにはボタン（たとえば総称関数を Inspect するもの）があり、メソッドのメニューにはさらに操作があります。たとえば **function calls** を見る方法、関数を **undefine** または **trace** するメニューなどです。

さらに読む:

* [Chapter 8 of the documentation: the Class Browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-55.htm#pgfId-871798)


### 関数呼び出しブラウザ

関数呼び出しブラウザを使うと、ある関数の呼び出し元と呼び出し先のグラフを見られます。表示情報を絞り込んだり、コールスタックをさらに調べたりする方法がいくつか用意されています。

<div class="info-box info">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> そのような相互参照を探す Slime の関数は <code>slime-who-[calls, references, binds, sets, depends-on, specializes, macroexpands]</code> です。
</div>

いくつかのパッケージをロードした後、`string-trim` 関数を誰が呼んでいるかを示す単純な例です。

![関数呼び出しブラウザ](assets/lispworks/function-call-browser.png)

すべてのパッケージから関数を表示しますが、たとえば "current and used" や現在のパッケージのみに制限する選択ボックスがあります。

グラフに表示された関数をダブルクリックするとソースに移動します。多くの LispWorks のビューと同様に、関数のメニューでは選択した関数をさらに操作できます。trace、undefine、listen（オブジェクトを Listener に貼り付ける）などです。

Text タブは同じ情報をテキストで、呼び出し元と呼び出し先を横並びで表示します。

コンパイル済みコードについて相互参照を見ることができ、その機能が有効になっていることを確認する必要があります。コードをコンパイルすると、LispWorks は次のようなコンパイル出力を表示します。

```
;;; Safety = 3, Speed = 1, Space = 1, Float = 1, Interruptible = 1
;;; Compilation speed = 1, Debug = 2, Fixnum safety = 3
;;; Source level debugging is on
;;; Source file recording is  on
;;; Cross referencing is on
```

相互参照が有効になっていることが分かります。そうでなければ `(toggle-source-debugging t)` で有効にします。

さらに読む:

- [Chapter 15: the function call browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-114.htm#pgfId-852601)


### プロセスブラウザ

プロセスブラウザは実行中の全スレッドの一覧を表示します。入力欄では名前で絞り込めます。正規表現を受け付けます。その後、これらのプロセスを stop、inspect、listen、break into できます。

!["The process browser"](assets/lispworks/process-browser.png)

さらに読む:

* [Chapter 28: the Process Browser](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u-178.htm#pgfId-852666)

### イメージの保存

LispWorks でイメージを保存する方法は SBCL とは異なります。

- 今すぐイメージを保存することも、後の時点にスナップショットの作成を予約することもできます
- 新しく作成されたイメージは LispWorks 環境のデフォルトのコアイメージになります
- REPL のセッションが保存されます
- ウィンドウの構成が保存されます
- スレッドが保存されます

つまり実質的に、イメージを保存すれば開発環境を同じ状態に戻せます。現在の作業のスナップショットを取り、離れた場所から続けられるわけです。

たとえば REPL からゲームを開始し、そのウィンドウで少し遊び、イメージを保存すると、復元時にそのゲームと状態が戻ってきます。


### その他

`Search Files` 機能は気に入っています。再帰的な `grep` のようなものですが、結果を表示し、ダブルクリックでき、さらにいくつかの操作を提供する典型的な LispWorks のグラフィカルなウィンドウが得られます。

最後に、**コンパイルコンディションブラウザ** も見てください。システムをコンパイルすると、LispWorks はすべての警告とエラーを特別なブラウザに入れます。それ以降は、それらを修正し、ブラウザから消えていくのを見ながら作業できます。開発中に警告とエラーを追跡し続ける助けになります。


## Emacs と Slime から LispWorks を使う

これには 2 つの方法があります。1 つ目は、LispWorks を通常どおり起動し、Swank サーバーを開始して Emacs から接続する方法です（Swank は Slime のバックエンド部分です）。

まず依存をロードします。

~~~lisp
(ql:quickload "swank")
;; or
(load "~/.emacs.d/elpa/slime-20xx/swank-loader.lisp")
~~~

サーバーを開始します。

~~~lisp
(swank:create-server :port 9876)
;; Swank started at port: 9876.
9876
~~~

Emacs から `M-x slime-connect` を実行し、ホストに `localhost`、ポートに `9876` を選びます。

接続されているはずです。`(lisp-implementation-type)` で確認してください。これで LispWorks の機能を使えます。

~~~lisp
(setq button
      (make-instance 'capi:push-button
                     :data "Button"))
(capi:contain button)
~~~

2 つ目の方法は、Swank をロードした GUI なしの LispWorks イメージを作成し、このイメージを SLIME または SLY から実行することです。たとえばマルチプロセッシングを有効にした、いわゆる `console` イメージを作るには:

~~~lisp
(in-package "CL-USER")
(load-all-patches)
(save-image "~/lw-console"
            :console t
            :multiprocessing t
            :environment nil)
~~~

そして新しいイメージ ~/lw-console を作成するため、LispWorks を次のように実行します。

    lispworks-7-0-0-x86-linux -build /tmp/resave.lisp

ただし、`console` は **Windows と Mac でのみ**実装されています。

LispWorks のドキュメントを参照してください。

## アプリケーションを配布する

LispWorks の配布の方法は `delivery` 関数を中心にしています。よいドキュメントがあります: [https://www.lispworks.com/documentation/lw80/deliv/deliv.htm](https://www.lispworks.com/documentation/lw80/deliv/deliv.htm)。

他のオープンソースの Lisp と違い、LispWorks は tree-shaker を提供します。これにより配布アプリケーションからパッケージを取り除き、7MB 前後の小さなバイナリを作れます。


#### 配布の制限

LispWorks の配布は、配布アプリケーションに `compile-file` を[含みません](https://www.lispworks.com/products/runtimes.html)（`save-image`、`deliver`、IDE も含みません）。そのため、配布済みのイメージ上で動的にコードを変更することはできません。Swank サーバーもなく、`ql:quickload` を使う可能性もありません。

ただしリモートデバッグを可能にするために、LW は独自のデバッガクライアントを提供します。バックエンド側では次を実行します。

    (require "remote-debugger-client")
    (dbg:start-client-remote-debugging-server :announce t)

IDE 側では次を実行します。

    (require "remote-debugger-full")
    (dbg:ide-connect-remote-debugging "host" :open-a-listener t)


## 関連項目

- [LispWorks IDE User Guide](http://www.lispworks.com/documentation/lw71/IDE-U/html/ide-u.htm)（ここで扱わなかった節も確認してください）
- [LispWorks on Wikipedia](https://en.wikipedia.org/wiki/LispWorks)
- [Awesome LispWorks](https://github.com/fourier/awesome-lispworks) の一覧
- [Common Lisp における真のイメージベースアプローチ](https://www.youtube.com/watch?v=nsKx40ab9SY) - SBCL と LispWorks の違い
- ブログ記事: [Delivering a LispWorks application](https://blog.dziban.net/posts/delivering-a-lispworks-application/)
- [lw-plugins](https://github.com/apr3vau/lw-plugins) - LispWorks のプラグイン:
  * 端末連携、コードの折りたたみ、サイドツリー、markdown のハイライト、Nerd Fonts、あいまい一致、強化されたディレクトリモード、領域の展開、対の編集、SVG レンダリング…
 
#  変数 {#chapter-variables}
 

あなたは初めての Common Lisp プログラムを書いていて（ようこそ！）、変数を宣言したいと思っています。どんな選択肢がありますか？

迷ったら、以下に示すようにトップレベルのパラメータには `defparameter` を使ってください。

<!-- Cookbook のほとんどの節とは異なり、学生やその他の
初心者が集中しやすいように、ここでは TLDR; を先頭に置いていません。 -->


## `defparameter`: トップレベル変数

トップレベル変数を宣言するには、次のように `defparameter` を使います。

```lisp
(defparameter *name* "me")

(defun hello (&optional name)
  "Say hello."
  (format t "Hello ~a!" (or name *name*)))
```

`defparameter` はオプション(省略可能)の第3引数として変数のドキュメント文字列を受け取れます：

```lisp
(defparameter *name* "me"
   "Default name to say hello to.")
```

インラインのドキュメント文字列はCommon Lispのインタラクティブな体験において重要な要素です。コーディングセッション中に出会うことになります（私たちLisperはたいていLispを長時間起動しっぱなしにしています）。EmacsとSlimeでは、`C-c C-d d`（`Alt-x slime-describe-symbol`）でシンボルのドキュメント文字列を参照できます。プログラムから参照することもできます：

~~~lisp
(documentation '*name* 'variable)
~~~

ここでは `*name*` が保持している値ではなく、`*name*` というシンボルのドキュメントを求めているため、`'*name*`（`(quote *name*)` の略記）のようにクォートしています。もう1つの「ドキュメントの種類」は `'function` です。Common Lispでは変数と関数は異なる「名前空間」に存在しており、それがここにも現れています。

値なしの `defparameter` については後述します。

### defparameter の再定義

Common Lispのコーディングセッションは通常、長時間にわたりとてもインタラクティブです。Lispを起動したまま、作業しながら対話を続けます。これはEmacsとSlime、Vim、AtomとSLIMA、VSCodeとAlive、Lem……その他のエディタ、あるいはターミナルから行います。

つまり、次のようなことができます：

1. 最初の defparameter を書く

```lisp
(defparameter *name* "me")
```

REPLに直接書くか、.lispファイルに書いてSlimでショートカットを使ってコンパイル＆ロードします（その式の上で `C-c C-c`（Alt-x `slime-compile-defun`）、または現在のバッファ全体をコンパイル・ロードするなら `C-c C-k`（Alt-x `slime-compile-and-load-file`））。シンプルなターミナルREPLで作業しているなら `(load …)` で.lispファイルを読み込めます）。

これで `*name*` 変数が実行中のイメージに存在するようになります。

2. defparameter の行を編集する:

```lisp
(defparameter *name* "you")
```

同じ方法で変更をロードします：REPLから、または `C-c C-c` で。これで `*name*` 変数は新しい値 "you" を持ちます。

`defvar` なら再定義されません。


## `defvar`: 再定義なし

`defvar` はトップレベルの変数を定義し、再定義から保護します。

`defvar` を再ロードしても現在の値は消去されません。変更するには setf を使う必要があります。


```lisp
(defvar *names-cache* (list)
  "Store a list of names we said \"hello\" to.")

(defun hello (&optional (name *name*))
   (pushnew name *names-cache* :test #'string-equal)
   (format t "hello ~a!" name))
```

実際に使ってみましょう：

```lisp
CL-USER> (hello)
hello you!
NIL
CL-USER> *names-cache*
("you")
CL-USER> (hello "lisper")
hello lisper!
NIL
CL-USER> *names-cache*
("lisper" "you")
```

`defvar` 行を再定義した場合（`C-c C-c`、`C-c C-k`、または REPL で）、`*names-cache*` はどうなるでしょうか。

変わりません。そして *それは良いことです* 。

実際、この変数はユーザーが直接目にするパラメータではなく、即座の用途はありませんが、プログラムの正確性や堅牢性などにとって重要です。Webサーバーのキャッシュを保持していると想像してください：新しいコードをロードするたびにそれを消去したくはありません。開発中は `C-c C-k` を連打して現在のファイルを何度もリロードしますし、本番環境で実行中のアプリをリロードすることもできますが、触れたくないものが確かにあります。データベース接続であれば、コードをコンパイルするたびに nil に戻して再接続したくはないでしょう。

`defvar` の変数値を変更するには `setf` を使う必要があります。

もちろん Slime にはこのためのショートカットがあります。`setf` の代わりに、`C-M-x`（Control+ Alt + x）、すなわちインタラクティブ関数 `slime-eval-defun`（これは `slime-re-evaluate-defvar` を呼びます）を使えます。

```
現在のトップレベルフォームを評価します。

フォームが "(defvar" で始まる場合は "slime-re-evaluate-defvar" を使います。
```


## " \*イヤーマフ\* " 規約

`*name*` のように「*イヤーマフ*」で囲んで書いているのに気づきましたか。これはレキシカルスコープ内でトップレベル変数を上書きしないようにするための重要な規約です。

```lisp
(defparameter name "lisper")

;; later…
(let ((name "something else"))
   ;;  ^^^ トップレベルの name を上書きする。見つけにくいバグになりうる。
   …)
```

イヤーマフを使えばこれが機能になります：

```lisp
(defparameter *db-name* "db.db")

(defun connect (&optional (db-name *db-name*))
  (sqlite:connect db-name))

(let ((*db-name* "another.db"))
  (connect))
  ;; ^^^^  db-nameオプションパラメータ（デフォルトは *db-name*）は "another.db" を見るようになる。
```

ちなみに、このようなユースケースでは `let` バインディングを抽象化した `with-…` マクロがよく見られます。

```lisp
(with-db "another.db"
  (connect))
```

余談ですが、[earmuff(イヤーマフ)](https://www.wordreference.com/definition/earmuff) とは冬に耳（だけ）を覆うものです。現実よりも映画で見たことがある人の方が多いかもしれません。最後にひと言：自分を大切にして、暖かくして、イヤーマフを使いましょう。

## グローバル変数は「ダイナミックスコープ」内に作られる

トップレベルのパラメータや変数はいわゆるダイナミックスコープ内に作られます。関数定義の中からも（先ほどのように）、`let` バインディングの中からも、どこからでもアクセスできます。

Lisp では、これらを [*ダイナミック変数*または*スペシャル変数*](https://cl-community-spec.github.io/pages/Dynamic-Variables.html) とも呼びます。

任意の場所から `proclaiming` を使って "special" と宣言することで作ることも可能です。日常的にやることではありませんが、Lispでは何でも可能ですから ;)

> ダイナミック変数は、それをバインドするフォームのダイナミックエクステントの外から参照することができる。そのような変数は「グローバル変数」と呼ばれることもあるが、あらゆる意味で単なるダイナミック変数であり、そのバインディングがたまたまグローバル環境に存在しているにすぎない。[Hyper Spec]


## `setf`: 値の変更

どんな変数も `setf` で変更できます:

```lisp
(setf *name* "Alice")
;; => "Alice"
```

新しい値が返ります。

実際、`setf` は値と変数のペアを複数受け取れます：

~~~lisp
(setf *name* "Bob"
      *db-name* "app.db")
;; => "app.db"
~~~

最後の値が返されます。

まだ宣言されていない変数を `setf` するとどうなるでしょうか？たいていは動作しますが警告が出ます：

```lisp
;; in SBCL 2.5.8
CL-USER> (setf *foo* "foo")
; in: SETF *FOO*
;     (SETF CL-USER::*FOO* "foo")
;
; caught WARNING:
;   undefined variable: CL-USER::*FOO*
;
; compilation unit finished
;   Undefined variable:
;     *FOO*
;   caught 1 WARNING condition
"foo"
```

返り値の "foo" が見えるので動作はしています。ただし、変数は先に `defparameter` や `defvar` で宣言してください。

`setf` のドキュメント文字列全体を読んでみましょう。興味深いことが書いてあります：

```txt
SETQ と同様にペアの引数を取る。最初はplace（場所）で、2番目はそのplaceに入れるべき値。最後の値を返す。place引数は、SETFが対応する設定フォームを知っているアクセスフォームであれば何でもよい。
```

`setq` も別のマクロですが、`setf` がより多くの「place」に対して動作するため、今では `setq` はほとんど使われません。関数やあらゆるものを `setf` できます。


## `let`, `let*`: レキシカルスコープの作成

`let` は限られたスコープ内で変数を定義したり、トップレベル変数を一時的にオーバーライドしたりするために使います。

下の例では、2つの変数は `let` のカッコの中でのみ存在します：

```lisp
(let* ((a 2)
       (square (* a a)))
   (format t "the square of ~a is ~a" a square))
   ;; ここまでは問題ありません

(format t "the value of a is: ~a" a)
;; => ERROR: the variable A is unbound
```

「unbound（未束縛）」とは、変数が NIL にさえ束縛されていないことを意味します。シンボル自体は存在するかもしれませんが、何にも関連付けられていません。

`let` のスコープが終わった直後、変数 `a` と `square` はもう存在しません。

Lispリーダーが `format` 式を読んだとき、グローバル環境には `a` シンボルが存在しますが、束縛されていません。

> 考えてみてください：変数名を書いてLispリーダーがそれを読むとシンボルは作られますが、何にも束縛されるわけではありません。

2つの変数は `let` バインディングの中のどんなフォームからもアクセスできます。2つ目の `let` を作ると、その*環境*は前のものを継承します（上で宣言した変数が見えます。当然ですが！）。

```lisp
(defparameter *name* "test")

(defun log (square)
  (format t "name is ~s and square is ~a" *name* square))

(let* ((a 2)
       (square (* a a)))
  ;; 最初の環境の中
  (let ((*name* "inside let"))
    ;; 2つ目の環境の中、
    ;; ダイナミックスコープにアクセスしている。
    (log square)))
;;  => name is "inside let" and square is 4
;;  => NIL

(print *name*)
;; => "test"
;;    ^^^^ letの外に出たので、ダイナミックスコープの値に戻る。
```

let の中で関数を定義することもできます。そうすることで関数定義はコンパイル時に周囲の let からのバインディングを「見る」ことになります。これはクロージャであり、関数の章で扱います。

「レキシカルスコープ」とは単純に言えば、

> 設立フォーム内の空間的またはテキスト的な領域に限定されたスコープ。関数のパラメータ名は通常レキシカルスコープを持つ。[Hyper Spec]

言い換えれば、変数のスコープはソースコード上の位置によって決まります。これは今日のベストプラクティスです。最も驚きの少ない方法です：ソースコードを見ればスコープが見えるのです。

### `let` と `let*`

ところで、`let` の構文とは何で、`let*` との違いは何でしょうか？

`let*` では互いに依存する変数を宣言できます。

`let` の基本的な使い方は、初期値なしで変数のリストを宣言することです。変数は `nil` で初期化されます：

```lisp
(let (variable1 variable2 variable3) ;; 変数はデフォルトで nil に初期化される。
  ;; ここで使う
  …)

;; 例：
(let (a b square)
  (setf a 2)
  (setf square (* a a))
  (list a b square))
;; => (2 NIL 4)

;; まったく同じ：
(let (a
      b
      square)
  …)
```

`(a 2)` のように「ペア」の要素を使うことでデフォルト値を与えられます：

```lisp
(let ((a 2)     ;; <-- 初期値
       square)  ;; <-- 「ペア」ではないが、1要素として NIL がデフォルト。
  (setf square (* a a))
  (list a square))
```

`((` が2つ連続しています！これがCommon Lispの構文です。数える必要はありません。`let` の後に来るのは変数の定義です。通常は1行に1つです。

letのロジックは意味のあるインデントとともにボディに書かれます。Lispのコードはインデントで読めます。あなたが見ているプロジェクトがこれを守っていなければ、それは低品質なプロジェクトです。

`square` を `nil` のままにしておいたことに注意してください。`a` の2乗にしたいのですが、こんなことはできるでしょうか？

```lisp
(let ((a 2)
      (square (* a a))) ;; 警告：
  …)
```

ここではできません。これが `let` の制限です。`let*` が必要です。

2つの `let` を書くこともできます：

```lisp
(let ((a 2))
  (let ((square (* a a)))
    (list a square)))
;; => (2 4)
```

これは `let*` と等価です：

```lisp
(let* ((a 2)
       (square (* a a)))
  …)
```

`let` は互いに依存しない変数を宣言するためのもので、`let*` は順番に読まれ、後の変数が前の変数に依存できる変数を宣言するためのものです。

これは無効です：

```lisp
(let* ((square (* a a))  ;; WARN!
       (a 2))
   (list a square))
;; => debugger:
;; The variable A is unbound.
```

エラーメッセージは明確です。`(square (* a a))` を読んでいる時点では、`a` は未知です。

### let の中の setf

さらに明確にしましょう:`let` バインディングで *シャドウされている* 値であっても `setf` できます。ますが、let の外に出ると変数は現在の *環境* の値に戻ります。ります。

これはわかっていることです：

```lisp
(defparameter *name* "test")

(let ((*name* "inside let"))
  (format t "*name* inside let: ~s" *name*))
;; => *name* inside let: "inside let"

(format t "*name* outside let: ~s" *name*)
;; => *name* outside let: "test"
```

let バインディングでシャドウされたダイナミックパラメータを setf する：

```lisp
(defparameter *name* "test")

(defun change-name ()
   ;; ただし、スタイルとしては悪い。
   ;; 関数の中で変数をミューテートしないようにして、
   ;; 引数を受け取り、新しいデータ構造を返すようにすること。
   (setf *name* "set!"))
   ;; ^^^^  ダイナミック環境から、またはletのレキシカルスコープから。

(let ((*name* "inside let"))
  (change-name)
  (format t "*name* inside let: ~s" *name*))
;; => *name* inside let: "set!"

(format t "*name* outside let: ~s" *name*)
;; => *name* outside let: "test"
```


### 定義した変数を使わないとき

コンパイラの警告を読みましょう :)

下の例では、`b` が定義されているが一度も使われていないことを教えてくれます。SBCLは *コンパイル時*（式をポイントでコンパイル・ロードする `C-c C-c`（`slime-compile-defun`）、ファイル全体の `C-c C-k`、または `load` を使うたびに）に有用な警告を出すことが得意です。

~~~lisp
(let (a b square)
  (list a square))
;; =>
; caught STYLE-WARNING:
;   The variable B is defined but never used.
~~~

SBCLのREPLは常に式をコンパイルするため、この例はREPLで動作します。

実装によっては動作が異なる場合があります。

タイポを発見するのに最適です！

```lisp
(let* ((a 2)
       (square (* a a)))
  (list a squale))
  ;;         ^^^ typo
```

これを .lisp ファイル（または `Alt-x slime-scratch` の lisp バッファ）でコンパイルすると、2つの警告が出て、エディタはそれぞれを2つの異なる色でアンダーラインを引きます：

![](assets/let-example-squale.png "まともなエディタはコンパイル時の警告をハイライトします。")

- 1つ目：「square」が定義されているが一度も使われていない
- 2つ目：「squale」は未定義変数である。

REPLでこのスニペットを実行すると、2つの警告が出た後、スニペットが実行されるので「The 変数 SQUALE is unbound」というエラーでインタラクティブデバッガが起動します。


## 未束縛変数

「unbound（未束縛）」変数は、NIL にさえ束縛されていません。シンボルは存在するかもしれませんが、関連付けられた値を持ちません。

このような変数は次のように作れます：

```lisp
(defvar *connection*)
```

この `defvar` フォームは正しいです。デフォルト値を与えていないので：変数は未束縛です。

変数（または関数）が束縛されているかどうかは `boundp`（または `fboundp`）で確認できます。末尾の `p` は「predicate（述語）」の意味です。

変数（または関数）を未束縛にするには `makunbound`（または `fmakunbound`）を使います。

なお、`defparameter` フォームには初期引数が必須です。


## グローバル変数はスレッドセーフ

スレッド内でグローバルバインディングにアクセスしたり設定したりすることを怖がる必要はありません。各スレッドは変数の独自のコピーを持ちます。結果として、`let` バインディングなどで別の値に束縛することもできます。これは良いことです。

問題になるのは、真に単一の情報源を求める場合、つまりスレッド間で変数を共有したいときだけです。ロックを使えば（非常に簡単ですが）対処できます。ただしそれはまた別の話題です。

## 付録： `defconstant`

`defconstant` は、何かが定数であり変更されるべきでないことを言うためのものですが、実際には `defconstant` は面倒です。`defparameter` を使い、新しいスタイルのイヤーマフによる規約を加えてください：

```lisp
(defparameter +pi+ pi
  "piが存在するがイヤーマフがないことを示すため。これでイヤーマフを付けた。+-スタイルのイヤーマフの変数は変更すべきでない、定数扱いだ。")
```

`defconstant` が扱いにくい理由は、少なくともSBCLでは、インタラクティブデバッガによる確認なしに再定義できないからです。開発中は頻繁に再定義しますし、デフォルトのテストが `eql` であるため、文字列を与えると定数が常に再定義されたと見なします。（以下の各行を順番に1つずつ評価してみてください）：

```lisp
(defconstant +best-lisper+ :me)
;; ここまでは問題なし。

(defconstant +best-lisper+ :me)
;; ここまでは問題なし：何も再定義していない。

(defconstant +best-lisper+ :you)
;; => 定数が再定義されようとしており、インタラクティブデバッガが起動する（SBCL）：

The constant +BEST-LISPER+ is being redefined (from :ME to :YOU)
   [Condition of type SB-EXT:DEFCONSTANT-UNEQL]
See also:
  Common Lisp Hyperspec, DEFCONSTANT [:macro]
  SBCL Manual, Idiosyncrasies [:node]

Restarts:
 0: [CONTINUE] Go ahead and change the value.
 1: [ABORT] Keep the old value.
 2: [RETRY] Retry SLIME REPL evaluation request.
 3: [*ABORT] Return to SLIME's top level.
 4: [ABORT] abort thread (#<THREAD tid=573581 "repl-thread" RUNNING {120633D123}>)

;; => 0（ゼロ）を押すか「Continue」リスタートをクリックして値の変更を受け入れる。
```

文字列を定数にした場合：

```lisp
(defconstant +best-name+ "me")
;; ここまでは問題なし、新しい定数を作成。

(defconstant +best-name+ "me")
;; => インタラクティブデバッガが起動！！

The constant +BEST-NAME+ is being redefined (from "me" to "me")
…
```

等値の章で見るように、2つの文字列は低レベルの等値演算子（ポインタを考えてみてください）である `eql` では等しくなく、`equal`（または `string-equal` ）では等しくなります。

`defconstant` のドキュメントにはこう書かれています：

> グローバル定数を定義し、その値は定数でありコードにコンパイルされる可能性があることを宣言する。変数がすでに値を持っており、それが新しい値と EQL でない場合、そのコードはポータブルでない（未定義動作）。3番目の引数は変数に対するオプションのドキュメント文字列。

`eql` の件は仕様にありますが、定数を再定義したときに実装が何をすべきかは定義されていないため、実装によって異なる場合があります。

以下を参照することをお勧めします：

- [Alexandria's define-constant](https://alexandria.common-lisp.dev/draft/alexandria.html#Data-and-Control-Flow)。`:test` キーワードを持つ（ただし再定義ではやはりエラーになります）。
- [Serapeum の `defconst`](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#defconst-symbol-init-optional-docstring)
- `cl:defparameter` ;)


## ガイドラインとベストプラクティス

スタイルに関するガイドラインをいくつか：

- トップレベルのパラメータはすべてファイルの先頭に作成する
- パラメータを先に定義し、次に変数を定義する
- ドキュメント文字列を使う
- コンパイラの警告を読む
- 関数はトップレベルのパラメータに依存するよりも、引数を受け取る方が良い
- 関数はトップレベルのバインディングをミューテート（変更）すべきでない。代わりに新しいデータ構造を作成し、関数の戻り値を別の関数のパラメータとして使い、データが関数から関数へと流れるようにすること
- パラメータは「Webサーバーのポート」や「デフォルト値」など、ユーザーが目にするパラメータに最適
- 変数はキャッシュやDBコネクションなど、長期間存続し内部的な変数に最適
- defconstant は忘れてよい
- 迷ったら `defparameter` を使う
- 関数パラメータのデフォルトをグローバル変数にするパターンは典型的でイディオマティック：

```lisp
;; STRライブラリより。
(defvar *whitespaces* (list #\Backspace #\Tab #\Linefeed #\Newline #\Vt #\Page
                            #\Return #\Space #\Rubout
                            ;; 簡略化のため省略
                            ))

(defun trim-left (s &key (char-bag *whitespaces*))
  "Removes all characters in `char-bag` (default: whitespaces) at the beginning of `s`."
  (when s
   (string-left-trim char-bag s)))
```

デフォルト値は関数呼び出しにすることもできます：

```lisp
;; Lemエディタより
(defun buffer-modified-p (&optional (buffer (current-buffer)))
  "Return T if 'buffer' has been modified, NIL otherwise."
  (/= 0 (buffer-%modified-p buffer)))
```

- グローバル変数への let バインディング `(let ((*name* "other")) …)` もイディオマティックです。

## まとめ

トップレベル変数には `defparameter` を使ってください。

レキシカルスコープには `let` または `let*` を使ってください。両者の違いは知っておくべきですが、迷ったら `let*` から始めましょう：

```lisp
(let* ((a 2)
       (square (* a a)))
   (format t "the square of ~a is ~a" a square))
```

変数の変更には `setf` を使ってください。
 
#  関数 {#chapter-functions}
 

[​]{#return}

## 名前付き関数: `defun`

名前付き関数は `defun` キーワードで作成します。基本形は次のとおりです。

~~~lisp
(defun function-name (zero or some arguments)
  "docstring"
  (code of function body))
~~~

戻り値は本体の最後の式が返す値です (詳しくは下を参照)。"return xx" のような文はありません。

たとえば:

~~~lisp
(defun hello-world ()
  ;;               ^^ 引数なし
  (print "hello world!"))
~~~

呼び出してみます。

~~~lisp
(hello-world)
;; "hello world!"  <-- 出力
;; "hello world!"  <-- 文字列が返る
~~~

`print` 関数は 1 つの引数を標準出力に出力し、*さらにそれを返します*。そのため "hello world!" がこの関数の戻り値になります。


## 引数

[​]{#required-argument}

### 基本形: 必須引数

引数は次のように追加します。

~~~lisp
(defun hello (name)
  "Say hello to `name'."
  (format t "hello ~a !~&" name))
;; HELLO
~~~

(`~a` は変数を *見やすく* 出力するために最もよく使われる `format` ディレクティブで、`~&` は改行を出力します)

関数を呼び出します。

~~~lisp
(hello "me")
;; hello me !  <-- これは `format` により出力される
;; NIL         <-- 戻り値: `format t` は文字列を
;;                 標準出力に出力し nil を返す
~~~

正しい数の引数を指定しないと、明示的なエラーメッセージとともに対話的デバッガに入ります。

   (hello)

> invalid number of arguments: 0

### 省略可能な引数: `&optional`

省略可能な引数は lambda list の `&optional` キーワードの後に宣言します。これらは順序を持ち、続けて現れなければなりません。

この関数は:

~~~lisp
(defun hello (name &optional age gender) …)
~~~

次のように呼び出す必要があります。

~~~lisp
(hello "me") ;; 必須引数への値、
             ;; 省略可能な引数は 0 個
(hello "me" "7")  ;; age への値
(hello "me" 7 :h) ;; age と gender への値
~~~

### 名前付きパラメータ: `&key`

引数の順序を覚えるのがいつも便利とは限りません。そのため、引数を名前で渡せます。`&key argname` で宣言し、関数の呼び出しでは `:argname "value"` で設定し、関数の本体では通常の変数として `argname` を使います。

キー引数のデフォルト値は `nil` です。

~~~lisp
(defun hello (name &key happy)
  "If `happy' is `t', print a smiley"
  (format t "hello ~a " name)
  (when happy
    (format t ":)~&")))
~~~

次の呼び出しが可能です。

    (hello "me")
    (hello "me" :happy t)
    (hello "me" :happy nil) ;; 不要、(hello "me") と同等

一方、これは正しくありません: `(hello "me" :happy)`:

> odd number of &KEY arguments

複数のキーパラメータを持つ関数宣言の例です。

~~~lisp
(defun hello (name &key happy lisper cookbook-contributor-p) …)
~~~

これは 0 個以上のキーパラメータを任意の順序で指定して呼び出せます。

~~~lisp
(hello "me" :lisper t)
(hello "me" :lisper t :happy t)
(hello "me" :cookbook-contributor-p t :happy t)
~~~

最後に、キーはプログラムから選択できます（変数にできます）。

~~~lisp
(let ((key :happy)
      (val t))
  (hello "me" key val))
;; hello me :)
;; NIL
~~~

[​]{#optional-parameter--key-parameter-}
[​]{#optional--key-}

#### オプショナルパラメータとキーパラメータの混在

一般にはスタイル警告になりますが、可能です。

~~~lisp
(defun hello (&optional name &key happy)
  (format t "hello ~a " name)
  (when happy
    (format t ":)~&")))
~~~

SBCL では次のようになります。

~~~
; in: DEFUN HELLO
;     (SB-INT:NAMED-LAMBDA HELLO
;         (&OPTIONAL NAME &KEY HAPPY)
;       (BLOCK HELLO (FORMAT T "hello ~a " NAME) (WHEN HAPPY (FORMAT T ":)~&"))))
;
; caught STYLE-WARNING:
;   &OPTIONAL and &KEY found in the same lambda list: (&OPTIONAL (NAME "John") &KEY
;                                                      HAPPY)
;
; compilation unit finished
;   caught 1 STYLE-WARNING condition
~~~

呼び出すことはできます。

~~~lisp
(hello "me" :happy t)
;; hello me :)
;; NIL
~~~

[​]{#key-parameter--default-value}
[​]{#key--default-}

### キーパラメータのデフォルト値

ラムダリストでは、次の `(happy t)` のような組を使ってオプショナル引数やキー引数にデフォルト値を与えます。

~~~lisp
(defun hello (name &key (happy t))
~~~

これで `happy` はデフォルトで真です。

[​]{#key-parameter-}
[​]{#key-}

### キーパラメータは指定されたか?

このヒントは必要なら今は飛ばしてかまいませんが、便利になることがあるので後で戻ってきてください。

キーパラメータのデフォルト値は `nil` だと見ました（`(defun hello (name &key happy) …)`）。しかし、「値がデフォルトで NIL である」ことと「利用者が NIL を指定した」ことはどう区別できるでしょうか。

デフォルト値を設定するには 2 要素のリストを使うことを見ました。

`&key (happy t)`

この疑問に答えるには、次のような 3 つ組を使います。

`&key (happy t happy-p)`

ここで `happy-p` はキーが渡されたかどうかを知るための *述語* 変数として働きます (`-p` を使うのは慣習にすぎないので、好きな名前を付けられます)。渡されていれば `T` になります。

これで、`:happy` が明示的に NIL に設定された場合は悲しい顔を出力します。デフォルトでは出力しません。

~~~lisp
(defun hello (name &key (happy nil happy-p))
  (format t "Key supplied? ~a~&" happy-p)
  (format t "hello ~a " name)
  (when happy-p
    (if happy
      (format t ":)")
      (format t ":("))))
~~~

### 可変個数の引数: `&rest`

関数に可変個数の引数を受け取らせたいことがあります。`&rest <variable>` を使います。この `<variable>` はリストになります。

~~~lisp
(defun mean (x &rest numbers)
    (/ (apply #'+ x numbers)
       (1+ (length numbers))))
~~~

~~~lisp
(mean 1)
(mean 1 2)  ;; => 3/2 (そう、ratio として print される)
(mean 1 2 3 4 5) ;;  => 3
~~~

[​]{#key-argument--allow-other-keys}

### key 引数を定義し、さらに他も許す: `&allow-other-keys`

見てみましょう。

~~~lisp
(defun hello (name &key happy)
  (format t "hello ~a~&" name))

(hello "me" :lisper t)
;; => Error: unknown keyword argument
~~~

一方で:

~~~lisp
(defun hello (name &key happy &allow-other-keys)
  (format t "hello ~a~&" name))

(hello "me" :lisper t)
;; hello me
~~~

引数を受け渡ししたり、関数をより高い水準で操作したりするとき、`&allow-other-keys` が必要になることがあります。

実例です。常に `:if-exists :supersede` を使ってファイルを開く関数を定義しますが、他のキーはそのまま `open` 関数に渡します。

~~~lisp
(defun open-supersede (f &rest other-keys &key &allow-other-keys)
  (apply #'open f :if-exists :supersede other-keys))
~~~

`:if-exists` 引数が重複した場合、最初に渡したものが優先されます。


## 戻り値

関数の戻り値は、本体で最後に実行されたフォームが返す値です。

大域脱出の方法 (`return-from <function name> <value>`) もありますが、通常は必要ありません。

Common Lisp には多値という概念もあります。

### 多値

多値を返すことは、結果のリストを返すこととは**違います**。

#### 簡単な例

1 つの値を返す関数を定義します。

~~~lisp
(defun foo ()
  :a)
~~~

次に、この関数呼び出しの結果を変数に設定します。

~~~lisp
(defparameter *var* (foo))
~~~

`*var*` は今 `:a` です。これはごく普通の振る舞いです。

今度は `values` を使って、この関数が *多値* を返すようにします。

~~~lisp
(foo ()
  (values :a :b :c))
~~~

そして再びその結果を `*var*` に設定します。

~~~lisp
(setf *var* (foo))
~~~

`*var*` の値は何でしょうか。*:a のままです*。残りの値を受け取るようには要求していないので、`:b` と `:c` は捨てられました。

これは実際とても便利です。関数が以前より多くの値を返すように変更しても、呼び出し箇所を変更したりリファクタリングしたりする必要がありません。

[​]{#multiple-value--values}

#### 多値を返す: `values`

関数 `values` は多値を返すために使います。

~~~lisp
(values 'a 'b)
;; => A
;; => B
~~~

引数なしで `values` を呼び出すと、値をまったく返しません。

これは `nil` を返すこととは違います。

下で説明する関数を使って多値を受け取らない限り、他の関数から見えて使われるのは最初の値だけです。

~~~lisp
(+ (values 1 2 3) (values 10 20 30))
;; => 11
~~~

`values` はリストを作りません。

[​]{#multiple-value-cl-built-in-}

#### 多値がある理由。CL の組み込み関数を見る

ほとんどの Common Lisp のフォームは 1 つの値を返しますが、関数が複数の値 (または 0 個) を返せると便利なことがあります。

たとえば `round` は、丸めた結果と、丸めのために取り除かれた量という 2 つの値を返します。

~~~lisp
(round 10.33333333)
;; => 10
;; => 0.33333302
~~~

ほとんどの場合は丸めた値だけが必要ですが、何らかの理由で剰余を知りたいなら受け取れます。関数が計算したすべての値がほとんどの場合に使われると予想するなら、結果をリスト、CLOS のインスタンス、*など* にまとめて返す方がよいでしょう。多値は、最初の値が最も頻繁に必要で、後の値はあまり使われない場合にだけ使います。

同様に、hash-table の内容を取得すると 2 つの値が返ります。結果と、そのキーが見つかったかどうかを示す真偽値です。下を参照してください。

[​]{#multiple-value--capture-multiple-value-bindnth-valuemultiple-value-list-}

#### 多値の受け取り: `multiple-value-bind`、`nth-value`、`multiple-value-list` など

多値を受け取る最も一般的な方法は `multiple-value-bind` です。

~~~lisp
(multiple-value-bind (c d) (values 1 2)
  (list c d))
;; => (1 2)

;; 次のように indent されることも多い:
(multiple-value-bind (c d)
    (values 1 2)
  (list c d))
~~~

これは `let` による束縛のように動作します。値 `c` と `d` は `multiple-value-bind` のスコープ内に存在します。

返される値の数と、束縛する変数の数は一致していなくてもかまいません。値が多すぎる場合、余分なものは捨てられます。束縛する変数が多すぎる場合、余分な変数は `nil` に設定されます。

~~~lisp
(multiple-value-bind (a b) (values 1 2 3 4)
  (list a b))
;; =>(1 2)
~~~

~~~lisp
(multiple-value-bind (a b) (values 1)
  (list a b))
;; => (1 NIL)
~~~

関数 `values` は `setf` 可能で、これを値の受け取りに使うこともできます。

~~~lisp
(let (c d)
  (setf (values c d) (values 1 2))
  (list c d))
;; => (1 2)
~~~

同等の `multiple-value-setq` も使えます。

~~~lisp
(let (c d)
  (multiple-value-setq (c d) (values 3 4))
  (list c d))
;; => (3 4)
~~~

また、`multiple-value-call` で多値を直接関数呼び出しに送り込めます。

~~~lisp
(multiple-value-call #'list (values 1 2 3))
;; => (1 2 3)
~~~

関数 `multiple-value-list` は上のコードと同等です。

~~~lisp
(multiple-value-list (values 1 2 3))
;; => (1 2 3)
~~~~

逆に、`values-list` でリストを多値に変換できます。

~~~lisp
(values-list '(1 2 3))
;; => 1
;; => 2
;; => 3
~~~

`nth-value` で特定の値を選択できます。

~~~lisp
(nth-value 0 (values :a :b :c))  ;; => :A
(nth-value 2 (values :a :b :c))  ;; => :C
(nth-value 9 (values :a :b :c))  ;; => NIL
~~~

ここでも、`values` はリストとは違うことを改めて強調しておきます。

~~~lisp
(nth-value 0 (list :a :b :c)) ;; => (:A :B :C)
;; => リストはそれ自体で 1 つのデータ構造

(nth-value 1 (list :a :b :c)) ;; => NIL
;; => 受け取れる 2 番目の値はない
~~~

[​]{#multiple-value-}

#### 成功または失敗を報告するために多値を使う

多値の典型的な用途は、`nil` が見つかった場合と検索の失敗を区別することです。たとえば `gethash` は 2 つの値を返します。1 つ目は検索の結果です。何も見つからなければ `nil` かもしれませんが、hashtable に実際に保存されている `nil` かもしれません。2 つ目の戻り値は検索が成功したかどうかを示すフラグです。

~~~lisp
(defvar *hash* (make-hash-table))
(setf (gethash 'a *hash*) 12)
(setf (gethash 'b *hash*) nil)
~~~

~~~lisp
(gethash 'a *hash*)
;; => 12           <--- 1 番目の戻り値: 結果
;; => T            <--- 2 番目の戻り値: key が見つかった

(gethash 'b *hash*)
;; => NIL
;; => T

(gethash 'c *hash*)
;; => NIL
;; => NIL          <---- この key は見つからなかった
~~~

## 無名関数: `lambda`

無名関数は `lambda` で作成します。

~~~lisp
(lambda (x) (print x))
~~~

lambda は `funcall` または `apply` で呼び出せます (下を参照)。

クォートされていないリストの最初の要素が lambda 式なら、その lambda が呼び出されます。

~~~lisp
((lambda (x) (print x)) "hello")
;; hello
~~~

[​]{#function--programmatically--funcall--apply}

## 関数をプログラムから呼び出す: `funcall` と `apply`

`funcall` は引数の数がわかっているときに使います。一方 `apply` は、たとえば `&rest` から得たリストに対して使えます。

~~~lisp
(funcall #'+ 1 2)
(apply #'+ '(1 2))
~~~

`apply` について覚えておくべきことが 1 つあります。非常に大きなリストには使えません。関数の引数リストには長さの制限があります。

この制限は変数 `call-arguments-limit` で確認できます。これは処理系に依存します。SBCL ではかなり大きい (4611686018427387903) ですが、任意の長さの引数に関数を適用する別の選択肢があります。それが `reduce` です。

### `reduce`

`reduce` は任意の長さのリストやベクトルに関数を適用するために使います。関数を 2 つの引数で繰り返し呼び出し、引数リストを走査します。

たとえば、上のように `apply` を使う代わりに:

    (apply #'min '(22 1 2 3)) ;; 非常に大きなリストを想像してください

`reduce` を使えます。

    (reduce #'min '(22 1 2 3))

引数が 1000 要素の長さなら、`apply` は `min` 関数を 1000 個の引数で呼び出します。一方 `reduce` は `min` を毎回 2 個の引数で (ほぼ) 1000 回呼び出します。

`reduce` はリストを走査します。つまり次のようになります。

- まず `min` が引数 22 と 1 で呼ばれ、中間結果 1 を生成します。
- `min` はこの中間結果を最初の引数とし、引数リストの次の引数である 2 とともに再び呼ばれます。中間結果はまた 1 です。
- `min` は引数 1 と 3 で再び呼ばれ、最終結果 1 を返します。

トレースできます。

~~~lisp
CL-USER> (trace min)
CL-USER> (reduce #'min '(22 1 2 3))
  0: (MIN 22 1)
  0: MIN returned 1
  0: (MIN 1 2)
  0: MIN returned 1
  0: (MIN 1 3)
  0: MIN returned 1
1
~~~

完全なシグネチャは次のとおりです。

```lisp
(reduce function sequence &key key from-end start end initial-value)
```

ここで `key`、`from-end`、`start`、`end` は他の組み込み関数にも見られるキー引数です（データ構造の章を参照）。`:initial-value` が与えられた場合、最初のサブシーケンスの前に置かれます。

`reduce` の詳細は Community Spec を読んでください。

- [https://cl-community-spec.github.io/pages/reduce.html](https://cl-community-spec.github.io/pages/reduce.html)


[​]{#function--single-quote---sharpsign-quote--}

### 名前で関数を参照する: シングルクォート `'` か シャープクォート `#'` か?

上の例では `#'` を使いましたが、シングルクォートも動作し、実際のコードでも見かけます。どちらを使うべきでしょうか。

一般には `#'` を使う方が安全です。レキシカルスコープを尊重するからです。見てみましょう。

~~~lisp
(defun foo (x)
  (* x 100))

(flet ((foo (x) (1+ x)))
  (funcall #'foo 1))
;; => 2、期待どおり

;; しかし:

(flet ((foo (x) (1+ x)))
  (funcall 'foo 1))
;; => 100
~~~

`#'` は実際には `(function …)` の省略形です。

~~~lisp
(function +)
;; #<FUNCTION +>

(flet ((foo (x) (1+ x)))
  (print (function foo))
  (funcall (function foo) 1))
;; #<FUNCTION (FLET FOO) {1001C0ACFB}>
;; 2
~~~

`function` または `#'` の省略形を使うとローカル関数を参照できます。代わりにシンボルを `funcall` に渡すと、呼び出されるのは常に *グローバル環境* でそのシンボルによって名付けられた関数です。

さらに、`#'` は関数を値として保持します。関数が再定義されても、`#'` でこの関数を参照している束縛は元の動作を実行し続けます。

関数をパラメータに代入してみます。

~~~lisp
(defparameter *foo-caller* #'foo)
(funcall *foo-caller* 1)
;; => 100
~~~

ここで `foo` を再定義しても、`*foo-caller*` の振る舞いは変わりません。

~~~lisp
(defun foo (x) (1+ x))
;; WARNING: redefining CL-USER::FOO in DEFUN
;; FOO

(funcall *foo-caller* 1)
;; 100  ;; 2 ではない
~~~

呼び出し元をシングルクォートの `'foo` で束縛すると、関数は実行時に解決されます。

~~~lisp
(defun foo (x) (* x 100))  ;; 元の動作に戻す
(defparameter *foo-caller-2* 'foo)
;; *FOO-CALLER-2*
(funcall *foo-caller-2* 1)
;; 100

;; 定義を変更する:
(defun foo (x) (1+ x))
;; WARNING: redefining CL-USER::FOO in DEFUN
;; FOO

;; もう一度試す:
(funcall *foo-caller-2* 1)
;; 2
~~~

どの振る舞いが望ましいかは用途によります。一般にはシャープクォートを使う方が驚きが少ないです。しかし密なループを実行していてライブ更新の仕組み (ゲームやライブな可視化を考えてください) が欲しい場合は、ループが利用者の新しい関数定義を拾うようにシングルクォートを使いたいかもしれません。


[​]{#higher-order-function-function--function}

## 高階関数: 関数を返す関数

関数を返す関数を書くのは十分に簡単です。

~~~lisp
(defun adder (n)
  (lambda (x) (+ x n)))
;; ADDER
~~~

ここでは、[`function`](http://www.lispworks.com/documentation/HyperSpec/Body/t_fn.htm) _型_ の _オブジェクト_ を返す関数 `adder` を定義しました。

結果として得られる関数を呼び出すには、`funcall` または `apply` を使う必要があります。

~~~lisp
(adder 5)
;; #<CLOSURE (LAMBDA (X) :IN ADDER) {100994ACDB}>
(funcall (adder 5) 3)
;; 8
~~~

すぐに呼び出そうとすると不正な関数呼び出しになります。

~~~lisp
((adder 3) 5)
In: (ADDER 3) 5
    ((ADDER 3) 5)
Error: Illegal function call.
~~~

実際、CL では関数と変数に異なる _名前空間_ があります。つまり、評価されるフォームの中での位置によって、同じ _名前_ が別のものを指すことがあります。

~~~lisp
;; シンボル foo は何にも束縛されていない:
CL-USER> (boundp 'foo)
NIL
CL-USER> (fboundp 'foo)
NIL
;; 変数を作る:
CL-USER> (defparameter foo 42)
FOO
CL-USER> foo
42
;; これで foo は値に束縛されている:
CL-USER> (boundp 'foo)
T
;; しかし関数としてはまだ違う:
CL-USER> (fboundp 'foo)
NIL
;; では関数を定義する:
CL-USER> (defun foo (x) (* x x))
FOO
;; これでシンボル foo は関数としても束縛された:
CL-USER> (fboundp 'foo)
T
;; 関数を取得する:
CL-USER> (function foo)
#<FUNCTION FOO>
;; 短縮表記:
CL-USER> #'foo
#<FUNCTION FOO>
;; 呼び出す:
(funcall (function adder) 5)
#<CLOSURE (LAMBDA (X) :IN ADDER) {100991761B}>
;; そして lambda を呼び出す:
(funcall (funcall (function adder) 5) 3)
8
~~~

少し単純化すると、Common Lisp の各シンボルには情報を保存する「セル」が（少なくとも）2 つあると考えられます。1 つは「値セル」と呼ばれ、シンボルに束縛された値を保持できます。[`boundp`](http://www.lispworks.com/documentation/HyperSpec/Body/f_boundp.htm) を使うと、シンボルが大域環境で値に束縛されているかを検査できます。シンボルの値セルには [`symbol-value`](http://www.lispworks.com/documentation/HyperSpec/Body/f_symb_5.htm) でアクセスできます。


もう 1 つは「関数セル」と呼ばれ、シンボルに大域的に束縛された関数の定義を保持できます。この場合、シンボルはその定義に _fbound_ されていると言います。[`fboundp`](http://www.lispworks.com/documentation/HyperSpec/Body/f_fbound.htm) を使うと、シンボルが関数に束縛されているかを検査できます。シンボルの関数セルには、大域環境では [`symbol-function`](http://www.lispworks.com/documentation/HyperSpec/Body/f_symb_1.htm) でアクセスできます。


さて、_シンボル_ が評価されると、_変数_ として扱われ、その値セルが返されます (単に `foo`)。_複合フォーム_、つまり _cons_ が評価され、その _car_ がシンボルなら、このシンボルの関数セルが使われます (`(foo 3)` のように)。


Common Lisp では Scheme と異なり、評価される複合フォームの car を任意のフォームにすることはできません。シンボルでない場合、それは `(lambda lambda-list form*)` の形をした _lambda 式_ でなければなりません。

これが上で得たエラーメッセージの理由です。`(adder 3)` はシンボルでも lambda 式でもありません。

複合フォームの car でシンボル `*my-fun*` を使えるようにしたいなら、その _関数セル_ に明示的に何かを保存する必要があります (通常これはマクロ [`defun`](http://www.lispworks.com/documentation/HyperSpec/Body/m_defun.htm) が行ってくれます)。

~~~lisp
;;; 上からの続き
CL-USER> (fboundp '*my-fun*)
NIL
CL-USER> (setf (symbol-function '*my-fun*) (adder 3))
#<CLOSURE (LAMBDA (X) :IN ADDER) {10099A5EFB}>
CL-USER> (fboundp '*my-fun*)
T
CL-USER> (*my-fun* 5)
8
~~~

詳しくは [form evaluation](http://www.lispworks.com/documentation/HyperSpec/Body/03_aba.htm) についての CLHS の節を読んでください。

## クロージャ

クロージャを使うとレキシカルな束縛を保持できます。これは、毎回関数に渡したくない状態を保存するときに便利です。利便性のためだけでなく、状態変数を外部からアクセス可能な名前空間に置かずに済みます。

~~~lisp
(let ((limit 3)
      (counter -1))
    (defun my-counter ()
      (if (< counter limit)
          (incf counter)
          (setf counter 0))))

(my-counter)
0
(my-counter)
1
(my-counter)
2
(my-counter)
3
(my-counter)
0
~~~

または同様に:

~~~lisp
(defun repeater (n)
  (let ((counter -1))
     (lambda ()
       (if (< counter n)
         (incf counter)
         (setf counter 0)))))

(defparameter *my-repeater* (repeater 3))
;; *MY-REPEATER*
(funcall *my-repeater*)
0
(funcall *my-repeater*)
1
(funcall *my-repeater*)
2
(funcall *my-repeater*)
3
(funcall *my-repeater*)
0
~~~

カウンタの生成に加えて、レキシカルクロージャのもう 1 つの一般的な用途はメモ化、つまり計算にコストがかかる関数の以前の結果をキャッシュすることです。下のメモ化されていない Fibonacci 関数は、すぐに計算時間がかなりかかるようになります。

~~~lisp
(defun fibonacci (n)
  (if (<= n 1)
      n
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(time (fibonacci 40))
;; Evaluation took:
;;   2.843 seconds of real time
;;   2.841360 seconds of total run time (2.796188 user, 0.045172 system)
;;   99.93% CPU
;;   0 bytes consed
;; 102334155
~~~

以前に計算した結果を hash table に保存すると高速化できます。`defvar` を使うこともできますが、これはクロージャに適した用途です。1 つの関数だけが使う変数を名前空間に追加せずに済むからです。

~~~lisp
(let ((memo (make-hash-table)))
  (defun fibonacci (n)
    (let ((value (gethash n memo)))
      (cond ((<= n 1) n)
            (value value)
            (t (setf (gethash n memo)
                     (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))))))

(time (fibonacci 40))
;; Evaluation took:
;;   0.000 seconds of real time
;;   0.000016 seconds of total run time (0.000015 user, 0.000001 system)
;;   100.00% CPU
;;   0 bytes consed
;; 102334155
~~~

メモ化ライブラリはいくつかあり、その一部はこのレキシカルクロージャとキャッシュの仕組みをマクロで包んでいます。

詳しくは [Practical Common Lisp](http://www.gigamonkeys.com/book/variables.html) を参照してください。

## `setf` function

関数 name は、最初のシンボルが `setf` である 2 つのシンボルの list にすることもできます。このとき最初の引数は新しい値です。

~~~lisp
(defun (setf function-name) (new-value other optional arguments)
  body)
~~~

この仕組みは CLOS メソッドでよく使われます。

例に向けて進めましょう。square を表す hash-table を操作するとします。この hash-table に square の width を保存します。

~~~lisp
(defparameter *square* (make-hash-table))
(setf (gethash :width *square*) 21)
~~~

プログラムの life cycle 中、上で行ったように `setf` で square の width を変更できます。

square area を計算する関数を定義します。dimension と重複するため、これは hash-table には保存しません。

~~~lisp
(defun area (square)
  (expt (gethash :width square) 2))
~~~

ここで programming 上の必要から、square の `*area*` を変更し、それを square の dimension に反映できると非常に便利な状況になったとします。プログラムのアプリケーションインターフェイスにとって、次のような setf-function を定義すると扱いやすくなります。

~~~lisp
(defun (setf area) (new-area square)
  (let ((width (sqrt new-area)))
    (setf (gethash :width square) width)))
~~~

これで次のようにできます。

~~~lisp
(setf (area *square*) 100)
;; => 10.0
~~~

square を確認すると (`describe`、`inspect` など)、新しい width が設定されています。

### setf-function: optional argument

setf-function が持つ mandatory 引数は、新しい値 1 つだけである点に注意してください。2 番目以降の引数は optional です。たとえば [Lem editor codebase](https://github.com/lem-project/lem/blob/main/src/buffer/internal/buffer.lisp) から:


~~~lisp
(defun (setf current-buffer) (buffer)
  "Change the current buffer."
  (check-type buffer buffer)
  (setf *current-buffer* buffer))
~~~

この setf-function は global パラメータ (`*current-buffer*`) を新しい値に設定します。

2 つより多い引数を持つ setf-function も定義できます。

~~~lisp
(defun (setf area) (new-area square x y &key log)
  (list new-area square x y log))
~~~

使ってみます。

~~~lisp
(setf (area 'square 1 2 :log t) 9)
~~~


[​]{#currying-functions}

## Currying

### 概念

関連する概念に _[カリー化（currying）](https://en.wikipedia.org/wiki/Currying)_ があります。関数型言語から来たなら馴染みがあるかもしれません。前の節を読んだ後なら、これはかなり簡単に実装できます。

~~~lisp
CL-USER> (defun curry (function &rest args)
           (lambda (&rest more-args)
	           (apply function (append args more-args))))
CURRY
CL-USER> (funcall (curry #'+ 3) 5)
8
CL-USER> (funcall (curry #'+ 3) 6)
9
CL-USER> (setf (symbol-function 'power-of-ten) (curry #'expt 10))
#<Interpreted Function "LAMBDA (FUNCTION &REST ARGS)" {482DB969}>
CL-USER> (power-of-ten 3)
1000
~~~

[​]{#alexandria-library-}

### Alexandria ライブラリを使う

やり方がわかったので、Quicklisp にある [Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Data-and-Control-Flow) ライブラリの実装を使うありがたみもわかるでしょう。

~~~lisp
(ql:quickload "alexandria")

(defun adder (foo bar)
  "Add the two arguments."
  (+ foo bar))

(defvar add-one (alexandria:curry #'adder 1) "Add 1 to the argument.")

(funcall add-one 10)  ;; => 11

(setf (symbol-function 'add-one) add-one)
(add-one 10)  ;; => 11
~~~

## ドキュメント

- function: <http://www.lispworks.com/documentation/HyperSpec/Body/t_fn.htm#function>
- ordinary lambda list: <http://www.lispworks.com/documentation/HyperSpec/Body/03_da.htm>
- multiple-value-bind: <http://clhs.lisp.se/Body/m_multip.htm>
 
#  データ構造 {#chapter-data-structures}
 

ここでは、よく使われるデータ構造について明快なリファレンスを示すことを目指します。
言語を本当に学ぶには、時間を取って他の資料も読むべきです。私たちが参考にした
以下の資料には、さらに多くの詳細があります。

- Peter Seibel による [Practical CL](http://gigamonkeys.com/book/they-called-it-lisp-for-a-reason-list-processing.html)
- E. Weitz による [CL Recipes](http://weitz.de/cl-recipes/)。説明とヒントが豊富です。
- [CL 標準仕様](https://franz.com/support/documentation/cl-ansi-standard-draft-w-sidebar.pdf)
  には、PDF リーダーのサイドバーに見やすい目次があり、関数リファレンス、詳細な説明、
  さらに多くの例と注意事項、つまりほとんどすべてが含まれています。
  [PDF のミラー](https://gitlab.com/vancan1ty/clstandard_build/-/blob/master/cl-ansi-standard-draft-w-sidebar.pdf)
- [Common Lisp quick reference](http://clqr.boundp.org/)

付録も見逃さないでください。さらに多くのデータ構造が必要な場合は、
[awesome-cl](https://github.com/CodyReichert/awesome-cl#data-structures)
のリストと [Quickdocs](https://quickdocs.org/-/search?q=data%20structure) を見てください。

## リスト

リストを作成する最も単純な方法は `list` を使うことです。

~~~lisp
(list 1 2 3)
~~~

ただし、他にもコンストラクタがあります。また、リストは `cons` セルからできていることも
知っておくべきです。


### リストの構築。Cons セル、リスト。

_リストはシーケンスでもあるため、後述の関数を使えます。_

リストの基本要素は cons セルです。cons セルを組み合わせてリストを構築します。

~~~lisp
(cons 1 2)
;; => (1 . 2) ;; ドットを使った表現、ドット対。
~~~

これは次のようになります。

```
[o|o]--- 2
 |
 1
```

最初のセルの `cdr` が別の cons セルで、その最後の `cdr` が `nil` なら、
リストを構築したことになります。

~~~lisp
(cons 1 (cons 2 nil))
;; => (1 2)
~~~

これは次のようになります。

```
[o|o]---[o|/]
 |       |
 1       2
```
（ASCII アートは [draw-cons-tree](https://github.com/cbaggers/draw-cons-tree) によるものです）。

表現がドット対ではないことに注目してください。Lisp のプリンタはこの慣習を理解します。

最後に、`list` で単純にリテラルリストを構築できます。

~~~lisp
(list 1 2)
;; => (1 2)
~~~

または quote を呼び出します。

~~~lisp
'(1 2)
;; => (1 2)
~~~

これは関数呼び出し `(quote (1 2))` の短縮表記です。

### 循環リスト

cons セルの car や cdr は、同じリスト内の自分自身や他のセルを含む、
他のオブジェクトを参照できます。そのため、循環リストのような自己参照構造を
定義するために使えます。

循環リストを扱う前に、プリンタがそれを認識し、リスト全体を印字しようとしないように、
[\*print-circle\*](http://clhs.lisp.se/Body/v_pr_cir.htm)
を `T` に設定します。

~~~lisp
(setf *print-circle* t)
~~~

最後の `cdr` がリストの先頭を指すようにリストを変更する関数は次のようになります。

~~~lisp
(defun circular! (items)
  "リスト ITEMS の最後の cdr を変更し、循環リストを返す"
  (setf (cdr (last items)) items))

(circular! (list 1 2 3))
;; => #1=(1 2 3 . #1#)

(fifth (circular! (list 1 2 3)))
;; => 2
~~~

[list-length](http://www.lispworks.com/documentation/HyperSpec/Body/f_list_l.htm#list-length)
関数は循環リストを認識し、`nil` を返します。

リーダも
[Sharpsign Equal-Sign](http://www.lispworks.com/documentation/HyperSpec/Body/02_dho.htm)
記法を使って循環リストを作成できます。リストのようなオブジェクトには `#n=` という
接頭辞を付けられます。ここで `n` は符号なし 10 進整数（1 桁以上）です。
ラベル `#n#` は、式の後の部分でそのオブジェクトを参照するために使えます。

~~~lisp
'#42=(1 2 3 . #42#)
;; => #1=(1 2 3 . #1#)
~~~

リーダに与えたラベル（`n=42`）は読み込み後に破棄され、プリンタが新しいラベル
（`n=1`）を定義することに注意してください。

参考資料

* [Let over Lambda](https://letoverlambda.com/index.cl/guest/chap4.html#sec_5) の循環式に関する節


### car/cdr または first/rest（second... tenth まで）

~~~lisp
(car (cons 1 2)) ;; => 1
(cdr (cons 1 2)) ;; => 2
(first (cons 1 2)) ;; => 1
(first '(1 2 3)) ;; => 1
(rest '(1 2 3)) ;; => (2 3)
~~~

`setf` を使うと、*任意の* 新しい値を代入できます。

### last, butlast, nbutlast (&optional n)

リスト内の最後の cons セル（または末尾から n 番目の cons セル）を返します。

~~~lisp
(last '(1 2 3))
;; => (3)
(car (last '(1 2 3)) ) ;; または (first (last …))
;; => 3
(butlast '(1 2 3))
;; => (1 2)
~~~

[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Conses) では、
`lastcar` は `(first (last …))` と等価です。

~~~lisp
(alexandria:lastcar '(1 2 3))
;; => 3
~~~


### reverse, nreverse

`reverse` と `nreverse` は新しいシーケンスを返します。

`nreverse` は破壊的です。N は **non-consing** を意味し、新しい cons セルを
割り当てる必要がないという意味です。元のシーケンスを再利用して変更する
*可能性があります*（実際にはそうします）。

~~~lisp
(defparameter mylist '(1 2 3))
;; => (1 2 3)
(reverse mylist)
;; => (3 2 1)
mylist
;; => (1 2 3)
(nreverse mylist)
;; => (3 2 1)
mylist
;; => (1) SBCL ではこうなるが、実装依存。
~~~


### append, nconc（および revappend, nreconc）

`append` は任意個数のリスト引数を取り、すべての引数の要素を含む新しいリストを返します。

~~~lisp
(append (list 1 2) (list 3 4))
;; => (1 2 3 4)
~~~

新しいリストは `(3 4)` と一部の cons セルを共有します。

![](assets/gigamonkeys-after-append.png)

`nconc` は再利用版に相当します。

`revappend` と `nreconc` は、あまり頻繁には使わないかもしれない 2 つの関数です :)

`revappend` は `(append (reverse x) y)` を行います。

~~~lisp
(revappend (list 1 2 3) (list :a :b :c))
;; => (3 2 1 :A :B :C)
~~~

`nreconc` は `(nconc (nreverse x) Y)` を行います。

~~~lisp
(nreconc (list 1 2 3) (list :a :b :c))
;; => (3 2 1 :A :B :C)
~~~

後でありがたみが分かるでしょう。


### push, pushnew (item, place)

`push` は *place* に格納されているリストの先頭に *item* を追加し、結果のリストを
*place* に格納して、そのリストを返します。

`pushnew` も似ていますが、その要素がすでに place に存在する場合は何もしません。

対象のリストを変更しない `adjoin` についても後述します。

~~~lisp
(defparameter mylist '(1 2 3))
(push 0 mylist)
;; => (0 1 2 3)
~~~

~~~lisp
(defparameter x ’(a (b c) d))
;; => (A (B C) D)
(push 5 (cadr x))
;; => (5 B C)
x
;; => (A (5 B C) D)
~~~

`push` は `(setf place (cons item place ))` と等価ですが、*place* の部分式が
一度だけ評価され、*item* が *place* より先に評価される点が異なります。

**リストの末尾に追加する** 組み込み関数はありません。これはよりコストの高い操作です
（リスト全体を走査する必要があります）。これが必要なら、別のデータ構造の利用を検討するか、
必要なときに単にリストを `reverse` してください。

`pushnew` はキーワード引数 `:key`、`:test`、`:test-not` を受け取ります。


### pop

破壊的な操作です。

### nthcdr (index, list)

`first`、`second`、そして `tenth` まででは足りない場合に使います。

### car/cdr と合成形（cadr、caadr…） - リスト内のリストへのアクセス

他のリストを含むリストに適用すると意味があります。

~~~lisp
(caar (list 1 2 3))                  ==> error
(caar (list (list 1 2) 3))           ==> 1
(cadr (list (list 1 2) (list 3 4)))  ==> (3 4)
(caadr (list (list 1 2) (list 3 4))) ==> 3
~~~

### destructuring-bind (parameter*, list): パターンマッチング

このマクロはリストに対して単純なパターンマッチングを行います。

パラメータ宣言に基づいて、入力リストから取り出した値を各パラメータに束縛します。

固定個数または可変個数の要素を持つリストやネストしたリストを分配束縛できます。
存在しない要素にデフォルト値を与えたり、`defun` や `defmacro` でおなじみの
ラムダリストキーワード `&key`、`&rest`、`&allow-other-keys` などを使って
プロパティリストのキーにマッチさせたりできます。

例:

~~~lisp
(destructuring-bind (x y z)
    (list 1 2 3)
  (format t "x= ~s, y= ~s, z= ~s" x y z))
;; x= 1, y= 2, z= 3
~~~

この例では正確に `(x y z)` にマッチさせたいので、対象のリストは x、y、z を
提供しなければなりません。

以下では `z` の存在を省略可能にします。これで 2 要素のリストにも 3 要素のリストにも
マッチできます。

~~~lisp
(destructuring-bind (x y &optional z)
    (list 1 2)
  (format t "x= ~s, y= ~s, z=~s" x y z))
;; x= 1, y= 2, z=NIL
~~~

しかし、可変個数の引数を持つリストにマッチさせたい場合、これは動作しません。

~~~lisp
;; 動作しない:
(destructuring-bind (x y &optional z)
    (list 1 2 3 4 5)
  (format t "x= ~s, y= ~s, z=~s" x y z))
~~~

次のエラーになります。

```
Error while parsing arguments to DESTRUCTURING-BIND:
  too many elements in
    (1 2 3 4 5)
  to satisfy lambda list
    (X Y &OPTIONAL Z):
  between 1 and 3 expected, but got 5
```

`&rest` を使うと、可変個数の要素を `z` に束縛できます。これで `z` はリストに束縛されます。

~~~lisp
(destructuring-bind (x y &rest z)
    (list 1 2 3 4 5)
  (format t "x= ~s, y= ~s, z=~s" x y z))
;; x= 1, y= 2, z=(3 4 5)
~~~

`&whole` パラメータはリスト全体に束縛されます。これは最初に置く必要があり、
その後に他のパラメータを続けられます。

~~~lisp
(destructuring-bind (&whole whole-list x y &optional z)
    (list 1 2 3)
  (format t "x= ~s, y= ~s, z=~s, whole list: ~s" x y z whole-list))
;; x= 1, y= 2, z=3, whole list: (1 2 3)
~~~


サブリストの内部にもマッチできます。

~~~lisp
(destructuring-bind (x (y1 y2) z)
    (list 1 (list 2 20) 3)
  (list :x x :y1 y1 :y2 y2 :z z))
;; => (:X 1 :Y1 2 :Y2 20 :Z 3)
~~~


もう 1 つ便利な機能は、キーワードと値が交互に並ぶリストである plist の分配束縛です。
どのキーにマッチさせるかを指定でき、入力内での順序は任意です。

~~~lisp
(destructuring-bind (&key a b c)
    (list :c 3 :b 2 :a 1)
  (format t "a= ~s, b= ~s, c=~s" a b c))
;; a= 1, b= 2, c=3
~~~

キーが存在しなくても問題ありません。optional として指定する必要はありません。

~~~lisp
(destructuring-bind (&key a b c)
    (list :b 2 :a 1)
  (format t "a= ~s, b= ~s, c=~s" a b c))
a= 1, b= 2, c=NIL
~~~

ただし、宣言していないキーを含む入力は扱えません。その場合は `&allow-other-keys` を使います。

~~~lisp
;; 動作しない
(destructuring-bind (&key a b c)
    (list :b 2 :a 1 :foo t)
    ;;              ^^^ 不明
  (format t "a= ~s, b= ~s, c=~s" a b c))
~~~

ここでも明確なエラーが出ます。

```
Error while parsing arguments to DESTRUCTURING-BIND:
  unknown keyword: :FOO; expected one of :A, :B, :C
```

今度は `&allow-other-keys` を使います。

~~~lisp
(destructuring-bind (&key a b c &allow-other-keys)
    (list :b 2 :a 1 :foo t)
  (format t "a= ~s, b= ~s, c=~s" a b c))
;; a= 1, b= 2, c=NIL
~~~


これだけではありません。`defun` のラムダリストと同じように、cons セル
`(key default)` を使ってデフォルト値を与えられます。


~~~lisp
(destructuring-bind (&key a b (c 42))
    (list :b 2 :a 1)
  (format t "a= ~s, b= ~s, c=~s" a b c))
;; a= 1, b= 2, c=42
~~~

分配束縛ラムダリストには、`&environment` を除き、マクロラムダリストと同じ
キーワードをすべて含められます。これには `&aux` と `&body` も含まれます。

`destructuring-bind` の構造は、ラムダリスト、入力リスト、省略可能な `declare` による宣言、
そして本体内の 1 つ以上のフォームです。

入力リストは評価される式でもかまいません。

~~~lisp
(destructuring-bind ((a &optional (b 'beta)) one two three)
     `((alpha) ,@(list 1 2 3))
  (list a b one two three))
;; => (ALPHA BETA 1 2 3)
~~~

これでパターンマッチングをしたくなったら、
[パターンマッチング](#chapter-pattern_matching)
を参照してください。


### 述語: null, listp, consp, atom

`null` は `not` と等価ですが、より良いスタイルと考えられています。

`listp` はオブジェクトがリストまたは nil かどうかを調べます。

`consp` はオブジェクトが cons セルかどうかを調べます。

空リストは cons ではないため、`(consp nil)` は偽ですが、`(listp nil)` は真です。

`atom` は引数がアトムかどうか、言い換えると `cons` ではないかどうかを調べます。
`atom` は型でもあります。

~~~lisp
(atom '()) ;; => true
~~~

シーケンスの述語もあわせて参照してください。


### list*, make-list

`make-list` を使うと、指定したサイズのリストを作成し、省略可能な初期要素で埋められます。

~~~lisp
(make-list 3 :initial-element "ta")
;; => ("ta" "ta" "ta")
~~~

~~~lisp
(make-list 3)
;; => (NIL NIL NIL)
(fill * "hello")
;; => ("hello" "hello" "hello")
~~~

`list*` はさまざまな面で `list` に似ています。既存のリストの前に 1 つまたは複数の
要素を追加し、新しいリストを返すのに便利です。

~~~lisp
(list* :foo (list 1 2 3))
;; => (:FOO 1 2 3)

(list* 'a 'b 'c '(d e f))
;; => (A B C D E F)
~~~

`:foo` がリストの先頭に追加され、結果のリストが平坦であることに注意してください。一方で次の場合は:

~~~lisp
(list :foo (list 1 2 3))
;; => (:FOO (1 2 3))
~~~

2 要素の新しいリストが得られます。

`list*` は `list` と同じく可変個数の引数を受け取ります。ただし違いとして、
リストの最後の要素は最後の 2 要素からなる cons セルになります。以下ではドット対で示されています。

~~~lisp
(list*  1 2 3)
;; => (1 2 . 3)
~~~

そしてこの結果は proper list ではありません。cons セルの連なりです。

一方、`list` では:

~~~lisp
(list 1 2 3)
;; => (1 2 3)
~~~

最後の cons セルは数値 3 と `nil` で、`nil` が proper list の終端です。


### ldiff, tailp

<!-- TODO redact -->

オブジェクトがリストのいずれかの末尾と同一であれば、`tailp` は真を返します。
そうでなければ偽を返します。

オブジェクトがリストのいずれかの末尾と同一であれば、`ldiff` はリストのリスト構造内で
オブジェクトに先行する要素からなる新しいリストを返します。そうでなければリストのコピーを返します。

<!-- ~~~lisp -->
<!-- (ldiff '(1 2) (list 9 8 1 2 3)) -->
<!-- ;; => (1 2) -->
<!-- ~~~ -->

循環リストではどうなるでしょうか。実装のドキュメントを確認してください。
循環性を検出した場合は偽を返さなければなりません。


### member (elt, list)

`eql` による等価性を満たす最初の要素から始まる `list` の末尾を返します。

`:test`、`:test-not`、`:key`（関数またはシンボル）を受け取ります。

~~~lisp
(member 2 '(1 2 3))
;; (2 3)
~~~

### ツリー内のオブジェクトの置換: subst, sublis

[subst](http://www.lispworks.com/documentation/HyperSpec/Body/f_substc.htm) and
`subst-if` は、ツリー内の要素または部分式の出現箇所を検索して置換します
（省略可能な `test` を満たす場合）。

~~~lisp
(subst 'one 1 '(1 2 3))
;; => (ONE 2 3)

(subst  '(1 . one) '(1 . 1) '((1 . 1) (2 . 2)) :test #'equal)
;; ((1 . ONE) (2 . 2))
~~~

[sublis](http://www.lispworks.com/documentation/HyperSpec/Body/f_sublis.htm)
を使うと、多くのオブジェクトを一度に置換できます。`tree` 内で見つかった
`alist` に指定されたオブジェクトを、alist に与えられた新しい値で置き換えます。

~~~lisp
(sublis '((x . 10) (y . 20))
        '(* x (+ x y) (* y y)))
;; (* 10 (+ 10 20) (* 20 20))
~~~

`sublis` は `:test` と `:key` 引数を受け取ります。`:test` はキーとサブツリーという
2 つの引数を取る関数です。

~~~lisp
(sublis '((t . "foo"))
        '("one" 2 ("three" (4 5)))
        :key #'stringp)
;; ("foo" 2 ("foo" (4 5)))
~~~


## シーケンス

**リスト** と **ベクタ**（したがって **文字列**）はシーケンスです。

_注_: [文字列](#chapter-strings) のページも参照してください。

シーケンス関数の多くはキーワード引数を取ります。すべてのキーワード引数は省略可能で、
指定する場合は任意の順序で現れてかまいません。

`:test` 引数に注意してください。デフォルトは `eql` です。文字列には `:equal` を使います。

`:key` 引数には 1 引数の関数を渡せます。このキー関数は、シーケンスの要素を見るための
フィルタとして使われます。たとえば次の例では:

~~~lisp
(defparameter *list-of-pairs* '((1 2) (41 42)))

(find 42 *list-of-pairs* :key #'second)
;; => (41 42)
~~~

42 そのものに等しい要素ではなく、`second` 要素が 42 に等しいシーケンス内の要素を
検索します。`:key` が省略されるか nil の場合、フィルタは実質的に `identity` 関数です。

`lambda` 関数、または 1 引数を受け取る任意の関数を使えます。


### 述語: every, some, notany

`every, notevery (test, sequence)`: シーケンスの対応する要素集合に対するいずれかの
テストが nil を返した時点で、それぞれ nil または t を返します。

`some`, `notany` *(test, sequence)*: テストの値または nil を返します。

~~~lisp
(defparameter foo '(1 2 3))
(every #'evenp foo)
;; => NIL
(some #'evenp foo)
;; => T
~~~

文字列リストの例:

~~~lisp
(defparameter *list-of-strings* '("foo" "bar" "team"))
(every #'stringp *list-of-strings*)
;; => T

(some (lambda (it)
        (= 3 (length it)))
   *list-of-strings*)
;; => T
~~~


### 関数

次で定義されているシーケンス関数も参照してください。
[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Sequences):
`starts-with`, `ends-with`, `ends-with-subseq`, `length=`, `emptyp`,…

#### length (sequence)

#### elt (sequence, index) - インデックスで探す

ここではシーケンスが先に来ることに注意してください。

#### count (foo sequence)

シーケンス内で *foo* にマッチする要素数を返します。

追加パラメータ: `:from-end`、`:start`、`:end`。

`count-if`、`count-not` *(test-function sequence)* も参照してください。

#### subseq (sequence start, [end])

~~~lisp
(subseq (list 1 2 3) 0)
;; (1 2 3)
(subseq (list 1 2 3) 1 2)
;; (2)
~~~

ただし、`end` がリストより大きい場合は注意してください。

~~~lisp
(subseq (list 1 2 3) 0 99)
;; => Error: the bounding indices 0 and 99
;; are bad for a sequence of length 3.
~~~

この目的には `alexandria-2:subseq*` を使います。

~~~lisp
(alexandria-2:subseq* (list 1 2 3) 0 99)
;; (1 2 3)
~~~

`subseq` は "setf" 可能ですが、新しいシーケンスが置換対象と同じ長さの場合にのみ動作します。


[​]{#sort-stable-sort-sequence-test--key-function-}

#### sort, stable-sort (sequence, test [, key 関数]) (破壊的)

これらのソート関数は破壊的なので、ソート前に `copy-seq` でシーケンスをコピーした方がよい場合があります。

~~~lisp
(sort (copy-seq seq) #'string<)
~~~

`sort` と異なり、`stable-sort` は引数の順序を保つことを保証します。理論上、次の結果は:

~~~lisp
(sort '((1 :a) (1 :b)) #'< :key #'first)
~~~

`((1 :A) (1 :B))` にも `((1 :B) (1 :A))` にもなり得ます。私のテストでは順序は保たれましたが、標準はそれを保証していません。


#### fill (sequence item &keys start end) (破壊的)

`fill` は **破壊的** な操作です。

シーケンス内の `start` と `end` の位置の間にある要素を、`item` で破壊的に置き換えます。

~~~lisp
(make-list 3)
;; (NIL NIL NIL)
(fill * :hello :start 1)
;; (NIL :HELLO :HELLO)
~~~

`substitute` も参照してください。


#### find, position (foo, sequence) - インデックスを得る

`find-if`、`find-if-not`、`position-if`、`position-if-not` *(test sequence)* もあります。
`:key` と `:test` パラメータを参照してください。

~~~lisp
(find 20 '(10 20 30))
;; 20
(position 20 '(10 20 30))
;; 1
~~~

#### search と mismatch (sequence-a, sequence-b)

`search` は `sequence-b` の中から `sequence-a` にマッチするサブシーケンスを検索します。
`sequence-b` 内の *位置*、または NIL を返します。`from-end`、`end1`、`end2` と、
通常の `test`、`key` パラメータを取ります。

~~~lisp
(search '(20 30) '(10 20 30 40))
;; 1
(search '("b" "c") '("a" "b" "c"))
;; NIL
(search '("b" "c") '("a" "b" "c") :test #'equal)
;; 1
(search "bc" "abc")
;; 1
~~~

`mismatch` は 2 つのシーケンスが異なり始める位置を返します。

~~~lisp
(mismatch '(10 20 99) '(10 20 30))
;; 2
(mismatch "hellolisper" "helloworld")
;; 5
(mismatch "same" "same")
;; NIL
(mismatch "foo" "bar")
;; 0
~~~

#### substitute, nsubstitute[if,if-not]

`old` と等しいすべての要素を `new` に置き換えた、元のシーケンスと同じ種類のシーケンスを返します。

~~~lisp
(substitute #\o #\x "hellx") ;; => "hello"
(substitute :a :x '(:a :x :x)) ;; => (:A :A :A)
(substitute "a" "x" '("a" "x" "x") :test #'string=)
;; => ("a" "a" "a")
~~~

`nsubstitute` は "non-consing" な破壊的バージョンです。


#### merge (result-type, sequence1, sequence2, predicate) (破壊的)

`merge` 関数は破壊的です。

> 述語によって決まる順序に従って、`sequence1` と `sequence2` を破壊的にマージします。

~~~lisp
(setq test1 (list 1 3 5 7))
(setq test2 (list 2 4 6 8))
(merge 'list test1 test2 #'<)
;; => (1 2 3 4 5 6 7 8)
~~~

ここで `test1` を見てみます。

~~~lisp
test1
;; => (1 2 3 4 5 6 7 8)
;; 少なくとも SBCL ではこうなるが、結果は異なる場合があります。
~~~


#### replace (sequence-a, sequence-b, &key start1, end1) (破壊的)

`sequence-a` の要素を `sequence-b` の要素で破壊的に置き換えます。

完全なシグネチャは次のとおりです。

~~~lisp
(replace sequence1 sequence2
      &rest args
      &key (start1 0) (end1 nil) (start2 0) (end2 nil))
~~~

START1 と END1 で区切られたサブシーケンスへ、START2 と END2 で区切られた
サブシーケンスから要素がコピーされます。これらのサブシーケンスの長さが同じでない場合、
短い方の長さによってコピーされる要素数が決まります。

~~~lisp
(replace "xxx" "foo")
"foo"

(replace "xxx" "foo" :start1 1)
"xfo"

(replace "xxx" "foo" :start1 1 :start2 1)
"xoo"

(replace "xxx" "foo" :start1 1 :start2 1 :end2 2)
"xox"
~~~


#### remove, delete (foo sequence)

`foo` にマッチする要素を除いたシーケンスのコピーを作ります。`:start/end`、`:key`、
`:count` パラメータがあります。

`delete` は `remove` の再利用版です。

~~~lisp
(remove "foo" '("foo" "bar" "foo") :test 'equal)
;; => ("bar")
~~~

下記の `remove-if[-not]` も参照してください。

#### remove-duplicates, delete-duplicates (sequence)

[remove-duplicates](http://clhs.lisp.se/Body/f_rm_dup.htm) は一意な要素を持つ
新しいシーケンスを返します。`delete-duplicates` は元のシーケンスを変更する場合があります。

`remove-duplicates` は通常の引数 `from-end test test-not start end key` を受け取ります。

~~~lisp
(remove-duplicates '(:foo :foo :bar))
(:FOO :BAR)

(remove-duplicates '("foo" "foo" "bar"))
("foo" "foo" "bar")

(remove-duplicates '("foo" "foo" "bar") :test #'string-equal)
("foo" "bar")
~~~


### マッピング (map, mapcar, remove-if[-not],...)

他の言語の map や filter に慣れているなら、おそらく `mapcar` が欲しくなるでしょう。
ただしこれはリストでしか動作しないため、ベクタを反復処理するには
（そしてベクタまたはリストを生成するには）`(map 'list function vector)` を使います。

mapcar は `&rest more-seqs` で複数のリストも受け取ります。最短のシーケンスが尽きると
マッピングは停止します。

`map` は出力型を第 1 引数として取ります（`'list`、`'vector`、`'string`）。

~~~lisp
(defparameter foo '(1 2 3))
(map 'list (lambda (it) (* 10 it)) foo)
~~~

`reduce` *(関数, sequence)*。特別なパラメータ: `:initial-value`。

~~~lisp
(reduce '- '(1 2 3 4))
;; => -8
(reduce '- '(1 2 3 4) :initial-value 100)
;; => 90
~~~

ここでいう**フィルタリング**は `remove-if-not` と呼ばれます。

### リストを平坦化する (Alexandria)

次の
[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html),
には `flatten` 関数があります。


### 変数を使ってリストを作成する

これは `backquote` の用途の 1 つです。

~~~lisp
(defparameter *var* "bar")
;; 1 回目:
'("foo" *var* "baz") ;; バッククォートなし
;; => ("foo" *VAR* "baz") ;; だめ
~~~

2 回目は、バッククォート補間を使います。

~~~lisp
`("foo" ,*var* "baz")     ;; バッククォート、カンマ
;; => ("foo" "bar" "baz") ;; よい
~~~

バッククォートはまず補間を行うことを示し、カンマは変数の値を導入します。

変数がリストの場合:

~~~lisp
(defparameter *var* '("bar" "baz"))
;; 1 回目:
`("foo" ,*var*)
;; => ("foo" ("bar" "baz")) ;; ネストしたリスト
`("foo" ,@*var*)            ;; バッククォート、comma-@
;; => ("foo" "bar" "baz")
~~~

E. Weitz は、「この方法で生成されたオブジェクトはかなり高い確率で構造を共有する
（Recipe 2-7 を参照）」と警告しています。


### リストの比較

集合関数を使えます。

## 集合

以下では、リストに対して集合演算を使う方法を示します。

集合は同じ要素を 2 回含まず、順序を持ちません。

これらの関数の多くには、"n" で始まる再利用（変更）版があります。たとえば
`nintersection` や `nreverse` です。"n" は "non-consing"、つまり
「メモリ内にオブジェクトを作らない」という Lisp の言い回しです。

これらはすべて通常の `:key` と `:test` 引数を受け取るため、文字列を扱う場合は
テストとして `#'string=` または `#'equal` を使ってください。

詳しくは
[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Conses):
の `setp`、`set-equal` などの関数と、次の節で示す FSet ライブラリを参照してください。

### リストの `intersection`

list-a と list-b の両方にある要素は何でしょうか。

~~~lisp
(defparameter list-a '(0 1 2 3))
(defparameter list-b '(0 2 4))
(intersection list-a list-b)
;; => (2 0)
~~~

### list-a から list-b の要素を取り除く (`set-difference`)

~~~lisp
(set-difference list-a list-b)
;; => (3 1)
(set-difference list-b list-a)
;; => (4)
~~~

### 一意な要素を持つ 2 つのリストを結合する (`union`, `nunion`)

~~~lisp
(union list-a list-b)
;; => (3 1 0 2 4) ;; 使用する Lisp では順序が異なる場合があります
~~~

`nunion` は再利用する破壊的バージョンです。

### 両方のリストにある要素を取り除く (`set-exclusive-or`)

~~~lisp
(set-exclusive-or list-a list-b)
;; => (4 3 1)
~~~

### 集合に要素を追加する (`adjoin`)

新しい集合が返され、元の集合は変更されません。

~~~lisp
(adjoin 3 list-a)
;; => (0 1 2 3)   ;; <-- 何も変更されない。3 はすでに存在していた。

(adjoin 5 list-a)
;; => (5 0 1 2 3) ;; <-- 要素が先頭に追加された。

list-a
;; => (0 1 2 3)  ;; <-- 元のリストは変更されていない。
~~~

リストを変更する `pushnew` も使えます（上記参照）。


### 部分集合かどうかを調べる (`subsetp`)

~~~lisp
(subsetp '(1 2 3) list-a)
;; => T

(subsetp '(1 1 1) list-a)
;; => T

(subsetp '(3 2 1) list-a)
;; => T

(subsetp '(0 3) list-a)
;; => T
~~~


## 配列とベクタ

**配列** は定数時間アクセスの性質を持ちます。

配列は固定長にも調整可能にもできます。*単純配列* は、変位（displaced。
`:displaced-to` を使って別の配列を指すもの）でも調整可能（`:adjust-array`）でもなく、
フィルポインタ（要素を追加または削除すると移動する `fill-pointer`）も持ちません。

**ベクタ** はランク 1（1 次元）の配列です。これは *シーケンス* でもあります（上記参照）。

*simple vector* は、特殊化もされていない単純配列です
（要素の型を設定するために `:element-type` を使いません）。


### 1 次元または多次元の配列を作成する

`make-array` *(sizes-list :adjustable bool)*

`adjust-array` *(array, sizes-list, :element-type, :initial-element)*

### アクセス: aref (array i [j …])

`aref` *(array i j k …)*、または `(aref i i i …)` と等価な `row-major-aref` *(array i)*。

結果は `setf` 可能です。

~~~lisp
(defparameter myarray (make-array '(2 2 2) :initial-element 1))
myarray
;; => #3A(((1 1) (1 1)) ((1 1) (1 1)))
(aref myarray 0 0 0)
;; => 1
(setf (aref myarray 0 0 0) 9)
;; => 9
(row-major-aref myarray 0)
;; => 9
~~~


### サイズ

`array-total-size` *(array)*: 配列に入る要素数。

`array-dimensions` *(array)*: 配列の各次元の長さを含むリスト。

`array-dimension` *(array i)*: *i* 番目の次元の長さ。

`array-rank`: 配列の次元数。

~~~lisp
(defparameter myarray (make-array '(2 2 2)))
;; => MYARRAY
myarray
;; => #3A(((0 0) (0 0)) ((0 0) (0 0)))
(array-rank myarray)
;; => 3
(array-dimensions myarray)
;; => (2 2 2)
(array-dimension myarray 0)
;; => 2
(array-total-size myarray)
;; => 8
~~~


### ベクタ

`vector` またはリーダマクロ `#()` で作成します。これは _simple vector_ を返します。

~~~lisp
(vector 1 2 3)
;; => #(1 2 3)
#(1 2 3)
;; => #(1 2 3)
~~~

ベクタ（またはベクタに似た配列）には次のインターフェイスが利用できます。

* `vector-push` *(new-element vector)*: fill ポインタが指すベクタ要素を `new-element` に置き換え、その後 fill ポインタを 1 増やします。新しい要素が置かれたインデックス、または十分な空きがなければ NIL を返します。
* `vector-push-extend` *(new-element vector [extension])*: `vector-push` と同様ですが、fill ポインタが大きくなりすぎた場合は `adjust-array` を使って配列を拡張します。`extension` は、拡張が必要な場合に配列へ追加する最小要素数です。
* `vector-pop` *(vector)*: fill ポインタを減らし、それが新たに指す要素を返します。
* `fill-pointer` *(vector)*. `setf` 可能。

*シーケンス* 関数も参照してください。

以下は、必要に応じて格納容量を増やしながら、任意に push/pop できる配列を作る方法を示しています。
これは Python の `list`、Java の `ArrayList`、C++ の `vector<T>` におおよそ相当します。
ただし、pop されたときに要素が消去されるわけではない点に注意してください。

~~~lisp
CL-USER> (defparameter *v* (make-array 0 :fill-pointer t :adjustable t))
*V*
CL-USER> *v*
#()
CL-USER> (vector-push-extend 42 *v*)
0
CL-USER> (vector-push-extend 43 *v*)
1
CL-USER> (vector-pop *v*)
43
CL-USER> *v*
#(42)
CL-USER> (aref *v* 1) ; 注意、要素はまだそこにある!
43
CL-USER> (setf (aref *v* 1) nil) ; 必要なら手動で要素を消去する
~~~

### ベクタをリストに変換する

それを map している場合は、第 1 パラメータが結果型である `map` 関数を参照してください。

または `(coerce vector 'list)` を使います。

## ハッシュテーブル

ハッシュテーブルは、キーと値を非常に効率よく関連付ける強力なデータ構造です。
性能が問題になる場合、ハッシュテーブルは連想リストより好まれることが多いですが、
少しオーバーヘッドがあるため、維持するキー値ペアが少数だけなら assoc リストの方が適しています。

ただし、alist は別の使い方ができることもあります。

- 順序を持たせられます
- 同じキーを持つ cons セルを push し、先頭のものを取り除けばスタックになります
- 人間が読める印字表現を持ちます
- 簡単にシリアライズ/デシリアライズできます
- RASSOC があるため、alist のキーと値は本質的に交換可能です。一方、ハッシュテーブルではキーと値は非常に異なる役割を持ちます（いつものように、詳しくは Edmund Weitz の "Common Lisp Recipes" を参照してください）。


[​]{#create}

### ハッシュテーブルの作成

ハッシュテーブルは関数
[`make-hash-table`](http://www.lispworks.com/documentation/HyperSpec/Body/f_mk_has.htm)
を使って作成します。必須引数はありません。最もよく使われる省略可能なキーワード引数は
`:test` で、キーの等価性をテストするために使う関数を指定します。

<div class="info-box info">
<strong>注:</strong> より短い記法については、<a href="https://github.com/ruricolist/serapeum/">Serapeum</a> や <a href="https://github.com/vseloved/rutils">Rutils</a> ライブラリを参照してください。たとえば Serapeum には <code>dict</code> があり、Rutils には <code>#h</code> リーダマクロがあります。
</div>

[​]{#add}

### ハッシュテーブルへの要素の追加

ハッシュテーブルに要素を追加したい場合は、ハッシュテーブルから要素を取り出す関数
`gethash` を
[`setf`](http://www.lispworks.com/documentation/HyperSpec/Body/m_setf_.htm)
と組み合わせて使えます。
と組み合わせて使えます。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table))
*MY-HASH*
CL-USER> (setf (gethash 'one-entry *my-hash*) "one")
"one"
CL-USER> (setf (gethash 'another-entry *my-hash*) 2/4)
1/2
CL-USER> (gethash 'one-entry *my-hash*)
"one"
T
CL-USER> (gethash 'another-entry *my-hash*)
1/2
T
~~~

Serapeum の `dict` を使うと、ハッシュテーブルを作成し、要素を一度に追加できます。

~~~lisp
(defparameter *my-hash* (dict :one-entry "one"
                              :another-entry 2/4))
;; =>
 (dict
  :ONE-ENTRY "one"
  :ANOTHER-ENTRY 1/2
 )
~~~

[​]{#get}

### ハッシュテーブルから値を取得する

関数
[`gethash`](http://www.lispworks.com/documentation/HyperSpec/Body/f_gethas.htm)
は 2 つの必須引数、キーとハッシュテーブルを取ります。返り値は 2 つあります。
ハッシュテーブル内でキーに対応する値（見つからなければ `nil`）と、そのキーが
テーブル内で見つかったかどうかを示すブール値です。キー値ペアの値として `nil` は
有効なので、この第 2 値が必要です。`gethash` の第 1 値として `nil` が得られても、
必ずしもキーがテーブル内に見つからなかったことを意味しません。

#### 存在しないキーをデフォルト値付きで取得する

`gethash` には省略可能な第 3 引数があります。

~~~lisp
(gethash 'bar *my-hash* "default-bar")
;; => "default-bar"
;;     NIL
~~~

#### ハッシュテーブルのすべてのキーまたはすべての値を取得する

次の
[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html)
ライブラリ（Quicklisp 内）には、そのための関数 `hash-table-keys` と
`hash-table-values` があります。

~~~lisp
(ql:quickload "alexandria")
;; […]
(alexandria:hash-table-keys *my-hash*)
;; => (BAR)
~~~


[​]{#test}

### ハッシュテーブルの比較

ハッシュテーブルの等価性を要素ごとに比較するには `equalp` を使います。`equalp` は
文字列について大文字小文字を区別しません。詳しくは [等価性](#chapter-equality) の節を参照してください。


### ハッシュテーブル内のキーの存在をテストする

`gethash` が返す第 1 値は、`gethash` の引数として与えたキーに関連付けられた
ハッシュテーブル内のオブジェクト、またはそのキーに値が存在しない場合の `nil` です。
この値は、キーの存在をテストしたい場合に
[一般化ブール値](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_g.htm#generalized_boolean">generalized
boolean) として振る舞えます。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table))
*MY-HASH*
CL-USER> (setf (gethash 'one-entry *my-hash*) "one")
"one"
CL-USER> (if (gethash 'one-entry *my-hash*)
           "Key exists"
           "Key does not exist")
"Key exists"
CL-USER> (if (gethash 'another-entry *my-hash*)
           "Key exists"
           "Key does not exist")
"Key does not exist"
~~~

ただし、ハッシュに格納したい値の中に `nil` がある場合、これは動作しないことに注意してください。

~~~lisp
CL-USER> (setf (gethash 'another-entry *my-hash*) nil)
NIL
CL-USER> (if (gethash 'another-entry *my-hash*)
           "Key exists"
           "Key does not exist")
"Key does not exist"
~~~

この場合、`gethash` の _第 2_ 返り値を確認する必要があります。これは値が見つからなければ常に `nil`、そうでなければ T を返します。

~~~lisp
CL-USER> (if (nth-value 1 (gethash 'another-entry *my-hash*))
           "Key exists"
           "Key does not exist")
"Key exists"
CL-USER> (if (nth-value 1 (gethash 'no-entry *my-hash*))
           "Key exists"
           "Key does not exist")
"Key does not exist"
~~~


[​]{#del}

### ハッシュテーブルからの削除

ハッシュエントリを削除するには
[`remhash`](http://www.lispworks.com/documentation/HyperSpec/Body/f_remhas.htm)
を使います。キーとそれに関連付けられた値の両方がハッシュテーブルから取り除かれます。
そのようなエントリがあれば `remhash` は T を返し、そうでなければ `nil` を返します。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table))
*MY-HASH*
CL-USER> (setf (gethash 'first-key *my-hash*) 'one)
ONE
CL-USER> (gethash 'first-key *my-hash*)
ONE
T
CL-USER> (remhash 'first-key *my-hash*)
T
CL-USER> (gethash 'first-key *my-hash*)
NIL
NIL
CL-USER> (gethash 'no-entry *my-hash*)
NIL
NIL
CL-USER> (remhash 'no-entry *my-hash*)
NIL
CL-USER> (gethash 'no-entry *my-hash*)
NIL
NIL
~~~


[​]{#del-tab}

### ハッシュテーブルの削除

ハッシュテーブルを削除するには
[`clrhash`](http://www.lispworks.com/documentation/HyperSpec/Body/f_clrhas.htm)
を使います。これはハッシュテーブルからすべてのデータを取り除き、削除済みのテーブルを返します。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table))
*MY-HASH*
CL-USER> (setf (gethash 'first-key *my-hash*) 'one)
ONE
CL-USER> (setf (gethash 'second-key *my-hash*) 'two)
TWO
CL-USER> *my-hash*
#<hash-table :TEST eql :COUNT 2 {10097BF4E3}>
CL-USER> (clrhash *my-hash*)
#<hash-table :TEST eql :COUNT 0 {10097BF4E3}>
CL-USER> (gethash 'first-key *my-hash*)
NIL
NIL
CL-USER> (gethash 'second-key *my-hash*)
NIL
NIL
~~~


[​]{#traverse}

### ハッシュテーブルの走査: `loop`, `maphash`, `with-hash-table-iterator`

ハッシュテーブル内の各エントリ（つまり各キー値ペア）に対して操作を行いたい場合、
いくつかの選択肢があります。

- もちろん `loop`、さらに
- `maphash`
- `with-hash-table-iterator`
- alexandria、serapeum、その他のサードパーティライブラリもあります。

=> [繰り返しのページ](/cl-cookbook/iteration.html#looping-over-a-hash-table) を参照してください。

~~~lisp
(loop :for k :being :the :hash-key :of *my-hash-table* :collect k)
;; (B A)
~~~

~~~lisp
(maphash (lambda (key val)
           (format t "key: ~A value: ~A~%" key val))
         *my-hash-table*)
;; =>
key: A value: 1
key: B value: 2
NIL
~~~



[​]{#count}

### ハッシュテーブル内のエントリ数を数える

指で数える必要はありません。Common Lisp にはそのための組み込み関数があります。
[`hash-table-count`](http://www.lispworks.com/documentation/HyperSpec/Body/f_hash_1.htm).

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table))
*MY-HASH*
CL-USER> (hash-table-count *my-hash*)
0
CL-USER> (setf (gethash 'first *my-hash*) 1)
1
CL-USER> (setf (gethash 'second *my-hash*) 2)
2
CL-USER> (setf (gethash 'third *my-hash*) 3)
3
CL-USER> (hash-table-count *my-hash*)
3
CL-USER> (setf (gethash 'second *my-hash*) 'two)
TWO
CL-USER> (hash-table-count *my-hash*)
3
CL-USER> (clrhash *my-hash*)
#<EQL hash table, 0 entries {48205F35}>
CL-USER> (hash-table-count *my-hash*)
0
~~~

### ハッシュテーブルを読み戻し可能に印字する

**print-object を使う**（移植性なし）

`print-object` を使いたくなるのは自然です。これはいくつかの実装では動作しますが、
実際には移植性のある方法ではありません。標準はこれを許していないため、未定義動作です。

~~~lisp
(defmethod print-object ((object hash-table) stream)
  (format stream "#HASH{~{~{(~a : ~a)~}~^ ~}}"
          (loop for key being the hash-keys of object
                using (hash-value value)
                collect (list key value))))
~~~

次のようになります。

~~~
;; WARNING:
;;   redefining PRINT-OBJECT (#<STRUCTURE-CLASS COMMON-LISP:HASH-TABLE>
;;                            #<SB-PCL:SYSTEM-CLASS COMMON-LISP:T>) in DEFMETHOD
;; #<STANDARD-METHOD COMMON-LISP:PRINT-OBJECT (HASH-TABLE T) {1006A0D063}>
~~~

試してみましょう。

~~~lisp
(let ((ht (make-hash-table)))
  (setf (gethash :foo ht) :bar)
  ht)
;; #HASH{(FOO : BAR)}
~~~

**カスタム関数を使う**（移植性のある方法）

移植性のある方法は次のとおりです。

このスニペットはハッシュテーブルのキー、値、テスト関数を印字し、
`alexandria:alist-hash-table` を使って読み戻します。

~~~lisp
;; https://github.com/phoe/phoe-toolbox/blob/master/phoe-toolbox.lisp
(defun print-hash-table-readably (hash-table
                                  &optional
                                  (stream *standard-output*))
  "ALEXANDRIA:ALIST-HASH-TABLE を使ってハッシュテーブルを読み戻し可能に印字する。"
  (let ((test (hash-table-test hash-table))
        (*print-circle* t)
        (*print-readably* t))
    (format stream "#.(ALEXANDRIA:ALIST-HASH-TABLE '(~%")
    (maphash (lambda (k v) (format stream "   (~S . ~S)~%" k v)) hash-table)
    (format stream "   ) :TEST '~A)" test)
    hash-table))
~~~

出力例:

```
#.(ALEXANDRIA:ALIST-HASH-TABLE
'((ONE . 1))
  :TEST 'EQL)
#<HASH-TABLE :TEST EQL :COUNT 1 {10046D4863}>
```

この出力は読み戻してハッシュテーブルを作成できます。

~~~lisp
(read-from-string
 (with-output-to-string (s)
   (print-hash-table-readably
    (alexandria:alist-hash-table
     '((a . 1) (b . 2) (c . 3))) s)))
;; #<HASH-TABLE :TEST EQL :COUNT 3 {1009592E23}>
;; 83
~~~

**Serapeum を使う**（読み戻し可能で移植性あり）

[Serapeum library](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#hash-tables)
には `dict` コンストラクタ、`pretty-print-hash-table` 関数、
`toggle-pretty-print-hash-table` スイッチがあります。これらはいずれも内部で
`print-object` を使いません。

~~~lisp
CL-USER> (serapeum:toggle-pretty-print-hash-table)
T
CL-USER> (serapeum:dict :a 1 :b 2 :c 3)
(dict
  :A 1
  :B 2
  :C 3
 )
~~~

この印字表現は読み戻せます。


[​]{#size}

### スレッドセーフなハッシュテーブル

Common Lisp の標準ハッシュテーブルはスレッドセーフではありません。つまり、単純な
アクセス操作が途中で中断され、誤った結果を返す可能性があります。

実装ごとに異なる解決策があります。

**SBCL** では、`make-hash-table` に `:synchronized` キーワードを指定してスレッドセーフなハッシュテーブルを作成できます: [http://www.sbcl.org/manual/#Hash-Table-Extensions](http://www.sbcl.org/manual/#Hash-Table-Extensions).

> nil（デフォルト）の場合、ハッシュテーブルには複数の同時読み取りがあり得ますが、別の読み取りまたは書き込みと同時にスレッドがハッシュテーブルへ書き込む場合、結果は未定義です。t の場合、すべての同時アクセスは安全ですが、[clhs 3.6 (Traversal Rules and Side Effects)](http://www.lispworks.com/documentation/HyperSpec/Body/03_f.htm) は引き続き有効であることに注意してください。関連項目: sb-ext:with-locked-hash-table。

~~~lisp
(defparameter *my-hash* (make-hash-table :synchronized t))
~~~

ただし、変更マクロ（`incf`）や次のように、2 回のアクセスへ展開される操作は:

~~~lisp
(setf (gethash :a *my-hash*) :new-value)
~~~

`sb-ext:with-locked-hash-table` で包む必要があります。

> BODY の実行中、HASH-TABLE への同時アクセスを制限します。HASH-TABLE が synchronized の場合、BODY はテーブルを排他的に所有して実行されます。HASH-TABLE が synchronized でない場合、BODY は他の WITH-LOCKED-HASH-TABLE 本体を排除して実行されます。WITH-LOCKED-HASH-TABLE で囲まれていないハッシュテーブルアクセスの排除は未規定です。

~~~lisp
(sb-ext:with-locked-hash-table (*my-hash*)
  (setf (gethash :a *my-hash*) :new-value))
~~~

**LispWorks** では、ハッシュテーブルはデフォルトでスレッドセーフです。ただし同様に、
アクセス操作 *間* の原子性は保証されないため、
[with-hash-table-locked](http://www.lispworks.com/documentation/lw71/LW/html/lw-144.htm#pgfId-900768).
を使えます。

最終的には、[**cl-gserver library**](https://mdbergmann.github.io/cl-gserver/index.html#toc-2-4-1-hash-table-agent)
が提案するものが好みに合うかもしれません。これはハッシュテーブルと actors/agent
システムの周辺にヘルパー関数を提供し、スレッドセーフ性を可能にします。また、更新と読み取りの順序も維持します。


### 性能上の問題: ハッシュテーブルのサイズ

`make-hash-table` 関数には、ハッシュテーブルの初期サイズと、拡張が必要になった場合の
成長方法を制御する省略可能なパラメータがいくつかあります。大きなハッシュテーブルを
扱う場合、これは重要な性能上の問題になり得ます。以下は Linux 上の
[CMUCL](http://www.cons.org/cmucl) pre-18d による（率直に言ってあまり科学的ではない）例です。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table))
*MY-HASH*
CL-USER> (hash-table-size *my-hash*)
65
CL-USER> (hash-table-rehash-size *my-hash*)
1.5
CL-USER> (time (dotimes (n 100000)
                 (setf (gethash n *my-hash*) n)))
Compiling LAMBDA NIL:
Compiling Top-Level Form:

Evaluation took:
  0.27 seconds of real time
  0.25 seconds of user run time
  0.02 seconds of system run time
  0 page faults and
  8754768 bytes consed.
NIL
CL-USER> (time (dotimes (n 100000)
                 (setf (gethash n *my-hash*) n)))
Compiling LAMBDA NIL:
Compiling Top-Level Form:

Evaluation took:
  0.05 seconds of real time
  0.05 seconds of user run time
  0.0 seconds of system run time
  0 page faults and
  0 bytes consed.
NIL
~~~

次の値は
[`hash-table-size`](http://www.lispworks.com/documentation/HyperSpec/Body/f_hash_4.htm)
と
[`hash-table-rehash-size`](http://www.lispworks.com/documentation/HyperSpec/Body/f_hash_2.htm)
については実装依存です。この例では、CMUCL は初期サイズとして 65 を選び、
成長が必要になるたびにハッシュのサイズを 50 パーセント増やします。
最終サイズに達するまで、何回リサイズする必要があるか見てみましょう。

~~~lisp
CL-USER> (log (/ 100000 65) 1.5)
18.099062
CL-USER> (let ((size 65))
           (dotimes (n 20)
             (print (list n size))
             (setq size (* 1.5 size))))
(0 65)
(1 97.5)
(2 146.25)
(3 219.375)
(4 329.0625)
(5 493.59375)
(6 740.3906)
(7 1110.5859)
(8 1665.8789)
(9 2498.8184)
(10 3748.2275)
(11 5622.3413)
(12 8433.512)
(13 12650.268)
(14 18975.402)
(15 28463.104)
(16 42694.656)
(17 64041.984)
(18 96062.98)
(19 144094.47)
NIL
~~~

ハッシュは 100,000 個のエントリを保持できるほど大きくなるまでに 19 回リサイズされる必要があります。
そのため、多くの consing が発生し、ハッシュテーブルを埋めるのにかなり時間がかかったのです。
また、2 回目の実行がずっと速かった理由も説明できます。ハッシュテーブルはすでに正しいサイズだったからです。

もっと速い方法があります。
ハッシュがどれくらい大きくなるか事前に分かっているなら、適切なサイズから始められます。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table :size 100000))
*MY-HASH*
CL-USER> (hash-table-size *my-hash*)
100000
CL-USER> (time (dotimes (n 100000)
                 (setf (gethash n *my-hash*) n)))
Compiling LAMBDA NIL:
Compiling Top-Level Form:

Evaluation took:
  0.04 seconds of real time
  0.04 seconds of user run time
  0.0 seconds of system run time
  0 page faults and
  0 bytes consed.
NIL
~~~

これは明らかにずっと高速です。また、まったくリサイズする必要がなかったため consing も発生しませんでした。
最終サイズが事前に分からなくても、ハッシュテーブルの成長の仕方を推測できるなら、
その値を `make-hash-table` に与えることもできます。絶対的な成長を指定するには整数を、
相対的な成長を指定するには浮動小数点数を与えられます。

~~~lisp
CL-USER> (defparameter *my-hash* (make-hash-table :rehash-size 100000))
*MY-HASH*
CL-USER> (hash-table-size *my-hash*)
65
CL-USER> (hash-table-rehash-size *my-hash*)
100000
CL-USER> (time (dotimes (n 100000)
                 (setf (gethash n *my-hash*) n)))
Compiling LAMBDA NIL:
Compiling Top-Level Form:

Evaluation took:
  0.07 seconds of real time
  0.05 seconds of user run time
  0.01 seconds of system run time
  0 page faults and
  2001360 bytes consed.
NIL
~~~

これもかなり高速です（リサイズは 1 回だけで済みました）が、ほぼハッシュテーブル全体
（初期の 65 要素を除く）をループ中に構築する必要があったため、consing はずっと多くなります。

新しいハッシュテーブルを作成するときに `rehash-threshold` も指定できることに注意してください。
最後に 1 つ。実装は、`rehash-size` と `rehash-threshold` に与えられた値を
_完全に無視_ することも許されています。

## Alist

### 定義

連想リストは cons セルのリストです。

キーと値は任意の型にできます。

この単純な例は:

~~~lisp
(defparameter *my-alist* (list (cons 'foo "foo")
                               (cons 'bar "bar")))
;; => ((FOO . "foo") (BAR . "bar"))
~~~

次のようになります。

```
[o|o]---[o|/]
 |       |
 |      [o|o]---"bar"
 |       |
 |      BAR
 |
[o|o]---"foo"
 |
FOO
```

### 構築

上記のように cons セルのリストを構築するほかに、ドット表現に従って alist を構築できます。

~~~lisp
(setf *my-alist* '((:foo . "foo")
                   (:bar . "bar")))
~~~

quote を使うと、その内側の式は評価されないことを覚えておいてください。

コンストラクタ `pairlis` はキーのリストと値のリストを対応付けます。

~~~lisp
(pairlis (list :foo :bar)
         (list "foo" "bar"))
;; => ((:BAR . "bar") (:FOO . "foo"))
~~~

alist は単なるリストなので、同じ alist 内で同じキーを複数回持てます。

~~~lisp
(setf *alist-with-duplicate-keys*
  '((:a . 1)
    (:a . 2)
    (:b . 3)
    (:a . 4)
    (:c . 5)))
~~~


### アクセス

キーを取得するには `assoc` があります（キーが文字列の場合は、いつものように `:test 'equal` を使います）。
これは cons セル全体を返すため、値を取得するには `cdr` や `rest` を使うか、
`Alexandria` の `assoc-value list key` を使うとよいでしょう。

~~~lisp
(assoc :foo *my-alist*)
;; (:FOO . "foo")
(cdr *)
;; "foo"
~~~

~~~lisp
(alexandria:assoc-value *my-alist* :foo)
;; "foo"
;; (:FOO . "FOO")
;; 実際には 2 つの値を返している。
~~~

`assoc-if` もあります。また、値から cons セルを得る「逆方向」の検索を行う `rassoc` もあります。

~~~lisp
(rassoc "foo" *my-alist*)
;; NIL
;; 残念! 値 "foo" は文字列なので、次を使う:
(rassoc "foo" *my-alist* :test #'equal)
;; (:FOO . "foo")
~~~

alist に繰り返し（重複）キーがある場合、たとえば `remove-if-not` を使ってそれらすべてを取得できます。

~~~lisp
(remove-if-not
  (lambda (entry)
      (eq :a entry))
  *alist-with-duplicate-keys*
  :key #'car)
~~~

### エントリの挿入と削除

関数 `acons` は既存の alist に指定された値を持つキーを追加し、新しい alist を返します。

~~~lisp
(acons :key "key" *my-alist*)
;; => ((:KEY . "key") (:FOO . "foo") (:BAR . "bar"))
~~~

キーを追加するには、別の cons セルを `push` できます。

~~~lisp
(push (cons 'team "team") *my-alist*)
;; => ((TEAM . "team") (FOO . "foo") (BAR . "bar"))
~~~

`pop` や、`remove` のようなリストを操作する他の関数を使えます。

~~~lisp
(remove :team *my-alist*)
;; ((:TEAM . "team") (FOO . "foo") (BAR . "bar"))
;; => 何も削除されていない
(remove :team *my-alist* :key 'car)
;; ((FOO . "foo") (BAR . "bar"))
;; => コピーを返す
~~~

`:count` で 1 要素だけ削除します。

~~~lisp
(push (cons 'bar "bar2") *my-alist*)
;; ((BAR . "bar2") (TEAM . "team") (FOO . "foo") (BAR . "bar"))
;; => 'bar キーが 2 回ある

(remove 'bar *my-alist* :key 'car :count 1)
;; ((TEAM . "team") (FOO . "foo") (BAR . "bar"))

;; そうしないと:
(remove 'bar *my-alist* :key 'car)
;; ((TEAM . "team") (FOO . "foo"))
;; => 'bar がなくなる
~~~

### エントリの更新

値を置き換えます。

~~~lisp
*my-alist*
;; => '((:FOO . "foo") (:BAR . "bar"))
(assoc :foo *my-alist*)
;; => (:FOO . "foo")
(setf (cdr (assoc :foo *my-alist*)) "new-value")
;; => "new-value"
*my-alist*
;; => '((:foo . "new-value") (:BAR . "bar"))
~~~

キーを置き換えます。

~~~lisp
*my-alist*
;; => '((:FOO . "foo") (:BAR . "bar")))
(setf (car (assoc :bar *my-alist*)) :new-key)
;; => :NEW-KEY
*my-alist*
;; => '((:FOO . "foo") (:NEW-KEY . "bar")))
~~~

次の
[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Conses)
ライブラリには、`hash-table-alist`、`alist-plist` など、さらに多くの関数があります。


## Plist

### plist とは

プロパティリストは、キー、値、キー、値というように交互に並ぶ単なるリストです。
キーはキーワードまたはシンボルです。

~~~lisp
(defparameter my-plist (list :foo "foo" :bar "bar"))
~~~

plist はハッシュテーブルのようなキー値ストアです。ただし、ハッシュテーブルとは異なります。

- plist は同じキーを 2 回格納できます。そのため、キュー（"Last In First Out"）として使えます。下記を読んでください。
- plist は本質的に（連結）リストであり、同じ性能特性を持ちます。小さくないデータセットにはハッシュテーブルを使ってください。
  - plist は、設定変数、ユーザー設定、関数引数の操作、小さな内部データ構造には問題ありません。
- 文字列をキーとして実用的に使うことはできません。

キーは他の任意のオブジェクトでもかまいませんが、文字列のように `eq`
（最も低レベルの等価性関数）で比較できない場合（文字列は `equal` や
`string-equal` で比較できます）、`getf` で取り出せません。

より正確には、plist はまず `car` がキーである cons セルを持ち、その `cdr` は
`car` が値である次の cons セルを指します。たとえば上の plist は次のようになります。

```
[o|o]---[o|o]---[o|o]---[o|/]
 |       |       |       |
:FOO     "foo"   :BAR     "bar"
```

上の例では、キーに `:foo`、`:bar` というキーワードを使いました。これはキーを定義する
最も一般的な方法にすぎません。代わりに引用されたシンボル `'foo`、`'bar` も使えますが、
慣習としては少し一般的ではありません。

キーにシンボルを使う場合、別のパッケージからそれらのキーにアクセスしたいときは、
完全修飾されたシンボル名を使う必要があることを覚えておいてください。一方、すべての
キーワードは同じパッケージに存在し、常に自分自身へ評価されます。キーワードを使う方が少し簡単です。


### plist のデータへアクセスする、plist をキューとして使う

要素には `getf` でアクセスします。

~~~lisp
(defparameter my-plist (list :foo "foo" :bar "bar"))
;; => (:FOO "foo" :BAR "bar")
(getf my-plist :foo)
;; => "foo"
~~~

`getf` に `:test` キーワードを設定することはできない点を覚えておいてください。
`getf` でキーを取得するには、キーが `eq` によって *同一* でなければなりません。
キーに文字列を使うと動作しません。

~~~lisp
(defparameter not-ok-plist (list "foo" "this-is-foo" "bar" "this-is-bar"))

;; "foo" がキーに見えても NIL が返る:
(getf not-ok-plist "foo")
;; => NIL

;; plist ではなくリストを作っていた。
~~~

plist はキューとして使えます。同じキーが 2 回ある場合、`getf` は最初のもの
（左から右へ）の値を取ります。

~~~lisp
(defparameter my-plist (list :foo "lifo" :foo "foo" :bar "bar"))
;;                           ^^           ^^ キー :foo が 2 回

(getf my-plist :foo)
;; => "lifo"
~~~


### plist から要素を削除する

plist から要素を削除するには `remf` を使います。これは plist をその場で破壊的に変更します。

~~~lisp
(defparameter my-plist (list :foo "foo" :bar "bar"))
;; => (:FOO "foo" :BAR "bar")
(remf my-plist :foo)
;; => T
my-plist
;; => (:bar "bar")
~~~

### plist に要素を追加する

plist に要素を追加するには `list*` と `append` を使えます。これらは破壊的では
*ありません*。元の plist をその場で変更しません。

`list*` を使うと、先頭に要素を追加します。

~~~lisp
(defparameter my-plist (list :foo "foo" :bar "bar"))

(list* :baz "baz" my-plist)
;; => (:BAZ "baz" :FOO "foo" :BAR "bar")

my-plist
;; => (:FOO "foo" :BAR "bar")
;;    元の plist は変更されていない。
~~~

`append` を使うと、末尾に要素を追加します。

~~~lisp
(defparameter my-plist (list :foo "foo" :bar "bar"))
(append my-plist '(:baz "baz"))
;; => (:FOO "foo" :BAR "bar" :BAZ "baz")

my-plist
;; => (:FOO "foo" :BAR "bar")
;;    元の plist は変更されていない。
~~~

plist を変更したい場合は `(setf my-plist (append …))` を使います。


### plist の要素を設定する

もちろん、`getf` で得た place を `setf` できます。この場合、`list*` や `append` と異なり、
`setf` は plist をその場で更新します。

~~~lisp
(defparameter my-plist (list :foo "foo" :bar "bar"))
;; => (:FOO "foo" :BAR "bar")

(getf my-plist :foo)
;; => "foo"

(setf (getf my-plist :foo) "foo!!!")
;; => "foo!!!"

my-plist
;; => (:FOO "foo!!!" :BAR "bar")
~~~

## 構造体

構造体は、名前付きスロットにデータを格納する方法を提供します。単一継承をサポートします。

Common Lisp Object System (CLOS) が提供するクラスの方が柔軟ですが、構造体はより良い性能を提供する場合があります（たとえば SBCL マニュアルを参照）。

### 作成

`defstruct` を使います。

~~~lisp
(defstruct person
   id name age)
~~~

作成時、スロットは省略可能で、デフォルトは `nil` です。

デフォルト値を設定するには:

~~~lisp
(defstruct person
   id
   (name "john doe")
   age)
~~~

デフォルト値の後に型も指定します。

~~~lisp
(defstruct person
  id
  (name "john doe" :type string)
  age)
~~~

生成されたコンストラクタ `make-` + `<structure-name>`、つまり `make-person` でインスタンスを作成します。

~~~lisp
(defparameter *me* (make-person))
*me*
#S(PERSON :ID NIL :NAME "john doe" :AGE NIL)
~~~

印字表現はリーダで読み戻せることに注意してください。

不正な name 型を使うと:

~~~lisp
(defparameter *bad-name* (make-person :name 123))
~~~

```
Invalid initialization argument:
  :NAME
in call for class #<STRUCTURE-CLASS PERSON>.
   [Condition of type SB-PCL::INITARG-ERROR]
```

構造体のコンストラクタを設定して、キーワード引数を使わずに構造体を作成できます。
これは場合によってより便利です。名前と引数の順序を与えます。

~~~lisp
(defstruct (person (:constructor create-person (id name age)))
     id
     name
     age)
~~~

新しいコンストラクタは `create-person` です。

~~~lisp
(create-person 1 "me" 7)
#S(PERSON :ID 1 :NAME "me" :AGE 7)
~~~

しかし、デフォルトの `make-person` はもう動作しません。

~~~lisp
(make-person :name "me")
;; debugger:
obsolete structure error for a structure of type PERSON
[Condition of type SB-PCL::OBSOLETE-STRUCTURE]
~~~



### スロットアクセス

`<name-of-the-struct>-` + `slot-name` によって作成されたアクセサでスロットにアクセスします。

~~~lisp
(person-name *me*)
;; "john doe"
~~~

同様に `person-age` と `person-id` もあります。

### 設定

スロットは `setf` 可能です。

~~~lisp
(setf (person-name *me*) "Cookbook author")
(person-name *me*)
;; "Cookbook author"
~~~

### 述語

述語関数が生成されます。

~~~lisp
(person-p *me*)
T
~~~

### 単一継承

`:include <struct>` 引数を使って単一継承を行います。

~~~lisp
(defstruct (female (:include person))
     (gender "female" :type string))
(make-female :name "Lilie")
;; #S(FEMALE :ID NIL :NAME "Lilie" :AGE NIL :GENDER "female")
~~~

CLOS オブジェクトシステムの方が強力であることに注意してください。

### symbol-macrolet による短いスロットアクセス

1 つの関数内で複数のスロットにアクセスする場合、特殊フォーム `symbol-macrolet` は、
構造体アクセサを持つフォームへ展開されるシンボルマクロを作成することで可読性を改善できます。

~~~lisp
(defstruct ship x-position y-position x-velocity y-velocity)

(defun move-ship (ship)
  (symbol-macrolet
      ((x (ship-x-position ship))
       (y (ship-y-position ship))
       (xv (ship-x-velocity ship))
       (yv (ship-y-velocity ship)))
    (psetf x (+ x xv)
           y (+ y yv))
    ship))
~~~

ここでは、アクセサ関数を使う場合よりも `move-ship` 関数内の計算が読みやすくなっています。

`symbol-macrolet` なしでは次のようになります。

~~~lisp
(defun move-ship (ship)
  (psetf (ship-x-position ship)
           (+ (ship-x-position ship) (ship-x-velocity ship))
         (ship-y-position ship)
           (+ (ship-y-position ship) (ship-y-velocity ship)))
   ship)
~~~

この関数ではすべてのアクセサがそれほど読みにくいわけではありませんが、より複雑な操作ではすぐに煩雑になります。

では、この関数を試してみましょう。

~~~lisp
(move-ship (make-ship :x-position 1 :y-position 1 :x-velocity 2 :y-velocity 2))
;; #S(SHIP :X-POSITION 3 :Y-POSITION 3 :X-VELOCITY 2 :Y-VELOCITY 2)
~~~

### 構造体と `with-slots`

標準には記載されていませんが、Common Lisp の多くの現代的な実装では、CLOS マクロ
`with-slots` を構造体とともに使うことが許されています。標準では `with-slots` 自体が
`symbol-macrolet` を使って定義されています。少なくとも SBCL と ECL はこれを受け入れます。

~~~lisp
(defstruct point x y)

(defvar p (make-point :x 2.3 :y -3.2))

(with-slots (x y) p
  (list x y))

;; => (2.3 -3.2)
~~~

ただし、標準では上記のように構造体に `with-slots` を使う動作は
"unspecified" と呼ばれている点に注意してください。

### 制限

変更後、インスタンスは更新されません。

スロット（以下の `email`）を追加しようとすると、すべてのインスタンスを失うか、
`person` の新しい定義を使い続けるかを選ぶことになります。しかし、構造体の再定義の
影響は標準では未定義なので、変更したコードを再コンパイルして再実行するのが最善です。

~~~lisp
(defstruct person
       id
       (name "john doe" :type string)
       age
       email)
~~~

エラーが発生し、デバッガに入ります。

~~~
attempt to redefine the STRUCTURE-OBJECT class PERSON
incompatibly with the current definition
   [Condition of type SIMPLE-ERROR]

Restarts:
 0: [CONTINUE] Use the new definition of PERSON, invalidating already-loaded code and instances.
 1: [RECKLESSLY-CONTINUE] Use the new definition of PERSON as if it were compatible, allowing old accessors to use new instances and allowing new accessors to use old instances.
 2: [CLOBBER-IT] (deprecated synonym for RECKLESSLY-CONTINUE)
 3: [RETRY] Retry SLIME REPL evaluation request.
 4: [*ABORT] Return to SLIME's top level.
 5: [ABORT] abort thread (#<THREAD "repl-thread" RUNNING {1002A0FFA3}>)
~~~

新しい定義を使うために restart `0` を選ぶと、`*me*` へアクセスできなくなります。

~~~lisp
*me*
obsolete structure error for a structure of type PERSON
   [Condition of type SB-PCL::OBSOLETE-STRUCTURE]
~~~

イントロスペクションもごくわずかです。移植可能な Common Lisp は、定義された
super/sub-structures や構造体が持つスロットを調べる方法を定義していません。

後から言語に入った Common Lisp Object System にはそのような制限はありません。
[CLOS section][Fundamentals of CLOS] を参照してください。

* [HyperSpec の structures](http://www.lispworks.com/documentation/HyperSpec/Body/08_.htm)
* David B. Lamkins, ["Successful Lisp, How to Understand and Use Common Lisp"](http://www.communitypicks.com/r/lisp/s/17592186045679-successful-lisp-how-to-understand-and-use-common).

## ツリー

### 組み込み

ツリーはリストのリストで構築できます。

たとえば、ネストしたリスト `'(A (B) (C (D) (E)))` は次のツリーを表します。

```
   A
   ├─ B
   ╰─ C
      ├─ D
      ╰─ E
```

ここで `(B)`、`(D)`、`(E)` は葉ノードです。

関数 `tree-equal` と `copy-tree` は、訪問する cons セルの car と cdr へ再帰的に降りていきます。

ツリー内の要素を置換するには、上記の関数 `subst` と `sublis` を参照してください。

## FSet - 不変な関数型データ構造

不変データ構造を使うには、**FSet** ライブラリ（Quicklisp 内）とその優れたドキュメントを見てみるとよいでしょう。

     (ql:quickload "fset")

FSet は次のコレクションを提供します。

- `maps`、つまりハッシュテーブル
- `seqs`、つまりシーケンス
- `sets`、つまり「重複のない値の順序なしコレクション」
- `bags` または multiset、つまりメンバーが bag 内に何回出現するかを数える集合
- さらに "replay sets and maps"、"binary relations"、"tuples"、"interval sets"（範囲）、"bounded sets"、厳密な（弱）順序を持つ同様のコレクション。

高水準の概念的背景、チュートリアル、API リファレンス、他のエコシステムの関数型データ構造との比較を含む
[優れたドキュメント](https://fset.common-lisp.dev/Modern-CL/Top_html/index.html) から読み始められます。

- FSet のホームと issue tracker: https://gitlab.common-lisp.net/fset/fset/

## Sycamore - 純粋関数型の重み平衡二分木

Common Lisp 向けのもう 1 つの高速な純粋関数型データ構造ライブラリは
[Sycamore](https://github.com/ndantam/sycamore) です。

機能:

- 高速で純粋関数型の **Hash Array Mapped Tries** ([HAMT](https://en.wikipedia.org/wiki/Hash_array_mapped_trie)).
* 高速で純粋関数型の重み平衡 **binary trees**。
* ツリー **sets** と **maps**（ハッシュテーブル）のインターフェイス。
* [ropes](http://en.wikipedia.org/wiki/Rope_(data_structure))
* 純粋関数型の [pairing **heaps**](http://en.wikipedia.org/wiki/Pairing_heap)
* 純粋関数型の償却 **queues**。


## 印字するデータ量を制御する (`*print-length*`, `*print-level*`)

`*print-length*` と `*print-level*` を使います。

どちらもデフォルトでは `nil` です。

非常に大きなリストがある場合、それを REPL やスタックトレースで印字すると長い時間がかかり、
エディタやサーバーさえ止めてしまう可能性があります。`*print-length*` を使って印字する
リスト要素の最大数を選び、残りがあることを `...` プレースホルダで示します。

~~~lisp
(setf *print-length* 2)
(list :A :B :C :D :E)
;; (:A :B ...)
~~~

非常に深くネストしたデータ構造がある場合は、`*print-level*` を設定して印字する深さを選びます。

~~~lisp
(let ((*print-level* 2))
  (print '(:a (:b (:c (:d :e))))))
;; (:A (:B #))             <= *print-level* が効いている
;; (:A (:B (:C (:D :E))))
;; => リストが返される。
;; let 束縛はもう有効ではない。
~~~

`*print-length*` は各レベルで適用されます。

参考: [HyperSpec](http://clhs.lisp.se/Body/v_pr_lev.htm)。

## 付録 A - どの関数が破壊的で、どの関数がそうでないか

破壊的関数は与えられた引数を変更します。たとえば、関数 `nreverse` は破壊的です。

```lisp
(defparameter *hello* "hello")

(defun greet (s)
   (print (nreverse s)))

(greet *hello*)
;; => "olleh"

;; *hello* は今どうなっているか?
(print *hello*)
;; => "olleh"
;;
;; おっと、トップレベル変数が副作用で変更された。これは（まったく）良い習慣ではない。
```

どの関数が破壊的か、どうやって分かるでしょうか。

- すべての `n`something 関数は破壊的です: `nreverse`、
  `nsubstitute` など。"n" は "non-consing" を意味し、その関数が新しい cons セルを
  割り当てない（メモリ内に新しいオブジェクトを作らない）ことを表します。そのため、
  元のシーケンスを再利用し、その場で変更する可能性があります。
  - `nstring-upcase`, `nstring-downcase`, `nstring-capitalize`
  - `nunion`, `nintersection`, `nset-difference`, `nset-exclusive-or`
  - `nbutlast`
  - `nsubst[-if, -if-not]`, `nsublis`,  `nsubstitue[-if, -if-not]`
  - 各 `n`-something 関数には非破壊版があり、そちらを使うことを優先すべきです。
- `sort` と `stable-sort` は破壊的関数で、`merge` も同様です。そのため、これらを呼ぶ前に `copy-list` または `copy-seq` を使うのがベストプラクティスです。
- `delete[-*]` 関数は破壊的です（`remove` は破壊的ではありません）
- `(setf (nth ... ...) ...)` は明らかに破壊的です。
- `replace`、`fill` は破壊的です
- `vector-push` は破壊的である *可能性があります*
- `remprop`, `remf`
- `map-into`

また:

- `pop`, `push`: cons を変更しないという意味では破壊的ではありませんが、pop または push する place の car を変更します。


## 付録 B - alist、plist、ハッシュテーブル、CLOS スロットへの汎用的かつネストしたアクセス

以下に示す解決策は始める助けになるかもしれませんが、性能への影響があり、エラーメッセージが
あまり明示的でなくなることを覚えておいてください。

* [access](https://github.com/AccelerationNet/access) ライブラリ（実戦で試されており、Djula テンプレートシステムで使われています）には、汎用的な `(access my-var :elt)` があります（[blog post](https://lisp-journey.gitlab.io/blog/generice-consistent-access-of-data-structures-dotted-path/)）。ネストした値にアクセスして設定するための `accesses`（複数形）もあります。
* [rutils](https://github.com/vseloved/rutils) には汎用的な `generic-elt` または `?` があります。

## 付録 C - ネストしたデータ構造へのアクセス

ネストしたデータ構造を扱うことがあります。そのとき、入り組んだ "getf" や "assoc" などよりも
簡単にネストした要素へアクセスする方法が欲しくなるかもしれません。また、中間のキーが存在しない場合に
単に `nil` が返ってほしいこともあります。

上記の `access` ライブラリは、`(accesses var key1 key2…)` でこれを提供します。

## 付録 D - コレクション型階層

*実線のノードは具象型で、破線のノードは型エイリアスです。たとえば、`'string` は任意サイズの文字配列 `(array character (*))` のエイリアスです。*




![](collections.png)
   

## 関連項目

* [Pretty Printer](https://cl-community-spec.github.io/pages/Examples-of-using-the-Pretty-Printer.html#Examples-of-using-the-Pretty-Printer): `*print-length*`, `*print-right-margin*`, `pprint-tabular` など。
 
#  文字列 {#chapter-strings}
 

Common Lisp の文字列についてまず知っておくべきなのは、文字列は配列であり、したがってシーケンスでもあるという点です。つまり、配列やシーケンスに適用できる概念はすべて文字列にも当てはまります。特定の文字列関数が見つからないときは、より一般的な [配列関数やシーケンス関数](http://www.gigamonkeys.com/book/collections.html) も探してください。ここでは、文字列に対して、そして文字列に対してできることの一部だけを扱います。

ほとんどの Common Lisp 実装に含まれる ASDF3 には、[Utilities for Implementation- and OS- Portability (UIOP)](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/README.md) も含まれています。UIOP には文字列を扱う関数（`strcat`、`string-prefix-p`、`string-enclosed-p`、`first-char`、`last-char`、`split-string`、`stripln`）があります。

Quicklisp で使える外部ライブラリには、さらに機能を増やしたり、短く書けたりするものがあります。

- [str](https://github.com/vindarel/cl-str) は `trim`、`words`、`unwords`、`lines`、`unlines`、`concat`、`split`、`shorten`、`repeat`、`replace-all`、`starts-with-p`、`ends-with-p`、`blankp`、`emptyp` などを定義します。
- [Serapeum](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#strings) は、文字列操作関数を多数含む大きなユーティリティ集です。
- [cl-change-case](https://github.com/rudolfochrist/cl-change-case) には、文字列を camelCase、param-case、snake_case などへ変換する関数があります。これらは `str` にも含まれています。
- [mk-string-metrics](https://github.com/cbaggers/mk-string-metrics) には、さまざまな文字列メトリクス（Damerau-Levenshtein、Hamming、Jaro、Jaro-Winkler、Levenshtein など）を効率よく計算する関数があります。
- `cl-ppcre` も便利です。たとえば `ppcre:replace-regexp-all` があります。[正規表現](#chapter-regexp) の節も参照してください。


最後に、`format` 構文に取り組むときは、次の資料を見逃さないでください。

* 公式の [CLHS ドキュメント](http://www.lispworks.com/documentation/HyperSpec/Body/22_c.htm)
* [クイックリファレンス](http://clqr.boundp.org/)
* [HexstreamSoft の CLHS 要約](https://www.hexstreamsoft.com/articles/common-lisp-format-reference/clhs-summary/#subsections-summary-table)
* この文書の末尾にある format ディレクティブ一覧
* Slime のヒントとして、`C-c C-d ~` のあとに format ディレクティブの文字を入力すると、そのドキュメントを開けます。TAB 補完で一覧できます。これも `ivy-mode` や `helm-mode` だとより便利です。

## 文字列を作る

文字列はダブルクォートで作れますが、ほかにも次の方法があります。

- `format nil` を使うと *出力せず* に新しい文字列を返します（`format` の例は後ろに出ます）。

~~~lisp
(defparameter *person* "you")
(format nil "hello ~a" *person*) ;; => "hello you"
~~~

- `make-string count` は指定した長さの文字列を作ります。`:initial-element` で指定した文字は `count` 回繰り返されます。

~~~lisp
(make-string 3 :initial-element #\♥) ;; => "♥♥♥"
~~~


## 部分文字列へアクセスする

文字列はシーケンスなので、`subseq` 関数で部分文字列へアクセスできます。文字列のインデックスは、いつも通り 0 始まりです。3 番目のオプション引数は、部分文字列に含まれない最初の文字のインデックスであり、部分文字列の長さではありません。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (subseq *my-string* 8)
"Marx"
CL-USER> (subseq *my-string* 0 7)
"Groucho"
CL-USER> (subseq *my-string* 1 5)
"rouc"
~~~

`subseq` を `setf` と組み合わせれば、部分文字列を変更することもできます。

~~~lisp
CL-USER> (defparameter *my-string* (string "Harpo Marx"))
*MY-STRING*
CL-USER> (subseq *my-string* 0 5)
"Harpo"
CL-USER> (setf (subseq *my-string* 0 5) "Chico")
"Chico"
CL-USER> *my-string*
"Chico Marx"
~~~

ただし、文字列は "stretchable" ではありません。HyperSpec には次のようにあります。 "部分シーケンスと新しいシーケンスの長さが等しくない場合、短いほうの長さが置換される要素数を決める"。例を示します。

~~~lisp
CL-USER> (defparameter *my-string* (string "Karl Marx"))
*MY-STRING*
CL-USER> (subseq *my-string* 0 4)
"Karl"
CL-USER> (setf (subseq *my-string* 0 4) "Harpo")
"Harpo"
CL-USER> *my-string*
"Harp Marx"
CL-USER> (subseq *my-string* 4)
" Marx"
CL-USER> (setf (subseq *my-string* 4) "o Marx")
"o Marx"
CL-USER> *my-string*
"Harpo Mar"
~~~

## 個々の文字へアクセスする

`char` 関数で、文字列の個々の文字へアクセスできます。`char` は `setf` とも一緒に使えます。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (char *my-string* 11)
#\x
CL-USER> (char *my-string* 7)
#\Space
CL-USER> (char *my-string* 6)
#\o
CL-USER> (setf (char *my-string* 6) #\y)
#\y
CL-USER> *my-string*
"Grouchy Marx"
~~~

`schar` もあります。効率が重要なら、適切な場面では `schar` のほうが少し速いことがあります。

文字列は配列であり、したがってシーケンスでもあるので、より一般的な `aref` や `elt` も使えます（`char` のほうが効率的に実装されていることもありますが）。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (aref *my-string* 3)
#\u
CL-USER> (elt *my-string* 8)
#\M
~~~

文字列中の各文字には整数コードがあります。認識できるコードの範囲や Lisp がそれを表示できるかどうかは、実装の文字セット対応、たとえば ISO-8859-1 や Unicode に直接関係します。以下は SBCL での UTF-8 の例です。UTF-8 は文字を 1 〜 4 バイトで表します。最初の例は先頭 128 文字の外にある文字、つまり通常のラテン文字集合の外にある文字を示します。2 番目の例は、255 を超える多バイト符号化を示します。Lisp reader が文字名で往復できる点にも注目してください。

~~~lisp
CL-USER> (stream-external-format *standard-output*)

:UTF-8
CL-USER> (code-char 200)

#\LATIN_CAPITAL_LETTER_E_WITH_GRAVE
CL-USER> (char-code #\LATIN_CAPITAL_LETTER_E_WITH_GRAVE)

200
CL-USER> (code-char 2048)
#\SAMARITAN_LETTER_ALAF

CL-USER> (char-code #\SAMARITAN_LETTER_ALAF)
2048
~~~

対応する文字の範囲と符号化については、UTF-8 の Wikipedia 記事を参照してください。

## 文字列から文字を削除・置換する

文字列を操作できる（シーケンス）関数はたくさんあります。ここでは例だけ示します。詳しくは HyperSpec のシーケンス辞書を見てください。

文字列から 1 文字を `remove` します。

~~~lisp
CL-USER> (remove #\o "Harpo Marx")
"Harp Marx"
CL-USER> (remove #\a "Harpo Marx")
"Hrpo Mrx"
CL-USER> (remove #\a "Harpo Marx" :start 2)
"Harpo Mrx"
CL-USER> (remove-if #'upper-case-p "Harpo Marx")
"arpo arx"
~~~

1 文字の置換には、`substitute`（非破壊的）か `replace`（破壊的）を使えます。

~~~lisp
CL-USER> (substitute #\u #\o "Groucho Marx")
"Gruuchu Marx"
CL-USER> (substitute-if #\_ #'upper-case-p "Groucho Marx")
"_roucho _arx"
CL-USER> (defparameter *my-string* (string "Zeppo Marx"))
*MY-STRING*
CL-USER> (replace *my-string* "Harpo" :end1 5)
"Harpo Marx"
CL-USER> *my-string*
"Harpo Marx"
~~~


## 文字列を連結する

名前の通りです。`concatenate` が役立ちます。これは汎用シーケンス関数なので、最初の引数に結果型を指定する必要があります。

~~~lisp
CL-USER> (concatenate 'string "Karl" " " "Marx")
"Karl Marx"
CL-USER> (concatenate 'list "Karl" " " "Marx")
(#\K #\a #\r #\l #\Space #\M #\a #\r #\x)
~~~

UIOP なら `strcat` を使います。

~~~lisp
CL-USER> (uiop:strcat "karl" " " "marx")
~~~

また、`str` ライブラリなら `concat` を使います。

~~~lisp
CL-USER> (str:concat "foo" "bar")
~~~

ただし、文字列を多くの部分から組み立てるなら、`concatenate` を何度も呼ぶのは無駄に見えます。データの形に応じて、ほかにも少なくとも 3 通りのよい方法があります。1 文字ずつ文字列を作るなら、`fill-pointer` が 0 の、`character` 型のサイズ可変なベクトルにして、`vector-push-extend` を使います。こうすると、文字列のおおよその長さが分かるならシステムへヒントも渡せます（`vector-push-extend` の第 3 引数参照）。

~~~lisp
CL-USER> (defparameter *my-string* (make-array 0
                              :element-type 'character
                              :fill-pointer 0
                              :adjustable t))
*MY-STRING*
CL-USER> *my-string*
""
CL-USER> (dolist (char '(#\Z #\a #\p #\p #\a))
    (vector-push-extend char *my-string*))
NIL
CL-USER> *my-string*
"Zappa"
~~~

文字列を任意のオブジェクト（シンボル、数値、文字、文字列など）の（印字表現）から組み立てる場合は、出力ストリーム引数を `nil` にして `format` を使えます。こうすると `format` は、指定した出力を文字列として返します。

~~~lisp
CL-USER> (format nil "This is a string with a list ~A in it"
             '(1 2 3))
"This is a string with a list (1 2 3) in it"
~~~

`format` のミニ言語が持つ繰り返し構文を使えば、`concatenate` を模倣できます。

~~~lisp
CL-USER> (format nil "The Marx brothers are:~{ ~A~}."
             '("Groucho" "Harpo" "Chico" "Zeppo" "Karl"))
"The Marx brothers are: Groucho Harpo Chico Zeppo Karl."
~~~

`format` はもっと多くの処理ができますが、その構文は比較的難解です。この最後の例のあと、詳細は CLHS の整形出力に関する節で確認できます。

~~~lisp
CL-USER> (format nil "The Marx brothers are:~{ ~A~^,~}."
             '("Groucho" "Harpo" "Chico" "Zeppo" "Karl"))
"The Marx brothers are: Groucho, Harpo, Chico, Zeppo, Karl."
~~~

さまざまなオブジェクトの印字表現から文字列を作るもう 1 つの方法は、`with-output-to-string` を使うことです。この便利なマクロの値は、マクロ本体の中で文字列ストリームへ出力されたものをすべて含む文字列です。つまり、必要なら `format` の全機能も自由に使えます。

~~~lisp
CL-USER> (with-output-to-string (stream)
           (dolist (char '(#\Z #\a #\p #\p #\a #\, #\Space))
             (princ char stream))
           (format stream "~S - ~S" 1940 1993))
"Zappa, 1940 - 1993"
~~~

## 文字列を 1 文字ずつ処理する

`map` 関数で、文字列を 1 文字ずつ処理できます。

~~~lisp
CL-USER> (defparameter *my-string* (string "Groucho Marx"))
*MY-STRING*
CL-USER> (map 'string (lambda (c) (print c)) *my-string*)
#\G
#\r
#\o
#\u
#\c
#\h
#\o
#\Space
#\M
#\a
#\r
#\x
"Groucho Marx"
~~~

`loop` を使ってもできます。

~~~lisp
CL-USER> (loop for char across "Zeppo"
               collect char)
(#\Z #\e #\p #\p #\o)
~~~

## 文字列を文字ごと・単語ごとに逆順にする

文字ごとに逆順にするのは、組み込みの `reverse` 関数（または破壊的版の `nreverse`）で簡単です。

~~~lisp
CL-USER> (defparameter *my-string* (string "DSL"))
*MY-STRING*
CL-USER> (reverse *my-string*)
"LSD"
~~~

単語ごとに逆順にするワンライナーは、CL にはありません。Perl のように split と join で済ませるわけにはいきません。`split-sequence` のような外部ライブラリを使うか、自分で実装する必要があります。

`str` ライブラリを使った例です。

~~~lisp
CL-USER> (defparameter *singing* "singing in the rain")
*SINGING*
CL-USER> (str:words *SINGING*)
("singing" "in" "the" "rain")
CL-USER> (reverse *)
("rain" "the" "in" "singing")
CL-USER> (str:unwords *)
"rain the in singing"
~~~

外部依存なしの別解もあります。

~~~lisp
CL-USER> (defun split-by-one-space (string)
    "Returns a list of substrings of string
    divided by ONE space each.
    Note: Two consecutive spaces will be seen as
    if there were an empty string between them."
    (loop for i = 0 then (1+ j)
          as j = (position #\Space string :start i)
          collect (subseq string i j)
          while j))
SPLIT-BY-ONE-SPACE
CL-USER> (split-by-one-space "Singing in the rain")
("Singing" "in" "the" "rain")
CL-USER> (split-by-one-space "Singing in the  rain")
("Singing" "in" "the" "" "rain")
CL-USER> (split-by-one-space "Cool")
("Cool")
CL-USER> (split-by-one-space " Cool ")
("" "Cool" "")
CL-USER> (defun join-string-list (string-list)
    "Concatenates a list of strings
and puts spaces between the elements."
    (format nil "~{~A~^ ~}" string-list))
JOIN-STRING-LIST
CL-USER> (join-string-list '("We" "want" "better" "examples"))
"We want better examples"
CL-USER> (join-string-list '("Really"))
"Really"
CL-USER> (join-string-list '())
""
CL-USER> (join-string-list
          (nreverse
           (split-by-one-space
            "Reverse this sentence by word")))
"word by sentence this Reverse"
~~~

## Unicode 文字列を扱う

ここでは [SBCL の文字列操作](http://www.sbcl.org/manual/index.html#String-operations) を使います。より一般には、[SBCL の Unicode サポート](http://www.sbcl.org/manual/index.html#Unicode-Support) を参照してください。


### Unicode 文字列をアルファベット順に並べる

比較関数に `string-lessp` を使って Unicode 文字列を並べるのは、期待どおりではありません。

~~~lisp
CL-USER> (sort '("Aaa" "Ééé" "Zzz") #'string-lessp)
("Aaa" "Zzz" "Ééé")
~~~

[SBCL](http://www.sbcl.org/manual/#String-operations) では `sb-unicode:unicode<` を使います。

~~~lisp
CL-USER> (sort '("Aaa" "Ééé" "Zzz") #'sb-unicode:unicode<)
("Aaa" "Ééé" "Zzz")
~~~

### 文字列をグラフェム・文・行・単語に分割する

これらの関数は SBCL の [`sb-unicode`](http://www.sbcl.org/manual/#String-operations) を使います。SBCL 専用です。

`sb-unicode:sentences` を使うと、既定の文分割規則に従って文字列を文に分けられます。

`sb-unicode:lines` を使うと、`:margin` キーワード引数で指定した幅を超えない行に分割できます。結合文字は常に基底文字と一緒に保たれ、行末のスペース（ただし他の空白は除く）は削除されます。`:margin` を指定しない場合、既定値は 80 文字です。

~~~lisp
CL-USER> (sb-unicode:lines "A first sentence. A second somewhat long one." :margin 10)
("A first"
 "sentence."
 "A second"
 "somewhat"
 "long one.")
~~~

`sb-unicode:words` と `sb-unicode:graphemes` も参照してください。

ヒント: フィーチャフラグを使えば、これらの関数を SBCL でだけ実行するようにできます。

    #+sbcl
    (runs on sbcl)
    #-sbcl
    (runs on other implementations)

## 大文字小文字を制御する

Common Lisp には、文字列の大文字小文字を制御する関数がいくつかあります。

~~~lisp
CL-USER> (string-upcase "cool")
"COOL"
CL-USER> (string-upcase "Cool")
"COOL"
CL-USER> (string-downcase "COOL")
"cool"
CL-USER> (string-downcase "Cool")
"cool"
CL-USER> (string-capitalize "cool")
"Cool"
CL-USER> (string-capitalize "cool example")
"Cool Example"
~~~

これらの関数は `:start` と `:end` キーワード引数を取るので、文字列の一部だけを操作することもできます。先頭に `N` が付いた破壊的版もあります。

~~~lisp
CL-USER> (string-capitalize "cool example" :start 5)
"cool Example"
CL-USER> (string-capitalize "cool example" :end 5)
"Cool example"
CL-USER> (defparameter *my-string* (string "BIG"))
*MY-STRING*
CL-USER> (defparameter *my-downcase-string* (nstring-downcase *my-string*))
*MY-DOWNCASE-STRING*
CL-USER> *my-downcase-string*
"big"
CL-USER> *my-string*
"big"
~~~

次の点に注意してください。HyperSpec によると、

> STRING-UPCASE、STRING-DOWNCASE、STRING-CAPITALIZE は文字列を変更しません。ただし、変換が必要な文字がない場合、処理系の裁量により、結果は元の文字列またはそのコピーのどちらかになります。

このため、次の例の最後の結果は実装依存です。"BIG" になるか "BUG" になるかは実装次第です。確実にしたいなら `copy-seq` を使ってください。

~~~lisp
CL-USER> (defparameter *my-string* (string "BIG"))
*MY-STRING*
CL-USER> (defparameter *my-upcase-string* (string-upcase *my-string*))
*MY-UPCASE-STRING*
CL-USER> (setf (char *my-string* 1) #\U)
#\U
CL-USER> *my-string*
"BUG"
CL-USER> *my-upcase-string*
"BIG"
~~~

### `format` 関数を使う

`format` 関数には、単語の大文字小文字を変えるディレクティブがあります。

#### 小文字にする: `~( ~)`

~~~lisp
CL-USER> (format t "~(~a~)" "HELLO WORLD")
hello world
~~~


#### 各単語の先頭を大文字にする: `~:( ~)`

~~~lisp
CL-USER> (format t "~:(~a~)" "HELLO WORLD")
Hello World
NIL
~~~

#### 最初の単語だけ先頭を大文字にする: `~@( ~)`

~~~lisp
CL-USER> (format t "~@(~a~)" "hello world")
Hello world
NIL
~~~

#### 大文字にする: `~@:( ~)`

ここではコロンと `@` を再利用しています。

~~~lisp
CL-USER> (format t "~@:(~a~)" "hello world")
HELLO WORLD
NIL
~~~


## 文字列の両端から空白を取り除く

空白だけでなく、任意の文字を取り除くこともできます。`string-trim`、`string-left-trim`、`string-right-trim` は、第 2 引数の部分文字列を返し、第 1 引数に含まれる文字を先頭や末尾から削除します。第 1 引数には任意の文字シーケンスを渡せます。

~~~lisp
CL-USER> (string-trim " " " trim me ")
"trim me"
CL-USER> (string-trim " et" " trim me ")
"rim m"
CL-USER> (string-left-trim " et" " trim me ")
"rim me "
CL-USER> (string-right-trim " et" " trim me ")
" trim m"
CL-USER> (string-right-trim '(#\Space #\e #\t) " trim me ")
" trim m"
CL-USER> (string-right-trim '(#\Space #\e #\t #\m) " trim me ")
~~~

注意: 先ほどの大文字小文字の節で述べた注意点は、ここにも当てはまります。

## シンボルと文字列を相互変換する

`intern` 関数は、文字列をシンボルに "変換" します。正確には、その文字列（第 1 引数）が表すシンボルが、パッケージ（第 2 引数。省略時は現在のパッケージ）ですでに参照可能かどうかを調べ、必要ならそのパッケージに登録します。ここでは関連する概念や、この関数の第 2 戻り値まで説明しません。詳しくは CLHS のパッケージの章を参照してください。

文字列の大文字小文字が重要である点に注意してください。

~~~lisp
CL-USER> (in-package "COMMON-LISP-USER")
#<The COMMON-LISP-USER package, 35/44 internal, 0/9 external>
CL-USER> (intern "MY-SYMBOL")
MY-SYMBOL
NIL
CL-USER> (intern "MY-SYMBOL")
MY-SYMBOL
:INTERNAL
CL-USER> (export 'MY-SYMBOL)
T
CL-USER> (intern "MY-SYMBOL")
MY-SYMBOL
:EXTERNAL
CL-USER> (intern "My-Symbol")
|My-Symbol|
NIL
CL-USER> (intern "MY-SYMBOL" "KEYWORD")
:MY-SYMBOL
NIL
CL-USER> (intern "MY-SYMBOL" "KEYWORD")
:MY-SYMBOL
:EXTERNAL
~~~

逆に、シンボルから文字列へ変換するには `symbol-name` か `string` を使います。

~~~lisp
CL-USER> (symbol-name 'MY-SYMBOL)
"MY-SYMBOL"
CL-USER> (symbol-name 'my-symbol)
"MY-SYMBOL"
CL-USER> (symbol-name '|my-symbol|)
"my-symbol"
CL-USER> (string 'howdy)
"HOWDY"
~~~

## 文字と文字列を相互変換する

`coerce` を使えば、長さ 1 の文字列を文字に変換できます。文字のシーケンスを文字列へ変換することもできます。ただし、文字を文字列にするには `coerce` は使えません。その場合は `string` を使います。

~~~lisp
CL-USER> (coerce "a" 'character)
#\a
CL-USER> (coerce (subseq "cool" 2 3) 'character)
#\o
CL-USER> (coerce "cool" 'list)
(#\c #\o #\o #\l)
CL-USER> (coerce '(#\h #\e #\y) 'string)
"hey"
CL-USER> (coerce (nth 2 '(#\h #\e #\y)) 'character)
#\y
CL-USER> (defparameter *my-array* (make-array 5 :initial-element #\x))
*MY-ARRAY*
CL-USER> *my-array*
#(#\x #\x #\x #\x #\x)
CL-USER> (coerce *my-array* 'string)
"xxxxx"
CL-USER> (string 'howdy)
"HOWDY"
CL-USER> (string #\y)
"y"
CL-USER> (coerce #\y 'string)
#\y can't be converted to type STRING.
   [Condition of type SIMPLE-TYPE-ERROR]
~~~

## 文字列の要素を探す

`find`、`position`、およびそれぞれの `…-if` 系を使って、適切な `:test` パラメータ付きで文字列内の文字を探せます。

~~~lisp
CL-USER> (find #\t "Tea time." :test #'equal)
#\t
CL-USER> (find #\t "Tea time." :test #'equalp)
#\T
CL-USER> (find #\z "Tea time." :test #'equalp)
NIL
CL-USER> (find-if #'digit-char-p "Tea time.")
#\1
CL-USER> (find-if #'digit-char-p "Tea time." :from-end t)
#\0

CL-USER> (position #\t "Tea time." :test #'equal)
4   ;; <= the first lowercase t
CL-USER> (position #\t "Tea time." :test #'equalp)
0    ;; <= the first capital T
CL-USER> (position-if #'digit-char-p "Tea time is at 5'00.")
15
CL-USER> (position-if #'digit-char-p "Tea time is at 5'00." :from-end t)
18
~~~

あるいは `count` などを使って、文字列中の文字を数えます。

~~~lisp
CL-USER> (count #\t "Tea time." :test #'equal)
1  ;; <= equal ignores the capital T
CL-USER> (count #\t "Tea time." :test #'equalp)
2  ;; <= equalp counts the capital T
CL-USER> (count-if #'digit-char-p "Tea time is at 5'00.")
3
CL-USER> (count-if #'digit-char-p "Tea time is at 5'00." :start 18)
1
~~~

## 文字列の部分文字列を探す

`search` 関数で、文字列の部分文字列を探せます。

~~~lisp
CL-USER> (search "we" "If we can't be free we can at least be cheap")
3
CL-USER> (search "we" "If we can't be free we can at least be cheap"
          :from-end t)
20
CL-USER> (search "we" "If we can't be free we can at least be cheap"
          :start2 4)
20
CL-USER> (search "we" "If we can't be free we can at least be cheap"
          :end2 5 :from-end t)
3
CL-USER> (search "FREE" "If we can't be free we can at least be cheap")
NIL
CL-USER> (search "FREE" "If we can't be free we can at least be cheap"
          :test #'char-equal)
15
~~~

## 文字列を数値に変換する

### 整数へ: `parse-integer`

CL には、整数を表す文字列を対応する数値へ変換する `parse-integer` 関数があります。第 2 戻り値は、解析が止まった位置のインデックスです。

~~~lisp
CL-USER> (parse-integer "42")
42
2
CL-USER> (parse-integer "42" :start 1)
2
2
CL-USER> (parse-integer "42" :end 1)
4
1
CL-USER> (parse-integer "42" :radix 8)
34
2
CL-USER> (parse-integer " 42 ")
42
3
CL-USER> (parse-integer " 42 is forty-two" :junk-allowed t)
42
3
CL-USER> (parse-integer " 42 is forty-two")

Error in function PARSE-INTEGER:
   There's junk in this string: " 42 is forty-two".
~~~

`parse-integer` は `#X` のような基数指定を理解しませんし、他の数値型を解析する組み込み関数もありません。その場合は `read-from-string` を使えます。

### 文字列から複数の整数を取り出す: `ppcre:all-matches-as-strings`

これは正規表現の章でも紹介しますが、この話題のついでに挙げておくと、とても便利です。

~~~lisp
CL-USER> (ppcre:all-matches-as-strings "-?\\d+" "42 is 41 plus 1")
;; ("42" "41" "1")

CL-USER> (mapcar #'parse-integer *)
;; (42 41 1)
~~~

### 任意の数値へ: `read-from-string`

この関数を使うと完全な reader が有効になる点に注意してください。脆弱性の原因になり得ます。代わりに `parse-number` や `parse-float` のようなライブラリを使うべきです。

~~~lisp
CL-USER> (read-from-string "#X23")
35
4
CL-USER> (read-from-string "4.5")
4.5
3
CL-USER> (read-from-string "6/8")
3/4
3
CL-USER> (read-from-string "#C(6/8 1)")
#C(3/4 1)
9
CL-USER> (read-from-string "1.2e2")
120.00001
5
CL-USER> (read-from-string "symbol")
SYMBOL
6
CL-USER> (defparameter *foo* 42)
*FOO*
CL-USER> (read-from-string "#.(setq *foo* \"gotcha\")")
"gotcha"
23
CL-USER> *foo*
"gotcha"
~~~

### `read-from-string` を安全に使う

少なくとも、外部から来たデータを読むなら、次のようにします。

~~~lisp
(let ((cl:*read-eval* nil))
  (read-from-string "…"))
~~~

これで read 時にコードが評価されるのを防げます。これにより、最後の `#.` reader マクロの例は動かなくなります。"can't read #. while *READ-EVAL* is NIL" というエラーになります。

さらに、別の reader マクロを導入するカスタム readtable からも守りたいなら、次のようにします。

~~~lisp
(with-standard-io-syntax
  (let ((cl:*read-eval* nil))
    (read-from-string "…")))
~~~


### 浮動小数へ: `parse-float` ライブラリ

`parse-integer` のように他の数値型を解析する組み込み関数はありません。外部ライブラリ [parse-float](https://github.com/soemraws/parse-float) はまさにそれを行います。`read-from-string` を使わないので、安全に使えます。

~~~lisp
CL-USER> (ql:quickload "parse-float")
CL-USER> (parse-float:parse-float "1.2e2")
120.00001
5
~~~

LispWorks にも [parse-float](http://www.lispworks.com/documentation/lw51/LWRM/html/lwref-228.htm) 関数があります。

`[parse-number](https://github.com/sharplispers/parse-number)` も参照してください。


## 数値を文字列に変換する

一般関数 `write-to-string`、またはその簡易版 `prin1-to-string` / `princ-to-string` を使うと、数値を文字列に変換できます。`write-to-string` では、`:base` キーワード引数で 1 回だけ出力基数を変えられます。全体の基数を変えるなら、既定値 10 の `*print-base*` を設定します。Lisp では、有理数は文字列化しても 2 つの整数の比として表されることを覚えておいてください。

~~~lisp
CL-USER> (write-to-string 250)
"250"
CL-USER> (write-to-string 250.02)
"250.02"
CL-USER> (write-to-string 250 :base 5)
"2000"
CL-USER> (write-to-string (/ 1 3))
"1/3"
~~~

## 文字列を比較する

一般関数 `equal` と `equalp` で、2 つの文字列が等しいかを確認できます。文字列は要素ごとに比較され、`equal` は大文字小文字を区別し、`equalp` は区別しません。ほかにも文字列専用の比較関数がたくさんあります。文字の実装依存属性を使うなら、こちらを使いたくなるでしょう。その場合は実装のドキュメントを確認してください。

例をいくつか示します。なお、不等を調べる関数はすべて、最初に一致しない位置を一般化ブールとして返します。より柔軟性が必要なら、汎用シーケンス関数 `mismatch` も使えます。

~~~lisp
CL-USER> (string= "Marx" "Marx")
T
CL-USER> (string= "Marx" "marx")
NIL
CL-USER> (string-equal "Marx" "marx")
T
CL-USER> (string< "Groucho" "Zeppo")
0
CL-USER> (string< "groucho" "Zeppo")
NIL
CL-USER> (string-lessp "groucho" "Zeppo")
0
CL-USER> (mismatch "Harpo Marx" "Zeppo Marx" :from-end t :test #'char=)
3
~~~

さらに `string/=`, `string-not-equal`, `string-not-lessp`, `string-not-greaterp` もあります。

[​]{#string-formatting-format}

## 文字列の整形: `format`

`format` 関数には、文字列、数値、リストの出力、再帰処理、Lisp 関数の呼び出しなど、たくさんのディレクティブがあります。ここでは、文字列を出力・整形するいくつかの要点に絞ります。

以下の例では、映画のリストを使います。

~~~lisp
(defparameter *movies* '(
    (1 "Matrix" 5)
    (10 "Matrix Trilogy swe sub" 3.3)))
~~~


### `format` の構造

format ディレクティブは `~` で始まります。`A` や `a` のような末尾の文字（大小文字は区別しません）がディレクティブを決めます。その間に、カンマ区切りのオプションやパラメータを入れられます。さらに、一部のディレクティブはコロンやアットマークの修飾子を受け取り、挙動を変えます。たとえば `D` ディレクティブでは、コロンを付けると 3 桁ごとにカンマが入り、アットマークを付けると正の数にプラス記号が付きます。

~~~lisp
(format nil "~d" 2025)
;; => "2025"
(format nil "~:d" 2025)
;; => "2,025"
(format nil "~@d" 2025)
;; => "+2025"
(format nil "~@:d" 2025)
;; => "+2,025"
~~~

アットマーク修飾子を付けると、`R` ディレクティブは英語の基数ではなくローマ数字を出力します。

~~~lisp
(format nil "~r" 2025)
;; => "two thousand twenty-five"
(format nil "~@r" 2025)
;; => "MMXXV"
~~~

2 つの修飾子を同時に使っても意味のある解釈がない場合、結果は未定義か、別の意味になります。

チルダを出すには `~~`、10 個のチルダを出すには `~10~` を使います。

ほかのディレクティブには次のものがあります。

- `R`: ローマ数字（例: 英語で出力）: `(format t "~R" 20)` => "twenty"。
- `$`: 通貨: `(format t "~$" 21982)` => 21982.00
- `D`, `B`, `O`, `X`: 10 進、2 進、8 進、16 進。
- `F`: 固定小数点形式の浮動小数点数。
- `P`: 複数形: `(format nil "~D famil~:@P/~D famil~:@P" 7 1)` => "7 families/1 family"

### 基本プリミティブ: `~A` / `~a` (Aesthetics)

`(format t "~a" *movies*)` がもっとも基本的な使い方です。

`t` は `*standard-output*` に出力します。

~~~lisp
(format nil "~a" *movies*)
;; => "((1 Matrix 5) (10 Matrix Trilogy swe sub 3.3))"
~~~

ここで `nil` は、`format` に新しい文字列を返すよう指示します。


### 標準出力に出すか新しい文字列を返すか: `t` / `nil`

上で見たように、`(format t …)` は `*standard-output*` に出力し、`(format nil …)` は新しい文字列を返します。

では、次を見てください。

~~~lisp
(format t "~a" *movies*)
;; =>
((1 Matrix 5) (10 Matrix Trilogy swe sub 3.3))
NIL
~~~

`format` は標準出力に *出力* し、NIL を *返します*。

しかし今度は次のようになります。

~~~lisp
(format nil "~a" *movies*)
;; =>
"((1 Matrix 5) (10 Matrix Trilogy swe sub 3.3))"
~~~

`format` は文字列を返しました。


[​]{#newlines--and-}

### 改行: `~%` と `~&`

`~%` は改行文字です。`~10%` は改行を 10 個出力します。

`~&` は、出力ストリームがすでに行頭にある場合は改行を出力しません。

[​]{#tabs}

### タブ

`~T` を使います。`~10T` も使えます。

インデントには `i` も使えます。


[​]{#justifying-text--add-padding-on-the-right}

### テキストの位置揃え / 右側にパディングを足す

`~2a` のように数値をパラメータとして使います。

~~~lisp
(format nil "~20a" "yo")
;; "yo                  "
~~~

~~~lisp
(mapcar (lambda (it)
           (format t "~2a ~a ~a~%" (first it) (second it) (third it)))
         *movies*)
~~~

```
1  Matrix 5
10 Matrix Trilogy swe sub 3.3
```

さらに広げると、次のようになります。

~~~lisp
(mapcar (lambda (it)
          (format t "~2a ~25a ~2a~%" (first it) (second it) (third it)))
        *movies*)
~~~

```
1  Matrix                    5
10 Matrix Trilogy swe sub    3.3
```

テキストは右寄せされます（これはオプション `:` を使う場合です）。

[​]{#justifying-on-the-left-}

#### 左寄せ: `@`

`~2@A` のように `@` を使います。

~~~lisp
(format nil "~20@a" "yo")
;; "                  yo"
~~~

~~~lisp
(mapcar (lambda (it)
           (format nil "~2@a ~25@a ~2a~%" (first it) (second it) (third it)))
        *movies*)
~~~

```
 1                    Matrix 5
10    Matrix Trilogy swe sub 3.3
```

[​]{#justifying-decimals}

### 小数の桁揃え

`~,2F` では、2 が小数点以下の桁数で、F が浮動小数点数のディレクティブです。
`(format t "~,2F" 20.1)` => "20.10".

`~2,2f` の場合は次のようになります。

~~~lisp
(mapcar (lambda (it)
          (format t "~2@a ~25a ~2,2f~%" (first it) (second it) (third it)))
        *movies*)
~~~

```
 1 Matrix                    5.00
10 Matrix Trilogy swe sub    3.30
```

これで十分です。

### 反復

反復構文 `~{str~}` で、リストから文字列を作れます。

~~~lisp
(format nil "~{~A, ~}" '(a b c))
;; "A, B, C, "
~~~

最後の要素のあとにカンマとスペースを出さないよう、`~^` を使います。

~~~lisp
(format nil "~{~A~^, ~}" '(a b c))
;; "A, B, C"
~~~

`~:{str~}` は似ていますが、サブリストのリスト向けです。

~~~lisp
(format nil "~:{~S are ~S. ~}" '((pigeons birds) (dogs mammals)))
;; "PIGEONS are BIRDS. DOGS are MAMMALS. "
~~~

`~@{str~}` は `~{str~}` に似ていますが、1 つのリスト引数ではなく、残りの引数すべてを反復用の引数リストとして使います。

~~~lisp
(format nil "~@{~S are ~S. ~}" 'pigeons 'birds 'dogs 'mammals)
;; "PIGEONS are BIRDS. DOGS are MAMMALS. "
~~~

### format 文字列を組み立てる (`~v`, `~?`)

文字列を揃えたいけれど、幅が変数そのものになることがあります。`(format nil "~30a" "foo")` のように固定値を書くわけにはいきません。そこで `v` ディレクティブを使います。カンマ区切りの先頭パラメータの代わりに使えます。

~~~lisp
(let ((padding 30))
    (format nil "~va" padding "foo"))
;; "foo                           "
~~~

実行時に完全な format ディレクティブを差し込みたいこともあります。そこで `?` ディレクティブです。

~~~lisp
(format nil "~?" "~30a" '("foo"))
;;                       ^ a list
~~~

あるいは `~@?` を使います。

~~~lisp
(format nil "~@?" "~30a" "foo" )
;;                       ^ not a list
~~~

もちろん、あらかじめ format 文字列を組み立てることもできます。

~~~lisp
(let* ((length 30)
      (directive (format nil "~~~aa" length)))
 (format nil directive "foo"))
~~~

### 条件付き整形

数値を指定して、複数の候補から 1 つを選びます。

~~~lisp
(format nil "~[dog~;cat~;bird~:;default~]" 0)
;; "dog"

(format nil "~[dog~;cat~;bird~:;default~]" 1)
;; "cat"
~~~

数値が範囲外なら、`~:;` のあとにある既定値が返ります。

~~~lisp
(format nil "~[dog~;cat~;bird~:;default~]" 9)
;; "default"
~~~

`~:*` と組み合わせると、不規則複数形を実装できます。

~~~lisp
(format nil "I saw ~r el~:*~[ves~;f~:;ves~]." 0)
;; => "I saw zero elves."
(format nil "I saw ~r el~:*~[ves~;f~:;ves~]." 1)
;; => "I saw one elf."
(format nil "I saw ~r el~:*~[ves~;f~:;ves~]." 2)
;; => "I saw two elves."
~~~

## ストリームへ出した内容を捕捉する

`(with-output-to-string (mystream) …)` の中では、`mystream` に書き込まれたものがすべて捕捉され、文字列として返されます。

~~~lisp
(defun greet (name &key (stream t))
   ;; by default, print to standard output.
   (format stream "hello ~a" name))

(let ((output (with-output-to-string (stream)
                (greet "you" :stream stream))))
   (format t "Output is: '~a'. It is indeed a ~a, aka a string.~&" output (type-of output)))
;; Output is: 'hello you'. It is indeed a (SIMPLE-ARRAY CHARACTER (9)), aka a string.
;; NIL
~~~

## 文字列を整える

次の例では [cl-slug](https://github.com/EuAndreh/cl-slug/) ライブラリを使います。このライブラリは内部で文字列を 1 文字ずつ走査し、`ppcre:regex-replace-all` を使っています。

    (ql:quickload "cl-slug")

読み込むと `slug` プレフィックスで使えます。

主な関数は、Web サイトの URL に向いた slug へ文字列を変換することです。

~~~lisp
(slug:slugify "My new cool article, for the blog (V. 2).")
;; "my-new-cool-article-for-the-blog-v-2"
~~~

### アクセント付き文字を取り除く

`slug:asciify` を使うと、アクセント付き文字を ASCII 相当へ置き換えられます。

~~~lisp
(slug:asciify "ñ é ß ğ ö")
;; => "n e ss g o"
~~~

この関数は多くの（西洋）言語をサポートしています。

~~~
slug:*available-languages*
((:TR . "Türkçe (Turkish)") (:SV . "Svenska (Swedish)") (:FI . "Suomi (Finnish)")
 (:UK . "українська (Ukrainian)") (:RU . "Ру́сский (Russian)") (:RO . "Română (Romanian)")
 (:RM . "Rumàntsch (Romansh)") (:PT . "Português (Portuguese)") (:PL . "Polski (Polish)")
 (:NO . "Norsk (Norwegian)") (:LT . "Lietuvių (Lithuanian)") (:LV . "Latviešu (Latvian)")
 (:LA . "Lingua Latīna (Latin)") (:IT . "Italiano (Italian)") (:EL . "ελληνικά (Greek)")
 (:FR . "Français (French)") (:EO . "Esperanto") (:ES . "Español (Spanish)") (:EN . "English")
 (:DE . "Deutsch (German)") (:DA . "Dansk (Danish)") (:CS . "Čeština (Czech)")
 (:CURRENCY . "Currency"))
~~~

### 句読点を取り除く

`(str:remove-punctuation s)` または `(str:no-case s)`（`(cl-change-case:no-case s)` と同じ）を使います。

~~~lisp
(str:remove-punctuation "HEY! What's up ??")
;; "HEY What s up"

(str:no-case "HEY! What's up ??")
;; "hey what s up"
~~~

これらは 1 つの ppcre Unicode 正規表現で句読点を取り除きます（`(ppcre:regex-replace-all "[^\\p{L}\\p{N}]+"`。`p{L}` は "letter" カテゴリ、`p{N}` はあらゆる数値文字です）。

## 付録

### すべての format ディレクティブ

すべてのディレクティブは大文字小文字を区別しません。`~A` は `~a` と同じです。

```
$ - Monetary Floating-Point
% - Newline
& - Fresh-line
( - Case Conversion
) - End of Case Conversion
* - Go-To
/ - Call Function
; - Clause Separator
< - Justification
< - Logical Block
> - End of Justification
? - Recursive Processing
A - Aesthetic
B - Binary
C - Character
D - Decimal
E - Exponential Floating-Point
F - Fixed-Format Floating-Point
G - General Floating-Point
I - Indent
Missing and Additional FORMAT Arguments
Nesting of FORMAT Operations
Newline: Ignored Newline
O - Octal
P - Plural
R - Radix
S - Standard
T - Tabulate
W - Write
X - Hexadecimal
[ - Conditional Expression
] - End of Conditional Expression
^ - Escape Upward
_ - Conditional Newline
{ - Iteration
| - Page
} - End of Iteration
~ - Tilde
```

### Slime のヘルプ

* `~A` のような `format` ディレクティブを調べるには、`M-x common-lisp-hyperspec-format` を使います。これは `C-c C-d ~` に割り当てられており、TAB 補完も使えます。


## 文字列と文字の型の階層

*実線のノードは具体的な型、破線のノードは型エイリアスです。たとえば `'string` は任意サイズの文字配列、`(array character (*))` の別名です。*

<div style="text-align: center">
    <img src="string-and-chars.png" alt="String and Character Types in Common Lisp"/>
</div>


![](string-and-chars.png)
   


## 関連項目

* [Pretty Printer](https://cl-community-spec.github.io/pages/Examples-of-using-the-Pretty-Printer.html#Examples-of-using-the-Pretty-Printer): `*print-length*`、`*print-right-margin*`、`pprint-tabular` など
* [表データを整形出力する](https://gist.github.com/WetHat/a49e6f2140b401a190d45d31e052af8f) ASCII アートの Jupyter Notebook チュートリアル
 
#  数値 {#chapter-numbers}
 

Common Lisp には、integer、rational、floating point、complex など、豊富な数値型があります。

参考資料:

* Common Lisp the Language, 2nd Edition の [`Numbers`][numbers]
* [`Numbers, Characters and Strings`][numbers-characters-strings]
  (Practical Common Lisp)

## はじめに

### integer 型

Common Lisp は `bignum` と呼ばれる真の integer 型を提供します。これは machine word size ではなく、利用可能な総 memory 量だけに制限されます。たとえば次の値は 64 bit integer を大きく overflow します。

~~~lisp
* (expt 2 200)
1606938044258990275541962092341162602522202993782792835301376
~~~

効率のため、integer は固定 bit 数に制限できます。これは `fixnum` 型と呼ばれます。表現可能な integer の範囲は次で得られます。

~~~lisp
* most-positive-fixnum
4611686018427387903
* most-negative-fixnum
-4611686018427387904
~~~

integer を操作する、または integer を返す関数には次のものがあります。

* [`isqrt`][isqrt] は、自然数の正確な正の平方根以下で最大の integer を返します。

~~~lisp
* (isqrt 10)
3
* (isqrt 4)
2
~~~

* [`gcd`][gcd] は Greatest Common Denominator を求めます。
* [`lcm`][lcm] は Least Common Multiple を求めます。

他の低水準プログラミング言語と同じく、Common Lisp は 16 進数や 36 までの基数のリテラル表記を提供します。例:

~~~lisp
* #xFF
255
* #2r1010
10
* #4r33
15
* #8r11
9
* #16rFF
255
* #36rz
35
~~~

### rational 型

[`ratio`][ratio] 型の rational number は、分子と分母という 2 つの `bignum` から構成されます。そのため、どちらも任意の大きさにできます。

~~~lisp
* (/ (1+ (expt 2 100)) (expt 2 100))
1267650600228229401496703205377/1267650600228229401496703205376
~~~

これは [`integer`][integer] と同じく [`rational`][rational] クラスの subtype です。

### floating point 型

[Common Lisp the Language, 2nd Edition, section 2.1.3][book-cl-2.1.3] を参照してください。

floating point 型は、連続した real number を有限個の bit で表そうとします。つまり多くの real number は正確には表現できず、近似されます。特に 10 進表現と内部の 2 進表現を相互変換するとき、これは厄介な驚きにつながることがあります。floating point number を扱うなら、[What Every Computer Scientist Should Know About Floating-Point Arithmetic][article-floating-point-arithmetic] を読むことを強く勧めます。

Common Lisp standard は複数の floating point 型を許します。精度が低い順に `short-float`、`single-float`、`double-float`、`long-float` です。これらの精度は処理系 dependent であり、すべての型が 1 つの floating point precision だけを持つ処理系もありえます。

定数 [`short-float-epsilon`, `single-float-epsilon`, `double-float-epsilon` and `long-float-epsilon`][float-constants] は floating point 型の精度の目安を与えるもので、処理系 dependent です。

特に ECL は `long-float` を C の `long double` に基づけているため、より高い精度を持ちます。

```
CL-USER> (lisp-implementation-type)
"ECL"
CL-USER> most-positive-single-float
3.4028235e38
CL-USER> most-positive-double-float
1.7976931348623157d308
CL-USER> most-positive-long-float
1.189731495357231765l4932
```

#### floating point literal

floating point number を読むとき、default の型は special 変数 [`*read-default-float-format*`][read-default-float-format] で設定されます。default は `SINGLE-FLOAT` なので、数値を double precision として確実に読ませたい場合は末尾に `d0` suffix を付けます。

~~~lisp
* (type-of 1.24)
SINGLE-FLOAT

* (type-of 1.24d0)
DOUBLE-FLOAT
~~~

他の suffix は `s` (short)、`f` (single float)、`d` (double float)、`l` (long float)、`e` (default、通常は single float) です。

デフォルトの型は変更できますが、`single-float` 型を仮定しているパッケージを壊す可能性がある点に注意してください。

~~~lisp
* (setq *read-default-float-format* 'double-float)
* (type-of 1.24)
DOUBLE-FLOAT
~~~

一部の language と違って、数値の末尾に decimal point を 1 つ付けても float にはならない点に注意してください。

~~~lisp
* (type-of 10.)
(INTEGER 0 4611686018427387903)

* (type-of 10.0)
SINGLE-FLOAT
~~~

#### floating point error

floating point calculation の結果が大きすぎる場合、floating point overflow が発生します。[SBCL][SBCL] (および他の処理系) では default でエラーコンディションになります。

~~~lisp
* (exp 1000)
; Evaluation aborted on #<FLOATING-POINT-OVERFLOW {10041720B3}>.
~~~

このエラーは処理できます。また、この振る舞いを変更して `+infinity` を返すようにもできます。SBCL では次のようにします。

~~~lisp
* (sb-int:set-floating-point-modes :traps '(:INVALID :DIVIDE-BY-ZERO))

* (exp 1000)
#.SB-EXT:SINGLE-FLOAT-POSITIVE-INFINITY

* (/ 1 (exp 1000))
0.0
~~~

これで計算はエラーコンディションなしに静かに続行されます。

floating overflow エラーを無効にする同様の機能は [CCL][CCL] にもあります。

~~~lisp
* (set-fpu-mode :overflow nil)
~~~

SBCL では floating point mode を調べられます。

~~~lisp
* (sb-int:get-floating-point-modes)
(:TRAPS (:OVERFLOW :INVALID :DIVIDE-BY-ZERO) :ROUNDING-MODE :NEAREST
 :CURRENT-EXCEPTIONS NIL :ACCRUED-EXCEPTIONS NIL :FAST-MODE NIL)
~~~

#### 任意精度

任意の高精度計算には、QuickLisp に [computable-reals][computable-reals] ライブラリがあります。

~~~lisp
* (ql:quickload :computable-reals)
* (use-package :computable-reals)

* (sqrt-r 2)
+1.41421356237309504880...

* (sin-r (/r +pi-r+ 2))
+1.00000000000000000000...
~~~

表示する精度は `*PRINT-PREC*` で設定され、デフォルトは 20 です。

~~~lisp
* (setq *PRINT-PREC* 50)
* (sqrt-r 2)
+1.41421356237309504880168872420969807856967187537695...
~~~

### complex 型

complex number には 5 種類があります。実部と虚部は同じ型でなければならず、rational またはいずれかの floating point 型 (short、single、double、long) にできます。

complex 値は `#C` reader マクロまたは関数 [`complex`][complex] で作成できます。reader マクロでは、実部と虚部に式を使うことはできません。

~~~lisp
* #C(1 1)
#C(1 1)

* #C((+ 1 2) 5)
; Evaluation aborted on #<TYPE-ERROR expected-type: REAL datum: (+ 1 2)>.

* (complex (+ 1 2) 5)
#C(3 5)
~~~

異なる型を混ぜて構築した場合、両方の部分により高精度の型が使われます。

~~~lisp
* (type-of #C(1 1))
(COMPLEX (INTEGER 1 1))

* (type-of #C(1.0 1))
(COMPLEX (SINGLE-FLOAT 1.0 1.0))

* (type-of #C(1.0 1d0))
(COMPLEX (DOUBLE-FLOAT 1.0d0 1.0d0))
~~~

complex number の実部と虚部は [`realpart` and `imagpart`][realpart-and-imaginary] で取り出せます。

~~~lisp
* (realpart #C(7 9))
7
* (imagpart #C(4.2 9.5))
9.5
~~~

#### complex arithmetic

Common Lisp の mathematical 関数は一般に complex number を扱え、本来の結果が complex number である場合は complex number を返します。例:

~~~lisp
* (sqrt -1)
#C(0.0 1.0)

* (exp #C(0.0 0.5))
#C(0.87758255 0.47942555)

* (sin #C(1.0 1.0))
#C(1.2984576 0.63496387)
~~~

[​]{#string--number-}

## 文字列から number を読む

[`parse-integer`][parse-integer] 関数は文字列から integer を読みます。

[parse-number][parse-number] ライブラリは任意の式を evaluate できないため、信頼できない input に対してより安全に使えるはずです。float も parse できます。

~~~lisp
* (ql:quickload :parse-number)
* (use-package :parse-number)

* (parse-number "23.4e2")
2340.0
6
~~~

[Serapeum][serapeum] ライブラリにももちろん `parse-float` 関数があります。たとえば double float のように、出力の型を指定することもできます。

~~~lisp
* (ql:quickload "serapeum")
* (serapeum:parse-float "23.4e2" :type 'double-float)
2340.0d0
;;    ^^ double
~~~

文字列と数値の相互変換については [文字列セクション][strings] を参照してください。

## 数値の変換

ほとんどの数値関数は必要に応じて型を自動変換します。`coerce` 関数は、数値型を含むオブジェクトをある型から別の型へ変換します。

[Common Lisp the Language, 2nd Edition, section 12.6][book-cl-12.6] を参照してください。

### float を rational に変換する

[`rational` and `rationalize` 関数][rational-and-rationalize] は real numeric 引数を rational に変換します。`rational` は floating point 引数が正確だと仮定します。`rationalize` は floating point number がその精度の範囲でしか正確でないという事実を利用するため、より単純な rational number を見つけられることがよくあります。

### rational を integer に変換する

計算結果が rational number で、その分子が分母の倍数である場合、自動的に integer に変換されます。

~~~lisp
* (type-of (* 1/2 4))
(INTEGER 0 4611686018427387903)
~~~

## floating-point number と rational number の丸め

[`ceiling`, `floor`, `round` and `truncate`][ceiling-functions] 関数は floating point number または rational number を integer に変換します。結果と input の差が第 2 戻り値として返るため、input は 2 つの出力の和になります。

~~~lisp
* (ceiling 1.42)
2
-0.58000004

* (floor 1.42)
1
0.41999996

* (round 1.42)
1
0.41999996

* (truncate 1.42)
1
0.41999996
~~~

負の数では `floor` と `truncate` に違いがあります。

~~~lisp
* (truncate -1.42)
-1
-0.41999996

* (floor -1.42)
-2
0.58000004

* (ceiling -1.42)
-1
-0.41999996
~~~

類似の関数 `fceiling`、`ffloor`、`fround`、`ftruncate` は、引数と同じ型の floating point として結果を返します。

~~~lisp
* (ftruncate 1.3)
1.0
0.29999995

* (type-of (ftruncate 1.3))
SINGLE-FLOAT

* (type-of (ftruncate 1.3d0))
DOUBLE-FLOAT
~~~

## number の比較

[Common Lisp the Language, 2nd Edition, Section 12.3][book-cl-12.3] を参照してください。

`=` predicate は、すべての引数が数値的に等しい場合に `T` を返します。floating point number の比較には、すべての real number を表現できずエラーが蓄積するという性質のため、ある程度の誤差の余地が含まれる点に注意してください。

定数 [`single-float-epsilon`][single-float-epsilon] は、1.0 に加えたとき `=` comparison が fail する最小の number です。

~~~lisp
* (= (+ 1s0 5e-8) 1s0)
T
* (= (+ 1s0 6e-8) 1s0)
NIL
~~~

これは `single-float` が常に `6e-8` 以内の精度を持つという意味ではない点に注意してください。

~~~lisp
* (= (+ 10s0 4e-7) 10s0)
T
* (= (+ 10s0 5e-7) 10s0)
NIL
~~~

むしろ、これは `single-float` が約 7 桁の精度を持つという意味です。一連の計算を行うとエラーが蓄積し、より大きな誤差の許容範囲が必要になることがあります。この場合は絶対差を比較できます。

~~~lisp
* (< (abs (- (+ 10s0 5e-7)
             10s0))
     1s-6)
T
~~~

`=` で数値を比較するときは、型が混在していてもかまいません。数値と型の両方を検査するには `eql` を使います。

~~~lisp
* (= 3 3.0)
T

* (eql 3 3.0)
NIL
~~~

## 数列を操作する

多くの Common Lisp 関数はシーケンスを操作します。シーケンスはリストまたはベクトル（1 次元配列）です。[mapping][mapping] の節を参照してください。

多次元配列に対する操作は[配列の節][arrays]で説明しています。

数値の「無限」シーケンスを含む遅延シーケンスを定義し操作するライブラリもあります。例:

* [Clazy][clazy] は QuickLisp にあります。
* [folio2][folio2] は QuickLisp にあります。効率的なシーケンスのための
* [Series][series] パッケージへのインターフェイスを含みます。
* [lazy-seq][lazy-seq].

## ローマ数字を扱う

`format` 関数は `~@r` ディレクティブで数値をローマ数字に変換できます。

~~~lisp
* (format nil "~@r" 42)
"XLII"
~~~

ローマ数字を読むための [gist by tormaroe][gist-tormaroe] があります。

## 乱数の生成

[`random`][random] 関数は、その引数の型に応じて整数または浮動小数点数の乱数を生成します。

~~~lisp
* (random 10)
7

* (type-of (random 10))
(INTEGER 0 4611686018427387903)
* (type-of (random 10.0))
SINGLE-FLOAT
* (type-of (random 10d0))
DOUBLE-FLOAT
~~~

SBCL では [Mersenne Twister][mersenne-twister] という擬似乱数生成器が使われています。詳細は [SBCL manual の 7.13][sbcl-7.13] の節を参照してください。

乱数のシードは [`*random-state*`][random-state] に保存され、その内部表現は処理系に依存します。関数 [`make-random-state`][make-random-state] は、新しい乱数の状態を作成したり、既存の状態をコピーしたりするために使えます。

同じ乱数の集合を複数回使うには、`(make-random-state nil)` で現在の `*random-state*` のコピーを作成します。

~~~lisp
* (dotimes (i 3)
    (let ((*random-state* (make-random-state nil)))
      (format t "~a~%"
              (loop for i from 0 below 10 collecting (random 10)))))

(8 3 9 2 1 8 0 0 4 1)
(8 3 9 2 1 8 0 0 4 1)
(8 3 9 2 1 8 0 0 4 1)
~~~

これはループ内で 10 個の乱数を生成しますが、毎回シーケンスは同じです。なぜなら `*random-state*` というスペシャル変数が、`let` フォームの前でその状態のコピーに動的束縛されるからです。

その他の資料:

* [random-state][random-state] パッケージは QuickLisp で利用でき、複数の移植性のある乱数生成器を提供します。

[​]{#bit-wise-operation}

## ビット単位の演算

Common Lisp はビット単位の算術演算を行う関数も多数提供しています。よく使われるものを、対応する C/C++ の表現とともに以下に示します。

<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
}
th {
  text-align: left;
}
</style>

<table>
  <thead>
    <tr>
      <th>Common Lisp</th>
      <th>C/C++</th>
      <th>説明</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>(logand a b c)</td>
      <td>a & b & c</td>
      <td>複数 operand の bit-wise AND</td>
    </tr>
    <tr>
      <td>(logior a b c)</td>
      <td>a | b | c</td>
      <td>複数 operand の bit-wise OR</td>
    </tr>
    <tr>
      <td>(lognot a)</td>
      <td>~a</td>
      <td>単一 operand の bit-wise NOT</td>
    </tr>
    <tr>
      <td>(logxor a b c)</td>
      <td>a ^ b ^ c</td>
      <td>複数 operand の bit-wise exclusive or (XOR)</td>
    </tr>
    <tr>
      <td>(ash a 3)</td>
      <td>a << 3</td>
      <td>bit-wise left shift</td>
    </tr>
    <tr>
      <td>(ash a -3)</td>
      <td>a >> 3</td>
      <td>bit-wise right shift</td>
    </tr>
  </tbody>
</table>

負の数は 2 の補数として扱われます。忘れてしまった場合は [Wiki ページ][twos-complements] を参照してください。

例:

~~~lisp
* (logior 1 2 4 8)
15
;; 説明:
;;   0001
;;   0010
;;   0100
;; | 1000
;; -------
;;   1111

* (logand 2 -3 4)
0

;; 説明:
;;   0010 (2)
;;   1101 (-3 の two's complement)
;; & 0100 (4)
;; -------
;;   0000

* (logxor 1 3 7 15)
10

;; 説明:
;;   0001
;;   0011
;;   0111
;; ^ 1111
;; -------
;;   1010

* (lognot -1)
0
;; 説明:
;;   11 -> 00

* (lognot -3)
2
;; 説明:
;;   101 -> 010

* (ash 3 2)
12
;; 説明:
;;   11 -> 1100

* (ash -5 -2)
-2
;; 説明
;;   11011 -> 110
~~~

より詳しい説明や他の bit-wise 関数については [CLHS page][logand-functions] を参照してください。

## 付録: number tower



![](numbertower.png)
   

*太字で実線の box に入っている type は、通常よく使うものです。*


[numbers]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node16.html#SECTION00610000000000000000
[numbers-characters-strings]: http://www.gigamonkeys.com/book/numbers-characters-and-strings.html
[isqrt]: http://clhs.lisp.se/Body/f_sqrt_.htm
[gcd]: http://clhs.lisp.se/Body/f_gcd.htm
[lcm]: http://clhs.lisp.se/Body/f_lcm.htm#lcm
[ratio]: http://clhs.lisp.se/Body/t_ratio.htm
[rational]: http://clhs.lisp.se/Body/t_ration.htm#rational
[integer]: http://clhs.lisp.se/Body/t_intege.htm#integer
[book-cl-2.1.3]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node19.html
[article-floating-point-arithmetic]: https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html
[float-constants]: http://clhs.lisp.se/Body/v_short_.htm
[read-default-float-format]: http://clhs.lisp.se/Body/v_rd_def.htm
[SBCL]: http://www.sbcl.org/
[CCL]: https://ccl.clozure.com/
[computable-reals]: http://quickdocs.org/computable-reals/
[complex]: http://clhs.lisp.se/Body/f_comp_2.htm#complex
[realpart-and-imaginary]: http://clhs.lisp.se/Body/f_realpa.htm
[parse-integer]: http://clhs.lisp.se/Body/f_parse_.htm
[parse-number]: https://github.com/sharplispers/parse-number
[serapeum]: https://github.com/ruricolist/serapeum/
[strings]: https://lispcookbook.github.io/cl-cookbook/strings.html#converting-a-string-to-a-number
[book-cl-12.6]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node130.html
[rational-and-rationalize]: http://clhs.lisp.se/Body/f_ration.htm
[ceiling-functions]: http://www.lispworks.com/documentation/HyperSpec/Body/f_floorc.htm
[book-cl-12.3]: https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node124.html
[single-float-epsilon]: http://clhs.lisp.se/Body/v_short_.htm
[mapping]: https://lispcookbook.github.io/cl-cookbook/data-structures.html#mapping-map-mapcar-remove-if-not
[arrays]: https://lispcookbook.github.io/cl-cookbook/arrays.html
[clazy]: https://common-lisp.net/project/clazy/
[series]: https://github.com/tokenrove/series/wiki/Documentation
[lazy-seq]: https://github.com/fredokun/lisp-lazy-seq
[folio2]: https://github.com/mikelevins/folio2
[gist-tormaroe]: https://gist.github.com/tormaroe/90ddd9dc7cc191040be4
[random]: http://clhs.lisp.se/Body/f_random.htm#random
[mersenne-twister]: https://en.wikipedia.org/wiki/Mersenne_Twister
[sbcl-7.13]: http://www.sbcl.org/manual/#Random-Number-Generation
[random-state]: http://clhs.lisp.se/Body/v_rnd_st.htm#STrandom-stateST
[make-random-state]: http://clhs.lisp.se/Body/f_mk_rnd.htm
[random-state]: http://quickdocs.org/random-state/
[logand-functions]: http://www.lispworks.com/documentation/HyperSpec/Body/f_logand.htm
[twos-complements]: https://en.wikipedia.org/wiki/Twos_complement
 
#  等価性 {#chapter-equality}
 

Common Lisp には、等価性を判定するためのさまざまな関数があります。`=`、`eq`、`eql`、`equal`、`equalp`、`string-equal`、`char-equal` などです。これらの違いを例とともに説明します。

要点は次のとおりです。

- `=` は数値専用です。`equal` は、リストや文字列など多くの値を通常期待する方法で比較します。
- ライブラリを使わない限り、`=` や `equal` のような標準関数を自作のクラス向けに特殊化することはできません。
- `find` などで文字列のシーケンスを検索しても結果が得られない場合は、`:test` キーワード引数を確認してください。たとえば `(find "foo" '("hello" "foo") :test #'equal)` とします。
- 汎用的な述語を介さず、用途に合った比較関数を直接使うほうが、静的解析や性能の面で有利になることがあります。


## `=` は数値用（`NIL` に注意）

`=` 関数は、2 つ以上の数値が数値的に等しいかどうかを比較します。

~~~lisp
(= 2 2) ;; => T
(= 2 2.0 2 2) ;; => T
(= 2 4/2) ;; => T

(= 2 42) ;; => NIL
~~~

ただし、`=` は数値専用です。次の例は型エラーとなり、対話デバッガに入ります。ここでは SBCL のエラーメッセージ、コンディションの型、バックトレースを示します。

~~~lisp
(= 2 NIL)
;; => ERROR:
The value
  NIL
is not of type
  NUMBER
when binding SB-KERNEL::Y

   [Condition of type TYPE-ERROR]

Restarts:
  …

Backtrace:
  0: (SB-KERNEL:TWO-ARG-= 2 NIL) [external]
  1: (SB-VM::GENERIC-=)
  2: (= 2 NIL)
~~~

`SB-KERNEL::Y` は処理系内部の変数を指しています。プログラム中に `Y` という変数があるわけではありません。

したがって、数値の比較対象に `NIL` が含まれる可能性がある場合は、`equalp` を使う、変数を `(or … 0)` で包む、または事前に `(null …)` で確認する、といった方法が使えます。

[​]{#eq--low-level-pointermemory-}
[​]{#eq--low-level-memory-}

## `eq` はオブジェクトの同一性を判定する

> `(eq x y)` は、`x` と `y` が同一のオブジェクトである場合に限り真になります。

シンボルやキーワードの比較には `eq` を使います。

次の式はいずれも真になります。

~~~lisp
(eq :a :a)
(eq 'a 'a)
~~~

オブジェクトをそれ自身と比較すると、`eq` は真になります。

~~~lisp
(let ((x '(a . b)))
  (eq x x))
;; => T
~~~

数値や文字、およびリストや文字列などの複合オブジェクトを、値や内容に基づいて比較する目的では `eq` は使えません。動作するように見える場合もありますが、すべての処理系で真になることは規定されていません。

たとえば、ある処理系では数値に対する `eq` が真になっても、別の処理系では真にならないことがあります。

~~~lisp
(eq 2 2) ;; => T または NIL（規格では結果が保証されない）

;; 一方、大きな整数では次のようになることがある
(eq
  49827139472193749213749218734917239479213749127394871293749123
  49827139472193749213749218734917239479213749127394871293749123) ;; => 処理系によっては NIL
~~~

これは、数値を同一のオブジェクトとして表現するかどうかが処理系によって異なり、規格では定められていないためです。

同様に、次の結果も処理系に依存します。

~~~lisp
(eq '(a . b) '(a . b)) ;; T または NIL
(eq #\a #\a)           ;; T または NIL
~~~

実行時にそれぞれ別個に作られたリストや文字列は、内容が同じでも `eq` ではありません。

~~~lisp
(eq (list 'a) (list 'a)) ;; => NIL
(eq (copy-seq "a") (copy-seq "a")) ;; => NIL
~~~

この例では、内容が同じでも別々のオブジェクトが作られているため、`eq` は偽になります。


[​]{#eql--number--character--eq-}

## `eql` は、同じ型の数値と文字にも使える、より一般的な `eq`

> `eql` 述語は、引数同士が `eq` である場合、同じ型かつ同じ値の数値である場合、または同じ文字を表す文字オブジェクトである場合に真になります。

有用性の観点では、`eq` < `eql` と言えます。

次の数値比較は真になります。

~~~lisp
(eql 3 3) ;; => T
~~~

ただし、次の比較は偽になります。`3` と `3.0` の型が異なるためです（整数と単精度浮動小数点数）。

~~~lisp
(eql 3 3.0) ;; => NIL
~~~

複素数の場合は次のようになります。

~~~lisp
(eql #c(3 -4) #c(3 -4))       ;; => T
(eql #c(3 -4.0) #c(3 -4))     ;; => NIL（-4.0 と -4 の型が異なるため）
~~~

文字も比較できます。

~~~lisp
(eql #\A #\A) ;; => T
~~~

一方、リストやコンスセルの内容を比較することはできません。

~~~lisp
(eql (cons 'a 'b) (cons 'a 'b)) ;; => NIL
~~~

[​]{#equal--string--printed-representation--object-}

## `equal` は文字列やリストの構造も比較する

> `equal` 述語は、引数同士が構造的に同等（同型）である場合に真になります。大まかな目安としては、印字表現が同じオブジェクト同士は `equal` であると考えられます。

概念的には、`eq` < `eql` < `equal` と表せます。`eql` である 2 つのオブジェクトは、必ず `equal` でもあります。

ただし、型が異なる **数値** は、数値的に同じ値でも等価とは判定されません。

~~~lisp
(equal 3 3.0) ;; => NIL
~~~

一方、**リスト**やコンスセルは、その構造と要素を比較できます。別々に作られたオブジェクトでも構いません。

~~~lisp
(equal (cons 'a 'b) (cons 'a 'b)) ;; => T

(equal (list 'a) (list 'a)) ;; => T
~~~

**文字列**も比較できます。

~~~lisp
(equal "Foo" "Foo") ;; => T
~~~

別々のオブジェクトでも、内容が同じなら真になります。

~~~lisp
(equal "Foo" (copy-seq "Foo")) ;; => T
~~~

文字列の大文字と小文字は区別されます。

~~~lisp
(equal "FOO" "foo") ;; => NIL
~~~

構造体やハッシュテーブルなどのオブジェクトについては、同一のオブジェクト、つまり `eq` である場合に限り `equal` になります。`equal` は、その内部に格納された値を再帰的には比較しません。

詳しくは、末尾にリンクした Community Spec を参照してください。


[​]{#equalp--string--case-number--numerical-value-}

## `equalp` は文字列の大小を区別せず、数値を数値的に比較する

> 2 つのオブジェクトは、`equal` である場合、大文字と小文字などの属性を無視する `char-equal` で等しい文字である場合、型が異なっても数値的に同じ値を持つ場合、またはすべての構成要素が `equalp` である場合に `equalp` です。

順序を続けると、`eq` < `eql` < `equal` < `equalp` と言えます。
ただし、一般的には `equalp` より `equal` のほうが適切な場合が多いでしょう。

型が異なる **数値** でも、数値的な値を比較できます。

~~~lisp
(equalp 3 3.0) ;; => T
~~~

数値は、`=` で等しければ `equalp` でも等しくなります。

次の **文字列** の比較に注目してください。

~~~lisp
(equalp "FOO" "foo") ;; => T
~~~

`equalp` は文字列の大文字と小文字を区別しません。文字列は文字のシーケンスであり、`equalp` は文字の大小を無視する `char-equal` を使って、すべての構成要素を比較するからです。

`equalp` で **配列** を比較するときは、配列の要素型の違いが無視されます。そのため、文字列と文字のベクターが `equalp` になることがあります。

~~~lisp
(equalp "x" #(#\x)) ;; => T
~~~

一方、`equal` では偽になります。

~~~lisp
(equal "x" #(#\x)) ;; => NIL
~~~

**構造体**と**ハッシュテーブル**については、`equalp` は内部の要素も比較します。

たとえば、`serapeum:dict` という略記を使って 2 つのハッシュテーブルを作ります。

~~~lisp
(dict :a 1 :b 2)
(dict :b 2 :a 1)
~~~

これらを比較すると、`equalp` は真になります。

~~~lisp
(equalp * **)
;; => T
~~~

ただし、**equalp** は CLOS の**インスタンス**のスロットまでは比較しません。後述の節を参照してください。

詳しくは、末尾にリンクした Community Spec を参照してください。


[​]{#function}

## その他の比較関数

### `null`

関数 `null` は、引数が `NIL` なら真を返します。

~~~lisp
(null '()) ;; => T
~~~


### 多くの Common Lisp 標準関数は既定で `eql` を使う

これは、文字列を扱い始めた人がよく遭遇する問題です。Common Lisp の標準関数を使っても、期待した結果が得られないことがあります。

次の例を見てください。

~~~lisp
(find "foo" (list "test" "foo" "bar"))
;; NIL
~~~

このリストに文字列 `"foo"` が存在するか調べていますが、`NIL` が返ります。何が起きているのでしょうか。

`find` は、既定では各要素の比較に `eql` を使います。しかし、`eql` は文字列の内容を比較しません。文字列の内容を比較できる別の述語を指定する必要があります。

`find` などの関数は `:test` キーワード引数を受け取り、比較に使う述語を変更できます。

~~~lisp
(find "foo" (list "test" "foo" "bar") :test #'equal)
;; => "foo"
~~~

文字列の大文字と小文字を区別しない場合は、`equalp` も使えます。

~~~lisp
(find "FOO" (list "test" "foo" "bar") :test #'equalp)
;; => "foo"
~~~

これらの標準関数については、[データ構造](https://lispcookbook.github.io/cl-cookbook/data-structures.html)にも例があります。

### `char-equal`

文字を比較するための関数として `char-equal` があります。

> `char-equal` は、大文字と小文字、および文字の一部の属性を無視して比較します。


[​]{#string--string-equal}

### 文字列と `string-equal`

`string-equal` は文字列およびその一部分を比較します。比較する範囲の *start* と *end* を指定できます。文字の比較には `char-equal` を使うため、大文字と小文字は区別しません。また、文字列指定子としてシンボルも渡せます。

~~~lisp
(string-equal :foo "foo") ;; => T
(string-equal :foo "FOO") ;; => T
~~~

次はそのドキュメント文字列です。

```
STRING-EQUAL

This is a function in package COMMON-LISP

Signature
(string1 string2 &key (start1 0) end1 (start2 0) end2)

Given two strings (string1 and string2), and optional integers start1,
start2, end1 and end2, compares characters in string1 to characters in
string2 (using char-equal).
```

文字列の比較には、ほかにも `string=`、`string/=`、`string<`、`string>`、`string<=`、`string>=`、`string-equal`、`string-not-equal`、`string-lessp`、`string-greaterp`、`string-not-greaterp`、`string-not-lessp` があります。

詳しくは[文字列](https://lispcookbook.github.io/cl-cookbook/strings.html)を参照してください。

### `tree-equal` で木を比較する

> `tree-equal` は、`X` と `Y` が同じ葉を持つ同型の木である場合に `T` を返します。


[​]{#function------function-}

## 比較対象と使用する関数

```txt
比較対象                    使用する関数

オブジェクト／構造体        EQ

NIL                         EQ（ただし NULL のほうが簡潔で、おそらく低コスト）

T                           EQ（または値そのものを条件式として使う）

型も含めた数値              EQL

数値                        =

文字                        EQL または CHAR-EQUAL

リスト、コンス              EQ（同一のオブジェクトか調べる場合）
                            EQUAL（要素の内容を比較する場合）

配列                        EQ（同一のオブジェクトか調べる場合）
                            EQUALP（要素の内容を比較する場合）

文字列                      EQUAL（大文字と小文字を区別する）
                            EQUALP（大文字と小文字を区別しない）
                            STRING-EQUAL（シンボルも比較対象に含める場合）

木（リストのリスト）        TREE-EQUAL（適切な :TEST 引数を指定する）
```

[​]{#object--built-in-function--object-oriented-}

## 自作のオブジェクトを比較する

2 つの変数が同一のオブジェクトを指しているか確認するには、`eq` を使います。

自作のオブジェクトを独自の基準で比較したい場合もあります。たとえば、2 つの `person` オブジェクトについて、名前と姓が同じなら等価とみなす場合です。そのために Common Lisp の標準関数を特殊化することはできません。`person=` のような独自の関数を定義するか、ライブラリを使ってください（末尾のリンクを参照）。

これは制約ともいえますが、汎用的な比較関数ではなく、用途に特化した関数を使うことで性能上有利になる場合があります。

例として、CLOS チュートリアルの `person` クラスを使います。

```lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)))
```

同じ名前を持つ、別々の `person` オブジェクトを 2 つ作ります。

```lisp
(defparameter *p1* (make-instance 'person :name "me"))
(defparameter *p2-same-name* (make-instance 'person :name "me"))
```

オブジェクトの同一性は `eq` で比較できます。

~~~lisp
(eq *p1* *p1*) ;; => T
(eq *p1* *p2-same-name*) ;; => NIL
~~~

オブジェクトが等価となる条件を独自に定めるには、`person=` のようなメソッドを定義します。

~~~lisp
(defmethod person= (p1 p2)
  (string= (name p1) (name p2)))

(person= *p1* *p2-same-name*)  ;; => T
~~~

独自のオブジェクトにも `=` や `equal` を使いたい場合は、末尾で紹介しているライブラリを利用してください。

## オブジェクトの併合と `compile-file`

`(eql "a" "a")` の例に戻りましょう。REPL では、この式が `NIL` を返すことがあります。

これは、2 つの文字列リテラルが別々のオブジェクトとして読み込まれることがあるためです。

一方、コンパイラーはオブジェクトを併合することがあります。

`compile-file` でファイルをコンパイルすると、コンパイラーが複数の類似したリテラルを同一のオブジェクトとして扱う場合があります。たとえば、2 つの文字列リテラル `"a"` が併合される可能性があります。

その場合、同じ比較式が `T` を返す可能性があります。

したがって、比較対象に合った等価性述語を使う必要があります。

これは、`'(1 2 3)` のようなリテラルを破壊的に変更してはならない理由の一つでもあります。変更可能なリストが必要なら、`(list 1 2 3)` のように実行時に作成します。

なお、`compile` にはオブジェクトの併合が許されていません。


## 謝辞

- [CLtL2: Equality Predicates](http://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node74.html)
- 比較表: [Stack Overflow における Leslie P. Polzer の回答](https://stackoverflow.com/questions/547436/whats-the-difference-between-eq-eql-equal-and-equalp-in-common-lisp)

## 参照

- [CL Community Spec の `equal`](https://cl-community-spec.github.io/pages/equal.html)
- [CL Community Spec の `equalp`](https://cl-community-spec.github.io/pages/equalp.html)
- [equals](https://github.com/karlosz/equals/) - Common Lisp 向けの汎用的な等価性判定。
- [generic-cl](https://github.com/alex-gutev/generic-cl/) - Common Lisp 標準関数に対する総称関数インターフェイス。
  - 自作のオブジェクトに `=` や `<` を使えるようになります。
 
#  ループ、反復、マッピング {#chapter-iteration}
 

<!-- 最初の見出しの前に何らかの本文が必要 -->

## はじめに: loop, iterate, for, mapcar, series, transducers

### `loop` マクロ（組み込み）

**[loop](http://www.lispworks.com/documentation/lw51/CLHS/Body/m_loop.htm)**
は反復のための組み込みマクロです。

最も単純な形は `(loop (print "hello"))` です。これは永久に表示し続けます。

リストに対する単純な反復は次のようになります。

~~~lisp
(loop for x in '(1 2 3)
      do (print x))
;; =>
1
2
3
NIL
~~~

必要なものを表示しますが、戻り値は `nil` です。

リストを返したい場合は `collect` を使います。

~~~lisp
(loop for x in '(1 2 3)
      collect (* x 10))
;; => (10 20 30)
~~~

`loop` マクロは、ほとんどの Lisp 式とは異なり、S 式を使わない複雑な内部 DSL を持っています。そのため、`loop` 式を読むときは、頭の半分を Lisp モードに、もう半分を `loop` モードにしておく必要があります。好きになるか嫌いになるかのどちらかです。たいていは、しばらく嫌いになってから好きになります。

`loop` 式は 4 つの部分からなると考えられます。

1. 反復される変数を設定する式
2. 条件付きで反復を終了する式
3. 各反復で何かを行う式
4. Loop が終了する直前に何かを行う式

さらに、`loop` 式は値を返せます。1 つの `loop` 式でこれらすべてを使うことはめったにありませんが、さまざまな方法で組み合わせられます。

loop の節は 2 つのスタイルで書けます。上のようにシンボルとして書くか、次のようにキーワードとして書きます。

~~~lisp
(loop :for x :in '(1 2 3) :collect (* x 10))
~~~

ここでは `:for`、`:in`、`:collect` をキーワードとして書いています。


### `iterate` ライブラリ

**[iterate](https://common-lisp.net/project/iterate/doc/index.html)** は、
`loop` より単純で、より「Lisp らしく」、より予測しやすく、さらに拡張可能であることを目指した人気の反復マクロです。ただし組み込みではないので、取り込む必要があります。

    (ql:quickload "iterate")
    (use-package :iterate)

（同じパッケージで `loop` と Iterate を使うと、名前の衝突に遭遇するかもしれません。）

Iterate は次のように書きます。

~~~lisp
(iter (for i from 1 to 5)
  (collect (* i i)))
;; => (1 4 9 16 25)
~~~

Iterate には `display-iterate-clauses` も付属しており、かなり便利です。

~~~
(display-iterate-clauses '(for))
;; FOR PREVIOUS &OPTIONAL INITIALLY BACK     Previous value of a variable
;; FOR FIRST THEN            Set var on first, and then on subsequent iterations
;; ...
~~~

このページの `loop` 用の例の多くは、少し変更すれば Iterate でも有効です。

### `for` ライブラリ

**[for](https://github.com/Shinmera/for/)** は、
しばしば `loop` より短く書ける拡張可能な反復マクロです。「`loop` と違って拡張可能で分かりやすく、Iterate と違って code-walking を必要とせず拡張しやすい」とされています。

もう 1 つの利点として、すべてのデータ構造（list、vector、hash-table など）に対して使える 1 つの構文があります。迷ったら `for… over…` を使えばよいのです。

~~~lisp
(for:for ((x over your-data-structure))
   (print …))
~~~

これも quickload で読み込む必要があります。

    (ql:quickload "for")

### `map`, `mapcar` など（組み込み）

**`mapcar`** と `map` の例も示します。さらに、E. Weitz が "Common Lisp Recipes" 第 7 章でうまく分類している仲間の `mapcon`、`mapcan`、`maplist`、`mapc`、`mapl` も扱います。他の言語から来た人に最もなじみがあるのは、おそらく `mapcar` でしょう。これは関数と 1 つ以上のリストを引数に取り、リストの各 *要素* に順番に関数を適用し、結果のリストを返します。

~~~lisp
(mapcar (lambda (it) (+ it 10)) '(1 2 3))
;; => (11 12 13)
~~~

`lambda` を使わずに関数を参照することもできます。その関数は正しい個数の引数を受け取れる必要があります。

~~~lisp
(mapcar #'1+ '(1 2 3))
;; => (2 3 4)

(mapcar #'+ '(1 2 3) '(10 20 30))
;; => (11 22 33)

(mapcar #'+ '(1 2 3) '(10 20 30) '(100 200 300))
;; => (111 222 333)
~~~

`map` は汎用的で、list や vector を引数として受け取り、結果の型を第 1 引数として要求します。

~~~lisp
(map 'vector (lambda (it) (+ it 10)) '(1 2 3))
;; => #(11 12 13)

(map 'list (lambda (it) (+ it 10)) #(1 2 3))
;; => (11 12 13)

(map 'string #'code-char '#(97 98 99))
;; => "abc"
~~~

**`map-into`** は破壊的な変種で、新しいシーケンスを割り当てる代わりに、既存のシーケンスへ結果を直接格納します。その結果のシーケンスは戻り値にもなります。

~~~lisp
(let ((result (make-list 3)))
  (map-into result #'+ '(1 2 3) '(10 20 30)))
;; => (11 22 33)
~~~

これは vector でも動作し、性能が重要なループで割り当てを避けたいときに便利です。

~~~lisp
(let ((buf (make-array 4)))
  (map-into buf #'char-code "abcd")
  buf)
;; => #(97 98 99 100)
~~~

注: `map-into` は第 1 引数をその場で変更します。既存のバッファを再利用する必要がない場合は、`map` や `mapcar` を優先してください。

他の構文にも、状況によって利点があります。リストの *末尾（tail）* を処理したり、戻り値を *連結* したり、何も返さなかったりします。その一部を見ていきます。

`mapcar` が好きでよく使い、lambda をもっと速く短く書きたいなら、次の単純なマクロを使えます。

~~~lisp
(defmacro ^ (&rest forms)
  `(lambda ,@forms))
~~~

例:

~~~lisp
(mapcar (^ (nb) (* nb 10)) '(1 2 3))
;; (10 20 30)
~~~

できあがりです。このレシピではこれ以上使いませんが、自由に使ってください。

### `series` ライブラリ

**[series](http://series.sourceforge.net/)** も気に入るかもしれません。これは sequence、ストリーム、loop の側面を組み合わせるものだと自称するライブラリです。Series 式は sequence に対する操作（つまり関数型プログラミング）のように見えますが、`loop` と同じ高い効率を達成できます。Series は "Common Lisp the Language" の付録 A で初めて登場しました（言語の一部になりかけたものです）。Series は次のように書きます。

~~~lisp
(collect
  (mapping ((x (scan-range :from 1 :upto 5)))
    (* x x)))
;; (1 4 9 16 25)
~~~

`series` は良いものですが、その関数名は今日の関数型言語で見かけるものとは異なります。["Generators
The Way I Want Them Generated"](https://cicadas.surf/cgit/colin/gtwiwtg.git/about/) ライブラリも気に入るかもしれません。これは `series` に似た遅延シーケンスのライブラリですが、より新しく、完全性では劣るものの、`take`、`filter`、`for`、`fold` といった語を持つ「現代的な」API を備えていて使いやすいです。

~~~lisp
(range :from 20)
;; #<GTWIWTG::GENERATOR! {1001A90CA3}>

(take 4 (range :from 20))
;; (20 21 22 23)
~~~

執筆時点で、GTWIWTG は GPLv3 の下でライセンスされています。

### `transducers` ライブラリ

**[transducers](https://codeberg.org/fosskers/cl-transducers)** パターンは 2023 年に Common Lisp へ移植され、"source" を効率よく反復するための関数型プログラミングのイディオム一式を提供します。"source" は List や Vector のような単純なコレクションでもよく、巨大なファイルや無限データのジェネレータでもありえます。

Transducers は...

- `map` や `filter` のような操作を、各ステップの間でメモリを割り当てずに連鎖できます。
- 特定のデータ型に縛られません。一度だけ実装すれば済みます。
- 「データ変換コード」を大幅に単純化します。
- 「遅延評価」とは無関係です。

最初の 1000 個の奇数整数の二乗和を求めてみましょう。

~~~lisp
(defpackage foo
  (:use :cl)
  (:local-nicknames (:t :transducers)))
;; => #<PACKAGE "FOO">

(t:transduce
  (t:comp (t:filter #'oddp)  ;; (2) 奇数だけを残す。
          (t:take 1000)      ;; (3) filter 後の最初の 1000 個の奇数を残す。
          (t:map (lambda (n) ;; (4) その 1000 個を二乗する。
                   (* n n))))
  #'+                        ;; (5) Reducer: すべての二乗を足し合わせる。
  (t:ints 1))                ;; (1) Source: すべての正の整数を生成する。
;; => 1333333000
~~~

ここでは `ints` が無限のジェネレータであるにもかかわらず、最終結果に必要な数だけの値しか実際には作られません。

利用者は独自のトランスデューサー（`map` のような関数）やリデューサー（`+` のような関数）を自由に作り、望む方法でデータストリームを走査できます。それでいてメモリ効率を非常に高く保てます。

詳しくは [README](https://codeberg.org/fosskers/cl-transducers)、[API](https://fosskers.github.io/cl-transducers/index.html)、または [元の
Transducers のドキュメント](https://clojure.org/reference/transducers) を参照してください。

## レシピ

### 永久にループする、return

~~~lisp
(loop (print "hello"))
~~~

`return` は結果を返せます。

~~~lisp
(loop for i in '(1 2 3)
      when (> i 1)
        return i)
;; => 2
~~~


### 決まった回数だけループする

#### dotimes

~~~lisp
(dotimes (n 3)
  (print n))
;; =>
0
1
2
NIL
~~~

ここで `dotimes` は `nil` を返します。値を返す方法は 2 つあります。まず、lambda list の中で result form を設定できます。

~~~lisp
(dotimes (n 3 :done)
  ;;          ^^^^^ result form。s-expression でもよい。
  (print n))
;; =>
0
1
2
:DONE
~~~

または、戻り値とともに `return` を使えます。

~~~lisp
(dotimes (i 3)
   (if (> i 1)
       (return :early-exit!)
     (print i)))
;; =>
0
1
:EARLY-EXIT!
~~~



#### loop… repeat

これは "Hello!" を 3 回表示し、`nil` を返します。

~~~lisp
(loop repeat 3
      do (format t "Hello!~%"))
;; =>
Hello!
Hello!
Hello!
NIL
~~~

`collect` を使うと、これはリストを返します。

~~~lisp
(loop repeat 3
      collect (random 10))
;; => (5 1 3)
~~~

#### Series

~~~lisp
(iterate ((n (scan-range :below 3)))
  (print n))
;; =>
0
1
2
NIL
~~~

### 無限にループする、循環リストを巡回する

まず、上で示したように、単に `(loop ...)` を使えば無限にループできます。ここでは、リスト上で永久にループする方法を示します。

最後の要素をリスト自身に設定することで、無限リストを作れます。

~~~lisp
(loop with list-a = (list 1 2 3)
      with infinite-list = (setf (cdr (last list-a)) list-a)
      for item in infinite-list
      repeat 8
      collect item)
;; => (1 2 3 1 2 3 1 2)
~~~

図解: `(last (list 1 2 3))` は `(3)` です。これはリスト、より正確には `car` が 3 で `cdr` が NIL の cons セルです。復習には [データ構造の章](#chapter-data-structures) を参照してください。これは `(list 3)` の表現です。

~~~
[o|/]
 |
 3
~~~

`(list 1 2 3)` の表現:

```
[o|o]---[o|o]---[o|/]
 |       |       |
 1       2       3
```

最後の要素の `cdr` をリスト自身に設定することで、自分自身へ戻るようにします。

`#=` 構文を使うと、記法上のショートカットが可能です。

~~~lisp
(defparameter *list-a* '#1=(1 2 3 . #1#))
(setf *print-circle* t)  ;; circular list を永久に表示しない
;; *list-a*
~~~

2 つの値の間だけで交互に切り替える必要があるなら、`for … then` を使います。

~~~lisp
(loop repeat 4
      for up = t then (not up)
      collect up)
;; (T NIL T NIL)
~~~

### Iterate の for ループ

リストとベクトルについて:

~~~lisp
(iter (for item in '(1 2 3))
  (collect (+ item 1)))
;; (2 3 4)

(iter (for i in-vector #(1 2 3))
  (collect (+ item 1)))
;; (2 3 4)
~~~

あるいは、リストとベクトルに対応する一般化された反復節として `in-sequence` を使います（速度面では不利になります）。

hash-table をループするのも簡単です。

~~~lisp
(let ((h (let ((h (make-hash-table)))
            (setf (gethash 'a h) 1)
            (setf (gethash 'b h) 2)
            h)))
   (iter (for (k v) in-hashtable h)
     (print k)))
;; =>
B
A
NIL
~~~

実際、次のものを反復する方法を知るには [こちら](https://common-lisp.net/project/iterate/doc/Sequence-Iteration.html) を見るか、`(display-iterate-clauses '(for))` を実行してください。

- シンボル: `in-package`
- ファイルまたはストリーム: `in-file` または `in-stream`
- 要素: `in-sequence`（シーケンスはベクトルまたはリストです）。

### リストをループする

#### dolist

~~~lisp
(dolist (item '(1 2 3))
  (print item))
;; =>
1
2
3
NIL
~~~

`dolist` は `nil` を返します。

#### loop

`in` を使う場合は驚くことはありません。

~~~lisp
(loop for x in '(a b c)
      do (print x))
;; =>
A
B
C
NIL
~~~

~~~lisp
(loop for x in '(a b c)
      collect x)
;; => (A B C)
~~~

`on` を使うと、リストの `cdr` をループします。

~~~lisp
(loop for i on '(1 2 3) collect i)
;; => ((1 2 3) (2 3) (3))
~~~


#### mapcar

~~~lisp
(mapcar (lambda (x)
          (* x 10))
        '(1 2 3))
;; (10 20 30)
~~~

`mapcar` は lambda 関数の結果をリストとして返します。

#### Series
~~~lisp
(iterate ((item (scan '(1 2 3))))
  (print item))
;; =>
1
2
3
NIL
~~~

`scan-sublists` は `loop for ... on` に相当します。

~~~lisp
(iterate ((i (scan-sublists '(1 2 3))))
  (print i))
;; =>
(1 2 3)
(2 3)
(3)
NIL
~~~

[​]{#vector--string-}
[​]{#vector-}

### ベクトルと文字列をループする

#### loop: `across`

~~~lisp
(loop for i across #(1 2 3) collect (+ i 1))
;; (2 3 4)
~~~

文字列はベクトルなので:

~~~lisp
(loop for i across "foo" do (format t "~a " i))
;; f o o
;; NIL
~~~

#### iterate: `in-vector`, `index-of-vector`, `in-string`

Iterate は配列を反復するために `in-vector` を使います。

```lisp
(iter (for i in-vector #(100 20 3))
      (sum i))
```

`index-of-vector` を使うと、ベクトルのインデックスを変数へ直接割り当てられます。

~~~lisp
(iter (for i index-of-vector  #(100 20 3))
      (format t "~a " i))
;; => 0 1 2
~~~

#### Series

~~~lisp
(iterate ((i (scan #(1 2 3))))
  (print i))
;; =>
1
2
3
NIL
~~~

[​]{#sequence-}

### 汎用シーケンスをループする

#### loop（該当なし）

`loop` には、任意の種類のシーケンスをループする単一のキーワードはありません。

#### iterate: `in-sequence`

iter では `in-sequence` を使って文字列やベクトル（したがってリストも）を反復できます。

これは専用の反復構文より遅くなることがあります。

~~~lisp
(iter (for i in-sequence "foo" )
      (format t "~a " i))
;; => f o o
;; NIL

(iter (for i in-sequence '(1 2 3))
      (format t "~a " i))
;; => 1 2 3
;; NIL

(iter (for i in-sequence #(100 20 3))
      (format t "~a " i))
;; => 100 20 3
;; NIL
~~~

### hash-table をループする

hash-table の反復は、`loop` や他の組み込み、`iterate`、その他のライブラリで可能です。

hash table の性質上、entry が提供される順序を制御することは _できない_ ことに注意してください。

以降の例のために hash-table を作りましょう。

~~~lisp
(defparameter *my-hash-table* (make-hash-table))
(setf (gethash 'a *my-hash-table*) 1)
(setf (gethash 'b *my-hash-table*) 2)
~~~

[​]{#key--value--loop-}
[​]{#key--loop-}

#### キーと値を `loop` する

キーをループするには、次のようにします。

~~~lisp
(loop :for k :being :the :hash-key :of *my-hash-table* :collect k)
;; (B A)
~~~

値をループする場合も考え方は同じですが、`:hash-key` の代わりに `:hash-value` keyword を使います。

~~~lisp
(loop :for v :being :the :hash-value :of *my-hash-table* :collect v)
;; (2 1)
~~~

キーと値の組をループします。

~~~lisp
(loop :for k :being :the :hash-key
        :using (hash-value v) :of *my-hash-table*
      :collect (list k v))
;; ((B 2) (A 1))
~~~


#### maphash

`maphash` のラムダ関数は 2 つの引数、キーと値を取ります。

~~~lisp
(maphash (lambda (key val)
           (format t "key: ~A value: ~A~%" key val))
         *my-hash-table*)
;; =>
key: A value: 1
key: B value: 2
NIL
~~~


#### with-hash-table-iterator

次のものも使えます。
[`with-hash-table-iterator`](http://www.lispworks.com/documentation/HyperSpec/Body/m_w_hash.htm),
これは（
[`macrolet`](http://www.lispworks.com/documentation/HyperSpec/Body/s_flet_.htm))
を経由して）第 1 引数をイテレータに変換するマクロです。このイテレータは呼び出されるたびに、ハッシュテーブルのエントリごとに 3 つの値を返します。

- エントリが返された場合に真になる一般化ブール値
- エントリのキー
- エントリの値

エントリがもうない場合は、`nil` という 1 つの値だけが返されます。

例:

~~~lisp
;;; 上と同じ hash-table
CL-USER> (with-hash-table-iterator (my-iterator *my-hash-table*)
           (loop
              (multiple-value-bind (entry-p key value)
                  (my-iterator)
                (if entry-p
                    (format t "The value associated with the key ~S is ~S~%" key value)
                    (return)))))
;; =>
The value associated with the key A is 1
The value associated with the key B is 2
NIL
~~~

HyperSpec の次の注意に留意してください。

> 反復の暗黙の内部状態のいずれかが、呼び出しフォームを閉じ込めたクロージャを返すなどして、`with-hash-table-iterator` フォームのダイナミックエクステントの外へ返された場合に何が起こるかは未規定です。

#### iterate: `in-hashtable`

`in-hashtable` を使います。

~~~lisp
(iter (for (k v) in-hashtable *my-hash-table*)
  (collect (list k v)))
;; ((B 2) (A 1))
~~~

#### Alexandria の `maphash-keys` と `maphash-values`

キーまたは値だけを変換するには、ここでも Alexandria の `maphash-keys` と `maphash-values` を利用できます。

#### Serapeum の `do-hash-table`

[Serapeum ライブラリ](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#hash-tables) には `do-hash-table` という do 風のマクロがあります。

    (do-hash-table (key value table &optional return) &body body)


#### for

`for` ライブラリでは `over` キーワードを使います。

~~~lisp
(for:for ((it over *my-hash-table*))
  (print it))
;; =>
(A 1)
(B 2)
NIL
~~~

#### trivial-do:dohash

この話題が好きなので、もう 1 つ [trivial-do](https://github.com/yitzchak/trivial-do/) というライブラリを紹介します。これは `dolist` に似た `dohash` マクロを持っています。

~~~lisp
(dohash (key value *my-hash-table*)
  (format t "key: ~A, value: ~A~%" key value))
;; =>
key: A value: 1
key: B value: 2
NIL
~~~

#### Series

~~~lisp
(iterate (((k v) (scan-hash *my-hash-table*)))
  (format t "~&~a ~a~%" k v))
;; =>
A 1
B 2
NIL
~~~

### 2 つのリストを並行してループする

#### loop

~~~lisp
(loop for x in '(a b c)
      for y in '(1 2 3)
      collect (list x y))
;; ((A 1) (B 2) (C 3))
~~~

平坦なリストを返すには、`collect` の代わりに `nconcing` を使います。

~~~lisp
(loop for x in '(a b c)
      for y in '(1 2 3)
      nconcing (list x y))
;; (A 1 B 2 C 3)
~~~

片方のリストがもう片方より短い場合、loop は短い方の末尾で停止します。

~~~lisp
(loop for x in '(a b c)
      for y in '(1 2 3 4 5)
      collect (list x y))
;; ((A 1) (B 2) (C 3))
~~~

最も長いリストをループし、短い方の要素へ index で手動アクセスすることもできますが、すぐに非効率になります。代わりに、短いリストを延長するよう `loop` に指示できます。

~~~lisp
(loop for y in '(1 2 3 4 5)
      for x-list = '(a b c) then (cdr x-list)
      for x = (or (car x-list) 'z)
      collect (list x y))
;; ((A 1) (B 2) (C 3) (Z 4) (Z 5))
~~~

コツは、`for … = … then (cdr …)` という記法（`=` と `then` の役割に注意）によって、各反復で中間リストが（`cdr` により）短くなることです。最初は初期値の `'(a b c)` で、次に `cdr` の `(b c)`、次に `(c)`、最後に `NIL` になります。そして `(car NIL)` と `(cdr NIL)` はどちらも `NIL` を返すので、うまくいきます。


#### mapcar
~~~lisp
(mapcar (lambda (x y)
          (list x y))
        '(a b c)
        '(1 2 3))
;; ((A 1) (B 2) (C 3))
~~~

または単純に:

~~~lisp
(mapcar 'list '(a b c) '(1 2 3))
;; ((A 1) (B 2) (C 3))
~~~

平坦なリストを返します。

~~~lisp
(mapcan 'list '(a b c) '(1 2 3))
;; (A 1 B 2 C 3)
~~~

#### Series
~~~lisp
(collect
  (#Mlist (scan '(a b c))
          (scan '(1 2 3))))
;; ((A 1) (B 2) (C 3))
~~~

リストの長さが等しいと分かっている場合、より効率的な方法です。

~~~lisp
(collect
  (mapping (((x y) (scan-multiple 'list
                                  '(a b c)
                                  '(1 2 3))))
    (list x y)))
;; ((A 1) (B 2) (C 3))
~~~

平坦なリストを返します。

~~~lisp
(collect-append ; または collect-nconc
  (mapping (((x y) (scan-multiple 'list
                                  '(a b c)
                                  '(1 2 3))))
    (list x y)))
;; (A 1 B 2 C 3)
~~~


### ネストしたループ
#### loop

~~~lisp
(loop for x from 1 to 3
      collect (loop for y from 1 to x collect y))
;; ((1) (1 2) (1 2 3))
~~~

平坦なリストを返すには、最初の `collect` の代わりに `nconcing` を使います。

#### iterate

~~~lisp
(iter outer
  (for i below 2)
  (iter (for j below 3)
     (in outer (collect (list i j)))))
;; ((0 0) (0 1) (0 2) (1 0) (1 1) (1 2))
~~~

#### Series

~~~lisp
(collect
  (mapping ((x (scan-range :from 1 :upto 3)))
    (collect (scan-range :from 1 :upto x))))
;; ((1) (1 2) (1 2 3))
~~~


### 中間値を計算する

#### loop

各反復で値を計算する必要があるなら、`for var = ...` を使います。

~~~lisp
(loop for x from 1 to 3
      for y = (* x 10)
      collect y)
;; (10 20 30)
~~~

値を 1 回だけ計算すればよいなら、`with var = ...` を使います。

~~~lisp
(loop for x from 1 to 3
      for y = (* x 10)
      with z = x
      collect (list x y z))
;; ((1 10 1) (2 20 1) (3 30 1))
~~~

HyperSpec は `with` 節を次のように定義しています。

    with-clause ::= with var1 [type-spec] [= form1] {and var2 [type-spec] [= form2]}*

そのため、`=` の前に型を指定し、`with` を `and` でつなげられることが分かります。

~~~lisp
(loop for x from 1 to 3
      for y integer = (* x 10)
      with z integer = x
      collect (list x y z))
;; ((1 10 1) (2 20 1) (3 30 1))
~~~

~~~lisp
(loop for x upto 3
      with foo = :foo
      and bar = :bar
      collect (list x foo bar))
;; ((0 :FOO :BAR) (1 :FOO :BAR) (2 :FOO :BAR) (3 :FOO :BAR))
~~~

`for` に、各反復で呼び出される `then` 節を与えることもできます。

~~~lisp
(loop repeat 3
      for x = 10 then (incf x)
      collect x)
;; (10 11 12)
~~~

boolean を交互に切り替える小技です。

~~~lisp
(loop repeat 4
      for up = t then (not up)
      collect up)
;; (T NIL T NIL)
~~~

### カウンタ付きのループ
#### loop
リストを反復し、カウンタも並行して反復させます。最初に終了した clause（この場合はリストの末尾に到達すること）が、反復の終了時点を決めます。2 組の action が定義され、そのうち 1 つが条件付きで実行されます。（`do` が `when`、`unless`、`if` clause の直後にある場合、その action は test が `t` を返したときだけ実行されます。）

~~~lisp
(loop for x in '(a b c d e)
      for firstp = t then nil
      unless firstp
        do (format t ", ")
      do (format t "~A" x))
;; =>
A, B, C, D, E
NIL
~~~

上のループは、`if` とカウンタ変数 `y` を使って書くこともできます。

~~~lisp
(loop for x in '(a b c d e)
      for y from 1
      if (> y 1)
        do (format t ", ~A" x)
      else
        do (format t "~A" x))
;; =>
A, B, C, D, E
NIL
~~~

#### Series

複数の series を並行して反復し、無限 range を使うことで、カウンタを作れます。

~~~lisp
(iterate ((x (scan '(a b c d e)))
          (y (scan-range :from 1)))
  (when (> y 1)
    (format t ", "))
  (format t "~A" x))
;; =>
A, B, C, D, E
NIL
~~~

### 昇順と降順、上限と下限: `to` と `below`, `downto` と `above`

#### loop

`from… to…`:

~~~lisp
(loop for i from 0 to 3 collect i)
;; (0 1 2 3)
~~~

`from… below…`: これは 2 で止まります。

~~~lisp
(loop for i from 0 below 3 collect i)
;; (0 1 2)
~~~

同様に、`(3 2 1 0)` を得るには `from 3 downto 0` を使い、`(3 2 1)` を得るには `from 3 above 0` を使います。

#### Series

`:from ... :upto` は上限を含みます。

~~~lisp
(iterate ((i (scan-range :from 0 :upto 3)))
  (print i))
;; =>
0
1
2
3
NIL
~~~

`:from ... :below` は上限を含みません。

~~~lisp
(iterate ((i (scan-range :from 0 :below 3)))
  (print i))
;; =>
0
1
2
NIL
~~~


### ステップ
#### loop

`by` を使います。

~~~lisp
(loop for i from 1 to 10 by 2 collect i)
;; (1 3 5 7 9)
~~~

step clause は 1 回だけ評価されます。`by (1+ (random 3))` を使うと、次と同等です。

~~~lisp
(let ((step (1+ (random 3))))
  (loop for i from 1 to 10 by step
        do (print i)))
...
~~~

step は常に正の数でなければなりません。カウントダウンしたい場合は上を参照してください。

#### Series

`:by` を使います。

~~~lisp
(iterate ((i (scan-range :from 1 :upto 10 :by 2)))
  (print i))
~~~


### ループと条件分岐
#### loop

`if`、`else`、`finally` を使います。

~~~lisp
*(loop repeat 10
       for x = (random 100)
       if (evenp x)
         collect x into evens
       else
         collect x into odds
       finally (return (values evens odds)))
;; =>
(92 44 58 68)
(95 5 97 43 99 37)
~~~

```
(42 82 24 92 92)
(55 89 59 13 49)
```

`if` 本体で複数の clause を組み合わせるには、特別な構文（`and do`、`and count`）が必要です。

~~~lisp
(loop repeat 10
      for x = (random 100)
      if (evenp x)
        collect x into evens
        and do (format t "~a is even!~%" x)
      else
        collect x into odds
        and count t into n-odds
      finally (return (values evens odds n-odds)))
;; =>
46 is even!
8 is even!
76 is even!
58 is even!
0 is even!
(46 8 76 58 0)
(7 45 43 15 69)
5
~~~

#### iterate

上の例を iterate で翻訳する（あるいは最初から書く）のは分かりやすいです。

~~~lisp
(iter (repeat 10)
   (for x = (random 100))
   (if (evenp x)
       (progn
         (collect x into evens)
         (format t "~a is even!~%" x))
       (progn
         (collect x into odds)
         (count t into n-odds)))
   (finally (return (values evens odds n-odds))))
...
~~~

#### Series

前のループは Series では少し違った形になります。`split` は、与えられた boolean series に従って 1 つの series を複数に振り分けます。

~~~lisp
(let* ((number (#M(lambda (n)
                     (declare (ignore n))
                     (random 100))
                  (scan-range :below 10)))
       (parity (#Mevenp number)))
  (iterate ((n number) (p parity))
    (when p (format t "~a is even!~%" n)))
  (multiple-value-bind (evens odds) (split number parity)
    (values (collect evens)
            (collect odds)
            (collect-length odds))))
;; =>
24 is even!
92 is even!
92 is even!
46 is even!
(24 92 92 46)
(89 59 13 49 7 45)
6
~~~

`iterate` と 3 つの `collect` 式は逐次的に書かれていますが、実行される反復は `loop` の例と同じく 1 回だけであることに注意してください。

### clause でループを開始する（initially）

~~~lisp
(loop initially (format t "~a " 'loop-begin)
      for x below 3
      do (format t "~a " x))
;; =>
LOOP-BEGIN 0 1 2
NIL
~~~

`initially` form は loop code 全体の前、ループの「prologue」で評価されます。ループの終わりに対応するものは `finally` です。

その直後の `:for`、`:with`、`:as` clause で宣言された変数を変更しようとしても、*loop body の中では* 効果がありません。たとえば、下の initially で a と b を変更しようとすると次のようになります。

~~~lisp
(loop with a = 20 with b = 10
     initially (rotatef a b)  ;; 警告: a と b には遅すぎる。効果なし。
     for i from a to b
  do (print i))
;; => NIL
~~~

これは 10 から 20 までループするのに間に合うようには a と b を交換しません。20 から 10 へループすることになり、結果としてまったくループせず NIL を返します。

ただし、ループの最後で a と b の値を表示すると（`finally (format t "a is ~a, b is ~a" a b)` を試してください）、それらの値は交換されていることが分かります。なぜそうなるかを完全に理解するには、この loop snippet を macro-expand する必要があります（中間変数があります）。

`initially` は `iterate` にも存在します。


### test でループを終了する（until, while）
#### loop

~~~lisp
(loop for x in '(1 2 3 4 5)
      until (> x 3)
        collect x)
;; (1 2 3)
~~~

`while` を使っても同じです。

~~~lisp
(loop for x in '(1 2 3 4 5)
      while (< x 4)
        collect x)
;; (1 2 3)
~~~

#### Series

`until-if` で series を切り詰め、その結果から collect します。

~~~lisp
(collect
  (until-if (lambda (i) (> i 3))
            (scan '(1 2 3 4 5))))
;; (1 2 3)
~~~

### ループし、表示し、結果を返す
#### loop

`do` と `collect` は 1 つの式で組み合わせられます。

~~~lisp
(loop for x in '(1 2 3 4 5)
      while (< x 4)
        do (format t "x is ~a~&" x)
      collect x)
;; =>
x is 1
x is 2
x is 3
(1 2 3)
~~~

#### Series
mapping によって、副作用を実行しつつ item を collect できます。

~~~lisp
(collect
  (mapping ((x (until-if (complement (lambda (x) (< x 4)))
                         (scan '(1 2 3 4 5)))))
    (format t "x is ~a~&" x)
    x))
;; =>
x is 1
x is 2
x is 3
(1 2 3)
~~~


### 名前付きループと早期脱出
#### loop

特別な `loop named` 構文を使うと、`return-from` でループから早期脱出するために使える block を作れます。これは特にネストしたループで便利です。


~~~lisp
(loop named loop-1
      for x from 0 to 10 by 2
      do (loop for y from 0 to 100 by (1+ (random 3))
               when (< x y)
                 do (return-from loop-1 (values x y))))
;; =>
0
2
~~~

早期に返したいが、それでも `finally` clause は実行したいことがあります。その場合は [`loop-finish`](http://www.lispworks.com/documentation/HyperSpec/Body/m_loop_f.htm#loop-finish) を使います。

~~~lisp
(loop for x from 0 to 100
  do (print x)
  when (>= x 3)
    return x
  finally (print :done))  ;; <-- 表示されない
;; =»
0
1
2
3
3

(loop for x from 0 to 100
      do (print x)
      when (>= x 3)
        do (loop-finish)
      finally (print :done)
              (return x))
;; =>
0
1
2
3
:DONE
3
~~~

これは、何らかの計算を `finally` clause で行わなければならないときに最も必要になります。

#### when/return のための loop 省略形: thereis, never, always

いくつかの action は when/return の組み合わせに対する省略形を提供します。

~~~lisp
(loop for x in '(foo 2)
      thereis (numberp x))
;; T
~~~

~~~lisp
(loop for x in '(foo 2)
      never (numberp x))
;; NIL
~~~

~~~lisp
(loop for x in '(foo 2)
      always (numberp x))
;; NIL
~~~

これらは関数 `some`、`notany`、`every` に対応します。

~~~lisp
(some #'numberp '(foo 2))   => T
(notany #'numberp '(foo 2)) => NIL
(every #'numberp '(foo 2))  => NIL
~~~


#### Series

反復から早期に脱出するには、`return-from` で使う block を明示的に作ります。

~~~lisp
(block loop-1
  (iterate ((x (scan-range :from 0 :upto 10 :by 2)))
    (iterate ((y (scan-range :from 0 :upto 100 :by (1+ (random 3)))))
      (when (< x y)
        (return-from loop-1 (values x y))))))
;; =>
0
3
~~~

### 数える
#### loop
~~~lisp
(loop for i from 1 to 3 count (oddp i))
;; 2
~~~

#### Series
~~~lisp
(collect-length (choose-if #'oddp (scan-range :from 1 :upto 3)))
;; 2
~~~

### 合計
#### loop

~~~lisp
(loop for i from 1 to 3 sum (* i i))
;; 14
~~~

変数へ合計します。

~~~lisp
(loop for i from 1 to 3
      sum (* i i) into total
      do (print i)
      finally (return total))
;; =>
1
2
3
14
~~~


#### Series

~~~lisp
(collect-sum (#M(lambda (i) (* i i))
                (scan-range :from 1 :upto 3)))
;; 14
~~~

### max, min

#### loop

~~~lisp
(loop for i from 1 to 3 maximize (mod i 3))
;; 2
~~~

そして `minimize` があります。

#### Series

~~~lisp
(collect-max (#M(lambda (i) (mod i 3))
                (scan-range :from 1 :upto 3)))
;; 2
~~~
そして `collect-min` があります。

### 分配束縛、つまりリストや dotted pair に対するパターンマッチ

#### loop

~~~lisp
(loop for (a b) in '((x 1) (y 2) (z 3))
      collect (list b a))
;; ((1 X) (2 Y) (3 Z))
~~~

項を無視するには `nil` を使います。

~~~lisp
(loop for (nil . y) in '((1 . a) (2 . b) (3 . c)) collect y)
;; (A B C)
~~~

##### plist を反復する、またはリストを 2 要素ずつ反復する

リストを 2 item ずつ反復するには、`on`、`by`、destructuring を組み合わせます。

リストの残り（`cdr`）をループするために `on` を使います。

~~~lisp
(loop for rest on '(a 2 b 2 c 3)
      collect rest)
;; ((A 2 B 2 C 3) (2 B 2 C 3) (B 2 C 3) (2 C 3) (C 3) (3))
~~~

各反復で 1 element を飛ばすために `by` を使います（`(cddr list)` は `(rest (rest list))` と等価です）。

~~~lisp
(loop for rest on '(a 2 b 2 c 3) by #'cddr
      collect rest)
;; ((A 2 B 2 C 3) (B 2 C 3) (C 3))
~~~

次に destructuring を加えて、各反復で最初の 2 item だけを束縛します。

~~~lisp
(loop for (key value) on '(a 2 b 2 c 3) by #'cddr
      collect (list key (* 2 value)))
;; ((A 2) (B 4) (C 6))
~~~


#### Series
一般には `destructuring-bind` を使います。

~~~lisp
(collect
  (mapping ((l (scan '((x 1) (y 2) (z 3)))))
    (destructuring-bind (a b) l
      (list b a))))
~~~

ただし alist には `scan-alist` が用意されています。

~~~lisp
(collect
  (mapping (((a b) (scan-alist '((1 . a) (2 . b) (3 . c)))))
    (declare (ignore a))
    b))
;; (A B C)
~~~

### 変数の型を宣言する

型を宣言すると、compiler がコードを最適化する助けになります。SBCL はこれが得意なことで有名です。

machine code が最適化されたかどうかは、`disassembly` を呼び出して確認できます。

#### Loop

`:of-type` を使います。

~~~lisp
(loop :for i :of-type fixnum :below 10
   :for j :of-type fixnum :from 1
   :sum (* i j))
~~~

`fixnum`、`float`、`t`、`nil` のような単純な型では、`:of-type` を省略できます。

~~~lisp
(loop :for i fixnum :below 10
   :for j fixnum :from 1
   :sum (* i j))
~~~

`sum` や他の accumulation clause の後に型を指定することもできます。

~~~lisp
(loop for i fixnum below 10
   for j fixnum from 1
   sum (* i j) fixnum)
~~~

#### Iterate

`(declare (fixnum i))` を使います。

~~~lisp
(iter (for i below 10)
      (for j from 1)
      (declare (fixnum i))
      (sum (* i j)))
~~~


## loop にはない Iterate 固有の機能

Iterate には他にも固有の機能があります。

Common Lisp の初心者であれば、この節は後回しにしてまったく問題ありません。これらの機能に頼らずに Lisp を使い続けることも十分できます。ただし、いつか役に立つかもしれません。


### clause の順序が厳密でない

`loop` では、すべての `for` clause が loop body より前、たとえば `while` より前に現れる必要があります。`iter` ではこの順序に従わなくても問題ありません。

~~~lisp
(iter (for x in '(1 2 99))
  (while (< x 10))
  (for y = (print x))
  (collect (list x y)))
;; =>
1
2
((1 1) (2 2))
~~~

### accumulating clause をネストできる

`collect`、`appending`、その他の accumulating clause はどこにでも現れられます。

~~~lisp
(iter (for x in '(1 2 3))
  (case x
    (1 (collect :a))
    ;;  ^^ iter keyword。s-expression の中にネストされている。
    (2 (collect :b))))
~~~

### finder: `finding`

`iterate` には [finder](https://common-lisp.net/project/iterate/doc/Finders.html#Finders) があります。

> finder は、値が何らかの条件を満たす式である clause です。

`finding` の後に `maximizing`、`minimizing`、`such-that` を続けて使えます。

リストのリストから最長のリストを見つける方法です。

~~~lisp
(iter (for elt in '((a) (b c d) (e f)))
      (finding elt maximizing (length elt)))
;; (B C D)
~~~

LOOP でおおよそ同等のものを書くと次のようになります。

~~~lisp
(loop with max-elt = nil
      with max-key = 0
      for elt in '((a) (b c d) (e f))
      for key = (length elt)
      do
      (when (> key max-key)
        (setf max-elt elt
              max-key key))
      finally (return max-elt))
;; (B C D)
~~~

`such-that` clause は複数あってもかまいません。

~~~lisp
(iter (for i in '(7 -4 2 -3))
      (if (plusp i)
          (finding i such-that (evenp i))
        (finding (- i) such-that (oddp i))))
;; 2
~~~

`such-that #'evenp` や `such-that #'oddp` とも書けます。**`such-that 'oddp` は動作しないことに注意してください。**


### 制御フロー: `next-iteration`

これは "continue" のようなもので、loop にはありません。

> loop body の残りを飛ばし、ループの次の反復を開始します。

`iterate` には `first-iteration-p` と `(if-first-time then else)` もあります。

[control flow](https://common-lisp.net/project/iterate/doc/Control-Flow.html#Control-Flow) を参照してください。


### generator

generator は lazy で、明示的に指示されたときに次の値へ進みます。

`generate` と `next` を使います。

~~~lisp
(iter (for i in '(1 2 3 4 5))
      (generate c in-string "black")
      (if (oddp i) (next c))
      (format t "~a " c))
;; =>
b b l l a
NIL
~~~

### 変数のバックトラック（`previous`）VS 並行束縛

`iterate` では、変数の前回の値を取得できます。

~~~lisp
(iter (for el in '(a b c d e))
      (for prev-el previous el)
      (collect (list el prev-el)))
;; ((A NIL) (B A) (C B) (D C) (E D))
~~~

ただしこの場合は、`iterate` ではサポートされない `loop` の並行束縛 `and` を使っても実現できます。

~~~lisp
(loop for el in '(a b c d e)
      and prev-el = nil then el
      collect (list el prev-el))
;; ((A NIL) (B A) (C B) (D C) (E D))
~~~

### さらに多くの clause

- `in-string` は文字列を 1 文字ずつ反復するために明示的に使えます。loop では `across` を使います。

~~~lisp
(iter (for c in-string "hello")
      (collect c))
;; (#\h #\e #\l #\l #\o)
~~~

- `loop` は `collecting`、`nconcing`、`appending` を提供します。`iterate` はこれらに加えて、`adjoining`、`unioning`、`nunioning`、`accumulating` も持ちます。

~~~lisp
(iter (for el in '(a b c a d b))
      (adjoining el))
;; (A B C D)
~~~

（`adjoin` は集合操作です。）

- `loop` には `summing`、`counting`、`maximizing`、`minimizing` があります。`iterate` にはさらに `multiplying` と `reducing` もあります。Reducing は一般化された reduction builder です。

~~~lisp
(iter (with dividend = 100)
      (for divisor in '(10 5 2))
      (reducing divisor by #'/ initial-value dividend))
;; 1
~~~


### Iterate は拡張可能

~~~lisp
(defmacro dividing-by (num &key (initial-value 0))
  `(reducing ,num by #'/ initial-value ,initial-value))
;; DIVIDING-BY

(iter (for i in '(10 5 2))
      (dividing-by i :initial-value 100))
;; 1
~~~

ただし [さらに多くの内容があります。documentation を参照してください](https://common-lisp.net/project/iterate/doc/Rolling-Your-Own.html#Rolling-Your-Own)。

[CLSQL](http://clsql.kpe.io/manual/loop-tuples.html) のように `loop` を拡張するライブラリも見ましたが、それらは feature flag check（`#+(or allegro clisp-aloop cmu openmcl
sbcl scl)`）だらけで、内部 module（`ansi-loop::add-loop-path`、`sb-loop::add-loop-path` など）を呼び出します。

## do と do*, tagbody と go: 汎用で低レベルな反復構文

組み込みの `do` マクロは汎用の primitive です。

実際には、日常的な用途では `loop`、`dotimes`、その仲間の方がよく使われます。`do` は、複数の stepping 変数を明示的に制御したいとき、反復本体で tag と `go` を使いたいとき、あるいは独自の反復構文を作るためにマクロ内で使う際に `loop` DSL より Lisp らしい括弧を好むときに便利です。

初心者としては、`do` をすぐに学ぶ *必要* はありませんが、いつか戻ってくるべきです。

### `do` の構造

`do` は次のものから構成されます。

- 変数を定義し、必要に応じて初期値と反復方法を指定する束縛のリスト
- 次を含むリスト
  - test form: true に評価されると反復が停止します。
  - 反復の結果として返すもの。単純な form 1 つでも複数でも構いません。暗黙の progn で包まれます。
- macro body

下の例では、マクロ body 内で `i` に束縛される 1 つの変数だけを step します。0 から始まり、各反復で `(1+ i)` の結果を得ます。

`(>= i 5)` が true になると反復は終了し、`i` を返します。

~~~lisp
(do ((i 0 (1+ i)))  ;; <-- var + init form + step form
                    ;;     これ以上の束縛はない
    ((>= i 5) i)    ;; <-- test form + result
  (print i))
;; =>
0
1
2
3
4
;; => 5
~~~

0 から 4 を表示し、5 を返していることに注意してください。最後の反復の冒頭で step form が評価され、`i` が 5 に束縛され、その後 test form `(>= i 5)` が true になったので、数値 5 が返されました。

この snippet は次と等価です。

```lisp
(loop for i from 0 below 5
  do (print i)
  finally (return i))
```

複数の変数を並行して step できます。ここで「並行」とは、`let` と同じく、作られるときに互いを見ないこと、そして各 step で *互いの新しい値* を見ないことを意味します。

この例では、`i` と `j` という 2 つの束縛を更新します。

~~~lisp
(do ((i 0 (1+ i))
     (j 10 (- 10 i)))
    ((>= i 5) (list i j))
  (format t "i=~a j=~a~%" i j))
~~~

indentation と、それらを囲む括弧の組に注意してください。別の indentation にすると次のようになります。

~~~lisp
(do (
     (i 0  (1+ i))
     (j 10 (- 10 i))
    ; ^ ^^ ^^^
    ; var init step
    )
    …
~~~

`j` の initialization form が `i` に依存していないことを見てください。`j` は step form でだけ `i` を使います。

結果は次のとおりです。

```
i=0 j=10
i=1 j=10
i=2 j=9
i=3 j=8
i=4 j=7
;; => (5 6)
```

`do*` マクロとの違いは下を読んでください。


### 複数の result form

上の例では、単に `i`、`j`、`(list i j)` を返していました。これらは 1 つの Lisp form です。

複数の result form を書けます。それらは `progn` で包まれているかのように評価されます。したがって、最後の式の結果が返されます。

~~~lisp
(do* ((i 0 (1+ i)))
      ((>= i 5) (print "hey it's time to return") i i i)
      ;;        ^^   PROGN 内にあるかのような result form    ^^
    (print i))
…
;; => 5
~~~


### `do*`: `let*` のように文を逐次的に反復する

`do*` は似ていますが、`let*` のように変数を逐次的に束縛します（各変数は初期化フォームで前の変数を参照できます）。また、各更新の冒頭で、各変数は他の束縛の *新しい値* を参照します。

上と同じ例を `do*` で書くと次のようになります。

~~~lisp
(do* ((i 0 (1+ i))
      (j 10 (- 10 i)))
     ((>= i 5) (list i j))
  (format t "i=~a j=~a~%" i j))
;; =>
i=0 j=10
i=1 j=9
i=2 j=8
i=3 j=7
i=4 j=6
;; => (5 5)
~~~

結果が異なることを見てください。2 回目の反復（initialization step の後の最初の反復）の冒頭で `i` は 1 です。逐次束縛のため、`j` は以前の値 0 ではなく、*今は* `i` を 1 として見るので、`j` は 9 になります。

また、`do` を使った次の例は、`j` が initialization form で `i` を参照しているため compile できません。`do*` を使うべきでした。

~~~lisp
;; COMPILE できない。DO* を使う
(do ((i 0 (1+ i))
     (j i (* 2 i)))
     ;; ^^ 前の束縛を参照している。
    ((>= i 5) i)
  (format t "i is ~a, j is ~a~&" i j))
~~~

コンパイル警告が表示されます。

> ; caught WARNING:
>;   undefined variable: COMMON-LISP-USER::I

それでも REPL で実行すると、"The 変数 I is unbound." という runtime エラーになります。

`do*` を使えます。


### 暗黙の `block`: `return` を使う

`do/do*` は、`nil` という名前の暗黙の `block` で囲まれています。

その結果、`(return)` を使えます（暗黙に nil という名前の block から return します。そうでなければ `return-from block-name` を使うことになります）。

~~~lisp
(do* ((i 0 (1+ i))
      (j i (* 2 i)))
     ((>= i 5) i)
  (when (> i 2)
    (return i))   ;; <----- return が動作する
  (format t "i is ~a, j is ~a~&" i j))

i is 0, j is 0
i is 1, j is 2
i is 2, j is 4
;; => 3
~~~

### 暗黙の `tagbody`: `go` を使う

`do/do*` の body は暗黙の `tagbody` で包まれています。

macro-expansion で確認しましょう。

```lisp
(macroexpand-1 '(do ((i 0 (1+ i)))
    ((>= i 5) i)
  (print i))
  )

(BLOCK NIL
  (LET* ((I 0))
    (DECLARE (IGNORABLE I))
    (TAGBODY
      (GO #:G318)
     #:G317
      (TAGBODY (PRINT I))
      (PSETQ I (1+ I))
     #:G318
      (UNLESS (>= I 5) (GO #:G317))
      (RETURN-FROM NIL (PROGN I)))))
```

つまり、反復 body の中で tag と `go` を使えます。

~~~lisp
(do ((i 0 (1+ i)))
     ((>= i 5) i)

  ;; body の開始。

  (when (= i 1)
    (go tag1))
  (when (= i 2)
    (go tag2))

  (go end)

 tag1      ;; <---------- 暗黙の tagbody 内の tag。
  (print "hello tag 1")
  (go end)

 tag2
  (print "hello tag 2")
  (go end)

 end
  (print i)
  )
~~~

これは次を出力します。

~~~lisp
0
"hello tag 1"
1
"hello tag 2"
2
3
4
;; => 5
~~~

tag を賢く使う方法は読者への練習問題として残します。ただし初心者向けではありません。

### 初心者に `do` は必要か

`do` を使うべきでしょうか。好きなものを使ってください。ただし初心者なら、まず `dotimes`、`dolist`、そして危ないことができる程度の `loop` を学びましょう。`loop` だけでも長くやっていけます。

- 詳しくは [Community Spec](https://cl-community-spec.github.io/pages/do.html) を読んでください。

## 独自の series scanner

同じ種類のオブジェクトをよく scan するなら、そのための独自 scanner を書けます。反復そのものを切り出せるということです。上の 2 要素リストのリストを scan する例を使い、1 番目の element の series と 2 番目の element の series を返す scanner を書きます。

~~~lisp
(defun scan-listlist (listlist)
  (declare (optimizable-series-function 2))
  (map-fn '(values t t)
          (lambda (l)
            (destructuring-bind (a b) l
              (values a b)))
          (scan listlist)))

(collect
  (mapping (((a b) (scan-listlist '((x 1) (y 2) (z 3)))))
    (list b a)))
~~~

## より短い series 式

次の series 式を考えます。

~~~lisp
(collect-sum (mapping ((i (scan-range :length 5)))
                    (* i 2)))
~~~

これは必要以上に少し長くなっています。`mapping` form の唯一の目的は変数 `i` を束縛することで、`i` は 1 か所でしか使われていません。Series には、この式を次のように単純化できる「隠れ機能」があります。

~~~lisp
(collect-sum (* 2 (scan-range :length 5)))
~~~

これは implicit mapping と呼ばれ、`series::install` の呼び出しで有効化できます。

~~~lisp
(series::install :implicit-map t)
~~~

implicit mapping を使う場合、上で示した `#M` reader マクロは不要になります。

## Loop の落とし穴

- 関数型構文でよく使われる keyword `it` は、loop keyword として認識されることがあります。loop の中では使わないでください。

~~~lisp
(loop for i from 1 to 5 when (evenp i) collect it)
;; (T T)
~~~

## Iterate の落とし穴

関数 `count` で壊れます。

~~~lisp
(iter (for i from 1 to 10)
      (sum (count i '(1 3 5))))
~~~

組み込みの `count` 関数を認識せず、代わりにコンディションを通知します。

`loop` では動作します。

~~~lisp
(loop for i from 1 to 10
    sum (count i '(1 3 5 99)))
;; 3
~~~


## 付録: loop keyword の一覧

**Name Clause**

```
named
```

**Variable Clauses**

```
initially finally for as with
```

**Main Clauses**

```
do collect collecting append
appending nconc nconcing into count
counting sum summing maximize return loop-finish
maximizing minimize minimizing doing
thereis always never if when
unless repeat while until
```

これらは clause を導入しません。

```
= and it else end from upfrom
above below to upto downto downfrom
in on then across being each the hash-key
hash-keys of using hash-value hash-values
symbol symbols present-symbol
present-symbols external-symbol
external-symbols fixnum float t nil of-type
```

ただし、何が keyword であるかを決めるのは parsing であることに注意してください。たとえば次では:

~~~lisp
(loop for key in hash-values)
~~~

`for` と `in` だけが keyword です。


©Dan Robertson on [Stack Overflow](https://stackoverflow.com/questions/52236803/list-of-loop-keywords).

## クレジットと参考文献

### Loop

* [Tutorial for the Common Lisp Loop Macro](http://www.ai.sri.com/pkarp/loop.html) by Peter D. Karp
* [Common Lisp's Loop Macro Examples for Beginners](http://www.unixuser.org/~euske/doc/cl/loop.html) by Yusuke Shinyama
* [Section 6.1 The LOOP Facility, of the draft Common Lisp Standard (X3J13/94-101R)](https://gitlab.com/vancan1ty/clstandard_build) - （draft）standard は Loop の開発、仕様、例についての背景情報を提供しています。[Single PDF file available](https://gitlab.com/vancan1ty/clstandard_build/-/blob/master/cl-ansi-standard-draft-w-sidebar.pdf)
* [26. Loop by Jon L White, edited and expanded by Guy L. Steele Jr.](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node235.html) - "Common Lisp the Language, 2nd Edition" から。上の draft と強く関連し、補足コメントと例を含みます。

### Iterate

* [The Iterate Manual](https://common-lisp.net/project/iterate/doc/index.html) - by Jonathan Amsterdam and Luís Oliveira
* [iterate - Pseudocodic Iteration](https://common-lisp-libraries.readthedocs.io/iterate/) - by Shubhamkar Ayare
* [Loop v Iterate - SabraOnTheHill](https://sites.google.com/site/sabraonthehill/loop-v-iter)
* [Comparing loop and iterate](https://web.archive.org/web/20170713081006/https://items.sjbach.com/211/comparing-loop-and-iterate) - by Stephen Bach（web archive）

### Series

* [Common Lisp the Language (2nd Edition) - Appendix A. Series](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node347.html)
* [SERIES for Common Lisp - Richard C. Waters](http://series.sourceforge.net/)

### その他

* 関連項目: [more functional constructs](https://lisp-journey.gitlab.io/blog/snippets-functional-style-more/)（do-repeat, take,…）
 
#  多次元配列 {#chapter-arrays}
 

Common Lisp は多次元配列をネイティブにサポートしており、1 次元配列には「ベクトル」という特別な扱いがあります。配列は汎用化されており、任意の型（`element-type t`）の要素を含められます。また、`single-float` や `integer` など、特定の型の要素だけを含むよう特殊化することもできます。出発点としては、Peter Seibel による [Practical Common Lisp 第11章「コレクション」](http://www.gigamonkeys.com/book/collections.html) がよいでしょう。

配列に対する一般的な操作の早見表は、[配列とベクトル](#chapter-data-structures) の節にあります。

配列を操作するために [Quicklisp](https://www.quicklisp.org/beta/) で利用できるライブラリには、次のものがあります。

- [array-operations](https://github.com/Lisp-Stat/array-operations) は Lisp-Stat プロジェクトに由来し、
  `generate`, `permute`, `displace`, `flatten`, `split`,
  `combine`, `reshape` 関数を定義します。また、要素ごとの
  演算に使う `each` も定義します。これは [bendudson/array-operations](https://github.com/bendudson/array-operations) のフォークであり、さらにこれは原作者による [tpapp/array-operations](https://github.com/tpapp/array-operations) から派生しています。
- [cmu-infix](https://github.com/rigetticomputing/cmu-infix) は、
  多次元配列用の添字構文を含みます。
- [lla](https://github.com/tpapp/lla) は線形代数用ライブラリで、BLAS と LAPACK
  ライブラリを呼び出します。多くの Common Lisp 線形代数パッケージと違って
  直感的な関数名を使い、ネイティブ配列だけでなく
  CLOS オブジェクトに対しても動作できます。

このページでは組み込みの多次元配列でできることを扱いますが、制限もあります。特に次の点です。

* 外部言語の配列との相互運用性。たとえば BLAS、LAPACK、GSL のようなライブラリを呼び出す場合です。
* 算術演算子やその他の数学演算子を、配列も扱えるように拡張すること。たとえば `a` や `b` が配列のときに `(+ a b)` が動作するようにする場合です。

これら 2 つの問題は、ネイティブ配列を特殊なケースとして持つ拡張配列クラスを CLOS で定義することで解決できます。この手法を採用し、[Quicklisp](https://www.quicklisp.org/beta/) 経由で利用できるライブラリには、次のものがあります。

* [matlisp](https://github.com/bharath1097/matlisp/)。その一部は
  下の節で説明します。
* [MGL-MAT](https://github.com/melisgl/mgl-mat)。マニュアルがあり、
  BLAS と CUDA へのバインディングを提供します。これは機械学習ライブラリ
  [MGL](https://github.com/melisgl/mgl) で使われています。
* [cl-ana](https://github.com/ghollisjr/cl-ana/wiki)。マニュアル付きのデータ分析
パッケージで、配列に対する操作を含みます。
* [Antik](https://www.common-lisp.net/project/antik/)。GNU Scientific Library（GNU 科学技術計算ライブラリ）
  へのバインディングである [GSLL](https://common-lisp.net/project/gsll/) で使われています。

比較的新しく活発に開発されているパッケージとして [MAGICL](https://github.com/rigetticomputing/magicl) があります。これは BLAS と LAPACK ライブラリのラッパーを提供します。執筆時点ではこのパッケージは Quicklisp に含まれておらず、SBCL と CCL でのみ動きます。特に複素配列に焦点を当てているようですが、それだけに限定されているわけではありません。インストールするには、たとえば Linux/Unix では Quicklisp の `local-projects` ディレクトリにリポジトリをクローンします。

~~~bash
$ cd ~/quicklisp/local-projects
$ git clone https://github.com/rigetticomputing/magicl.git
~~~

依存ライブラリ（BLAS、LAPACK、Expokit）のインストール手順は [GitHub のページ](https://github.com/rigetticomputing/magicl)にあります。低水準ルーチンは外部関数をラップしているため、たとえば `magicl.lapack-cffi::%zgetrf` のような Fortran の名前を持ちます。これらの関数の一部には高水準インターフェイスも存在します。[ソースディレクトリ](https://github.com/rigetti/magicl/blob/master/src/high-level/)と[ドキュメント](https://github.com/quil-lang/magicl/blob/master/doc/high-level.md)を参照してください。

さらに、Common Lisp 上に構築されたドメイン固有言語を、配列を使った数値計算に利用できます。執筆時点で、これらの中でも最も広く使われ、活発にサポートされているものは次のとおりです。

* [Maxima](http://maxima.sourceforge.net/documentation.html)
* [Axiom](https://github.com/daly/axiom)


[CLASP](https://github.com/drmeister/clasp) は、[LLVM](http://llvm.org/) を使って Common Lisp と他の言語（特に C++）との相互運用を容易にすることを目指すプロジェクトです。このプロジェクトの主要な用途の 1 つが、数値計算と科学技術計算です。

## 作成

関数 [CLHS: make-array](http://clhs.lisp.se/Body/f_mk_ar.htm) は、単一の値で満たされた配列を作成できます。

~~~lisp
* (defparameter *my-array* (make-array '(3 2) :initial-element 1.0))
*MY-ARRAY*
* *my-array*
#2A((1.0 1.0) (1.0 1.0) (1.0 1.0))
~~~

より複雑な配列値は、まず配列を作り、その後、各要素を反復して値を埋めることで生成できます（要素へのアクセスについては下の節を参照してください）。

[array-operations](https://github.com/tpapp/array-operations) ライブラリは、この反復処理をラップして配列を作成する便利な関数 `generate` を提供します。

~~~lisp
* (ql:quickload :array-operations)
To load "array-operations":
  Load 1 ASDF system:
    array-operations
; Loading "array-operations"

(:ARRAY-OPERATIONS)

* (aops:generate #'identity 7 :position)
#(0 1 2 3 4 5 6)
~~~

`array-operations` のニックネームは `aops` です。`generate` 関数はキー `:subscripts` を渡すことで配列の添字も反復できます。さらに多くの例は [array-operations の `generate` マニュアル](https://lisp-stat.dev/docs/manuals/array-operations/#generate) を参照してください。

### 乱数

一様分布から得た乱数を含む 3 × 3 配列を作るには、`generate` から Common Lisp の [random](http://clhs.lisp.se/Body/f_random.htm) 関数を呼び出します。

~~~lisp
* (aops:generate (lambda () (random 1.0)) '(3 3))
#2A((0.99292254 0.929777 0.93538976)
    (0.31522608 0.45167792 0.9411855)
    (0.96221936 0.9143338 0.21972346))
~~~

[Alexandria](https://common-lisp.net/project/alexandria/) パッケージを使って、平均 0、標準偏差 1 のガウス分布（正規分布）に従う乱数の配列を作る例です。

~~~lisp
* (ql:quickload :alexandria)
To load "alexandria":
  Load 1 ASDF system:
    alexandria
; Loading "alexandria"

(:ALEXANDRIA)

* (aops:generate #'alexandria:gaussian-random 4)
#(0.5522547885338768d0 -1.2564808468164517d0 0.9488161476129733d0
  -0.10372852118266523d0)
~~~

これは特に効率的ではないことに注意してください。要素ごとに関数呼び出しが必要であり、`gaussian-random` は 2 つの乱数を返しますが、そのうち 1 つしか使われません。

より効率的な実装や、より広い範囲の確率分布を扱うために、Quicklisp で利用できるパッケージがあります。一覧は [CLiki](https://www.cliki.net/statistics) を参照してください。

[​]{#element--access}

## 要素へのアクセス

配列の個々の要素にアクセスするには、[aref](http://clhs.lisp.se/Body/f_aref.htm) と [row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) 関数があります。

[aref](http://clhs.lisp.se/Body/f_aref.htm) 関数は、配列の次元数と同じ数のインデックス引数を取ります。インデックスは 0 から始まります。要素の格納順序は C と同じ行優先ですが、Fortran とは異なります。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (aref *a* 0)
1
* (aref *a* 3)
4
* (defparameter *b* #2A((1 2 3) (4 5 6)))
*B*
* (aref *b* 1 0)
4
* (aref *b* 0 2)
3
~~~

各インデックスの範囲は [array-dimensions](http://clhs.lisp.se/Body/f_ar_d_1.htm) で調べられます。

~~~
* (array-dimensions *a*)
(4)
* (array-dimensions *b*)
(2 3)
~~~

また、配列のランク（次元数）を調べてから、各次元のサイズを取得することもできます。

~~~lisp
* (array-rank *a*)
1
* (array-dimension *a* 0)
4
* (array-rank *b*)
2
* (array-dimension *b* 0)
2
* (array-dimension *b* 1)
3
~~~

配列を反復処理するには、次のような入れ子のループを使えます。

~~~lisp
* (defparameter a #2A((1 2 3) (4 5 6)))
A
* (destructuring-bind (n m) (array-dimensions a)
    (loop for i from 0 below n do
      (loop for j from 0 below m do
        (format t "a[~a ~a] = ~a~%" i j (aref a i j)))))

a[0 0] = 1
a[0 1] = 2
a[0 2] = 3
a[1 0] = 4
a[1 1] = 5
a[1 2] = 6
NIL
~~~

この処理を多次元に対して行う補助マクロが `nested-loop` です。

~~~lisp
(defmacro nested-loop (syms dimensions &body body)
  "Iterates over a multidimensional range of indices.

   SYMS must be a list of symbols, with the first symbol
   corresponding to the outermost loop.

   DIMENSIONS will be evaluated, and must be a list of
   dimension sizes, of the same length as SYMS.

   Example:
    (nested-loop (i j) '(10 20) (format t '~a ~a~%' i j))

  "
  (unless syms (return-from nested-loop `(progn ,@body))) ; No symbols

  ;; Generate gensyms for dimension sizes
  (let* ((rank (length syms))
         ;; reverse our symbols list,
         ;; since we start from the innermost.
         (syms-rev (reverse syms))
         ;; innermost dimension first:
         (dims-rev (loop for i from 0 below rank
                         collecting (gensym)))
         ;; start with innermost expression
         (result `(progn ,@body)))
    ;; Wrap previous result inside a loop for each dimension
    (loop for sym in syms-rev for dim in dims-rev do
         (unless (symbolp sym)
           (error "~S is not a symbol. First argument to nested-loop must be a list of symbols" sym))
         (setf result
               `(loop for ,sym from 0 below ,dim do
                     ,result)))
    ;; Add checking of rank and dimension types,
    ;; and get dimensions into gensym list.
    (let ((dims (gensym)))
      `(let ((,dims ,dimensions))
         (unless (= (length ,dims) ,rank)
           (error "Incorrect number of dimensions: Expected ~a but got ~a" ,rank (length ,dims)))
         (dolist (dim ,dims)
           (unless (integerp dim)
             (error "Dimensions must be integers: ~S" dim)))
         ;; dimensions reversed so that innermost is last:
         (destructuring-bind ,(reverse dims-rev) ,dims
           ,result)))))
~~~

これにより、2 次元配列の内容を次のように表示できます。

~~~lisp
* (defparameter a #2A((1 2 3) (4 5 6)))
A
* (nested-loop (i j) (array-dimensions a)
      (format t "a[~a ~a] = ~a~%" i j (aref a i j)))

a[0 0] = 1
a[0 1] = 2
a[0 2] = 3
a[1 0] = 4
a[1 1] = 5
a[1 2] = 6
NIL
~~~

[注: このマクロは array-operations の[このフォーク](https://github.com/bendudson/array-operations)で利用できますが、Quicklisp には収録されていません]

[​]{#row-major-indexing}

### 行優先順でのインデックス指定

場合によっては、特に要素ごとの演算では、次元数は重要ではありません。次元数に依存しないコードを書くには、[row-major-aref](http://clhs.lisp.se/Body/f_row_ma.htm#row-major-aref) で一次元化した単一のインデックスを使い、配列要素へアクセスできます。配列全体の要素数は [array-total-size](http://clhs.lisp.se/Body/f_ar_tot.htm) で得られ、一次元化したインデックスは 0 から始まります。

~~~lisp
* (defparameter a #2A((1 2 3) (4 5 6)))
A
* (array-total-size a)
6
* (loop for i from 0 below (array-total-size a) do
     (setf (row-major-aref a i) (+ 2.0 (row-major-aref a i))))
NIL
* a
#2A((3.0 4.0 5.0) (6.0 7.0 8.0))
~~~

[​]{#infix-syntax}

### 中置記法

[cmu-infix](https://github.com/rigetticomputing/cmu-infix) ライブラリは、数式を読みやすく記述できる別の構文を提供します。

~~~lisp
* (ql:quickload :cmu-infix)
To load "cmu-infix":
  Load 1 ASDF system:
    cmu-infix
; Loading "cmu-infix"

(:CMU-INFIX)

* (named-readtables:in-readtable cmu-infix:syntax)
(("COMMON-LISP-USER" . #<NAMED-READTABLE CMU-INFIX:SYNTAX {10030158B3}>)
 ...)

* (defparameter arr (make-array '(3 2) :initial-element 1.0))
ARR

* #i(arr[0 1] = 2.0)
2.0

* arr
#2A((1.0 2.0) (1.0 1.0) (1.0 1.0))
~~~

行列同士の乗算は次のように実装できます。

~~~lisp
(let ((A #2A((1 2) (3 4)))
      (B #2A((5 6) (7 8)))
      (result (make-array '(2 2) :initial-element 0.0)))

     (loop for i from 0 to 1 do
           (loop for j from 0 to 1 do
                 (loop for k from 0 to 1 do
                       #i(result[i j] += A[i k] * B[k j]))))
      result)
~~~

別の行列乗算の実装については、下の線形代数の節を参照してください。

[​]{#element-wise-operations}

## 要素ごとの演算

同じサイズの 2 つの数値配列を掛け合わせるには、[array-operations](https://github.com/Lisp-Stat/array-operations) ライブラリの `each` に関数を渡します。

~~~lisp
* (aops:each #'* #(1 2 3) #(2 3 4))
#(2 6 12)
~~~

効率を高めるために `aops:each*` 関数があります。これは結果の配列を特殊化するため、最初の引数に型を取ります。

配列のすべての要素に定数を加えるには、次のようにします。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (aops:each (lambda (it) (+ 42 it)) *a*)
#(43 44 45 46)
* *a*
#(1 2 3 4)
~~~

`each` は破壊的ではなく、新しい配列を作ることに注意してください。`each` に渡す配列はすべて同じサイズでなければならないため、`(aops:each #'+ 42 *a*)` は正しくありません。

[​]{#expression--vectorize}
[​]{#vectorize}

### 式のベクトル化

上の `each` 関数に代わる方法として、配列のすべての要素を反復するマクロを使えます。

~~~lisp
(defmacro vectorize (variables &body body)
  ;; Check that variables is a list of only symbols
  (dolist (var variables)
    (if (not (symbolp var))
        (error "~S is not a symbol" var)))

    ;; Get the size of the first variable, and create a new array
    ;; of the same type for the result
    `(let ((size (array-total-size ,(first variables)))  ; Total array size (same for all variables)
           (result (make-array (array-dimensions ,(first variables)) ; Returned array
                               :element-type (array-element-type ,(first variables)))))
       ;; Check that all variables have the same sizeo
       ,@(mapcar (lambda (var) `(if (not (equal (array-dimensions ,(first variables))
                                                (array-dimensions ,var)))
                                    (error "~S and ~S have different dimensions" ',(first variables) ',var)))
              (rest variables))

       (dotimes (indx size)
         ;; Locally redefine variables to be scalars at a given index
         (let ,(mapcar (lambda (var) (list var `(row-major-aref ,var indx))) variables)
           ;; User-supplied function body now evaluated for each index in turn
           (setf (row-major-aref result indx) (progn ,@body))))
       result))
~~~

[注: このマクロの拡張版は array-operations の[このフォーク](https://github.com/bendudson/array-operations)で利用できますが、Quicklisp には収録されていません]

これは次のように使えます。

~~~lisp
* (defparameter *a* #(1 2 3 4))
*A*
* (vectorize (*a*) (* 2 *a*))
#(2 4 6 8)
~~~

式の本体（`vectorize` 式の 2 番目のフォーム）の中では、シンボル `*a*` は単一の要素に束縛されます。つまり、組み込みの数学関数を使えるということです。

~~~lisp
* (defparameter a #(1 2 3 4))
A
* (defparameter b #(2 3 4 5))
B
* (vectorize (a b) (* a (sin b)))
#(0.9092974 0.28224 -2.2704074 -3.8356972)
~~~

さらに `cmu-infix` と組み合わせられます。

~~~lisp
* (vectorize (a b) #i(a * sin(b)) )
#(0.9092974 0.28224 -2.2704074 -3.8356972)
~~~

### BLAS を呼び出す

高速な行列操作のために、いくつかのパッケージが BLAS のラッパーを提供しています。

Quicklisp の [lla](https://github.com/tpapp/lla) パッケージは、いくつかの BLAS 関数を呼び出す機能を提供します。

[​]{#array--scale-}
[​]{#scale-}

#### 配列をスケーリングする

定数倍する演算です。

~~~lisp
* (defparameter a #(1 2 3))
* (lla:scal! 2.0 a)
* a
#(2.0d0 4.0d0 6.0d0)
~~~

#### AXPY

これは `a * x + y` を計算します。ここで `a` は定数、`x` と `y` は配列です。`lla:axpy!` 関数は破壊的で、最後の引数（`y`）を変更します。

~~~lisp
* (defparameter x #(1 2 3))
A
* (defparameter y #(2 3 4))
B
* (lla:axpy! 0.5 x y)
#(2.5d0 4.0d0 5.5d0)
* x
#(1.0d0 2.0d0 3.0d0)
* y
#(2.5d0 4.0d0 5.5d0)
~~~

`y` 配列が複素数の場合、この演算は各演算子の複素数版を呼び出します。

~~~lisp
* (defparameter x #(1 2 3))
* (defparameter y (make-array 3 :element-type '(complex double-float)
                                :initial-element #C(1d0 1d0)))
* y
#(#C(1.0d0 1.0d0) #C(1.0d0 1.0d0) #C(1.0d0 1.0d0))

* (lla:axpy! #C(0.5 0.5) a b)
#(#C(1.5d0 1.5d0) #C(2.0d0 2.0d0) #C(2.5d0 2.5d0))
~~~

[​]{#dot-product}

#### 内積

2 つのベクトルの内積です。

~~~lisp
* (defparameter x #(1 2 3))
* (defparameter y #(2 3 4))
* (lla:dot x y)
20.0d0
~~~

[​]{#reductions}

### 畳み込み

[reduce](http://clhs.lisp.se/Body/f_reduce.htm) 関数は、ベクトル（1 次元配列）を含むシーケンスに対して動作しますが、多次元配列には動作しません。これを回避するには、多次元配列を参照する 1 次元の displaced 配列を作成できます。displaced 配列は元の配列と記憶領域を共有するため、データをコピーせずに高速に処理できます。

~~~lisp
* (defparameter a #2A((1 2) (3 4)))
A
* (reduce #'max (make-array (array-total-size a) :displaced-to a))
4
~~~

`array-operations` パッケージには `flatten` があり、displaced 配列、つまりデータをコピーせず元の配列と記憶領域を共有する配列を返します。

~~~lisp
* (reduce #'max (aops:flatten a))
~~~

SBCL 拡張の [array-storage-vector](http://www.sbcl.org/manual/#index-array_002dstorage_002dvector) は、同じことを実現する効率的ですが移植性のない方法を提供します。

~~~lisp
* (reduce #'max (array-storage-vector a))
4
~~~

ときには、より複雑な畳み込みが必要です。たとえば、2 つの配列の差の絶対値の最大値を求める場合です。上の方法を使うと次のようにできます。

~~~lisp
* (defparameter a #2A((1 2) (3 4)))
A
* (defparameter b #2A((1 3) (5 4)))
B
* (reduce #'max (aops:flatten
                  (aops:each
                    (lambda (a b) (abs (- a b))) a b)))
2
~~~

これは中間結果を保持する配列の割り当てを伴い、大きな配列では非効率になり得ます。上で定義した `vectorize` と同様に、割り当てを行わないマクロを次のように定義できます。

~~~lisp
(defmacro vectorize-reduce (fn variables &body body)
  "Performs a reduction using FN over all elements in a vectorized expression
   on array VARIABLES.

   VARIABLES must be a list of symbols bound to arrays.
   Each array must have the same dimensions. These are
   checked at compile and run-time respectively.
  "
  ;; Check that variables is a list of only symbols
  (dolist (var variables)
    (if (not (symbolp var))
        (error "~S is not a symbol" var)))

  (let ((size (gensym)) ; Total array size (same for all variables)
        (result (gensym)) ; Returned value
        (indx (gensym)))  ; Index inside loop from 0 to size

    ;; Get the size of the first variable
    `(let ((,size (array-total-size ,(first variables))))
       ;; Check that all variables have the same size
       ,@(mapcar (lambda (var) `(if (not (equal (array-dimensions ,(first variables))
                                                (array-dimensions ,var)))
                                    (error "~S and ~S have different dimensions" ',(first variables) ',var)))
              (rest variables))

       ;; Apply FN with the first two elements (or fewer if size < 2)
       (let ((,result (apply ,fn (loop for ,indx below (min ,size 2) collecting
                                      (let ,(map 'list (lambda (var) (list var `(row-major-aref ,var ,indx))) variables)
                                        (progn ,@body))))))

         ;; Loop over the remaining indices
         (loop for ,indx from 2 below ,size do
            ;; Locally redefine variables to be scalars at a given index
              (let ,(mapcar (lambda (var) (list var `(row-major-aref ,var ,indx))) variables)
                ;; User-supplied function body now evaluated for each index in turn
                (setf ,result (funcall ,fn ,result (progn ,@body)))))
         ,result))))

~~~

[注: このマクロは array-operations の[このフォーク](https://github.com/bendudson/array-operations)で利用できますが、Quicklisp には収録されていません]

このマクロを使うと、任意の形状の配列 A における最大値を次のように求められます。

~~~lisp
* (vectorize-reduce #'max (a) a)
~~~

形状が同じであれば、任意の形状の 2 つの配列 A と B について、差の絶対値の最大値を次のように求められます。

~~~lisp
* (vectorize-reduce #'max (a b) (abs (- a b)))
~~~

[​]{#linear-algebra}

## 線形代数

いくつかのパッケージが BLAS と LAPACK ライブラリへのバインディングを提供しています。たとえば次です。

- [lla](https://github.com/tpapp/lla)
- [MAGICL](https://github.com/rigetticomputing/magicl)

利用可能なパッケージのより詳しい一覧は [CLiki の線形代数ページ](https://www.cliki.net/linear%20algebra)にあります。

下の例では LLA パッケージがロードされています。

~~~lisp
* (ql:quickload :lla)

To load "lla":
  Load 1 ASDF system:
    lla
; Loading "lla"
.
(:LLA)
~~~

[​]{#matrix-multiplication}

### 行列の乗算

[lla](https://github.com/tpapp/lla) の関数 `mm` は、ベクトル同士、行列とベクトル、行列同士の乗算を行います。

[​]{#vector-dot-product}

#### ベクトルの内積

一方のベクトルは行ベクトルとして、もう一方は列ベクトルとして扱われることに注意してください。

~~~lisp
* (lla:mm #(1 2 3) #(2 3 4))
20
~~~

[​]{#matrix-vector-product}

#### 行列とベクトルの積

~~~lisp
* (lla:mm #2A((1 1 1) (2 2 2) (3 3 3))  #(2 3 4))
#(9.0d0 18.0d0 27.0d0)
~~~

これは `A[i j] * x[j]` を `j` について総和したものです。

[​]{#matrix-matrix-multiply}

#### 行列同士の乗算

~~~lisp
* (lla:mm #2A((1 2 3) (1 2 3) (1 2 3))  #2A((2 3 4) (2 3 4) (2 3 4)))
#2A((12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0) (12.0d0 18.0d0 24.0d0))
~~~

これは `A[i j] * B[j k]` を `j` について総和したものです。

返される配列は単純配列で、要素型が `double-float` に特殊化されていることに注意してください。

~~~lisp
* (type-of (lla:mm #2A((1 0 0) (0 1 0) (0 0 1)) #(1 2 3)))
(SIMPLE-ARRAY DOUBLE-FLOAT (3))
~~~

[​]{#outer-product}

#### 外積

[array-operations](https://github.com/Lisp-Stat/array-operations) パッケージには、一般化された[外積](https://en.wikipedia.org/wiki/Outer_product)関数が含まれます。

~~~lisp
* (ql:quickload :array-operations)
To load "array-operations":
  Load 1 ASDF system:
    array-operations
; Loading "array-operations"

(:ARRAY-OPERATIONS)
* (aops:outer #'* #(1 2 3) #(2 3 4))
#2A((2 3 4) (4 6 8) (6 9 12))
~~~

これは新しい 2 次元配列 `A[i j] = B[i] * C[j]` を作成しています。`outer` 関数は任意個の入力を受け取れ、多次元の入力にも対応します。

[​]{#matrix-inverse}

### 逆行列

密行列の逆行列は `invert` で計算できます。

~~~lisp
* (lla:invert #2A((1 0 0) (0 1 0) (0 0 1)))
#2A((1.0d0 0.0d0 -0.0d0) (0.0d0 1.0d0 -0.0d0) (0.0d0 0.0d0 1.0d0))
~~~

たとえば:

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter b (lla:invert a))
B
* (lla:mm a b)
#2A((1.0d0 2.220446049250313d-16 0.0d0)
    (0.0d0 1.0d0 0.0d0)
    (0.0d0 1.1102230246251565d-16 0.9999999999999998d0))
~~~

逆行列を直接計算することは、特に大きな行列では一般におすすめできません。代わりに [LU 分解](https://en.wikipedia.org/wiki/LU_decomposition)を計算し、複数回の逆行列計算に使えます。

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter b (lla:mm a #(1 2 3)))
B
* (lla:solve (lla:lu a) b)
#(1.0d0 2.0d0 3.0d0)
~~~

[​]{#singular-value-decomposition}

### 特異値分解

`svd` 関数は、与えられた行列の[特異値分解](https://en.wikipedia.org/wiki/Singular-value_decomposition)を計算し、得られる 3 つの行列を格納するスロットを持つオブジェクトを返します。

~~~lisp
* (defparameter a #2A((1 2 3) (0 2 1) (1 3 2)))
A
* (defparameter a-svd (lla:svd a))
A-SVD
* a-svd
#S(LLA:SVD
   :U #2A((-0.6494608633564334d0 0.7205486773948702d0 0.24292013188045855d0)
          (-0.3744175632000917d0 -0.5810891192666799d0 0.7225973455785591d0)
          (-0.6618248071322363d0 -0.3783451320875919d0 -0.6471807210432038d0))
   :D #S(CL-NUM-UTILS.MATRIX:DIAGONAL-MATRIX
         :ELEMENTS #(5.593122609997059d0 1.2364443401235103d0
                     0.43380279311714376d0))
   :VT #2A((-0.2344460799312531d0 -0.7211054639318696d0 -0.6519524104506949d0)
           (0.2767642134809678d0 -0.6924017945853318d0 0.6663192365460215d0)
           (-0.9318994611765425d0 -0.02422116311440764d0 0.3619070730398283d0)))
~~~

対角行列（特異値）とベクトルには関数でアクセスできます。

~~~lisp
(lla:svd-u a-svd)
#2A((-0.6494608633564334d0 0.7205486773948702d0 0.24292013188045855d0)
    (-0.3744175632000917d0 -0.5810891192666799d0 0.7225973455785591d0)
    (-0.6618248071322363d0 -0.3783451320875919d0 -0.6471807210432038d0))

* (lla:svd-d a-svd)
#S(CL-NUM-UTILS.MATRIX:DIAGONAL-MATRIX
   :ELEMENTS #(5.593122609997059d0 1.2364443401235103d0 0.43380279311714376d0))

* (lla:svd-vt a-svd)
#2A((-0.2344460799312531d0 -0.7211054639318696d0 -0.6519524104506949d0)
    (0.2767642134809678d0 -0.6924017945853318d0 0.6663192365460215d0)
    (-0.9318994611765425d0 -0.02422116311440764d0 0.3619070730398283d0))
~~~


## Matlisp

[Matlisp](https://github.com/bharath1097/matlisp/) は科学技術計算ライブラリです。BLAS と LAPACK 関数のラッパーを含み、配列に対する高性能な演算を提供します。Quicklisp でロードできます。

~~~lisp
* (ql:quickload :matlisp)
~~~

`matlisp` のニックネームは `m` です。各シンボルの前に `matlisp:` や `m:` と入力せずに済むよう、Matlisp を使用する独自のパッケージを定義できます（[PCL のパッケージ節](http://www.gigamonkeys.com/book/programming-in-the-large-packages-and-symbols.html)を参照）。

~~~lisp
* (defpackage :my-new-code
     (:use :common-lisp :matlisp))
#<PACKAGE "MY-NEW-CODE">

* (in-package :my-new-code)
~~~

また、`#i` 中置記法リーダー（`cmu-infix` と同じ名前であることに注意）を使うには、次を実行します。

~~~lisp
* (named-readtables:in-readtable :infix-dispatch-table)
~~~

[​]{#tensors}

### テンソルの作成

~~~lisp
* (matlisp:zeros '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.000    0.000
  0.000    0.000
>
~~~

デフォルトでは、行列の格納型は `double-float` です。`zeros`、`ones`、`eye` を使って複素配列を作るには、型を指定します。

~~~lisp
* (matlisp:zeros '(2 2) '((complex double-float)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: (COMPLEX DOUBLE-FLOAT)>| #(2 2)
  0.000    0.000
  0.000    0.000
>
~~~

`zeros` と `ones` に加えて、単位行列を作る `eye` があります。

~~~lisp
* (matlisp:eye '(3 3) '((complex double-float)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: (COMPLEX DOUBLE-FLOAT)>| #(3 3)
  1.000    0.000    0.000
  0.000    1.000    0.000
  0.000    0.000    1.000
>
~~~

[​]{#range}

#### 数列

1 次元配列を生成するには `range` と `linspace` 関数があります。

~~~lisp
* (matlisp:range 1 10)
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(9)
 1   2   3   4   5   6   7   8   9
>
~~~

`range` 関数は最後の引数を整数に切り下げます。

~~~lisp
* (matlisp:range 1 -3.5)
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: SINGLE-FLOAT>| #(5)
 1.000   0.000   -1.000  -2.000  -3.000
>
* (matlisp:range 1 3.3)
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: SINGLE-FLOAT>| #(3)
 1.000   2.000   3.000
>
~~~

`linspace` はもう少し汎用的で、返される値に終点を含みます。

~~~lisp
* (matlisp:linspace 1 10)
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(10)
 1   2   3   4   5   6   7   8   9   10
>
~~~

~~~lisp
* (matlisp:linspace 0 (* 2 pi) 5)
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(5)
 0.000   1.571   3.142   4.712   6.283
>
~~~

現在、`linspace` への入力は実数でなければならず、複素数には対応していません。

#### 乱数

~~~lisp
* (matlisp:random-uniform '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.7287       0.9480
  2.6703E-2    0.1834
>
~~~

~~~lisp
(matlisp:random-normal '(2 2))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.3536    -1.291
 -0.3877    -1.371
>
~~~

他の確率分布に対応する関数もあり、`random-exponential`、`random-beta`、`random-gamma`、`random-pareto` などが含まれます。

[​]{#reader-macro}

#### リーダーマクロ

`#d` と `#e` リーダーマクロを使うと、`double-float` と `single-float` のテンソルを作成できます。

~~~lisp
* #d[1,2,3]
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(3)
 1.000   2.000   3.000
>

* #d[[1,2,3],[4,5,6]]
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    2.000    3.000
  4.000    5.000    6.000
>
~~~

カンマ区切りが必要であることに注意してください。

[​]{#array--tensor-}
[​]{#tensor-}

#### 配列からテンソルへ

Common Lisp 配列は、コピーして Matlisp のテンソルへ変換できます。

~~~lisp
* (copy #2A((1 2 3)
            (4 5 6))
        '#.(tensor 'double-float))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    2.000    3.000
  4.000    5.000    6.000
>
~~~

次元を指定して `tensor` クラスのインスタンスを作成することもできます。`tensor` オブジェクトの内部記憶領域は、スロット `store` 内の 1 次元配列（`simple-vector`）です。

たとえば、`double-float` 型のテンソルを作るには次のようにします。

~~~lisp
(make-instance (tensor 'double-float)
    :dimensions  (coerce '(2) '(simple-array index-type (*)))
    :store (make-array 2 :element-type 'double-float))
~~~

[​]{#tensor--array-}
[​]{#tensor--1}

#### テンソルから配列へ

テンソルの内部データにはスロットを使ってアクセスできます。

~~~lisp
* (defparameter vec (m:range 0 5))
* vec
#<|<SIMPLE-DENSE-TENSOR: (INTEGER 0 4611686018427387903)>| #(5)
 0   1   2   3   4
>
* (slot-value vec 'm:store)
#(0 1 2 3 4)
~~~

多次元テンソルも 1 次元配列に格納されますが、その順序は Common Lisp 配列で使われる行優先ではなく列優先です。したがって、displaced 配列として参照すると行列は転置されます。

テンソルの内容は配列へコピーできます。

~~~lisp
* (let ((tens (m:ones '(2 3))))
    (m:copy tens 'array))
#2A((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

リストへコピーすることもできます。

~~~lisp
* (m:copy (m:ones '(2 3)) 'cons)
((1.0d0 1.0d0 1.0d0) (1.0d0 1.0d0 1.0d0))
~~~

[​]{#element-access}

### 要素へのアクセス

`ref` 関数は標準 Common Lisp 配列に対する `aref` に相当し、`setf` も可能です。

~~~lisp
* (defparameter a (matlisp:ones '(2 3)))

* (setf (ref a 1 1) 2.0)
2.0d0
* a
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  1.000    1.000    1.000
  1.000    2.000    1.000
>
~~~

[​]{#element-wise-operations-1}

### 要素ごとの演算

`matlisp` とともにロードされる `matlisp-user` パッケージには、テンソルの要素ごとに演算する関数が含まれます。

~~~lisp
* (matlisp-user:* 2 (ones '(2 3)))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 3)
  2.000    2.000    2.000
  2.000    2.000    2.000
>
~~~

これには算術演算子 `+`、`-`、`*`、`/`、`expt` だけでなく、`sqrt`、`sin`、`cos`、`tan`、双曲線関数、およびそれらの逆関数も含まれます。`#i` リーダーマクロはこれらの多くを認識し、`matlisp-user` の関数を使います。

~~~lisp
* (let ((a (ones '(2 2)))
        (b (random-normal '(2 2))))
     #i( 2 * a + b ))
#<|<BLAS-MIXIN SIMPLE-DENSE-TENSOR: DOUBLE-FLOAT>| #(2 2)
  0.9684    3.250
  1.593     1.508
>

* (let ((a (ones '(2 2)))
        (b (random-normal '(2 2))))
     (macroexpand-1 '#i( 2 * a + b )))
(MATLISP-USER:+ (MATLISP-USER:* 2 A) B)
~~~
 
#  日付と時刻 {#chapter-dates_and_times}
 

Common Lisp は time を見る 2 つの異なる方法を提供します。「現実世界」の time を意味する universal time と、コンピュータの CPU から見た time を意味する実行時間です。ここではそれぞれを分けて扱います。

[​]{#univ}


## 組み込みの時刻関数

### ユニバーサルタイム

ユニバーサルタイムは、GMT タイムゾーンの 1900 年 1 月 1 日 00:00 から経過した秒数として表されます。関数
[`get-universal-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get_un.htm)
は現在のユニバーサルタイムを返します。

~~~lisp
CL-USER> (get-universal-time)
3220993326
~~~

もちろんこの値はあまり読みやすくないため、関数
[`decode-universal-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_dec_un.htm)
を使って「カレンダー時刻」の表現に変換できます。

~~~lisp
CL-USER> (decode-universal-time 3220993326)
6
22
19
25
1
2002
4
NIL
5
~~~

**NB**: 次の section では、`local-time` ライブラリを使って、より使いやすい関数を得ます。たとえば `(local-time:universal-to-timestamp (get-universal-time))` は `@2021-06-25T09:16:29.000000+02:00` を返します。

この `decode-universal-time` 呼び出しは 9 つの値を返します。秒、分、時、日、月、年、曜日、夏時間フラグ、タイムゾーンです。曜日は 0..6 の範囲の整数として表され、0 が月曜日、6 が日曜日であることに注意してください。また、**タイムゾーン** は現在時刻に足すと GMT になる時間数として表されます。

したがってこの例では、デコードされた時刻は EST タイムゾーンにおける `2002 年 1 月 25 日 金曜日の 19:22:06` で、夏時間は有効ではありません。もちろんこれはコンピュータ自身の時計に依存するため、正しく設定されていることを確認してください（タイムゾーンと夏時間フラグを含みます）。手早く済ませるなら、
[`get-decoded-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get_un.htm)
を使うと、現在時刻のカレンダー時刻表現を直接得られます。

~~~lisp
CL-USER> (get-decoded-time)
~~~

これは次と同等です。

~~~lisp
CL-USER> (decode-universal-time (get-universal-time))
~~~

これらの関数をプログラム内で使う方法の例です (ただし率直に言えば、代わりに `local-time` ライブラリを使ってください)。

~~~lisp
CL-USER> (defconstant *day-names*
           '("Monday" "Tuesday" "Wednesday"
	         "Thursday" "Friday" "Saturday"
	         "Sunday"))
*DAY-NAMES*

CL-USER> (multiple-value-bind
           (second minute hour day month year day-of-week dst-p tz)
    	   (get-decoded-time)
           (format t "It is now ~2,'0d:~2,'0d:~2,'0d of ~a, ~d/~2,'0d/~d (GMT~@d)"
	    	 hour
	    	 minute
	    	 second
	    	 (nth day-of-week *day-names*)
	    	 month
	    	 day
	    	 year
	    	 (- tz)))
It is now 17:07:17 of Saturday, 1/26/2002 (GMT-5)
~~~

もちろん上の `get-decoded-time` 呼び出しは、任意の日付を表示するために、n を任意の整数として `(decode-universal-time n)` に置き換えられます。逆方向へ進むこともできます。関数
[`encode-universal-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_encode.htm)
を使うと、カレンダー時刻を対応するユニバーサルタイムへエンコードできます。この関数は 6 つの必須引数（秒、分、時、日、月、年）と 1 つの省略可能な引数（タイムゾーン）を取り、ユニバーサルタイムを返します。

~~~lisp
CL-USER> (encode-universal-time 6 22 19 25 1 2002)
3220993326
~~~

タイムゾーンが指定されない場合、結果は夏時間に対して自動的に調整されることに注意してください。指定された場合、Lisp は指定されたタイムゾーンがすでに夏時間を考慮していると見なし、調整は行われません。

ユニバーサルタイムは単なる数値なので、カレンダー時刻より操作が簡単で安全です。日付と時刻は、可能であれば常にユニバーサルタイムとして保存し、出力のためだけに文字列表現へ変換するべきです。たとえば、2 つの日付のどちらが先かを知るには、対応する 2 つのユニバーサルタイムを `<` で比較するだけで簡単です。

### 内部時間

内部時間は、あなたの Lisp 環境がコンピュータの時計を使って測る時間です。これは 3 つの重要な点でユニバーサルタイムと異なります。まず、内部時間は決まった時点を起点に測られるわけではありません。Lisp を起動した瞬間、マシンを起動した瞬間、または過去の任意の時点が起点になるかもしれません。すぐに見るように、内部時間の絶対値はほとんど常に意味を持たず、内部時間同士の差だけが有用です。2 つ目の違いは、内部時間は秒ではなく、[`internal-time-units-per-second`](http://www.lispworks.com/documentation/HyperSpec/Body/v_intern.htm) から知ることのできる（通常はより小さい）単位で測られることです。

~~~lisp
CL-USER> internal-time-units-per-second
1000
~~~

これは、この例で使われている Lisp 環境では内部時間がミリ秒で測られることを意味します。

最後に、「内部時間」の時計は何を測っているのでしょうか。実際には Lisp には 2 つの異なる内部時間の時計があります。

- その 1 つは「実」時間の経過を測ります（ユニバーサルタイムが測るのと同じ時間ですが、単位が異なります）。
- もう 1 つは CPU 時間の経過、つまり CPU が現在の Lisp プロセスのために実際の計算を行うのに費やした時間を測ります。

ほとんどの現代のコンピュータでは、これら 2 つの時間は異なります。CPU がプログラムだけに完全に専念することはないからです（単一ユーザーのマシンでさえ、CPU は割り込みの処理や I/O の実行などに時間の一部を割く必要があります）。内部時間を取得するために使う 2 つの関数は、それぞれ [`get-internal-real-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get_in.htm) と [`get-internal-run-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get__1.htm) と呼ばれます。これらを使えば、関数の実行時間を測るという上の問題を解決できます。これは組み込みマクロ `time` が行っていることです。

~~~lisp
CL-USER> (time (sleep 1))
Evaluation took:
  1.000 seconds of real time
  0.000049 seconds of total run time (0.000044 user, 0.000005 system)
  0.00% CPU
  2,594,553,447 processor cycles
  0 bytes consed
~~~


## `local-time` ライブラリ

[local-time](https://common-lisp.net/project/local-time/) ライブラリ ([GitHub](https://github.com/dlowe-net/local-time/)) は、標準で定義されたやや限られた機能を拡張する、とても便利なライブラリです。

特に、次のことができます。

- timestamp をさまざまな標準形式またはカスタム形式で表示する（例: RFC1123 や RFC3339）
- 時刻文字列を解析する
- 時刻の演算を行う
- Unix time、timestamp、ユニバーサルタイムの相互変換を行う

以下では、最も有用だと思う関数を紹介します。完全な詳細は[マニュアル](https://common-lisp.net/project/local-time/manual.html)を見てください。

Quicklisp で利用できます。

~~~lisp
CL-USER> (ql:quickload "local-time")
~~~

### timestamp を作成する (encode-timestamp, universal-to-timestamp)

`encode-timestamp` で timestamp を作成します。ナノ秒、秒、分、時、日、月、年の値を渡します。

~~~lisp
(local-time:encode-timestamp 0 0 0 0 1 1 1984)
@1984-01-01T00:00:00.000000+01:00
~~~

完全なシグネチャは次のとおりです。

    **encode-timestamp** nsec sec minute hour day month year &key timezone offset into

    offset はロケールの UTC からのオフセット秒数です。offset が指定されていない場合、offset は timezone から推測されます。into 引数として timestamp が渡された場合、その値が設定され、その timestamp が返されます。それ以外の場合は、新しい timestamp が作成されます。

`universal-to-timestamp` でユニバーサルタイムから timestamp を作成します。

~~~lisp
(get-universal-time)
3833588757
(local-time:universal-to-timestamp (get-universal-time))
@2021-06-25T07:45:59.000000+02:00
~~~

人が読みやすい時刻文字列を解析することもできます。

~~~lisp
(local-time:parse-timestring "1984-01-01")
@1984-01-01T01:00:00.000000+01:00
~~~

ただし時刻文字列の解析についての節も見てください。

### 今日の日付を得る (now, today)

`now` または `today` を使います。

~~~lisp
(local-time:now)
@2019-11-13T20:02:13.529541+01:00

(local-time:today)
@2019-11-13T01:00:00.000000+01:00
~~~

"today" は UTC ゾーンにおける現在の日の真夜中です。

「昨日」と「明日」を計算するには、下を参照してください。

### 時刻を加算または減算する (timestamp+, timestamp-)

`timestamp+` と `timestamp-` を使います。それぞれ 3 つの引数、日付、数値、単位を取ります（省略可能で timezone と offset も取ります）。

~~~lisp
(local-time:now)
@2021-06-25T07:19:39.836973+02:00

(local-time:timestamp+ (local-time:now) 1 :day)
@2021-06-26T07:16:58.086226+02:00

(local-time:timestamp- (local-time:now) 1 :day)
@2021-06-24T07:17:02.861763+02:00
~~~

利用できる単位は `:sec :minute :hour :day :year` です。

この操作は `adjust-timestamp` でも行えます。次の節ですぐ見るように、この関数は一度に複数の操作を行えます。

~~~lisp
(local-time:timestamp+ (today) 3 :day)
@2021-06-28T02:00:00.000000+02:00

(local-time:adjust-timestamp (today) (offset :day 3))
@2021-06-28T02:00:00.000000+02:00
~~~

`today` から定義した `yesterday` と `tomorrow` です。

~~~lisp
(defun yesterday ()
  "Returns a timestamp representing the day before today."
  (timestamp- (today) 1 :day))

(defun tomorrow ()
  "Returns a timestamp representing the day after today."
  (timestamp+ (today) 1 :day))
~~~

### 任意のオフセットで timestamp を変更する (adjust-timestamp)

`adjust-timestamp` の最初の引数は操作対象の timestamp で、その後にすべての `&body changes` を受け取ります。「変更」は `(offset :part value)` というフォームです。

直前の月曜日を指してみましょう。

~~~lisp
(local-time:adjust-timestamp (today) (offset :day-of-week :monday))
@2021-06-21T02:00:00.000000+02:00
~~~

一度に多くの変更を適用できます。時間旅行をしてみましょう。

~~~lisp
(local-time:adjust-timestamp (today)
  (offset :day 3)
  (offset :year 110)
  (offset :month -1))
@2131-05-28T02:00:00.000000+01:00
~~~

破壊的な版として `adjust-timestamp!` があります。


### timestamp を比較する (timestamp<, timestamp<, timestamp= …)

これらは説明するまでもないでしょう。

~~~lisp
timestamp< time-a time-b
timestamp<= time-a time-b
timestamp> time-a time-b
timestamp>= time-a time-b
timestamp= time-a time-b
timestamp/= time-a time-b
~~~

### 最小または最大の timestamp を見つける

`timestamp-minimum` と `timestamp-maximum` を使います。これらは任意個の引数を受け取ります。

~~~lisp
(local-time:timestamp-minimum (local-time:today)
                              (local-time:timestamp- (local-time:today) 100 :year))
@1921-06-25T02:00:00.000000+01:00
~~~

timestamp のリストがある場合は、`(apply #'timestamp-minimum <your list of timestamps>)` を使います。

### 時間の単位に従って timestamp を最大化または最小化する (timestamp-maximize-part, timestamp-minimize-part)

この便利な関数でかなり多くの問いに答えられます。

例として、この月の最終日を求めてみましょう。

~~~lisp
(let ((in-february (local-time:parse-timestring "1984-02-01")))
  (local-time:timestamp-maximize-part in-february :day))

@1984-02-29T23:59:59.999999+01:00
~~~


[​]{#timestamp-object--query--dayday-of-weekdays-in-month-}
[​]{#timestamp--query--dayday-of-weekdays-in-month-}

### timestamp オブジェクトに問い合わせる (日、曜日、月の日数などを得る)

次を使います。

~~~lisp
timestamp-[year, month, day, hour, minute, second, millisecond, microsecond,
           day-of-week (starts at 0 for sunday),
           millenium, century, decade]
~~~

すべての値を一度に得るには `decode-timestamp` を使います。

この便利なマクロで、選んだ値を変数に束縛します。

~~~lisp
(local-time:with-decoded-timestamp (:hour h)
     (now)
   (print h))

8
8
~~~

もちろん各時間の単位 (`:sec :minute :day`) を任意の順序でそれぞれの変数に束縛できます。

`(days-in-month <month> <year>)` も参照してください。


[​]{#time-string--formatting-format-format-timestring-iso-8601-format}

### 時刻文字列の書式化 (format, format-timestring, +iso-8601-format+)

local-time の日付表現は `@` で始まります。通常どおり `format` できます。たとえば aesthetic ディレクティブを使うと、普通の日付表現を得られます。

~~~lisp
(local-time:now)
@2019-11-13T18:07:57.425654+01:00
~~~

~~~lisp
(format nil "~a" (local-time:now))
"2019-11-13T18:08:23.312664+01:00"
~~~

`format` のように使える `format-timestring` を使えます (したがって最初の引数としてストリームを取ります)。

~~~lisp
(local-time:format-timestring nil (local-time:now))
"2019-11-13T18:09:06.313650+01:00"
~~~

ここで `nil` は新しい文字列を返します。`t` なら `*standard-output*` に出力します。

しかし `format-timestring` は `:format` 引数も受け取ります。あらかじめ定義された日付形式を使うことも、S 式で扱いやすい方法で独自のものを与えることもできます（次の節を参照）。

既定値は
`+iso-8601-format+` で、出力は上に示したものです。`+rfc3339-format+` 形式はこれを既定とします。

`+rfc-1123-format+` の場合:

~~~lisp
(local-time:format-timestring nil (local-time:now) :format local-time:+rfc-1123-format+)
"Wed, 13 Nov 2019 18:11:38 +0100"
~~~

`+asctime-format+` の場合:

~~~lisp
(local-time:format-timestring nil (local-time:now) :format local-time:+asctime-format+)
"Wed Nov 13 18:13:15 2019"
~~~

`+iso-week-date-format+` の場合:

~~~lisp
(local-time:format-timestring nil (local-time:now) :format local-time:+iso-week-date-format+)
"2019-W46-3"
~~~


これらをまとめると、Unix time を人が読みやすい文字列として返す関数は次のようになります。

~~~lisp
(defun unix-time-to-human-string (unix-time)
  (local-time:format-timestring
   nil
   (local-time:unix-to-timestamp unix-time)
   :format local-time:+asctime-format+))

(unix-time-to-human-string (get-universal-time))
"Mon Jun 25 06:46:49 2091"
~~~


[​]{#format-string--format-timestring-year---month---day}

### 書式文字列を定義する (format-timestring (:year "-" :month "-" :day))

カスタムの `:format` 引数を `format-timestring` に渡せます。

構文は、特別な意味を持つシンボル (`:year`, `:day` など)、文字列、文字からなるリストです。

~~~lisp
(local-time:format-timestring nil (local-time:now) :format '(:year "-" :month "-" :day))
"2019-11-13"
~~~

シンボルの一覧はドキュメントにあります: [https://common-lisp.net/project/local-time/manual.html#Parsing-and-Formatting](https://common-lisp.net/project/local-time/manual.html#Parsing-and-Formatting)

`:year :month :day :weekday :hour :hour12 :min :sec :msec`、長い表記と短い表記 (`:long-weekday` は "Monday"、`:short-weekday` は
"Mon."、`:minimal-weekday` は "Mo."、同様に `:long-month` は "January"、`:short-month` は "Jan.")、GMT オフセット、タイムゾーンの記号、`:ampm`、`:ordinal-day` (1st, 23rd)、ISO 番号などがあります。

`+rfc-1123-format+` 自体は次のように定義されています。

~~~lisp
(defparameter +rfc-1123-format+
  ;; Sun, 06 Nov 1994 08:49:37 GMT
  '(:short-weekday ", " (:day 2) #\space :short-month #\space (:year 4) #\space
    (:hour 2) #\: (:min 2) #\: (:sec 2) #\space :gmt-offset-hhmm)
  "See the RFC 1123 for the details about the possible values of the timezone field.")
~~~

`(:day 2)` というフォームが見えます。2 は**桁揃え**用で、日が 2 桁で出力されることを保証します (`1` だけでなく `01`)。省略可能な 3 つ目の引数として、桁揃えに使う文字を指定できます (既定は `#\0`)。

[​]{#time-string--parse-}

### 時刻文字列を解析する

`parse-timestring` を使って、`2019-11-13T18:09:06.313650+01:00` という形の時刻文字列を解析します。既定でさまざまな形式に対応し、必要に合わせてパラメータを変更できます。

"Thu Jul 23 19:42:23 2013" (asctime) のようなさらに多くの形式を解析するには、[cl-date-time-parser](https://github.com/tkych/cl-date-time-parser) ライブラリを使います。

`parse-timestring` の docstring は次のとおりです。

>  時刻文字列を解析し、対応する timestamp を返します。解析は start から始まり、end の位置で止まります。時刻文字列内に不正な文字があり fail-on-error が T の場合、invalid-timestring エラーが signal されます。そうでなければ NIL が返されます。
>
> 時刻文字列に timezone が指定されていない場合、offset が既定の timezone offset（秒単位）として使われます。

例:

~~~lisp
(local-time:parse-timestring "2019-11-13T18:09:06.313650+01:00")
;; @2019-11-13T18:09:06.313650+01:00
~~~

~~~lisp
(local-time:parse-timestring "2019-11-13")
;; @2019-11-13T01:00:00.000000+01:00
~~~

このようなカスタム形式は既定では失敗します: "2019/11/13"。しかし `:date-separator` を "/" に設定できます。

~~~lisp
(local-time:parse-timestring "2019/11/13" :date-separator #\/)
;; @2019-11-13T19:42:32.394092+01:00
~~~

`:time-separator` (既定は `#\:`) と
`:date-time-separator` (`#\T`) もあります。

その他のオプションには次があります。

- start の位置と end の位置
- `fail-on-error` (既定は `t`)
- `(allow-missing-elements t)`
- `(allow-missing-date-part allow-missing-elements)`
- `(allow-missing-time-part allow-missing-elements)`
- `(allow-missing-timezone-part allow-missing-elements)`
- `(offset 0)`

今度は "Wed Nov 13 18:13:15 2019" のような形式は失敗します。`cl-date-time-parser` ライブラリを使います。

~~~lisp
(cl-date-time-parser:parse-date-time "Wed Nov 13 18:13:15 2019")
;; 3782657595
;; 0
~~~

これはユニバーサルタイムを返し、それを local-time ライブラリに取り込めます。

~~~lisp
(local-time:universal-to-timestamp *)
;; @2019-11-13T19:13:15.000000+01:00
~~~

### その他

Alice の記念日かどうかを調べるには、`timestamp-whole-year-difference time-a time-b` を使います。
 
#  パターンマッチング {#chapter-pattern_matching}
 

ANSI Common Lisp 標準には pattern matching の機能は含まれていませんが、この用途のためのライブラリは存在し、[Trivia](https://github.com/guicho271828/trivia) が community standard になりました。

pattern matching の概念の導入については、[Trivia's wiki](https://github.com/guicho271828/trivia/wiki/What-is-pattern-matching%3F-Benefits%3F) を参照してください。

Trivia は*非常に多くの* Lisp オブジェクトに対して match でき、拡張可能です。

このライブラリは Quicklisp にあります。

~~~lisp
(ql:quickload "trivia")
~~~

以下の例では、このライブラリを `use` します。

~~~lisp
(use-package :trivia)
~~~

好みに応じて、テスト用のパッケージを作成できます。

~~~lisp
(defpackage :trivia-tests (:use :cl :trivia))
(in-package :trivia-tests)
~~~


## よく使う分配束縛パターン

### 単純な値にマッチする

`match` を使うと、変数を他の値に対して検査できます。

~~~lisp
(let ((x 3))
  (match x
     (0 :no-match)
     (1 :still-no-match)
     (3 :yes)
     (_ :other)))
;; => :yes
~~~

リストでも同じです。

~~~lisp
(let ((x (list :a)))
  (match x
    (0 :nope)
    (1 :still-nope)
    (3 :yes)
    ((list :a) :a-list) ;; <-- match (list :a) entirely. Next we'll match on the content.
    (_ :other)))
;; => :A-LIST
~~~

文字列でも動きます（CL 組み込みの `case` ではできません）。

~~~lisp
(let ((x "a string"))
  (match x
    ("a string" :a-string)
    (_ :other)))
;; => :A-STRING
~~~

この知識を使って、洗練された再帰的 Fibonacci 関数を書けます。

~~~lisp
(defun fib (n)
  (match n
    (0 0)
    (1 1)
    (_ (+ (fib (- n 1)) (fib (- n 2))))))
~~~

変数 `x` が複合データ構造である場合、その内容に対してマッチできるとより面白くなります。次の節では Trivia のパターンを使ってそれを行います。


### 包括的な分岐は `_`

包括的な分岐に、`cond` や `case` で使われる `t` ではなく `_`（アンダースコア）を使ったことに注目してください。


### `cons`

`cons` pattern は list やその他の cons cell に match します。

match されるオブジェクトと pattern の長さは異なっていてもかまいません。下では、`y` は `x` に match されなかった残りすべてを受け取ります。

~~~lisp
(match '(1 2 3)
  ((cons x y)
  ; ^^ pattern
   (print x)
   (print y)))
;; |-> 1
;; |-> (2 3)
~~~

### `list`, `list*`

`list` は厳密な pattern で、match されるオブジェクトの長さが subpattern の長さと同じであることを期待します。

~~~lisp
(match '(something 2 3)
  ((list a b _)
   (values a b)))
SOMETHING
2
~~~

`_` placeholder がなければ match しません。

~~~lisp
(match '(something 2 3)
  ((list a b)
   (values a b)))
NIL
~~~

`list*` パターンはオブジェクトの長さに関して柔軟です。

~~~lisp
(match '(something 2 3)
  ((list* a b)
   (values a b)))
SOMETHING
(2 3)
~~~

~~~lisp
(match '(1 2 . 3)
  ((list* _ _ x)
   x))
3
~~~

ただし、`list*` がオブジェクトを1つだけ受け取る場合、そのオブジェクトがリストであるかどうかに関係なく、そのオブジェクトが返されることに注意してください。

~~~lisp
(match #(0 1 2)
  ((list* a)
   a))
#(0 1 2)
~~~

これは HyperSpec における `list*` の定義に関係しています: http://clhs.lisp.se/Body/f_list_.htm.


### `vector`, `vector*`

`vector` はオブジェクトが vector であるか、長さが同じか、そして内容が各 subpattern に match するかを確認します。

`vector*` も似ていますが、subpattern の長さ以上であることを許す soft-match variant と呼ばれます。

~~~lisp
(match #(1 2 3)
  ((vector _ x _)
   x))
;; -> 2
~~~

~~~lisp
(match #(1 2 3 4)
  ((vector _ x _)
   x))
;; -> NIL : does not match
~~~

~~~lisp
(match #(1 2 3 4)
  ((vector* _ x _)
   x))
;; -> 2 : soft match.
~~~

~~~
<vector-pattern> : vector      | simple-vector
                   bit-vector  | simple-bit-vector
                   string      | simple-string
                   base-string | simple-base-string | sequence
(<vector-pattern> &rest subpatterns)
~~~

[​]{#class--structure--pattern}

### クラスと構造体のパターン

等価な3つの書き方があります。

~~~lisp
(defstruct foo bar baz)
(defvar *x* (make-foo :bar 0 :baz 1)

(match *x*
  ;; make-instance style
  ((foo :bar a :baz b)
   (values a b))
  ;; with-slots style
  ((foo (bar a) (baz b))
   (values a b))
  ;; slot name style
  ((foo bar baz)
   (values bar baz)))
~~~

### `type`, `satisfies`

`type` パターンはオブジェクトがその型であればマッチします。`satisfies` は述語がオブジェクトに対して true を返す場合にマッチします。lambda フォームも受け付けます。

### `assoc`, `property`, `alist`, `plist`

これらのパターンはすべて、まずパターンがリストかどうかを確認します。それが満たされると内容を取得し、値をサブパターンに対してマッチします。`assoc` と `property` パターンは単一の値にマッチします。`alist` と `plist` パターンは実質的に複数のパターンを `and` します。

~~~lisp
(match '(:a 1 :b 2)
  ((property :a 1) 'found))
;; -> FOUND
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property :a n) n))
;; -> 1
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property :d n) n))
;; -> NIL
~~~

`cl:getf` と同様に、`property` パターンにデフォルト値を追加できます。`cl:getf` と異なり、そのデフォルトが使われているかどうかを捕捉するフラグをさらに追加できます。

~~~lisp
(match '(:a 1 :b 2)
  ((property :c c 3) c))
;; -> 3
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property :c c 3 foundp) (list c foundp)))
;; -> (3 NIL)
~~~

`property!` パターンは、キーが実際に存在する場合にだけマッチします。

~~~lisp
(match '(:a 1 :b 2)
  ((property :d n) (list n))
  (_ 'fail))
;; -> (NIL)
~~~

~~~lisp
(match '(:a 1 :b 2)
  ((property! :d n) (list n))
  (_ 'fail))
;; -> FAIL
~~~

`plist` を使うと、複数の property にマッチできます。

~~~lisp
(match '(:a 1 :b 2)
  ((plist :a 1 :b x) x))
;; -> 2
~~~

`assoc` パターンは連想リストにマッチします。`cl:assoc` と同じように `:test` キーワードを取れます。

~~~lisp
(match '((a . 1) (b . 2) (c . 3))
  ((assoc 'a 1) 'ok))
;; -> OK
~~~

~~~lisp
(match '((a . 1) (b . 2) (c . 3))
  ((assoc 'b x) x))
;; -> 2
~~~

~~~lisp
(match '(("one" . 1) ("two" . 2))
  ((assoc "one" x :test #'string-equal) x))
;; -> 1
~~~

`alist` パターンは連想リストの複数の要素にマッチします。

~~~lisp
(match '((a . 1) (b . 2) (c . 3))
  ((alist ('a . 1) ('c . n)) n))
;; -> 3
~~~

[​]{#array-simple-array-row-major-array-pattern}

### 配列、`simple-array`、`row-major-array` のパターン

https://github.com/guicho271828/trivia/wiki/Type-Based-Destructuring-Patterns#array-simple-array-row-major-array-pattern を参照してください。

## 論理に基づくパターン

任意のパターンをいくらかの論理と組み合わせられます。

### `and`, `or`

次のものは:

~~~lisp
(match x
  ((or (list 1 a)
       (cons a 3))
   a))
~~~

`(1 2)` と `(4 . 3)` の両方にマッチし、それぞれ 2 と 4 を返します。

### `not`

サブパターンがマッチするときはマッチしません。サブパターンで使われた変数は本体から見えません。

## guard

guard を使うと、パターンを使い、さらに述語に対して検証できます。

構文は `guard` + `subpattern` + `a test form`、そして本体です。

~~~lisp
(match (list 2 5)
  ((guard (list x y)     ; subpattern1
          (= 10 (* x y))) ; test-form
   :ok))
~~~

サブパターンが真なら test form が評価され、それも真なら subpattern1 にマッチします。


## パターンの入れ子

パターンは入れ子にできます。

~~~lisp
(match '(:a (3 4) 5)
  ((list :a (list _ c) _)
   c))
~~~

これは `4` を返します。

## さらに見る

[special patterns](https://github.com/guicho271828/trivia/wiki/Special-Patterns) を参照してください: `place`, `bind`, `access`。
 
#  正規表現 {#chapter-regexp}
 

[ANSI Common Lisp 標準](http://www.lispworks.com/documentation/HyperSpec/index.html)には正規表現の機能は含まれていませんが、この用途のライブラリはいくつか存在します。たとえば [cl-ppcre](https://github.com/edicl/cl-ppcre) です。

さらに多くのリンクについては、対応する [Cliki: regexp](http://www.cliki.net/Regular%20Expression) ページも参照してください。

一部の CL 処理系、特に [CLISP](http://clisp.sourceforge.net/impnotes.html#regexp) と [ALLEGRO CL](https://franz.com/support/documentation/current/doc/regexp.htm) は正規表現の機能を含んでいることに注意してください。迷った場合は、マニュアルを確認するかベンダーに尋ねてください。

以下の説明は完全なものにはほど遠いので、CL-PPCRE ライブラリに付属するリファレンスマニュアルを忘れずに確認してください。

## PPCRE

[CL-PPCRE](https://github.com/edicl/cl-ppcre)（Portable Perl-compatible 正規表現の略）は、Common Lisp 向けの移植可能な正規表現ライブラリで、幅広い機能と優れた性能を備えています。多くの Common Lisp 処理系へ移植されており、Quicklisp 経由で簡単にインストールできます（または依存関係として追加できます）。

~~~lisp
(ql:quickload "cl-ppcre")
~~~

CL-PPCRE ライブラリ関数による基本操作を以下に説明します。


### マッチするパターンを探す: scan, create-scanner

`scan` 関数は与えられたパターンとのマッチを試み、成功すると4つの値を多値で返します。すなわち、マッチの開始位置、終了位置、そしてレジスタのマッチの開始と終了を表す2つの配列です。失敗すると `NIL` を返します。

正規表現パターンは `create-scanner` 関数呼び出しでコンパイルできます。他の関数から使える「scanner」が作成されます。

例:

~~~lisp
(let ((ptrn (ppcre:create-scanner "(a)*b")))
  (ppcre:scan ptrn "xaaabd"))
~~~

これは次と同じ結果を返します。

~~~lisp
(ppcre:scan "(a)*b" "xaaabd")
~~~

ただし、式の解析とコンパイルは一度だけ行われるため、繰り返し `scan` を呼ぶ場合に必要な時間は少なくなります。


### 情報を抽出する

CL-PPCRE は、マッチした断片を抽出する方法をいくつか提供します。

#### all-matches, all-matches-as-strings

`all-matches-as-strings` 関数はとても便利です。マッチのリストを返します。

~~~lisp
(ppcre:all-matches-as-strings "\\d+" "numbers: 1 10 42")
;; => ("1" "10" "42")
~~~

`all-matches` 関数も似ていますが、位置のリストを返します。

~~~lisp
(ppcre:all-matches "\\d+" "numbers: 1 10 42")
;; => (9 10 11 13 14 16)
~~~

よく見てください。実際には、すべてのマッチの開始位置と終了位置を含むリストを返しています。9 と 10 は最初の数値（1）の開始と終了、という具合です。

この例の文字列から整数を抽出したい場合は、結果に `parse-integer` をマップするだけです。

~~~lisp
CL-USER> (ppcre:all-matches-as-strings "\\d+" "numbers: 1 10 42")
;; ("1" "10" "42")
CL-USER> (mapcar #'parse-integer *)
(1 10 42)
~~~

2つの関数は通常の `:start` と `:end` キーワード引数を受け付けます。さらに、`all-matches-as-strings` は `:sharedp` 引数を受け付けます。

> SHAREDP が真の場合、部分文字列は TARGET-STRING と構造を共有することがあります。

#### count-matches（2.1.2、2024年4月で追加）

`(count-matches regex target-string)` は、`target-string` に対する `regex` のすべてのマッチ数を返します。


~~~lisp
CL-USER> (ppcre:count-matches "a" "foo bar baz")
2

CL-USER> (ppcre:count-matches "\\w*" "foo bar baz")
6
~~~



#### scan-to-strings, register-groups-bind

`scan-to-strings` 関数は `scan` に似ていますが、位置ではなく対象文字列の部分文字列を返します。この関数は成功時に2つの値を返します。マッチ全体の文字列と、マッチしたレジスタに対応する部分文字列（または NIL）の配列です。

`register-groups-bind` 関数は、与えられたパターンを対象文字列に対してマッチさせ、マッチした断片を与えられた変数に束縛します。

~~~lisp
(ppcre:register-groups-bind (first second third fourth)
      ("((a)|(b)|(c))+" "abababc" :sharedp t)
    (list first second third fourth))
;; => ("c" "a" "b" "c")
~~~

CL-PPCRE は、マッチした断片を変数に代入する前に関数を呼び出すための短縮形も提供しています。

~~~lisp
(ppcre:register-groups-bind
  (fname lname (#'parse-integer date month year))
      ("(\\w+)\\s+(\\w+)\\s+(\\d{1,2})\\.(\\d{1,2})\\.(\\d{4})"
       "Frank Zappa 21.12.1940")
    (list fname lname date month year))
;; => ("Frank" "Zappa" 21 12 1940)
~~~

### テキストを置換する: regex-replace, regex-replace-all

~~~lisp
(ppcre:regex-replace "a" "abc" "A") ;; => "Abc"
;; or
(let ((pat (ppcre:create-scanner "a")))
  (ppcre:regex-replace pat "abc" "A"))
~~~

### S式構文（parse tree）

cl-ppcre は、文字列の代わりに S 式として正規表現を受け取ることもできます。これは "parse tree"（解析木）構文と呼ばれ、バックスラッシュのエスケープを避けられます。

~~~lisp
;; Match one or more digits:
(ppcre:scan '(:greedy-repetition 1 nil :digit-class)
            "abc123def")
;; => 3, 6, #(), #()
~~~

これは次と等価です。

~~~lisp
(ppcre:scan "\\d+" "abc123def")
~~~

ここでは `scan` を使いましたが、`all-matches-as-strings` や、正規表現を引数として受け取る任意の関数も使えます。つまり Lisp らしい正規表現を使うわけです。

`parse-string` を使うと、文字列表現と木構造の表現を相互に変換できます（これは例から学ぶための優れた方法です）。

~~~lisp
(ppcre:parse-string "(\\d+)-(\\w+)")
;; => (:SEQUENCE
;;     (:REGISTER
;;      (:GREEDY-REPETITION 1 NIL :DIGIT-CLASS))
;;     #\-
;;     (:REGISTER
;;      (:GREEDY-REPETITION 1 NIL :WORD-CHAR-CLASS)))
~~~

木構造の形式は、プログラムからパターンを組み立てる場合に便利です。

~~~lisp
(defun match-tag (tag-name)
  "Build a regex matching an XML opening tag."
  `(:sequence
    "<" ,tag-name
    (:greedy-repetition 0 nil
      (:inverted-char-class #\>))
    ">"))

(ppcre:scan (match-tag "div") "<div class='x'>")
;; => 0, 16, #(), #()

(ppcre:all-matches-as-strings (match-tag "div") "<div class='x'>")
;; => ("<div class='x'>")
~~~

一般的な木構造の要素は次のとおりです。

| 木構造の形式 | 文字列での等価表現 |
|---|---|
| `:digit-class` | `\d` |
| `:word-char-class` | `\w` |
| `:whitespace-char-class` | `\s` |
| `(:greedy-repetition 0 nil x)` | `x*` |
| `(:greedy-repetition 1 nil x)` | `x+` |
| `(:greedy-repetition 0 1 x)` | `x?` |
| `(:register x)` | `(x)` |
| `(:alternation x y)` | `x\|y` |
| `(:sequence x y)` | `xy` |

完全な parse tree 構文については、[cl-ppcre docs](https://edicl.github.io/cl-ppcre/#create-scanner2) を参照してください。

## さらに見る

- [common-lisp-libraries.readthedocs.io の cl-ppcre](https://common-lisp-libraries.readthedocs.io/cl-ppcre/) を参照し、`do-matches`、`do-matches-as-strings`、`do-register-groups`、`do-scans`、`parse-string`、`regex-apropos`、`quote-meta-chars`、`split` などを読んでください。
 
#  入出力 {#chapter-io}
 

入出力のための便利なパターンをいくつか見てみましょう。

## ユーザー入力を求める: `y-or-n-p`, `yes-or-no-p`, `read`, `read-line`

[`y-or-n-p` と `yes-or-no-p`](https://cl-community-spec.github.io/pages/y_002dor_002dn_002dp.html) 関数はプロンプトを表示し、処理を止めて "yes" または "no" の入力（短い形式または長い形式）を待ちます。

[`read`](https://cl-community-spec.github.io/pages/read.html) 関数は、他の引数なしで呼び出されると処理を止めて入力を待ちますが、Lisp のフォームを読み取ります。

~~~lisp
CL-USER> (read)
|               ;; <---- point waiting for input.
~~~

`(1+ 2)` と入力すると、次の結果が見えます。

```lisp
(1+ 2)
```

3 が表示されると思いましたか。

もう一度試してみましょう。

~~~lisp
(read)
hello  ;; our input
HELLO  ;; return value: a symbol, hence capitalized

(read)
(list a b c)   ;; our input
(LIST A B C)   ;; return value: some s-expression.
~~~

結果は評価されて*いません*。

`read` 関数はソースコードを読み取ります。文字列ではありません。これは S 式を返します。

文字列が欲しい場合は、引用符の中に書いてください（または次の節を参照してください）。

まだコードを評価してはいません。そのためには `eval` があります。

~~~lisp
(read)
(1+ 2)  ;; input
(1+ 2)  ;; return value

(eval *)
;; 3
~~~

これが、最も原始的な REPL、つまり Read-Eval-Print-Loop を作る方法です。

~~~lisp
CL-USER> (loop (print (eval (read))))
(1+ 1)  ;; input

2 (1+ 2)  ;; result + my next input

3
~~~

上の行は永遠にループし、抜け出す方法はありません。ただし `(quit)` は別で、これはトップレベルの REPL も終了します。次は、`q` シンボル（文字列ではありません）を見たら終了する、とても単純なループです。

~~~lisp
(loop for input = (read)
      while (not (equal input 'q))
      do (print (eval input)))
~~~


### 入力を文字列として読む: `read-line`

入力を*文字列*として読むには、[`read-line`](https://cl-community-spec.github.io/pages/read_002dline.html) を使います。

~~~lisp
CL-USER> (defparameter *input* (read-line))
This is a longer input.
*INPUT*

CL-USER> *input*
"This is a longer input."
~~~

これは複数行を読みません。


## プログラムの標準出力をリダイレクトする

次のようにします。

~~~lisp
(let ((*standard-output* <some form generating a stream>))
  ...)
~~~

[`*standard-output*`](http://www.lispworks.com/documentation/HyperSpec/Body/v_debug_.htm) はダイナミック変数なので、`LET` フォームの本体の実行中にそれを参照するすべての箇所は、あなたが束縛したストリームを参照します。`LET` フォームを抜けると、通常実行であれ、関数全体を抜ける `RETURN-FROM` であれ、例外であれ、その他何であれ、`*STANDARD-OUTPUT*` の古い値が復元されます。（ちなみに、Common Lisp でグローバル変数が他の言語ほど壊れたものにならないのはこのためです。特定のフォームの実行中だけ束縛でき、そのフォームが終わった後に以前の値を失う危険がないので、かなり安全に使えます。すべての関数に渡される追加のパラメータのように振る舞います。）

プログラムの出力をファイルへ送るべき場合は、次のようにできます。

~~~lisp
(with-open-file (*standard-output* "somefile.dat"
                                   :direction :output
                                   :if-exists :supersede)
  ...)
~~~

[`with-open-file`](http://www.lispworks.com/documentation/HyperSpec/Body/m_w_open.htm) はファイルを開き、必要なら作成し、`*standard-output*` を束縛し、本体を実行し、ファイルを閉じ、`*standard-output*` を以前の値へ復元します。これ以上快適にはなりません。[​]{#faith}

[​]{#stream-}

## 文字ストリームによる忠実な出力

ここでいう _忠実な出力_ とは、0 から 255 の間のコードを持つ文字がそのまま書き出されることを意味します。つまり、ストリームに対して `(princ (code-char 0..255) s)` でき、8 ビットのバイトが書き出されると期待できるということです。Unicode と 16 ビットまたは 32 ビットの文字表現の時代には、これは自明ではありません。これは、ä、ß、þ といった文字の [`char-code`](http://www.lispworks.com/documentation/HyperSpec/Body/f_char_c.htm) が 0..255 の範囲にあることを要求するものでは*ありません*。実装は任意のコードを使えます。しかし、とりわけ `#\Newline` から CRLF への変換が起きないことは要求します。

Common Lisp には、文字の I/O とバイト（バイナリ）の I/O を区別する長い伝統があります。たとえば [`read-byte`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_by.htm) と [`read-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_cha.htm) は標準に含まれています。一部の実装では両方の関数を交換可能に呼べます。他の実装では、どちらか一方だけが許可されます。[simple ストリームの提案](https://www.cliki.net/simple-stream) は、両方が可能な _bivalent stream_ の概念を定義しています。

さまざまな element-type が有用なのは、一部のプロトコルがチャネル上で 8 ビットの出力を送信できることに依存しているからです。たとえば HTTP では、ヘッダは通常 ASCII であり、行終端として CRLF を使うべきです。一方でボディは MIME タイプ application/octet-stream を持つことができ、その場合 CRLF 変換はデータを破壊します。（これは、誤って設定された web サーバーが未知のファイルを text/plain の MIME タイプとして宣言したとき、MS-Windows 上の Netscape ブラウザが送信データを壊す仕組みです。text/plain はほとんどの Apache 設定でデフォルトです）。

以下は、実装依存の選択肢と振る舞い、および実験用のコードの一覧です。

### SBCL

任意のバイトを文字列にロードするには、`:iso-8859-1` の external format を使います。例:

~~~lisp
(uiop:read-file-string "/path/to/file" :external-format :iso-8859-1)
~~~

### CLISP

CLISP では、次を使うことで忠実な出力が可能です。

~~~lisp
:external-format
(ext:make-encoding :charset 'charset:iso-8859-1
                   :line-terminator :unix)
~~~

`(SETF (STREAM-ELEMENT-TYPE F) '(UNSIGNED-BYTE 8))` も使えます。ここで `SETF` できることは CLISP 固有の拡張です。`:EXTERNAL-FORMAT :UNIX` を使うと移植性の問題が発生します。MS-Windows 上のデフォルト文字セットは `CHARSET:CP1252` だからです。`CHARSET:CP1252` は、たとえば `(CODE-CHAR #x81)` の出力を許しません。

~~~
;*** - Character #\u0080 cannot be represented in the character set CHARSET:CP1252
~~~

コードが 127 を超える文字は ASCII で表現できません。

~~~
;*** - Character #\u0080 cannot be represented in the character set CHARSET:ASCII
~~~

### AllegroCL

`#+(AND ALLEGRO UNIX) :DEFAULT`（未テスト）- UNIX では十分なようですが、AllegroCL の MS-Windows 版では動かないでしょう。

### LispWorks

`:EXTERNAL-FORMAT '(:LATIN-1 :EOL-STYLE :LF)`（Marc Battyani により確認済み）

### 例

試すためのサンプルコードを示します。

~~~lisp
(defvar *unicode-test-file* "faithtest-out.txt")

(defun generate-256 (&key (filename *unicode-test-file*)
			  #+CLISP (charset 'charset:iso-8859-1)
                          external-format)
  (let ((e (or external-format
	       #+CLISP (ext:make-encoding :charset charset
                           :line-terminator :unix))))
    (describe e)
    (with-open-file (f filename :direction :output
		     :external-format e)
      (write-sequence
        (loop with s = (make-string 256)
	      for i from 0 to 255
	      do (setf (char s i) (code-char i))
	      finally (return s))
       f)
      (file-position f))))

;(generate-256 :external-format :default)
;#+CLISP (generate-256 :external-format :unix)
;#+CLISP (generate-256 :external-format 'charset:ascii)
;(generate-256)

(defun check-256 (&optional (filename *unicode-test-file*))
  (with-open-file (f filename :direction :input
		     :element-type '(unsigned-byte 8))
    (loop for i from 0
	  for c = (read-byte f nil nil)
	  while c
	  unless (= c i)
	  do (format t "~&Position ~D found ~D(#x~X)." i c c)
	  when (and (= i 33) (= c 32))
	  do (let ((c (read-byte f)))
	       (format t "~&Resync back 1 byte ~D(#x~X) - cause CRLF?." c c) ))
    (file-length f)))

#| CLISP
(check-256 *unicode-test-file*)
(progn (generate-256 :external-format :unix) (check-256))
; uses UTF-8 -> 385 bytes

(progn (generate-256 :charset 'charset:iso-8859-1) (check-256))

(progn (generate-256 :external-format :default) (check-256))
; uses UTF-8 + CRLF(on MS-Windows) -> 387 bytes

(progn (generate-256 :external-format
  (ext:make-encoding :charset 'charset:iso-8859-1 :line-terminator :mac)) (check-256))
(progn (generate-256 :external-format
  (ext:make-encoding :charset 'charset:iso-8859-1 :line-terminator :dos)) (check-256))
|#
~~~

[​]{#bulk}

## 高速な一括 I/O

大量のデータをコピーする必要があり、コピー元とコピー先がどちらもストリーム（同じ [element type](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_e.htm#element_type)）である場合、[`read-sequence`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_seq.htm) と [`write-sequence`](http://www.lispworks.com/documentation/HyperSpec/Body/f_wr_seq.htm) を使うと非常に高速です。

~~~lisp
(let ((buf (make-array 4096 :element-type (stream-element-type input-stream))))
  (loop for pos = (read-sequence buf input-stream)
        while (plusp pos)
        do (write-sequence buf output-stream :end pos)))
~~~
 
#  ファイルとディレクトリ {#chapter-files}
 

ここではファイルとディレクトリを操作するための関数とライブラリをいくつか見ていきます。

この章では主に
[namestring](http://www.lispworks.com/documentation/HyperSpec/Body/19_aa.htm)
を使って[ファイル名を指定](http://www.lispworks.com/documentation/HyperSpec/Body/19_.htm)します。いくつかのレシピでは
[pathname](http://www.lispworks.com/documentation/HyperSpec/Body/19_ab.htm)
も使います。

多くの関数は UIOP 由来なので、直接見ておくことを勧めます。

* [UIOP/filesystem](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fFILESYSTEM)
* [UIOP/pathname](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fPATHNAME)

もちろん、次も見逃さないでください。

* [Files and File I/O in Practical Common Lisp](http://gigamonkeys.com/book/files-and-file-io.html)


### pathname の構成要素を取得する

#### ファイル名（ディレクトリなし）

pathname からファイル名を取得するには `file-namestring` を使います。

~~~lisp
(file-namestring #p"/path/to/file.lisp") ;; => "file.lisp"
~~~

#### ファイルの拡張子

ファイルの拡張子は Lisp 用語では "pathname type" と呼ばれます。

~~~lisp
(pathname-type "~/foo.org")  ;; => "org"
~~~

#### ファイルのベース名

ベース名は "pathname name" と呼ばれます。

~~~lisp
(pathname-name "~/foo.org")  ;; => "foo"
(pathname-name "~/foo")      ;; => "foo"
~~~

ディレクトリの pathname に末尾のスラッシュがある場合、`pathname-name` は `nil` を返すことがあります。代わりに `pathname-directory` を使います。

~~~lisp
(pathname-name "~/foo/")     ;; => NIL
(first (last (pathname-directory #P"~/foo/"))) ;; => "foo"
~~~

#### 親ディレクトリ

~~~lisp
(uiop:pathname-parent-directory-pathname #P"/foo/bar/quux/")
;; => #P"/foo/bar/"
~~~

### ファイルが存在するか調べる

関数
[`probe-file`](http://www.lispworks.com/documentation/HyperSpec/Body/f_probe_.htm)
を使います。これは
[一般化ブール値](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_g.htm#generalized_boolean)
を返します。ファイルが存在しなければ `nil`、存在するならその
[truename](http://www.lispworks.com/documentation/HyperSpec/Body/20_ac.htm)
(渡した引数とは異なる場合があります) を返します。

より移植性を高めるには、`uiop:probe-file*` または `uiop:file-exists-p` を使います。これらは (存在する場合) ファイルの pathname を返します。

ファイル名に `*`、`[`、`]` などのワイルドカード文字が含まれているかもしれない場合は、下を読んでください。


~~~lisp
* (probe-file "/etc/passwd")
#p"/etc/passwd"

;; symlink を作成する (shell):
$ ln -s /etc/passwd foo

* (probe-file "foo")
#p"/etc/passwd"

* (probe-file "bar")
NIL
~~~


[​]{#file--test--wildcard-character-}

### ファイルが存在するか調べる（ワイルドカード文字に注意）

`(make-pathname :name filename-with-wild-chars)` の後に `probe-file` を使うか、SBCL では `sb-ext:parse-native-namestring` を使います。なぜでしょうか。

`*` だけでなく `[` と `]` もワイルドカード文字です。ファイル名の中では、これらは制限付きの [wildcard pathnames](https://cl-community-spec.github.io/pages/Restrictions-on-Wildcard-Pathnames.html) を作ります。

ファイル名にこれらが含まれている場合、ファイルが存在していても `uiop:probe-file*` と `uiop:file-exists-p` は NIL を返します。

"best-of-[2000]-01.mp3" という音楽ファイルがあるとします。

```txt
$ touch best-of-\[2000\]-01.mp3
```

2 つのバックスラッシュで文字をエスケープしない限り、`probe-file` は使えません (これは `str:replace-all` で行うことになるでしょう)。

```lisp
(probe-file "best-of-[2000]-01.mp3")
;; => NIL

(probe-file "best-of-\\[2000\\]-01.mp3")
;; => #P"best-of-\\[2000]-01.mp3"
```

`make-pathname` に続けて `probe-file` を使えます。

~~~lisp
(probe-file (make-pathname :name "best-of-[2000]-01.mp3"))
;; => #P"/home/me/path/to/best-of-\\[2000]-01.mp3"
~~~

SBCL では `sb-ext:parse-native-namestring` を使えます。

```lisp
(sb-ext:parse-native-namestring "best-of-[2000]-01.mp3")
;; => #P"best-of-\\[2000]-01.mp3"
```

`uiop:ensure-pathname` では `:want-non-wild t` キーパラメータを使えます。


### チルダ (`~`) を含むファイル名またはディレクトリ名を展開する

移植性のために `uiop:native-namestring` を使います。

~~~lisp
(uiop:native-namestring "~/.emacs.d/")
"/home/me/.emacs.d/"
~~~

存在しないファイルやディレクトリについてもチルダを展開します。

~~~lisp
(uiop:native-namestring "~/foo987.txt")
:: "/home/me/foo987.txt"
~~~

いくつかの処理系 (CCL、ABCL、ECL、CLISP、LispWorks) では、`namestring` も同様に動作します。SBCL ではファイルまたはディレクトリが存在しない場合、`namestring` はパスを展開せず、チルダを含む引数を返します。

存在するファイルには `truename` も使えます。ただし少なくとも SBCL では、パスが存在しない場合エラーを返します。

[​]{#pathname--windows--directory-separator--string-}

### pathname を Windows のディレクトリ区切り文字を使う文字列に変換する

ここでも `uiop:native-namestring` を使います。

~~~lisp
CL-USER> (uiop:native-namestring #p"~/foo/")
"C:\\Users\\You\\foo\\"
~~~

逆の操作については `uiop:parse-native-namestring` も参照してください。

### ディレクトリを作成する

関数
[ensure-directories-exist](http://www.lispworks.com/documentation/HyperSpec/Body/f_ensu_1.htm)
は、ディレクトリが存在しない場合に作成します。

~~~lisp
(ensure-directories-exist "foo/bar/baz/")
~~~

これは `foo`、`bar`、`baz` を作成するかもしれません。末尾のスラッシュを忘れないでください。

### ディレクトリを削除する

pathname (`#p`)、末尾のスラッシュ、`:validate` キーとともに `uiop:delete-directory-tree` を使います。

~~~lisp
;; mkdir dirtest
(uiop:delete-directory-tree #p"dirtest/" :validate t)
~~~

ディレクトリを指す文字列を `pathname` で包んで使うこともできます。

~~~lisp
(defun rmdir (path)
  (uiop:delete-directory-tree (pathname path) :validate t))
~~~

UIOP には `delete-empty-directory` もあります。

[cl-fad][cl-fad] には `(fad:delete-directory-and-files "dirtest")` があります。

### ファイルとディレクトリを連結する

`merge-pathnames` を使いますが、注意点が 1 つあります。ディレクトリを連結したい場合、第 2 引数には末尾の `/` が必要です。

いつものように UIOP 関数を見てください。細かい場合分けを修正する `uiop:merge-pathnames*` 相当があります。

あるディレクトリに別のディレクトリを連結する方法は次のとおりです。

~~~lisp
(merge-pathnames "otherpath" "/home/vince/projects/")
;; 重要:                                         ^^
;; 末尾の / は directory を表す
;; => #P"/home/vince/projects/otherpath"
~~~

違いを見てください。どちらのパスにも末尾のスラッシュを含めない場合、`otherpath` と `projects` はファイルと見なされるため、`otherpath` は `projects` を含むベースディレクトリに連結されます。

~~~lisp
(merge-pathnames "otherpath" "/home/vince/projects")
;; #P"/home/vince/otherpath"
;;               ^^ "projects" はない。ファイルと見なされたため
~~~

あるいは、`otherpath/` (末尾の `/` 付き) だが `projects` はファイルと見なされる場合です。

~~~lisp
(merge-pathnames "otherpath/" "/home/vince/projects")
;; #P"/home/vince/otherpath/projects"
;;                ^^ ここに挿入される
~~~

### 現在の作業ディレクトリ（CWD）を取得する

`uiop/os:getcwd` を使います。

~~~lisp
(uiop/os:getcwd)
;; #P"/home/vince/projects/cl-cookbook/"
;;                                    ^ 末尾のスラッシュ付き。merge-pathnames に便利
~~~

### Lisp プロジェクトからの相対的な現在のディレクトリを取得する

`asdf:system-relative-pathname system path` を使います。

`mysystem` の中で作業しているとします。これは ASDF のシステム宣言を持ち、そのシステムは Lisp イメージにロードされています。この ASDF ファイルはファイルシステムのどこかにあり、`src/web/` へのパスが欲しいとします。次のようにします。

~~~lisp
(asdf:system-relative-pathname "mysystem" "src/web/")
;; => #P"/home/vince/projects/mysystem/src/web/"
~~~

これはシステムのソースが別の場所にある他のユーザーのマシンでも動作します。


### 現在の作業ディレクトリを設定する

[`uiop:chdir`](https://asdf.common-lisp.dev/uiop.html#Function-uiop_002fos_003achdir) _`path`_ を使います。

~~~lisp
(uiop:chdir "/bin/")
0
~~~

_path_ の末尾のスラッシュは省略できます。

または、次の操作の間だけカレントディレクトリを設定するには、`uiop:with-current-directory` を使います。

~~~lisp
(let ((dir "/path/to/another/directory/"))
  (uiop:with-current-directory (dir)
      (directory-files "./")))
~~~


### ファイルを開く

Common Lisp には
[`open`](http://www.lispworks.com/documentation/HyperSpec/Body/f_open.htm) と
[`close`](http://www.lispworks.com/documentation/HyperSpec/Body/f_close.htm)
関数があり、これはおそらく馴染みのある他のプログラミング言語の同名の関数に似ています。しかし、ほとんど常にマクロ
[`with-open-file`](http://www.lispworks.com/documentation/HyperSpec/Body/m_w_open.htm)
を使うことを勧めます。このマクロはファイルを開き、終わったら閉じるだけではありません。コードが本体から異常に抜けた場合 (
[`go`](https://www.lispworks.com/documentation/HyperSpec/Body/s_go.htm),
[`return-from`](https://www.lispworks.com/documentation/HyperSpec/Body/s_ret_fr.htm),
または [`throw`](http://www.lispworks.com/documentation/HyperSpec/Body/s_throw.htm) の使用など) も処理してくれます。`with-open-file` の典型的な使い方は次のようになります。

~~~lisp
(with-open-file (str <_file-spec_>
    :direction <_direction_>
    :if-exists <_if-exists_>
    :if-does-not-exist <_if-does-not-exist_>)
  (your code here))
~~~

*   `str` は、ファイルを開くことで作成されるストリームに束縛される変数です。
*   `<_file-spec_>` は truename または pathname になります。
*   `<_direction_>` は通常 `:input` (ファイルから読みたい場合)、`:output` (ファイルに書きたい場合)、または `:io` (同時に読み書き _両方_ する場合) です。デフォルトは `:input` です。
*   `<_if-exists_>` は、書き込み用にファイルを開きたいが同名のファイルがすでに存在する場合にどうするかを指定します。ファイルから読むだけなら、このオプションは無視されます。デフォルトは `:error` で、エラーが通知されることを意味します。他に便利なオプションとして、`:supersede` (新しいファイルが古いものを置き換える)、`:append` (内容がファイルに追加される)、`nil` (ストリーム変数が `nil` に束縛される)、`:rename` (つまり古いファイルの名前が変更される) があります。
*   `<_if-does-not-exist_>` は、開きたいファイルが存在しない場合にどうするかを指定します。エラーを通知する `:error`、空のファイルを作成する `:create`、ストリーム変数を `nil` に束縛する `nil` のいずれかです。デフォルトは簡単に言えば、指定した他のオプションに応じて正しいことをする、というものです。詳細は CLHS を参照してください。

`with-open-file` にはさらに多くのオプションがある点に注意してください。詳細は
[the CLHS entry for `open`](http://www.lispworks.com/documentation/HyperSpec/Body/f_open.htm)
を参照してください。下に `with-open-file` の使い方の例があります。また、既存のファイルを読むために開くだけなら、通常キーワード引数を指定する必要はありません。

### ファイルを読む

[​]{#file--string--line--list-}

#### ファイルを文字列または行のリストに読む

ファイルの内容に文字列形式でアクセスしたり、行のリストを取得したりする必要はかなりよくあります。

uiop は ASDF に含まれており (追加でインストールするライブラリやロードするシステムはありません)、次の関数を持ちます。


~~~lisp
(uiop:read-file-string "file.txt")
~~~

そして

~~~lisp
(uiop:read-file-lines "file.txt")
~~~

*別の方法として*、これは `read-line` や `read-char` 関数でも実現できますが、おそらく最善の解決策ではありません。ファイルが複数行に分かれていないかもしれませんし、1 文字ずつ読むと大きな性能問題を招くかもしれません。この問題を解決するには、特定のサイズのまとまりを使ってファイルを読めます。

~~~lisp
(with-output-to-string (out)
  (with-open-file (in "/path/to/big/file")
    (loop with buffer = (make-array 8192 :element-type 'character)
          for n-characters = (read-sequence buffer in)
          while (< 0 n-characters)
          do (write-sequence buffer out :start 0 :end n-characters)))))
~~~

さらに、常に文字型の要素を使う代わりに、読み書きされるデータの形式を自由に変更できます。たとえばオクテットとしてデータを読むには、`with-output-to-string`、`with-open-file`、`make-array` 関数の `:element-type` 引数を `'(unsigned-byte 8)` に設定できます。

#### utf-8 エンコーディングで読む

`ASCII stream decoding error` を避けるために UTF-8 エンコーディングを指定したい場合があります。

~~~lisp
(with-open-file (in "/path/to/big/file"
                     :external-format :utf-8)
                 ...
~~~

#### SBCL のデフォルトエンコーディングを utf-8 に設定する

ライブラリの内部を制御できないことがあるため、デフォルトのエンコーディングを utf-8 に設定しておく方がよいでしょう。`~/.sbclrc` に次の行を追加します。

    (setf sb-impl::*default-external-format* :utf-8)

必要に応じて:

    (setf sb-alien::*default-c-string-external-format* :utf-8)

#### ファイルを 1 行ずつ読む

[`read-line`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_lin.htm)
はストリームから 1 行を読みます (デフォルトは
[_standard input_](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_s.htm#standard_input))
です）。行の終端は改行文字またはファイルの終端で決まります。この行は末尾の改行文字 _なし_ の文字列として返ります（`read-line` には第 2 戻り値があり、末尾に改行がなかった場合、つまり行がファイルの終端で終わった場合に true になる点に注意してください）。`read-line` はデフォルトではファイルの終端に到達するとエラーを通知します。第 2 引数に NIL を渡すとこれを抑制できます。その場合、ファイルの終端に到達すると `read-line` は `nil` を返します。

~~~lisp
(with-open-file (stream "/etc/passwd")
  (do ((line (read-line stream nil)
       (read-line stream nil)))
       ((null line))
       (print line)))
~~~

ファイルの終端を示すために `nil` の代わりに使う第 3 引数も指定できます。

~~~lisp
(with-open-file (stream "/etc/passwd")
  (loop for line = (read-line stream nil 'foo)
   until (eq line 'foo)
   do (print line)))
~~~

[​]{#file--1-character-}

#### ファイルを 1 文字ずつ読む

[`read-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_cha.htm)
は `read-line` に似ていますが、1 行ではなく 1 文字だけを読みます。もちろん、この関数では改行文字は他の文字と異なる扱いを受けません。

~~~lisp
(with-open-file (stream "/etc/passwd")
  (do ((char (read-char stream nil)
       (read-char stream nil)))
       ((null char))
       (print char)))
~~~

[​]{#character-}

#### 1 文字先を見る

ストリームの次の文字を実際には取り除かずに「見る」ことができます。これを行うのが関数
[`peek-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_peek_c.htm)
です。これは最初の (省略可能な) 引数に応じて 3 つの異なる目的に使えます (第 2 引数は読む対象のストリームです)。最初の引数が `nil` の場合、`peek-char` はストリームで待っている次の文字をそのまま返します。

~~~lisp
CL-USER> (with-input-from-string (stream "I'm not amused")
           (print (read-char stream))
           (print (peek-char nil stream))
           (print (read-char stream))
           (values))

#\I
#\'
#\'
~~~

最初の引数が `T` の場合、`peek-char` は
[whitespace](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_w.htm#whitespace)
文字を読み飛ばします。つまりストリームで待っている次の空白以外の文字を返します。空白文字は `read-char` で読まれたかのようにストリームから消えます。

~~~lisp
CL-USER> (with-input-from-string (stream "I'm not amused")
           (print (read-char stream))
           (print (read-char stream))
           (print (read-char stream))
           (print (peek-char t stream))
           (print (read-char stream))
           (print (read-char stream))
           (values))

#\I
#\'
#\m
#\n
#\n
#\o
~~~

`peek-char` の最初の引数が文字の場合、その特定の文字が見つかるまですべての文字を読み飛ばします。

~~~lisp
CL-USER> (with-input-from-string (stream "I'm not amused")
           (print (read-char stream))
           (print (peek-char #\a stream))
           (print (read-char stream))
           (print (read-char stream))
           (values))

#\I
#\a
#\a
#\m
~~~

`peek-char` には、`read-line` や `read-char` と同様に、ファイル終端時の動作を制御する追加のオプショナル引数があります（デフォルトではエラーを通知します）。

~~~lisp
CL-USER> (with-input-from-string (stream "I'm not amused")
           (print (read-char stream))
           (print (peek-char #\d stream))
           (print (read-char stream))
           (print (peek-char nil stream nil 'the-end))
           (values))

#\I
#\d
#\d
THE-END
~~~

関数
[`unread-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_unrd_c.htm)
を使うと、1 文字をストリームに戻すこともできます。文字を読んだ _後で_、`read-char` ではなく `peek-char` を使うべきだったと判断した場合のように使えます。

~~~lisp
CL-USER> (with-input-from-string (stream "I'm not amused")
           (let ((c (read-char stream)))
             (print c)
             (unread-char c stream)
             (print (read-char stream))
             (values)))

#\I
#\I
~~~

ストリームの先頭はスタックのようには振る舞わない点に注意してください。ストリームに戻せるのは正確に _1_ 文字だけです。また、以前に読んだものと同じ文字を戻さなければならず、まだ何も読んでいない場合は文字を戻せません。

[​]{#file--random-access}

#### ファイルへのランダムアクセス

関数
[`file-position`](http://www.lispworks.com/documentation/HyperSpec/Body/f_file_p.htm)
をファイルへのランダムアクセスに使います。この関数を 1 つの引数（ストリーム）で使うと、ストリーム内の現在位置を返します。2 つの引数で使うと（下を参照）、ストリーム内の
[file position](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_f.htm#file_position)
を実際に変更します。

~~~lisp
CL-USER> (with-input-from-string (stream "I'm not amused")
           (print (file-position stream))
           (print (read-char stream))
           (print (file-position stream))
           (file-position stream 4)
           (print (file-position stream))
           (print (read-char stream))
           (print (file-position stream))
           (values))

0
#\I
1
4
#\n
5
~~~

### 内容をファイルに書く

`with-open-file` では `:direction :output` を指定し、内部で `write-sequence` を使います。

~~~lisp
(with-open-file (f <pathname> :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create)
    (write-sequence s f))
~~~

ファイルが存在する場合、内容を `:append` で追記することもできます。

存在しない場合は `:error` にできます。詳細は [the standard](http://www.lispworks.com/documentation/HyperSpec/Body/f_open.htm) を参照してください。

[​]{#library-}

#### ライブラリを使う

[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Conses) ライブラリには [write-string-into-file](https://gitlab.common-lisp.net/alexandria/alexandria/-/blob/master/alexandria-1/io.lisp#L73) という関数があります。

~~~lisp
(alexandria:write-string-into-file content "file.txt")
~~~

また、[str](https://github.com/vindarel/cl-str) ライブラリには `to-file` 関数があります。

~~~lisp
(str:to-file "file.txt" content) ;; 省略可能なオプション付き
~~~

`alexandria:write-string-into-file` と `str:to-file` はどちらも、ファイルの作成を制御する `cl:open` と同じキーワード引数、つまり `:if-exists` と `if-does-not-exists` を取ります。

[​]{#file-attribute-sizeaccess-time--}

### ファイル属性（サイズ、アクセス時刻など）を取得する

[Osicat](https://www.common-lisp.net/project/osicat/)
は Windows を含む POSIX 系システム向けの Common Lisp の軽量なオペレーティングシステムインターフェイスです。Osicat を使うと、**環境変数**の取得と設定 (現在は `uiop:getenv` でも可能)、**ファイルとディレクトリ**、**pathname** などの操作ができます。

[file-attributes](https://github.com/Shinmera/file-attributes/) は
新しく軽量な OS 移植性ライブラリで、システムコール (cffi) を使ってファイル属性を取得することに特化しています。

`sb-posix` contrib を持つ SBCL も使えます。

#### ファイル属性 (Osicat)

Osicat をインストールすると、ファイル属性を取得できる `osicat-posix` システムも定義されます。

~~~lisp
(ql:quickload "osicat")

(let ((stat (osicat-posix:stat #P"./files.md")))
  (osicat-posix:stat-size stat))  ;; => 10629
~~~

他の属性は次のメソッドで取得できます。

~~~
osicat-posix:stat-dev
osicat-posix:stat-gid
osicat-posix:stat-ino
osicat-posix:stat-uid
osicat-posix:stat-mode
osicat-posix:stat-rdev
osicat-posix:stat-size
osicat-posix:stat-atime
osicat-posix:stat-ctime
osicat-posix:stat-mtime
osicat-posix:stat-nlink
osicat-posix:stat-blocks
osicat-posix:stat-blksize
~~~

#### ファイル属性 (file-attributes)

ライブラリは次でインストールします。

    (ql:quickload "file-attributes")

パッケージは `org.shirakumo.file-attributes` です。関数に短い名前でアクセスするために、たとえば package-local nickname を使えます。

~~~lisp
(uiop:add-package-local-nickname :file-attributes :org.shirakumo.file-attributes)
~~~

あとは単に関数を使います。

- `access-time`, `modification-time`, `creation-time`。これらは `setf` できます。
- `owner`, `group`, `attributes`。これらの関数で使われる値は OS 固有です。属性フラグは `decode-attributes` と `encode-attributes` により標準化された形式でデコード／エンコードできます。

~~~lisp
CL-USER> (file-attributes:decode-attributes
           (file-attributes:attributes #p"test.txt"))
(:READ-ONLY NIL :HIDDEN NIL :SYSTEM-FILE NIL :DIRECTORY NIL :ARCHIVED T :DEVICE
 NIL :NORMAL NIL :TEMPORARY NIL :SPARSE NIL :LINK NIL :COMPRESSED NIL :OFFLINE
 NIL :NOT-INDEXED NIL :ENCRYPTED NIL :INTEGRITY NIL :VIRTUAL NIL :NO-SCRUB NIL
 :RECALL NIL)
~~~

[ドキュメント](https://shinmera.github.io/file-attributes) を参照してください。

#### ファイル属性 (sb-posix)

この contrib は POSIX システムではデフォルトでロードされます。

まずファイルの stat オブジェクトを取得し、それから必要な stat を取得します。

~~~lisp
CL-USER> (sb-posix:stat "test.txt")
#<SB-POSIX:STAT {10053FCBE3}>

CL-USER> (sb-posix:stat-mtime *)
1686671405
~~~


### ファイルとディレクトリを一覧する

下のいくつかの関数は pathname を返すため、次が必要になるかもしれません。

~~~lisp
(namestring #p"/foo/bar/baz.txt")           ==> "/foo/bar/baz.txt"
(directory-namestring #p"/foo/bar/baz.txt") ==> "/foo/bar/"
(file-namestring #p"/foo/bar/baz.txt")      ==> "baz.txt"
~~~


#### ディレクトリ内のファイルを一覧する

~~~lisp
(uiop:directory-files "./")
~~~

pathname のリストを返します。

```
(#P"/home/vince/projects/cl-cookbook/.emacs"
 #P"/home/vince/projects/cl-cookbook/.gitignore"
 #P"/home/vince/projects/cl-cookbook/AppendixA.jpg"
 #P"/home/vince/projects/cl-cookbook/AppendixB.jpg"
 #P"/home/vince/projects/cl-cookbook/AppendixC.jpg"
 #P"/home/vince/projects/cl-cookbook/CHANGELOG"
 #P"/home/vince/projects/cl-cookbook/CONTRIBUTING.md"
 […]
```

#### サブディレクトリを一覧する

~~~lisp
(uiop:subdirectories "./")
~~~

```
(#P"/home/vince/projects/cl-cookbook/.git/"
 #P"/home/vince/projects/cl-cookbook/.sass-cache/"
 #P"/home/vince/projects/cl-cookbook/_includes/"
 #P"/home/vince/projects/cl-cookbook/_layouts/"
 #P"/home/vince/projects/cl-cookbook/_site/"
 #P"/home/vince/projects/cl-cookbook/assets/")
```

#### ファイルを反復処理する（遅延評価で）

上の関数に加えて、ディレクトリを*遅延評価で*たどる方法にも触れておきます。これらはファイルの一覧全体をロードしてから返すわけではありません。

Osicat には `with-directory-iterator` があります。

~~~lisp
(with-directory-iterator (next "/")
  (loop for entry = (next)
        while entry
        when (member :group-write (file-permissions entry))
        collect entry))
;; => (#P"tmp/")
~~~

LispWorks には [fast-directory-files](https://www.lispworks.com/documentation/lw80/lw/lw-hcl-74.htm#LWUGRM) 関数があり、AllegroCL には [map-over-directory](https://franz.com/support/documentation/10.1/doc/operators/excl/map-over-directory.htm) があります。

#### ディレクトリを再帰的にたどる（walk する）

`uiop/filesystem:collect-sub*directories` を参照してください。これは引数として次を取ります。

- a `directory`
- a `collectp` function
- a `recursep` function
- a `collector` function

ディレクトリが与えられると、`collectp` がそのディレクトリに対して true を返した場合、そのディレクトリに対して `collector` 関数を呼び、`recursep` が true を返す各サブディレクトリを再帰的にたどります。

したがって、この関数によりファイルシステムの階層をたどることができ、`cl-fad:walk-directory` の機能を置き換えられます。

シンボリックリンクが存在する場合の挙動には移植性がありません。そのような状況を扱うには IOlib を使います。

例:

- サブディレクトリだけを集めます。

~~~lisp
(defparameter *dirs* nil "All recursive directories.")

(uiop:collect-sub*directories "~/cl-cookbook"
    (constantly t)
    (constantly t)
    (lambda (it) (push it *dirs*)))
~~~

- ファイルとサブディレクトリを集めます。

~~~lisp
(let ((results))
    (uiop:collect-sub*directories
     "./"
     (constantly t)
     (constantly t)
     (lambda (subdir)
       (setf results
             (nconc results
                    ;; 細かい点: pathname ではなく string を返す
                    (loop for path in (append (uiop:subdirectories subdir)
                                              (uiop:directory-files subdir))
                          collect (namestring path))))))
    results)
~~~

- `cl-fad` ライブラリでも同じことができます。

~~~lisp
(cl-fad:walk-directory "./"
  (lambda (name)
     (format t "~A~%" name))
   :directories t)
~~~

- もちろん外部ツールも使えます。古き良き unix の `find`、またはより新しい `fd` (Debian では `fdfind`) です。`fd` はより単純な構文を持ち、よくあるファイルやディレクトリの集合をデフォルトで除外します (node_modules、.git など)。

~~~lisp
(str:lines (uiop:run-program (list "find" ".") :output :string))
;; または
(str:lines (uiop:run-program (list "fdfind") :output :string))
~~~

ここでは `str` ライブラリの助けを借りています。


#### パターンに一致するファイルを探す

下では単にディレクトリのファイルを一覧し、その名前が与えられた文字列を含むかを確認します。

~~~lisp
(remove-if-not (lambda (it)
                   (search "App" (namestring it)))
               (uiop:directory-files "./"))
~~~

```
(#P"/home/vince/projects/cl-cookbook/AppendixA.jpg"
 #P"/home/vince/projects/cl-cookbook/AppendixB.jpg"
 #P"/home/vince/projects/cl-cookbook/AppendixC.jpg")
```

`pathname` を文字列に変換するために `namestring` を使いました。これにより、`search` が扱えるシーケンスになります。


#### ワイルドカードでファイルを探す

unix のワイルドカードを移植性のある Common Lisp にそのまま移すことはできません。

pathname 文字列では `*` と `**` をワイルドカードとして使えます。これは絶対 pathname と相対 pathname で動作します。

~~~lisp
(directory #P"*.jpg")
~~~

~~~lisp
(directory #P"**/*.png")
~~~


#### デフォルトの pathname を変更する

現在のディレクトリを表す `.` という概念は移植性のある Common Lisp には存在しません。これは特定のファイルシステムや特定の処理系には存在するかもしれません。

ホームディレクトリを表す `~` も存在しません。いくつかの処理系は移植性のない拡張として認識することがあります。


`*default-pathname-defaults*` は、一部のパス名操作にデフォルト値を提供します。

~~~lisp
(let ((*default-pathname-defaults* (pathname "/bin/")))
          (directory "*sh"))
(#P"/bin/zsh" #P"/bin/tcsh" #P"/bin/sh" #P"/bin/ksh" #P"/bin/csh" #P"/bin/bash")
~~~

`(user-homedir-pathname)` も参照してください。

[cl-fad]: https://edicl.github.io/cl-fad/
 
#  エラーと例外処理 {#chapter-error_handling}
 

Common Lisp には、ほかの言語に見られるようなエラー処理とコンディション処理の仕組みがあり、さらにそれ以上のことができます。

コンディションとは何でしょうか？

> 例外処理をサポートする言語（Java、C++、Python など）と同じく、コンディションは多くの場合「例外的」な状況を表します。しかし、それらの言語以上に、*Common Lisp のコンディションは、必ずしもエラー状態に起因しない、プログラムロジック上の分岐が必要になる一般的な状況を表すことができます*。Lisp 開発の非常に対話的な性質（REPL と組み合わせた Lisp イメージ）を考えると、これは Java や、非常に原始的な REPL しか持たない Python のような言語よりも、Lisp のような言語では完全に理にかなっています。ただし多くの場合、このシステムが提供する対話性を必要としない（あるいは許可すらしない）かもしれません。ありがたいことに、同じシステムは非対話モードでも同じようにうまく機能します。
>
> [z0ltan](https://z0ltan.wordpress.com/2016/08/06/conditions-and-restarts-in-common-lisp/)

順を追って見ていきましょう。追加の資料は後半にあります。

[​]{#throwingcatching--signalinghandling}

## throw/catch とコンディションの通知・処理

Common Lisp には throw と catch の概念がありますが、これは C++ や Java の throwing/catching とは異なる概念を指します。Common Lisp の [`throw`](https://www.lispworks.com/documentation/HyperSpec/Body/s_throw.htm) と [`catch`](https://www.lispworks.com/documentation/HyperSpec/Body/s_catch.htm)（[Ruby](https://ruby-doc.com/docs/ProgrammingRuby/html/tut_exceptions.html#S4) と同じく！）は制御の移動のための仕組みであり、コンディションを扱うものではありません。

Common Lisp ではコンディションは「通知」され、通知されたコンディションに応じてコードを実行する過程を「処理」と呼びます。Java や C++ と違い、コンディションを処理しても、ただちにスタックが巻き戻されるとは限りません。スタックを巻き戻すかどうか、どの状況でそうするかは、個々のハンドラー関数が決めます。

## すべてのエラーを無視し、nil を返す

関数が失敗し得ることを知っていて、それをただ無視したい場合があります。そのときは [ignore-errors][ignore-errors] を使います。

~~~lisp
(ignore-errors
  (/ 3 0))
; in: IGNORE-ERRORS (/ 3 0)
;     (/ 3 0)
;
; caught STYLE-WARNING:
;   Lisp error during constant folding:
;   arithmetic error DIVISION-BY-ZERO signalled
;   Operation was (/ 3 0).
;
; compilation unit finished
;   caught 1 STYLE-WARNING condition
NIL
#<DIVISION-BY-ZERO {1008FF5F13}>
~~~

`division-by-zero` の警告は得られますが、コードは実行され、`nil` と通知されたコンディションの 2 つの値を返します。何を返すかは選べませんでした。

Slime では右クリックでコンディションを `inspect` できることを思い出してください。


[​]{#handler-case--error-condition-}

## `handler-case` ですべてのエラーコンディションを扱う

<!-- we will say "handling" for handler-bind -->

`ignore-errors` は [handler-case][handler-case] から作られています。前の例を、一般的な `error` をハンドルする形で書けますが、今度は好きなものを返せます。

~~~lisp
(handler-case (/ 3 0)
  (error (c)
    (format t "We handled an error.~&")
    (values 0 c)))
; in: HANDLER-CASE (/ 3 0)
;     (/ 3 0)
;
; caught STYLE-WARNING:
;   Lisp error during constant folding:
;   Condition DIVISION-BY-ZERO was signalled.
;
; compilation unit finished
;   caught 1 STYLE-WARNING condition
We handled an error.
0
#<DIVISION-BY-ZERO {1004846AE3}>
~~~

ここでも 0 と通知されたコンディションの 2 つの値を返しました。

`handler-case` の一般形は次のとおりです。

~~~lisp
(handler-case (code that can error out)
   (condition-type (the-condition) ;; <-- optional argument
      (code))
   (another-condition (the-condition)
       ...))
~~~

`handler-case` に続く `(code that can error out)` は 1 つのフォームでなければなりません。複数の式を書きたい場合は `progn` で包みます。


[​]{#condition-}

## 特定のコンディションを扱う

どのコンディションを扱うか指定できます。

~~~lisp
(handler-case (/ 3 0)
  (division-by-zero (c)
    (format t "Got division by zero: ~a~%" c)))
;; …
;; Got division by zero: arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;; NIL
~~~

これは、ほかの言語で知られる「通常の」例外処理に最も近い仕組みです。C++ と Java の `throw`/`try`/`catch`、Python の `raise`/`try`/`except`、Ruby の `raise`/`begin`/`rescue` などです。しかし、Common Lisp ではもっと多くのことができます。

[​]{#condition--restart--handler-bind}

## コンディションと restart を完全に制御する: `handler-bind`

[handler-bind][handler-bind] は、コンディションが通知されたときに何が起きるかを完全に制御したい場合に使います。スタックを巻き戻しません。この点は次の節で示します。デバッガとリスタートを、対話的にもプログラムからも使えるようにします。

一般形は次のとおりです。

~~~lisp
(handler-bind ((a-condition #'function-to-handle-it)
               (another-one #'another-function))
    (code that can...)
    (...error out…)
    (... with an implicit PROGN))
~~~

例:

~~~lisp
(defun handler-bind-example ()
  (handler-bind
        ((error (lambda (c)
                  (format t "we handle this condition: ~a" c)
                  ;; この return-from を外して試すと、エラーは対話的デバッガまで伝播する。
                  (return-from handler-bind-example))))
      (format t "starting example…~&")
      (error "oh no")))
~~~

`handler-case` と比べると構文が「逆」になっていることに気づくでしょう。先に束縛があり、次に（暗黙の progn 内の）フォームがあります。

ハンドラが通常どおり戻った場合（コンディションの処理を辞退した場合）、コンディションは別のハンドラを探して伝播し続け、最終的に対話的デバッガに到達します。

これも `handler-case` との違いです。ハンドラ関数が `return-from handler-bind-example` で呼び出し元関数から明示的に戻らなければ、エラーは伝播し続け、対話的デバッガが表示されます。

この挙動は、プログラムが単純なコンディションを通知したときに特に便利です。単純なコンディションはエラーではないため（下の「コンディション階層」を参照）、デバッガを起動しません。コンディション（アプリケーション内で何かが起きたという通知）に対して処理を行い、プログラムを続行できます。

あるライブラリがすべてのコンディションを処理せず、いくつかをこちらへ伝播させる場合、スタックの深い場所にある restarts（`restart-case` により確立されたもの）を見ることができます。そのライブラリが呼び出した別ライブラリが確立した restarts も含まれます。

### handler-bind はスタックを巻き戻さない

`handler-bind` では、*すべての呼び出しフレームを含む完全なスタックトレースを見られます*。`handler-case` を使うと、コンディションが処理されるまでのプログラム実行の多くの段階を「忘れ」ます。コールスタックが巻き戻されるためです。`handler-bind` はスタックを巻き戻しません。これを示します。

デモのため、Quicklisp でインストールできる `trivial-backtrace` ライブラリを使います。

    (ql:quickload "trivial-backtrace")

これは `sb-debug:print-backtrace` など、処理系のプリミティブを包むラッパーです。

次のコードを考えます。`main` 関数は、最終的に `error` でエラーを通知して失敗する関数の連鎖を呼び出します。`main` 関数でエラーを処理し、バックトレースを出力します。

~~~lisp
(defun f0 ()
  (error "oh no"))

(defun f1 ()
  (f0))

(defun f2 ()
  (f1))

(defun main ()
  (handler-case (f2)
    (error (c)
      (format t "in main, we handle: ~a" c)
      (trivial-backtrace:print-backtrace c))))
~~~

これがバックトレースです（最初のフレームだけ）。

```
CL-REPL> (main)
in main, we handle: oh no
Date/time: 2025-07-04-11:25!
An unhandled error condition has been signalled: oh no

Backtrace for: #<SB-THREAD:THREAD "repl-thread" RUNNING {1008695453}>
0: […]
1: (TRIVIAL-BACKTRACE:PRINT-BACKTRACE … )
2: (MAIN)
[…]
```

ここまでは問題ありません。"Date/time" と "An unhandled エラーコンディション…" というメッセージを出しているのは `trivial-backtrace` です。

次に、`handler-bind` を使った場合のスタックトレースと比較します。

```lisp
(defun main-no-stack-unwinding ()
  (handler-bind
      ((error (lambda (c)
                (format t "in main, we handle: ~a" c)
                (trivial-backtrace:print-backtrace c)
                (return-from main-no-stack-unwinding))))
    (f2)))
```

```
CL-REPL> (main-no-stack-unwinding)
in main, we handle: oh no
Date/time: 2025-07-04-11:32!
An unhandled error condition has been signalled: oh no


Backtrace for: #<SB-THREAD:THREAD "repl-thread" RUNNING {1008695453}>
0: …
1: (TRIVIAL-BACKTRACE:PRINT-BACKTRACE …)
2: …
3: …
4: (ERROR "oh no")
5: (F0)
6: (F1)
7: (MAIN-NO-STACK-UNWINDING)
```

その通りです。`main` 関数から `f1` と `f0` を通ってエラーに至る、すべてのコールスタックが見えます。`handler-case` を使ったときのバックトレースに、この 2 つの中間関数はありませんでした。エラーが通知されてコールスタックを伝播するにつれ、スタックが巻き戻され、情報を失ったためです。


### どちらをいつ使うか

失敗する状況を予期しているなら、`handler-case` で十分です。たとえば HTTP リクエストの文脈では、400 番台のエラーを想定するのは普通です。

~~~lisp
;; dexador ライブラリを使う。
(handler-case (dex:get "http://bad-url.lisp")
  (dex:http-request-failed (e)
    ;; 4xx または 5xx HTTP エラー: 起こり得るので問題ない。
    (format *error-output* "The server returned ~D" (dex:response-status e))))
~~~

その他の例外的な状況では、おそらく `handler-bind` が欲しくなります。たとえば、何が問題だったかを処理し、バックトレースを出力したい場合、または手動でデバッガを起動し（下記参照）、正確に何が起きたかを見たい場合です。

[​]{#condition-finallyunwind-protect}

## コンディションの有無にかかわらずコードを実行する（"finally"）（unwind-protect）

ほかの `try`/`catch`/`finally` フォームにおける "finally" 部分は [unwind-protect][unwind-protect] で行います。

これは `with-open-file` のような "with-" マクロで使われる構文で、処理後に必ずファイルを閉じます。

この例では:

~~~lisp
(unwind-protect (/ 3 0)
  (format t "This place is safe.~&"))
~~~

SBCL ソース:

```lisp
(sb-xc:defmacro with-open-file ((stream filespec &rest options)
                                &body body)
  (multiple-value-bind (forms decls) (parse-body body nil)
    (let ((abortp (sb-xc:gensym)))
      `(let ((,stream (open ,filespec ,@options))
             (,abortp t))
         ,@decls
         (unwind-protect
              (multiple-value-prog1
                  (progn ,@forms)
                (setq ,abortp nil))
           (when ,stream
             (close ,stream :abort ,abortp)))))))
```

単純化すると:

```lisp
(defmacro with-open-file ((stream filespec) &body body)
  `(let ((,stream (open ,filespec)))
    (unwind-protect
      (progn ,@body)
     (when ,stream
       (close ,stream)))))
```

なぜなら、次を:

```lisp
(let ((stream (open "filename.txt" :direction :input :if-does-not-exist :create :if-exists :overwrite)))
    (unwind-protect
      (format stream "hello file")
     (when stream
       (close stream))))
```

次のように単純に書きたいからです。

```lisp
(with-open-file (f "filename.txt" …)
  (format stream "hello"))
```

対話的デバッガは*表示されます*（`handler-bind` などは使っていません）が、それでもその後にメッセージは出力されます。

[​]{#condition--1}

## コンディションを定義し作る

[define-condition][define-condition] でコンディションを定義し、[make-condition][make-condition] でそれを作成（初期化）します。

~~~lisp
(define-condition my-division-by-zero (error)
  ())

(make-condition 'my-division-by-zero)
;; #<MY-DIVISION-BY-ZERO {1005A5FE43}>
~~~

コンディションを作るときにより多くの情報を与えた方がよいので、スロットを使いましょう。

~~~lisp
(define-condition my-division-by-zero (error)
  ((dividend :initarg :dividend
             :initform nil
             :reader dividend)) ;; <-- (dividend condition) で dividend を得られる。必要なら CLOS チュートリアルを参照。
  (:documentation "Custom error when we encounter a division by zero.")) ;; よい習慣 ;)
~~~

これで、コード内でコンディションを通知するときに、後で利用される情報を埋め込めます。

~~~lisp
(make-condition 'my-division-by-zero :dividend 3)
;; #<MY-DIVISION-BY-ZERO {1005C18653}>
~~~

<div class="info-box info">
<p>
<strong>Note:</strong> <a href="#chapter-clos">Common Lisp Object System</a> についてまだ十分でない場合の、クラスに関する簡単なおさらいです。
</p>
</div>

~~~lisp
(make-condition 'my-division-by-zero :dividend 3)
;;                                   ^^ これが ":initarg"
~~~

そして `:reader dividend` は、`my-division-by-zero` オブジェクトの dividend に対する "getter" である*総称関数*を作りました。

~~~lisp
(make-condition 'my-division-by-zero :dividend 3)
;; #<MY-DIVISION-BY-ZERO {1005C18653}>
(dividend *)
;; 3
~~~

`:accessor` なら getter と setter の両方になります。

つまり、`define-condition` の一般形は通常のクラス定義のように見え、感じられます。ただし似ていても、コンディションは標準オブジェクトではありません。

違いの 1 つは、スロットに対して `slot-value` を使えないことです。


[​]{#condition--signal--error-cerror-warn-signal}
[​]{#signal---cerror-warn-signal}

## コンディションを通知する: error、cerror、warn、signal

[エラー][error] は 2 通りに使えます。

- `(error "some text")`: [simple-error][simple-error] 型のコンディションを通知します。
- `(error 'my-error :message "We did this and that and it didn't work.")`: `message` スロットに値を与えたカスタムコンディションを作成して通知します。

どちらの場合も、コンディションがハンドルされなければ、`error` は対話的デバッガを開き、ユーザーは実行を続けるための restart を選べます。

上で定義した独自コンディション型では、次のようにできます。

~~~lisp
(error 'my-division-by-zero :dividend 3)
;; これは次のショートカット
(error (make-condition 'my-division-by-zero :dividend 3))
~~~

`cerror` は `error` に似ていますが、ユーザーが実行を続けるために使える `continue` restart を自動的に確立します。最初の引数として文字列を受け取り、この文字列はその restart のユーザーに見える report として使われます。

`warn` はデバッガには入りません（warning コンディションは [warning][warning] を subclass して作ります）。コンディションがハンドルされなければ、代わりに警告をエラー output へ記録します。

何も出力せず、デバッガにも入らずに、何らかの注目すべき状況が起きたことを上位レベルへ通知したい場合は、[signal][signal] を使います。

その状況は、コードの通常動作中に情報を渡すことから、エラーのような重大な状況まで何でも構いません。たとえば、操作中の進捗を追跡するために使えます。`percent` スロットを持つコンディションを作り、進捗があるたびに通知し、上位のコードで処理して利用者に表示できます。詳しくは下の資料を参照してください。

[​]{#condition--2}

### コンディション階層

`simple-error` のクラス優先順位リストは `simple-error, simple-condition, error, serious-condition, condition, t` です。

`simple-warning` のクラス precedence list は `simple-warning, simple-condition, warning, condition, t` です。


### カスタムエラーメッセージ（:report）

ここまで、エラーを通知したとき、デバッガには次のデフォルトテキストが表示されていました。

```
Condition COMMON-LISP-USER::MY-DIVISION-BY-ZERO was signalled.
   [Condition of type MY-DIVISION-BY-ZERO]
```

コンディション宣言に `:report` 関数を与えることで、もっとよくできます。

~~~lisp
(define-condition my-division-by-zero (error)
  ((dividend :initarg :dividend
             :initform nil
             :accessor dividend))
  ;; :report はデバッガ内のメッセージ:
  (:report (lambda (condition stream)
     (format stream
             "You were going to divide ~a by zero.~&"
             (dividend condition)))))
~~~

すると:

~~~lisp
(error 'my-division-by-zero :dividend 3)
;; Debugger:
;;
;; You were going to divide 3 by zero.
;;    [Condition of type MY-DIVISION-BY-ZERO]
~~~


## stacktrace を調べる

これはもう 1 つの簡単なおさらいであり、Slime チュートリアルではありません。デバッガでは、stacktrace、関数呼び出しへの引数、エラーのあるソース行への移動（Slime では `v`）、そのコンテキストでのコード実行（`e`）などができます。

多くの場合、バグのある関数を編集し、（Slime の `C-c C-c` ショートカットで）コンパイルし、"RETRY" restart を選んで、コードが通ることを確認できます。

これはすべてコンパイラオプション、つまりデバッグ、速度、安全性のどれ向けに最適化されているかに依存します。

[デバッグセクション](#chapter-debugging)を参照してください。


## Restarts、デバッガ内の対話的な選択肢

Restarts はデバッガ内で得られる選択肢です。デバッガには常に `RETRY` と `ABORT` があります。

restart を *handling* することで、エラーが起きなかったかのように（スタック上で見たように）操作をやり直せます。


### assert の任意 restart を使う

単純な形では、`assert` は私たちが知っているとおりに動きます。

~~~lisp
(assert (realp 3))
;; NIL = passed
~~~

アサーションが失敗すると、デバッガに入るよう促されます。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y)))
  (/ x y))

(divide 3 0)
;; The assertion (NOT #1=(ZEROP Y)) failed with #1# = T.
;;    [Condition of type SIMPLE-ERROR]
;;
;; Restarts:
;;  0: [CONTINUE] Retry assertion.
;;  1: [RETRY] Retry SLIME REPL evaluation request.
;;  …
~~~

値を変更する選択肢を提供する任意パラメータも受け取ります。

~~~lisp
(defun divide (x y)
  (assert (not (zerop y))
          (y)   ;; 変更できる値のリスト。
          "Y can not be zero. Please change it") ;; カスタムエラーメッセージ。
  (/ x y))
~~~

これで、Y の値を変更する新しい restart が得られます。

~~~lisp
(divide 3 0)
;; Y can not be zero. Please change it
;;    [Condition of type SIMPLE-ERROR]
;;
;; Restarts:
;;  0: [CONTINUE] Retry assertion with new value for Y.  <--- new restart
;;  1: [RETRY] Retry SLIME REPL evaluation request.
;;  …
~~~

それを選ぶと、REPL で新しい値の入力を求められます。

```
The old value of Y is 0.
Do you want to supply a new value?  (y or n) y

Type a form to be evaluated:
2
3/2  ;; and our result.
```


### restarts を定義する（restart-case）

これは便利ですが、もっと独自の選択肢が欲しいこともあります。[restart-case][restart-case] で関数呼び出しを包むことで、一覧の先頭に restarts を追加できます。

~~~lisp
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()  ;; <-- "RETURN-ZERO" という新しい restart を作る
      0)
    (divide-by-one ()
      (/ x 1))))
(divide-with-restarts 3 0)
~~~

*任意のエラー*の場合（これは `handler-bind` で改善します）、デバッガの先頭にこの 2 つの新しい選択肢が表示されます。

![](simple-restarts.png)

これで問題ありませんが、より人間に分かりやすい「説明（report）」を書きましょう。

~~~lisp
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()
      :report "Return 0"  ;; <-- 追加
      0)
    (divide-by-one ()
      :report "Divide by 1"
      (/ x 1))))
(divide-with-restarts 3 0)
;; Nicer restarts:
;;  0: [RETURN-ZERO] Return 0
;;  1: [DIVIDE-BY-ONE] Divide by 1
~~~

こちらの方がよいですが、上の `assert` の例で行ったようにオペランドを変更する機能がありません。


### restart で変数を変更する

定義した 2 つの restarts は、新しい値を求めませんでした。これを行うには、restart に `:interactive` lambda 関数を追加し、ユーザーに新しい値を入力方法で尋ねます。ここでは通常の `read` を使います。

~~~lisp
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()
      :report "Return 0"
      0)
    (divide-by-one ()
      :report "Divide by 1"
      (/ x 1))
    (set-new-divisor (value)
      :report "Enter a new divisor"
      ;;
      ;; ユーザーに新しい値を尋ねる:
      :interactive (lambda () (prompt-new-value "Please enter a new divisor: "))
      ;;
      ;; 新しい値で divide 関数を呼ぶ…
      ;; …おそらく不正入力を再び handle しながら！
      (divide-with-restarts x value))))

(defun prompt-new-value (prompt)
  (format *query-io* prompt) ;; *query-io*: ユーザー問い合わせ用の特別なストリーム。
  (force-output *query-io*)  ;; ユーザーが入力内容を見られるようにする。
  (list (read *query-io*)))  ;; リストを返さなければならない。

(divide-with-restarts 3 0)
~~~

呼び出すと新しい restart が提示され、新しい値を入力し、結果を得ます。

~~~
(divide-with-restarts 3 0)
;; Debugger:
;;
;; 2: [SET-NEW-DIVISOR] Enter a new divisor
;;
;; Please enter a new divisor: 10
;;
;; 3/10
~~~

グラフィカルユーザーインターフェイスの方がよいですか？ GNU/Linux では `zenity` コマンドラインインターフェイスを使えます。

~~~lisp
(defun prompt-new-value (prompt)
  (list
   (let ((input
          ;; プログラムの出力を文字列へ捕捉する。
          (with-output-to-string (s)
            (let* ((*standard-output* s))
              (uiop:run-program `("zenity"
                                  "--forms"
                                  ,(format nil "--add-entry=~a" prompt))
                                :output s)))))
     ;; 文字列を得たので、数値が欲しい。
     ;; parse-integer や parse-number ライブラリなども使える。
     (read-from-string input))))
~~~

もう一度試すと、新しい数値を尋ねる小さなウィンドウが出るはずです。

![](assets/zenity-prompt.png)

これは楽しいですが、それだけではありません。restarts を手動で選ぶことは、常に（あるいは頻繁に）満足できるものではありません。そして restart を *handling* することで、エラーが起きなかったかのように、スタック上で見た操作をやり直せます。


### restarts をプログラムから呼び出す（handler-bind, invoke-restart）

コンディションを通知し得るコードがあるとします。ここでは `divide-with-restarts` がゼロ除算に関するエラーを通知する可能性があります。ここで行いたいのは、上位レベルのコードでそれを自動的に処理し、適切なリスタートを呼ぶことです。

これは `handler-bind` と [invoke-restart][invoke-restart] でできます。

~~~lisp
(defun divide-and-handle-error (x y)
  (handler-bind
      ((division-by-zero (lambda (c)
                           (format t "Got error: ~a~%" c) ;; エラーメッセージ
                           (format t "and will divide by 1~&")
                           (invoke-restart 'divide-by-one))))
    (divide-with-restarts x y)))

(divide-and-handle-error 3 0)
;; Got error: arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;; and will divide by 1
;; 3
~~~


### ほかの restarts を使う（find-restart）

[find-restart][find-restart] を使います。

`find-restart 'name-of-restart` は、指定された名前で最も新しく束縛された restart、または `nil` を返します。


### restarts を隠す、表示する

Restarts は隠せます。`restart-case` では、`:report` と `:interactive` に加えて、`:test` キーも受け取ります。

~~~lisp
(restart-case
   (return-zero ()
     :test (lambda ()
             (some-test))
    ...
~~~

## デバッガを手動で起動する

`handler-bind` でコンディションをハンドルしており、コンディションオブジェクトが（上の例のように）`c` 変数に束縛されているとします。さらに、たとえば `*devel-mode*` というパラメータが、本番環境ではないことを示しているとします。このコンディションに対してデバッガを起動すると便利かもしれません。次を使います。

~~~lisp
(invoke-debugger c)
~~~

本番環境では、代わりに `trivial-backtrace:print-backtrace` でバックトレースを出力できます。


## デバッガを無効にする

本番環境では、デバッガをオフにして lisp プログラムを実行できます。各処理系にはコマンドラインスイッチがあります。SBCL では次のとおりです。

    $ sbcl --disable-debugger

（これは `--script` と `--non-interactive` では暗黙に指定されます）。



## まとめ

これで、本番コードを書く準備ができました！


## 資料

* [Practical Common Lisp: "Beyond Exception Handling: コンディション and Restarts"](http://gigamonkeys.com/book/beyond-exception-handling-conditions-and-restarts.html) - 定番チュートリアル。より多くの説明とプリミティブ。
* Common Lisp Recipes、第 12 章、E. Weitz
* [language reference](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node317.html)
* [Video tutorial: introduction on conditions and restarts](http://nklein.com/2011/03/tutorial-introduction-to-conditions-and-restarts/)、Patrick Stein による。
* [Condition Handling in the Lisp family of languages](http://www.nhplace.com/kent/Papers/Condition-Handling-2001.html)
* [z0ltan.wordpress.com](https://z0ltan.wordpress.com/2016/08/06/conditions-and-restarts-in-common-lisp/)（このレシピが大きく基づいている記事）

## 関連項目

* [Algebraic effects - You can touch this !](http://jacek.zlydach.pl/blog/2019-07-24-algebraic-effects-you-can-touch-this.html) - コンディションと restarts を使って、長時間実行される計算の進捗報告と中止を実装する方法。対話的または GUI の文脈でも利用可能。
* [A Tutorial on Conditions and Restarts](https://github.com/stylewarning/lisp-random/blob/master/talks/4may19/root.lisp) - 実関数の根の計算を題材にしたもの。著者により 2019 年 5 月の Bay Area Julia meetup で発表されました（[talk slides here](https://github.com/stylewarning/talks/blob/master/4may19-julia-meetup/Bay%20Area%20Julia%20Users%20Meetup%20-%204%20May%202019.pdf)）。
* [lisper.in](https://lisper.in/restarts#signaling-validation-errors) - csv ファイルの parsing と restarts の成功例。[旅行会社での事例](https://www.reddit.com/r/lisp/comments/7k85sf/a_tutorial_on_conditions_and_restarts/drceozm/)。
* [https://github.com/svetlyak40wt/python-cl-conditions](https://github.com/svetlyak40wt/python-cl-conditions) - Python における CL コンディション system の実装。
* [https://github.com/phoe/portable-condition-system](https://github.com/phoe/portable-condition-system) - Common Lisp における CL コンディションシステムの移植可能な実装。

## 謝辞

* `handler-bind` 部分について、[`@vindarel` の Udemy 動画講座](https://www.udemy.com/course/common-lisp-programming/?referralCode=2F3D698BBC4326F94358)。


[ignore-errors]: http://www.lispworks.com/documentation/HyperSpec/Body/m_ignore.htm
[handler-case]: http://www.lispworks.com/documentation/HyperSpec/Body/m_hand_1.htm
[handler-bind]: http://www.lispworks.com/documentation/HyperSpec/Body/m_handle.htm
[define-condition]: http://www.lispworks.com/documentation/HyperSpec/Body/m_defi_5.htm
[make-condition]: http://www.lispworks.com/documentation/HyperSpec/Body/f_mk_cnd.htm
[error]: http://www.lispworks.com/documentation/HyperSpec/Body/e_error.htm#error
[simple-error]: http://www.lispworks.com/documentation/HyperSpec/Body/e_smp_er.htm
[simple-warning]: http://www.lispworks.com/documentation/HyperSpec/Body/e_smp_wa.htm
[signal]: http://www.lispworks.com/documentation/HyperSpec/Body/f_signal.htm
[restart-case]: http://www.lispworks.com/documentation/HyperSpec/Body/m_rst_ca.htm
[invoke-restart]: http://www.lispworks.com/documentation/HyperSpec/Body/f_invo_1.htm#invoke-restart
[find-restart]: http://www.lispworks.com/documentation/HyperSpec/Body/f_find_r.htm#find-restart
[unwind-protect]: http://www.lispworks.com/documentation/HyperSpec/Body/s_unwind.htm
 
#  パッケージ {#chapter-packages}
 

参照: [The Complete Idiot's Guide to Common Lisp パッケージ][guide]

[​]{#package-}

## パッケージを作成する

パッケージ定義の例です。これは名前を取り、通常は Common Lisp のシンボルと関数を `:use` したいはずです。

~~~lisp
(defpackage :my-package
  (:use :cl))
~~~

このパッケージ用のコードを書き始めるには、その中へ入ります。

~~~lisp
(in-package :my-package)
~~~

この `in-package` マクロは、あなたをパッケージの「中」に置きます。

- 新しい変数や関数は、このパッケージ、つまりこのパッケージの「名前空間」に作られます。
- パッケージの接頭辞を使わずに、このパッケージのすべてのシンボルを直接呼び出せます。

試してみてください。

REPL 上でパッケージを試すためにも `in-package` を使えます。新しい Lisp REPL セッションでは、私たちは CL-USER パッケージの「中」にいます。これは通常のパッケージです。

例を示しましょう。新しい .lisp ファイルを開き、パッケージの中に関数を持つ新しいパッケージを作ります。

~~~lisp
;; in test-package.lisp
(defpackage :my-package
  (:use :cl))

(in-package :my-package)

(defun hello ()
  (print "Hello from my package."))
~~~

この "hello" 関数は "my-package" の中にあります。まだ export されていません。

それを呼び出す方法を見るには、下へ進んでください。

[​]{#package--symbol--access-}
[​]{#access-}

### パッケージからシンボルにアクセスする

パッケージを定義するか読み込むと（Quicklisp 経由、または `.asd` システム定義の依存関係として定義されている場合）、コロンを区切り文字として使い、`package:a-symbol` でそのシンボルにアクセスできます。

例:

~~~lisp
(str:concat …)
~~~

シンボルが export されていない場合 (つまり "private" な場合) は、double colon を使います。

~~~lisp
(package::non-exported-symbol)
(my-package::hello)
~~~

例を続けます。REPL で、`CL-USER` ではなく `my-package` にいることを確認してください。そこで "hello" を直接呼び出せます。

~~~lisp
CL-USER> (in-package :my-package)
#<PACKAGE "MY-PACKAGE">
;; ^^^ this is the package object. You can right click or call INSPECT on it.
MY-PACKAGE> (hello)
;; ^^^^ the REPL shows you the current package.
"Hello from my package."
~~~

しかし今度は CL-USER パッケージに戻り、"hello" を呼び出してみます。エラーになります。

~~~lisp
MY-PACKAGE> (in-package :cl-user)
#<PACKAGE "COMMON-LISP-USER">
CL-USER> (hello)

=> you get the interactive debugger that says:

The function COMMON-LISP-USER::HELLO is undefined.

(quit)
~~~

hello 関数をパッケージ名で名前空間修飾する必要があります。

~~~lisp
CL-USER> (my-package::hello)
"Hello from my package."
~~~

関数を export しましょう。

[​]{#symbol--export-}

### シンボルを export する

`defpackage` 宣言を拡張し、次のように "hello" 関数を export します。

~~~lisp
(defpackage :my-package
  (:use :cl)
  (:export
   #:hello))
~~~

これをコンパイルすると (Slime では `C-c C-c`)、今度はコロン1つで呼び出せます。

~~~lisp
CL-USER> (my-package:hello)
~~~

`export` 関数を使うこともできます。

~~~lisp
(in-package :my-package)
(export #:hello)
~~~

観察:

- sharpsign なしで `:hello` を export しても動きますが、常に新しいシンボルを作ります。`#:` notation は新しいシンボルを作りません。より正確には、現在のパッケージに新しいシンボルを *intern* しません。これは細部であり、この時点では使うかどうかは個人の好みです。特に他のライブラリからシンボルを import して re-export するとき、シンボル namespace を散らかさずに済むため役立つことがあります。そうすれば editor のシンボル completion は関連する結果だけを表示します。この時点の私たちには有用ではないので、心配はいりません。

次に、パッケージ接頭辞なしですぐアクセスできるように、個別のシンボルをインポートしたくなるかもしれません。


[​]{#package--symbol--import-}

### 別のパッケージからシンボルを import する

必要なシンボルだけを `:import-from` で正確に import できます。

~~~lisp
(defpackage :my-package
  (:import-from :ppcre #:regex-replace)
  (:use :cl))
~~~

これで `my-package` の中から、`ppcre` パッケージ prefix なしで `regex-replace` を呼び出せます。`regex-replace` はあなたのパッケージ内の新しいシンボルです。これは export されません。

明示的な import なしに `(:import-from :ppcre)` と書かれているのを見ることがあります。これは ASDF の *package inferred system* を使う人の助けになります。

パッケージ定義の外から `import` 関数を使うこともできます。

~~~lisp
CL-USER> (import 'ppcre:regex-replace)
CL-USER> (regex-replace …)
~~~

[​]{#symbol--import-}

### すべてのシンボルを import する

別のパッケージから何を import するかを注意深く選ぶほうがよい習慣ですが (下を読んでください)、`:use` ですべてのシンボルを一度に import することもできます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

これで、`cl-ppcre` からエクスポートされたすべての変数、関数、マクロに、`my-package` パッケージからアクセスできます。

`use-package` 関数を使うこともできます。

~~~lisp
CL-USER> (use-package 'cl-ppcre)
~~~

その対になる、`use-package` の import を取り消すものは… `unuse-package` です。


[​]{#package--use--bad-practice-}
[​]{#use--bad-practice-}

### パッケージを "use" することが悪い慣行とされる理由

`:use` は広く使われているイディオムです。次のように書けます。

~~~lisp
(defpackage :my-package
  (:use :cl :ppcre))
~~~

すると、`cl-ppcre` (別名 `ppcre`) から export された **すべての** シンボルが、あなたのパッケージで直接使えるようになります。しかし、自分が管理しているプロジェクト内の別パッケージを `use` する場合を除き、これは悪い習慣と考えるべきです。実際、外部のパッケージがシンボルを追加すると、あなたのシンボルと衝突する可能性があります。あるいは、あなたが追加したシンボルが外部のシンボルを隠し、警告に気づかないかもしれません。

[この詳しい説明](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) (読むことをおすすめします) を引用すると、要旨は次のとおりです。

> 現代のコードでは、USE は完全に管理している内部パッケージを除いて悪い考えです。内部パッケージでは、別パッケージのシンボルを変更しながら新しい DEFUN を作っていることを忘れるまでは、それなりに筋が通ります。USE があるため、Alexandria は今日では自分自身に新しいシンボルを追加することすらできません。それは、外部のソース由来の同じ名前のシンボルをすでに持つ別パッケージと名前の衝突を起こすかもしれないからです。


[​]{#package--symbol--list--do-external-symbols}

## パッケージ内のすべてのシンボルを list する (do-external-symbols)

Common Lisp は、パッケージのシンボルを反復するためのマクロをいくつか提供します。特に興味深いものは
[`DO-SYMBOLS` と `DO-EXTERNAL-SYMBOLS`][do-sym] です。`DO-SYMBOLS` はパッケージからアクセス可能なシンボルを反復し、`DO-EXTERNAL-SYMBOLS` は外部シンボルだけを反復します（これらは実質的なパッケージ API と見なせます）。

"PACKAGE" という名前のパッケージの export 済みシンボルをすべて print するには、次のように書けます。

~~~lisp
(do-external-symbols (s (find-package "PACKAGE"))
  (print s))
~~~

これらのシンボルをすべてリストに集めることもできます。

~~~lisp
(let (symbols)
  (do-external-symbols (s (find-package "PACKAGE"))
    (push s symbols))
  symbols)
~~~

または [`LOOP`][loop] で行えます。

~~~lisp
(loop for s being the external-symbols of (find-package "PACKAGE")
  collect s)
~~~

[`with-package-iterator`](https://cl-community-spec.github.io/pages/with_002dpackage_002diterator.html) も参照してください。

## Package nickname

#### Package Local Nicknames (PLN)

import したパッケージに local name を与えると、typing を減らせて便利なことがあります。特に、import したパッケージがよい global nickname を提供していない場合です。

多くの処理系 (SBCL, CCL, ECL, Clasp, ABCL, ACL, LispWorks >= 7.2…) はパッケージ Local Nicknames (PLN) を support しています。


PLN を使うには、たとえば ad-hoc に local nickname を試したい場合、単に次のようにできます。

~~~lisp
(uiop:add-package-local-nickname :a :alexandria)
(a:iota 12) ; (0 1 2 3 4 5 6 7 8 9 10 11)
~~~

`defpackage` フォーム内で PLN を設定することもできます。PLN の効果は完全に `mypackage` 内に限られます。つまり、`nickname` は、そこでも定義されていない限り他のパッケージでは動きません。そのため、他のライブラリで意図しないパッケージ名の衝突が起きる心配はありません。

~~~lisp
(defpackage :mypackage
  (:use :cl)
  (:local-nicknames (:nickname :original-package-name)
                    (:alex :alexandria)
                    (:re :cl-ppcre)))

(in-package :mypackage)

;; You can use :nickname instead of :original-package-name
(nickname:some-function "a" "b")
~~~

パッケージにニックネームを追加する別の機能もあります。関数 [`RENAME-PACKAGE`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm) を使うと、パッケージの名前とニックネームを置き換えられます。しかし、それを使うと、他のライブラリが元の名前やニックネームでそのパッケージにアクセスできなくなる可能性があります。これを使う場面はほとんどありません。代わりにパッケージローカルニックネームを使ってください。

[​]{#package--nickname}

### パッケージが提供する nickname

パッケージを定義するとき、利用者の使い勝手を良くするために nickname を与えるのは簡単です。しかしこの仕組みは *global*（全体）です。ここで定義した nickname は、どこにある他のすべてのパッケージからも見えます。よく使うパッケージに短い名前を与えようとしていたなら、別のパッケージと衝突する可能性があります。だからこそ *package-local*（パッケージローカル）な nickname が現れました。代わりにそれを使うべきです。

とはいえ、`prove` パッケージからの例を示します。

~~~lisp
(defpackage prove
  (:nicknames :cl-test-more :test-more)
  (:export #:run
           #:is
           #:ok)
~~~

その後、利用者はパッケージ名の代わりに nickname を使ってこのパッケージを参照できます。例:

~~~lisp
(prove:run)
(cl-test-more:is)
(test-more:ok)
~~~

Common Lisp は 1 つのパッケージに複数の nickname を定義することを許していますが、nickname が多すぎると利用者にとって保守の複雑さが増える可能性があります。したがって nickname は意味があり、わかりやすいものにするべきです。例:

~~~lisp
(defpackage #:iterate
  (:nicknames #:iter))

(defpackage :cl-ppcre
  (:nicknames :ppcre)
~~~


### パッケージロック

パッケージ `common-lisp` と SBCL の内部実装用パッケージは、`sb-ext` を含め、デフォルトでロックされています。

加えて、ユーザー定義のパッケージもロックされるよう宣言でき、その場合ユーザーは変更できません。シンボルテーブルを変更したり、そのシンボルが名前を付けている関数を再定義しようとするとエラーになります。

より詳しい情報は [SBCL][sbcl-package-lock] と [CLisp][clisp-package-lock] のドキュメントから得られます。

たとえば、次のコードを試すとします。

~~~lisp
(asdf:load-system :alexandria)
(rename-package :alexandria :alex)
~~~

次のエラーが出ます (SBCL の場合)。

~~~
Lock on package ALEXANDRIA violated when renaming as ALEX while
in package COMMON-LISP-USER.
   [Condition of type PACKAGE-LOCKED-ERROR]
See also:
  SBCL Manual, Package Locks [:node]

Restarts:
 0: [CONTINUE] Ignore the package lock.
 1: [IGNORE-ALL] Ignore all package locks in the context of this operation.
 2: [UNLOCK-PACKAGE] Unlock the package.
 3: [RETRY] Retry SLIME REPL evaluation request.
 4: [*ABORT] Return to SLIME's top level.
 5: [ABORT] abort thread (#<THREAD "repl-thread" RUNNING {10047A8433}>)

...
~~~

それでも変更が必要な場合は、[cl-package-lock][cl-package-lock] というパッケージを使ってパッケージのロックを無視できます。例:

~~~lisp
(cl-package-locks:without-package-locks
  (rename-package :alexandria :alex))
~~~

## 参照

- [Package Local Nicknames in Common Lisp](https://gist.github.com/phoe/2b63f33a2a4727a437403eceb7a6b4a3) の記事。

[guide]: http://www.flownet.com/gat/packages.pdf
[do-sym]: http://www.lispworks.com/documentation/HyperSpec/Body/m_do_sym.htm
[loop]: http://www.lispworks.com/documentation/HyperSpec/Body/06_a.htm
[rename-package]: http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_pkg.htm
[sbcl-package-lock]: http://www.sbcl.org/manual/#Package-Locks
[clisp-package-lock]: https://clisp.sourceforge.io/impnotes/pack-lock.html
[cl-package-lock]: https://www.cliki.net/CL-PACKAGE-LOCKS
 
#  マクロ {#chapter-macros}
 

コンピュータサイエンスでは、_macro_ という語は一般に、プログラミング言語への構文拡張を意味します。（注: この名前は、多くの第 2 世代アセンブリ言語で便利だった "macro-instruction" という語に由来します。macro-instruction は単一の命令のように見えますが、実際には一連の命令へ展開されます。この基本的な考え方は、その後 C プリプロセッサなどで何度も使われてきました。"macro" という名前は、指しているものとあまり関係がない響きなので理想的ではないかもしれませんが、私たちはこの名前と付き合っていくしかありません。）多くの言語にマクロ機能はありますが、Lisp のマクロほど強力なものはありません。Lisp マクロの基本機構は単純ですが、微妙な複雑さもあるため、使いこなすには少し練習が必要です。

## マクロの仕組み

マクロは、_別の Lisp コードらしきもの_ を操作し、それを実行可能な Lisp に（より近い形へ）変換する、普通の Lisp コードです。少し複雑に聞こえるかもしれないので、簡単な例を見てみましょう。2 つの変数を同じ値に設定する [`setq`](http://www.lispworks.com/documentation/HyperSpec/Body/s_setq.htm) の変種がほしいとします。つまり、次のように書いたとき、

~~~lisp
(setq2 x y (+ z 3))
~~~

`z`=8 なら、`x` と `y` の両方が 11 に設定される、というものです。（これが何に役立つかは思いつきませんが、例として使います。）

`setq2` を関数として定義できないことは明らかです。もし `x`=50 で `y`=_-5_ なら、この関数は 50、_-5_、11 という値を受け取るだけで、どの変数を設定すべきかを知ることができません。本当に言いたいのは、あなた（Lisp システム）が次を見たら、

```lisp
(setq2 v1 v2 e)
```

次と同等に扱ってほしい、ということです。

```lisp
(progn
  (setq v1 e)
  (setq v2 e))
```

厳密にはこれはまだ正しくありませんが、今のところは十分です。マクロを使うと、入力パターン <code>(setq2 <i>v<sub>1</sub></i> <i>v<sub>2</sub></i> <i>e</i>)</code> を出力パターン `(progn ...)` へ変換するプログラムを指定することで、まさにこれを実現できます。

### クォート

`setq2` マクロは次のように定義できます。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (list 'progn (list 'setq v1 e) (list 'setq v2 e)))
~~~

これは 2 つの変数と 1 つの式を引数として受け取ります。

そしてコード片を返します。Lisp ではコードがリストで表現されるので、コードを表すリストをそのまま返せます。

ここでは *quote* も使っています。これは *special operator* です（関数でもマクロでもなく、Lisp の中核をなす少数の special operator の 1 つです）。

*quoted* なオブジェクトはそれ自身へ評価されます。つまり、そのまま返されます。

- `(+ 1 2)` は `3` に評価されますが、`(quote (+ 1 2))` は `(+ 1 2)` に評価されます。
- `(quote (foo bar baz))` は `(foo bar baz)` に評価されます。
- `'` は `quote` の省略記法です。`(quote foo)` と `'foo` は等価で、どちらも `foo` に評価されます。

したがって、このマクロは次の部品を返します。

- symbol `progn`
- 2 つ目のリスト。これは次を含みます。
  - symbol `setq`
  - 変数 `v1`: マクロ内ではこの変数は評価されないことに注意してください。
  - 式 `e`: これも評価されません。
- `v2` を含む 2 つ目のリスト。

次のように使えます。

```lisp
(defparameter v1 1)
(defparameter v2 2)
(setq2 v1 v2 3)
;; 3
```

確認すると、`v1` と `v2` は `3` に設定されています。


### Macroexpand

マクロを書き始めるのは、生成したいコードが分かってからです。書き始めたら、そのマクロが実際にどんなコードを生成するか確認できると非常に便利です。そのための関数が `macroexpand` です。これは関数なので、展開したいコードをリストとして渡します（つまり、渡すコード片をクォートします）。

~~~lisp
(macroexpand '(setq2 v1 v2 3))
;; (PROGN (SETQ V1 3) (SETQ V2 3))
;; T
~~~

よし、マクロは望んだコードへ展開されています。

さらに興味深い例です。

~~~lisp
(macroexpand '(setq2 v1 v2 (+ z 3)))
;; (PROGN (SETQ V1 (+ z 3)) (SETQ V2 (+ z 3)))
;; T
~~~

ここで式 `e`、つまり `(+ z 3)` は評価されていないことを確認できます。引数の評価をカンマ `,` で制御する方法は後で見ます。

### 注: Slime の小技

Slime では、展開したい s-expression の左括弧の位置にカーソルを置き、``M-x
slime-macroexpand-[1,all]`` または ``C-c M-m`` を実行すると macroexpand を呼び出せます。

~~~lisp
[|](setq2 v1 v2 3)
;^ cursor
; C-c M-m
; =>
; (PROGN (SETQ V1 3) (SETQ V2 3))
~~~

もう 1 つの小技です。マクロ名の上で ``C-c C-w m``（または ``M-x
slime-who-macroexpands``）を入力すると、そのマクロが展開されたすべての場所を含む新しいバッファが得られます。その後、通常どおり ``C-c C-k``（``slime-compile-and-load-file``）を入力すれば、それらをすべて再コンパイルできます。


### マクロ VS 関数

このマクロは、次の関数定義にとても近いものです。

~~~lisp
(defun setq2-function (v1 v2 e)
  (list 'progn (list 'setq v1 e) (list 'setq v2 e)))
~~~

`(setq2-function 'x 'y '(+ z 3))` を評価したとします（各引数は *quoted* されているので、関数呼び出し時には評価されません）。すると次が得られます。

```lisp
(progn (setq x (+ z 3)) (setq y (+ z 3)))
```

これは完全に普通の Lisp の計算であり、唯一面白い点は、その出力が実行可能な Lisp コード片だということです。`defmacro` が行うのは、この関数を暗黙に作り、`(setq2 x y (+ z 3))` という形の式が見つかるたびに、フォームの部品、すなわち `x`、`y`、`(+ z 3)` を引数として `setq2-function` を呼び出すようにすることです。得られたコード片は `setq2` の呼び出しを置き換え、最初からその新しいコード片がそこにあったかのように実行が続きます。マクロフォームは新しいコード片へ _展開（expand）_ されると言われます。

### 評価コンテキスト

これがすべてです。ただし、もちろん、そこから非常に多くの微妙な帰結が生まれます。主な帰結は、_`setq2` マクロにとっての実行時_ が _そのコンテキストにとってのコンパイル時_ だということです。たとえば、Lisp システムがある関数をコンパイルしている途中で `(setq2 x y (+ z 3))` という式を見つけたとします。コンパイラの仕事は、ソースコードを機械語やバイトコードなどの実行可能なものへ変換することです。したがって、コンパイラはソースコードを実行するのではなく、いろいろな神秘的な方法でそれを処理します。しかし、`setq2` 式を見つけた瞬間、コンパイラは突然 `setq2` マクロ本体の実行へ切り替えなければなりません。先ほど述べたように、これは普通の Lisp コードなので、原理的には他の Lisp コードができることは何でもできます。つまり、コンパイラが動いているとき、Lisp の（実行時）システム全体が存在していなければならない、ということです。

もう一度強調しておきます。コンパイル時には、言語全体を自由に使えます。

初心者はよく次のような間違いをします。`setq2` マクロが、その `e` 引数を結果に埋め込む前に何らかの複雑な変換をする必要があるとします。この変換は Lisp の手続き `some-computation` として書けるとします。初心者はしばしば次のように書きます。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (let ((e1 (some-computation e)))
    (list 'progn (list 'setq v1 e1) (list 'setq v2 e1))))

(defmacro some-computation (exp) ...) ;; _Wrong!_
~~~

間違いは、いったんマクロが呼び出されると Lisp システムが「マクロ世界」に入り、その世界のものは当然すべて `defmacro` で定義しなければならない、と考えることです。これは誤ったイメージです。正しいイメージは、`defmacro` によって _普通の Lisp 世界_ へ踏み込む、ただしそこで主に操作する対象が Lisp コードである、というものです。その段階に入ったら、通常の Lisp 関数定義を使います。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (let ((e1 (some-computation e)))
    (list 'progn (list 'setq v1 e1) (list 'setq v2 e1))))

(defun some-computation (exp) ...) ;; _Right!_
~~~

この間違いの理由の 1 つは、C のような他の言語では、プリプロセッサマクロを起動すると実際に別世界へ入るからかもしれません。そこでは任意の C プログラムを実行することはできません。それが可能だとしたら何を意味するか、少し考えてみる価値はあるでしょう。

もう 1 つの微妙な帰結は、マクロの引数が舞台裏の仮想的な関数（この例では `setq2-function` と呼んだもの）へどのように分配されるかを、明確に書かなければならないことです。ほとんどの場合、これは簡単です。マクロ定義では `&optional`、`&rest`、`&key` など通常の `lambda` リスト構文をすべて使えます。ただし、仮引数に束縛されるのはマクロフォームの部品であって、それらの値ではありません（値はたいてい不明です。なぜなら、これはマクロフォームにとってのコンパイル時だからです）。したがって、次のようにマクロを定義したとします。

~~~lisp
(defmacro foo (x &optional y &key (cxt 'null)) ...)
~~~

すると、

- `(foo a)` と呼ぶと、パラメータの値は `x=a`、`y=nil`、`cxt=null` です。
- `(foo (+ a 1) (- y 1))` と呼ぶと、`x=(+ a 1)`、`y=(- y 1)`、`cxt=null` です。
- `(foo a b :cxt (zap zip))` では、`x=a`、`y=b`、`cxt=(zap zip)` です。


変数の値は、実際の式 `(+ a 1)` や `(zap zip)` であることに注意してください。これらの式の値が既知である必要はなく、値を持つ必要すらありません。マクロはそれらを好きなように扱えます。たとえば、さらに役に立たない `setq` の変種として <code>(setq-reversible <i>e<sub>1</sub></i> <i>e<sub>2</sub></i> <i>d</i>)</code> を考えます。これは <i>d=</i><code>:normal</code> なら <code>(setq <i>e<sub>1</sub></i> <i>e<sub>2</sub></i>)</code> のように振る舞い、_d=_`:backward` なら <code>(setq <i>e<sub>2</sub></i> <i>e<sub>1</sub></i>)</code> のように振る舞います。次のように定義できます。

~~~lisp
(defmacro setq-reversible (e1 e2 direction)
  (case direction
    (:normal (list 'setq e1 e2))
    (:backward (list 'setq e2 e1))
    (t (error "Unknown direction: ~a" direction))))
~~~

展開は次のようになります。

~~~lisp
(macroexpand '(setq-reversible x y :normal))
(SETQ X Y)
T
(macroexpand '(setq-reversible x y :backward))
(SETQ Y X)
T
~~~

誤った方向を渡すと、

~~~lisp
(macroexpand '(setq-reversible x y :other-way-around))
~~~

エラーになり、デバッガへ入ります。

バッククォートとカンマの仕組みは次の節で見ますが、修正版は次のとおりです。

~~~lisp
(defmacro setq-reversible (v1 v2 direction)
  (case direction
    (:normal (list 'setq v1 v2))
    (:backward (list 'setq v2 v1))
    (t `(error "Unknown direction: ~a" ,direction))))
    ;; ^^ backquote                    ^^ comma: backquote の中で値を取り出す。

(macroexpand '(SETQ-REVERSIBLE v1 v2 :other-way-around))
;; (ERROR "Unknown direction: ~a" :OTHER-WAY-AROUND)
;; T
~~~

これで `(setq-reversible v1 v2 :other-way-around)` を呼ぶと、やはりエラーとデバッガは発生しますが、少なくとも `macroexpand` の時点では発生しません。

[​]{#2-backquote}

## バッククォートとカンマ

次へ進む前に、マクロ定義に不可欠な Lisp 記法を導入する必要があります。ただし技術的には、これはマクロそのものからは独立しています。それが _backquote facility_ です。上で見たように、マクロの主な仕事は、結局のところ Lisp コード片を定義することです。つまり `(list 'prog (list 'setq ...) ...)` のような式を評価することになります。これらの式が複雑になるにつれ、読みにくく書きにくくなります。欲しくなるのは、式の骨組みを示し、その一部を新しい式で埋め込める記法です。バッククォートはそれを提供します。上の `list` 式の代わりに、次のように書けます。

~~~lisp
  `(progn (setq ,v1 ,e) (setq ,v2 ,e))
;;^ backquote   ^   ^         ^   ^ commas
~~~

バッククォート（`）文字は、それに続く式の中で、カンマが前についていないすべての部分式はクォートされ、カンマが前についているすべての部分式は評価される、ということを示します。

これはデータ補間として考え、使うことができます。

~~~lisp
`(v1 = ,v1) ;; => (V1 = 3)
~~~


バッククォートについては、ほとんどこれだけです。ただし、追加で 2 つ指摘しておくことがあります。

#### Comma-splice ,@

まず、"`,e`" ではなく "`,@e`" と書くと、_e_ の値が結果に _spliced_（「結合」「合成」「差し込み」）されます。`v` が `(oh boy)` に等しいなら、

~~~lisp
`(zap ,@v ,v)
~~~

は次のように評価されます。

~~~lisp
(zap oh boy (oh boy))
;;   ^^^^^ v の要素（2 要素）が splice される。
;;          ^^ v 自身（リスト）
~~~

2 番目の `v` はその値で置き換えられます。最初のものは、その値の要素で置き換えられます。もし `v` の値が `()` なら、それは完全に消えます。`(zap ,@v ,v)` の値は `(zap ())` になり、これは `(zap nil)` と同じです。

#### Quote-comma ',

バッククォートの文脈にいて、式を文字どおり表示したいときは、quote と comma の組み合わせを使うしかありません。

~~~lisp
(defmacro explain-exp (exp)
  `(format t "~S = ~S" ',exp ,exp))
  ;;                   ^^

(explain-exp (+ 2 3))
;; (+ 2 3) = 5
~~~

自分で確かめてみましょう。

~~~lisp
;; quote をまったく使わない defmacro:
(defmacro explain-exp (exp)
  (format t "~a = ~a" exp exp))
(explain-exp v1)
;; V1 = V1

;; backquote と comma で exp の値を取り出す:
(defmacro explain-exp (exp)
  ;; 誤った例
  `(format t "~a = ~a" exp ,exp))
(explain-exp v1)
;; => error: The variable EXP is unbound.

;; そこで quote-comma を使う:
(defmacro explain-exp (exp)
  `(format t "~a = ~a" ',exp ,exp))
(explain-exp (+ 1 2))
;; (+ 1 2) = 3
~~~


#### ネストしたバッククォート

次に、バッククォート式の中に別のバッククォート式が現れたらどうなるのか、疑問に思うかもしれません。答えは、バッククォートが本質的に読めず書けないものになる、ということです。ネストしたバッククォートを使うのは、たいてい退屈なデバッグ作業になります。理由は、私のあまり謙虚ではない意見では、バッククォートの定義が間違っているからです。カンマは最も内側のバッククォートと対応しますが、本来のデフォルトは最も外側と対応すべきです。とはいえ、ここは愚痴を言う場所ではありません。ネストしたバッククォートの正確な振る舞いと例については、お気に入りの Lisp リファレンスを参照してください。

#### バッククォートでリストを作る

バッククォートの問題の 1 つは、一度覚えると、リストを作るあらゆる場面で使いたくなることです。たとえば、次のように書くかもしれません。

~~~lisp
(mapcan (lambda (x)
          (cond ((symbolp x) `((,x)))
                ((> x 10) `(,x ,x))
                (t '())))
        some-list)
~~~

これは `some-list` = `(a 6 15)` のとき `((a) 15 15)` を返します。問題は、[`mapcan`](http://www.lispworks.com/documentation/HyperSpec/Body/f_mapc_.htm) が [`lambda`](http://www.lispworks.com/documentation/HyperSpec/Body/s_lambda.htm) 式から返された結果を破壊的に変更することです。その式が返すリストが "[fresh](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_f.htm#fresh)"、つまりその `lambda` 式の他の呼び出しで返された構造とは（[`eq`](http://www.lispworks.com/documentation/HyperSpec/Body/f_eq.htm) の意味で）別物である、と確信できるでしょうか。今回の例では、綿密に調べれば fresh でなければならないことが分かります。しかし一般に、バッククォートは毎回 fresh なリストを返す義務を負いません（返すかどうかは実装依存です）。上の例が次のように変更されたとします。

~~~lisp
(mapcan (lambda (x)
          (cond ((symbolp x) `((,x)))
                ((> x 10) `(,x ,x))
                ((>= x 0) `(low))
                (t '())))
        some-list)
~~~

このときバッククォートは `(low)` を `'(low)` のように扱うかもしれません。そのリストはロード時に割り当てられ、`lambda` が評価されるたびに同じ記憶領域の塊が返されます。したがって `some-list` = `(a 6 15)` で式を評価すると、`((a) low 15 15)` が得られますが、副作用として定数 `(low)` が破壊されて `(low 15 15)` になります。その後、たとえば `some-list` = `(8 oops)` で式を評価すると、結果は `(low 15 15 (oops))` になり、最初は `'(low)` だった「定数」は `(low 15 15 (oops))` になっています。（注: ここで例示したバグは他の形でも現れ、初心者だけでなく経験豊富なプログラマも何度も痛い目を見ています。一般形は、何かの値として生成された定数リストが、後で破壊的に変更されるというものです。このバグに対する第一の防衛線は、どんなリストも破壊的に変更しないことです。初心者にとっては、これが最後の防衛線でもあります。自分たちをもう少し洗練されていると思っている人にとって、次の防衛線は [`nconc`](http://www.lispworks.com/documentation/HyperSpec/Body/f_nconc.htm) や `mapcan` を使うたびに非常に注意深く考えることです。）

このバグを直すには、`mapcan` の代わりに `(map 'list ...)` と書けます。しかし、どうしても `mapcan` を使うなら、式を次のように書きます。

~~~lisp
(mapcan (lambda (x)
          (cond ((symbolp x) (list `(,x)))
                ((> x 10) (list x x))
                ((>= x 0) (list 'low))
                (t '())))
        some-list)
~~~

個人的には、バッククォートは _S 式_、つまりシンボル、数値、文字列からなる階層的な式で、長さが変化するものとして概念化されていないものを作る場合にだけ使うのが好みです。たとえば、私は次のようには書きません。

~~~lisp
(setq sk `(,x ,@sk))
~~~

`sk` がスタックとして使われている、つまり通常の処理の中で [`pop`](http://www.lispworks.com/documentation/HyperSpec/Body/m_pop.htm) されるなら、私は `(push x sk)` と書きます。そうでなければ `(setq sk (cons x sk))` と書きます。

[​]{#LtohTOCentry-3}

## マクロを正しく書く

最初の節で、私の `setq2` の定義は厳密には正しくないと言いました。ここでそれを直します。

`x`_=8_ のとき `(setq2 x y (+ x 2))` と書いたとします。上で与えた定義によれば、このフォームは次へ展開されます。

~~~lisp
(progn
  (setq x (+ x 2))
  (setq y (+ x 2)))
~~~

そのため `x` は 10 になり、`y` は 12 になります。実際、マクロ展開は次のとおりです。

~~~lisp
(macroexpand '(setq2 x y (+ x 2)))
;;(PROGN (SETQ X (+ X 2)) (SETQ Y (+ X 2)))
~~~

おそらくこれは、そのマクロに期待される動作ではありません（もちろん、そうでないとは限りませんが）。もう 1 つの問題例は `(setq2 x y (pop l))` です。これは `l` を 2 回 pop してしまいます。これもおそらく正しくありません。

解決策は、式 `e` を 1 回だけ評価し、一時変数に保存してから、`v1` と `v2` をそれに設定することです。

### Gensym

一時変数を作るには、`gensym` 関数を使います。これは他のどこにも現れないことが保証された fresh な変数を返します。マクロは次のようになるべきです。

~~~lisp
(defmacro setq2 (v1 v2 e)
  (let ((tempvar (gensym)))
    `(let ((,tempvar ,e))
       (progn (setq ,v1 ,tempvar)
              (setq ,v2 ,tempvar)))))
~~~

これで `(setq2 x y (+ x 2))` は次へ展開されます。

~~~lisp
(let ((#:g2003 (+ x 2)))
  (progn (setq x #:g2003) (setq y #:g2003)))
~~~

ここで `gensym` はシンボル `#:g2003` を返しています。このような妙な表示になるのは、reader がそれを認識しないからです。（それを reader が認識する必要もありません。なぜなら、そのシンボルはそれを含むコードがコンパイルされるまでの間だけ存在すればよいからです。）

練習: この新しい版が `(setq2 x y (pop l1))` の場合に正しく動作することを確認してください。

練習: バッククォートを使わずに、この新しい版のマクロを書いてみてください。できなければ、その練習は正しくできています。そして、バッククォートが何のためにあるかを学んだことになります。

この節の教訓は、マクロ内のどの式がいつ評価されるかを慎重に考えることです。同じ式が出力に 2 回埋め込まれる状況（最初のマクロ設計における `e` のようなもの）に注意してください。複雑なマクロでは、式が評価される順序が、書かれている順序と異なる場合にも気をつけてください。これはマクロの利用者を必ずつまずかせます。たとえ利用者が自分だけであってもです。[​]{#LtohTOCentry-4}

## マクロは何のためにあるか

マクロは Lisp に構文拡張を作るためのものです。マクロは悪い考えだ、ユーザーに任せてはいけない、などと言われることがあります。ばかげています。自分の手続きを定義して言語を拡張するのと同じくらい、構文的に言語を拡張するのは合理的です。たしかに、あなたのコードを気軽に読む人は、マクロ定義を見なければコードを理解できないかもしれません。しかし、関数定義を見なければ理解できないのも同じです。複数のファイルに散らばった [`defmethod`](http://www.lispworks.com/documentation/HyperSpec/Body/m_defmet.htm) の方が、マクロよりはるかに不明瞭さに寄与しますが、それは別の長話です。

私が有用だと思う構文拡張の種類を眺める前に、一般に _有用ではない_ 構文拡張、あるいはマクロ以外の手段で実現した方がよいものを指摘しておきます。初心者の中には、マクロは関数を open-code するために便利だと考える人がいます。たとえば、次のように定義する代わりに、

~~~lisp
(defun sqone (x)
  (let ((y (+ x 1))) (* y y)))
~~~

次のように定義するかもしれません。

~~~lisp
(defmacro sqone (x)
  `(let ((y (+ ,x 1))) (* y y)))
~~~

すると `(sqone (* z 13))` は次へ展開されます。

~~~lisp
(let ((y (+ (* z 13) 1)))
  (* y y))
~~~

これは正しいですが、労力の無駄です。第一に、節約される時間はほぼ確実に無視できます。本当に `sqone` をインライン展開することが重要なら、`sqone` を定義する前に `(declaim (inline sqone))` を置けます（ただし、コンパイラがこの宣言に従う義務はありません）。第二に、`sqone` をマクロとして定義すると、`(mapcar #'sqone ll)` と書くことも、それ以外に呼び出す以外のことをすることも不可能になります。

しかし、マクロには正当な用途が山ほどあります。`(^ (x) ...)` と書けるなら、なぜ `(lambda (x) ...)` と書くのでしょう。`^` をマクロとして定義すればよいのです。

```lisp
(defmacro ^ (&rest body)
  `(lambda ,@body))
```

多くの人は、特に大きな `lambda` 式と一緒に使うとき、`mapcar` や `mapcan` は少し分かりにくいと感じます。次のようなものを書く代わりに、

~~~lisp
(mapcar (lambda (x)
          (let ((y (hairy-fun1 x))
                (z (hairy-fun2 x)))
            (dolist (y1 y)
              (dolist (z1 z)
                _... and further meaningless_
                _space-filling nonsense..._
                ))))
        list)
~~~

次のように書きたいかもしれません。

~~~lisp
(for (x :in list)
     (let ((y (hairy-fun1 x))
           (z (hairy-fun2 x)))
       (dolist (y1 y)
         (dolist (z1 z)
           _... and further meaningless_
           _space-filling nonsense..._
           ))))
~~~

このマクロは次のように定義できます。

~~~lisp
(defmacro for (listspec exp)
  ;;           ^^ listspec = (x :in list), 長さ 3 のリスト。
  ;;                    ^^ exp = 残りのコード。
  (cond
    ((and (= (length listspec) 3)
          (symbolp (first listspec))
          (eq (second listspec) ':in))
     `(mapcar (lambda (,(first listspec))
                ,exp)
              ,(third listspec)))
    (t (error "Ill-formed for spec: ~A" listspec)))))
~~~

（これは Chris Riesbeck によるマクロの簡略版です。）

このマクロで keyword `:in` が果たす役割について、少し立ち止まって考える価値があります。これは「局所的な構文マーカー」のように機能します。Lisp から見れば意味はありませんが、マクロ自身にとっては構文上の道しるべになります。このようなマーカーを _guide symbols_ と呼ぶことにします。（ここでの役割は些細に見えるかもしれませんが、`for` マクロを一般化して複数のリスト引数や本体内の暗黙の `progn` を許すなら、`:in` は引数がどこで終わり、本体がどこから始まるかを知らせる上で重要になります。）

マクロの guide シンボルが [keyword パッケージ](http://www.lispworks.com/documentation/HyperSpec/Body/11_abc.htm) にあることは厳密には必要ではありませんが、2 つの理由から良い考えです。第一に、何か独自のことが起きていることを読み手に目立たせます。`(for ((x in (foobar a b 'oof))) (something-hairy x (list x)))` のようなフォームは、`x` の前の二重括弧のためにすでに少し奇妙に見えます。しかし "`:in`" を使うと、それがより明白になります。

第二に、guide シンボルの存在を確認するために、マクロ定義で `(eq (second listspec) ':in)` と書いたことに注意してください。もし `:in` ではなく `in` を使っていたら、_自分の_ `in` がどのパッケージに住み、マクロ利用者の `in` がどのパッケージに住むかを考えなければなりません。問題を避ける方法の 1 つは次のように書くことです。

~~~lisp
(and (symbolp (second listspec))
     (eq (intern (symbol-name (second listspec))
                 :keyword)
         ':in))
~~~

もう 1 つは次のように書くことです。

~~~lisp
(and (symbolp (second listspec))
     (string= (symbol-name (second listspec)) (symbol-name 'in)))
~~~

どちらも特に明快でも美しくもありません。keyword パッケージは、ホームが本質的に関係ないシンボルの置き場所を提供するためにあります。使えばよいのです。（注: ANSI Lisp では `(symbol-name 'in)` の代わりに `"IN"` と書けますが、シンボル名を大文字へ変換しない Lisp 実装もあります。大文字変換という考え全体は恥ずかしい遺物だと思っているので、私はそうした実装にも移植できるコードを書くようにしています。）

もう 1 つ例を見てみましょう。これは便利なマクロを示すと同時に、後の議論で使う補助関数を提供します。Lisp では新しいシンボルを作りたいことがよくありますが、それらを構築するには `gensym` だけでは不十分なことがあります。`build-symbol` という代替機能の説明は次のとおりです。

> <code>(build-symbol [(:package <em>p</em>)] <em>-pieces-</em>)</code> は、指定された _pieces_ を連結してシンボルを作り、_p_ によって指定された方法で intern します。_pieces_ の各要素について、それが ...
>
> *   ... string: その文字列が新しいシンボル名へ追加されます。
> *   ... symbol: そのシンボルの名前が新しいシンボル名へ追加されます。
> *   ... <code>(:< <em>e</em>)</code> という形の式: _e_ は文字列、シンボル、number のいずれかへ評価されるべきです。_e_ の値を `princ` で表示した文字列が新しいシンボル名へ連結されます。
> *   ... <code>(:++ <em>p</em>)</code> という形の式: _p_ は place 式（つまり `setf` の第 1 引数として適切なもの）で、その値は整数であるべきです。その値は 1 増やされ、新しい値が新しいシンボル名へ連結されます。
>
> `:package` 指定が省略された場合、デフォルトは `*package*` の値です。_p_ が `nil` ならシンボルはどこにも intern されません。そうでなければ、パッケージ designator（通常はパッケージと同じ名前を持つ keyword）へ評価されるべきです。

たとえば、`x` = `foo` で `*x-num*` = 8 のとき `(build-symbol (:< x) "-" (:++ *x-num*))` は、`*x-num*` を 9 に設定し、`FOO-9` に評価されます。もう一度評価すると、結果は `FOO-10` になり、以下同様です。

明らかに、`build-symbol` は関数として実装できません。マクロでなければなりません。実装は次のとおりです。

~~~lisp
(defmacro build-symbol (&rest list)
  (let ((p (find-if (lambda (x)
                      (and (consp x)
                           (eq (car x) ':package)))
                    list)))
    (when p
      (setq list (remove p list)))
    (let ((pkg (cond ((eq (second p) 'nil)
                      nil)
                     (t `(find-package ',(second p))))))
      (cond (p
             (cond (pkg
                    `(values (intern ,(symstuff list) ,pkg)))
                   (t
                    `(make-symbol ,(symstuff list)))))
            (t
             `(values (intern ,(symstuff list))))))))

(defun symstuff (list)
  `(concatenate 'string
     ,@(for (x :in list)
            (cond ((stringp x)
                   `',x)
                  ((atom x)
                   `',(format nil "~a" x))
                  ((eq (car x) ':<)
                   `(format nil "~a" ,(second x)))
                  ((eq (car x) ':++)
                   `(format nil "~a" (incf ,(second x))))
                  (t
                   `(format nil "~a" ,x))))))
~~~

（別の方法として、`symstuff` が <code>(format nil <em>format-string -forms-</em>)</code> という形の単一の呼び出しを返すようにしてもよいでしょう。このとき _forms_ は _pieces_ から導かれ、_format-string_ は ~a と文字列が交互に並んだものになります。）

ときには、マクロが一時的にだけ、構文上の足場のようなものとして必要になることがあります。12 個の関数を定義する必要があるが、それらが 4 個ずつの典型的な 3 グループに分かれているとします。

~~~lisp
(defun make-a-zip (y z)
  (vector 2 'zip y z))
(defun test-whether-zip (x)
  (and (vectorp x) (eq (aref x 1) 'zip)))
(defun zip-copy (x) ...)
(defun zip-deactivate (x) ...)

(defun make-a-zap (u v w)
  (vector 3 'zap u v w))
(defun test-whether-zap (x) ...)
(defun zap-copy (x) ...)
(defun zap-deactivate (x) ...)

(defun make-a-zep ()
  (vector 0 'zep))
(defun test-whether-zep (x) ...)
(defun zep-copy (x) ...)
(defun zep-deactivate (x) ...)
~~~

省略された部分は、同じような名前の関数ではすべて同じだとします。（つまり、`zep-deactivate` の "..." は `zip-deactivate` の "..." と同じコード、という具合です。）ここでは具体性のため、もっともらしさはともかく、`zip`、`zap`、`zep` は奇妙な小さなデータ構造のように振る舞っているとします。関数はかなり大きくなり得るので、デバッグしながらすべてを同期させ続けるのは退屈です。代替案はマクロを使うことです。

~~~lisp
(defmacro odd-define (name buildargs)
  `(progn (defun ,(build-symbol make-a- (:< name))
                                ,buildargs
            (vector ,(length buildargs) ',name ,@buildargs))
          (defun ,(build-symbol test-whether- (:< name)) (x)
            (and (vectorp x) (eq (aref x 1) ',name))
          (defun ,(build-symbol (:< name) -copy) (x)
            ...)
          (defun ,(build-symbol (:< name) -deactivate) (x)
            ...))))

(odd-define zip (y z))
(odd-define zap (u v w))
(odd-define zep ())
~~~

このマクロの使用がすべてこの 1 か所にまとまっているなら、[macrolet](http://www.lispworks.com/documentation/HyperSpec/Body/s_flet_.htm) を使ってローカルマクロにした方が明快かもしれません。

~~~lisp
(macrolet ((odd-define (name buildargs)
             `(progn
                (defun ,(build-symbol make-a- (:< name))
                                        ,buildargs
                    (vector ,(length buildargs)
                            ',name
                             ,@buildargs))
                  (defun ,(build-symbol test-whether- (:< name))
                         (x)
                    (and (vectorp x) (eq (aref x 1) ',name))
                  (defun ,(build-symbol (:< name) -copy) (x)
                    ...)
                  (defun ,(build-symbol (:< name) -deactivate) (x)
                    ...)))))
(odd-define zip (y z))
(odd-define zap (u v w))
(odd-define zep ()))
~~~

最後に、マクロは「コマンド言語」を定義するために不可欠です。_command_ は、ユーザーが Lisp の read-eval-print loop と対話するときに使う短い名前の関数です。短い名前が便利で可能なのは、タイプしやすくしたい一方で、その名前が他のコマンドと衝突するかどうかはあまり気にしないからです。2 つのコマンド名が衝突したら、片方を変えればよいのです。

例として、マクロをデバッグする小さなコマンド言語を定義してみましょう。（実際に便利だと感じるかもしれません。）コマンドは `ex` と `fi` の 2 つだけです。これらは「現在のフォーム」、つまり macro-expanded される対象またはその展開結果を追跡します。

1.  <code>(ex [<em>form</em>])</code>: _form_ が与えられていればそれに、そうでなければ現在のフォームに `macroexpand-1` を適用し、その結果を現在のフォームにします。その後、現在のフォームを pretty-print します。
2.  <code>(fi <em>s</em> [<em>k</em>])</code>: 現在のフォームのうち、`car` が _s_ である _k_ 番目の部分式を探します。(_k_ のデフォルトは 0 です。) その部分式を現在のフォームにし、pretty-print します。

`hair-squared` というマクロをデバッグしようとしているとします。このマクロは複雑なものへ展開され、その中にシンボル `odd-define` で始まるマクロフォームが含まれています。その部分フォームにバグがあると疑っています。次のコマンドを発行できます。

~~~lisp
(ex (hair-squared ...))
(PROGN (DEFUN ...)
         (ODD-DEFINE ZIP (U V W))
         ...)

(fi odd-define)
(ODD-DEFINE ZIP (U V W))

(ex)
(PROGN (DEFUN MAKE-A-ZIP (U V W) ...)
   ...)
~~~

繰り返しますが、`ex` と `fi` は関数にはできないことが明らかです。ただし、引数の前に quote を打つことを厭わないなら、簡単に関数にできます。しかし、コマンドで "quote" をよく使うのは不適切に思えることがあります。第一に、キーストロークを節約しようとしている文脈でそれをタイプする必要があるのは面倒です。特に、その引数が常にクォートされるならなおさらです。第二に、多くの場合、単に不自然に見えます。引数の 1 つとしてシンボルを受け取り、それをある値に設定するコマンドがあるなら、<code>(<em>command</em> 'x ...)</code> と書くのは、<code>(<em>command</em> x ...)</code> と書くより奇妙です。なぜなら、そのコマンドを `setq` の変種として考えたいからです。

`ex` と `fi` は次のように定義できます。

~~~lisp
(defvar *current-form*)

(defmacro ex (&optional (form nil form-supplied))
  `(progn
     (pprint (setq *current-form*
                   (macroexpand-1
                    ,(cond (form-supplied
                            `',form)
                           (t '*current-form*)))))
     (values)))

(defmacro fi (s &optional (k 0))
  `(progn
     (pprint (setq *current-form*
                   (find-nth-occurrence ',s *current-form* ,k)))
     (values)))
~~~

`ex` マクロは `macroexpand-1` への呼び出しを含むフォームへ展開されます。`macroexpand-1` は組み込み関数で、`car` がマクロ名であるフォームに対して、マクロ展開を 1 ステップ行います。（別のフォームが与えられた場合は、そのフォームを変更せずに返します。）`pprint` は引数を pretty-print する組み込み関数です。`ex` と `fi` は read-eval-print loop で使うので、展開が返す値はすべて印字されます。ここでは展開は副作用のために実行されるので、展開が `(values)` を返すようにして、値をまったく返さないようにします。

Lisp 実装によっては、read-eval-print loop が通常 `pprint` を使って結果を印字します。そのような実装では、`ex` と `fi` が何も印字せず、単に `*current-form*` の値を返すように単純化できます。read-eval-print loop がそれをきれいに印字してくれるからです。判断して使ってください。

`find-nth-occurrence` の定義は練習問題として残しておきます。現在のフォームを設定して印字するだけのコマンド <code>(cf <em>e</em>)</code> も定義したくなるかもしれません。

注意点を 1 つ。一般に、コマンド言語はマクロと関数の混合からなり、それを定義する人（そして普通は唯一の利用者）にとって便利であることが主な考慮事項になります。あるコマンドが、ときどき一部の引数を評価したがっているように見えるなら、そのコマンドを 2 つ（またはそれ以上）のバージョンとして定義するか、1 つの関数として定義して、評価を防ぐために引数をクォートしてもらうかを決める必要があります。前の段落で述べた `cf` コマンドについては、`cf` を関数にしたいユーザーもいれば、マクロにしたいユーザーもいるでしょう。

## define-symbol-macro, symbol-macrolet

これら 2 つのマクロは、別のより複雑なフォームへの「ショートカット」として振る舞うシンボルを定義できるようにします。

仕様の言葉では、これらは「指定されたシンボルのマクロ展開に影響を与える仕組みを提供する」ものです。

`define-symbol-macro` はグローバル環境に影響します（`defparameter`、`defun` などと同様です）。`symbol-macrolet` は `let` のようにローカルスコープで使います。

データ構造の節で例を示しました。構造体を使います。

~~~lisp
(defstruct ship x-position y-position x-velocity y-velocity)
~~~

そのスロット accessor は `ship-x-position` などです。

すべての異なる structure スロットにアクセスしなければならない `move-ship` 関数を書きます。

~~~lisp
(defun move-ship (ship)
  (psetf (ship-x-position ship)
           (+ (ship-x-position ship) (ship-x-velocity ship))
         (ship-y-position ship)
           (+ (ship-y-position ship) (ship-y-velocity ship)))
   ship)
~~~

しかし、これは冗長です。そこで、`x` が `ship-x-position` へ展開されるようにローカルシンボルマクロを使います。

`symbol-macrolet` は次のような形で、構文は `let` に似ています。

~~~lisp
(symbol-macrolet ((x (ship-x-position ship))
                  (y (other-form ship)))
    (use x and y here))
~~~

関数の中で使ってみましょう。

~~~lisp
(defun move-ship (ship)
  (symbol-macrolet                   ;; <---- LET のようなもの
      ((x (ship-x-position ship))    ;; <---- (symbol (expansion form)) のリスト
       (y (ship-y-position ship))
       (xv (ship-x-velocity ship))
       (yv (ship-y-velocity ship)))
    (psetf x (+ x xv)                ;; <----- 本体で x を使う
           y (+ y yv))
    ship))
~~~

コンパイル時、マクロ展開の段階で `x` はフォーム `(ship-x-position ship)` へ展開され、関数はそのフォームを使ってコンパイルされます。

詳しくは [Community Spec](https://cl-community-spec.github.io/pages/symbol_002dmacrolet.html) を読んでください。


## 関連項目

* [A gentle introduction to Compile-Time Computing — Part 1](https://medium.com/@MartinCracauer/a-gentle-introduction-to-compile-time-computing-part-1-d4d96099cea0)
* [Safely dealing with scientific units of variables at compile time (a gentle introduction to Compile-Time Computing — part 3)](https://medium.com/@MartinCracauer/a-gentle-introduction-to-compile-time-computing-part-3-scientific-units-8e41d8a727ca)
* 次の動画は、[cbaggers](https://github.com/cbaggers/) による ["Little bits of
Lisp"](https://www.youtube.com/user/CBaggers/playlists) シリーズのものです。マクロについて 2 時間ほど話しており、compiler マクロのような初歩から高度な概念までを示しています。
[https://www.youtube.com/watch?v=ygKXeLKhiTI](https://www.youtube.com/watch?v=ygKXeLKhiTI)
Emacs でマクロ（とその展開）を操作する方法も示しています。

[![video](assets/youtube-little-bits-lisp.jpg)](https://www.youtube.com/watch?v=ygKXeLKhiTI)

* 記事 "Reader Macros in Common Lisp": https://lisper.in/reader-macros
 
#  CLOS の基礎 {#chapter-clos}
 


CLOS は "Common Lisp Object System" の略で、どの言語でも利用できるオブジェクトシステムの中でも、おそらく最も強力なものの 1 つです。

その機能には次のようなものがあります。

* **動的**であり、Lisp REPL で扱うのが楽しくなります。たとえば、クラス定義を変更すると、こちらで制御できる一定の規則に従って既存のオブジェクトが更新されます。
* **多重ディスパッチ** と **多重継承** をサポートします。
* クラス定義とメソッド定義が結び付いていない点で、多くのオブジェクトシステムとは異なります。
* 優れた **イントロスペクション（内省）** 機能を持ちます。
* **メタオブジェクトプロトコル** によって提供されます。これは CLOS への標準インターフェイスを提供し、新しいオブジェクトシステムを作るためにも使えます。

この名前に属する機能は、1984 年の Steele による "Common Lisp, the Language" 初版の出版から、その 10 年後に ANSI 標準として言語が正式化されるまでの間に Common Lisp 言語へ追加されました。

このページは CLOS の使い方を十分に理解できるようにすることを目指しますが、MOP については簡単な導入にとどめます。

これらの主題を深く学ぶには、次の 2 冊が必要です。

- [Object-Oriented Programming in Common Lisp: a Programmer's Guide to CLOS](http://www.communitypicks.com/r/lisp/s/17592186046723-object-oriented-programming-in-common-lisp-a-programmer), by Sonya Keene,
- [the Art of the Metaobject Protocol](http://www.communitypicks.com/r/lisp/s/17592186045709-the-art-of-the-metaobject-protocol), by Gregor Kiczales, Jim des Rivières et al.

あわせて次も参照してください。

- Peter Seibel による [Practical Common Lisp](http://www.gigamonkeys.com/book/object-reorientation-generic-functions.html) (online) の導入。
-  [Common Lisp, the Language](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node260.html#SECTION003200000000000000000)
- リファレンスとして、完全な [CLOS-MOP specifications](https://clos-mop.hexstreamsoft.com/)。


##  クラスとインスタンス

### まず試す

クラス定義、オブジェクト作成、スロットアクセス、特定クラスに特殊化したメソッド、継承を示す例から始めましょう。

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)))

;; => #<STANDARD-CLASS PERSON>

(defvar p1 (make-instance 'person :name "me" ))
;;                                 ^^^^ initarg
;; => #<PERSON {1006234593}>

(name p1)
;;^^^ accessor
;; => "me"

(lisper p1)
;; => nil
;;    ^^ initform (slot unbound by default)

(setf (lisper p1) t)


(defclass child (person)
  ())

(defclass child (person)
  ((can-walk-p
     :accessor can-walk-p
     :initform t)))
;; #<STANDARD-CLASS CHILD>

(can-walk-p (make-instance 'child))
;; T
~~~

### クラスの定義 (defclass)

CLOS で新しいデータ型を定義するために使うマクロは `defclass` です。

先ほどは次のように使いました。

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)))
~~~

これにより、`person` という CLOS 型 (またはクラス) と、`name` および `lisper` という 2 つのスロットが得られます。

~~~lisp
(class-of p1)
#<STANDARD-CLASS PERSON>

(type-of p1)
PERSON
~~~

`defclass` の一般形は次のとおりです。

```
(defclass <class-name> (list of super classes)
  ((slot-1
     :slot-option slot-argument)
   (slot-2, etc))
  (:optional-class-option
   :another-optional-class-option))
```

つまり、私たちの `person` クラスは別のクラスを明示的には継承していません (空の括弧 `()` を受け取っています)。
しかし、それでもデフォルトでクラス `t` と `standard-object` から継承しています。
下の「継承」を参照してください。

スロットオプションなしの最小限のクラス定義は次のように書けます。

~~~lisp
(defclass point ()
  (x y z))
~~~

あるいはスロット指定子すらなく、`(defclass point () ())` と書くこともできます。

### オブジェクトの作成 (make-instance)

クラスのインスタンスは `make-instance` で作成します。

~~~lisp
(defvar p1 (make-instance 'person :name "me" ))
~~~

一般に、コンストラクタを定義するのはよい習慣です。

~~~lisp
(defun make-person (name &key lisper)
  (make-instance 'person :name name :lisper lisper))
~~~

これには、必要な引数を制御できるという直接的な利点があります。
この時点では、クラス自体ではなく、コンストラクタをパッケージから export すべきです。

### スロット

#### 常に使える関数 (slot-value)

任意のスロットへいつでもアクセスするための関数は `(slot-value <object> <slot-name>)` です。

上の `point` クラスはスロットアクセサを定義していませんでした。


```lisp
(defvar pt (make-instance 'point))

(inspect pt)
The object is a STANDARD-OBJECT of type POINT.
0. X: "unbound"
1. Y: "unbound"
2. Z: "unbound"
```

型 `POINT` のオブジェクトは得られましたが、**スロットはデフォルトでは unbound** です。
アクセスしようとすると `UNBOUND-SLOT` コンディションが発生します。

~~~lisp
(slot-value pt 'x) ;; => condition: the slot is unbound
~~~


`slot-value` は `setf` できます。

~~~lisp
(setf (slot-value pt 'x) 1)
(slot-value pt 'x) ;; => 1
~~~

#### 初期値とデフォルト値 (initarg, initform)

- `:initarg :foo` は、このスロットに値を与えるために `make-instance` へ渡せるキーワードです。

~~~lisp
(make-instance 'person :name "me")
~~~

(繰り返しますが、スロットはデフォルトでは unbound です)

- `:initform <val>` は、initarg を指定しなかった場合の *デフォルト値* です。
  このフォームは、必要になるたびに `defclass` のレキシカル環境で評価されます。

スロットを明確に必須にするため、次のようなテクニックを見ることがあります。

~~~lisp
(defclass foo ()
    ((a
      :initarg :a
      :initform (error "you didn't supply an initial value for slot a"))))
;; #<STANDARD-CLASS FOO>

(make-instance 'foo) ;; => enters the debugger.
~~~


#### getter と setter (accessor, reader, writer)

- `:accessor foo`: accessor は **getter** であり **setter** でもあります。
  その引数は **総称関数** になる名前です。

~~~lisp
(name p1) ;; => "me"

(type-of #'name)
STANDARD-GENERIC-FUNCTION
~~~

- `:reader` と `:writer` は期待どおりのことをします。`setf` できるのは `:writer` だけです。

これらのどれも指定しなくても、`slot-value` は使えます。

1 つのスロットに複数の `:accessor`、`:reader`、`:initarg` を与えることもできます。


状況によってスロットへのアクセスを短く書くため、2 つのマクロを紹介します。

1- `with-slots` は、複数の slot-value 呼び出しを短く書けるようにします。
第 1 引数はスロット名のリストです。
第 2 引数は CLOS インスタンスへ評価されます。
その後に省略可能な宣言と暗黙の `progn` が続きます。
本体の評価中、レキシカルには、これらの名前を変数として参照することは、対応するインスタンスのスロットを `slot-value` で参照することと同じです。


~~~lisp
(with-slots (name lisper)
    c1
  (format t "got ~a, ~a~&" name lisper))
~~~

または

~~~lisp
(with-slots ((n name)
             (l lisper))
    c1
  (format t "got ~a, ~a~&" n l))
~~~

2- `with-accessors` も同様ですが、スロットのリストではなく accessor 関数のリストを取ります。
マクロ内で変数を参照すると、accessor 関数の呼び出しと同じになります。

~~~lisp
(with-accessors ((name        name)
                  ^^variable  ^^accessor
                 (lisper lisper))
            p1
          (format t "name: ~a, lisper: ~a" name lisper))
~~~

#### クラススロットとインスタンススロット

`:allocation` は、このスロットが *ローカル* か *共有* かを指定します。

* スロットはデフォルトで *ローカル* です。つまり、クラスのインスタンスごとに異なる値を持てます。この場合、`:allocation` は `:instance` です。

* *共有* スロットは、そのクラスのすべてのインスタンスで常に同じ値になります。これは `:allocation :class` で設定します。

次の例では、`p2` のクラススロット `species` の値を変更すると、そのクラスのすべてのインスタンス (それらがすでに存在しているかどうかにかかわらず) に影響することに注目してください。

~~~lisp
(defclass person ()
  ((name :initarg :name :accessor name)
   (species
      :initform 'homo-sapiens
      :accessor species
      :allocation :class)))

;; 既存のインスタンスからスロット "lisper" が削除されたことに注意。
(inspect p1)
;; The object is a STANDARD-OBJECT of type PERSON.
;; 0. NAME: "me"
;; 1. SPECIES: HOMO-SAPIENS
;; > q

(defvar p2 (make-instance 'person))

(species p1)
(species p2)
;; HOMO-SAPIENS

(setf (species p2) 'homo-numericus)
;; HOMO-NUMERICUS

(species p1)
;; HOMO-NUMERICUS

(species (make-instance 'person))
;; HOMO-NUMERICUS

(let ((temp (make-instance 'person)))
    (setf (species temp) 'homo-lisper))
;; HOMO-LISPER
(species (make-instance 'person))
;; HOMO-LISPER
~~~

#### スロットのドキュメント

各スロットは `:documentation` オプションを 1 つ受け取れます。
`documentation` でそのドキュメントを取得するには、スロットオブジェクトを取得する必要があります。
これは [closer-mop](https://github.com/pcostanza/closer-mop) のようなライブラリを使うと移植性のある形で行えます。例:

~~~lisp
(closer-mop:class-direct-slots (find-class 'my-class))
;; => スロット (オブジェクト) のリスト
(find 'my-slot * :key #'closer-mop:slot-definition-name)
;; => 目的のスロットを名前で探す
(documentation * t) ; そのドキュメントを取得する
~~~

ただし一般には、スロットではなくスロット accessor をドキュメント化するほうがよいかもしれません。
スロットは実装詳細であり、公開インターフェイスの一部ではない、という見方が広くあります。

#### スロット型

`:type` スロットオプションは、期待どおりの仕事をしないかもしれません。
CLOS に慣れていないなら、このセクションは飛ばし、自分のコンストラクタで手動でスロット型をチェックすることをおすすめします。

実際、スロット型がチェックされるかどうかは未定義です。[Hyperspec](http://www.lispworks.com/documentation/HyperSpec/Body/m_defcla.htm#defclass) を参照してください。

これを行う実装は少数です。Clozure CL は行います。SBCL はバージョン 1.5.9 (2019 年 11 月) 以降、または safety が高い場合 (`(declaim (optimise safety))`) に行います。

別の方法で行うには、[this Stack-Overflow answer](https://stackoverflow.com/questions/51723992/how-to-force-slots-type-to-be-checked-during-make-instance) を参照してください。また、契約プログラミングライブラリ [quid-pro-quo](https://github.com/sellout/quid-pro-quo) も参照してください。


### find-class, class-name, class-of

~~~lisp
(find-class 'point)
;; #<STANDARD-CLASS POINT 275B78DC>

(class-name (find-class 'point))
;; POINT

(class-of my-point)
;; #<STANDARD-CLASS POINT 275B78DC>

(typep my-point (class-of my-point))
;; T
~~~

CLOS クラスもまた CLOS クラスのインスタンスであり、下の例のように、そのクラスが何かを調べられます。

~~~lisp
(class-of (class-of my-point))
;; #<STANDARD-CLASS STANDARD-CLASS 20306534>
~~~

<u>Note</u>: これは MOP への最初の導入です。始めるだけなら必要ありません!

オブジェクト `my-point` は `point` という名前のクラスのインスタンスであり、`point` という名前のクラス自体は `standard-class` という名前のクラスのインスタンスです。
`standard-class` という名前のクラスは、`my-point` の *メタクラス* (つまりクラスのクラス) であると言います。
後で見るように、メタクラスはうまく活用できます。



### サブクラスと継承

上で示したように、`child` は `person` のサブクラスです。

すべてのオブジェクトはクラス `standard-object` と `t` から継承します。

すべての `child` のインスタンスは `person` のインスタンスでもあります。

~~~lisp
(type-of c1)
;; CHILD

(subtypep (type-of c1) 'person)
;; T

(ql:quickload "closer-mop")
;; ...

(closer-mop:subclassp (class-of c1) 'person)
;; T
~~~

[closer-mop](https://github.com/pcostanza/closer-mop) ライブラリは、CLOS/MOP 操作を行うための移植性のある定番の方法です。


サブクラスは親のすべてのスロットを継承し、そのスロットオプションを上書きできます。
Common Lisp はこのプロセスを動的にしており、REPL セッションに適しています。
さらに、その一部を制御することもできます (特定のスロットが削除、更新、追加されたときに何かをする、など)。

したがって、`child` の **クラス優先順位リスト** は次のようになります。

    child <- person <-- standard-object <- t

これは次で取得できます。

~~~lisp
(closer-mop:class-precedence-list (class-of c1))
;; (#<standard-class child>
;;  #<standard-class person>
;;  #<standard-class standard-object>
;;  #<sb-pcl::slot-class sb-pcl::slot-object>
;;  #<sb-pcl:system-class t>)
~~~

しかし、`child` の **直接のスーパークラス** は次だけです。

~~~lisp
(closer-mop:class-direct-superclasses (class-of c1))
;; (#<standard-class person>)
~~~

さらに `class-direct-[subclasses, slots, default-initargs]` や多くの関数でクラスを調べられます。

スロットの結合にはいくつかの規則があります。

- `:accessor` と `:reader` は、継承したすべてのスロットからの accessor と reader の **和集合** によって結合されます。

- `:initarg`: 継承したすべてのスロットからの初期化引数の **和集合** です。

- `:initform`: **最も特定的な** デフォルト初期値フォーム、つまり優先順位リスト内でそのスロットに対して最初に現れる `:initform` が得られます。

- `:allocation` は継承されません。定義中のクラスだけで制御され、デフォルトは `:instance` です。


最後に重要な注意として、継承はかなり誤用しやすく、多重継承ではその危険がさらに増えます。少し注意してください。
`foo` が本当に `bar` を継承したいのか、それとも `foo` のインスタンスが `bar` を含むスロットを持ちたいのかを自問してください。
一般的な指針として、`foo` と `bar` が「同じ種類のもの」なら継承で混ぜるのは正しいですが、本当に別々の概念なら、スロットを使って分けておくべきです。


### 多重継承

CLOS は多重継承をサポートします。


~~~lisp
(defclass baby (child person)
  ())
~~~

親クラスのリストで最初にあるクラスが最も特定的です。
`child` のスロットは `person` のスロットより優先されます。
この例では、`baby` を定義する前に `child` と `person` の両方が定義されている必要があることに注意してください。


### クラスの再定義と変更

このセクションでは 2 つの話題を簡単に扱います。

- 既存クラスの再定義。これはコード例を追っている間にすでに行ったかもしれず、開発中には自然に行うことです。
- あるクラスのインスタンスを別のクラスのインスタンスに変えること。CLOS の強力な機能ですが、あまり頻繁には使わないでしょう。

詳細は軽く流します。MOP が公開するメソッドを実装することで、すべて設定可能だと言えば十分です。

クラスを再定義するには、新しい `defclass` フォームを評価するだけです。
それが古い定義の代わりになり、既存のクラスオブジェクトが更新され、**そのクラスのすべてのインスタンス** (および再帰的にそのサブクラス) は **新しい定義を反映するよう遅延更新されます**。
新しい `defclass` 以外を再コンパイルする必要も、オブジェクトを無効化する必要もありません。少し考えてみてください。これはすごいことです!

たとえば、私たちの `person` クラスでは:

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)))

(setf p1 (make-instance 'person :name "me" ))
~~~

スロットの変更、追加、削除...

~~~lisp
(lisper p1)
;; NIL

(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform t        ;; <-- from nil to t
    :accessor lisper)))

(lisper p1)
;; NIL (of course!)

(lisper (make-instance 'person :name "You"))
;; T

(defclass person ()
  ((name
    :initarg :name
    :accessor name)
   (lisper
    :initform nil
    :accessor lisper)
   (age               ;; <-- new slot
    :initarg :arg
    :initform 18      ;; <-- default value
    :accessor age)))

(age p1)
;; => 18。正しい。この新しいスロットのデフォルト initform。

(slot-value p1 'bwarf)
;; => "the slot bwarf is missing from the object #<person…>"

(setf (age p1) 30)
(age p1) ;; => 30

(defclass person ()
  ((name
    :initarg :name
    :accessor name)))

(slot-value p1 'lisper) ;; => slot lisper is missing.
(lisper p1) ;; => there is no applicable method for the generic function lisper when called with arguments #(lisper).
~~~


インスタンスのクラスを変更するには `change-class` を使います。

~~~lisp
(change-class p1 'child)
;; 新しいクラスのスロットも設定できる:
(change-class p1 'child :can-walk-p nil)

(class-of p1)
;; #<STANDARD-CLASS CHILD>

(can-walk-p p1)
;; T
~~~

上の例では、私は `child` になり、デフォルトで真である `can-walk-p` スロットを継承しました。


### 整形して表示する

ここまでオブジェクトを表示するたびに、次のような出力が得られました。

    #<PERSON {1006234593}>

これでは多くを語っていません。

もっと情報を表示したい場合はどうでしょうか。たとえば:

    #<PERSON me lisper: t>

整形表示は、このクラス向けに総称関数 `print-object` のメソッドを特殊化することで行います。

~~~lisp
(defmethod print-object ((obj person) stream)
      (print-unreadable-object (obj stream :type t)
        (with-accessors ((name name)
                         (lisper lisper))
            obj
          (format stream "~a, lisper: ~a" name lisper))))
~~~

これは次を返します。

~~~lisp
p1
;; #<PERSON me, lisper: T>
~~~

`print-unreadable-object` は `#<...>` を出力します。これは、このオブジェクトを reader が読み戻せないことを示します。
`:type t` 引数は、オブジェクト型のプレフィックス、つまり `PERSON` を出力するよう求めます。
これがないと `#<me, lisper: T>` になります。

ここでは `with-accessors` マクロを使いましたが、単純な場合はもちろん次で十分です。

~~~lisp
(defmethod print-object ((obj person) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~a, lisper: ~a" (name obj) (lisper obj))))
~~~

注意: デフォルトで束縛されていないスロットにアクセスしようとするとエラーになります。`slot-boundp` を使ってください。


参考までに、次はデフォルトの挙動を再現します。

~~~lisp
(defmethod print-object ((obj person) stream)
  (print-unreadable-object (obj stream :type t :identity t)))
~~~

ここで `:identity` を `t` にすると `{1006234593}` というアドレスが出力されます。

### 伝統的な Lisp 型のクラス

ここでは、CLOS を使うために CLOS オブジェクトが必要なわけではない、という点に近づきます。

ありがたいことに、前のセクションで紹介した関数は、CLOS インスタンス<u>ではない</u> Lisp オブジェクトにも使えます。

~~~lisp
(find-class 'symbol)
;; #<BUILT-IN-CLASS SYMBOL>
(class-name *)
;; SYMBOL
(eq ** (class-of 'symbol))
;; T
(class-of ***)
;; #<STANDARD-CLASS BUILT-IN-CLASS>
~~~

ここで、シンボルはシステムクラス `symbol` のインスタンスであることがわかります。
これは、対応する Lisp 型と同じ名前のクラスが存在することを言語が要求する 75 個のケースの 1 つです。
これらの多くは CLOS 自体 (たとえば型 `standard-class` と同名の CLOS クラスの対応) またはコンディションシステム (実装によって CLOS クラスで構築されているかもしれないし、そうでないかもしれないもの) に関係しています。
しかし、「伝統的な」Lisp 型に関係する対応が 33 個残っています。

<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
}
th {
  text-align: left;
}
</style>

<table>
  <tbody>
    <tr>
      <td>array</td>
      <td>hash-table</td>
      <td>readtable</td>
    </tr>
    <tr>
      <td>bit-vector</td>
      <td>integer</td>
      <td>real</td>
    </tr>
    <tr>
      <td>broadcast-stream</td>
      <td>list</td>
      <td>sequence</td>
    </tr>
    <tr>
      <td>character</td>
      <td>logical-pathname</td>
      <td>stream</td>
    </tr>
    <tr>
      <td>complex</td>
      <td>null</td>
      <td>string</td>
    </tr>
    <tr>
      <td>concatenated-stream</td>
      <td>number</td>
      <td>string-stream</td>
    </tr>
    <tr>
      <td>cons</td>
      <td>package</td>
      <td>symbol</td>
    </tr>
    <tr>
      <td>echo-stream</td>
      <td>pathname</td>
      <td>synonym-stream</td>
    </tr>
    <tr>
      <td>file-stream</td>
      <td>random-state</td>
      <td>t</td>
    </tr>
    <tr>
      <td>float</td>
      <td>ratio</td>
      <td>two-way-stream</td>
    </tr>
    <tr>
      <td>function</td>
      <td>rational</td>
      <td>vector</td>
    </tr>
  </tbody>
</table>

すべての「伝統的な」Lisp 型がこのリストに含まれるわけではないことに注意してください。
(`atom`、`fixnum`、`short-float`、およびシンボルで表されない型を考えてみてください。)


`t` が存在するのは興味深いことです。
すべての Lisp オブジェクトが型 `t` であるのと同じように、すべての Lisp オブジェクトは `t` という名前のクラスのメンバーでもあります。
これは同時に複数のクラスに属する単純な例であり、後である程度詳しく考える *継承* の問題を持ち出します。

~~~lisp
(find-class t)
;; #<BUILT-IN-CLASS T 20305AEC>
~~~

Lisp 型に対応するクラスに加えて、定義したすべての構造体型にも CLOS クラスがあります。

~~~lisp
(defstruct foo)
FOO

(class-of (make-foo))
;; #<STRUCTURE-CLASS FOO 21DE8714>
~~~

`structure-object` の metaclass はクラス `structure-class` です。
「伝統的な」Lisp オブジェクトの metaclass が `standard-class`、`structure-class`、`built-in-class` のどれであるかは実装依存です。
制約:

`built-in-class`: `make-instance` を使えず、`slot-value` を使えず、`defclass` で変更できず、サブクラスを作成できません。

`structure-class`: `make-instance` は使えません。`slot-value` は動くかもしれません (実装依存)。アプリケーションの structure 型をサブクラス化するには `defstruct` を使います。既存の `structure-class` を変更した結果は未定義です。完全な再コンパイルが必要になるかもしれません。

`standard-class`: これらの制約はありません。

### イントロスペクション

いくつかのイントロスペクション関数はすでに見ました。

最善の選択肢は、[closer-mop](https://github.com/pcostanza/closer-mop) ライブラリを知り、[CLOS & MOP specifications](https://clos-mop.hexstreamsoft.com/) を手元に置いておくことです。

さらに多くの関数:

```
closer-mop:class-default-initargs
closer-mop:class-direct-default-initargs
closer-mop:class-direct-slots
closer-mop:class-direct-subclasses
closer-mop:class-direct-superclasses
closer-mop:class-precedence-list
closer-mop:class-slots
closer-mop:classp
closer-mop:extract-lambda-list
closer-mop:extract-specializer-names
closer-mop:generic-function-argument-precedence-order
closer-mop:generic-function-declarations
closer-mop:generic-function-lambda-list
closer-mop:generic-function-method-class
closer-mop:generic-function-method-combination
closer-mop:generic-function-methods
closer-mop:generic-function-name
closer-mop:method-combination
closer-mop:method-function
closer-mop:method-generic-function
closer-mop:method-lambda-list
closer-mop:method-specializers
closer-mop:slot-definition
closer-mop:slot-definition-allocation
closer-mop:slot-definition-initargs
closer-mop:slot-definition-initform
closer-mop:slot-definition-initfunction
closer-mop:slot-definition-location
closer-mop:slot-definition-name
closer-mop:slot-definition-readers
closer-mop:slot-definition-type
closer-mop:slot-definition-writers
closer-mop:specializer-direct-generic-functions
closer-mop:specializer-direct-methods
closer-mop:standard-accessor-method
```


### 参考

#### Slime によるクラスシンボルの export

コマンド **M-x slime-export-class** は、クラスシンボルをパッケージ定義の ":export" 節に追加します。
これにより、多数のシンボルを一度に export できます。

次のクラスがあるとします。

~~~lisp
(defclass test ()
  ((foo :accessor foo)
   (bar :reader bar)))
~~~

"M-x slime-export-class RET test RET" を使うと、"test"、"foot"、"bar" が export されます。

残念ながら、クラス定義からスロットを削除しても export 節からは削除されません。

これは構造体でも動作します (SBCL と Clozure CL のみ)。


#### defclass/std: クラスを短く書く

[defclass/std](https://github.com/EuAndreh/defclass-std) ライブラリは、より短い `defclass` フォームを書くためのマクロを提供します。

デフォルトでは、スロット定義に accessor、initarg、`nil` への initform を追加します。

これは:

~~~lisp
(defclass/std example ()
  ((slot1 slot2 slot3)))
~~~

次へ展開されます。

~~~lisp
(defclass example ()
  ((slot1
    :accessor slot1
    :initarg :slot1
    :initform nil)
   (slot2
     :accessor slot2
     :initarg :slot2
     :initform nil)
   (slot3
     :accessor slot3
     :initarg :slot3
     :initform nil)))
~~~

これはもっと多くのことができ、非常に柔軟です。
ただし Common Lisp コミュニティではあまり使われていません。自己責任で使ってください。


## メソッド

### まず試す
冒頭の `person` クラスと `child` クラスを思い出してください。

~~~lisp
(defclass person ()
  ((name
    :initarg :name
    :accessor name)))
;; => #<STANDARD-CLASS PERSON>

(defclass child (person)
  ())
;; #<STANDARD-CLASS CHILD>

(setf p1 (make-instance 'person :name "me"))
(setf c1 (make-instance 'child :name "Alice"))
~~~

以下ではメソッドを作成し、特殊化し、メソッド結合 (before, after, around) と修飾子を使います。

~~~lisp
(defmethod greet (obj)
  (format t "Are you a person ? You are a ~a.~&" (type-of obj)))
;; style-warning: Implicitly creating new generic function common-lisp-user::greet.
;; #<STANDARD-METHOD GREET (t) {1008EE4603}>

(greet :anything)
;; Are you a person ? You are a KEYWORD.
;; NIL
(greet p1)
;; Are you a person ? You are a PERSON.

(defgeneric greet (obj)
  (:documentation "say hello"))
;; STYLE-WARNING: redefining COMMON-LISP-USER::GREET in DEFGENERIC
;; #<STANDARD-GENERIC-FUNCTION GREET (2)>

(defmethod greet ((obj person))
  (format t "Hello ~a !~&" (name obj)))
;; #<STANDARD-METHOD GREET (PERSON) {1007C26743}>

(greet p1) ;; => "Hello me !"
(greet c1) ;; => "Hello Alice !"

(defmethod greet ((obj child))
  (format t "ur so cute~&"))
;; #<STANDARD-METHOD GREET (CHILD) {1008F3C1C3}>

(greet p1) ;; => "Hello me !"
(greet c1) ;; => "ur so cute"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Method combination: before, after, around.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod greet :before ((obj person))
  (format t "-- before person~&"))
#<STANDARD-METHOD GREET :BEFORE (PERSON) {100C94A013}>

(greet p1)
;; -- before person
;; Hello me

(defmethod greet :before ((obj child))
  (format t "-- before child~&"))
;; #<STANDARD-METHOD GREET :BEFORE (CHILD) {100AD32A43}>
(greet c1)
;; -- before child
;; -- before person
;; ur so cute

(defmethod greet :after ((obj person))
  (format t "-- after person~&"))
;; #<STANDARD-METHOD GREET :AFTER (PERSON) {100CA2E1A3}>
(greet p1)
;; -- before person
;; Hello me
;; -- after person

(defmethod greet :after ((obj child))
  (format t "-- after child~&"))
;; #<STANDARD-METHOD GREET :AFTER (CHILD) {10075B71F3}>
(greet c1)
;; -- before child
;; -- before person
;; ur so cute
;; -- after person
;; -- after child

(defmethod greet :around ((obj child))
  (format t "Hello my dear~&"))
;; #<STANDARD-METHOD GREET :AROUND (CHILD) {10076658E3}>
(greet c1) ;; Hello my dear


;; call-next-method

(defmethod greet :around ((obj child))
  (format t "Hello my dear~&")
  (when (next-method-p)
    (call-next-method)))
;; #<standard-method greet :around (child) {100AF76863}>

(greet c1)
;; Hello my dear
;; -- before child
;; -- before person
;; ur so cute
;; -- after person
;; -- after child

;;;;;;;;;;;;;;;;;
;; &key の追加
;;;;;;;;;;;;;;;;;

;; generic method に "&key" を追加するには、まずその定義を削除する必要がある。
(fmakunbound 'greet)  ;; Slime では: C-c C-u (slime-undefine-function)
(defmethod greet ((obj person) &key talkative)
  (format t "Hello ~a~&" (name obj))
  (when talkative
    (format t "blah")))

(defgeneric greet (obj &key &allow-other-keys)
  (:documentation "say hi"))

(defmethod greet (obj &key &allow-other-keys)
  (format t "Are you a person ? You are a ~a.~&" (type-of obj)))

(defmethod greet ((obj person) &key talkative &allow-other-keys)
  (format t "Hello ~a !~&" (name obj))
  (when talkative
    (format t "blah")))

(greet p1 :talkative t) ;; ok
(greet p1 :foo t) ;; これも ok


;;;;;;;;;;;;;;;;;;;;;;;

(defgeneric greet (obj)
  (:documentation "say hello")
  (:method (obj)
    (format t "Are you a person ? You are a ~a~&." (type-of obj)))
  (:method ((obj person))
    (format t "Hello ~a !~&" (name obj)))
  (:method ((obj child))
    (format t "ur so cute~&")))

;;;;;;;;;;;;;;;;
;;; Specializers
;;;;;;;;;;;;;;;;

(defgeneric feed (obj meal-type)
  (:method (obj meal-type)
    (declare (ignorable meal-type))
    (format t "eating~&")))

(defmethod feed (obj (meal-type (eql :dessert)))
    (declare (ignorable meal-type))
    (format t "mmh, dessert !~&"))

(feed c1 :dessert)
;; mmh, dessert !

(defmethod feed ((obj child) (meal-type (eql :soup)))
    (declare (ignorable meal-type))
    (format t "bwark~&"))

(feed p1 :soup)
;; eating
(feed c1 :soup)
;; bwark
~~~


### Generic function (defgeneric, defmethod)

`総称関数` は、一連のメソッドと関連付けられ、呼び出されたときにそれらをディスパッチする Lisp 関数です。
同じ関数名を持つすべてのメソッドは、同じ総称関数に属します。

`defmethod` フォームは `defun` に似ています。
コード本体を関数名に関連付けますが、その本体は、引数の型がラムダリストで宣言されたパターンに一致する場合にだけ実行されます。

省略可能な引数、キーワード引数、`&rest` 引数を持てます。

`defgeneric` フォームは generic 関数を定義します。
対応する `defgeneric` なしで `defmethod` を書くと、generic 関数が自動的に作成されます (例を参照)。

一般に `defgeneric` を書くのはよい考えです。
デフォルト実装やドキュメントを追加できます。

~~~lisp
(defgeneric greet (obj)
  (:documentation "says hi")
  (:method (obj)
    (format t "Hi")))
~~~

メソッドのラムダリストの必須パラメータは、次の 3 つの形式のいずれかを取れます。

1- 単純な変数:

~~~lisp
(defmethod greet (foo)
  ...)
~~~

このメソッドは任意の引数を取れ、常に適用可能です。

変数 `foo` は通常どおり対応する引数値に束縛されます。

2- 変数と **特定化子（specializer）**。例:

~~~lisp
(defmethod greet ((foo person))
  ...)
~~~

この場合、変数 `foo` は、その引数が特定化子のクラス `person` *またはそのサブクラス* (`child` など) である場合にのみ、対応する引数に束縛されます (実際、"child" も "person" です)。

いずれかの引数がその特定化子に一致しない場合、そのメソッドは *適用可能* ではなく、それらの引数では実行できません。
「総称関数 xxx を引数 yyy で呼び出したとき、適用可能なメソッドがありません」のようなエラーメッセージが出ます。

**特殊化できるのは必須パラメータだけです**。省略可能な引数や `&key` 引数では特殊化できません。


3- 変数と **eql 特定化子**

~~~lisp
(defmethod feed ((obj child) (meal-type (eql :soup)))
    (declare (ignorable meal-type))
    (format t "bwark~&"))

(feed c1 :soup)
;; "bwark"
~~~

単純なシンボル (`:soup`) の代わりに、eql 特定化子には任意の Lisp フォームを使えます。
これは defmethod と同じタイミングで評価されます。

ラムダリストの形式が総称関数の形と *合同（congruent）* である限り、同じ関数名で特定化子の異なるメソッドをいくつでも定義できます。
システムは最も *特定的* な適用可能メソッドを選び、その本体を実行します。
最も特定的なメソッドとは、特定化子が引数の `class-precedence-list` の先頭に最も近いものです (ラムダリストの左側にあるクラスほど特定的です)。
特定化子を持つメソッドは、何も持たないメソッドより特定的です。


**注意:**

-   通常の関数と同じ関数名でメソッドを定義するのはエラーです。本当にそうしたい場合はシャドーイングの機構を使ってください。

-   既存の総称メソッドのラムダリストに `keys` や `rest` 引数を追加または削除するには、`fmakunbound` (または Slime で関数上にカーソルを置いて `C-c C-u` (slime-undefine-function)) で宣言を削除し、やり直す必要があります。そうしないと次のようになります。

```
attempt to add the method
  #<STANDARD-METHOD NIL (#<STANDARD-CLASS CHILD>) {1009504233}>
to the generic function
  #<STANDARD-GENERIC-FUNCTION GREET (2)>;
but the method and generic function differ in whether they accept
&REST or &KEY arguments.
```

-   メソッドは再定義できます (通常の関数とまったく同じです)。

-   メソッドが定義される順序は関係ありません。ただし、特殊化の対象になるクラスはすでに存在している必要があります。

-   特殊化されていない引数は、だいたいクラス `t` に特殊化されていることと同等です。唯一の違いは、すべての特殊化された引数は暗黙に「参照された」ものとみなされることです (`declare ignore` の意味で)。

-   各 `defmethod` フォームは、クラス `standard-method` の CLOS インスタンスを生成し、返します。

- `eql` 特定化子は文字列ではそのまま動きません。実際、文字列の比較には `equal` または `equalp` が必要です。ただし、文字列を変数に代入し、その変数を `eql` 特定化子と関数呼び出しの両方で使えます。

- 同じ関数名を持つすべてのメソッドは同じ総称関数に属します。

- `defclass` で定義されたすべてのスロット accessor と reader はメソッドです。同じ総称関数上の他のメソッドを上書きしたり、上書きされたりできます。


[defmethod on the CLHS](http://www.lispworks.com/documentation/lw70/CLHS/Body/m_defmet.htm) も参照してください。

### マルチメソッド

マルチメソッドは、総称関数の必須パラメータを複数明示的に特殊化します。

それらは特定のクラスに属しません。
つまり、他の言語で必要になるかもしれないように、このメソッドを置くのに最適なクラスを決める必要はありません。

~~~lisp
(defgeneric hug (a b)
   (:documentation "Hug between two persons."))
;; #<STANDARD-GENERIC-FUNCTION HUG (0)>

(defmethod hug ((a person) (b person))
  :person-person-hug)

(defmethod hug ((a person) (b child))
  :person-child-hug)
~~~

詳しくは [Practical Common Lisp](http://www.gigamonkeys.com/book/object-reorientation-generic-functions.html#multimethods) を読んでください。

[​]{#setter--setf-ing-methods}

### セッターの制御 (setf するメソッド)

Lisp では、関数やメソッドに対応する `setf` 版を定義できます。
これは、オブジェクトの更新方法をより細かく制御したい場合に使えます。

~~~lisp
(defmethod (setf name) (new-val (obj person))
  (if (equalp new-val "james bond")
    (format t "Dude that's not possible.~&")
    (setf (slot-value obj 'name) new-val)))

(setf (name p1) "james bond") ;; -> no rename
~~~

Python を知っているなら、この挙動は `@property` デコレータで提供されるものです。


[​]{#dispatch--next-method}

### ディスパッチ機構と次のメソッド


総称関数が呼び出されたとき、アプリケーションがメソッドを直接呼び出すことはできません。
ディスパッチ機構は次のように進みます。

1.  適用可能なメソッドのリストを計算する
2.  適用可能なメソッドがなければエラーを通知する
3.  適用可能なメソッドを特定性の順にソートする
4.  最も特定的なメソッドを呼び出す

私たちの `greet` 総称関数には 3 つの適用可能メソッドがあります。

~~~lisp
(closer-mop:generic-function-methods #'greet)
(#<STANDARD-METHOD GREET (CHILD) {10098406A3}>
 #<STANDARD-METHOD GREET (PERSON) {1009008EC3}>
 #<STANDARD-METHOD GREET (T) {1008E6EBB3}>)
~~~

メソッドの実行中、残りの適用可能メソッドには *ローカル関数* `call-next-method` を介してアクセスできます。
この関数はメソッド本体内でレキシカルスコープを持ちますが、無期限のエクステントを持ちます。
次に特定的なメソッドを呼び出し、そのメソッドが返した値をそのまま返します。
次のいずれかで呼び出せます。

*   引数なし。この場合、*次のメソッド* はこのメソッドとまったく同じ引数を受け取ります。

*   明示的な引数。この場合、新しい引数に適用可能なメソッドのソート済み集合が、総称関数が最初に呼ばれたときに計算されたものと同じでなければなりません。

例:

~~~lisp
(defmethod greet ((obj child))
  (format t "ur so cute~&")
  (when (next-method-p)
    (call-next-method)))
;; STYLE-WARNING: REDEFINING GREET (#<STANDARD-CLASS CHILD>) in DEFMETHOD
;; #<STANDARD-METHOD GREET (child) {1003D3DB43}>

(greet c1)
;; ur so cute
;; Hello Alice !
~~~

後続のメソッドがないときに `call-next-method` を呼び出すと、エラーが通知されます。
next メソッドが存在するかどうかは、local 関数 `next-method-p` を呼び出して調べられます (これもレキシカルスコープと indefinite extent を持ちます)。

最後に、すべてのメソッド本体は、そのメソッドの generic 関数と同じ名前の block を確立することに注意してください。
その名前に対して `return-from` すると、囲んでいる generic 関数の呼び出しではなく、現在のメソッドから抜けます。


[​]{#qualifiers-and-method-combination}

### Method qualifier (before, after, around)

「まず試す」の例で、`:before`、`:after`、`:around` *qualifier* の使い方をいくつか見ました。

- `(defmethod foo :before (obj) (...))`
- `(defmethod foo :after (obj) (...))`
- `(defmethod foo :around (obj) (...))`

CLOS が提供する *standard メソッド combination* フレームワークでは、デフォルトでこれら 3 つの qualifier のどれか 1 つだけを使えます。
制御の流れは次のとおりです。

- **before-method** は、文字どおり applicable な primary メソッドの前に呼ばれます。before-method が複数ある場合は **すべて** 呼ばれます。最も specific な before-method が最初に呼ばれます (person より child が先)。
- 最も specific な applicable **primary method** (qualifier のないメソッド) が呼ばれます (1 つだけ)。
- applicable な **after-method** がすべて呼ばれます。最も specific なものは *最後* に呼ばれます (person の after-method、その後 child の after-method)。

**generic 関数は primary メソッドの値を返します**。
before メソッドや after メソッドの値は無視されます。
それらは副作用のために使われます。

そして **around-method** があります。
これは、ここまで説明した中核機構を包むラッパーです。
返り値を捕まえたり、プライマリメソッドの周囲に環境を用意したりするのに便利です (catch、lock、実行時間計測など)。

ディスパッチ機構が around-method を見つけると、それを呼び出して結果を返します。
around-method に `call-next-method` があれば、次に適用可能な around-method を呼び出します。
プライマリメソッドに到達して初めて、before-method と after-method の呼び出しを始めます。

したがって、総称関数の完全なディスパッチ機構は次のようになります。

1.  適用可能なメソッドを計算し、修飾子に従って別々のリストへ分ける。
2.  適用可能なプライマリメソッドがなければエラーを通知する。
3.  各リストを特定性の順にソートする。
4.  最も特定的な `:around` メソッドを実行し、それが返すものを返す。
5.  `:around` メソッドが `call-next-method` を呼び出した場合、次に特定的な `:around` メソッドを実行する。
6.  最初から `:around` メソッドがなかった場合、または `:around` メソッドが `call-next-method` を呼び出したが、呼び出すべき後続の `:around` メソッドがない場合、次のように進む。

    a.  すべての `:before` メソッドを順に実行する。返り値は無視し、`call-next-method` や `next-method-p` の呼び出しは許可しない。

    b.  最も特定的なプライマリメソッドを実行し、それが返すものを返す。

    c.  プライマリメソッドが `call-next-method` を呼び出した場合、次に特定的なプライマリメソッドを実行する。

d.  プライマリメソッドが `call-next-method` を呼び出したものの、呼び出すべき後続のプライマリメソッドがない場合はエラーを通知する。

    e.  プライマリメソッドの完了後、すべての `:after` メソッドを **<u>逆</u>** 順で実行する。返り値は無視し、`call-next-method` や `next-method-p` の呼び出しは許可しない。

玉ねぎのように考えるとよいでしょう。最も外側の層にすべての `:around` メソッドがあり、中間層に `:before` と `:after` メソッドがあり、内側にプライマリメソッドがあります。


[​]{#method-combination}

### その他のメソッド結合

先ほど見たデフォルトのメソッド結合の種類は `standard` という名前ですが、他のメソッド結合の種類も利用でき、もちろん自分で定義することもできます。

組み込み型は次のとおりです。

    progn + list nconc and max or append min

これらの型は Lisp のオペレータにちなんで名付けられていることに気づくでしょう。
実際、それらが行うのは、その名前の Lisp オペレータ呼び出しの内側で適用可能なプライマリメソッドを結合するフレームワークを定義することです。
たとえば、`progn` の結合の種類を使うことは、**すべての** プライマリメソッドを順に呼び出すことと同等です。

~~~lisp
(progn
  (method-1 args)
  (method-2 args)
  (method-3 args))
~~~

ここでは standard 機構と異なり、与えられたオブジェクトに適用可能なすべてのプライマリメソッドが、最も特定的なものから呼び出されます。

結合の種類を変更するには、`defgeneric` の `:method-combination` オプションを設定し、それをメソッドの修飾子として使います。

~~~lisp
(defgeneric foo (obj)
  (:method-combination progn))

(defmethod foo progn ((obj obj))
   (...))
~~~

**progn** の例:

~~~lisp
(defgeneric dishes (obj)
   (:method-combination progn)
   (:method progn (obj)
     (format t "- clean and dry.~&"))
   (:method progn ((obj person))
     (format t "- bring a person's dishes~&"))
   (:method progn ((obj child))
     (format t "- bring the baby dishes~&")))
;; #<STANDARD-GENERIC-FUNCTION DISHES (3)>

(dishes c1)
;; - bring the baby dishes
;; - bring a person's dishes
;; - clean and dry.

(greet c1)
;; ur so cute  --> 最も applicable なメソッドだけが呼ばれた。
~~~

同様に、`list` 型を使うことは、メソッドの値のリストを返すことと同等です。

~~~lisp
(list
  (method-1 args)
  (method-2 args)
  (method-3 args))
~~~

~~~lisp
(defgeneric tidy (obj)
  (:method-combination list)
  (:method list (obj)
    :foo)
  (:method list ((obj person))
    :books)
  (:method list ((obj child))
    :toys))
;; #<STANDARD-GENERIC-FUNCTION TIDY (3)>

(tidy c1)
;; (:toys :books :foo)
~~~

**Around method** は受け付けられます。

~~~lisp
(defmethod tidy :around (obj)
   (let ((res (call-next-method)))
     (format t "I'm going to clean up ~a~&" res)
     (when (> (length res)
              1)
       (format t "that's too much !~&"))))

(tidy c1)
;; I'm going to clean up (toys book foo)
;; that's too much !
~~~

これらのオペレータは `before`、`after`、`around` メソッドをサポートしないことに注意してください (実際、それらを入れる余地がもうありません)。
around メソッドはサポートされ、そこでは `call-next-method` が許可されますが、プライマリメソッド内で `call-next-method` を呼び出すことはサポートされません。
すべてのプライマリメソッドが呼ばれるため、それは冗長ですし、あるものを *呼ばない* ほうがぎこちなくなります。

CLOS では、Lisp 関数、マクロ、special form のいずれであっても、新しいオペレータをメソッド結合の種類として定義できます。
必要を感じたら、書籍を参照してください。

[​]{#method-combination--trace}

### デバッグ: メソッド結合のトレース

メソッド結合を [トレース](http://www.xach.com/clhs?q=trace) することは可能ですが、これは実装依存です。

SBCL では `(trace foo :methods t)` を使えます。[SBCL のコア開発者によるこの記事](http://christophe.rhodes.io/notes/blog/posts/2018/sbcl_method_tracing/) を参照してください。

たとえば、次の総称関数があるとします。

~~~lisp
(defgeneric foo (x)
  (:method (x) 3))
(defmethod foo :around ((x fixnum))
  (1+ (call-next-method)))
(defmethod foo ((x integer))
  (* 2 (call-next-method)))
(defmethod foo ((x float))
  (* 3 (call-next-method)))
(defmethod foo :before ((x single-float))
  'single)
(defmethod foo :after ((x double-float))
 'double)
~~~

これをトレースします。

~~~lisp
(trace foo :methods t)

(foo 2.0d0)
  0: (FOO 2.0d0)
    1: ((SB-PCL::COMBINED-METHOD FOO) 2.0d0)
      2: ((METHOD FOO (FLOAT)) 2.0d0)
        3: ((METHOD FOO (T)) 2.0d0)
        3: (METHOD FOO (T)) returned 3
      2: (METHOD FOO (FLOAT)) returned 9
      2: ((METHOD FOO :AFTER (DOUBLE-FLOAT)) 2.0d0)
      2: (METHOD FOO :AFTER (DOUBLE-FLOAT)) returned DOUBLE
    1: (SB-PCL::COMBINED-METHOD FOO) returned 9
  0: FOO returned 9
9
~~~

### defgeneric と defmethod の違い: 再定義

`defgeneric` 本体の中でメソッドを宣言する場合と、複数の `defmethod` を書く場合には違いがあります。
この 2 つの方法は、メソッドの再定義を異なる形で扱います。
`defgeneric` は、本体内にもう存在しないメソッドを削除します。

以下では、`person` と `child` に特殊化した 2 つの `defmethod` を使って、新しい generic 関数を定義します。

~~~lisp
(defmethod goodbye ((p person))
  (format t "goodbye ~a.~&" (name p)))

(defmethod goodbye ((c child))
  (format t "love you lil' one <3~&"))
~~~

`(goodbye (make-instance 'person :name "you"))` で試せます。

さて、作業セッションの後半で、`child` に特殊化したものはもう不要だと判断したとします。
そのソースコードを削除します。
しかし、**そのメソッドはまだ image 内に存在します**。
下で見るように、プログラム的にメソッドを削除する必要があります。

`defgeneric` を使っていれば、すべてのメソッドは更新、追加、削除されていたでしょう。
すでに 3 つのメソッドを持つ `tidy` generic 関数を定義しました。

~~~lisp
(defgeneric tidy (obj)
  (:method-combination list)
  (:method list (obj)
    :foo)
  (:method list ((obj person))
    :books)
  (:method list ((obj child))
    :toys))
~~~

これは person や child など任意のオブジェクト型で動作します。
文字列で試してください: `(tidy "tidy what?")`。動作します。

次に、この宣言を `defgeneric` から削除します。


~~~lisp
(defgeneric tidy (obj)
  (:method-combination list)
  ;;(:method list (obj)  ;; <--- commented out
  ;;  :foo)
  (:method list ((obj person))
    :books)
  (:method list ((obj child))
    :toys))
~~~

もう一度呼び出してみると、"no applicable method" エラーが出ます。

```
There is no applicable method for the generic function
  #<STANDARD-GENERIC-FUNCTION TRADESIGNAL::TIDY (2)>
when called with arguments
  ("tidy what?").
```

開発中にこれが重要かどうかは場合によりますが、知っておくと Lisp image をソースコードと同期した状態に保つ助けになります。
そうでなければ、古いメソッドが邪魔になったときに削除できます。

### メソッドの削除

まず、メソッドオブジェクトを探す必要があります。

~~~lisp
(find-method #'goodbye nil (list (find-class 'child)))
;; => #<STANDARD-METHOD GOODBYE (CHILD) {10073EFD73}>
~~~

`find-method` は引数として、関数参照、qualifier (before、after、around など)、クラス specializer のリストを取ります。

メソッドが見つかったら、`remove-method` を使います。

`(fmakunbound 'goodbye)` を使うこともできますが、これは *すべての* メソッドを unbound にします。


## MOP

ここでは、メタオブジェクトプロトコルが提供するフレームワークを使う例をいくつか集めます。
これは Lisp のオブジェクトシステムを支配する、設定可能なオブジェクトシステムです。
高度な概念に触れるので、初めて読む人も心配しないでください。
Common Lisp Object System を使い始めるために、このセクションを理解する必要はありません。

ここでは MOP について多くは説明しませんが、その可能性が見えたり、一部の CL ライブラリがどのように作られているかを理解する助けになる程度には説明できればと思います。
導入部で参照した書籍を読むことをおすすめします。


### メタクラス

メタクラスは他のクラスの挙動を制御するために必要です。

*予告したとおり、ここでは多くを語りません。[metaclasses](https://en.wikipedia.org/wiki/Metaclass) や [CLOS](https://en.wikipedia.org/wiki/Common_Lisp_Object_System) については Wikipedia も参照してください*。

標準のメタクラスは `standard-class` です。

~~~lisp
(class-of p1) ;; #<STANDARD-CLASS PERSON>
~~~

しかし、これを自分たちのものに変更し、**インスタンスの作成を数えられる** ようにします。
同じ仕組みは、データベースシステムの主キーを自動インクリメントするため (Postmodern や Mito ライブラリはこのようにしています)、オブジェクト作成をログに記録するため、などに使えます。

私たちのメタクラスは `standard-class` を継承します。

~~~lisp
(defclass counted-class (standard-class)
  ((counter :initform 0)))
#<STANDARD-CLASS COUNTED-CLASS>

(unintern 'person)
;; person の metaclass を変更するために必要。
;; または (setf (find-class 'person) nil)
;; https://stackoverflow.com/questions/38811931/how-to-change-classs-metaclass#38812140

(defclass person ()
  ((name
    :initarg :name
    :accessor name))
  (:metaclass counted-class)) ;; <- metaclass
;; #<COUNTED-CLASS PERSON>
;;   ^^^ もう standard-class ではない。
~~~

`:metaclass` クラスオプションは 1 回だけ現れます。

実際には、`validate-superclass` を実装するよう求めるメッセージが出たはずです。
そこで、引き続き `closer-mop` ライブラリを使います。

~~~lisp
(defmethod closer-mop:validate-superclass ((class counted-class)
                                           (superclass standard-class))
  t)
~~~

これで新しい `person` インスタンスの作成を制御できます。

~~~lisp
(defmethod make-instance :after ((class counted-class) &key)
  (incf (slot-value class 'counter)))
;; #<STANDARD-METHOD MAKE-INSTANCE :AFTER (COUNTED-CLASS) {1007718473}>
~~~

`:after` qualifier が最も安全な選択であることに注目してください。
標準メソッドを通常どおり実行させ、新しいインスタンスを返させます。

`&key` は必要です。`make-instance` には initarg が渡されることを思い出してください。

ではテストします。

~~~lisp
(defvar p3 (make-instance 'person :name "adam"))
#<PERSON {1007A8F5B3}>

(slot-value p3 'counter)
;; => error。新しいスロットは person クラス上にはない。
(slot-value (find-class 'person) 'counter)
;; 1

(make-instance 'person :name "eve")
;; #<PERSON {1007AD5773}>
(slot-value (find-class 'person) 'counter)
;; 2
~~~

動作しています。


### インスタンス初期化の制御 (initialize-instance)

オブジェクトインスタンスの作成をさらに制御するには、`initialize-instance` メソッドを特殊化できます。
これは `make-instance` によって、新しいインスタンスが作成された直後、ただしデフォルトの initarg と initform でまだ初期化されていない時点で呼び出されます。

primary メソッドを作るとスロットの初期化を妨げるため、after メソッドを作ることが推奨されています (Keene)。

~~~lisp
(defmethod initialize-instance :after ((obj person) &key)
;; arglist の &key に注意:                    ^^^^
  (do something with obj))
~~~

典型的な例は初期値の検証です。
ここでは person の名前が 3 文字より長いことをチェックします。

~~~lisp
(defmethod initialize-instance :after ((obj person) &key)
  (with-slots (name) obj
    (assert (>= (length name) 3))))
~~~

そのため、この呼び出しはもう動きません。

~~~lisp
(make-instance 'person :name "me")
;; The assertion (>= #1=(LENGTH NAME) 3) failed with #1# = 2.
;;   [Condition of type SIMPLE-ERROR]
~~~

対話的デバッガに入り、リスタート (continue、retry、abort) の選択肢が提示されます。

ついでに、デバッガの機能を使って "name" を変更する選択肢を提供するアサーションを示します。
デバッガから変更できる場所のリストを `assert` に渡します。

~~~lisp
(defmethod INITIALIZE-INSTANCE :after ((obj person) &key)
  (with-slots (name) obj
    (assert (>= (length name) 3)
            (name)  ;; <-- place のリスト
            "The value of name is ~a. It should be longer than 3 characters." name)))
~~~

次のようになります。

```
The value of name is me. It should be longer than 3 characters.
   [Condition of type SIMPLE-ERROR]

Restarts:
 0: [CONTINUE] Retry assertion with new value for NAME.
                               ^^^^^^^^^^^^ 新しい restart
 1: [RETRY] Retry SLIME REPL evaluation request.
 2: [*ABORT] Return to SLIME's top level.
```


別の説明です。CLOS の `make-instance` 実装は 2 段階です。
新しいオブジェクトを割り当て、それからそのオブジェクトとすべての `make-instance` キーワード引数を generic 関数 `initialize-instance` に渡します。
実装者やアプリケーション作者は、インスタンスのスロットを初期化するために `initialize-instance` 上に `:after` メソッドを定義します。
システムが提供する primary メソッドは、(a) クラス定義時に与えられた `:initform` と `:initarg` の値、および (b) `make-instance` から渡されたキーワードに関してこれを行います。
他のメソッドは必要に応じてこの挙動を拡張できます。
たとえば、特定のスロットを埋めるためのデータベースアクセスを呼び出す追加キーワードを受け付けるかもしれません。
`initialize-instance` のラムダリストは次のとおりです。

~~~
initialize-instance instance &rest initargs &key &allow-other-keys
~~~

### インスタンス更新の制御 (update-instance-for-redefined-class)

座標と直径を持つ "circle" クラスを作ったとします。
後で、直径を半径に置き換えることにしました。
既存のすべてのオブジェクトを賢く更新したいとします。
半径は直径の値を 2 で割った値になるべきです。
`update-instance-for-redefined-class` を使います。

そのパラメータは次のとおりです。

- instance: 更新中のオブジェクトインスタンス
- added-slots: 追加されたスロットのリスト
- discarded-slots: 破棄されたスロットのリスト
- property-list: 元のインスタンスで値を持っていたすべての discarded-slots のスロット名と値を捕捉した plist
- initargs: 初期化引数リスト。下では `&key` がそれらを受け取ります。

そしてオブジェクトを返します。

実際にはこのメソッドを直接呼ぶのではなく、`:before` メソッドを使います。

~~~lisp
(defmethod update-instance-for-redefined-class
    :before ((obj circle) added deleted plist-values &key)
  (format t "plist values: ~a~&" plist-values)
  (let ((diameter (getf plist-values 'diameter)))
    (setf (radius obj) (/ diameter 2))))
~~~

試し方は次のとおりです。`circle` クラスから始めます。

~~~lisp
(defclass circle ()
  ((diameter :accessor diameter :initform 9)))
~~~

そして circle オブジェクトを作成します。

~~~lisp
(make-instance 'circle)
~~~

それを inspect するか、diameter の値を確認します。

次に新しいクラス定義を書いてコンパイルします。

~~~lisp
(defclass circle ()
  ((radius :accessor radius)))
~~~

まだ何も起こらず、"plist values" の print 出力は見えません。

そのオブジェクトを inspect するか `describe` してください。そこで更新され、`radius` スロットが見つかります。

既存オブジェクトは遅延更新されます。

詳しくは [HyperSpec](https://www.lispworks.com/documentation/HyperSpec/Body/f_upda_1.htm) または [Community Spec](https://cl-community-spec.github.io/pages/update_002dinstance_002dfor_002dredefined_002dclass.html) を参照してください。

### 新しいクラスへのインスタンス更新の制御 (update-instance-for-different-class)

今度は `circle` クラスで作業しているが、必要なのは `surface` 種のオブジェクトだけだと気づいたとします。
circle クラスを完全に捨てる一方で、既存オブジェクトをこの新しいクラスへ更新し、新しいスロットを賢く計算したいとします。
`update-instance-for-different-class` を使います。

詳しくは [HyperSpec](https://www.lispworks.com/documentation/HyperSpec/Body/f_update.htm) または [Community Spec](https://cl-community-spec.github.io/pages/update_002dinstance_002dfor_002ddifferent_002dclass.html) を参照してください。

### qualifier と型に一致するメソッドを探す

指定した *qualifier* の集合 (`:around` メソッドなど) と、より重要な *specializer* (そのメソッドが dispatch する型) を持つメソッドが存在するかを確認したいとします。

たとえば、この章では `person` オブジェクト向けに `print-object` メソッドを特殊化しました。

```lisp
(defmethod print-object ((obj person) stream)
```

今、イントロスペクションを使うプログラムで、そのような関数が存在するかを確認し、その参照を取得したいとします。

`find-method` を使います。

~~~lisp
(find-method #'print-object nil '(person t))
;;          ^^^ シンボルだけでなく関数オブジェクト
;; => <STANDARD-METHOD COMMON-LISP:PRINT-OBJECT (PERSON T) {1204FA0B83}>
~~~

第 1 引数 `nil` は qualifier のリストです。
`:around`、`:before`、`:after` メソッドには関心がないので `nil` のままにします。
リストとして `'(:around)` を使うこともできます。

第 2 引数はメソッド引数の型のリストです。
`print-object` は person とストリームの 2 つの引数を取ります。
generic 関数への参照を得るには `'(t t)` を使えます。
person と任意のストリームに特殊化したメソッドへの参照を得るには `'(person t)` を使います。

そのようなメソッドが存在しない場合、`find-method` はエラーを通知します。

```
There is no method on
#<STANDARD-GENERIC-FUNCTION COMMON-LISP::PRINT-OBJECT (1)> with no
qualifiers and specializers
(… …)
condition of type simple-error
```

最後の optional 引数 `errorp` を `nil` に設定しない限り、そうなります。


### 最後に

さらに多くのことは書籍を参照してください!
 
#  型システム {#chapter-type}
 

Common Lisp には完全で柔軟な型システムと、それに対応する型を調査・検査・操作するツールがあります。独自の型を作成し、変数や関数に型宣言を追加し、それによってコンパイル時の警告やエラーを得られます。


## 型を持つのは値であり、変数ではない

C/C++ のような一部の言語とは異なり、Lisp の変数はオブジェクト[^1] のための *置き場所* にすぎません。変数に [`setf`][setf] すると、オブジェクトがそこに「置かれ」ます。後で同じ変数に別の値を好きなように置けます。

これは、Common Lisp では **オブジェクトが型を持つ** のであり、変数は型を持たない、という事実を意味します。C/C++ の背景から来た場合、最初は驚くかもしれません。

例:

~~~lisp
(defvar *var* 1234)
*VAR*

(type-of *var*)
(INTEGER 0 4611686018427387903)
~~~

関数 [`type-of`][type-of] は、与えられたオブジェクトの型を返します。返される結果は[型指定子][type-specifiers]です。この場合、最初の要素が型で、残りはその型の追加情報（下限と上限）です。今のところ安全に無視できます。また、Lisp の整数には制限がないことも覚えておいてください。

では変数に [`setf`][setf] してみましょう。

~~~lisp
* (setf *var* "hello")
"hello"

* (type-of *var*)
(SIMPLE-ARRAY CHARACTER (5))
~~~

`type-of` が異なる結果を返すことが分かります。長さ 5 で内容の型が [`character`][character] の [`simple-array`][simple-array] です。これは、`*var*` が文字列 `"hello"` に評価され、関数 `type-of` が実際には変数 `*var*` ではなくオブジェクト `"hello"` の型を返すためです。

## 型階層

Lisp の型の継承関係は型のグラフから成り、すべての型の根は `T` です。例:

~~~lisp
* (describe 'integer)
COMMON-LISP:INTEGER
  [symbol]

INTEGER names the built-in-class #<BUILT-IN-CLASS COMMON-LISP:INTEGER>:
  Class precedence-list: INTEGER, RATIONAL, REAL, NUMBER, T
  Direct superclasses: RATIONAL
  Direct subclasses: FIXNUM, BIGNUM
  No direct slots.

INTEGER names a primitive type-specifier:
  Lambda-list: (&OPTIONAL (SB-KERNEL::LOW '*) (SB-KERNEL::HIGH '*))
~~~

関数 [`describe`][describe] は、シンボル [`integer`][integer] が追加情報として下限と上限を持つ基本型指定子であることを示します。同時に、これは組み込みクラスでもあります。なぜでしょうか。

多くの Common Lisp の型は CLOS クラスとして実装されています。一部の型は他の型の単なる「ラッパー」です。各 CLOS クラスは対応する型に対応づけられます。Lisp では、型は [`型指定子`][type-specifiers] の使用によって間接的に参照されます。

関数 [`type-of`][type-of] と [`class-of`][class-of] にはいくつか違いがあります。`type-of` は与えられたオブジェクトの型を型指定子の形式で返す一方、`class-of` は実装の詳細を返します。

~~~lisp
* (type-of 1234)
(INTEGER 0 4611686018427387903)

* (class-of 1234)
#<BUILT-IN-CLASS COMMON-LISP:FIXNUM>
~~~

## 型の検査

関数 [`typep`][typep] は、第 1 引数が第 2 引数で指定された型であるかを検査するために使えます。

~~~lisp
* (typep 1234 'integer)
T
~~~

関数 [`subtypep`][subtypep] は、ある型が別の型を継承しているかを調べるために使えます。2 つの値を返します。

- `T, T` は、第 1 引数が第 2 引数の派生型であることを意味します。
- `NIL, T` は、第 1 引数が第 2 引数の派生型 *ではない* ことを意味します。
- `NIL, NIL` は「判定できない」ことを意味します。

例:

~~~lisp
* (subtypep 'integer 'number)
T
T

* (subtypep 'string 'number)
NIL
T
~~~

引数の型に応じて異なる動作を行いたいことがあります。マクロ [`typecase`][typecase] が役に立ちます。

~~~lisp
* (defun plus1 (arg)
    (typecase arg
      (integer (+ arg 1))
      (string (concatenate 'string arg "1"))
      (t 'error)))
PLUS1

* (plus1 100)
101 (7 bits, #x65, #o145, #b1100101)

* (plus1 "hello")
"hello1"

* (plus1 'hello)
ERROR
~~~

## 型指定子

型指定子は型を指定するフォームです。上で述べたように、関数 `type-of` の戻り値と `typep` の第 2 引数はいずれも型指定子です。

上で示したように、`(type-of 1234)` は `(INTEGER 0 4611686018427387903)` を返します。この種の型指定子は複合型指定子と呼ばれます。これは、先頭が型を示すシンボルであるリストです。残りの部分は補足情報です。

~~~lisp
* (typep #(1 2 3) '(vector number 3))
T
~~~

ここで型 `vector` の補足情報は、それぞれ要素型とサイズです。

複合型指定子の残りの部分は `*` にできます。これは「何でも」を意味します。たとえば、型指定子 `(vector number *)` は、任意個数の数値から成るベクトルを表します。

~~~lisp
* (typep #(1 2 3) '(vector number *))
T
~~~

末尾の部分は省略でき、省略された要素は `*` として扱われます。

~~~lisp
* (typep #(1 2 3) '(vector number))
T

* (typep #(1 2 3) '(vector))
T
~~~

おそらく想像したとおり、上の型指定子は次のように短くできます。

~~~lisp
* (typep #(1 2 3) 'vector)
T
~~~

詳しくは [CLHS page][type-specifiers] を参照してください。

## 新しい型を定義する

マクロ [`deftype`][deftype] を使って新しい型指定子を定義できます。

その引数リストは、複合型指定子の残りの部分の要素への直接の対応づけと理解できます。シンボルの型指定子を許すために、それらは省略可能として定義されます。

本体は、与えられた引数がこの型かどうかを検査するマクロであるべきです（[`defmacro`][defmacro] を参照）。

たとえば `member` を使って列挙型を定義できます。

~~~lisp
(deftype fruit () '(member :apple :orange :pear))
~~~

ここで新しいデータ型を定義しましょう。このデータ型は最大 10 要素の配列とします。また、各要素は 10 未満の数値とします。例として次のコードを見てください。

~~~lisp
* (defun small-number-array-p (thing)
    (and (arrayp thing)
      (<= (length thing) 10)
      (every #'numberp thing)
      (every (lambda (x) (< x 10)) thing)))

* (deftype small-number-array (&optional type)
    `(and (array ,type 1)
          (satisfies small-number-array-p)))

* (typep #(1 2 3 4) '(small-number-array number))
T

* (typep #(1 2 3 4) 'small-number-array)
T

* (typep #(1 2 3 4 100) 'small-number-array)
NIL

* (small-number-array-p '(1 2 3 4 5 6 7 8 9 0 1))
NIL
~~~

## 実行時の型検査

Common Lisp はマクロ [`check-type`][check-type] による実行時の型検査をサポートしています。これは [`place`][place] と型指定子を引数として受け取り、place の内容が指定された型でない場合に [`type-error`][type-error] を通知します。

~~~lisp
* (defun plus1 (arg)
    (check-type arg number)
    (1+ arg))
PLUS1

* (plus1 1)
2 (2 bits, #x2, #o2, #b10)

* (plus1 "hello")
; Debugger entered on #<SIMPLE-TYPE-ERROR expected-type: NUMBER datum: "Hello">

The value of ARG is "Hello", which is not of type NUMBER.
   [Condition of type SIMPLE-TYPE-ERROR]
...
~~~


## コンパイル時の型検査

変数、関数引数などに対して、[`proclaim`][proclaim]、[`declaim`][declaim]（トップレベル）、[`declare`][declare]（関数とマクロの内部）を通じて型の情報を与えられます。

しかし、[CLOS の節][clos] で紹介した `:type` スロットと同様に、型宣言の効果は Lisp 標準では未定義であり、処理系に依存します。そのため、Lisp コンパイラがコンパイル時の型検査を行う保証はありません。

とはいえ、それは可能です。そして SBCL は綿密な型検査を行う処理系です。

まず、Lisp はすでに単純な型の警告を出すことを思い出しましょう。次の関数は誤って文字列と数値を連結しようとしています。コンパイルすると型の警告が出ます。

~~~lisp
(defconstant +foo+ 3)
(defun bar ()
  (concatenate 'string "+" +foo+))
; caught WARNING:
;   Constant 3 conflicts with its asserted type SEQUENCE.
;   See also:
;     The SBCL Manual, Node "Handling of Types"
~~~

例は単純ですが、他の言語にはない能力をすでに示しており、開発中に実際に役立ちます ;)
では、さらに良くしていきます。


### 変数の型を宣言する

マクロ [`declaim`][declaim] を `type` という宣言の識別子とともに使います（他の識別子は "ftype, inline, notinline, optimize…" です）。

グローバル変数 `*name*` が文字列であると宣言しましょう。REPL では次を任意の順序で入力できます。

~~~lisp
(declaim (type (string) *name*))
(defparameter *name* "book")
~~~

これを不正な型に設定しようとすると、ある処理系ではそのまま動くかもしれませんし、別の処理系では型エラーが出るかもしれません。

SBCL では `simple-type-error` が出ます。

~~~lisp
(setf *name* :me)
Value of :ME in (THE STRING :ME) is :ME, not a STRING.
   [Condition of type SIMPLE-TYPE-ERROR]
~~~

たとえば LispWorks と ECL では、警告やエラーなしで実行できます。

~~~lisp
(setf *name* :me)

*name*
:ME
~~~


独自の型でも同じことができます。`list-of-strings` 型を手早く宣言しましょう。

~~~lisp
(defun list-of-strings-p (list)
  "Return t if LIST is non nil and contains only strings."
  (and (consp list)
       (every #'stringp list)))

(deftype list-of-strings ()
  `(satisfies list-of-strings-p))
~~~

では `*all-names*` 変数が文字列のリストであると宣言しましょう。

~~~lisp
(declaim (type (list-of-strings) *all-names*))
;; そして不正な値で:
(defparameter *all-names* "")
;; まだ compile-time の時点で error を得ます:
Cannot set SYMBOL-VALUE of *ALL-NAMES* to "", not of type
(SATISFIES LIST-OF-STRINGS-P).
   [Condition of type SIMPLE-TYPE-ERROR]
~~~

### 型を合成する

型は合成できます。前の例に続けると:

~~~lisp
(declaim (type (or null list-of-strings) *all-names*))
~~~

### 関数の入力型と出力型を宣言する

再び `declaim` マクロを使います。ただし単なる `type` ではなく `ftype (function …)` を使います。

~~~lisp
(declaim (ftype (function (fixnum) fixnum) add))
;;                         ^^input ^^output [optional]
(defun add (n)
  (+ n  1))
~~~

これによりコンパイル時に良い型の警告が得られます。

関数を変更して、fixnum ではなく文字列を誤って返すようにすると、警告が出ます。

~~~lisp
(defun add (n)
  (format nil "~a" (+ n  1)))
; caught WARNING:
;   Derived type of ((GET-OUTPUT-STREAM-STRING STREAM)) is
;     (VALUES SIMPLE-STRING &OPTIONAL),
;   conflicting with the declared function return type
;     (VALUES FIXNUM &REST T).
~~~

`add` を別の関数の中で、文字列を期待する箇所に使うと警告が出ます。

~~~lisp
(defun bad-concat (n)
  (concatenate 'string (add n)))
; caught WARNING:
;   Derived type of (ADD N) is
;     (VALUES FIXNUM &REST T),
;   conflicting with its asserted type
;     SEQUENCE.
~~~

`add` を別の関数の中で使い、その関数が `add` の型と互換性がないように見える引数の型を宣言している場合も警告が出ます。

~~~lisp
(declaim (ftype (function (string)) bad-arg))
(defun bad-arg (n)
    (add n))
; caught WARNING:
;   Derived type of N is
;     (VALUES STRING &OPTIONAL),
;   conflicting with its asserted type
;     FIXNUM.
~~~

これはすべて実際に *コンパイル時* に起こります。REPL でも、Slime の単純な `C-c C-c` でも、ファイルを `load` するときでも同じです。

[​]{#key-parameters-}

### &key パラメータの宣言

`&key (:argument type)` を使います。

例:

    (declaim (ftype (function (string &key (:n integer))) foo))
    (defun foo (bar &key n) …)

[​]{#rest-parameters-}

### &rest パラメータの宣言

これはやや分かりにくく、適切な場所に置いた `declare` が必要かもしれません。

以下では fruit 型を宣言し、単一の fruit 引数を使う関数を書きます。そのため `placing-order` をコンパイルすると期待どおり型の警告が出ます。

~~~lisp
(deftype fruit () '(member :apple :orange :pear))

(declaim (ftype (function (fruit)) one-order))
(defun one-order (fruit)
  (format t "Ordering ~S~%" fruit))

(defun placing-order ()
  (one-order :bacon))
~~~

しかしこの版では `&rest` パラメータを使っており、型の警告は出なくなります。

~~~lisp
(declaim (ftype (function (&rest fruit)) place-order))
(defun place-order (&rest selections)
  (dolist (s selections)
    (format t "Ordering ~S~%" s)))

(defun placing-orders ()
  (place-order :orange :apple :bacon)) ;; => type warning なし
~~~

宣言は正しいのですが、コンパイラはそれを検査しません。適切な場所に置いた `declare` によりコンパイル時の警告が戻ります。

~~~lisp
(defun place-order (&rest selections)
  (dolist (s selections)
    (declare (type fruit s))      ;; <= declare
    (format t "Ordering ~S~%" s)))

(defun placing-orders ()
  (place-order :orange :apple :bacon))
~~~

=>

```
The value
  :BACON
is not of type
  (MEMBER :PEAR :ORANGE :APPLE)
```

移植性のあるコードでは、`assert` による実行時の検査を追加するでしょう。


[​]{#class-slot-}

### クラススロットの型を宣言する

クラススロットは `:type` スロットオプションを受け取ります。しかし一般には、initform の型を検査するためには *使われません*。2019 年 11 月にリリースされた [version 1.5.9][sbcl159] 以降の SBCL は、これらの警告を出すようになりました。つまり次のコードは:

~~~lisp
(defclass foo ()
  ((name :type number :initform "17")))
~~~

コンパイル時に警告を通知します。


注: `make-instance` の実行中（コンパイル時ではありません）にスロットの型を検査する、データのシリアライズおよび契約ライブラリ [sanity-clause][sanity-clause] も参照してください。


### 別の型検査の構文: defstar, serapeum

[Serapeum](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#types) ライブラリは、次のような短縮形を提供します。

```lisp
 (-> mod-fixnum+ (fixnum fixnum) fixnum)
 (defun mod-fixnum+ (x y) ...)
```

[Defstar](https://github.com/lisp-mirror/defstar) ライブラリは、lambda list に型宣言を追加できる `defun*` マクロを提供します。次のように見えます。

```lisp
(defun* sum ((a real) (b real))
   (+ a b))
```

さらに次も可能です。

* 戻り値の型を関数定義または本体内で宣言する
* `_` プレースホルダにより無視する変数を素早く宣言する
* 各引数にアサーションを追加する
* `defmethod`、`defparameter`、`defvar`、`flet`、`labels`、`let*`、`lambda` でも同じことを行う


### 制限

`satisfies` を含む複雑な型は、デフォルトでは関数本体の内部では検査されず、境界でだけ検査されます。多くのことはしてくれますが、SBCL は静的型付け言語ほど多くは行いません。

integer を文字列で誤って increment する次の例を考えてください。

~~~lisp
(declaim (ftype (function () string) bad-adder))
(defun bad-adder ()
  (let ((res 10))
    (loop for name in '("alice")
       do (incf res name))  ;; <= bad
    (format nil "finally doing sth with ~a" res)))
~~~

この関数をコンパイルしても型に関する警告は通知されません。

しかし、問題のある行が関数の boundary にあれば warning が出ます。

~~~lisp
(defun bad-adder ()
  (let ((res 10))
    (loop for name in  '("alice")
       return (incf res name))))
; in: DEFUN BAD-ADDER
;     (SB-INT:NAMED-LAMBDA BAD-ADDER
;         NIL
;       (BLOCK BAD-ADDER
;         (LET ((RES 10))
;           (LOOP FOR NAME IN *ALL-NAMES* RETURN (INCF RES NAME)))))
;
; caught WARNING:
;   Derived type of ("a hairy form" NIL (SETQ RES (+ NAME RES))) is
;     (VALUES (OR NULL NUMBER) &OPTIONAL),
;   conflicting with the declared function return type
;     (VALUES STRING &REST T).
~~~

loop body 内で `the` declaration を使ってコンパイル時の warning を得ることもできます。

```lisp
       do (incf res (the string name)))
```

何を結論とできるでしょうか。これは code を小さな関数に分解するもう 1 つの理由です。


## 参考

- Martin Cracauer による記事 [Static type checking in SBCL](https://medium.com/@MartinCracauer/static-type-checking-in-the-programmable-programming-language-lisp-79bb79eb068a)
- 記事 [Typed List, a Primer](https://alhassy.github.io/TypedLisp) - Haskell との浅い比較をしながら、Lisp の fine-grained type hierarchy を探索します。
- [Coalton](https://github.com/coalton-lang/coalton/) library: Common Lisp を強化する、効率的で statically typed な functional programming language。これは Lisp に埋め込まれた DSL で、Haskell や Standard ML に似ていますが、non-statically-typed Lisp code と seamless に相互運用できます（逆も同様）。
- enum types と union types（ecase-of、etypecase-of）のための [Serapeum](https://github.com/ruricolist/serapeum/blob/master/REFERENCE.md#ecase-of-type-x-body-body) による [コンパイル時の exhaustiveness type checking](https://dev.to/vindarel/compile-time-exhaustiveness-checking-in-common-lisp-with-serapeum-5c5i)。

 

[^1]: ここでの *object* という用語は Object-Oriented などとは関係ありません。「任意の Lisp datum」を意味します。

[defvar]: http://www.lispworks.com/documentation/lw51/CLHS/Body/m_defpar.htm
[setf]: http://www.lispworks.com/documentation/lw50/CLHS/Body/m_setf_.htm
[type-of]: http://www.lispworks.com/documentation/HyperSpec/Body/f_tp_of.htm
[type-specifiers]: http://www.lispworks.com/documentation/lw51/CLHS/Body/04_bc.htm
[number]: http://www.lispworks.com/documentation/lw61/CLHS/Body/t_number.htm
[typep]: http://www.lispworks.com/documentation/lw51/CLHS/Body/f_typep.htm
[subtypep]: http://www.lispworks.com/documentation/lw71/CLHS/Body/f_subtpp.htm
[string]: http://www.lispworks.com/documentation/lw71/LW/html/lw-426.htm
[simple-array]: http://www.lispworks.com/documentation/lw70/CLHS/Body/t_smp_ar.htm
[integer]: http://www.lispworks.com/documentation/lw71/CLHS/Body/t_intege.htm
[describe]: http://www.lispworks.com/documentation/lw51/CLHS/Body/f_descri.htm
[clos]: clos.html
[character]: http://www.lispworks.com/documentation/lcl50/ics/ics-14.html
[number]: http://www.lispworks.com/documentation/lw61/CLHS/Body/t_number.htm
[complex]: http://www.lispworks.com/documentation/lw70/CLHS/Body/t_comple.htm
[real]: http://www.lispworks.com/documentation/lw70/CLHS/Body/t_real.htm
[rational]: http://www.lispworks.com/documentation/HyperSpec/Body/t_ration.htm
[class-of]: http://www.lispworks.com/documentation/HyperSpec/Body/f_clas_1.htm
[typecase]: http://www.lispworks.com/documentation/lw60/CLHS/Body/m_tpcase.htm
[deftype]: http://www.lispworks.com/documentation/lw51/CLHS/Body/m_deftp.htm
[defmacro]: http://www.lispworks.com/documentation/lw70/CLHS/Body/m_defmac.htm
[check-type]: http://www.lispworks.com/documentation/HyperSpec/Body/m_check_.htm#check-type
[type-error]: http://www.lispworks.com/documentation/HyperSpec/Body/e_tp_err.htm#type-error
[place]: http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_p.htm#place
[proclaim]: http://www.lispworks.com/documentation/HyperSpec/Body/f_procla.htm
[declaim]: http://www.lispworks.com/documentation/HyperSpec/Body/m_declai.htm
[declare]: http://www.lispworks.com/documentation/HyperSpec/Body/s_declar.htm
[safety]: http://www.lispworks.com/documentation/HyperSpec/Body/d_optimi.htm#speed
[sbcl159]: http://www.sbcl.org/all-news.html#1.5.9
[sanity-clause]: https://github.com/fisxoj/sanity-clause
 
#  ソケットによる TCP/UDP プログラミング {#chapter-sockets}
 

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
 
#  OS との連携 {#chapter-os}
 


ANSI Common Lisp 標準はこの話題に触れていません。（この標準が書かれたのは、[Lisp Machine](https://en.wikipedia.org/wiki/Lisp_machine) が最盛期だった時代だということを覚えておいてください。これらのマシンでは Lisp _そのもの_ がオペレーティングシステムでした！）そのため、ここで言えることのほとんどは OS と処理系に依存します。
ただし、広く使われているライブラリはいくつかあります。これらは Common Lisp 処理系に同梱されているか、[Quicklisp](https://www.quicklisp.org/beta/) から簡単に入手できます。例を挙げると次のとおりです。

* ASDF3。ほぼすべての Common Lisp 処理系に含まれており、
  [Utilities for Implementation- and OS- Portability (UIOP)](https://common-lisp.net/project/asdf/uiop.html) を含んでいます。
* [osicat](https://common-lisp.net/project/osicat/)
* [unix-opts](http://quickdocs.org/unix-opts/) または、より新しい [clingon](https://github.com/dnaeon/clingon)。Python の `argparse` に似たコマンドライン引数パーサーです。


[​]{#env}

## 環境変数へのアクセス

UIOP には、多くの CL 処理系で Unix/Linux の環境変数を参照できる関数があります。

~~~lisp
* (uiop:getenv "HOME")
  "/home/edi"
~~~

以下は実装例です。ここでは、特定の処理系でコードを実行するために /フィーチャフラグ/ が使われていることが分かります。

~~~lisp
* (defun my-getenv (name &optional default)
    "Obtains the current value of the POSIX environment variable NAME."
    (declare (type (or string symbol) name))
    (let ((name (string name)))
      (or #+abcl (ext:getenv name)
         #+ccl (ccl:getenv name)
         #+clisp (ext:getenv name)
         #+cmu (unix:unix-getenv name) ; CMUCL 20b 以降
         #+ecl (si:getenv name)
         #+gcl (si:getenv name)
         #+mkcl (mkcl:getenv name)
         #+sbcl (sb-ext:posix-getenv name)
         default)))
MY-GETENV
* (my-getenv "HOME")
"/home/edi"
* (my-getenv "HOM")
NIL
* (my-getenv "HOM" "huh?")
"huh?"
~~~

これらの処理系の一部は、環境変数を _設定_ する機能も提供していることに注意してください。たとえば ECL（`si:setenv`）や AllegroCL、LispWorks、CLISP では、上で挙げた関数を [`setf`](http://www.lispworks.com/documentation/HyperSpec/Body/m_setf_.htm) と組み合わせて使えます。この機能は、Lisp 環境からサブプロセスを起動したい場合に重要になることがあります。

環境変数を設定するには、処理系に依存しない方法として `(uiop:getenv "lisp")` に対して `setf` を使えます。

また、
[Osicat](https://www.common-lisp.net/project/osicat/manual/osicat.html#Environment)
ライブラリには、Windows を含む POSIX 風システムで使える `(environment-variable "name")` メソッドがあります。これは `fset` 可能でもあります。

### ディレクトリを持つ環境変数（PATH）

ある関数を使うと、環境変数からディレクトリのリストを取得できます。

```lisp
(uiop:getenv-absolute-directories "PATH")
;; => (#P"/home/vince/.local/bin/" #P"/usr/local/bin/" #P"/usr/sbin/" #P"/usr/bin/")
```

そのドキュメントは次のとおりです。

> ユーザーが設定した環境変数から、ネイティブ OS に従って絶対ディレクトリのリストを取り出します。環境変数 X に空のエントリがある場合、それらは NIL として返されます。

環境変数が 1 つのディレクトリを含む場合は `uiop:getenv-absolute-directory` を使います。関連項目: `uiop:getenv-pathname[s]`。


[​]{#accessing-command-line}

## コマンドライン引数へのアクセス

### 基本

コマンドライン引数へのアクセスは処理系固有ですが、ほとんどの処理系にはそれらを取得する方法があるようです。`uiop:command-line-arguments` を使う UIOP、[Roswell](https://github.com/roswell/roswell/wiki)、および外部ライブラリ（次の節を参照）を使うと移植性を持たせられます。

[SBCL](http://www.sbcl.org) は引数リストをスペシャル変数 `sb-ext:*posix-argv*` に格納します。

~~~lisp
$ sbcl my-command-line-arg
~~~

....

~~~lisp
* sb-ext:*posix-argv*

("sbcl" "my-command-line-arg")
*
~~~

これを使ってスタンドアロンの Lisp スクリプトを書く方法の詳細は、[SBCL Manual](http://www.sbcl.org/manual/index.html#Command_002dline-arguments) にあります。

[LispWorks](http://www.lispworks.com) には `system:*line-arguments-list*` があります。

~~~lisp
* system:*line-arguments-list*
("/Users/cbrown/Projects/lisptty/tty-lispworks" "-init" "/Users/cbrown/Desktop/lisp/lispworks-init.lisp")
~~~

複数の処理系で引数文字列のリストを返す簡単な関数は次のとおりです。

~~~lisp
(defun my-command-line ()
  (or
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*)
   #+CLISP *args*)
~~~

これで、移植可能な方法で引数にアクセスし、スキーマ定義に従って解析できると便利です。

### コマンドライン引数の解析

[Awesome CL list#scripting](https://github.com/CodyReichert/awesome-cl#scripting)
の節を見て、[clingon](https://github.com/dnaeon/clingon) の使い方を示します。

詳しくは [scripting recipe](https://lispcookbook.github.io/cl-cookbook/scripting.html#parsing-command-line-arguments) を参照してください。


## 外部プログラムの実行

**uiop** が対応してくれます。おそらく Common Lisp 処理系に含まれています。

### 同期的に

[`uiop:run-program`](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fRUN_002dPROGRAM) は、実行する実行ファイルの名前を表す文字列、またはプログラムとその引数を表す文字列のリストを引数に取ります。

~~~lisp
(uiop:run-program "ls | grep lisp" :output t)
~~~

または

~~~lisp
(uiop:run-program (list "ls" "-lh") :output t)
~~~

これは指定どおりにプログラム出力を処理し、プログラムと出力処理が完了したときに処理結果を返します。

コマンドを文字列として渡すとシェル内で実行され、リストとして渡すとシェルを使いません。

標準出力に出力するために `:output t` を使っています。出力は文字列、ファイル、その他任意のストリームに取り込めますし、対話的な出力にもできます。後述します。

この関数には次の省略可能引数があります。

~~~lisp
run-program (command &rest keys &key
               ignore-error-status
               (force-shell nil force-shell-suppliedp)
               input
               (if-input-does-not-exist :error)
               output
               (if-output-exists :supersede)
               error-output
               (if-error-output-exists :supersede)
               (element-type *default-stream-element-type*)
               (external-format *utf-8-external-format*)
              allow-other-keys)
~~~

`force-shell` が指定されている場合、可能ならコマンドを直接実行するのではなく、常にシェルを呼び出します。同様に、`force-shell` に `nil` が指定されている場合、シェルは決して呼び出されません。

プロセスが成功しなかった場合（終了コードが 0 でない場合）、`ignore-error-status` が指定されていない限り、継続可能な `subprocess-error` を通知します。

`:output` 引数には次のものを指定できます。

- `output` が `nil`（デフォルトで、`null` デバイスを指定）、pathname、または pathname を指定する文字列の場合、そのパスのファイルが出力として使われます。
- `t` の場合、出力は現在の `*standard-output*` ストリームに送られます。
- `:output :string`、または末尾の改行を取り除く `:output '(:string :stripped t)`。
- `:interactive` の場合、出力は現在のプロセスから継承されます。これは `*standard-output*` と異なる可能性があり、`slime` では `*inferior-lisp*` バッファ上になるので注意してください。
- それ以外の場合、`output` は `uiop:slurp-input-stream` の適切な第 1 引数、またはそのような値とキーワード引数のリストである必要があります。例として `:string` や `'(:string :stripped t)` があります。
この場合、`run-program` はプログラム出力用の一時ストリームを作成します。
そのストリーム内のプログラム出力は、`output` を第 1 引数（または `output` の先頭要素を第 1 引数、残りをキーワード）として `slurp-input-stream` を呼び出すことで処理されます。
その呼び出しから得られる主たる値（呼び出しが不要だった場合は `nil`）が、`run-program` の第 1 戻り値になります。
たとえば、`:output :string` を使うと、出力ストリーム全体が文字列として返されます。

`if-output-exists` は、`output` が文字列または pathname の場合にのみ意味があり、`:error`、`:append`、`:supersede`（デフォルト）を取れます。これらの値の意味と、`output` が存在しない場合への影響は、`:direction` `:output` で `open` に渡す `if-exists` パラメータと同様です。

`error-output` は `output` と似ていますが、結果の値は `run-program` の第 2 戻り値として返されます。`t` は `*error-output*` を指定します。また `:output` はエラー出力を出力ストリームにリダイレクトすることを意味し、この場合は `nil` が返されます。

`if-error-output-exists` は `if-output-exist` と似ていますが、`output` ではなく `error-output` に影響します。

`input` は `output` と似ていますが、`vomit-output-stream` が使われ、値は返されず、`T` は `*standard-input*` を指定します。

`if-input-does-not-exist` は、`input` が文字列または pathname の場合にのみ意味があり、`:create` と `:error`（デフォルト）を取れます。これらの値の意味は、`:direction :input` で `open` に渡す `if-does-not-exist` パラメータと同様です。

`element-type` と `external-format` は、該当する場合、出力ストリームの作成のために Lisp 処理系へ渡されます。

ストリームの slurping または vomiting のうち 1 つだけが、オプションと処理系によってはサブプロセスと並行して行われる場合があります。その際は出力の処理が優先されます。
その他のストリームは、サブプロセスを起動する前または後に、一時ファイルを使って完全に生成または消費されます。

`run-program` は 3 つの値を返します。

* `output` の slurping 結果があればそれ、なければ `nil`
* `error-output` の slurping 結果があればそれ、なければ `nil`
* サブプロセスが成功のステータスで終了した場合は 0、そうでなければプロセスの `exit-code` による失敗の情報


### 非同期的に

[`uiop:launch-program`](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fLAUNCH_002dPROGRAM) を使います。

その signature は次のとおりです。

~~~lisp
launch-program (command &rest keys &key
                    input
                    (if-input-does-not-exist :error)
                    output
                    (if-output-exists :supersede)
                    error-output
                    (if-error-output-exists :supersede)
                    (element-type *default-stream-element-type*)
                    (external-format *utf-8-external-format*)
                    directory
                    #+allegro separate-streams
                    &allow-other-keys)
~~~

起動したプログラムからの出力（stdout）は、`output` キーワードで設定します。

 - `output` が pathname、pathname を指定する文字列、または `nil`（デフォルトで null デバイスを指定）の場合、そのパスのファイルが出力として使われます。
 - `:interactive` の場合、出力は現在のプロセスから継承されます。これは `*standard-output*` と異なる可能性があり、Slime では `*inferior-lisp*` バッファ上になるので注意してください。
 - `T` の場合、出力は現在の `*standard-output*` ストリームに送られます。
 - `:stream` の場合、新しいストリームが利用可能になり、`process-info-output` 経由でアクセスして読み取れます。
 - それ以外の場合、`output` は下位の Lisp 処理系が扱える値である必要があります。

`if-output-exists` は、`output` が文字列または pathname の場合にのみ意味があり、`:error`、`:append`、`:supersede`（デフォルト）を取れます。これらの値の意味と、`output` が存在しない場合への影響は、`:DIRECTION :output` で `open` に渡す `if-exists` パラメータと同様です。

`error-output` は `output` と似ています。`T` は `*error-output*` を指定し、`:output` はエラー出力を出力ストリームにリダイレクトすることを意味し、`:stream` は `process-info-error-output` 経由でストリームを利用可能にします。

`launch-program` は、次のような `process-info` オブジェクトを返します（[source](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/launch-program.lisp#L205)）。


~~~lisp
(defclass process-info ()
    (
     ;; PID の代わりに stream を扱う利点は、
     ;; `sys:pipe-kill-process` のような関数が使えることです。
     (process :initform nil)
     (input-stream :initform nil)
     (output-stream :initform nil)
     (bidir-stream :initform nil)
     (error-output-stream :initform nil)
     ;; 後方互換性のため、(zerop exit-code) <-> success という性質を
     ;; 保つ目的で、signal に応答した exit は 128+signum として
     ;; encode されます。
     (exit-code :initform nil)
     ;; platform が許す場合、code >128 での exit と signal に応答した
     ;; exit を区別するために、この code を設定します。
     (signal-code :initform nil)))
~~~

[docstrings](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/launch-program.lisp#L508) を参照してください。

#### サブプロセスが生きているかをテストする

`uiop:process-alive-p` は、`launch-program` が返した `process-info` オブジェクトを与えると、そのプロセスがまだ生きているかをテストします。

~~~lisp
* (defparameter *shell* (uiop:launch-program "bash"
                            :input :stream :output :stream))

;; 下位 shell process が実行中
* (uiop:process-alive-p *shell*)
T

;; input stream と output stream を閉じる
* (uiop:close-streams *shell*)
* (uiop:process-alive-p *shell*)
NIL
~~~

#### exit code を取得する

`uiop:wait-process` を使えます。プロセスが終了していれば即座に戻り、exit code を返します。終了していなければ、プロセスが終了するまで待ちます。

~~~lisp
(uiop:process-alive-p *process*)
NIL
(uiop:wait-process *process*)
0
~~~

exit code が 0 なら成功です（`zerop` を使います）。

exit code は `process-info` オブジェクトの `exit-code` スロットにも格納されます。上のクラス定義から分かるように accessor はないので、`slot-value` を使います。`nil` への `initform` があるため、スロットが bound かどうかを確認する必要はありません。次のようにできます。

~~~lisp
(slot-value *my-process* 'uiop/launch-program::exit-code)
0
~~~

こつは、事前に必ず `wait-process` を実行しなければならないことです。そうしないと結果は `nil` になります。

`wait-process` は blocking なので、新しいスレッドで実行できます。

~~~lisp
(bt:make-thread
  (lambda ()
    (let ((exit-code (uiop:wait-process
                       (uiop:launch-program (list "of" "commands"))))
      (if (zerop exit-code)
          (print :success)
          (print :failure)))))
  :name "Waiting for <program>")
~~~


`run-program` は exit code を第 3 戻り値として返すことにも注意してください。


### サブプロセスからの input と output

`input` keyword が `:stream` に設定されている場合、ストリームが作成され、ファイルと同じように書き込めます。このストリームには `uiop:process-info-input` を使ってアクセスできます。

~~~lisp
;; input stream と output stream を持つ下位 shell を起動する
* (defparameter *shell* (uiop:launch-program "bash"
                           :input :stream :output :stream))
;; shell に 1 行を書き込む
* (write-line "find . -name '*.md'"
     (uiop:process-info-input *shell*))
;; stream を flush する
* (force-output (uiop:process-info-input *shell*))
~~~

ここで [write-line](http://clhs.lisp.se/Body/f_wr_stg.htm) は、与えられたストリームに文字列を書き込み、末尾に newline を追加します。
[force-output](http://clhs.lisp.se/Body/f_finish.htm) の呼び出しはストリームの flush を試みますが、完了を待ちません。

出力ストリームからの読み取りも同様で、`uiop:process-info-output` は output ストリームを返します。

~~~lisp
* (read-line (uiop:process-info-output *shell*))
~~~

場合によっては、読み取るデータ量が分かっていたり、読み取りを止める delimiter があったりします。そうでない場合、[read-line](http://clhs.lisp.se/Body/f_rd_lin.htm) の呼び出しはデータを待って hang する可能性があります。これを避けるために、文字が利用可能かをテストする [listen](http://clhs.lisp.se/Body/f_listen.htm) を使えます。

~~~lisp
* (let ((stream (uiop:process-info-output *shell*)))
     (loop while (listen stream) do
         ;; 文字はすぐ利用可能
         (princ (read-line stream))
         (terpri)))
~~~

1 文字を読み取るか、利用可能な文字がない場合に `nil` を返す [read-char-no-hang](http://clhs.lisp.se/Body/f_rd_c_1.htm) もあります。
buffering のような問題や、相手プロセスがいつ実行されるかのタイミングにより、送信されたすべてのデータが `listen` や `read-char-no-hang` が `nil` を返す前に受信される保証はないことに注意してください。

[​]{#standard-output--error-output-}

### standard output とエラー output の捕捉

standard output の捕捉は上で見たように、`:output` に `:string` を指定するか、末尾の newline を取り除くために `:output '(:string :stripped t)` を使うだけで簡単にできます。

`:error-output` にも同じことを指定できます。さらに `:ignore-error-status t` を使うと、`uiop:run-program` にエラーを通知させず、対話型デバッガに入らないようにできます。

その場合、返された `exit-code` でプログラムの成功または失敗を確認できます。0 は成功です。

すべてをまとめると次のようになります。

~~~lisp
(uiop:run-program (list "git"
                        "checkout"
                        "me/does-not-exist")
                  :output :string
                  :error-output :string
                  :ignore-error-status t)
;; =>
""
"error: pathspec 'me/does-not-exist did not match any file(s) known to git
"
1
~~~

`uiop:run-program` は 3 つの値を返します。

- standard output（ここでは空文字列）
- エラー output（ここではエラーメッセージを含む文字列）
- exit code

これらは `multiple-value-bind` で bind できます。

~~~lisp
(multiple-value-bind (output error-output exit-code)
    (uiop:run-program (list …))
  (unless (zerop exit-code)
    (format t "error output is: ~a" error-output)))
~~~

### 対話的・視覚的なコマンドの実行（htop）

`uiop:run-program` を使い、`:input` と `:output` の両方を `:interactive` に設定します。

~~~lisp
(uiop:run-program "htop"
                  :output :interactive
                  :input :interactive)
~~~

これにより、`htop` は本来そうあるべきように全画面で spawn されます。

これは他のコマンド（`sudo`、`vim`、`less`…）でも動作します。

## パイプ

`ls | sort` と同等のことを行う例です。"ls" は `launch-program`（async）を使い、ストリームに出力します。一方、pipe の最後のコマンドである "sort" は `run-program` を使い、文字列に出力することに注意してください。

~~~lisp
(uiop:run-program "sort"
                   :input
                   (uiop:process-info-output
                    (uiop:launch-program "ls"
                                         :output :stream))
                   :output :string)
~~~


[​]{#lisp--process-idpid}

## Lisp の現在のプロセス ID（PID）を取得する

処理系はそれぞれ独自の関数を提供しています。

SBCL では次のとおりです。

~~~lisp
(sb-posix:getpid)
~~~

osicat ライブラリを使うと移植可能にできます。

~~~lisp
(osicat-posix:getpid)
~~~

ここでも、`apropos` 関数を使って探せます。

~~~lisp
CL-USER> (apropos "pid")
OSICAT-POSIX:GETPID (fbound)
OSICAT-POSIX::PID
[…]
SB-IMPL::PID
SB-IMPL::WAITPID (fbound)
SB-POSIX:GETPID (fbound)
SB-POSIX:GETPPID (fbound)
SB-POSIX:LOG-PID (bound)
SB-POSIX::PID
SB-POSIX::PID-T
SB-POSIX:WAITPID (fbound)
[…]
~~~
 
#  外部関数インターフェイス {#chapter-ffi}
 

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
 
#  動的ライブラリを作る {#chapter-dynamic-libraries}
 

Common Lisp 処理系の大多数には、C ABI を使うライブラリの関数を呼び出せる何らかの [外部関数インターフェイス](#chapter-ffi) があります。しかし逆方向、つまり CL ライブラリを他の言語から C ABI 経由で呼び出せるライブラリとしてコンパイルすることは、あまり一般的ではないかもしれません。

LispWorks や Allegro CL のような商用処理系は通常この機能を提供しており、ドキュメントもよく整備されています [^1]。

この章では、[SBCL-Librarian](https://github.com/quil-lang/sbcl-librarian) というプロジェクトを説明します。これは、優れたオープンソースかつ無償利用可能な処理系である [SBCL (Steel Bank Common Lisp)](https://www.sbcl.org) を使い、C (C FFI を持つもの全般) と Python から呼び出せるライブラリを作るための、方針を持った方法です。

SBCL-Librarian はコールバックに対応しているため、すばらしい機械学習や統計ライブラリを使う Python コードなど、どんなコードとでも Lisp ライブラリを統合できます。

SBCL-Librarian の動作は、C のソースファイル、C のヘッダ、Python モジュールを生成するというものです。

C ソースファイルはまず動的ライブラリにコンパイルされます。このライブラリは、提供されるヘッダーファイルを使って任意の C プロジェクトから、または C ライブラリの読み込みに対応する言語の任意のプロジェクトからロードできます。

生成された Python モジュールは、コンパイル済みライブラリを Python プロセスにロードします。つまり、Lisp ライブラリを Python コードから使う前に C ライブラリをコンパイルしておく必要があります。このことから、主に 2 つの結果が生じます。

- 一方で、Lisp ライブラリはすべて効率的なネイティブコードになります。これはすばらしいことです。Python のインタプリタはかなり遅いことがあり、特に機械学習や統計のライブラリの多くはネイティブコードにコンパイルされています。Common Lisp でも同じ効率を達成できます。
- 他方で、ライブラリが Python との通信に使えるのは C インターフェイスだけです。つまり、C の基本データ型、構造体、関数、ポインタ（関数へのポインタを含む）です。C の基本知識が必要です。

<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px;">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NOTE:</strong> SBCL-Librarian の背後にいるチームは、業界で量子コンピューティングに取り組んでいます。より正確には、Quil という量子コンピューティング用プログラミング言語とそのエコシステムに取り組んでいます。
</div>

[​]{#environment-}

## 環境の準備

[​]{#shared-library-support--sbcl--build-}

### 共有ライブラリ対応付きで SBCL をビルドする

SBCL のバイナリ配布物は通常、共有ライブラリとしてビルドされた SBCL を含んでいません。しかしこれは SBCL-Librarian に必要です。
[SBCL git リポジトリ](https://github.com/sbcl/sbcl) からダウンロードするか、[Roswell を使って](#with-roswell) `ros install sbcl-source` コマンドを実行して取得できます。

SBCL はコンパイル処理をブートストラップするために、動作する Common Lisp の処理系も必要とします。簡単な方法は、Roswell からバイナリをダウンロードしてインストールし、それを `PATH` 変数に追加することです。

SBCL は `zstd` ライブラリに依存します。Linux 系のシステムでは、ライブラリとヘッダファイルの両方をパッケージマネージャから取得できます。通常は `libzstd-dev` という名前です。Windows では、推奨される方法は
[MSYS2](https://www.msys2.org) を使うことです。MSYS2 には Roswell、`zstd`、そのヘッダが含まれます。

ソースのあるディレクトリへ移動し、次を実行します。

~~~bash
# Bash

# (assuming the version of your SBCL installed via Roswell is 2.4.1)
export PATH=~/.roswell/impls/x86-64/linux/sbcl-bin/2.4.1/bin/:$PATH

./make-config.sh --fancy
./make.sh --fancy
./make-shared-library.sh --fancy
~~~

共有ライブラリは Windows や Mac でも `.so` という拡張子を持つことに注意してください。ただし、問題なく動くようです。MSYS2 で Roswell を使う場合、MSYS2 のホームディレクトリではなく Windows のホームディレクトリを使うことがあります。これらは異なるパスです。したがって、Roswell へのパスは `~/.roswell/` ではなく `$USERPROFILE/.roswell` (または `/C/Users/<username>/.roswell`) かもしれません。

### SBCL-Librarian をダウンロードしてセットアップする

SBCL-Librarian のリポジトリを clone します。

~~~bash
git clone https://github.com/quil-lang/sbcl-librarian.git
~~~

## Lisp からの Hello World

SBCL-Librarian にはいくつかのドキュメントといくつかの例が付属していますが、基本チュートリアルのようなものは実際にはありません。この章では、2 つの数を足す基本的な関数を作り、それを Python から呼び出します。

便利のため、環境変数をいくつか設定しましょう。

~~~bash
# Directory with SBCL sources
export SBCL_SRC=~/.roswell/src/sbcl-2.4.1
# Directory with this project, don't forget the double slash at the end
# or it might not work
export CL_SOURCE_REGISTRY="~/prg/sbcl-librarian//"
~~~

より新しい Linux 系のシステムでは、通常、現在のディレクトリはライブラリの検索対象になりません。Python がライブラリを検索するパスも、通常は現在の作業ディレクトリに設定されていません。便利のため、次のように設定します。

~~~bash
export LD_LIBRARY_PATH=.:
export PATH=.:$PATH
~~~

これで、次の内容を持つ `helloworld.lisp` ファイルを作成できます。

~~~lisp
(require '#:asdf)
(asdf:load-system :sbcl-librarian)

(defpackage libhelloworld
  (:use :cl :sbcl-librarian))

(in-package libhelloworld)

;; will be called from Python
(defun hello-world (a b)
  (+ a b))


;; error enum to be used in C/Python code for error handling
(define-enum-type error-type "err_t"
  ("ERR_SUCCESS" 0)
  ("ERR_FAIL" 1))

;; mapping Common Lisp conditions to C enums
;; in this simple example, all conditions are mapped to number 1
;; which is "ERR_FAIL" in `error-type` enum
(define-error-map error-map error-type 0
  ((t (lambda (condition)
        (declare (ignore condition))
        (return-from error-map 1)))))

;; structure of the generated C source file
(define-api libhelloworld-api (:error-map error-map              ; error enum
                               :function-prefix "helloworld_")   ; prefix for all function names (C doesn't have namespaces)
  (:literal "/* types */")        ; just a comment (whatever is there will be printed as-is)
  (:type error-type)              ; outputs the error enum
  (:literal "/* functions */")
  (:function                      ; function declaration - name, return type, argument types
     (hello-world :int ((a :int) (b :int)))))

;; definition of the whole library - what is there
(define-aggregate-library libhelloworld (:function-linkage "LIBHELLOWORLD_API")
  sbcl-librarian:handles sbcl-librarian:environment libhelloworld-api)

;; builds the bindings
(build-bindings libhelloworld ".")
(build-python-bindings libhelloworld ".")

;; outputs the Lisp core
(build-core-and-die libhelloworld "." :compression t)
~~~

マクロ `define-enum-type` は、Common Lisp 関数が通知するコンディションと、C ラッパー関数の戻り値の型との対応付けを作ります。Common Lisp からコンディションが通知されると、`define-error-map` の中で数値、つまり C 関数の戻り値に変換されます。列挙型は C の `enum` を追加するため、次の代わりに:

~~~C
if (1 == cl_function()) {
~~~

次のように書けます。

~~~C
if (ERR_FAIL == cl_function()) {
~~~

こちらのほうが読みやすいです。

`define-api` は、作成されるライブラリコードの構造を概説し、エラーの対応表、型、関数、およびそれらの順序を指定します (この場合、`:literal` はコメントに使われます)。

`define-aggregate-library` は、ライブラリ全体を定義し、何をどの順序で含めるかを指定します。

次のコマンドでファイルをコンパイルできます。

~~~bash
$SBCL_SRC/run-sbcl.sh --script "helloworld.lisp"
cc -shared -fpic -o libhelloworld.so libhelloworld.c -L$SBCL_SRC/src/runtime -lsbcl
cp $SBCL_SRC/src/runtime/libsbcl.so .
~~~

Python のコンソールを起動し、`helloworld` モジュールが正常に作成されたことを確認できます。

~~~python
import helloworld

dir(helloworld)
~~~

出力された辞書に関数 `helloworld_hello_world` が存在するはずです。

この関数は、関数の戻り値がエラーコードになるという C の標準に従います
(0 は成功、その他の数値は `error-map` の定義に従う `err_t` クラスで定義されるべきです)。
関数の最後のパラメータが、その戻り値です。この場合これは整数へのポインタなので、
`ctypes` ライブラリを使って整数を作成し、結果の値へのポインタとともに `helloworld_hello_world` を呼び出す必要があります。

次のプログラムは 11 を出力するはずです。

~~~python
import helloworld
import ctypes

rv = ctypes.c_int(0)
helloworld.helloworld_hello_world(5, 6, ctypes.pointer(rv))
print(rv.value)
~~~

システムによっては、よく起きる問題が 2 つあります。

1 つ目は Python からのややわかりにくいエラーです。

~~~
>>> import helloworld
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: dynamic module does not define module export function (PyInit_helloworld)
~~~

これは、Python が `helloworld.py` ではなく `helloworld.so` を Python モジュールとして開こうとしていることを意味します。`helloworld.so` はネイティブコンパイルされた Python モジュールではなく普通の動的ライブラリなので、これは動きません。

~~~bash
cp ./helloworld.py ./py_helloworld.py
~~~

そして Python では `import py_helloworld` します。

次の例外が発生する場合:

~~~
Traceback (most recent call last):
  ...
    raise Exception('Unable to locate libhelloworld') from e
Exception: Unable to locate libhelloworld
~~~

まず、必要な依存ライブラリ、ここでは `libsbcl` と `libzstd` が出力ディレクトリにコピーされているか、オペレーティングシステムがライブラリをロードするパスにあるかを確認してください。それでも動かない場合は、使用中の環境で Python がライブラリを見つける仕組みに問題がある可能性があります。

`helloworld.py` (または先ほどの提案どおり名前を変更した場合は `py_helloworld.py`) を開き、次の行を

~~~Python
libpath = Path(find_library('libcallback')).resolve()
~~~

あなたのオペレーティングシステム用のパスに変更します。例:

~~~Python
libpath = Path('./libhelloworld.so').resolve()
~~~


## より複雑な例: コールバックの例

SBCL-Librarian には複数の例が含まれており、そのうちの 1 つは Python コードへの単純なコールバックです。この例には `Makefile` が付属し、`asdf` を使って適切に定義されたシステムもあります。

### ASDF のシステム定義

`libcallback.asd` のシステム定義は、SBCL-Librarian への依存を宣言します。

~~~lisp
(asdf:defsystem #:libcallback
  :defsystem-depends-on (#:sbcl-librarian)
  :depends-on (#:sbcl-librarian)
~~~

ASDF のシステムは SBCL-Librarian のソースをどこで見つけるかを知る必要があります。これを指定する方法の 1 つは、上で見たように、そのディレクトリを含むよう `CL_SOURCE_REGISTRY` 環境変数を設定することです。あるいは、ASDF が見つけられる場所 (`~/common-lisp/`, `~/quicklisp/local-projects/`) にプロジェクトを clone します。

### Bindings.lisp

`bindings.lisp` には、C バインディングを生成するための重要な要素が含まれます。

~~~lisp
(defun call-callback (callback outbuffer)
  (sb-alien:with-alien ((str sb-alien:c-string "I guess "))
    (sb-alien:alien-funcall callback str outbuffer)))
~~~

この関数はこの例の要です。Python コードから呼び出され、Python のメソッド (`callback` パラメータ) を呼び返します。SBCL-Librarian は C ライブラリと、それをラップする Python モジュールの両方を生成するため、この関数は C からも Python からも呼び出せます。この例は Python に焦点を当てます。

SBCL-Librarian は、C 関数と連携するための SBCL パッケージである `sb-alien` を利用します。`with-alien` は、そのスコープ内で有効で、終了後に自動的に破棄されるリソース (ここでは型 `c-string` の `str`) を作成し、メモリリークを防ぎます。`alien-funcall` は C 関数を呼び出すために使われ、この場合は、新しく作成した文字列と引数として渡された文字列バッファを使って `callback` を呼び出します。

~~~lisp
(sbcl-librarian::define-type :callback
  :c-type "void*"
  :alien-type (sb-alien:* (sb-alien:function sb-alien:void sb-alien:c-string (sb-alien:* sb-alien:char)))
  :python-type "c_void_p")

(sbcl-librarian::define-type :char-buffer
  :c-type "char*"
  :alien-type (sb-alien:* sb-alien:char)
  :python-type "c_char_p")
~~~

この部分は、C、Python、Common Lisp における `callback` と `char-buffer` 型を定義します。両者の C の型と Python の型は、それぞれ `void*` と `char*` です。callback の Common Lisp の型は関数のプロトタイプを指定します。つまり、`void` を返し、`c-string` と `char` へのポインタという 2 つのパラメータを取る関数へのポインタです。`sb-alien:*` はポインタを示すため、`:callback` は関数へのポインタです。`:char-buffer` 型は、3 つの言語すべてで `char*` を表します。

このファイルの残りは、`Hello World` の節で説明したものと似ています。

### Lisp コードをコンパイルする

`script.lisp` は、Lisp ソースをコンパイルし、ラッパーコードと Lisp コアを出力する単純な Lisp スクリプトです。

~~~lisp
(require '#:asdf)

(asdf:load-system '#:libcallback)

(in-package #:sbcl-librarian/example/libcallback)

(build-bindings libcallback ".")
(build-python-bindings libcallback ".")
(build-core-and-die libcallback "." :compression t)
~~~

これで新しいファイルがいくつかできます。

`libcallback.c` はライブラリのソースコードです。

~~~c
#define CALLBACKING_API_BUILD

#include "libcallback.h"

void (*lisp_release_handle)(void* handle);
int (*lisp_handle_eq)(void* a, void* b);
void (*lisp_enable_debugger)();
void (*lisp_disable_debugger)();
void (*lisp_gc)();
err_t (*callback_call_callback)(void* fn, char* out_buffer);

extern int initialize_lisp(int argc, char **argv);

CALLBACKING_API int init(char* core) {
  static int initialized = 0;
  char *init_args[] = {"", "--core", core, "--noinform", };
  if (initialized) return 1;
  if (initialize_lisp(4, init_args) != 0) return -1;
  initialized = 1;
  return 0; }
~~~

先頭には、Lisp のガベージコレクタに実行に適した時点であることを通知する `lisp_gc` など、SBCL 関連の関数がいくつかあります。次に `callback_call_callback` 関数へのポインタがあります。最後に、Lisp コードを実行する前に呼び出す `init` 関数があります。

SBCL (version 2.4.2 時点) は Lisp コアの後始末（de-initialize）に対応していなかったため、それを行う関数はありません。

`libcallback.h ` は、`lispcallback.c` と呼び出し側の任意の C コードの両方で include されるべきヘッダファイルです。これは `lispcallback.c` 内の関数と関数ポインタのプロトタイプ、エラーの `enum`、および `bindings.lisp` で追加されたコメントを取り込みます。

~~~C
typedef enum { ERR_SUCCESS = 0, ERR_FAIL = 1, } err_t;
~~~

最後のファイルである `lispcallback.py` は、ライブラリの Python ラッパーです。最も注目すべき部分は次です。

~~~Python
from ctypes import *
from ctypes.util import find_library

try:
    libpath = Path(find_library('libcallback')).resolve()
except TypeError as e:
    raise Exception('Unable to locate libcallback') from e
~~~

ファイルの残りは C のヘッダファイルと似ています。

この設定は、コンパイル済みの C ライブラリ（共有オブジェクト、DLL、dylib）をロードし、そのライブラリに含まれる関数と型を Python インタープリターに知らせます。また、Python インタープリターによってロードされたときに Lisp コアを初期化します。生成されたライブラリを C から呼び出す場合は、初期化を手動で行う必要があります。


### C コードをコンパイルする

~~~bash
cc -shared -fpic -o libcallback.so libcallback.c -L$SBCL_SRC/src/runtime -lsbcl
~~~

Mac OS ではコマンドが少し異なるかもしれません。

~~~bash
cc -dynamiclib -o libcallback.dylib libcallback.c -L$SBCL_SRC/src/runtime -lsbcl
~~~

`$SBCL_SRC/src/runtime` が `$PATH` にない場合は、`$SBCL_SRC/src/runtime/libsbcl.so` ファイルをカレントディレクトリにコピーしてください。

### 実行する

すべてセットアップできたので、次のコマンドで例のコードを実行できます。

~~~bash
$ python3 ./example.py
~~~

成功すれば、次の出力が見えるはずです。

~~~bash
I guess  it works!
~~~

## Makefile

各例には、Mac でビルドするための Makefile が付属します。`libsbcl.so` ライブラリを自動的にビルドし、カレントディレクトリへコピーすることもできます。ただし、プロジェクト（たとえば `libcallback`）をビルドするコマンドは、Linux 系オペレーティングシステムと Windows（MSYS2 使用）で動くよう修正する必要があります。

## CMake

CMake の利用は比較的わかりやすいです。残念ながら、現在 CMake に対応したライブラリや `vcpkg`/`conan` パッケージは存在しないため、必要なライブラリを見つけるには `find_library` で `HINTS` を使う必要があります。

`my_project` というプロジェクトをコンパイルし、Lisp ライブラリを追加したいと仮定すると、次のように進められます。

~~~CMake
# If there is a better way, let me know.
if(WIN32)
    set(DIR_SEPARATOR ";")
else()
    set(DIR_SEPARATOR ":")
endif()

# Set the ENV Vars for building the LISP part
set(SBCL_SRC "$ENV{SBCL_SRC}" CACHE PATH "Path to SBCL sources directory.")
set(SBCL_LIBRARIAN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../sbcl-librarian" CACHE PATH "Source codes of SBCL-LIBRARIAN project.")
set(CL_SOURCE_REGISTRY "${CMAKE_CURRENT_SOURCE_DIR}${DIR_SEPARATOR}${SBCL_LIBRARIAN_DIR}" CACHE PATH "ASDF registry for building of the libray.")

# Find the SBCL library
find_library(libsbcl NAMES sbcl HINTS ${SBCL_SRC}/src/runtime/)

# Link the library to the C project
target_link_libraries(my_project ${libsbcl})

# Build LISP part of the project
add_custom_command(OUTPUT my_project-lisp.core my_project-lisp.c my_project-lisp.h my_project-lisp.py
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMAND ${CMAKE_COMMAND} -E env CL_SOURCE_REGISTRY="${CL_SOURCE_REGISTRY}"
        ${SBCL_SRC}/run-sbcl.sh ARGS --script script.lisp
    COMMAND ${CMAKE_COMMAND} -E copy_if_different my_project-lisp.core $<TARGET_FILE_DIR:my_project>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different my_project-lisp.c $<TARGET_FILE_DIR:my_project>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different my_project-lisp.h $<TARGET_FILE_DIR:my_project>
    COMMAND ${CMAKE_COMMAND} -E copy_if_different my_project-lisp.py $<TARGET_FILE_DIR:my_project>
    COMMAND ${CMAKE_COMMAND} -E rm my_project-lisp.core my_project-lisp.c my_project-lisp.h my_project-lisp.py

# Copy SBCL library if newer
add_custom_command(TARGET my_project POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${libsbcl}"
        $<TARGET_FILE_DIR:my_project>)
~~~

これで SBCL-librarian を始めるためのチュートリアルは終わりです。Common Lisp で作れるものについて、あなたの想像力が広がり、正しい方向へ進む助けになれば幸いです。


[^1]: [LispWorks について](https://www.lispworks.com/documentation/lw70/DV/html/delivery-20.htm)、[LispWorks for Java について](https://www.lispworks.com/documentation/lw80/lw/lw-lw-ji-88.htm)、[AllegroCL について](https://franz.com/support/documentation/10.1/doc/dll.htm)。
 
#  スレッド、並行性、並列性 {#chapter-process}
 


[​]{#intro}

## はじめに

_スレッド_ とは、単一の Lisp プロセス内にあり、同じアドレス空間を共有する、独立した実行の流れを指します。通常、これらの流れの間ではシステム（Lisp カーネルまたは OS）によって実行が自動的に切り替えられるため、タスクは並列に（非同期に）完了しているように見えます。このページでは、スレッドの作成と管理、およびスレッド間の相互作用の一部について説明します。Lisp と他の _プロセス_ との相互作用については、[OS とのインターフェイス](#chapter-os) を参照してください。

不慣れな人がすぐにつまずく点として、多くの処理系では（用語上）スレッドを _processes_ と呼びます。これは、_thread_ という用語よりずっと長く存在してきた言語の歴史的な特徴です。望むなら、これを安定した処理系の成熟のしるしと呼んでもよいでしょう。

ANSI Common Lisp 標準はこの話題に触れていません。ここでは、ポータブルな
[bordeaux-threads](https://github.com/sionescu/bordeaux-threads)
ライブラリ、[SBCL Manual](http://www.sbcl.org/manual/) の [SBCL スレッド](http://www.sbcl.org/manual/#Threading) による実装例、そして [lparallel](https://lparallel.org)
ライブラリ（[GitHub](https://github.com/sharplispers/lparallel)）を紹介します。

Bordeaux-threads は、事実上の標準となっているポータブルなライブラリで、かなり低レベルなプリミティブを公開しています。Lparallel はその上に構築されており、次の機能を備えています。

-  受信用キューを使う単純なタスク投入モデル
-  細粒度の並列性を表現するための構文
-  スレッド境界を越えた **非同期コンディションハンドリング**
-  **map、reduce、sort、remove の並列版**、その他多数
-  **プロミス**、フューチャ、遅延評価構文
-  相互に接続されたタスクを並列化するための計算木
-  有界および無界の FIFO **キュー**
-  **チャネル**
-  高優先度および低優先度のタスク
-  カテゴリによるタスクの強制終了
-  統合されたタイムアウト

並列性と並行性に関する他のライブラリについては、[Awesome CL list](https://github.com/CodyReichert/awesome-cl#parallelism-and-concurrency)
および [Quickdocs](http://quickdocs.org/) の [スレッド](https://quickdocs.org/-/search?q=thread) や [並行性](https://quickdocs.org/-/search?q=concurrency) などを参照してください。

[​]{#why_bother}

### なぜわざわざ使うのか？

最初に解決すべき問いは、「なぜわざわざスレッドを使うのか」です。アプリケーションが非常に単純なので、スレッドをまったく気にする必要がない、という答えになる場合もあります。しかし、それ以外の多くの場合では、高度なアプリケーションをマルチスレッドなしで書く方法を想像するのは困難です。たとえば次のような場合です。

*   一度に複数のユーザーや接続に応答できる必要があるサーバー（たとえば Web
    サーバー。Sockets のページを参照）を書いている。
*   その処理中にメインアプリケーションを停止させず、何らかのバックグラウンド処理を行いたい。
*   一定時間が経過したときにアプリケーションへ通知したい。
*   何らかのシステムリソースが利用可能になるのを待つ間も、アプリケーションを実行中かつアクティブに保ちたい。
*   マルチスレッドを必要とする別のシステムと連携する必要がある（たとえば Windows 上の「ウィンドウ」は一般にそれぞれ自身のスレッドで動く）。
*   アプリケーションの異なる部分に、異なるコンテキスト（例: 異なる動的束縛）を対応付けたい。
*   単に 2 つのことを同時に行う必要がある。


[​]{#emergency}

### 並行性とは何か？ 並列性とは何か？

*Credit: 以下はもともと
[z0ltan.wordpress.com](https://z0ltan.wordpress.com/2016/09/02/basic-concurrency-and-parallelism-in-common-lisp-part-3-concurrency-using-bordeaux-and-sbcl-threads/)
に Timmy Jose によって書かれたものです。*

並行性は、異なる、場合によっては関連するタスクを、見かけ上同時に実行する方法です。つまり、単一プロセッサのマシン上でも、たとえばスレッドを使い、それらをコンテキストスイッチすることで同時性をシミュレートできます。

システム（ネイティブ OS）スレッドの場合、スケジューリングとコンテキストスイッチは最終的に OS によって決定されます。Java のスレッドや Common Lisp のスレッドはこの例です。

「グリーン」スレッド、つまりプログラムによって完全に管理されるスレッドの場合、スケジューリングはプログラム自身が完全に制御できます。Erlang はこのアプローチの優れた例です。

では、並行性と並列性の違いは何でしょうか？ 並列性は通常、非常に厳密な意味では、独立したタスクが異なるプロセッサまたは異なるコア上で同時に並列実行されることを意味します。この狭い意味では、単一コア、単一プロセッサのマシンで真の並列性を得ることはできません。

これら 2 つの関連する概念は、より抽象的なレベルで区別すると分かりやすくなります。並行性は主に、長時間実行される操作の最中でもシステムがロックされているように見えないよう、クライアントに同時性の錯覚を提供することを扱います。GUI システムはこの種のシステムの素晴らしい例です。したがって並行性は、必ずしも性能上の利点ではなく、良いユーザー体験を提供することに関心があります。

Java の Swing ツールキットと JavaScript はどちらもシングルスレッドですが、背後のコンテキストスイッチにより同時性があるように見せられます。もちろん、多くの場合並行性は複数のスレッドやプロセスを使って実装されます。

一方、並列性は主に純粋な性能向上に関心があります。たとえば、与えられた範囲内のすべての偶数の二乗を求めるタスクがあるとします。この範囲をチャンクに分割し、それらを異なるコアまたは異なるプロセッサ上で並列に実行し、結果を集約して最終結果を作れます。これは Map-Reduce が実際に働いている例です。

並行性の抽象的な意味を並列性の抽象的な意味から切り分けたので、次にそれらを実装するために使われる実際の機構について少し話せます。多くの人にとって混乱が生じるのはここです。抽象概念を、それを実装する具体的手段に結び付けてしまいがちなのです。本質的には、どちらの抽象概念も同じ機構で実装されることがあります。たとえば Java では、同じ基本的なスレッド機構を使って並行的な機能と並列的な機能を実装できます。私たちにとって違いを生むのは、抽象レベルでのタスク同士の概念的な絡み合い、または独立性だけです。

たとえば、作業の一部を別スレッド（場合によっては別コアや別プロセッサ）で行えるタスクがあるとします。しかし、そのスレッドを生成したスレッドが、生成されたスレッドの結果に論理的に依存している（そのためそのスレッドに “join” しなければならない）なら、それは依然として並行性です。

要するに、並行性と並列性は異なる概念ですが、その実装は同じ機構、すなわちスレッド、プロセスなどで行われることがあります。


## Bordeaux threads

Bordeaux ライブラリは、複数の Common Lisp 処理系で基本的なスレッド処理を扱うための、プラットフォーム非依存な方法を提供します。興味深い点は、それ自体が実際にネイティブスレッドを作成するわけではないことです。完全に下位の処理系に依存してそれを行います。

一方で、低レベルなスレッドの上に独自の抽象化を置き、いくつかの便利な追加機能を提供します。

また、デモプログラムを見ると、多くの Bordeaux 関数が SBCL で使われるものとかなり似ていることが分かります。これは偶然ではないと思います。

詳細についてはドキュメントを参照してください（“Wrap-up” セクションを確認してください）。

[​]{#bordeaux-threads-}

### Bordeaux-Threadsのインストール

まず Quicklisp を使って Bordeaux ライブラリをロードしましょう。

~~~lisp
CL-USER> (ql:quickload "bordeaux-threads")
To load "bordeaux-threads":
  Load 1 ASDF system:
    bordeaux-threads
; Loading "bordeaux-threads"

("bordeaux-threads")
~~~


### Common Lisp でのスレッドサポートの確認

Common Lisp 処理系にかかわらず、スレッドサポートが利用可能か確認する標準的な方法があります。

~~~lisp
CL-USER> (member :thread-support *FEATURES*)
(:THREAD-SUPPORT :SWANK :QUICKLISP :ASDF-PACKAGE-SYSTEM :ASDF3.1 :ASDF3 :ASDF2
 :ASDF :OS-MACOSX :OS-UNIX :NON-BASE-CHARS-EXIST-P :ASDF-UNICODE :64-BIT
 :64-BIT-REGISTERS :ALIEN-CALLBACKS :ANSI-CL :ASH-RIGHT-VOPS :BSD
 :C-STACK-IS-CONTROL-STACK :COMMON-LISP :COMPARE-AND-SWAP-VOPS
 :COMPLEX-FLOAT-VOPS :CYCLE-COUNTER :DARWIN :DARWIN9-OR-BETTER :FLOAT-EQL-VOPS
 :FP-AND-PC-STANDARD-SAVE :GENCGC :IEEE-FLOATING-POINT :INLINE-CONSTANTS
 :INODE64 :INTEGER-EQL-VOP :LINKAGE-TABLE :LITTLE-ENDIAN
 :MACH-EXCEPTION-HANDLER :MACH-O :MEMORY-BARRIER-VOPS :MULTIPLY-HIGH-VOPS
 :OS-PROVIDES-BLKSIZE-T :OS-PROVIDES-DLADDR :OS-PROVIDES-DLOPEN
 :OS-PROVIDES-PUTWC :OS-PROVIDES-SUSECONDS-T :PACKAGE-LOCAL-NICKNAMES
 :PRECISE-ARG-COUNT-ERROR :RAW-INSTANCE-INIT-VOPS :SB-DOC :SB-EVAL :SB-LDB
 :SB-PACKAGE-LOCKS :SB-SIMD-PACK :SB-SOURCE-LOCATIONS :SB-TEST :SB-THREAD
 :SB-UNICODE :SBCL :STACK-ALLOCATABLE-CLOSURES :STACK-ALLOCATABLE-FIXED-OBJECTS
 :STACK-ALLOCATABLE-LISTS :STACK-ALLOCATABLE-VECTORS
 :STACK-GROWS-DOWNWARD-NOT-UPWARD :SYMBOL-INFO-VOPS :UD2-BREAKPOINTS :UNIX
 :UNWIND-TO-FRAME-AND-CALL-VOP :X86-64)
~~~

スレッドサポートがない場合、この式の値として “NIL” が表示されます。

使用する具体的なライブラリによっては、並行性 サポートを確認する別の方法が用意されていることもあり、上で述べた共通の確認方法の代わりに使えます。

たとえばここでは Bordeaux ライブラリを使うことに関心があります。このライブラリでスレッドのサポートがあるかを確認するには、グローバル変数 `*supports-threads-p*` が NIL（サポートなし）または T（サポートあり）のどちらに設定されているかを見ます。

~~~lisp
CL-USER> bt:*supports-threads-p*
T
~~~

さて、これで準備ができたので、プラットフォーム非依存のライブラリ（Bordeaux）と、プラットフォーム固有のサポート（この場合は SBCL）の両方を試してみましょう。

そのために、いくつかの簡単な例を順に見ていきます。

-    基本 — 現在のスレッドを列挙する、すべてのスレッドを列挙する、スレッド名を取得する
-    スレッドからグローバル変数を更新する
-    スレッドを使って top-level にメッセージを表示する
-    top-level にメッセージを表示する — 修正版
-    top-level にメッセージを表示する — より良い版
-    複数のスレッドから共有リソースを変更する
-    複数のスレッドから共有リソースを変更する — ロックを使った修正版
-    複数のスレッドから共有リソースを変更する — アトミック操作を使う
-    スレッドに join する例、スレッドを破棄する例

### 基本 — 現在のスレッドを列挙する、すべてのスレッドを列挙する、スレッド名を取得する

~~~lisp
    ;;; Print the current thread, all the threads, and the current thread's name
    (defun print-thread-info ()
      (let* ((curr-thread (bt:current-thread))
             (curr-thread-name (bt:thread-name curr-thread))
             (all-threads (bt:all-threads)))
        (format t "Current thread: ~a~%~%" curr-thread)
        (format t "Current thread name: ~a~%~%" curr-thread-name)
        (format t "All threads:~% ~{~a~%~}~%" all-threads))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-thread-info)
    Current thread: #<THREAD "repl-thread" RUNNING {10043B8003}>

    Current thread name: repl-thread

    All threads:
     #<THREAD "repl-thread" RUNNING {10043B8003}>
    #<THREAD "auto-flush-thread" RUNNING {10043B7DA3}>
    #<THREAD "swank-indentation-cache-thread" waiting on: #<WAITQUEUE  {1003A28103}> {1003A201A3}>
    #<THREAD "reader-thread" RUNNING {1003A20063}>
    #<THREAD "control-thread" waiting on: #<WAITQUEUE  {1003A19E53}> {1003A18C83}>
    #<THREAD "Swank Sentinel" waiting on: #<WAITQUEUE  {1003790043}> {1003788023}>
    #<THREAD "main thread" RUNNING {1002991CE3}>

    NIL
~~~

スレッドからグローバル変数を更新します。

~~~lisp
    (defparameter *counter* 0)

    (defun test-update-global-variable ()
      (bt:make-thread
       (lambda ()
         (sleep 1)
         (incf *counter*)))
      *counter*)
~~~

`bt:make-thread` を使って新しいスレッドを作成します。この関数は lambda 抽象を引数として受け取ります。この lambda 抽象は引数を取れないことに注意してください。

もう 1 つ注意すべき点は、他の一部の言語（たとえば Java）とは異なり、スレッドオブジェクトの作成と、その開始や実行が分離されていないことです。この場合、スレッドは作成されるとすぐに実行されます。

出力は次のとおりです。

~~~lisp
    CL-USER> (test-update-global-variable)

    0
    CL-USER> *counter*
    1
~~~

見てのとおり、メインスレッドがただちに戻るため、`*counter*` の初期値は 0 です。その約 1 秒後、無名スレッドによって 1 に更新されます。

### スレッドを作成する: top-level にメッセージを表示する

~~~lisp
    ;;; Print a message onto the top-level using a thread
    (defun print-message-top-level-wrong ()
      (bt:make-thread
       (lambda ()
         (format *standard-output* "Hello from thread!"))
       :name "hello")
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-wrong)
    NIL
~~~

何が問題だったのでしょうか？問題は変数束縛です。`format` 関数の `t` 引数は top-level を指します。top-level はメインのコンソールストリームを表す Common Lisp の用語で、グローバル変数 `*standard-output*` によっても参照されます。そのため、出力はメインのコンソール画面に表示されると期待したかもしれません。

同じコードは、別スレッドで実行していなければ問題なく動いたでしょう。実際に起こることは、各スレッドが独自のスタックを持ち、そこで変数が再束縛されるということです。この場合、グローバル変数なので全スレッドで利用できるはずだと思いがちな `*standard-output*` でさえ、各スレッド内で再束縛されます。これは Java の ThreadLocal ストレージの概念に似ています。

### top-level にメッセージを表示する — 修正版

では、前の例の問題をどう修正すればよいでしょうか？もちろん、スレッド作成時に top-level を束縛します。純粋なレキシカルスコープの出番です。

~~~lisp
    ;;; Print a message onto the top-level using a thread — fixed
    (defun print-message-top-level-fixed ()
      (let ((top-level *standard-output*))
        (bt:make-thread
         (lambda ()
           (format top-level "Hello from thread!"))
         :name "hello"))
      nil)
~~~

これにより次の出力が得られます。

~~~lisp
    CL-USER> (print-message-top-level-fixed)
    Hello from thread!
    NIL
~~~

これで一安心です。ただし、次に見るように、非常に興味深い reader マクロを使って同じ結果を得る別の方法もあります。

### top-level にメッセージを表示する — 読み込み時 eval マクロ

まずコードを見てみましょう。

~~~lisp
    ;;; Print a message onto the top-level using a thread - reader macro

    (eval-when (:compile-toplevel)
      (defun print-message-top-level-reader-macro ()
        (bt:make-thread
         (lambda ()
           (format #.*standard-output* "Hello from thread!")))
        nil))

    (print-message-top-level-reader-macro)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-reader-macro)
    Hello from thread!
    NIL
~~~

動きました。では `eval-when` は何をしているのでしょうか。また、`*standard-output*` の前にある奇妙な `#.` という記号は何でしょうか？

`eval-when` は Lisp 式の評価がいつ行われるかを制御します。指定できる対象は `:compile-toplevel`、`:load-toplevel`、`:execute` の 3 つです。

`#.` 記号はいわゆる “Reader マクロ” です。reader（または read）マクロと呼ばれるのは、Common Lisp 式を読み込み解釈する責任を持つ Common Lisp Reader に対して特別な意味を持つためです。この特定の reader マクロは、`*standard-output*` の束縛が読み込み時に行われることを保証します。

読み込み時に値を束縛することで、スレッド実行時にも `*standard-output*` の元の値が維持され、出力が正しい top-level に表示されます。

ここで `eval-when` が効いてきます。関数定義全体を `eval-when` の中に包み、コンパイル時に評価が行われるようにすることで、`*standard-output*` の正しい値が束縛されます。`eval-when` を省略していた場合、次のエラーが表示されます。

~~~lisp
      error:
        don't know how to dump #<SWANK/GRAY::SLIME-OUTPUT-STREAM {100439EEA3}> (default MAKE-LOAD-FORM method called).
        ==>
          #<SWANK/GRAY::SLIME-OUTPUT-STREAM {100439EEA3}>

      note: The first argument never returns a value.
      note:
        deleting unreachable code
        ==>
          "Hello from thread!"


    Compilation failed.
~~~

これは理にかなっています。この出力ストリームが返すものはストリームであり、`format` 関数が期待するような、実際に定義された値ではないため、SBCL はそれを解釈できません。そのため “unreachable code” エラーが表示されます。

同じコードを REPL 上で直接実行していた場合は、すべてのシンボル解決が REPL スレッドによって正しく行われるため、問題はありません。


### 複数のスレッドから共有リソースを変更する

最小限の bank-account クラス（エラーチェックなし）を使った次の設定があるとします。

~~~lisp
    ;;; Modify a shared resource from multiple threads

    (defclass bank-account ()
      ((id :initarg :id
           :initform (error "id required")
           :accessor :id)
       (name :initarg :name
             :initform (error "name required")
             :accessor :name)
       (balance :initarg :balance
                :initform 0
                :accessor :balance)))

    (defgeneric deposit (account amount)
      (:documentation "Deposit money into the account"))

    (defgeneric withdraw (account amount)
      (:documentation "Withdraw amount from account"))

    (defmethod deposit ((account bank-account) (amount real))
      (incf (:balance account) amount))

    (defmethod withdraw ((account bank-account) (amount real))
      (decf (:balance account) amount))
~~~

そして、どうやらどのような同期も信じていない単純なクライアントがあるとします。

~~~lisp
    (defparameter *rich*
      (make-instance 'bank-account
                     :id 1
                     :name "Rich"
                     :balance 0))
    ; compiling (DEFPARAMETER *RICH* ...)

    (defun demo-race-condition ()
      (loop repeat 100
         do
           (bt:make-thread
            (lambda ()
              (loop repeat 10000 do (deposit *rich* 100))
              (loop repeat 10000 do (withdraw *rich* 100))))))
~~~

ここで行っているのはこれだけです。新しい銀行口座インスタンス（残高 0）を作成し、その後 100 個のスレッドを作成します。それぞれのスレッドは単に 100 という金額を 10000 回預け入れ、その後同じ金額を同じ回数だけ引き出します。したがって最終結果は開始時の残高、つまり 0 と同じになるはずです。確認してみましょう。

サンプル実行では、次のような結果になることがあります。

~~~lisp
    CL-USER> (:balance *rich*)
    0
    CL-USER> (dotimes (i 5)
               (demo-race-condition))
    NIL
    CL-USER> (:balance *rich*)
    22844600
~~~

おっと！この不一致の理由は、incf と decf がアトミック操作ではないことです。これらは複数の下位操作から成り、その実行順序は私たちの制御下にありません。

これが “race コンディション” と呼ばれるものです。複数のスレッドが同じ共有リソースを奪い合い、少なくとも 1 つの変更スレッドが、変更中に誤ったオブジェクト値を読み取ってしまう可能性が高い状態です。どう修正すればよいでしょうか？単純な方法の 1 つはロックを使うことです（この場合は mutex、より複雑な状況では semaphore もあり得ます）。

### 複数のスレッドから共有リソースを変更する — ロックを使った修正版

まず口座の残高を 0 に戻しましょう。

~~~lisp
    CL-USER> (setf (:balance *rich*) 0)
    0
    CL-USER> (:balance *rich*)
    0
~~~

次に、ロックを使って共有リソースにアクセスするように `demo-race-condition` 関数を変更します（`bt:make-lock` で作成し、示したように使用します）。

~~~lisp
    (defvar *lock* (bt:make-lock))
    ; compiling (DEFVAR *LOCK* …)

    (defun demo-race-condition-locks ()
      (loop repeat 100
         do
           (bt:make-thread
            (lambda ()
              (loop repeat 10000 do (bt:with-lock-held (*lock*)
                                      (deposit *rich* 100)))
              (loop repeat 10000 do (bt:with-lock-held (*lock*)
                                      (withdraw *rich* 100)))))))
    ; compiling (DEFUN DEMO-RACE-CONDITION-LOCKS ...)
~~~

今度は、より大きなサンプル実行を行ってみましょう。

~~~lisp
    CL-USER> (dotimes (i 100)
               (demo-race-condition-locks))
    NIL
    CL-USER> (:balance *rich*)
    0
~~~

素晴らしい。これで改善されました。もちろん、このように mutex を使うと性能に影響することを覚えておく必要があります。かなり多くの状況では、より良い方法があります。可能な場合はアトミック操作を使うことです。次にそれを扱います。

### 複数のスレッドから共有リソースを変更する — アトミック操作を使う

アトミック操作とは、概念上のトランザクション内ですべて発生することがシステムによって保証される操作です。つまり、主操作のすべての下位操作が外部からの干渉なしにまとめて行われます。操作は完全に成功するか、完全に失敗します。中間状態はなく、不整合な状態もありません。

もう 1 つの利点は、共有状態へのアクセスを保護するためにロックを使う場合より、性能がはるかに優れていることです。この違いは実際のデモ実行で確認します。

Bordeaux ライブラリはアトミック操作に対する実質的なサポートを提供していないため、その点では特定の処理系のサポートに依存する必要があります。ここではそれが SBCL なので、このデモは SBCL セクションに回します。

### スレッドに join する、スレッドを破棄する

スレッドに join するには `bt:join-thread` 関数を使います。スレッドを破棄するには（推奨される操作ではありませんが）`bt:destroy-thread` 関数を使えます。

単純なデモです。

~~~lisp
    (defmacro until (condition &body body)
      (let ((block-name (gensym)))
        `(block ,block-name
           (loop
               (if ,condition
                   (return-from ,block-name nil)
                   (progn
                       ,@body))))))

    (defun join-destroy-thread ()
      (let* ((s *standard-output*)
            (joiner-thread
              (bt:make-thread
                (lambda ()
                  (loop for i from 1 to 10
                     do
                       (format s "~%[Joiner Thread]  Working...")
                       (sleep (* 0.01 (random 100)))))))
            (destroyer-thread
                (bt:make-thread
                   (lambda ()
                    (loop for i from 1 to 1000000
                       do
                         (format s "~%[Destroyer Thread] Working...")
                         (sleep (* 0.01 (random 10000))))))))
        (format t "~%[Main Thread] Waiting on joiner thread...")
        (bt:join-thread joiner-thread)
        (format t "~%[Main Thread] Done waiting on joiner thread")
        (if (bt:thread-alive-p destroyer-thread)
            (progn
              (format t "~%[Main Thread] Destroyer thread alive... killing it")
              (bt:destroy-thread destroyer-thread))
            (format t "~%[Main Thread] Destroyer thread is already dead"))
        (until (bt:thread-alive-p destroyer-thread)
               (format t "[Main Thread] Waiting for destroyer thread to die..."))
        (format t "~%[Main Thread] Destroyer thread dead")
        (format t "~%[Main Thread] Adios!~%")))
~~~

ある実行での出力は次のとおりです。

~~~lisp
    CL-USER> (join-destroy-thread)

    [Joiner Thread]  Working...
    [Destroyer Thread] Working...
    [Main Thread] Waiting on joiner thread...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Main Thread] Done waiting on joiner thread
    [Main Thread] Destroyer thread alive... killing it
    [Main Thread] Destroyer thread dead
    [Main Thread] Adios!
    NIL
~~~

until マクロは、条件が真になるまで単純にループします。残りのコードはほぼ自明です。メインスレッドは joiner-thread の終了を待ちますが、destroyer-thread はただちに破棄します。

繰り返しますが、`bt:destroy-thread` の使用は推奨されません。この関数を必要とするように見える状況は、たいてい別のアプローチでより良く実現できます。

では、ここまで説明したすべての概念を結び付ける、もう少し総合的な例に進みましょう。

### タイムアウト

`bt:with-timeout` を使えます。

バックグラウンド操作を実行したいが、最大時間制限を超えないようにしたい場合があります。その場合、n を秒数として `bt:with-timeout
(n)` を使えます。タイムアウトした場合、Bordeaux-threads は `bt:timeout` エラーを通知します。

以下のシナリオでは、長時間かかる可能性のある操作を起動するスレッドを作成し、タイムアウト付きでそのスレッドに `join` し、タイムアウトエラーを処理します。ここでは、実行中のスレッドを破棄します。これにより、（`uiop:run-program` で実行されていた場合は）その下位プロセスも強制終了されます。

~~~lisp
(defun maybe-costly-operation ()
  (print "working hard...")
  (sleep 10))

(let ((thread (bt:make-thread            ;; <--- create a thread
                 (lambda ()
                   ;; maybe a long operation:
                   (maybe-costly-operation))
                 :name "maybe-costly-thread")))
    (handler-case
        (bt:with-timeout (timeout)       ;; <-- with-timeout
          (bt:join-thread thread))       ;; <-- join the thread
      (bt:timeout ()                     ;; <-- handle timeout.
        (bt:destroy-thread thread))))
~~~


### 便利な関数

デモ例で使用した関数、マクロ、グローバル変数に、いくつかの追加項目を加えた要約です。これらで基本的なプログラミングシナリオの大半をカバーできるはずです。

- `bt:*supports-thread-p*`（基本的なスレッドサポートを確認する）
- `bt:make-thread`（新しいスレッドを作成する）
- `bt:current-thread`（現在のスレッドオブジェクトを返す）
- `bt:all-threads`（実行中のすべてのスレッドのリストを返す）
- `bt:thread-alive-p`（スレッドがまだ生きているか確認する）
- `bt:thread-name`（スレッドの名前を返す）
- `bt:join-thread`（指定されたスレッドに join する）
- `bt:interrupt-thread`（指定されたスレッドに割り込む）
- `bt:destroy-thread`（スレッドの中断を試みる）
- `bt:make-lock`（ミューテックスを作成する）
- `bt:with-lock-held`（指定されたロックを使ってクリティカルコードを保護する）
- `bt:with-timeout`（タイムアウトエラーを通知する）

## SBCL threads

[SBCL](http://www.sbcl.org/) は [sb-thread](http://www.sbcl.org/manual/#Threading)
パッケージを通じてネイティブスレッドのサポートを提供します。これらは非常に低レベルな関数ですが、デモ例で示すように、その上に独自の抽象化を構築できます。

詳細についてはドキュメントを参照してください（“Wrap-up” セクションを確認してください）。

以下の例から、Bordeaux と SBCL スレッドの関数の間には強い対応関係があることが分かります。ほとんどの場合、違いはパッケージ名が bt から sb-thread に変わることだけです。

Bordeaux-Threadsライブラリがおおむね SBCL の実装を基にしていることは明らかです。そのため、構文または意味論に大きな違いがある場合にのみ説明を加えます。

### 基本 — 現在のスレッドを列挙する、すべてのスレッドを列挙する、スレッド名を取得する

コードです。


~~~lisp
    ;;; Print the current thread, all the threads, and the current thread's name

    (defun print-thread-info ()
      (let* ((curr-thread sb-thread:*current-thread*)
             (curr-thread-name (sb-thread:thread-name curr-thread))
             (all-threads (sb-thread:list-all-threads)))
        (format t "Current thread: ~a~%~%" curr-thread)
        (format t "Current thread name: ~a~%~%" curr-thread-name)
        (format t "All threads:~% ~{~a~%~}~%" all-threads))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-thread-info)
    Current thread: #<THREAD "repl-thread" RUNNING {10043B8003}>

    Current thread name: repl-thread

    All threads:
     #<THREAD "repl-thread" RUNNING {10043B8003}>
    #<THREAD "auto-flush-thread" RUNNING {10043B7DA3}>
    #<THREAD "swank-indentation-cache-thread" waiting on: #<WAITQUEUE  {1003A28103}> {1003A201A3}>
    #<THREAD "reader-thread" RUNNING {1003A20063}>
    #<THREAD "control-thread" waiting on: #<WAITQUEUE  {1003A19E53}> {1003A18C83}>
    #<THREAD "Swank Sentinel" waiting on: #<WAITQUEUE  {1003790043}> {1003788023}>
    #<THREAD "main thread" RUNNING {1002991CE3}>

    NIL
~~~

### スレッドからグローバル変数を更新する

コードです。

~~~lisp
    ;;; Update a global variable from a thread

    (defparameter *counter* 0)

    (defun test-update-global-variable ()
      (sb-thread:make-thread
       (lambda ()
         (sleep 1)
         (incf *counter*)))
      *counter*)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (test-update-global-variable)
    0
~~~

### スレッドを使って top-level にメッセージを表示する

コードです。

~~~lisp
    ;;; Print a message onto the top-level using a thread

    (defun print-message-top-level-wrong ()
      (sb-thread:make-thread
       (lambda ()
         (format *standard-output* "Hello from thread!")))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-wrong)
    NIL
~~~

top-level にメッセージを表示する — 修正版:

コードです。

~~~lisp
    ;;; Print a message onto the top-level using a thread - fixed

    (defun print-message-top-level-fixed ()
      (let ((top-level *standard-output*))
        (sb-thread:make-thread
         (lambda ()
           (format top-level "Hello from thread!"))))
      nil)
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-fixed)
    Hello from thread!
    NIL
~~~

### top-level にメッセージを表示する — より良い版

コードです。

~~~lisp
    ;;; Print a message onto the top-level using a thread - reader macro

    (eval-when (:compile-toplevel)
      (defun print-message-top-level-reader-macro ()
        (sb-thread:make-thread
         (lambda ()
           (format #.*standard-output* "Hello from thread!")))
        nil))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (print-message-top-level-reader-macro)
    Hello from thread!
    NIL
~~~

###    複数のスレッドから共有リソースを変更する

コードです。

~~~lisp
    ;;; Modify a shared resource from multiple threads

    (defclass bank-account ()
      ((id :initarg :id
           :initform (error "id required")
           :accessor :id)
       (name :initarg :name
             :initform (error "name required")
             :accessor :name)
       (balance :initarg :balance
                :initform 0
                :accessor :balance)))

    (defgeneric deposit (account amount)
      (:documentation "Deposit money into the account"))

    (defgeneric withdraw (account amount)
      (:documentation "Withdraw amount from account"))

    (defmethod deposit ((account bank-account) (amount real))
      (incf (:balance account) amount))

    (defmethod withdraw ((account bank-account) (amount real))
      (decf (:balance account) amount))

    (defparameter *rich*
      (make-instance 'bank-account
                     :id 1
                     :name "Rich"
                     :balance 0))

    (defun demo-race-condition ()
      (loop repeat 100
         do
           (sb-thread:make-thread
            (lambda ()
              (loop repeat 10000 do (deposit *rich* 100))
              (loop repeat 10000 do (withdraw *rich* 100))))))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (:balance *rich*)
    0
    CL-USER> (demo-race-condition)
    NIL
    CL-USER> (:balance *rich*)
    3987400
~~~

###    複数のスレッドから共有リソースを変更する — ロックを使った修正版

コードです。

~~~lisp
    (defvar *lock* (sb-thread:make-mutex))

    (defun demo-race-condition-locks ()
      (loop repeat 100
         do
           (sb-thread:make-thread
            (lambda ()
              (loop repeat 10000 do (sb-thread:with-mutex (*lock*)
                                      (deposit *rich* 100)))
              (loop repeat 10000 do (sb-thread:with-mutex (*lock*)
                                      (withdraw *rich* 100)))))))
~~~

ここでの唯一の違いは、Bordeaux の make-lock の代わりに `make-mutex` があり、それを例に示すように `with-mutex` マクロと一緒に使うことです。

出力は次のとおりです。

~~~lisp
    CL-USER> (:balance *rich*)
    0
    CL-USER> (demo-race-condition-locks)
    NIL
    CL-USER> (:balance *rich*)
    0
~~~

### 複数のスレッドから共有リソースを変更する — アトミック操作を使う

まずコードです。

~~~lisp
    ;;; Modify a shared resource from multiple threads - atomics

    (defgeneric atomic-deposit (account amount)
      (:documentation "Atomic version of the deposit method"))

    (defgeneric atomic-withdraw (account amount)
      (:documentation "Atomic version of the withdraw method"))

    (defmethod atomic-deposit ((account bank-account) (amount real))
      (sb-ext:atomic-incf (car (cons (:balance account) nil)) amount))

    (defmethod atomic-withdraw ((account bank-account) (amount real))
      (sb-ext:atomic-decf (car (cons (:balance account) nil)) amount))

    (defun demo-race-condition-atomics ()
      (loop repeat 100
         do (sb-thread:make-thread
             (lambda ()
               (loop repeat 10000 do (atomic-deposit *rich* 100))
               (loop repeat 10000 do (atomic-withdraw *rich* 100))))))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (dotimes (i 5)
               (format t "~%Opening: ~d" (:balance *rich*))
               (demo-race-condition-atomics)
               (format t "~%Closing: ~d~%" (:balance *rich*)))

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0

    Opening: 0
    Closing: 0
    NIL
~~~

見てのとおり、SBCL のアトミック関数は少し癖があります。ここで使っている 2 つの関数 `sb-ext:incf` と `sb-ext:atomic-decf` は、次のシグネチャを持ちます。


    Macro: atomic-incf [sb-ext] place &optional diff

and


    Macro: atomic-decf [sb-ext] place &optional diff

興味深い点は、“place” 引数が次のいずれかでなければならないことです（ドキュメントによる）。

- 宣言型が (unsigned-byte 64) の defstruct スロット、または (simple-array (unsigned-byte 64) (*)) の aref。この目的には `sb-ext:word` 型を使えます。
- cons の car または cdr（それぞれ first または REST）。
- fixnum 型として proclaim された、defglobal で定義された変数。

これが、`atomic-deposit` メソッドと `atomic-decf` メソッドで奇妙な構文が使われている理由です。

アトミック操作をできるだけ使う大きな動機の 1 つは性能です。`demo-race-condition-locks` 関数と `demo-race-condition-atomics` 関数を 1000 回実行して、性能差があるか手早く確認してみましょう。

ロックを使う場合:

~~~lisp
    CL-USER> (time
                        (loop repeat 100
                          do (demo-race-condition-locks)))
    Evaluation took:
      57.711 seconds of real time
      431.451639 seconds of total run time (408.014746 user, 23.436893 system)
      747.61% CPU
      126,674,011,941 processor cycles
      3,329,504 bytes consed

    NIL
~~~

アトミック操作を使う場合:

~~~lisp
    CL-USER> (time
                        (loop repeat 100
                         do (demo-race-condition-atomics)))
    Evaluation took:
      2.495 seconds of real time
      8.175454 seconds of total run time (6.124259 user, 2.051195 system)
      [ Run times consist of 0.420 seconds GC time, and 7.756 seconds non-GC time. ]
      327.66% CPU
      5,477,039,706 processor cycles
      3,201,582,368 bytes consed

    NIL
~~~

結果はどうでしょうか？ロック版は約 57 秒かかったのに対し、ロックなしのアトミック版はわずか 2 秒でした。これは実に大きな差です。

### スレッドに join する例、スレッドを破棄する例

コードです。

~~~lisp
;;; Joining on and destroying a thread

(defmacro until (condition &body body)
  (let ((block-name (gensym)))
    `(block ,block-name
       (loop
           (if ,condition
               (return-from ,block-name nil)
               (progn
                   ,@body))))))

(defun join-destroy-thread ()
  (let* ((s *standard-output*)
        (joiner-thread
           (sb-thread:make-thread
              (lambda ()
                (loop for i from 1 to 10
                   do
                     (format s "~%[Joiner Thread]  Working...")
                     (sleep (* 0.01 (random 100)))))))
        (destroyer-thread
           (sb-thread:make-thread
              (lambda ()
                (loop for i from 1 to 1000000
                   do
                     (format s "~%[Destroyer Thread] Working...")
                     (sleep (* 0.01 (random 10000))))))))

    (format t "~%[Main Thread] Waiting on joiner thread...")
    (bt:join-thread joiner-thread)
    (format t "~%[Main Thread] Done waiting on joiner thread")
    (if (sb-thread:thread-alive-p destroyer-thread)
        (progn
          (format t "~%[Main Thread] Destroyer thread alive... killing it")
          (sb-thread:terminate-thread destroyer-thread))
        (format t "~%[Main Thread] Destroyer thread is already dead"))
    (until (sb-thread:thread-alive-p destroyer-thread)
       (format t "[Main Thread] Waiting for destroyer thread to die..."))
    (format t "~%[Main Thread] Destroyer thread dead")
    (format t "~%[Main Thread] Adios!~%")))
~~~

出力は次のとおりです。

~~~lisp
    CL-USER> (join-destroy-thread)

    [Joiner Thread]  Working...
    [Destroyer Thread] Working...
    [Main Thread] Waiting on joiner thread...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Joiner Thread]  Working...
    [Main Thread] Done waiting on joiner thread
    [Main Thread] Destroyer thread alive... killing it
    [Main Thread] Destroyer thread dead
    [Main Thread] Adios!
    NIL
~~~

### 便利な関数

例で使った関数、マクロ、グローバル変数に、いくつかの追加項目を加えた要約リストです。

-    `(member :thread-support *features*)`（スレッドサポートを確認する）
-    `sb-thread:make-thread`（新しいスレッドを作成する）
-    `sb-thread:*current-thread*`（現在のスレッドオブジェクトを保持する）
-    `sb-thread:list-all-threads`（実行中のすべてのスレッドのリストを返す）
-    `sb-thread:thread-alive-p`（スレッドがまだ生きているか確認する）
-    `sb-thread:thread-name`（スレッドの名前を返す）
-    `sb-thread:join-thread`（指定されたスレッドに join する）
-    `sb-thread:interrupt-thread`（指定されたスレッドに interrupt する）
-    `sb-thread:destroy-thread`（スレッドの abort を試みる）
-    `sb-thread:make-mutex`（mutex を作成する）
-    `sb-thread:with-mutex`（指定されたロックを使ってクリティカルコードを保護する）

## まとめ

見てのとおり、Common Lisp における 並行性 サポートはかなり原始的です。しかし、それは主に ANSI Common Lisp 仕様にこの重要な機能が明らかに存在しないためです。とはいえ、Common Lisp 処理系が提供するサポートや、Bordeaux ライブラリのような素晴らしいライブラリの価値が少しでも損なわれるわけではありません。

この話題については、さらに多くを読んで自分で深めるべきです。ここに私自身の参考資料をいくつか共有します。

- [Common Lisp Recipes](http://weitz.de/cl-recipes/) by Edmund Weitz
- [Bordeaux API Reference](https://trac.common-lisp.net/bordeaux-threads/wiki/ApiDocumentation)
- [SBCL Manual](http://www.sbcl.org/manual/) on [Threading](http://www.sbcl.org/manual/#Threading)
- [The Common Lisp Hyperspec](https://www.lispworks.com/documentation/HyperSpec/Front/)

次は、このミニシリーズの最後の記事です。**lparallel** ライブラリを使った Common Lisp における並列性です。

## lparallel による並列プログラミング

lparallel は非同期プログラミングに対する広範なサポートも提供しており、純粋な並列プログラミングライブラリではない、という点に注意することが重要です。前述のとおり、並列性は、タスクが概念上互いに独立しているという抽象概念にすぎません。

lparallel ライブラリは Bordeaux threading ライブラリの上に構築されています。

前述したように、並列性と並行性は同じ手段、すなわちスレッド、プロセスなどを使って実装できます（そして通常そうされています）。違いは、それらの概念上の違いにあります。

この記事で示す例のすべてが必ずしも並列であるとは限らないことに注意してください。特にプロミスやフューチャのような非同期構文は、並列プログラミングよりも並行プログラミングに適しています。

lparallel ライブラリを使う基本的な手順は次のとおりです。

- `lparallel:make-kernel` を使って、ライブラリが kernel と呼ぶもののインスタンスを作成します。kernel はタスクをスケジュールし実行するコンポーネントです。
-    futures、promises、その他の高レベルな関数的概念の観点からコードを設計します。このために、lparallel は **channels**、**promises**、**futures**、**cognates** のサポートを提供します。
-    ライブラリが cognates と呼ぶものを使って操作を行います。これは単に、Common Lisp 言語自体に対応物を持つ関数です。たとえば `lparallel:pmap` 関数は、Common Lisp の `map` 関数の並列版です。
-    最後に、最初のステップで作成した kernel を `lparallel:end-kernel` で閉じます。

実行されるタスクが論理的に並列化可能であることを保証し、すべての可変状態を適切に扱う責任は開発者にあることに注意してください。

_Credit: この記事は最初に
[z0ltan.wordpress.com](https://z0ltan.wordpress.com/2016/09/09/basic-concurrency-and-parallelism-in-common-lisp-part-4a-parallelism-using-lparallel-fundamentals/)
に掲載されました。_

### インストール

lparallel が Quicklisp でダウンロード可能か確認してみましょう。

~~~lisp
CL-USER> (ql:system-apropos "lparallel")
#<SYSTEM lparallel / lparallel-20160825-git / quicklisp 2016-08-25>
#<SYSTEM lparallel-bench / lparallel-20160825-git / quicklisp 2016-08-25>
#<SYSTEM lparallel-test / lparallel-20160825-git / quicklisp 2016-08-25>
; No value
~~~

利用できるようです。インストールしましょう。

~~~lisp
CL-USER> (ql:quickload "lparallel")
To load "lparallel":
  Load 2 ASDF systems:
    alexandria bordeaux-threads
  Install 1 Quicklisp release:
    lparallel
; Fetching #<URL "http://beta.quicklisp.org/archive/lparallel/2016-08-25/lparallel-20160825-git.tgz">
; 76.71KB
==================================================
78,551 bytes in 0.62 seconds (124.33KB/sec)
; Loading "lparallel"
[package lparallel.util]..........................
[package lparallel.thread-util]...................
[package lparallel.raw-queue].....................
[package lparallel.cons-queue]....................
[package lparallel.vector-queue]..................
[package lparallel.queue].........................
[package lparallel.counter].......................
[package lparallel.spin-queue]....................
[package lparallel.kernel]........................
[package lparallel.kernel-util]...................
[package lparallel.promise].......................
[package lparallel.ptree].........................
[package lparallel.slet]..........................
[package lparallel.defpun]........................
[package lparallel.cognate].......................
[package lparallel]
(:LPARALLEL)
~~~

これだけです。では、このライブラリが実際にどのように動くか見てみましょう。

### 前準備 - コア数を取得する

まず、並列処理の例で使用するスレッド数を取得しましょう。理想的には、ワーカースレッドの数と利用可能なコア数が 1:1 で対応しているのが望ましいです。

この目的には、主要なすべてのプラットフォームで動作する `count-cpus` 関数を持つ、優れた **Serapeum** ライブラリを使えます。

インストールします。

~~~lisp
CL-USER> (ql:quickload "serapeum")
~~~

そして呼び出します。

~~~lisp
CL-USER> (serapeum:count-cpus)
8
~~~

それが正しいことを確認します。


### 共通のセットアップ

この例では、初期セットアップの部分を順に見て、セットアップが完了した後にいくつかの有用な情報も表示します。

ライブラリをロードします。

~~~lisp
CL-USER> (ql:quickload "lparallel")
To load "lparallel":
  Load 1 ASDF system:
    lparallel
; Loading "lparallel"

(:LPARALLEL)
~~~

lparallel kernel を初期化します。

~~~lisp
CL-USER> (setf lparallel:*kernel*
               (lparallel:make-kernel 8 :name "custom-kernel"))
#<LPARALLEL.KERNEL:KERNEL :NAME "custom-kernel" :WORKER-COUNT 8 :USE-CALLER NIL :ALIVE T :SPIN-COUNT 2000 {1003141F03}>
~~~

`*kernel*` グローバル変数は再束縛できることに注意してください。これにより、同じ実行中に複数の kernel を共存させられます。では、kernel に関する有用な情報をいくつか見てみましょう。

~~~lisp
CL-USER> (defun show-kernel-info ()
           (let ((name (lparallel:kernel-name))
                 (count (lparallel:kernel-worker-count))
                 (context (lparallel:kernel-context))
                 (bindings (lparallel:kernel-bindings)))
             (format t "Kernel name = ~a~%" name)
             (format t "Worker threads count = ~d~%" count)
             (format t "Kernel context = ~a~%" context)
             (format t "Kernel bindings = ~a~%" bindings)))


WARNING: redefining COMMON-LISP-USER::SHOW-KERNEL-INFO in DEFUN
SHOW-KERNEL-INFO

CL-USER> (show-kernel-info)
Kernel name = custom-kernel
Worker threads count = 8
Kernel context = #<FUNCTION FUNCALL>
Kernel bindings = ((*STANDARD-OUTPUT* . #<SLIME-OUTPUT-STREAM {10044EEEA3}>)
                   (*ERROR-OUTPUT* . #<SLIME-OUTPUT-STREAM {10044EEEA3}>))
NIL
~~~

kernel を終了します（`*kernel*` は明示的に終了するまでガベージコレクトされないため、これは重要です）。

~~~lisp
CL-USER> (lparallel:end-kernel :wait t)
(#<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {100723FA83}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {100723FE23}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {10072581E3}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007258583}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007258923}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007258CC3}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007259063}>
 #<SB-THREAD:THREAD "custom--kernel" FINISHED values: NIL {1007259403}>)
~~~

lparallel ライブラリのさまざまな側面について、さらにいくつかの例に進みましょう。

これらのデモでは、コードの観点から次の初期セットアップを使います。

~~~lisp
(require ‘lparallel)
(require ‘bt-semaphore)

(defpackage :lparallel-user
  (:use :cl :lparallel :lparallel.queue :bt-semaphore))

(in-package :lparallel-user)

;;; initialise the kernel
(defun init ()
  (setf *kernel* (make-kernel 8 :name "channel-queue-kernel")))

(init)
~~~

したがって、8 個の ワーカースレッド（マシン上の各 CPU コアに 1 つ）を持つ kernel を使います。

すべての例が終わったら、次のコードを実行して kernel を閉じ、使用したすべてのシステムリソースを解放します。

~~~lisp
;;; shut the kernel down
(defun shutdown ()
  (end-kernel :wait t))

(shutdown)
~~~

[​]{#channels--queues-}

### channels とキューを使う

まず、いくつか定義しておきましょう。

**task** は kernel に投入されるジョブです。これは単に、関数オブジェクトとその引数から成ります。

lparallel における **channel** は、Go における同じ概念に似ています。channel は単に、ワーカースレッドと通信するための手段です。ここでは、kernel にタスクを投入するための 1 つの方法です。

lparallel では `lparallel:make-channel` を使って channel を作成します。タスクは `lparallel:submit-task` で投入し、結果は `lparallel:receive-result` で受け取ります。

たとえば、数の二乗を次のように計算できます。

~~~lisp
(defun calculate-square (n)
  (let* ((channel (lparallel:make-channel))
         (res nil))
    (lparallel:submit-task channel (lambda (x)
                                       (* x x))
                           n)
    (setf res (lparallel:receive-result channel))
    (format t "Square of ~d = ~d~%" n res)))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (calculate-square 100)
Square of 100 = 10000
NIL
~~~

次に、同じ channel に複数のタスクを投入してみましょう。この単純な例では、与えられた入力をそれぞれ二乗、三乗、四乗する 3 つのタスクを作成しているだけです。

複数タスクの場合、出力の順序は非決定的になることに注意してください。

~~~lisp
(defun test-basic-channel-multiple-tasks ()
  (let ((channel (make-channel))
        (res '()))
    (submit-task channel (lambda (x)
                             (* x x))
                 10)
    (submit-task channel (lambda (y)
                             (* y y y))
                 10)
    (submit-task channel (lambda (z)
                             (* z z z z))
                 10)
     (dotimes (i 3 res)
       (push (receive-result channel) res))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (dotimes (i 3)
                              (print (test-basic-channel-multiple-tasks)))

(100 1000 10000)
(100 1000 10000)
(10000 1000 100)
NIL
~~~

lparallel は、ワーカースレッド間のメッセージパッシングを可能にするため、blocking キューを作成するサポートも提供します。キューは `lparallel.queue:make-queue` を使って作成します。

キューを使うための便利な関数には次のものがあります。

-    `lparallel.queue:make-queue`: FIFO blocking キューを作成する
-    `lparallel.queue:push-queue`: キューに要素を挿入する
-    `lparallel.queue:pop-queue`: キューから項目を pop する
-    `lparallel.queue:peek-queue`: pop せずに値を調べる
-    `lparallel.queue:queue-count`: キュー内の entry 数
-    `lparallel.queue:queue-full-p`: キューが満杯か確認する
-    `lparallel.queue:queue-empty-p`: キューが空か確認する
-    `lparallel.queue:with-locked-queue`: アクセス中にキューを lock する

キューの基本的な性質を示す基本デモです。

~~~lisp
    (defun test-queue-properties ()
      (let ((queue (make-queue :fixed-capacity 5)))
        (loop
           when (queue-full-p queue)
           do (return)
           do (push-queue (random 100) queue))
         (print (queue-full-p queue))
        (loop
           when (queue-empty-p queue)
           do (return)
           do (print (pop-queue queue)))
        (print (queue-empty-p queue)))
      nil)
~~~

これにより次の出力が得られます。

~~~lisp
    LPARALLEL-USER> (test-queue-properties)

    T
    17
    51
    55
    42
    82
    T
    NIL
~~~

注: `lparallel.queue:make-queue` は generic インターフェイスであり、実際には異なる種類のキューによって裏付けられています。たとえば前の例では、`:fixed-capacity` キーワード引数を使って固定サイズであることを指定したため、キューの実際の型は `lparallel.vector-queue` です。

ドキュメントには、`lparallel.queue:make-queue` に渡せるキーワード引数が実際には明記されていません。そのため、別の方法で調べてみましょう。

~~~lisp
    LPARALLEL-USER> (describe 'lparallel.queue:make-queue)
    LPARALLEL.QUEUE:MAKE-QUEUE
      [symbol]

    MAKE-QUEUE names a compiled function:
      Lambda-list: (&REST ARGS)
      Derived type: FUNCTION
      Documentation:
        Create a queue.

        The queue contents may be initialized with the keyword argument
        `initial-contents'.

        By default there is no limit on the queue capacity. Passing a
        `fixed-capacity' keyword argument limits the capacity to the value
        passed. `push-queue' will block for a full fixed-capacity queue.
      Source file: /Users/z0ltan/quicklisp/dists/quicklisp/software/lparallel-20160825-git/src/queue.lisp

    MAKE-QUEUE has a compiler-macro:
      Source file: /Users/z0ltan/quicklisp/dists/quicklisp/software/lparallel-20160825-git/src/queue.lisp
    ; No value
~~~

見てのとおり、次のキーワード引数をサポートしています。
*:fixed-capacity* と *initial-contents* です。

`:fixed-capacity` を指定した場合、キューの実際の型は `lparallel.vector-queue` になります。このキーワード引数を省略した場合、キューは `lparallel.cons-queue` 型（サイズ無制限のキュー）になります。これは次のスニペットの出力から分かります。

~~~lisp
    (defun check-queue-types ()
      (let ((queue-one (make-queue :fixed-capacity 5))
            (queue-two (make-queue)))
        (format t "queue-one is of type: ~a~%" (type-of queue-one))
        (format t "queue-two is of type: ~a~%" (type-of queue-two))))


    LPARALLEL-USER> (check-queue-types)
    queue-one is of type: VECTOR-QUEUE
    queue-two is of type: CONS-QUEUE
    NIL
~~~

もちろん、特定のキュー型のインスタンスを自分で作成することもいつでもできます。しかし可能な場合は、generic インターフェイスを使い、適切なキュー型の作成をライブラリに任せる方が常によいでしょう。

では、キューが実際に動く様子を見てみましょう。

~~~lisp
    (defun test-basic-queue ()
      (let ((queue (make-queue))
            (channel (make-channel))
            (res '()))
        (submit-task channel (lambda ()
                         (loop for entry = (pop-queue queue)
                            when (queue-empty-p queue)
                            do (return)
                            do (push (* entry entry) res))))
        (dotimes (i 100)
          (push-queue i queue))
        (receive-result channel)
        (format t "~{~d ~}~%" res)))
~~~

ここでは、キューが空になるまで繰り返し走査し、利用可能な値を pop して res リストに push する単一のタスクを投入しています。

出力は次のとおりです。

~~~lisp
    LPARALLEL-USER> (test-basic-queue)
    9604 9409 9216 9025 8836 8649 8464 8281 8100 7921 7744 7569 7396 7225 7056 6889 6724 6561 6400 6241 6084 5929 5776 5625 5476 5329 5184 5041 4900 4761 4624 4489 4356 4225 4096 3969 3844 3721 3600 3481 3364 3249 3136 3025 2916 2809 2704 2601 2500 2401 2304 2209 2116 2025 1936 1849 1764 1681 1600 1521 1444 1369 1296 1225 1156 1089 1024 961 900 841 784 729 676 625 576 529 484 441 400 361 324 289 256 225 196 169 144 121 100 81 64 49 36 25 16 9 4 1 0
    NIL
~~~

###    タスクを kill する

ここで `lparallel:kill-task` 関数について少し触れておくのがよいでしょう。この関数は、タスクが応答しない場合に有用です。lparallel のドキュメントは、これを最後の手段としてのみ使うべきだと明確に述べています。

作成されたすべてのタスクには、デフォルトで :default というカテゴリが割り当てられます。動的プロパティ `*task-category*` がこの値を保持しており、（後で見るように）別の値へ動的に束縛できます。

~~~lisp
;;; kill default tasks
(defun test-kill-all-tasks ()
  (let ((channel (make-channel))
        (stream *query-io*))
    (dotimes (i 10)
      (submit-task
          channel
          (lambda (x)
            (sleep (random 10))
            (format stream "~d~%" (* x x))) (random 10)))
    (sleep (random 2))
    (kill-tasks :default)))
~~~

サンプル実行:

~~~lisp
LPARALLEL-USER> (test-kill-all-tasks)
16
1
8
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
~~~

10 個のタスクを作成していたため、8 個の kernel ワーカースレッドはすべて、それぞれ 1 つのタスクで忙しかったはずです。カテゴリ :default のタスクを kill すると、これらのスレッドもすべて kill され、再生成が必要になります（これは高コストな操作です）。これが `lparallel:kill-tasks` を避けるべき理由の一部です。

上の例では、実行中のすべてのタスクが :default カテゴリに属していたため、すべて kill されました。特定のタスクだけを kill したい場合は、それらのタスクを作成するときに `*task-category*` を束縛し、`lparallel:kill-tasks` を呼び出すときにカテゴリを指定すれば実現できます。

たとえば、引数を二乗するタスクと三乗するタスクという 2 つのカテゴリがあるとします。それぞれに ’squaring-tasks と ’cubing-tasks というカテゴリを割り当てます。そして、ランダムに選んだカテゴリ ’squaring-tasks または ’cubing-tasks のタスクを kill します。

コードは次のとおりです。

~~~lisp
;;; kill tasks of a randomly chosen category
(defun test-kill-random-tasks ()
  (let ((channel (make-channel))
        (stream *query-io*))
    (let ((*task-category* 'squaring-tasks))
      (dotimes (i 5)
        (submit-task channel
                     (lambda (x)
                       (sleep (random 5))
                       (format stream "~%[Squaring] ~d = ~d"
                               x (* x x))) i)))
    (let ((*task-category* 'cubing-tasks))
      (dotimes (i 5)
        (submit-task channel
                    (lambda (x)
                       (sleep (random 5))
                       (format stream "~%[Cubing] ~d = ~d"
                               x (* x x x))) i)))
    (sleep 1)
    (if (evenp (random 10))
        (progn
          (print "Killing squaring tasks")
          (kill-tasks 'squaring-tasks))
        (progn
          (print "Killing cubing tasks")
          (kill-tasks 'cubing-tasks)))))
~~~

サンプル実行は次のとおりです。

~~~lisp
LPARALLEL-USER> (test-kill-random-tasks)

[Cubing] 2 = 8
[Squaring] 4 = 16
[Cubing] 4
 = [Cubing] 643 = 27
"Killing squaring tasks"
4
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.

[Cubing] 1 = 1
[Cubing] 0 = 0

LPARALLEL-USER> (test-kill-random-tasks)

[Squaring] 1 = 1
[Squaring] 3 = 9
"Killing cubing tasks"
5
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.

[Squaring] 2 = 4
WARNING: lparallel: Replacing lost or dead worker.
WARNING: lparallel: Replacing lost or dead worker.

[Squaring] 0 = 0
[Squaring] 4 = 16
~~~

### promises と futures を使う

Promises と Futures は非同期プログラミングのサポートを提供します。

lparallel の用語では、`lparallel:promise` は、値を与えることで fulfilled される結果のプレースホルダーです。promise オブジェクト自体は `lparallel:promise` を使って作成し、`lparallel:fulfill` マクロを使って promise に値を与えます。

promise がすでに fulfilled されているかどうかを確認するには、`lparallel:fulfilledp` 述語関数を使えます。最後に、`lparallel:force` 関数を使って promise から値を取り出します。この関数は操作が完了するまでブロックすることに注意してください。

まず非常に単純な例で、これらの概念を固めましょう。

~~~lisp
(defun test-promise ()
  (let ((p (promise)))
    (loop
       do (if (evenp (read))
              (progn
                (fulfill p 'even-received!)
                (return))))
    (force p)))
~~~

これにより次の出力が生成されます。

~~~lisp
LPARALLEL-USER> (test-promise)
5
1
3
10
EVEN-RECEIVED!
~~~

説明: この単純な例は、偶数が入力されるまで単に永久にループし続けます。ループ内で `lparallel:fulfill` を使って promise を fulfilled し、その後 `lparallel:force` で force することで値を関数から返します。

次に、もう少し大きな例を見てみましょう。promise が fulfilled されるのを待ちたくなく、その代わり現在の処理に有用な作業をさせたいとします。次の例のように、promise の fulfillment を明示的に外部へ委譲できます。

引数を二乗する関数があるとしましょう。議論のために、その処理には長い時間がかかるとします。クライアントコードからそれを呼び出し、二乗された値が利用可能になるまで待ちたいとします。


~~~lisp
(defun promise-with-threads ()
  (let ((p (promise))
        (stream *query-io*)
        (n (progn
             (princ "Enter a number: ")
             (read))))
    (format t "In main function...~%")
    (bt:make-thread
     (lambda ()
         (sleep (random 10))
         (format stream "Inside thread... fulfilling promise~%")
         (fulfill p (* n n))))
    (bt:make-thread
     (lambda ()
         (loop
            when (fulfilledp p)
            do (return)
            do (progn
                 (format stream "~d~%" (random 100))
                 (sleep (* 0.01 (random 100)))))))
    (format t "Inside main function, received value: ~d~%"
            (force p))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (promise-with-threads)
Enter a number: 19
In main function...
44
59
90
34
30
76
Inside thread... fulfilling promise
Inside main function, received value: 361
NIL
~~~

説明: この例にはそれほど多くのことはありません。promise オブジェクト p を作成し、ランダムな時間 sleep した後、値を与えて promise を fulfill するスレッドを生成します。

一方、メインスレッドでは、promise が fulfilled されているかどうかを確認し続ける別のスレッドを生成します。まだであれば、いくつかのランダムな数を表示して確認を続けます。promise が fulfilled されると、示したようにメインスレッドで `lparallel:force` を使って値を取り出せます。

これは、promise を作成したコードが promise の fulfillment を待つ必要なしに、別のスレッドが promise を fulfill できることを示しています。前述のとおり `lparallel:force` はブロッキング呼び出しなので、これは特に重要です。実際に値が利用可能になるまで、promise の force を遅らせたいのです。

promises を使う際にもう 1 つ注意すべき点は、promise が一度 fulfilled されると、同じオブジェクトに対して force を呼び出しても常に同じ値が返ることです。つまり、promise は正常には一度だけ fulfilled できます。

たとえば次のとおりです。

~~~lisp
(defun multiple-fulfilling ()
  (let ((p (promise)))
    (dotimes (i 10)
      (fulfill p (random 100))
      (format t "~d~%" (force p)))))
~~~

これにより次の出力が得られます。

~~~lisp
LPARALLEL-USER> (multiple-fulfilling)
15
15
15
15
15
15
15
15
15
15
NIL
~~~

では、future は promise とどう違うのでしょうか？

`lparallel:future` は、単に並列に実行される promise です。そのため、`lparallel:promise` のデフォルトの使い方のようにメインスレッドをブロックしません。もちろん lparallel ライブラリによって、自身のスレッドで実行されます。

future の単純な例です。

~~~lisp
(defun test-future ()
  (let ((f (future
             (sleep (random 5))
             (print "Hello from future!"))))
    (loop
       when (fulfilledp f)
       do (return)
       do (sleep (* 0.01 (random 100)))
         (format t "~d~%" (random 100)))
    (format t "~d~%" (force f))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (test-future)
5
19
91
11
Hello from future!
NIL
~~~

説明: これは `promise-with-threads` の例とまったく似ています。ただし 2 つの違いがあります。まず、`lparallel:future` マクロにも本体があります。これにより future は自分自身を fulfill できます。つまり、future の本体の実行が完了するとすぐに、`lparallel:fulfilledp` はその future オブジェクトに対して常に true を返します。

次に、future 自体はライブラリによって別スレッドに生成されるため、現在のスレッドの実行をあまり妨げません。これは、現在のスレッドをブロックしないよう fulfillment コード用に明示的なスレッドが必要だった promise-with-threads の例で見た promises とは異なります。

最も興味深い点は、（Dan Friedman らが提唱した実際の理論の観点でも）Future は概念上 Promise を fulfill するものだということです。つまり、promise は将来のある時点で何らかの値が生成されるという契約であり、future はまさにその仕事を行う「何か」です。

これは、lparallel ライブラリを使う場合でも、future の基本的な使い方は promise を fulfill することだ、という意味です。つまり promise-with-threads のようなハックをユーザーが書く必要はありません。

この点を示すため、小さな例を見てみましょう（かなり作為的な例であることは認めます）。

シナリオは次のとおりです。数を読み込み、その二乗を計算したいとします。そこで、この作業を別の関数にオフロードし、自分自身の作業を続けます。結果が準備できたら、こちらが介入しなくてもコンソールに表示されてほしいとします。

コードは次のようになります。

~~~lisp
;;; Callback example using promises and futures
(defun callback-promise-future-demo ()
  (let* ((p (promise))
         (stream *query-io*)
         (n (progn
              (princ "Enter a number: ")
              (read)))
         (f (future
              (sleep (random 10))
              (fulfill p (* n n))
              (force (future
                       (format stream "Square of ~d = ~d~%"
                               n (force p)))))))
    (loop
       when (fulfilledp f)
       do (return)
       do (sleep (* 0.01 (random 100))))))
~~~

出力は次のとおりです。

~~~lisp
LPARALLEL-USER> (callback-promise-future-demo)
Enter a number: 19
Square of 19 = 361
NIL
~~~

説明: まず、生成された二乗値を保持するための promise を作成します。これが p オブジェクトです。入力値はローカル変数 n に格納されます。

次に future オブジェクト f を作成します。この future は単に入力値を二乗し、その値で promise を fulfill します。最後に、出力を適切なタイミングで表示したいので、示したように出力文字列を表示するだけの無名 future を force します。

これは Node のような環境に非常によく似ていることに注意してください。そこでは、呼び出された関数が作業を終えたときに callback が呼ばれるという理解のもと、callback 関数を他の関数に渡します。

最後に、次のスニペットは（ブロッキングな `lparallel:force` 呼び出しを使っていても、別スレッド上なので）依然として問題ないことに注意してください。


~~~lisp
(force (future
(format stream "Square of ~d = ~d~%" n (force p))))
~~~

まとめると、一般的な使用イディオムは次のとおりです。**非同期計算の結果を保持するオブジェクトを promises として定義し、それらの promises を fulfill するために futures を使う**。

### cognates を使う - Common Lisp の対応物の並列版

Cognates は、おそらく lparallel ライブラリの存在理由です。これらの構文こそが、lparallel に真の並列性を提供します。ただし、これらの構文のほとんど（すべてではないにせよ）は futures と promises の上に構築されていることに注意してください。

簡潔に言えば、cognates は Common Lisp の対応物の並列版となることを意図した関数です。ただし、Common Lisp に対応物を持たない lparallel 独自の cognates もいくつかあります。

ここで、cognates には基本的に 2 種類あることを知っておくことが重要です。

-    細粒度の並列性のための構文: `defpun`、`plet`、`plet-if` など。
-   並列操作を行う明示的な関数とマクロ -
    `pmap`、`preduce`、`psort`、`pdotimes` など。

最初の場合、操作自体に対する明示的な制御はあまりありません。ライブラリ自身が可能な範囲でフォームを最適化し並列化する、という事実にほぼ依存します。この記事では、2 つ目のカテゴリの cognates に焦点を当てます。

たとえば、cognate 関数 `lparallel:pmap` は Common Lisp の対応物である `map` とまったく同じですが、並列に実行されます。例で示しましょう。

長さが 3 から 10 まで変化するランダムな文字列のリストがあり、その長さを vector に集めたいとします。

まず、ランダム文字列を生成する helper 関数を用意しましょう。

~~~lisp
(defvar *chars*
  (remove-duplicates
   (sort
    (loop for c across "The quick brown fox jumps over the lazy dog"
       when (alpha-char-p c)
       collect (char-downcase c))
    #'char<)))

(defun get-random-strings (&optional (count 100000))
  "generate random strings between lengths 3 and 10"
  (loop repeat count
     collect
       (concatenate 'string  (loop repeat (+ 3 (random 8))
                           collect (nth (random 26) *chars*)))))
~~~

Common Lisp の map による解決策は次のようになります。

~~~lisp
;;; map demo
(defun test-map ()
  (map 'vector #'length (get-random-strings 100)))
~~~

テスト実行してみましょう。

~~~lisp
LPARALLEL-USER> (test-map)
#(7 5 10 8 7 5 3 4 4 10)
~~~

そして、これが `lparallel:pmap` による対応版です。

~~~lisp
;;;pmap demo
(defun test-pmap ()
  (pmap 'vector #'length (get-random-strings 100)))
~~~

これにより次の出力が得られます。

~~~lisp
LPARALLEL-USER> (test-pmap)
#(8 7 6 7 6 4 5 6 5 7)
LPARALLEL-USER>
~~~

test-map と test-pmap の定義から分かるように、`lparallel:map` 関数と `lparallel:pmap` 関数の構文はまったく同じです（ほぼ同じ、というべきでしょう。`lparallel:pmap` には追加の optional 引数がいくつかあります）。

便利な cognate 関数とマクロをいくつか挙げます（明示的に示したものを除き、すべて関数です）。cognates はかなり多くありますが、各カテゴリを例で代表できるよう、いくつかを選びました。

#### lparallel:pmap: map の並列版。

すべての mapping 関数（`lparallel:pmap`、**lparallel:pmapc**、`lparallel:pmapcar` など）は、2 つの特別なキーワード引数を取ることに注意してください。

- `:size`: 処理する入力 sequence の要素数を指定します。
- `:parts`: sequence を分割する並列 part 数を指定します。

~~~lisp
    ;;; pmap - function
    (defun test-pmap ()
      (let ((numbers (loop for i below 10
                        collect i)))
        (pmap 'vector (lambda (x)
                          (* x x))
              :parts (length numbers)
              numbers)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pmap)

    #(0 1 4 9 16 25 36 49 64 81)
~~~

#### lparallel:por: or の並列版。

動作としては、引数のうち最初の non-nil 要素を返します。ただし、このマクロの並列性により、その要素は変化します。


~~~lisp
    ;;; por - macro
    (defun test-por ()
      (let ((a 100)
            (b 200)
            (c nil)
            (d 300))
        (por a b c d)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (dotimes (i 10)
                      (print (test-por)))

    300
    300
    100
    100
    100
    300
    100
    100
    100
    100
    NIL
~~~

通常の or 演算子の場合、常に最初の non-nil 要素、すなわち 100 を返していたでしょう。


#### lparallel:pdotimes: dotimes の並列版。

このマクロも optional な `:parts` 引数を取ることに注意してください。


~~~lisp
    ;;; pdotimes - macro
    (defun test-pdotimes ()
      (pdotimes (i 5)
        (declare (ignore i))
        (print (random 100))))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pdotimes)

    39
    29
    81
    42
    56
    NIL
~~~

####  lparallel:pfuncall: funcall の並列版。


~~~lisp
    ;;; pfuncall - macro
    (defun test-pfuncall ()
      (pfuncall #'* 1 2 3 4 5))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pfuncall)

    120
~~~

####    lparallel:preduce: reduce の並列版。

この非常に重要な関数も、2 つの optional keyword 引数を取ります。`:parts`（説明したものと同じ意味）と `:recurse` です。`:recurse` が non-nil の場合、引数に対して `lparallel:preduce` を再帰的に適用します。そうでなければ、デフォルトで reduce を使います。

~~~lisp
    ;;; preduce - function
    (defun test-preduce ()
      (let ((numbers (loop for i from 1 to 100
                        collect i)))
        (preduce #'+
                 numbers
                 :parts (length numbers)
                 :recurse t)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-preduce)

    5050
~~~

####    lparallel:premove-if-not: remove-if-not の並列版。

これは関数型プログラミングの用語でいう “filter” と本質的に同等です。


~~~lisp
    ;;; premove-if-not
    (defun test-premove-if-not ()
      (let ((numbers (loop for i from 1 to 100
                        collect i)))
        (premove-if-not #'evenp numbers)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-premove-if-not)

    (2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54
     56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100)
~~~

####    lparallel:pevery: every の並列版。


~~~lisp
    ;;; pevery - function
    (defun test-pevery ()
      (let ((numbers (loop for i from 1 to 100
                        collect i)))
        (list (pevery #'evenp numbers)
              (pevery #'integerp numbers))))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pevery)

    (NIL T)
~~~

この例では 2 つの確認を行っています。まず、範囲 [1,100] のすべての数が偶数かどうか。次に、同じ範囲のすべての数が整数かどうかです。

#### lparallel:count: count の並列版。

~~~lisp
    ;;; pcount - function
    (defun test-pcount ()
      (let ((chars "The quick brown fox jumps over the lazy dog"))
        (pcount #\e chars)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-pcount)

    3
~~~

####    lparallel:psort: sort の並列版。


~~~lisp
    ;;; psort - function
    (defstruct person
      name
      age)

    (defun test-psort ()
      (let* ((names (list "Peter" "Sybil" "Basil" "Candy" "Olga"))
             (people (loop for name in names
                        collect (make-person :name name
                                             :age (+ (random 20)
                                                     20)))))
        (print "Before sorting...")
        (print people)
        (fresh-line)
        (print "After sorting...")
        (psort
         people
         (lambda (x y)
             (< (person-age x)
                (person-age y)))
         :test #'=)))
~~~

サンプル実行:

~~~lisp
    LPARALLEL-USER> (test-psort)

    "Before sorting..."
    (#S(PERSON :NAME "Peter" :AGE 24) #S(PERSON :NAME "Sybil" :AGE 20)
     #S(PERSON :NAME "Basil" :AGE 22) #S(PERSON :NAME "Candy" :AGE 23)
     #S(PERSON :NAME "Olga" :AGE 33))

    "After sorting..."
    (#S(PERSON :NAME "Sybil" :AGE 20) #S(PERSON :NAME "Basil" :AGE 22)
     #S(PERSON :NAME "Candy" :AGE 23) #S(PERSON :NAME "Peter" :AGE 24)
     #S(PERSON :NAME "Olga" :AGE 33))
~~~

この例では、まず人に関する情報を保存するための person 型の構造体を定義します。次に、ランダムに生成された年齢（20 から 39 の間）を持つ 7 人のリストを作成します。最後に、年齢の非減少順でソートします。

### エラーハンドリング

lparallel がエラーハンドリングをどのように扱うか（ヒント: `lparallel:task-handler-bind`）については、
[lparallel-error-handling](https://z0ltan.wordpress.com/2016/09/10/basic-concurrency-and-parallelism-in-common-lisp-part-4b-parallelism-using-lparallel-error-handling/)
を読んでください。


## Slime でスレッドを監視・制御する

**M-x slime-list-threads**（*slime-selector* からショートカット **t** でもアクセスできます）は、実行中のスレッドを名前と状態付きで一覧表示します。

現在行のスレッドは **k** で kill できます。kill したいスレッドが多い場合は、複数行を選択して **k** を押すと、選択範囲内のすべてのスレッドを kill できます。

**g** はスレッド一覧を更新します。しかし、多くのスレッドが開始・停止している場合、毎回 **g** を押すのは面倒かもしれません。そのため `slime-threads-update-interval` という変数があります。数値 X に設定すると、スレッド一覧は X 秒ごとに自動更新されます。妥当な値は 0.5 でしょう。

[Slime tips](https://slime-tips.tumblr.com/) に感謝します。


## 参考資料

もちろん、lparallel ライブラリを使って並列計算を行うための関数、オブジェクト、イディオムは他にもたくさんあります。この記事はそれらの表面をかすめているにすぎません。しかし、操作の一般的な流れはここで十分に示されています。さらに読むには、次の資料が役立つでしょう。

- [ドキュメントを含む lparallel ライブラリの公式ホームページ](https://lparallel.org/)
- [The Common Lisp Hyperspec](https://www.lispworks.com/documentation/HyperSpec/Front/)、そしてもちろん
- 使用している Common Lisp 処理系の
  マニュアル。[SBCL については、公式マニュアルへのリンクがここにあります](http://www.sbcl.org/manual/)
- 尊敬すべき Edi Weitz による [Common Lisp recipes](http://weitz.de/cl-recipes/)。
- [Awesome-cl#parallelism-and-concurrency](https://github.com/CodyReichert/awesome-cl#parallelism-and-concurrency) リストにある、より多くの並行性およびスレッド処理のライブラリ。
 
#  システムを定義する {#chapter-systems}
 

**システム**とは、アプリケーションまたはライブラリを構成する Lisp ファイルの集まりであり、そのため全体として管理されるべきものです。**システム定義**は、どのソースファイルがシステムを構成するのか、それらの依存関係は何か、どの順序でコンパイルおよびロードされるべきかを記述します。


## ASDF

[ASDF](https://gitlab.common-lisp.net/asdf/asdf) は Common Lisp の標準ビルドシステムです。ほとんどの Common Lisp 処理系に同梱されています。[UIOP](https://gitlab.common-lisp.net/asdf/asdf/blob/master/uiop/README.md)、すなわち _"the Utilities for Implementation- and OS- Portability"_ も含まれています。[マニュアル](https://common-lisp.net/project/asdf/asdf.html) と [チュートリアルおよびベストプラクティス](https://gitlab.common-lisp.net/asdf/asdf/blob/master/doc/best_practices.md) を読むことができます。

[​]{#example}

## 簡単な例

### システム定義をロードする

Lisp を起動した時点で、Lisp は内部モジュールについては知っていますが、デフォルトでは、あなたのすばらしい新プロジェクトが `~/code/foo/bar/new-ideas/` ディレクトリの下にあることを知る方法がありません。そのため、プロジェクトをイメージにロードするには、次の3つの方法のいずれかを使います。

- ASDF または Quicklisp のデフォルトを使う
- ASDF または Quicklisp がプロジェクト定義を探す場所を設定する
- プロジェクト定義を明示的にロードする

[getting started#how-to-load-an-existing-project](https://lispcookbook.github.io/cl-cookbook/getting-started.html#how-to-load-an-existing-project) ページの該当節を読んでください。


### システムをロードする

Lisp がシステムとは何か、どこにあるかを知ったら、それをロードできます。

ASDF の最も単純な使い方は、`asdf:load-system` を呼び出してライブラリをロードすることです。その後、それを使えます。たとえば、そのライブラリが `foobar` パッケージで `some-fun` という関数を export しているなら、`(foobar:some-fun ...)` として呼び出せますし、次のようにもできます。

~~~lisp
(in-package :foobar)
(some-fun ...)
~~~

Quicklisp も使えます。

Quicklisp は内部で ASDF を呼び出します。依存関係がまだインストールされていなければ、それらをダウンロードしてインストールしてくれる利点があります。

~~~lisp
(ql:quickload "foobar")
;; =>
;; installs all dependencies
;; and loads the system.
~~~

また、Emacs コマンド `M-x slime-load-system`、またはプロンプトでの `, load-system` コマンドを使って、SLIME からシステムをロードすることもできます。この方法の面白い点は、SLIME が処理中のシステムの警告とエラーをすべて集め、ロード完了後に対話的に調べられる `*slime-compilation*` バッファに入れることです。

### システムをテストする

システムのテストを実行するには、次を使えます。

~~~lisp
(asdf:test-system :foobar)
~~~

慣習として、テストが成功しなかった場合はエラーを通知するべきです。

### システムを指定する

プログラム内でシステムを指定する適切な方法は、シンボルではなく小文字の文字列を使うことです。たとえば次のようにします。

~~~lisp
(asdf:load-system "foobar")
(asdf:test-system "foobar")
~~~

### 些細なシステム定義の書き方

些細なシステムは、プロジェクトのルートにある `foobar.lisp` という1つの Lisp ファイルだけを持つでしょう。そのファイルは、汎用ユーティリティの `alexandria` やパターンマッチングの `trivia` など、既存のライブラリに依存するとします。このシステムを ASDF でビルド可能にするため、次の内容を持つ `foobar.asd` というシステム定義ファイルを作ります。

~~~lisp
(asdf:defsystem "foobar"
  :depends-on ("alexandria" "trivia")
  :components ((:file "foobar")))
~~~


上のファイル名では、`foobar.lisp` の型 `lisp` が暗黙的であることに注意してください。そのファイルの内容は次のようになります。

~~~lisp
(defpackage :foobar
  (:use :common-lisp :alexandria :trivia)
  (:export
   #:some-function
   #:another-function
   #:call-with-foobar
   #:with-foobar))

(in-package :foobar)

(defun some-function (...)
    ...)
...
~~~

複数の完全なパッケージを `using` する代わりに、その一部だけを取り込みたい場合もあります。

~~~lisp
(defpackage :foobar
  (:use #:common-lisp)
  (:import-from #:alexandria
                #:some-function
                #:another-function))
  (:import-from #:trivia
                #:some-function
                #:another-function))
...)
~~~


#### 定義したシステムを使う

システムが `~/common-lisp/`、`~/quicklisp/local-projects/`、または ASDF 用にすでに設定された他のファイルシステム階層の下にインストールされていると仮定すると、`(asdf:load-system "foobar")` でロードできます。

そのファイルを作った時点で Lisp がすでに起動していた場合は、次のどちらかが必要になることがあります。

- 新しい .asd ファイルをロードする: `(asdf:load-asd "path/to/foobar.asd")`、または Slime で `C-c C-k` を使ってファイル全体をコンパイルしてロードします。
  - 注意: ASDF ファイルに組み込みの `load` を使うのは避けてください。動くかもしれませんが、`asdf:load-asd` が推奨されます。
- `(asdf:clear-configuration)` で設定を再処理します。


### 些細なテスト定義の書き方

どれほど些細なシステムであっても、いくらかのテストは必要です。いずれ変更されることになり、その変更が利用側のコードを壊さないことを確認したいからです。テストは期待される振る舞いを文書化するよい方法でもあります。

テストを書く最も簡単な方法は、`foobar-tests.lisp` というファイルを用意し、上の `foobar.asd` を次のように変更することです。

~~~lisp
(asdf:defsystem "foobar"
    :depends-on ("alexandria" "trivia")
    :components ((:file "foobar"))
    :in-order-to ((test-op (test-op "foobar/tests"))))

(asdf:defsystem "foobar/tests"
    :depends-on ("foobar" "fiveam")
    :components ((:file "foobar-tests"))
    :perform (test-op (o c) (symbol-call :fiveam '#:run! :foobar)))
~~~

最初のシステムの `:in-order-to` 節により、`(asdf:test-system :foobar)` を使えるようになり、それが `foobar/tests` へ連鎖します。2つ目のシステムの `:perform` 節がテストそのものを実行します。

テスト用システムでは、`fiveam` は人気のあるテストライブラリの名前であり、`perform` メソッドの内容は、このライブラリを呼び出してテストスイート `:foobar` を実行する方法です。別のライブラリを使う場合は、当然ながら事情は変わります。

## プロジェクトスケルトンを作成する

[cl-project](https://github.com/fukamachi/cl-project) を使うと、プロジェクトスケルトンを生成できます。デフォルトの ASDF 定義を作成し、ユニットテスト用のシステムを生成する、などを行います。

インストールします。

    (ql:quickload "cl-project")

プロジェクトを作成します。

~~~lisp
(cl-project:make-project #p"lib/cl-sample/"
:author "Eitaro Fukamachi"
:email "e.arrows@gmail.com"
:license "LLGPL"
:depends-on '(:clack :cl-annot))
;-> writing /Users/fukamachi/Programs/lib/cl-sample/.gitignore
;   writing /Users/fukamachi/Programs/lib/cl-sample/README.markdown
;   writing /Users/fukamachi/Programs/lib/cl-sample/cl-sample-test.asd
;   writing /Users/fukamachi/Programs/lib/cl-sample/cl-sample.asd
;   writing /Users/fukamachi/Programs/lib/cl-sample/src/hogehoge.lisp
;   writing /Users/fukamachi/Programs/lib/cl-sample/t/hogehoge.lisp
;=> T
~~~

これで完了です。
 
#  デバッグ {#chapter-debugging}
 

Lisp という新しい世界に入ると、次の疑問が出てくるでしょう。何が起きているかをどうデバッグするのか？ほかのプラットフォームよりどこが対話的なのか？スタックトレース以外に、対話的デバッガは何をもたらすのか？

## print デバッグ

もちろん有名な "print debugging" という手法は使えます。まずはいくつかの出力関数を簡単に振り返ります。

`print` は使えます。引数の `read` 可能な表現を出力します。つまり、`print` されたものは Lisp リーダで読み戻せます。引数は 1 つだけ受け取ります。

`princ` は*見た目向け*の表現に重点を置きます。

`(format t "~a" …)` は、*見た目向け*ディレクティブにより文字列を（標準出力ストリームである `t` に）出力し、nil を返します。一方 `format nil …` は何も出力せず、文字列を返します。多くの format 制御を使えば、複数の変数を一度に出力できます。

`print` にはデバッグに便利な性質があります。引数として渡されたフォームを出力し、さらにその結果を返します。アルゴリズムの途中に `print` 文を挟んでも、処理は壊れません。

~~~lisp
(+ 2 (print 40))
~~~


## ロギング

ロギングは、print デバッグからのよい進化です ;)

[log4cl](https://github.com/sharplispers/log4cl/) は人気のある、事実上の標準的なロギングライブラリです。ただし唯一の選択肢ではありません。ダウンロードします。

~~~lisp
(ql:quickload "log4cl")
~~~

ダミー変数を用意します。

~~~lisp
(defvar *foo* '(:a :b :c))
~~~

log4cl は `log` ニックネームで使えます。すると、使い方は次のように単純です。

~~~lisp
(log:info *foo*)
;; <INFO> [13:36:49] cl-user () - *FOO*: (:A :B :C)
~~~

文字列と式を、`format` 制御文字列の有無にかかわらず混在させられます。

~~~lisp
(log:info "foo is " *foo*)
;; <INFO> [13:37:22] cl-user () - foo is *FOO*: (:A :B :C)
(log:info "foo is ~{~a~}" *foo*)
;; <INFO> [13:39:05] cl-user () - foo is ABC
~~~

関連ライブラリ `log4slime` を使うと、ログレベルを対話的に変更できます。

- グローバルに
- パッケージごとに
- 関数ごとに
- CLOS メソッドと CLOS 階層（before/after メソッド）ごとに

大量の出力があるとき、すでに正しく動いていると分かっている関数やパッケージのログを止め、探索範囲を正しい場所へ絞り込めるので非常に便利です。この設定を保存し、別のイメージ、別のマシン上でも再利用できます。

これはコマンド、キーボードショートカット、メニューやマウスクリックから実行できます。

!["changing the log level with log4slime"](assets/log4cl.png)

log4cl の README も読んでみてください。

## 強力な REPL を使う

Lisp の楽しさの一部は、優れた REPL にあります。通常の作業では、REPL の存在によってほかのデバッグツールが必要になる時期が遅れます。場合によっては不要になることすらあります。

関数を定義したら、すぐ REPL で試せます。Slime では、`C-c C-c` で関数をコンパイルし（バッファ全体は `C-c C-k`）、`C-c C-z` で REPL に切り替えて試します。必要に応じて `(in-package :your-package)`、または `C-c ~`（`slime-sync-package-and-default-directory`、パッケージ定義のディレクトリへデフォルト作業ディレクトリも変更します）で作業中のパッケージに入ります。

フィードバックは即座に得られます。すべてを再コンパイルする必要も、プロセスを再起動する必要も、main 関数を作ってシェル用のコマンドライン引数を定義する必要もありません（もちろん必要になれば後でできます）。

関数をテストするために、何らかのデータを作ることがよくあります。これは REPL があることに伴う一つの技法で、初心者には新しい習慣かもしれません。コツは、テストデータを関数の近く、ただし `#+nil` feature test（またはより安全に `#+(or)`。誰かが `NIL` を `*features*` リストへ push している可能性は残るため）の下に書いておき、自分だけが手動でコンパイルできるようにすることです。

~~~lisp
#+nil
(progn
   (defvar *test-data* nil)
   (setf *test-data* (make-instance 'foo …)))
~~~

このファイルをロードしても `*test-data*` は存在しませんが、`C-c C-c` で手動作成できます。

このようにテスト用関数を定義できます。

`#| … |#` コメントの中で同様のことをする人もいます。

とはいえ、時期が来たらユニットテストを書くことを忘れないでください ;)


## inspect と describe

この 2 つのコマンドは、オブジェクトの説明を出力するという同じ目的を持ちます。`inspect` は対話的なものです。

~~~
(inspect *foo*)

The object is a proper list of length 3.
0. 0: :A
1. 1: :B

2. 2: :C
> q
~~~

対応しているエディタでは、REPL 内の任意のオブジェクトを右クリックして `inspect` することもできます（Slime では調べたいオブジェクト上で `C-c I`）。データ構造の内部へ深く潜り、変更すらできる画面が表示されます。

もう少し面白い構造、オブジェクトで簡単に見てみましょう。

~~~lisp
(defclass foo ()
    ((a :accessor foo-a :initform '(:a :b :c))
     (b :accessor foo-b :initform :b)))
;; #<STANDARD-CLASS FOO>
(make-instance 'foo)
;; #<FOO {100F2B6183}>
~~~

`#<FOO` オブジェクトを右クリックし、"inspect" を選びます。対話的なペイン（Slime の場合）が表示されます。

!["Slime's inspector, a textual window with buttons"](assets/slime-inspector.png)

スロット A の行をクリックするか Enter を押すと、さらに詳しく調べられます。

```
#<CONS {100F5E2A07}>
      --
A proper list:
0: :A
1: :B
2: :C
```

LispWorks ではグラフィカルなインスペクタを使えます。

!["The LispWorks inspector window"](assets/lispworks-graphical-inspector.png)



## Trace

[trace](http://www.lispworks.com/documentation/HyperSpec/Body/m_tracec.htm) を使うと、関数がいつ呼ばれたか、どんな引数を受け取ったか、どんな値を返したかを確認できます。

~~~lisp
(defun factorial (n)
  (if (plusp n)
    (* n (factorial (1- n)))
    1))
~~~

関数のトレースを始めるには、関数名（または複数の関数名）を指定して `trace` を呼ぶだけです。

~~~lisp
(trace factorial)

(factorial 2)
  0: (FACTORIAL 3)
    1: (FACTORIAL 2)
      2: (FACTORIAL 1)
        3: (FACTORIAL 0)
        3: FACTORIAL returned 1
      2: FACTORIAL returned 1
    1: FACTORIAL returned 2
  0: FACTORIAL returned 6
6

(untrace factorial)
~~~

すべての関数のトレースを解除するには、`(untrace)` を評価します。

現在トレースされている関数の一覧を得るには、引数なしで `(trace)` を評価します。

Slime では、関数をトレースまたはトレース解除するショートカット `C-c M-t` があります。

再帰呼び出しが見えない場合、コンパイラの最適化が原因かもしれません。トレースしたい関数を定義する前に、次を試してください。

~~~lisp
(declaim (optimize (debug 3)))  ;; 最大デバッグ設定でコンパイルするには C-u C-c C-c でもよい。
~~~

出力は `*trace-output*` に出力されます（CLHS を参照）。


### Trace オプション

`trace` はオプションを受け取ります。たとえば `:break t` を使うと、関数が呼び出される前、関数開始時にデバッガを起動できます（break については後述）。

~~~lisp
(trace factorial :break t)
(factorial 2)
~~~

`trace` の 1 回の呼び出しで多くのものを定義できます。たとえば、最初のトレース対象関数名より前に現れるオプションは*グローバル*で、その後に追加するすべてのトレース関数に影響します。ここでは、`:break t` が後続のすべての関数 `factorial`、`foo`、`bar` に設定されます。

~~~lisp
(trace :break t factorial foo bar)
~~~

逆に、オプションが関数名の後に来る場合、それは*ローカル*オプションとして、直前の関数にだけ作用します。最初に行ったのはこちらです。下では `foo` と `bar` は後に来るので、`:break` の影響を受けません。

~~~lisp
(trace factorial :break t foo bar)
~~~

しかし本当に関数呼び出しの*前*に `break` したいのでしょうか、それとも*後*でしょうか？ `:break` では、多くのオプションと同じく選べます。`:break` のオプションは次のとおりです。

```
:break form  ;; 前
:break-after form
:break-all form ;; 前と後
```

`form` は真に評価される任意のフォームです。

ここで説明したのは SBCL の trace 関数です。ほかの処理系にも同様の機能があるかもしれませんが、構文やオプション名は異なる場合があります。たとえば LispWorks では ":break-after" ではなく ":break-on-exit" で、`(trace (factorial :break t))` と書きます。

以下では、ほかのオプションをいくつか紹介します。その前に、`:break` を使った小技です。

### Trace オプション: break

オプションの引数には任意のフォームを渡せます。SBCL で、`factorial` が 0 で呼び出されようとしているときに break ウィンドウを出す小技です。`(sb-debug:arg 0)` は最初の引数 `n` を指します。

~~~lisp
CL-USER> (trace factorial :break (equal 0 (sb-debug:arg 0)))
;; WARNING: FACTORIAL is already TRACE'd, untracing it first.
;; (FACTORIAL)
~~~

もう一度実行します。

```
CL-USER> (factorial 3)
  0: (FACTORIAL 3)
    1: (FACTORIAL 2)
      2: (FACTORIAL 1)
        3: (FACTORIAL 0)

breaking before traced call to FACTORIAL:
   [Condition of type SIMPLE-CONDITION]

Restarts:
 0: [CONTINUE] Return from BREAK.
 1: [RETRY] Retry SLIME REPL evaluation request.
 2: [*ABORT] Return to SLIME's top level.
 3: [ABORT] abort thread (#<THREAD "repl-thread" RUNNING {1003551BC3}>)

Backtrace:
  0: (FACTORIAL 1)
      Locals:
        N = 1   <---------- (factorial 0) を呼ぶ前なので、n は 1。
```


### Trace オプション: 条件付きトレース、別関数から呼ばれた場合のトレース

`:condition` は、`form` 内の条件が真に評価される場合だけトレースを有効にします。

```
:condition form
:condition-after form
:condition-all form
```

> :condition が指定された場合、呼び出し時に Form が真に評価されないかぎり trace は何もしません。:condition-after も同様ですが、最初の出力を抑制し、関数が戻るときにテストされます。:condition-all は前後の両方で試します。

`:wherein` は非常に便利です。

```
:wherein Names
```

> 指定した場合、Names は関数名または名前のリストです。それらの関数のいずれかの呼び出しがこの関数の呼び出しを包んでいないかぎり（つまりバックトレースに現れないかぎり）、trace は何もしません。無名関数には "DEFUN FOO" のような文字列名があります。


```
:report Report-Type
```

> Report-Type が trace（デフォルト）の場合、情報はただちに出力されます。Report-Type が nil の場合、trace の効果はほかのオプション（print や break など）を実行することだけです。それ以外の場合、Report-Type は関数指定子として扱われ、各 trace イベントごとに 5 つの引数で funcall されます。trace の深さ（非負整数）、関数名または関数オブジェクト、キーワード（:enter、:exit、:non-local-exit）、スタックフレーム、値（引数または戻り値）のリストです。

トレース出力を豊かにするには `:print` も参照してください。

処理系が `trace` を非標準オプションで拡張するのは普通のことです。ここでは利用可能なオプションをすべて挙げたわけではないので、使っている処理系のドキュメントを参照してください。

- [SBCL trace](http://www.sbcl.org/manual/index.html#Function-Tracing)
- [CCL trace](https://ccl.clozure.com/manual/chapter4.2.html)
- [LispWorks trace](http://www.lispworks.com/documentation/lw80/lw/lw-tracer-ug-2.htm)
- [Allegro trace](https://franz.com/support/documentation/current/doc/debugging.htm#tracer-1)


### メソッド呼び出しのトレース

SBCL では、`(trace foo :methods t)` を使うとメソッド結合（before、after、around メソッド）の実行順序をトレースできます。例:

~~~lisp
(trace foo :methods t)

(foo 2.0d0)
  0: (FOO 2.0d0)
    1: ((SB-PCL::COMBINED-METHOD FOO) 2.0d0)
      2: ((METHOD FOO (FLOAT)) 2.0d0)
        3: ((METHOD FOO (T)) 2.0d0)
        3: (METHOD FOO (T)) returned 3
      2: (METHOD FOO (FLOAT)) returned 9
      2: ((METHOD FOO :AFTER (DOUBLE-FLOAT)) 2.0d0)
      2: (METHOD FOO :AFTER (DOUBLE-FLOAT)) returned DOUBLE
    1: (SB-PCL::COMBINED-METHOD FOO) returned 9
  0: FOO returned 9
9
~~~

CCL でも可能です。

もう少し情報が必要なら [CLOS][Fundamentals of CLOS] セクションを参照してください。

### 対話的 Trace Dialog

SLIME と SLY はどちらも、トレースをより見やすく表示し、引数と戻り値にも、単なる印字表現ではなくインスペクタ経由で実体の形式でアクセスできる[対話的なトレース表示](https://slime.common-lisp.dev/doc/html/SLIME-Trace-Dialog.html#SLIME-Trace-Dialog)を提供します。

![trace-dialog](trace-dialog.png "Trace dialog")

動作方法（以下の手順は SLIME 向けです）:

1. `C-c M-t` に割り当てられた `M-x slime-trace-dialog-toggle-trace` で、トレースする関数を選びます。
2. トレース対象関数を呼び出すコードを評価します。
3. `C-c T` に割り当てられた `M-x slime-trace-dialog` で trace dialog ツールを開きます。
4. トレース対象関数の一覧が `Traced specs` の下に表示されます。トレースはバッチで取得されます。そのため `[refresh]` ボタンで、トレース状況（取得可能なトレース数）を更新します。
5. 次に `[fetch next batch]` または `[fetch all]` ボタンでトレースを取得します。その後、トレースは `Traced specs` の下に表示され、SLIME インスペクタでそのデータ（引数と戻り値）を可視化できます。
6. トレース対象関数を呼び出すコードをさらに評価したら、この手順を繰り返します（ステップ 4 へ）。

ただし、この流れは、トレース状態の更新と取得が分かれているため、少し面倒になることがあります。状態更新を先に行わず、そのままトレースを取得した方がよい場合もあります。これは `G` に割り当てられた `M-x slime-trace-dialog-fetch-traces` を呼び出すことでできます。つまり、ステップ 4 と 5 の代わりに `G` を押してユーザーインターフェイスを更新します。

便利なキーに割り当てられている Emacs コマンドの一部です。

`g`
`M-x slime-trace-dialog-fetch-status`

    トレース収集と traced specs の情報を更新します。

`G`
`M-x slime-trace-dialog-fetch-traces`

    未取得のトレースの次のバッチを取得します。C-u prefix 引数を付けると、未取得のトレースがなくなるまで繰り返します。

`C-k`
`M-x slime-trace-dialog-clear-fetched-traces`

    確認を求めたうえで、取得済みと未取得の両方を含むすべてのトレースを消去します。


最後に、各トレースエントリの引数と戻り値は対話的なボタンです。クリックすると、それらに対して SLIME インスペクタが開きます。`M-RET` `M-x slime-trace-dialog-copy-down-to-repl` を呼び出すと、操作のため REPL に戻せます。各エントリの左側の数字は呼び出し順における絶対位置を示し、複数スレッドが同じトレース対象関数を呼ぶ場合には表示順と異なることがあります。

`M-x slime-trace-dialog-hide-details-mode` は引数と戻り値を隠し、呼び出しロジックに集中できるようにします。また、`M-x slime-trace-dialog-autofollow-mode` はカーソルがエントリ上を移動したときに、そのエントリの追加詳細を自動表示します。

## 対話的デバッガ

例外的な状況が起きたとき（[エラー処理](#chapter-error_handling)を参照）、または自分で要求したとき（`step` や `break` を使用）、対話的デバッガが表示されます。

そこにはエラーメッセージ、利用可能な操作（*restarts*）、バックトレースが表示されます。いくつか注意点があります。

- restarts はプログラム可能で、自分で作成できます。
- Slime では、スタックトレースのフレーム上で `v` を押すと対応するソースファイル位置を表示できます。
- フレーム上で Enter（または `t`）を押すと詳細表示を切り替えます。
- `e` を使うと、そのフレーム内でコードを評価できます。
- `r` を押すと、指定したフレームを再起動できます（後述）。
- エディタに表示されるはずのメニューから、機能を探索できます。

### 最大のデバッグ情報でコンパイルする（`declaim` と `C-u` prefix）

通常、コンパイラはさまざまなものを最適化で取り除くため、デバッガで利用できる情報量が減ります。たとえば計算途中の変数が見えないことがあります。最適化の選択は次で変更できます。

~~~lisp
(declaim (optimize (speed 0) (space 0) (debug 3)))
~~~

そしてコードを再コンパイルします。同じことは便利なショートカット `C-u C-c C-c` でもできます。このフォームは最大デバッグ設定でコンパイルされます。逆に負の prefix 引数（`M--`）を使うと速度優先でコンパイルできます。また数値引数を使うと、その設定値を指定できます（`slime-compile-defun` の docstring を読むとよいでしょう）。

同様に、現在のバッファ全体へ最大デバッグ設定を適用するには `C-u C-c C-k` を使えます。最大速度には `M--` prefix を使います。


## Step

[step](http://www.lispworks.com/documentation/HyperSpec/Body/m_step.htm) は `trace` と似た範囲を持つ対話的コマンドです。これは:

~~~lisp
;; 注: より多くのデバッグ情報を得るため、factorial をファイルにコピーした。
(step (factorial 3))
~~~

利用可能な操作（restarts）とバックトレースを含む対話的ペインを表示します。

```
Evaluating call:
  (FACTORIAL 3)
With arguments:
  3
   [Condition of type SB-EXT:STEP-FORM-CONDITION]

Restarts:
 0: [STEP-CONTINUE] Resume normal execution   <-------------------- stepping actions
 1: [STEP-OUT] Resume stepping after returning from this function
 2: [STEP-NEXT] Step over call
 3: [STEP-INTO] Step into call
 4: [RETRY] Retry SLIME REPL evaluation request.
 5: [*ABORT] Return to SLIME's top level.
 --more--

Backtrace:
  0: (FACTORIAL 3)     <----------- press Enter to fold/unfold. Fix your code and press "r" to restart it.
      Locals:
        N = 3          <----------- want to check? Move the point here and
                                    press "e" to evaluate code on that frame.

  1: (SB-INT:SIMPLE-EVAL-IN-LEXENV (LET ((SB-IMPL::*STEP-OUT* :MAYBE)) (UNWIND-PROTECT (SB-IMPL::WITH-STEPPING-ENABLED #))) #S(SB-KERNEL:LEXENV :FUNS NIL :VARS NIL :BLOCKS NIL :TAGS NIL :TYPE-RESTRICTIONS ..
  2: (SB-INT:SIMPLE-EVAL-IN-LEXENV (STEP (FACTORIAL 3)) #<NULL-LEXENV>)
  3: (EVAL (STEP (FACTORIAL 3)))
 --more--

```

*（繰り返しになりますが、関数は最大デバッグ設定でコンパイルしておいてください（上記参照）。そうでないと、コンパイラが内部で最適化を行い、ローカル変数のような有用な情報が見えなかったり、そもそもステップ実行できなかったりします。）*

ここには多くの選択肢があります。Emacs（実際にはほかのエディタでも）を使っているなら、step ウィンドウに加えて、利用可能な操作を表示する "SLDB" メニューがあることを覚えておいてください。

- restarts に従って**ステップ実行を続ける**: 実行を継続する、この関数から出る、ポイント上の関数呼び出しに入る、次の関数呼び出しまで進む、またはすべてを中止する。ショートカットは次のとおりです。
  - `c`: continue
  - `s`: step
  - `x`: step next
  - `o`: step out

- **バックトレース**とソースコードを調べる。バックトレースの各スタックフレーム（各行）で `v` を押すとソースファイルへ移動できます。スタックフレーム上で `Enter` または `t`（"toggle details"）を押すと、この呼び出しの関数パラメータなど、より多くの情報を表示できます。`n` と `p` で移動し、`M-n` と `M-p` で次または前のスタックフレームへ移動しながら、対応するソースファイルも同時に開けます。ポイントは呼び出されている関数上に置かれます。

- そのスタックフレームの**コンテキスト内でコードを評価する**。Slime では `e`（"eval in frame"、結果を pretty-print するには `d`）を使い、Lisp フォームを入力します。ポイントがあるスタックフレームのコンテキストで実行されます。変数を inspect して、Slime に別の inspector ウィンドウを開かせることすらできます。最初のフレーム（`0:`）上にいるなら、`i` を押し、次に "n" を押して中間変数を inspect します。

- 好きな場所から**実行を再開する**。ポイントがあるフレームを再起動するには `r` を使います。たとえば、（対話的デバッガを終了せずに）ソースコードを変更し、再コンパイルし、そのフレームを再実行して改善されたか確認します。プログラム全体の実行を再起動したのではありません。プログラムを正確な一点から再起動しただけです。スタックフレームから戻るには `R` を使い、戻り値を与えます。

<div class="info-box info" style="margin-bottom: 1em">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>NB:</strong> 考えてみてください。<strong>これはすごいことです！</strong> プログラムを任意の時点から再起動したのです。長時間実行される計算を扱っている場合、最初からやり直す必要はありません。問題のあるコードを変更、再コンパイルし、通過に必要な地点から実行を再開できます。
</div>

ステップ実行は貴重です。ただし、ある関数の挙動を何度も調べているなら、その関数を単純化し、より小さな部品に分ける必要があるサインかもしれません。

そして繰り返しますが、**LispWorks** には**グラフィカルなステッパ**があります。


<div class="info" style="background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 17px; margin-bottom: 1em;">
<!-- if inside a <p> then bootstrap adds 10px padding to the bottom -->
<strong>TIP:</strong> <a href="https://github.com/mmontone/slime-breakpoints">slime-breakpoints</a> パッケージは、Slime にもステップ実行と break のボタンを追加します。
</div>

![](assets/slime-breakpoints-toolbars.png)

### スタック内の任意の場所からプログラム実行を再開する（デモ）

[この動画](https://www.youtube.com/watch?v=jBBS4FeY7XM) では、上で説明した流れ、つまりバグのある関数を修正し、すべてをゼロから実行し直さずに、スタック内の任意の場所から**プログラム実行を再開する**方法のデモを見られます。この動画では Emacs と Slime、Lem エディタ、いずれも SBCL を使っています。

重要なのは、スタックフレーム上で `r`（`sldb-restart-frame`）を使って再起動することです。



## Break

[break](http://www.lispworks.com/documentation/HyperSpec/Body/f_break.htm) を呼び出すと、プログラムはデバッガに入り、そこからコールスタックを調べ、ステッパで上に述べたすべてのことを実行できます。


### Slime のブレークポイント

`SLDB` メニューを見てください。ナビゲーションキーと利用可能な操作が表示されます。その中には次のものがあります。

- `e`（*sldb-eval-in-frame*）は式の入力を促し、選択されたフレームで評価します。これにより中間変数を探索できます。
- `d` は似ていますが、結果を pretty printing します。

フレーム内に入り、不審な挙動を見つけたら、実行時に関数を再コンパイルし、停止した場所からプログラム実行を再開することもできます（"step-continue" restart を使うか、指定したスタックフレーム上で `r`（"restart frame"）を使います）。

コード注釈なしでブレークポイントを設定するには、上で触れた [Slime-star](https://github.com/mmontone/slime-star) Emacs 拡張も参照してください。

## 条件発生時に break する: `*break-on-signals*`

[*break-on-signals*](https://cl-community-spec.github.io/pages/002abreak_002don_002dsignals_002a.html) は、エラー（または任意のコンディション）が発生したことは分かるもののデバッガが出ず、そのコンディションが通知される*直前*にデバッガを強制的に開きたいとき、特に役立ちます。

たとえば、サードパーティライブラリのデータベースレコードの `print-object` メソッドが、何か問題が起きたと知らせてくるとします。

    #<DB record: <<ERROR while printing the DB object>> >

しかし、そのライブラリがエラーを処理してしまい、対話的デバッガは表示されませんでした。

これをデバッグするには、`*break-on-signals` を `'error`（または既存のコンディション型を指す任意のシンボル）に設定できます。

通常は、`*break-on-signals*` は NIL です。

~~~lisp
(ignore-errors
 (format t "*break-on-signals* value is: ~a~&" *break-on-signals*)
 (error 'simple-error :format-control "Oh no!"))
;; *break-on-signals* value is: NIL   <--- stdout
;; NIL                                <--- first returned value
;; #<SIMPLE-ERROR "Oh no!" {1205C6BC03}>  <-- second returned value, the condition object.
~~~

`*break-on-signals*` を `'error` に設定してみます。

~~~lisp
(let ((*break-on-signals* 'error))
 (format t "*break-on-signals* value is: ~a~&" *break-on-signals*)
  (ignore-errors
   (error 'simple-error :format-control "Oh no!")))
~~~

`error` が `ignore-errors` に囲まれているにもかかわらず、対話的デバッガが表示されます。

```
Oh no!
BREAK was entered because of *BREAK-ON-SIGNALS* (now rebound to NIL).
   [Condition of type SIMPLE-CONDITION]

Restarts:
 0: [CONTINUE] Return from BREAK.
 1: [RESET] Set *BREAK-ON-SIGNALS* to NIL and continue.
 2: [REASSIGN] Return from BREAK and assign a new value to *BREAK-ON-SIGNALS*.
 …

Backtrace:
 …
```

デバッガからスタックトレースを調べ、コンディションを通知した行へ移動し、修正して実行を再開できます。

通知されたコンディションがエラーの場合、ブレークを処理した後に 2 回目のデバッガには入りません。


## Advise と watch

*advise* と *watch* は、CCL（[advise](https://ccl.clozure.com/manual/chapter4.3.html#Advising) と [watch](https://ccl.clozure.com/manual/chapter4.12.html#watched-objects)）や LispWorks など、一部の処理系で利用できます。SBCL にも存在しますが、export されていません。`advise` を使うと、ソースを変更せずに関数を変更したり、実行前後に何かを行ったりできます。CLOS のメソッド結合（before、after、around メソッド）に似ています。

`watch` は、監視中のオブジェクトへスレッドが書き込もうとしたときにコンディションを通知します。GUI 内で監視対象オブジェクトを表示する機能と組み合わせることもできます。「値が変更されているが、変更元が分からない」といった種類のバグに非常に役立ちます。

## クロスリファレンス

Lisp は、関数が参照または呼び出されているすべての場所、グローバル変数が set されている場所、マクロが展開されている場所などを教えてくれます。たとえば `slime-who-calls`（`C-c C-w C-c` または Slime > Cross-Reference メニュー）は、関数が呼び出されているすべての場所を表示します。

- `slime-who-references`: グローバル変数参照
- `slime-who-bind`: グローバル変数束縛
- `slime-who-sets`: グローバル変数 setter
- `slime-who-specializes`: シンボルに特殊化されたメソッド
- `slime-who-macroexpands`: マクロが展開されている場所
- `slime-list-callees`: 指定した関数本体内で呼び出されるすべての関数を一覧表示します。
- `slime-list-callers`: 指定した関数を呼び出すすべての関数を一覧表示します。

このようなクロスリファレンス関数を呼び出すと、結果一覧を含む新しいバッファが開きます。参照間を移動でき、通常のショートカット（`C-c C-k`）で一覧された関数やマクロをすべて再コンパイルすることもできます。これは、マクロを変更したばかりで、そのマクロを使っているすべての関数を再コンパイルしたいときに特に便利です。

コマンドと Slime ショートカットの完全な一覧は Emacs ページを参照してください。


## SLY stepper と SLY stickers

SLY には改良された [stepper](https://github.com/joaotavora/sly-stepper) と、独自機能である [stickers](https://joaotavora.github.io/sly/#Stickers) があります。コードの一部に印を付けてコードを実行すると、SLY は各 sticker の結果を取得し、プログラム実行を対話的に調べられるようにします。どの sticker が取得されたか、またはされなかったかを確認できるため、その関数呼び出しにおけるコードカバレッジを一目で把握できます。

これらは `print` と `break` に対する非侵入的な代替手段です。

## ユニットテスト

最後に、独立した関数の自動テストこそ探しているものかもしれません！ [testing][Testing the code] セクションと [test frameworks and ライブラリ](https://github.com/CodyReichert/awesome-cl#unit-testing) の一覧を参照してください。


[​]{#remote-debugging}

## リモートデバッグ

ソフトウェアをネットワーク上のマシンで実行し、そこへ接続して、自宅や開発環境からデバッグできます。

手順は、リモートマシン上で **Swank server**（Swank は Slime のバックエンド伴走役です）を起動し、ssh トンネルを作成し、エディタから Swank サーバーに接続することです。すると実行中のインスタンス上で透過的にコードを閲覧、評価できます。

これを試すため、永久に出力する関数を定義しましょう。

必要なら、まず依存関係を import します。

~~~lisp
(ql:quickload '("swank" "bordeaux-threads"))
~~~


~~~lisp
;; 小さな common lisp swank デモ
;; このプログラムの実行中、別のターミナルやマシンから接続できる
;; そして doprint の定義を変更し、別のものを出力させられる！

(require :swank)
(require :bordeaux-threads)

(defparameter *counter* 0)

(defun dostuff ()
  (format t "hello world ~a!~%" *counter*))

(defun runner ()
  (swank:create-server :port 4006 :dont-close t)
  (format t "we are past go!~%")
  (bt:make-thread (lambda ()
                    (loop repeat 5 do
                          (sleep 5)
                          (dostuff)
                          (incf *counter*)))
                  :name "do-stuff"))

(runner)
~~~

サーバ上では、このコードを次で実行できます。

    sbcl --load demo.lisp

`(bt:all-threads)` で確認すると、ポート 4006 で動作中の Swank サーバーと、処理を行う準備ができた別スレッドが見えるはずです。

    (#<SB-THREAD:THREAD "do-stuff" RUNNING {10027CEDC3}>
     #<SB-THREAD:THREAD "Swank Sentinel" waiting on:
          #<WAITQUEUE  {10027D0003}>
        {10027CE8B3}>
     #<SB-THREAD:THREAD "Swank 4006" RUNNING {10027CEB63}>
     #<SB-THREAD:THREAD "main thread" RUNNING {1007C40393}>)

開発マシン上でポートフォワーディングを行います。

    ssh -L4006:127.0.0.1:4006 username@example.com

これにより、example.com のサーバ上のポート 4006 が、ローカルコンピュータのポート 4006 へ安全に転送されます（Swank は localhost からの接続だけを受け付けます）。

実行中の Swank へ `M-x slime-connect` で接続し、ホストには localhost、ポートには 4006 を選びます。

新しいコードを書けます。

~~~lisp
(defun dostuff ()
  (format t "goodbye world ~a!~%" *counter*))
(setf *counter* 0)
~~~

そして通常どおり、たとえば `C-c C-c` や `M-x slime-eval-region` で評価します。出力が変わるはずです。

Ron Garret は 1999 年に、このようにして地球から Deep Space 1 探査機をデバッグしました。

> 地上試験では現れなかった競合状態をデバッグし、修正できました。（1 億マイル離れた 1 億ドルのハードウェア上で動くプログラムをデバッグするのは興味深い経験です。探査機上で read-eval-print loop が動いていたことは、問題の発見と修正に非常に貴重でした。


## 参考資料

- ["How to understand and use Common Lisp"](https://successful-lisp.blogspot.com/p/httpsdrive.html)、第 30 章、David Lamkins（著者サイトから書籍をダウンロード）
- [Malisper: debugging Lisp series](https://malisper.me/debugging-lisp-part-1-recompilation/)
- [Two Wrongs: debugging Common Lisp in Slime](https://two-wrongs.com/debugging-common-lisp-in-slime.html)
- [Slime documentation: connecting to a remote Lisp](https://common-lisp.net/project/slime/doc/html/Connecting-to-a-remote-lisp.html#Connecting-to-a-remote-lisp)
- [cvberrycom: remotely modifying a running Lisp program using Swank](http://cvberry.com/tech_writings/howtos/remotely_modifying_a_running_program_using_swank.html)
- [Ron Garret: Lisping at the JPL](http://www.flownet.com/gat/jpl-lisp.html#1994-1999%20-%20Remote%20Agent)
- [the Remote Agent experiment: debugging code from 60 million miles away (youtube)](https://www.youtube.com/watch?v=_gZK0tW8EhQ&feature=youtu.be&t=4175)（[reddit の "AMA"](https://www.reddit.com/r/lisp/comments/a7156w/lisp_and_the_remote_agent/)）
 
#  パフォーマンスチューニングとヒント {#chapter-performance}
 

多くの Common Lisp 処理系はソースコードをアセンブリ言語に変換するため、一部のインタプリタ言語と比べて性能はとても良好です。

しかし、プログラムをもっと速くしたいこともあります。この章では CPU の力を引き出すためのいくつかの技法を紹介します。

## ボトルネックを見つける

### 実行時間を取得する

マクロ [`time`][time] はボトルネックを見つけるのにとても便利です。フォームを受け取り、それを評価し、下に示すように [`*trace-output*`][trace-output] にタイミング情報を出力します。

~~~lisp
* (defun collect (start end)
    "Collect numbers [start, end] as list."
    (loop for i from start to end
          collect i))

* (time (collect 1 10))

Evaluation took:
  0.000 seconds of real time
  0.000001 seconds of total run time (0.000001 user, 0.000000 system)
  100.00% CPU
  3,800 processor cycles
  0 bytes consed
~~~

`time` マクロを使うと、プログラムのどの部分が時間を取りすぎているか、またはメモリ（"bytes consed"）を使いすぎているかをかなり簡単に見つけられます。

ここで提供されるタイミング情報は、宣伝用の比較に十分な信頼性が保証されているわけではないことに注意してください。この章で示すように、チューニングの目的にだけ使うべきです。

### Lisp の統計的プロファイラを知る

処理系はそれぞれ独自のプロファイラを同梱しています。SBCL には、「古典的な、関数呼び出しごと」の決定的プロファイラである [sb-profile](http://www.sbcl.org/manual/#Deterministic-Profiler) と、統計的プロファイラである [sb-sprof](http://www.sbcl.org/manual/#Statistical-Profiler) があります。後者は `sb-profile:profile` のように関数を計測対象に組み込むのではなく、一定間隔でプログラムの実行のサンプルを取ることで動作します。

> common-lisp-package の関数、SBCL の内部、または計測のオーバーヘッドが過大なコードをプロファイリングする場合、決定的プロファイラより sb-sprof の方が便利かもしれません。

イメージに `sb-sprof` を読み込みます。

```lisp
(require :sb-sprof)
```

そしてマクロ `sb-sprof:with-profiling` を使います。詳細はそのドキュメントを参照してください。


### flamegraph とその他のトレース型プロファイラを使う

[cl-flamegraph](https://github.com/40ants/cl-flamegraph) は、FlameGraph の図を生成する SBCL 統計プロファイラのラッパーです。FlameGraph を使うと、コード内のボトルネックを視覚的に探せます。

![](assets/cl-flamegraph.png)

[tracer](https://github.com/TeMPOraL/tracer) も参照してください。これは SBCL 用のトレース型プロファイラです。その出力は Chrome または Chromium の Tracing Viewer（`chrome://tracing`）で表示するのに適しています。

ブラウザのインターフェイスを持つ拡張版 REPL である [ICL](https://github.com/atgreen/icl/) には、関数をプロファイルし、結果を対話的な flamegraph ビジュアライザで探索する組み込みコマンドがあります。ボトルネックを特定するために異なるビューを切り替えられます。


### アセンブリコードを確認する

関数 [`disassemble`][disassemble] は関数を受け取り、そのコンパイル済みコードを `*standard-output*` に出力します。例:

~~~lisp
* (defun plus (a b)
    (+ a b))
PLUS

* (disassemble 'plus)
; disassembly for PLUS
; Size: 37 bytes. Origin: #x52B8063B
; 3B:  498B5D60     MOV RBX, [R13+96]  ; no-arg-parsing entry point
                                       ; thread.binding-stack-pointer
; 3F:  48895DF8     MOV [RBP-8], RBX
; 43:  498BD0       MOV RDX, R8
; 46:  488BFE       MOV RDI, RSI
; 49:  FF14250102   CALL QWORD PTR [#x52100] ; GENERIC-+
; 50:  488B75E8     MOV RSI, [RBP-24]
; 54:  4C8B45F0     MOV R8, [RBP-16]
; 58:  488BE5       MOV RSP, RBP
; 5B:  F8           CLC
; 5C:  5D           POP RBP
; 5D:  C3           RET
; 5E:  CC0F         BREAK 15   ; Invalid argument count trap
~~~

上のコードは SBCL で評価されました。CLISP のような他の処理系では、`disassembly` は異なるものを返すかもしれません。

~~~lisp
* (defun plus (a b)
    (+ a b))
PLUS

* (disassemble 'plus)
Disassembly of function PLUS
2 required arguments
0 optional arguments
No rest parameter
No keyword parameters
4 byte-code instructions:
0     (LOAD&PUSH 2)
1     (LOAD&PUSH 2)
2     (CALLSR 2 55)                       ; +
5     (SKIP&RET 3)
NIL
~~~

これは、SBCL が Lisp コードを機械語にコンパイルする一方で、CLISP はそうしないためです。

[​]{#declare-expression-}

## declare 式を使う

[*declare expression*][declare] は、コンパイラに各種の最適化のヒントを与えるために使えます。これらのヒントは処理系依存であることに注意してください。SBCL のような一部の処理系はこの機能をサポートしており、詳細はそれぞれのドキュメントを参照できます。ここでは CLHS で触れられている基本的な技法だけを紹介します。

一般に、declare 式は特定のフォームの本体の先頭、または文脈が許す場合はドキュメント文字列の直後にだけ現れます。また、declare 式の内容は限られたフォームに制限されています。ここでは性能チューニングに関係するものをいくつか紹介します。

この節で紹介する最適化の手法は、選択した Lisp 処理系と強く結びついていることを覚えておいてください。`declare` を使う前に必ずそのドキュメントを確認してください。

### 速度と安全性

Lisp では、宣言 [`optimize`][optimize] を使ってコンパイラにいくつかの品質特性を指定できます。各品質には 0 から 3 の値を割り当てられ、0 は「まったく重要でない」、3 は「非常に重要」を意味します。

最も重要な品質は `safety` と `speed` かもしれません。

デフォルトでは、Lisp はコードの安全性を速度よりずっと重要だと見なします。しかし、より積極的な最適化のために重みを調整できます。

~~~lisp
* (defun max-original (a b)
    (max a b))
MAX-ORIGINAL

* (disassemble 'max-original)
; disassembly for MAX-ORIGINAL
; Size: 144 bytes. Origin: #x52D450EF
; 7A7:       8D46F1      lea eax, [rsi-15]               ; no-arg-parsing entry point
; 7AA:       A801        test al, 1
; 7AC:       750E        jne L0
; 7AE:       3C0A        cmp al, 10
; 7B0:       740A        jeq L0
; 7B2:       A80F        test al, 15
; 7B4:       7576        jne L5
; 7B6:       807EF11D    cmp byte ptr [rsi-15], 29
; 7BA:       7770        jnbe L5
; 7BC: L0:   8D43F1      lea eax, [rbx-15]
; 7BF:       A801        test al, 1
; 7C1:       750E        jne L1
; 7C3:       3C0A        cmp al, 10
; 7C5:       740A        jeq L1
; 7C7:       A80F        test al, 15
; 7C9:       755A        jne L4
; 7CB:       807BF11D    cmp byte ptr [rbx-15], 29
; 7CF:       7754        jnbe L4
; 7D1: L1:   488BD3      mov rdx, rbx
; 7D4:       488BFE      mov rdi, rsi
; 7D7:       B9C1030020  mov ecx, 536871873   ; generic->
; 7DC:       FFD1        call rcx
; 7DE:       488B75F0    mov rsi, [rbp-16]
; 7E2:       488B5DF8    mov rbx, [rbp-8]
; 7E6:       7E09        jle L3
; 7E8:       488BD3      mov rdx, rbx
; 7EB: L2:   488BE5      mov rsp, rbp
; 7EE:       F8          clc
; 7EF:       5D          pop rbp
; 7F0:       C3          ret
; 7F1: L3:   4C8BCB      mov r9, rbx
; 7F4:       4C894DE8    mov [rbp-24], r9
; 7F8:       4C8BC6      mov r8, rsi
; 7FB:       4C8945E0    mov [rbp-32], r8
; 7FF:       488BD3      mov rdx, rbx
; 802:       488BFE      mov rdi, rsi
; 805:       B929040020  mov ecx, 536871977   ; generic-=
; 80A:       FFD1        call rcx
; 80C:       4C8B45E0    mov r8, [rbp-32]
; 810:       4C8B4DE8    mov r9, [rbp-24]
; 814:       488B75F0    mov rsi, [rbp-16]
; 818:       488B5DF8    mov rbx, [rbp-8]
; 81C:       498BD0      mov rdx, r8
; 81F:       490F44D1    cmoveq rdx, r9
; 823:       EBC6        jmp L2
; 825: L4:   CC0A        break 10            ; error trap
; 827:       04          byte #X04
; 828:       13          byte #X13           ; OBJECT-NOT-REAL-ERROR
; 829:       FE9B01      byte #XFE, #X9B, #X01      ; RBX
; 82C: L5:   CC0A        break 10            ; error trap
; 82E:       04          byte #X04
; 82F:       13          byte #X13           ; OBJECT-NOT-REAL-ERROR
; 830:       FE1B03      byte #XFE, #X1B, #X03           ; RSI
; 833:       CC0A        break 10            ; error trap
; 835:       02          byte #X02
; 836:       19          byte #X19           ; INVALID-ARG-COUNT-ERROR
; 837:       9A          byte #X9A           ; RCX

* (defun max-with-speed-3 (a b)
    (declare (optimize (speed 3) (safety 0)))
    (max a b))
MAX-WITH-SPEED-3

* (disassemble 'max-with-speed-3)
; disassembly for MAX-WITH-SPEED-3
; Size: 92 bytes. Origin: #x52D452C3
; 3B:       48895DE0         mov [rbp-32], rbx                ; no-arg-parsing entry point
; 3F:       488945E8         mov [rbp-24], rax
; 43:       488BD0           mov rdx, rax
; 46:       488BFB           mov rdi, rbx
; 49:       B9C1030020       mov ecx, 536871873     ; generic->
; 4E:       FFD1             call rcx
; 50:       488B45E8         mov rax, [rbp-24]
; 54:       488B5DE0         mov rbx, [rbp-32]
; 58:       7E0C             jle L1
; 5A:       4C8BC0           mov r8, rax
; 5D: L0:   498BD0           mov rdx, r8
; 60:       488BE5           mov rsp, rbp
; 63:       F8               clc
; 64:       5D               pop rbp
; 65:       C3               ret
; 66: L1:   488945E8         mov [rbp-24], rax
; 6A:       488BF0           mov rsi, rax
; 6D:       488975F0         mov [rbp-16], rsi
; 71:       4C8BC3           mov r8, rbx
; 74:       4C8945F8         mov [rbp-8], r8
; 78:       488BD0           mov rdx, rax
; 7B:       488BFB           mov rdi, rbx
; 7E:       B929040020       mov ecx, 536871977      ; generic-=
; 83:       FFD1             call rcx
; 85:       488B45E8         mov rax, [rbp-24]
; 89:       488B75F0         mov rsi, [rbp-16]
; 8D:       4C8B45F8         mov r8, [rbp-8]
; 91:       4C0F44C6         cmoveq r8, rsi
; 95:       EBC6             jmp L0
~~~

見て分かるように、生成されたアセンブリコードはかなり短くなっています（92 bytes 対 144）。コンパイラは最適化を行えました。さらに型を宣言すれば、もっと良くできます。


### 型のヒント

[*型システム*][type] の章で述べたように、Lisp には比較的強力な型システムがあります。コンパイラが生成するコードのサイズを減らせるように型のヒントを与えられます。

~~~lisp
* (defun max-with-type (a b)
    (declare (optimize (speed 3) (safety 0)))
    (declare (type integer a b))
    (max a b))
MAX-WITH-TYPE

* (disassemble 'max-with-type)
; disassembly for MAX-WITH-TYPE
; Size: 42 bytes. Origin: #x52D48A23
; 1B:       488BF7           mov rsi, rdi                     ; no-arg-parsing entry point
; 1E:       488975F0         mov [rbp-16], rsi
; 22:       488BD8           mov rbx, rax
; 25:       48895DF8         mov [rbp-8], rbx
; 29:       488BD0           mov rdx, rax
; 2C:       B98C030020       mov ecx, 536871820    ; generic-<
; 31:       FFD1             call rcx
; 33:       488B75F0         mov rsi, [rbp-16]
; 37:       488B5DF8         mov rbx, [rbp-8]
; 3B:       480F4CDE         cmovl rbx, rsi
; 3F:       488BD3           mov rdx, rbx
; 42:       488BE5           mov rsp, rbp
; 45:       F8               clc
; 46:       5D               pop rbp
; 47:       C3               ret
~~~

生成されたアセンブリコードのサイズは約 1/3 まで縮みました。速度はどうでしょうか。

~~~lisp
* (time (dotimes (i 10000) (max-original 100 200)))
Evaluation took:
  0.000 seconds of real time
  0.000107 seconds of total run time (0.000088 user, 0.000019 system)
  100.00% CPU
  361,088 processor cycles
  0 bytes consed

* (time (dotimes (i 10000) (max-with-type 100 200)))
Evaluation took:
  0.000 seconds of real time
  0.000044 seconds of total run time (0.000036 user, 0.000008 system)
  100.00% CPU
  146,960 processor cycles
  0 bytes consed
~~~

型のヒントを指定することで、コードがずっと速く動くことが分かります。

しかし待ってください。間違った型を宣言すると何が起きるでしょうか。答えは「場合による」です。

たとえば、SBCL は型宣言を[独特なやり方][sbcl-type]で扱います。安全性のレベルに応じて異なるレベルの型検査を行います。安全性のレベルが 0 に設定されている場合、型検査は行われません。そのため、間違った型指定子は大きな損害を引き起こすかもしれません。

### `declaim` による型宣言の詳細

トップレベルで `declare` フォームを評価しようとすると、次のエラーが出るかもしれません。

~~~lisp
Execution of a form compiled with errors.
Form:
  (DECLARE (SPEED 3))
Compile-time error:
  There is no function named DECLARE.  References to DECLARE in some contexts
(like starts of blocks) are unevaluated expressions, but here the expression is
being evaluated, which invokes undefined behaviour.
   [Condition of type SB-INT:COMPILED-PROGRAM-ERROR]
~~~

これは型宣言に[スコープ][declare-scope]があるためです。上の例では、型宣言が関数に適用されるのを見ました。

開発中は、潜在的な問題をできるだけ早く見つけるために safety の重要度を上げることが普通は有用です。反対に、デプロイ後は speed の方が重要かもしれません。しかし、すべての関数に宣言式を指定するのは冗長すぎることがあります。

マクロ [`declaim`][declaim] はその可能性を提供します。ファイル内のトップレベルフォームとして使え、宣言はコンパイル時に作られます。

~~~lisp
* (declaim (optimize (speed 0) (safety 3)))
NIL

* (defun max-original (a b)
    (max a b))
MAX-ORIGINAL

* (disassemble 'max-original)
; disassembly for MAX-ORIGINAL
; Size: 181 bytes. Origin: #x52D47D9C
...

* (declaim (optimize (speed 3) (safety 3)))
NIL

* (defun max-original (a b)
    (max a b))
MAX-ORIGINAL

* (disassemble 'max-original)
; disassembly for MAX-ORIGINAL
; Size: 142 bytes. Origin: #x52D4815D
~~~

`declaim` はファイルの **コンパイル時** に動作することに注意してください。主に、一部の宣言をそのファイルにローカルにするために使われます。また、declaim のコンパイル時の副作用がファイルのコンパイル後も残るかどうかは規定されていません。


### 関数の型の宣言

もう 1 つ有用な宣言は `ftype` 宣言です。これは関数の引数の型と戻り値の型の関係を確立します。渡された引数の型が宣言された型と一致する場合、戻り値の型は宣言されたものと一致すると期待されます。そのため、1 つの関数に複数の `ftype` 宣言を関連付けられます。`ftype` 宣言は、関数が呼び出されるたびに引数の型を制限します。形は次のとおりです。

~~~lisp
 (declaim (ftype (function (arg1 arg2 ...) return-value)
                 function-name1))
~~~~

関数が `nil` を返す場合、その戻り値の型は `null` です。
この宣言は、それ自体では引数の型に制限をかけません。
与えられた引数が指定された型を持つ場合にのみ効果があります。そうでなければエラーは通知されず、宣言は効果を持ちません。たとえば、次の宣言は、関数 `square` への引数が `fixnum` なら、その関数の値も `fixnum` になることを示しています。

~~~lisp
(declaim (ftype (function (fixnum) fixnum) square))
(defun square (x) (* x x))
~~~~

`fixnum` 型と宣言されていない引数を与えると、最適化は行われません。

~~~lisp
(defun do-some-arithmetic (x)
  (the fixnum (+ x (square x))))
~~~~

では speed を最適化してみましょう。コンパイラは型が確定しないと述べます。

~~~lisp
(defun do-some-arithmetic (x)
  (declare (optimize (speed 3) (debug 0) (safety 0)))
  (the fixnum (+ x (square x))))

; compiling (DEFUN DO-SOME-ARITHMETIC ...)

; file: /tmp/slimeRzDh1R
 in: DEFUN DO-SOME-ARITHMETIC
;     (+ TEST-FRAMEWORK::X (TEST-FRAMEWORK::SQUARE TEST-FRAMEWORK::X))
;
; note: forced to do GENERIC-+ (cost 10)
;       unable to do inline fixnum arithmetic (cost 2) because:
;       The first argument is a NUMBER, not a FIXNUM.
;       unable to do inline (signed-byte 64) arithmetic (cost 5) because:
;       The first argument is a NUMBER, not a (SIGNED-BYTE 64).
;       etc.
;
; compilation unit finished
;   printed 1 note


      (disassemble 'do-some-arithmetic)
; disassembly for DO-SOME-ARITHMETIC
; Size: 53 bytes. Origin: #x52CD1D1A
; 1A:       488945F8         MOV [RBP-8], RAX   ; no-arg-parsing entry point
; 1E:       488BD0           MOV RDX, RAX
; 21:       4883EC10         SUB RSP, 16
; 25:       B902000000       MOV ECX, 2
; 2A:       48892C24         MOV [RSP], RBP
; 2E:       488BEC           MOV RBP, RSP
; 31:       E8C2737CFD       CALL #x504990F8    ; #<FDEFN SQUARE>
; 36:       480F42E3         CMOVB RSP, RBX
; 3A:       488B45F8         MOV RAX, [RBP-8]
; 3E:       488BFA           MOV RDI, RDX
; 41:       488BD0           MOV RDX, RAX
; 44:       E807EE42FF       CALL #x52100B50    ; GENERIC-+
; 49:       488BE5           MOV RSP, RBP
; 4C:       F8               CLC
; 4D:       5D               POP RBP
; 4E:       C3               RET
NIL
~~~~


ここで `x` に型宣言を追加すると、コンパイラは式 `(square x)` が `fixnum` だと仮定でき、fixnum 専用の `+` を使えます。

~~~lisp
(defun do-some-arithmetic (x)
  (declare (optimize (speed 3) (debug 0) (safety 0)))
  (declare (type fixnum x))
  (the fixnum (+ x (square x))))

       (disassemble 'do-some-arithmetic)

; disassembly for DO-SOME-ARITHMETIC
; Size: 48 bytes. Origin: #x52C084DA
; 4DA:       488945F8         MOV [RBP-8], RAX   ; no-arg-parsing entry point
; 4DE:       4883EC10         SUB RSP, 16
; 4E2:       488BD0           MOV RDX, RAX
; 4E5:       B902000000       MOV ECX, 2
; 4EA:       48892C24         MOV [RSP], RBP
; 4EE:       488BEC           MOV RBP, RSP
; 4F1:       E8020C89FD       CALL #x504990F8    ; #<FDEFN SQUARE>
; 4F6:       480F42E3         CMOVB RSP, RBX
; 4FA:       488B45F8         MOV RAX, [RBP-8]
; 4FE:       4801D0           ADD RAX, RDX
; 501:       488BD0           MOV RDX, RAX
; 504:       488BE5           MOV RSP, RBP
; 507:       F8               CLC
; 508:       5D               POP RBP
; 509:       C3               RET
NIL
~~~~

### コードのインライン化

宣言 [`inline`][inline] は、コンパイラがサポートしていれば関数呼び出しを関数本体で置き換えます。関数呼び出しのコストは節約できますが、コードサイズは増える可能性があります。`inline` を使う最適な状況は、小さいけれど頻繁に使われる関数でしょう。次のコードはコードのインライン化を促す方法と禁止する方法を示しています。

~~~lisp
;; globally defined function DISPATCH は open-coded にされるべきです。
;; implementation が inlining をサポートしており、NOTINLINE declaration が
;; この効果を上書きしない場合です。
(declaim (inline dispatch))
(defun dispatch (x) (funcall (get (car x) 'dispatch) x))

;; inlining が促される例です。
;; function DISPATCH は INLINE として定義されているため、
;; code inlining はデフォルトで促されます。
(defun use-dispatch-inline-by-default ()
  (dispatch (read-command)))

;; inlining が禁止される例です。
;; ここでの NOTINLINE はこの関数にだけ影響します。
(defun use-dispatch-with-declare-notinline  ()
  (declare (notinline dispatch))
  (dispatch (read-command)))

;; inlining が禁止される例です。
;; ここでの NOTINLINE は以後のすべての code に影響します。
(declaim (notinline dispatch))
(defun use-dispatch-with-declaim-noinline ()
  (dispatch (read-command)))

;; 指定したため inlining が促されます。
;; ここでの INLINE はこの関数にだけ影響します。
(defun use-dispatch-with-inline ()
  (declare (inline dispatch))
  (dispatch (read-command)))
~~~

インライン化された関数が変わった場合、すべての呼び出し元を再コンパイルしなければならないことに注意してください。

[​]{#generic-function-}

## 総称関数の最適化

### 静的ディスパッチを使う

総称関数は開発中に多くの利便性と柔軟性を提供します。しかし、その柔軟性にはコストがあります。総称メソッドは単純な関数よりずっと遅いのです。柔軟性が不要な場合、この性能上のコストは特に負担になります。

パッケージ [`inlined-generic-function`][inlined-generic-function] は、総称関数を静的ディスパッチに変換し、ディスパッチのコストをコンパイル時に移す関数を提供します。総称関数を `inlined-generic-function` として定義するだけで済みます。

**注意**

このパッケージは実験的と宣言されているため、本番環境の重要なソフトウェアでの利用は推奨されません。自己責任で使ってください。

~~~lisp
* (defgeneric plus (a b)
    (:generic-function-class inlined-generic-function))
#<INLINED-GENERIC-FUNCTION HELLO::PLUS (2)>

* (defmethod plus ((a fixnum) (b fixnum))
    (+ a b))
#<INLINED-METHOD HELLO::PLUS (FIXNUM FIXNUM) {10056D7513}>

* (defun func-using-plus (a b)
    (plus a b))
FUNC-USING-PLUS

* (defun func-using-plus-inline (a b)
    (declare (inline plus))
    (plus a b))
FUNC-USING-PLUS-INLINE

* (time
   (dotimes (i 100000)
     (func-using-plus 100 200)))
Evaluation took:
  0.018 seconds of real time
  0.017819 seconds of total run time (0.017800 user, 0.000019 system)
  100.00% CPU
  3 lambdas converted
  71,132,440 processor cycles
  6,586,240 bytes consed

* (time
   (dotimes (i 100000)
     (func-using-plus-inline 100 200)))
Evaluation took:
  0.001 seconds of real time
  0.000326 seconds of total run time (0.000326 user, 0.000000 system)
  0.00% CPU
  1,301,040 processor cycles
  0 bytes consed
~~~

一度インライン化されるとメソッドに加えた変更が反映されないため、インライン化はデフォルトでは有効になっていません。

[`*features*`][*features*] に `:inline-generic-function` フラグを追加すると、全体で有効化できます。

~~~lisp
* (push :inline-generic-function *features*)
(:INLINE-GENERIC-FUNCTION :SLYNK :CLOSER-MOP :CL-FAD :BORDEAUX-THREADS
:THREAD-SUPPORT :CL-PPCRE ALEXANDRIA.0.DEV::SEQUENCE-EMPTYP :QUICKLISP
:QUICKLISP-SUPPORT-HTTPS :SB-BSD-SOCKETS-ADDRINFO :ASDF3.3 :ASDF3.2 :ASDF3.1
:ASDF3 :ASDF2 :ASDF :OS-UNIX :NON-BASE-CHARS-EXIST-P :ASDF-UNICODE :ROS.INIT
:X86-64 :64-BIT :64-BIT-REGISTERS :ALIEN-CALLBACKS :ANSI-CL :AVX2
:C-STACK-IS-CONTROL-STACK :CALL-SYMBOL :COMMON-LISP :COMPACT-INSTANCE-HEADER
:COMPARE-AND-SWAP-VOPS :CYCLE-COUNTER :ELF :FP-AND-PC-STANDARD-SAVE ..)
~~~

このフィーチャが存在する場合、`notinline` と宣言されていない限り、インライン化可能なすべての総称関数がインライン化されます。

## 複数の戻り値

通常、`values` と `multiple-value-bind ` は "cons" しません。一方 `(cons a b)` の呼び出しはヒープに割り当てます。これらを使いましょう。

parcom ライブラリ [parcom][parcom] では、`cons` の代わりに `values` を使うことでメモリ使用量が 30% 減りました。

## スタックへの割り当て

`(declare (dynamic-extent your-variable))` により、ローカル変数をヒープではなくスタックに割り当ててほしいとコンパイラに伝えられます。関数が戻るとメモリは自動的に解放されます。


## ブロックコンパイル

SBCL は [version 2.0.2 でブロックコンパイルを得ました](https://mstmetent.blogspot.com/2020/02/block-compilation-fresh-in-sbcl-202.html)。これは CMUCL では 1991 年からありましたが、少し忘れられていました。

ブロックコンパイルは 1 行で有効化できます。

~~~lisp
(setq *block-compile-default* t)
~~~

ではこれは何でしょうか。

ブロックコンパイルは動的言語のよく知られた側面に対処します。グローバルなトップレベル関数への関数呼び出しは高価です。

> 静的にコンパイルされる言語よりはるかに高価です。遅い理由は、トップレベルで定義された関数の遅延束縛という性質にあります。プログラムが実行中に任意に再定義できるため、その関数が正しい数や型の引数で呼び出されているかについて実行時検査を強制されます。この種の呼び出しは Python（CMUCL と SBCL で使われるコンパイラであり、プログラミング言語と混同しないでください）で "full call" と呼ばれ、その呼び出し規約は最大限の実行時の柔軟性を許します。

しかしローカル呼び出し、つまりトップレベル関数の内側にあるもの（たとえば `lambda`、`labels`、`flet`）は高速です。

> これらの呼び出しは、静的な言語の関数呼び出しに近いものとして扱われるという意味で、より「静的」です。参照しているローカル関数と「一緒に」同時にコンパイルされ、コンパイル時に最適化できるためです。たとえば、呼び出し先の引数数がコンパイル時に分かるため、引数の検査はコンパイル時に行えます。full call の場合は、関数と、それが取る引数数が実行時の任意の時点で動的に変わり得るため、そうではありません。さらに、ローカル呼び出しの呼び出し規約では float のような unboxed な値を渡せる場合があります。これらは、full call の規約では使われない unboxed なレジスタに入れられるからです。full call の規約は boxed な引数および戻り値のレジスタを使わなければなりません。

つまりブロックコンパイルを有効にすると、コードが巨大な `labels` フォームになるようなものです。

アプリケーションによっては明白な、起こりうる欠点の 1 つは、実行時に関数を再定義できなくなることです。

`compile-file` に `:block-compile` キーワードを渡してブロックコンパイルを有効化することもできます。

~~~lisp
(defun foo (x y)
  (print (bar x y))
  (bar x y))

(defun bar (x y)
  (+ x y))

(defun fact (n)
  (if (zerop n)
      1
      (* n (fact (1- n)))))

> (compile-file "foo.lisp" :block-compile t :entry-points nil)
> (load "foo.fasl")

> (sb-disassem:disassemble-code-component #'foo)
~~~

アセンブリを調べると、

> FOO と BAR が同じコンポーネント（ローカル呼び出し付き）にコンパイルされ、両方とも有効な外部エントリポイントを持つことが分かるでしょう。これによりコードの局所性がかなり改善され、それでもファイルの外部（たとえば REPL）から FOO と BAR の両方を呼び出せます。[…]

しかしブロックコンパイルが追加する良い点はもう 1 つあります。

> 上で `:entry-points` nil を指定したことに注意してください。これは、ファイル内のすべての関数に外部エントリポイントをまだ作成するようコンパイラに伝えています。コードコンポーネント（つまりコンパイル済みのコンパイル単位、ここではファイル全体）の外から通常どおり呼び出せるようにしたいからです。

さらなる説明については、SBCL の現在の事実上のドキュメントである前述のブログ記事と、[CMUCL's documentation](https://cmucl.org/docs/cmu-user/html/Block-Compilation.html) を参照してください（CMUCL にあるフォームごとの細かい粒度（` (declaim (start-block ...)) ... (declaim (end-block ..))`）は、執筆時点の SBCL にはないことに注意してください）。

最後に、「ブロックコンパイルとインライン化は現状 [SBCL では] あまりうまく連携しない」ことに注意してください。

## 参考

* [CMUCL's Advanced Compiler Use and Efficiency Hints](https://cmucl.org/downloads/doc/cmu-user-2010-05-03/compiler-hint.html)。SBCL はここから来ています。
* [Common Lisp の最適化（parcom ライブラリ向け）](https://www.fosskers.ca/en/blog/optimizing-common-lisp)
* [Idiomatic Lisp and the nbody benchmark](https://www.stylewarning.com/posts/nbody/) (2026) - Lisp の DSL、C と同等の性能の達成、可読性、再利用性、そして Lisp 固有の追加の利点について。


[time]: http://www.lispworks.com/documentation/lw51/CLHS/Body/m_time.htm
[trace-output]: http://www.lispworks.com/documentation/lw71/CLHS/Body/v_debug_.htm#STtrace-outputST
[disassemble]: http://www.lispworks.com/documentation/lw60/CLHS/Body/f_disass.htm
[inlined-generic-function]: https://github.com/guicho271828/inlined-generic-function
[type]: type.html
[declare]: http://www.lispworks.com/documentation/lw71/CLHS/Body/s_declar.htm
[declare-scope]: http://www.lispworks.com/documentation/lw71/CLHS/Body/03_cd.htm
[optimize]: http://www.lispworks.com/documentation/lw71/CLHS/Body/d_optimi.htm
[sbcl-type]: http://sbcl.org/manual/index.html#Handling-of-Types
[declaim]: http://www.lispworks.com/documentation/lw71/CLHS/Body/m_declai.htm
[inline]: http://www.lispworks.com/documentation/lw51/CLHS/Body/d_inline.htm
[*features*]: http://www.lispworks.com/documentation/lw71/CLHS/Body/v_featur.htm
[parcom]: https://www.fosskers.ca/en/blog/optimizing-common-lisp
 
#  スクリプト、コマンドライン引数、実行ファイル {#chapter-scripting}
 

REPL からプログラムを使うのは問題ありませんが、できあがったらターミナルから呼び出したくなります。そういうときは Lisp の **スクリプト** を使えます。

さらに、プログラムを手軽に配布したいなら、**実行ファイル** を作りたくなります。

Lisp 実装ごとに作り方は少し違いますが、どれも対象アーキテクチャ向けの **自己完結型実行ファイル** を作れます。利用者は Lisp 実装をインストールする必要がなく、すぐにソフトウェアを実行できます。

**起動時間** はほぼゼロに近く、特に SBCL と CCL では顕著です。

少なくともオープンソース実装では、バイナリの **サイズ** はやや大きめです。Lisp 本体だけでなく、ライブラリ、すべてのシンボル名、関数の引数リスト情報、コンパイラ、デバッガ、ソースコードの位置情報なども含まれます。ただし、コンパイラとデバッガが入っているおかげで、プログラム実行中に Lisp コードをコンパイルして読み込めます。さらに、有償版の LispWorks には tree shaker があり、3〜5MB 程度のバイナリを作れます。こちらにはコンパイラが入っていないので、実行中の更新はできません。

同様に、HTML や JS などの静的アセットをすべて含む **Web アプリ** 向けの自己完結型実行ファイルも作れます。

## Common Lisp でスクリプトを書く

`hello` という名前のファイルを作り（`.lisp` 拡張子は外してもかまいません）、次を入れます。

```
#!/usr/bin/env -S sbcl --script
(require :uiop)
(format t "hello ~a!~&" (uiop:getenv "USER"))
```

スクリプトに実行権を付けて（`chmod +x hello`）、実行します。

```
$ ./hello
hello me!
```

いい感じです。これだけでもかなり使えます。

しかも、私の環境ではこのスクリプトの起動はかなり速く、0.03 秒でした。

ただし、依存関係を追加すると起動時間は長くなります。素直な解はバイナリを作ることです。依存関係をすべてコンパイル済みで、さらに速く起動します。別の方法として、自分用の *core image* を作る手もあります。

ここでは SBCL の CLI オプション `--script` を使いました。これは `--no-sysinit --no-userinit --disable-debugger --end-toplevel-options` と同等です。

- `--no-sysinit` はシステム全体の初期化ファイルを読み込みません。
- `--no-userinit` はユーザーの `~/.sbclrc` を読み込みません。
- `--disable-debugger` はデバッガを無効にします。エラー時には Lisp プロセスがバックトレースを表示して終了コード 1 で終了します。Lisp REPL は入りません。
- `--end-toplevel-options` は省略可能で、"プログラム向けのオプションが誤って SBCL に処理されるのを防ぐ" ものです。

また `env -S` も使いました。通常 `env` は 1 つの引数しか受け取りませんが、`-S`（`--split-string`）を使うと複数の引数を指定できます。そのおかげで `--script` フラグを追加できました。


### スクリプトから依存関係を quickload する

まだ `.asd` のプロジェクト定義を用意しておらず、とにかく簡単なスクリプトを書きたいだけで、Quicklisp の依存を読み込みたいとします。その場合は少し手順が増えます。

```lisp
#!/usr/bin/env -S sbcl --script

(require :uiop)

;; We want quicklisp, which is loaded from our initfile,
;; after a classical installation.
;; However the --script flag doesn't load our init file:
;; it implies --no-sysinit --no-userinit --disable-debugger --end-toplevel-options
;; So, please load it:
(load "~/.sbclrc")

;; Load a quicklisp dependency silently.
(ql:quickload "str" :silent t)

(princ (str:concat "hello " (uiop:getenv "USER") "!"))
```

そのため、Quicklisp 依存がすでにインストール済みなら、`require` だけでも済ませられます。

~~~lisp
;; replace loading sbclrc and ql:quickload.
(require :str)
~~~

なお、コードの途中に `ql:quickload` を置くと、そのファイルはもう読み込めませんし、エディタから `C-c C-k` もできなくなります。reader は `quickload` をまだ実行せずに読み進め、そのあとで、まだロードされていないパッケージへの呼び出しである `str:concat` に遭遇するからです。Common Lisp には、read フェーズ中にコードを実行する形があります。

~~~lisp
;; you shouldn't need this. Use an .asd system definition!
(eval-when (:load-toplevel :compile-toplevel :execute)
  (ql:quickload "str" :silent t))
~~~

ただし、ASDF のプロジェクト定義があるのには理由があります。

アプリケーションコードの途中で依存関係をインストールさせる言語を、他に見つけてください。

[​]{#the-main-entry-point}

### 「main」エントリポイント

ファイルを `load` で読み込むと、トップレベルの命令がすべて実行されます。

次のコードでは:

```lisp
(defun foo ()
  :hello)
```

`foo` 関数はコンパイルされますが、何も実行されません。次のコードでは:

```lisp
(defun foo ()
  :hello)

(foo)
```

`foo` はコンパイルされ、そのあと実行されます。ただし標準出力には何も出していないので、ターミナルには何も表示されないかもしれません。

つまり `(foo)` を main エントリポイントと考えられます。`main` 関数というものはありません。

ただし、トップレベル式があると、Slime の `C-c C-k` のように、ファイル全体を副作用なしでコンパイルして読み込むことができなくなります。これを避けるには、次のようにします。

```lisp
(eval-when (:execute)
  (foo))
```

これで、エディタから対話的にスクリプトを開発でき、トップレベル式の副作用に悩まされずに `C-c C-k`（`slime-compile-and-load-file`）を使えます。


## 自己完結型実行ファイルを作る

### SBCL を使う - イメージと実行ファイル

自己完結型の実行ファイルの作り方は、デフォルトでは実装依存です（移植可能な方法は後述します）。SBCL では、[ドキュメント](http://www.sbcl.org/manual/index.html#Function-sb_002dext_003asave_002dlisp_002dand_002ddie) にあるとおり、`save-lisp-and-die` を `:executable` 引数を `t` にして呼び出します。

~~~lisp
(sb-ext:save-lisp-and-die #P"path/name-of-executable"
                         :toplevel #'my-app:main-function
                         :executable t)
~~~

`sb-ext` は SBCL の拡張で、外部プロセスを扱います。ほかの [SBCL 拡張](http://www.sbcl.org/manual/index.html#Extensions) もあります（多くは他のライブラリで移植可能になっています）。

`:executable t` は、イメージではなく実行ファイルを作ることを意味します。現在の Lisp イメージの状態を保存して、あとでその状態から作業を再開するためにイメージを作ることもできます。計算量の多い作業をたくさんしたときには特に便利です。その場合は `sbcl --core name-of-image` でそのイメージを再利用します。

`:toplevel` はプログラムのエントリポイントで、ここでは `my-app:main-function` です。シンボルを `export` するのを忘れないでください。あるいは `my-app::main-function`（コロン 2 つ）を使ってもかまいません。

これを Slime で実行すると、スレッドが動いていることに関するエラーになります。

> Cannot save core with multiple threads running.

このコマンドは、端末上の素の SBCL REPL から実行する必要があります。

プロジェクトに Quicklisp の依存があるとしましょう。その場合は次のことが必要です。

* Lisp 起動時に Quicklisp がインストールされ、読み込まれていることを確認する（Quicklisp の導入を済ませる）
* プロジェクトの `.asd` を `asdf:load-asd` する（単なる `load` より推奨）
* 依存関係をインストールする
* 実行ファイルを作る

すると、次のようになります。

~~~lisp
(asdf:load-asd "my-app.asd")
(ql:quickload "my-app")
(sb-ext:save-lisp-and-die #p"my-app-binary"
                          :toplevel #'my-app:main
                          :executable t)
~~~

コマンドラインや Makefile からは、`--load` と `--eval` を使います。

```
build:
	sbcl --load my-app.asd \
	     --eval '(ql:quickload :my-app)' \
         --eval "(sb-ext:save-lisp-and-die #p\"my-app\" :toplevel #'my-app:main :executable t)"
```

### `uiop:dump-image` を使う

`sb-ext:save-lisp-and-die` は SBCL 専用です。ほかの実装にも似た機能はありますが、関数名や引数は異なります。CCL（Clozure CL）では `ccl:save-application` です。

Common Lisp 実装間で移植可能なビルドスクリプトを書きたいなら、`uiop:dump-image` を使えます。引数はおおむね `save-lisp-and-die` と同じですが、`:toplevel` の代わりに `uiop:*image-entry-point*` 変数へ設定します。

~~~lisp
;; build.lisp
(asdf:load-asd "my-app.asd")
(ql:quickload "my-app")

(setf uiop:*image-entry-point* #'my-app:main)

(uiop:dump-image "my-app-binary" :executable t :compression 9)
~~~

この `build.lisp` というファイルは、どの実装でも実行できます。

    $ sbcl --load build.lisp
    $ ecl --load build.lisp
    $ ccl --load build.lisp
    …


### ASDF を使う

ビルド手順を `.asd` のプロジェクト定義に直接書くこともできます。

ASDF 3.1 以降ではそれが可能です。`.asd` から引数を読む [`make` コマンド](https://common-lisp.net/project/asdf/asdf.html#Convenience-Functions) が導入されました。`.asd` に次を追加します。

~~~
:build-operation "program-op" ;; leave as is
:build-pathname "<here your final binary name>"
:entry-point "<my-package:main-function>"
~~~

そして `asdf:make :my-package` を呼びます。

そのため、Makefile には次のように書けます。

~~~lisp
LISP ?= sbcl

build:
    $(LISP) --load my-app.asd \
    	--eval '(ql:quickload :my-app)' \
		--eval '(asdf:make :my-app)' \
		--eval '(quit)'
~~~

### Deploy を使う - 外部ライブラリ依存もまとめて配布する

ここまでで、自分のマシンでは動くバイナリを作れます。しかし、他人の環境やサーバーで動くとは限りません。たぶんプログラムは、ファイルシステム上のどこかにある C の共有ライブラリに依存しています。たとえば `libssl` が次のような場所にあるかもしれません。

    /usr/lib/x86_64-linux-gnu/libssl.so.1.1

しかし VPS では別の場所にあるかもしれません。

そこで [Deploy](https://github.com/Shinmera/deploy) の出番です。

Deploy は、バイナリと必要な外部ライブラリを含む `bin/` ディレクトリを作ります。プログラムが必要とするものを自動検出しますが、必要なら手助けもできますし、やりすぎないように指示もできます。

使い方は、`asdf:make` と `.asd` の構成を使う先ほどのレシピにかなり近いです。次のようにします。

~~~lisp
:defsystem-depends-on (:deploy)  ;; (ql:quickload "deploy") before
:build-operation "deploy-op"     ;; instead of "program-op"
:build-pathname "my-application-name"  ;; doesn't change
:entry-point "my-package:my-start-function"  ;; doesn't change
~~~

そして、前と同じく `(asdf:make :my-app)` でバイナリをビルドします。

これで `bin/` ディレクトリを利用者へ配布できます。

バイナリを実行すると、同梱したライブラリが使われているのが分かります。

~~~lisp
$ ./my-app
 ==> Performing warm boot.
   -> Runtime directory is /home/debian/projects/my-app/bin/
   -> Resource directory is /home/debian/projects/my-app/bin/
 ==> Running boot hooks.
 ==> Reloading foreign libraries.
   -> Loading foreign library #<LIBRARY LIBRT>.
   -> Loading foreign library #<LIBRARY LIBMAGIC>.
 ==> Launching application.
 […]
~~~

成功です。

`libssl` について補足です。少なくとも Linux では、OS に入っているものを使うほうが簡単なので、Deploy にはこれを同梱しないよう指示します（`libcrypto` も同様です）。

~~~lisp
(require :cl+ssl)
#+linux (deploy:define-library cl+ssl::libssl :dont-deploy T)
#+linux (deploy:define-library cl+ssl::libcrypto :dont-deploy T)
~~~

Deploy が見つけられない外部ライブラリを同梱したい日には、次のように指定できます。

~~~lisp
(deploy:define-library cl+ssl::libcrypto
  ;;                   ^^^ CFFI system name.
  ;;                   Find it with a call to "apropos".
  :path "/usr/lib/x86_64-linux-gnu/libcrypto.so.1.1")
~~~

最後にもう 1 点です。バイナリを作って初めて実行すると、ASDF が自分自身を更新しようとして `~/common-lisp/asdf/` リポジトリに何も見つけられず、終了することがあります。これを避けるには、`.asd` に次を追加します。

~~~lisp
;; Tell ASDF to not update itself.
(deploy:define-hook (:deploy asdf) (directory)
  (declare (ignorable directory))
  #+asdf (asdf:clear-source-registry)
  #+asdf (defun asdf:upgrade-asdf () nil))
~~~

`asdf:make` を呼ぶ前にビルドスクリプトへこれを追加すると、Deploy の起動メッセージも消せます。

    (push :deploy-console *features*)

ほかにもあります。詳しくは Deploy のドキュメントを参照してください。


### Roswell または Buildapp を使う

[Roswell](https://roswell.github.io) は、実装管理、スクリプト起動などを行うツールで、`ros build` コマンドを備えています。多くの実装で使えるはずです。

これを使えば、`ros install my-app` のようにして他人に簡単にインストールしてもらえます。詳しくは Roswell のドキュメントを参照してください。

なお、`ros build` は既定で core compression を有効にします。そのため、単純なアプリでも起動オーバーヘッドがかなり増えます（およそ 150ms 増え、30ms ほどだった起動時間が 180ms ほどになることがあります）。`ros build <app.ros> --disable-compression` で無効化できます。もちろん、core compression はバイナリサイズを大きく減らします。後ろの「実装ごとの実行ファイルサイズと起動時間」の表を見てください。

最後に [Buildapp](http://www.xach.com/lisp/buildapp/) について少し触れます。これは実戦投入され、今でも人気のある「SBCL または CCL 向けで、実行可能な Common Lisp イメージを構成して保存するアプリケーション」です。

使用例です。

~~~lisp
buildapp --output myapp \
         --asdf-path . \
         --asdf-tree ~/quicklisp/dists \
         --load-system my-app \
         --entry my-app:main
~~~

多くのアプリケーションが使っています（たとえば [pgloader](https://github.com/dimitri/pgloader)）。Debian では `apt install buildapp` で入りますが、今なら `asdf:make` や Roswell で足りるはずです。


[​]{#for-web-apps}

### Web アプリ向け

同様に、Web アプリケーション向けの自己完結型実行ファイルも作れます。これには Web サーバーが含まれ、コマンドラインから起動できます。

    $ ./my-web-app
    Hunchentoot server is started.
    Listening on localhost:9003.

これは開発用ではなく本番用の Web サーバーを起動する点に注意してください。そのため、バイナリを VPS でそのまま実行して外部からアクセスできます。

気をつける点が 1 つあります。動いている Web サーバーのスレッドを見つけて前面に置くことです。`main` 関数では次のようにできます。

~~~lisp
(defun main ()
  (handler-case
      (progn
        (start-app :port 9003) ;; our start-app, for example clack:clack-up
        ;; let the webserver run,
        ;; keep the server thread in the foreground:
        ;; sleep for ± a hundred billion years.
        (sleep most-positive-fixnum))

    ;; Catch a user's C-c
    (#+sbcl sb-sys:interactive-interrupt
      #+ccl  ccl:interrupt-signal-condition
      #+clisp system::simple-interrupt-condition
      #+ecl ext:interactive-interrupt
      #+allegro excl:interrupt-signal
      () (progn
           (format *error-output* "Aborting.~&")
           (clack:stop *server*)
           (uiop:quit)))
    (error (c) (format t "Woops, an unknown error occurred:~&~a~&" c))))
~~~

ここでは `bordeaux-threads` ライブラリ（`(ql:quickload "bordeaux-threads")`、別名 `bt`）と、ASDF の一部としてすでに読み込まれている `uiop` を使い、移植可能な方法で終了しています（`sb-ext:quit` ではなく、任意の終了コードを取れる `uiop:quit`）。


### 実装ごとの実行ファイルサイズと起動時間

**SBCL** だけが Lisp 実装ではありません。[**ECL**](https://gitlab.com/embeddable-common-lisp/ecl/)（Embeddable Common Lisp）は Lisp プログラムを C に変換するため、より小さな実行ファイルになります。

[この Reddit 投稿](https://www.reddit.com/r/lisp/comments/46k530/tackling_the_eternal_problem_of_lisp_image_size/) によると、ECL は確かに最小の実行ファイルを生成し、SBCL より 1 桁ほど小さい一方で、起動時間は長めです。

CCL のバイナリは、SBCL と同程度に速く起動し、サイズはほぼ半分のようです。


```
| program size | implementation |  CPU | startup time |
|--------------+----------------+------+--------------|
|           28 | /bin/true      |  15% |        .0004 |
|         1005 | ecl            | 115% |        .5093 |
|        48151 | sbcl           |  91% |        .0064 |
|        27054 | ccl            |  93% |        .0060 |
|        10162 | clisp          |  96% |        .0170 |
|         4901 | ecl.big        | 113% |        .8223 |
|        70413 | sbcl.big       |  93% |        .0073 |
|        41713 | ccl.big        |  95% |        .0094 |
|        19948 | clisp.big      |  97% |        .0259 |
```

<!-- TODO: what about SBCL with maximum core compression? -->

コンパイル時間については、**CCL** が速いことで有名です。ECL は処理が重く、この 3 つの中ではコンパイルに最も時間がかかります。

商用 Lisp の **tree shaker** の能力も調べる価値があります。**LispWorks** なら、圧縮なしでも完全に tree shake された 8MB の hello-world プログラムを作れます。そのような実行ファイルは約 1 秒で生成され、Apple M2 Pro CPU では実行時間は 0.02 秒未満です。


### SBCL の core 圧縮でより小さなバイナリを作る

SBCL の core compression を使うと、アプリケーションのバイナリサイズを大幅に減らせます。今回の例では 120MB から 23MB まで減り、その代わり起動時間は十数ミリ秒増えましたが、それでも 50ms 未満でした。

<div class="info-box info">
    <strong>Note:</strong> SBCL 2.2.6 switched to compression with zstd instead of zlib, which provides smaller binaries and faster compression and decompression times. Un-official numbers are: about 4x faster compression, 2x faster decompression, and smaller binaries by 10%.
</div>


使っている SBCL は core compression 対応である必要があります。ドキュメント [Saving-a-Core-Image](http://www.sbcl.org/manual/#Saving-a-Core-Image) を参照してください。

対応しているかどうかは次で確認できます。

~~~lisp
(find :sb-core-compression *features*)
:SB-CORE-COMPRESSION
~~~

はい、Debian 版の SBCL では対応しています。

**SBCL の場合**

SBCL では `save-lisp-and-die` に引数を渡します。`:compression` は次の意味です。

> -7 から 22 までの整数で、zstd の圧縮レベルに対応します。`t` は既定の圧縮レベル 9 と同じです。

単純な "Hello, world" プログラムの場合:

```
| Program size | Compression level   |
|--------------|---------------------|
| 46MB         | Without compression |
| 22MB         | -7                  |
| 12MB         | 9                   |
| 11MB         | 22                  |
```

Lisp で書かれた X ウィンドウマネージャー StumpWM のような大きなプロジェクトでは、次のようになります。

```
| Program size | Compression level   |
|--------------|---------------------|
| 58MB         | Without compression |
| 27MB         | -7                  |
| 15MB         | 9                   |
| 13MB         | 22                  |
```

**ASDF の場合**

ただし、ASDF（正確には UIOP）でやるほうが好まれます。`.asd` に次を追加します。

~~~lisp
#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c)
                   :executable t
                   :compression t))
~~~

**Deploy の場合**

[Deploy](https://github.com/Shinmera/deploy/) ライブラリでも、完全にスタンドアロンなアプリケーションを作れます。利用可能なら圧縮も使います。

Deploy は、外部ライブラリ依存のあるアプリケーション向けに特化しています。依存先の共有ライブラリをすべて集め、`bin` サブディレクトリにまとめます。

これで完了です。

## core image を作る: 依存が多くても速く起動する

最初の用途に戻りましょう。shebang 行（`#!/usr/bin/env -S sbcl --script`）を使うスクリプトで依存関係を "quickload" したい場面です。ただし、依存が増えるほどスクリプトの起動は遅くなります。これを改善できるでしょうか。

必要なのは十数個の依存関係（とその推移的依存）です。

```
str
cl-ppcre
serapeum
bordeaux-threads
local-time
dexador
hunchentoot
djula
parse-number
shasht
cl-yaml
clingon
log4cl
```

スクリプトを再び速くする方法があります。依存関係をすべて読み込んだ "core image" をダンプし、その core image からスクリプトを実行します。

`uiop:dump-image "my.core"` で移植可能に core image を作れます。SBCL では `sb-ext:save-lisp-and-die …` に相当し、` :executable t` を除いた引数が同じです。実行ファイルでなければ、それは core image です。

`build-core.lisp` を作ります。

```lisp
(ql:quickload
 '("str"
   "cl-ppcre"
   "serapeum"
   "bordeaux-threads"
   "local-time"
   "dexador"
   "hunchentoot"
   "djula"
   "parse-number"
   "shasht"
   "cl-yaml"
   "clingon"
   "log4cl"
   ))

(uiop:dump-image "my.core")
```

このファイルを実行して core image を作ります。

    sbcl --load build-core.lisp

出力は次のようになります。

```
This is SBCL 2.5.8, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
To load "str":
  Load 1 ASDF system:
    str
; Loading "str"
...

[…]

[undoing binding stack and other enclosing state... done]
[performing final GC... done]
[defragmenting immobile space... (inst,code,sym)=1038+22032+24090... done]
[saving current Lisp image into my.core:
writing 65536 bytes from the linkage space at 0xb7ffb00000
writing 1310720 bytes from the fixedobj space at 0x50000000
writing 2752 bytes from the static space at 0x520000000000
writing 26050560 bytes from the dynamic space at 0x1200000000
writing 18951888 bytes from the read-only space at 0x11fede8000
writing 12767232 bytes from the text space at 0xb800000000
done]
```

これで新しい `my.core` ファイルができます。

```
$ ls -lh my.core
-rwxr-xr-x 1 me me 86M Mar  3 14:12 my.core
```

これをスクリプトから使うには、コマンドライン引数 `--core my.core` を付けます。`myscript.lisp` は次のようになります。

```lisp
#!/usr/bin/env -S sbcl --core my.core --script

(format t "Hello script. We are using dependencies. Time is ~a.~&" (local-time:now))
```

```sh
$ chmod +x myscript.lisp
$ time ./myscript.lisp
Hello script. We are using dependencies. Time is 2084-03-03T14:19:55.573738+01:00.
./use-core.lisp  0.01s user 0.01s system 99% cpu 0.017 total
```

起動の速さを見てください。

最後に注意点です。

- core image はマシン間で移植できません。これは自分用であり、利用者へ配ったりサーバーへデプロイしたりはできません。そういう用途には実行ファイルを使ってください。
- Lisp ライブラリ以外も事前読み込みできます。静的ファイル（ゲームアセット、JS/CSS、Markdown 文書など）や、事前計算済みデータ（重い CSV をコンパイル時に解析して読み込むなど）も含められます。

さらに読む:

- [SBCL's documentation](https://www.sbcl.org/manual/#Saving-a-Core-Image)


## コマンドライン引数を解析する

SBCL はコマンドライン引数を `sb-ext:*posix-argv*` に入れます。

ただし変数名は実装ごとに違うので、その差を吸収する手段が欲しくなります。

そこで `(uiop:command-line-arguments)` があります。これは ASDF に含まれ、ほぼすべての実装で使えます。コードのどこからでも、次のようにして特定の文字列がこのリストにあるか確認できます。

~~~lisp
(member "-h" (uiop:command-line-arguments) :test #'string-equal)
~~~

これで十分そうですが、さらに引数の解析や、短いオプション・長いオプションのチェック、自動ヘルプ生成なども欲しくなります。

そこで [Clingon](https://github.com/dnaeon/clingon) ライブラリを選びました。機能がもっとも豊富かもしれないからです。

- サブコマンドを扱えます
- さまざまな種類のオプション（フラグ、整数、真偽値、カウンタ、列挙など）に対応します
- Bash と Zsh の補完ファイルや man ページを生成できます
- さまざまな方法で拡張できます
- REPL 上で手軽に試せます
- その他いろいろ

ダウンロードしてみましょう。

    (ql:quickload "clingon")

よくあることですが、作業は 2 つの段階に分かれます。

* まず、アプリケーションが受け付けるオプションを宣言します。種類（フラグ、文字列、整数など）、長い名前と短い名前、必須かどうかを指定します。
* 次に、Clingon にコマンドラインのオプションを解析させ、アプリケーションを実行してもらいます。


### オプションを宣言する

コマンドラインツールの使い方を、次のように表したいとします。

    $ myscript [-h, --help] [-n, --name NAME]

最終的には、アプリケーションを表す Clingon の command を `clingon:make-command` で作る必要があります。command は option と、ロジックを担当する handler 関数から成ります。

まずは option を作りましょう。Clingon は `--help` はすでに扱ってくれますが、短い版は扱いません。`clingon:make-option` で option を作る例は次のとおりです。

~~~lisp
(clingon:make-option
 :flag                ;; <--- option kind. A "flag" does not expect a parameter on the CLI.
 :description "short help"
 ;; :long-name "help" ;; <--- long name, sans the "--" prefix, but here it's a duplicate.
 :short-name #\h      ;; <--- short name, a character
 ;; :required t       ;; <--- is this option always required? In our case, no.
 :key :help)          ;; <--- the internal reference to use with getopt, see later.
~~~

これは**フラグ**です。コマンドラインに `-h` があればオプションの値は真、それ以外は偽になります。フラグは引数を取りません。単独で存在します。

似た種類のオプションには次のものがあります。

- `:boolean`: 引数を取ります。"true" または 1 なら真、それ以外は偽とみなします。
- `:counter`: コマンドラインで何回指定されたかを数えます。通常は `-v` / `--verbose` に使い、利用者は `-vvv` のようにして詳細度を上げられます。この場合、値は 3 です。指定されなければ 0 になります。

2 つ目のオプション（引数付きの `--name` または `-n`）を作り、すべてを小さな関数にまとめます。

~~~lisp
;; The naming with a "/" is just our convention.
(defun cli/options ()
  "Returns a list of options for our main command"
  (list
   (clingon:make-option
    :flag
    :description "short help."
    :short-name #\h
    :key :help)
   (clingon:make-option
    :string              ;; <--- string type: expects one parameter on the CLI.
    :description "Name to greet"
    :short-name #\n
    :long-name "name"
    :env-vars '("USER")     ;; <-- takes this default value if the env var exists.
    :initial-value "lisper" ;; <-- default value if nothing else is set.
    :key :name)))
~~~

2 つ目に作ったオプションは `:string` 種別です。このオプションは引数を 1 つ取り、それは文字列として解析されます。引数を整数として解析する `:integer` もあります。

Clingon にはほかにもオプション種別があり、その充実したドキュメントで確認できます。`:choice`、`:enum`、`:list`、`:filepath`、`:switch` などです。

### トップレベルコマンド

トップレベルコマンドを Clingon に伝える必要があります。`clingon:make-command` はいくつかの説明用フィールドと、2 つの重要なフィールドを受け取ります。

- `:options` は Clingon オプションのリストで、各オプションは `clingon:make-option` で作ります
- `:handler` はアプリのロジックを実行する関数です。

最後に、main 関数（バイナリのエントリポイント）の中で `clingon:run` を使って、コマンドライン引数を解析し、コマンドのロジックを適用します。開発中は `clingon:parse-command-line` を手動で呼んで試すこともできます。

最小限のコマンドを示します。ハンドラ関数はあとで定義します。

~~~lisp
(defun cli/command ()
  "A command to say hello to someone"
  (clingon:make-command
   :name "hello"
   :description "say hello"
   :version "0.1.0"
   :authors '("John Doe <john.doe@example.org")
   :license "BSD 2-Clause"
   :options (cli/options) ;; <-- our options
   :handler #'null))  ;; <--  to change. See below.
~~~

この時点で、REPL でもう試せます。

### REPL でオプション解析を試す

`clingon:parse-command-line` を使います。トップレベル command と、コマンドライン引数の文字列リストを受け取ります。

~~~lisp
CL-USER> (clingon:parse-command-line (cli/command) '("-h" "-n" "me"))
#<CLINGON.COMMAND:COMMAND name=hello options=5 sub-commands=0>
~~~

動きます。

このコマンドオブジェクトを `inspect` すると、プロパティ（name、hooks、description、context など）やオプションの一覧などが見えます。

未知のオプションでも試してみましょう。

~~~lisp
CL-USER> (clingon:parse-command-line (cli/command) '("-x"))
;; => debugger: Unknown option -x of kind SHORT
~~~

その場合は対話デバッガに入り、次のように表示されます。

```
Unknown option -x of kind SHORT
   [Condition of type CLINGON.CONDITIONS:UNKNOWN-OPTION]
```

そして、いくつかの restart が提示されます。

```
Restarts:
 0: [DISCARD-OPTION] Discard the unknown option
 1: [TREAT-AS-ARGUMENT] Treat the unknown option as a free argument
 2: [SUPPLY-NEW-VALUE] Supply a new value to be parsed
 3: [RETRY] Retry SLIME REPL evaluation request.
 4: [*ABORT] Return to SLIME's top level.
```

これらはかなり実用的です。必要なら `parse-command-line` に `:around` メソッドを作り、`handler-bind` で Clingon の条件を扱い、その restart を使って未知の option に別の処理をさせることもできます。ただ、現時点ではそこまで要りません。無効な option は警告してほしいからです。

最後に、Clingon が CLI ツールの usage 情報をどう出すか見てみましょう。

```
CL-USER> (clingon:print-usage (cli/command) t)
NAME:
  hello - say hello

USAGE:
  hello [options] [arguments ...]

OPTIONS:
      --help          display usage information and exit
      --version       display version and exit
  -h                  short help.
  -n, --name <VALUE>  Name to greet [default: lisper] [env: $USER]

AUTHORS:
  John Doe <john.doe@example.org

LICENSE:
  BSD 2-Clause
```

`USAGE` 部分は、トップレベルコマンドの `:usage` キーパラメータで調整できます。


### オプションを処理する

コマンドライン引数の解析が成功したら、それを使って何かする必要があります。ここで新しい Clingon 関数を 2 つ使います。

- `clingon:getopt` は、` :key` で option の値を取得します
- `clingon:command-arguments` は、コマンドラインに残った自由引数を取得します

使い方は次のとおりです。

~~~lisp
CL-USER> (let ((command (clingon:parse-command-line (cli/command) '("-n" "you" "last"))))
           (format t "name is: ~a~&" (clingon:getopt command :name))
           (format t "free args are: ~s~&" (clingon:command-arguments command)))
name is: you
free args are: ("last")
NIL
~~~

これらを使って、トップレベルコマンドのハンドラを書きます。

~~~lisp
(defun cli/handler (cmd)
  "The handler function of our top-level command"
  (let ((free-args (clingon:command-arguments cmd))
        (name (clingon:getopt cmd :name)))  ;; <-- using the option's :key
    (format t "Hello, ~a!~%" name)
    (format t "You have provided ~a more free arguments~%"
            (length free-args))
    (format t "Bye!~%")))
~~~

トップレベルコマンドに、このハンドラを使うよう伝えます。

~~~lisp
;; from above:
(defun cli/command ()
  "A command to say hello to someone"
  (clingon:make-command
   ...
   :handler #'cli/handler))  ;; <-- changed.
~~~

あとはバイナリの main 関数（エントリポイント）を書けば終わりです。

ちなみに `clingon:getopt` は 3 つの値を返します。

- オプションの値
- そのオプションがコマンドラインで指定されたかを示す真偽値
- この値を提供したコマンド

`clingon:opt-is-set-p` も参照してください。


### main 関数（エントリポイント）

これは任意の関数でかまいませんが、Clingon を使うなら `run` 関数を呼びます。

~~~lisp
(defun main ()
  "The main entrypoint of our CLI program"
  (clingon:run (cli/command)))
~~~

この main 関数をバイナリのエントリポイントとして使うには、上で説明した Common Lisp バイナリの作り方に従います。念のため、`.asd` の system 定義で次のように設定します。

~~~lisp
:entry-point "my-package::main"
~~~

これでほぼ終わりです。おめでとうございます。これでコマンドライン引数をきちんと解析できます。

Clingon のドキュメントには、サブコマンド、コンテキスト、フック、C-c の扱い、メール用のオプションのような新しい種類の開発、Bash/Zsh 補完など、さらに多くの情報があります。


## C-c の終了シグナルを捕まえる

既定では、**Clingon は SIGINT シグナルのハンドラを提供します**。これによりアプリケーションはすぐに終了し、終了コード 130 を返します。

アプリケーションに後始末のロジックが必要なら、`unwind-protect` を使えます。ただしすべてのケースに向くとは限らないため、Clingon では [with-user-abort](https://github.com/compufox/with-user-abort) 補助ライブラリの利用も案内しています。

以下では、C-c を手動で捕まえる方法を示します。既定では Lisp のスタックトレースが出るからです。

簡単なバイナリを作って実行し、`C-c` を押してみました。スタックトレースを見てみましょう。

~~~
$ ./my-app
sleep…
^C
debugger invoked on a SB-SYS:INTERACTIVE-INTERRUPT in thread   <== condition name
#<THREAD "main thread" RUNNING {1003156A03}>:
  Interactive interrupt at #x7FFFF6C6C170.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE     ] Return from SB-UNIX:SIGINT.               <== it was a SIGINT indeed
  1: [RETRY-REQUEST] Retry the same request.
~~~

シグナルされた条件の名前は実装依存で、ここでは `sb-sys:interactive-interrupt` です。アプリケーションコードを `handler-case` で囲めばよいです。

~~~lisp
(handler-case
    (run-my-app free-args)
  (sb-sys:interactive-interrupt ()
      (progn
        (format *error-output* "Abort.~&")
        (uiop:quit))))
~~~

ただし、このコードは SBCL 専用です。[trivial-signal](https://github.com/guicho271828/trivial-signal/) もありますが、ここではまだ十分ではありませんでした。なので、次のような書き方にできます。

~~~lisp
(handler-case
    (run-my-app free-args)
  (#+sbcl sb-sys:interactive-interrupt
   #+ccl  ccl:interrupt-signal-condition
   #+clisp system::simple-interrupt-condition
   #+ecl ext:interactive-interrupt
   #+allegro excl:interrupt-signal
   ()
   (uiop:quit)))
~~~

ここで `#+` は、実装に応じてその行をコンパイル時に含めます。`#-` もあります。`#+` は `*features*` リスト内のシンボルを見ます。シンボルは `and`、`or`、`not` でも組み合わせられます。

## 実行ファイルの継続的デリバリー

継続的インテグレーションシステム（Travis CI、GitLab CI など）に、コミットごと、タグ push ごと、あるいは任意のポリシーでバイナリをビルドさせられます。

[`継続的インテグレーション`](#continuous-integration) を参照してください。

## 関連項目

- [SBCL-GOODIES](https://github.com/sionescu/sbcl-goodies) - 外部ライブラリ付きの SBCL バイナリを配布できます。`libssl`、`libcrypto`、`libfixposix` が静的に組み込まれます。これら 3 つの外部ライブラリだけを使うなら、Deploy は不要になります。
  * 2023 年 2 月に公開されました。
- [CIEL Is an Extended Lisp](http://ciel-lang.org/) - スクリプト機能を備えた、盛り込み済みの Common Lisp パッケージです。
- [kiln](https://github.com/ruricolist/kiln) - Lisp のスクリプト実行を効率的かつ扱いやすくするための基盤です（隠しマルチコールバイナリを管理します）。
  * Kiln を使うと、非常に小さなスクリプトも実用的に書けます。Kiln のスクリプトは高速で低コストなので、Lisp の小さな機能片でもシェルへ公開する意味が出てきます。
- [Common Lisp を Windows 向けにクロスコンパイルする](https://www.fosskers.ca/en/blog/cl-windows)

## 謝辞

* [cl-torrents のチュートリアル](https://vindarel.github.io/cl-torrents/tutorial.html)
* [lisp-journey/web-dev](https://lisp-journey.gitlab.io/web-dev/)
 
#  ストリーム {#chapter-streams}
 

ストリームは、Common Lisp における入出力の標準的な抽象化です。ファイルから読み込むとき、端末へ書き込むとき、ネットワークソケットで通信するとき、あなたはストリームを使っています。

多くの組み込み関数はストリーム引数を持ちます。省略可能な場合もあります。

```lisp
(print object &optional stream)

(format stream control-string &rest format-arguments)

(defmethod print-object (object stream) &body body)

(with-open-file (stream filespec …) &body body)
```

この章では、ストリームの種類、作成と利用の方法、そしてストリームプロトコルの拡張方法を扱います。

[​]{#stream-}

## そもそもストリームとは何か

ストリームは、ある方向（または複数の方向）から別の方向（または複数の方向）へ流れるデータを表します。小さく明確に区切られたデータ量も、場合によっては無限のデータ量も表せます。

英語では、"stream" は小川、途切れない流れ、そして音声や動画の配信を表すことがあります。

ストリームを扱うとき、私たちはストリーム全体を捕まえて _その後で_ 作業するのではなく、目の前を通り過ぎるデータを見ます。川を通る船を数えるとき、川全体をバケツに集めてから捕まえた船の数を数えるわけではありません。小さな CSV ファイルを読むときは、ファイル全体を一度に読み込んでから解析できますが、とても大きいファイルを扱う場合は streaming API が必要になり、作業を論理的なまとまりに分けることになります。


[​]{#stream--1}

## ストリームの基本

ストリームは、文字またはバイトの入力元や出力先を表すオブジェクトです。標準はいくつかのストリームの種類を定義しています。

- **Input streams** は読み取りをサポートします（`read-char` と `unread-char`、`read-byte`、`read-line`、`read`）。
- **Output streams** は書き込みをサポートします（`write-char`、`write-byte`、`write-string`、`format`）。
- **Bidirectional streams** はその両方をサポートします。

これとは別に、ストリームは要素型を持ちます。

- **文字ストリーム**は文字を運びます。`read-char`、`read-line`、`format`、およびこの章のほとんどの例がデフォルトで使うものです。
- **バイナリストリーム**はバイトを運び、通常は `(unsigned-byte 8)` のような要素型で宣言されます。

ストリームが何をサポートしているかはテストできます。

~~~lisp
(input-stream-p *standard-input*)   ;; => T
(output-stream-p *standard-output*) ;; => T
(stream-element-type *standard-input*)
;; => CHARACTER
~~~

[​]{#stream--2}

## 標準ストリーム変数

Common Lisp は、デフォルトで束縛されているいくつかのグローバルなストリーム変数を提供します。

| 変数 | 目的 |
|---|---|
| `*standard-input*` | デフォルト入力（端末または REPL） |
| `*standard-output*` | デフォルト出力（端末または REPL） |
| `*error-output*` | エラー／警告メッセージ |
| `*trace-output*` | `trace` からの出力 |
| `*debug-io*` | 対話的なデバッグ用 I/O |
| `*query-io*` | ユーザーへの yes/no 質問 |
| `*terminal-io*` | 実際の端末ストリーム |

`read`、`print`、`format` のような関数は、ストリームを指定しない場合、デフォルトでこれらを使います。

~~~lisp
;; これらは等価です。
(print "hello")
(print "hello" *standard-output*) ;; または (print "hello" t)

(format *standard-output* "hello") ;; または (format t "hello")
~~~

出力をリダイレクトするために、これらを再束縛できます。

### プログラム出力の捕捉またはリダイレクト

たとえば、通常は標準出力に出力する関数の出力を、文字列として捕捉したいでしょうか。

一般には、この形の `let` による束縛を使えます。

~~~lisp
(let ((*standard-output* some-other-stream))
  (print "hello"))  ;; または別の関数呼び出し。
  ;; some-other-stream に print されます
~~~

この（少し込み入った）例では、文字列ストリームを作成し、`*standard-output*` をそれに束縛します。

```lisp
(with-output-to-string (s)
 (let ((*standard-output* s))
   ;; ここにいくつかの関数呼び出し…
   (princ "hello")
   (princ " ")
   (princ "streams")))
;; => "hello streams"
```

`princ` を使ってオブジェクトの「見やすい」表現を出力しています。`print` ならクォートと改行も出力します。

ちなみに、この例は次のように短くできます。

```lisp
(with-output-to-string (*standard-output*)
  (princ "hello")
  (princ " ")
  (princ "streams"))
```

## ファイルストリーム

ファイルストリームを作成するには `open` を使うか、ストリームが確実に閉じられる `with-open-file` マクロを使います。

~~~lisp
;; ファイルを 1 行ずつ処理する:
(with-open-file (my-file-stream "test.txt")
  ;;            ^^^ マクロ本体でこのシンボルを束縛します。
  (loop for line = (read-line my-file-stream nil)
        while line
        when (search "cat" line)
          do (format t "this line is about cats: ~s~&" line)))
~~~

~~~lisp
;; ファイルに書き込む:
(with-open-file (stream "/tmp/out.txt"
                 :direction :output
                 :if-exists :supersede)
  (format stream "Hello, streams!~%"))
~~~

`:direction` キーワードはストリームの種類を制御します。

- `:input`（デフォルト）- 読み取り専用
- `:output` - 書き込み専用
- `:io` - 読み取りと書き込み
- `:probe` - ファイルが存在するか確認して閉じるだけ

バイナリファイルの場合は `:element-type` を指定します。

~~~lisp
(with-open-file (stream "/tmp/data.bin"
                 :direction :output
                 :if-exists :supersede
                 :element-type '(unsigned-byte 8))
  (write-byte 72 stream)
  (write-byte 101 stream))
~~~

## 文字列ストリーム

文字列ストリームを使うと、文字列をストリームとして扱えます。これは、ファイルを使わずに出力を構築したり入力を解析したりするときに便利です。

### 文字列への書き込み: `with-output-to-string`

このマクロは、シンボルをストリームに束縛し、マクロ本体内でそのストリームに出力する関数を呼び出し、最後に文字列を作成できるようにします。

~~~lisp
(with-output-to-string (s)
  ;; より賢い処理…
  (format s "Hello, ")
  (format s "world!"))
;; => "Hello, world!"
~~~

`format`、`write-string`、その他のストリーム操作を使えます。

これは、出力先に `nil` を指定した `format` を使うことの、より柔軟な同等物と見なせます。

~~~lisp
(format nil "Hello, world!")
;; => "Hello, world!"
~~~

### 文字列からの読み取り: `with-input-from-string`

文字列からの読み取りは、小さなパーサー、REPL の補助、またはファイルシステムに触れずに入力を使いたいテストに便利です。

この例では、`read` がストリームからトークンを解析するため、`with-input-from-string` で入力ストリームを模倣する必要があります。

~~~lisp
;; 1 つの form を parse するには read-from-string も参照。
(with-input-from-string (s "123 456")
  (list (read s) (read s)))
;; => (123 456)
~~~

さらにオプションが必要なら次を参照してください。

- Community Spec の [`with-input-from-string`](https://cl-community-spec.github.io/pages/with_002dinput_002dfrom_002dstring.html) を読む


### `make-string-input-stream` と `make-string-output-stream`

マクロ form が不便な場合は、文字列ストリームを直接作成できます。これは、ある場所でストリームを作成し、後で消費する必要がある場合によく使われます。

~~~lisp
(let ((s (make-string-output-stream)))
  (format s "one ")
  (format s "two ")
  (format s "three")
  (get-output-stream-string s))
;; => "one two three"
~~~

~~~lisp
(let ((s (make-string-input-stream "hello")))
  (read-char s))
;; => #\h
~~~

## concatenated stream

`make-concatenated-stream` は、複数の input ストリームから順番に読み取るストリームを作成します。最初のストリームが尽きると、次のストリームから読み取りが続きます。複数の入力を既存の stream-consuming code に対して 1 つの連続した source のように見せたいときに便利です。

~~~lisp
(let* ((s1 (make-string-input-stream "Hello, "))
       (s2 (make-string-input-stream "world!"))
       (combined (make-concatenated-stream s1 s2)))
  (read-line combined))
;; => "Hello, world!"
~~~

## ブロードキャストストリーム

`make-broadcast-stream` は、複数のストリームに同時に出力を送るストリームを作成します。

~~~lisp
(with-output-to-string (s)
  (let ((broadcast (make-broadcast-stream *standard-output* s)))
     (format broadcast "to both")))
;; 端末に "to both" を出力します
;; => そして "to both" という文字列を返します。
~~~

または次のようにも書けます。

~~~lisp
(let* ((s (make-string-output-stream))
       (broadcast (make-broadcast-stream *standard-output* s)))
  (format broadcast "to both")
  (get-output-stream-string str))
~~~

これはコンソールとファイルの両方に同時にログを記録する場合に便利です。

### 出力を捨てる（/dev/null へ書き込む）

引数なしで `make-broadcast-stream` を呼ぶことは、`/dev/null` へ書き込むことの移植性のある同等物でもあります。そのストリームに送られた出力は捨てられます。

~~~lisp
(let ((sink (make-broadcast-stream)))
  (format sink "this goes nowhere"))
~~~

## 例: 1 つのレポート、複数の出力先

実際のプログラムでよくあるパターンは、出力を端末、ファイル、メモリ上の文字列のどれへ送るかを関数自身で決めるのではなく、ストリームを受け取る関数を書くことです。そうすると整形のコードを 1 か所に保て、再利用しやすくなります。

下では、ストリーム引数は省略可能な引数（`&key` 引数でも構いません）で、デフォルトは標準出力です。

~~~lisp
(defun write-expense-report (expenses &optional (stream t))
  "Write a small summary of our expenses."
  (format stream "Expense report~%")
  (format stream "==============~%")
  (dolist (entry expenses)
    (format stream "~a: ~,2f EUR~%" (first entry) (second entry)))
  (format stream "--------------~%")
  (format stream "Total: ~,2f EUR~%"
          (loop for entry in expenses
                sum (second entry))))
~~~

同じ関数を、今度は異なる出力先に向けられます。

~~~lisp
(let ((expenses '(("Books" 12.50)
                  ("Train" 24.10)
                  ("Lunch" 18.00))))
  ;; 1. REPL / 端末に出力する（デフォルト）
  (write-expense-report expenses)

  ;; 2. ファイルに保存する
  (with-open-file (out "/tmp/expenses.txt"
                       :direction :output
                       :if-exists :supersede)
    (write-expense-report expenses out))

  ;; 3. テストやメール本文用に文字列として捕捉する
  (with-output-to-string (out)
    (write-expense-report expenses out)))

;; => "Expense report
;; => ==============
;; => Books: 12.50 EUR
;; => Train: 24.10 EUR
;; => Lunch: 18.00 EUR
;; => --------------
;; => Total: 54.60 EUR
;; => "
~~~

[​]{#stream--3}

### 2 つのストリームに同時に書き込む

tee 風の出力、つまり Unix の `tee` コマンドのように同じ出力を 2 つのストリームに同時に書き込みたい場合も、ブロードキャストストリームで出力先を組み合わせられます。

~~~lisp
(let* ((expenses '(("Books" 12.50)
                   ("Train" 24.10)))
       (copy (make-string-output-stream))
       (tee (make-broadcast-stream *standard-output* copy)))
  (write-expense-report expenses tee)
  (get-output-stream-string copy))
~~~

[​]{#two-way-stream--echo-stream}

## 双方向ストリームとエコーストリーム

**双方向ストリーム** は、入力ストリームと出力ストリームを 1 つの双方向ストリームに束ねます。

~~~lisp
(let* ((in (make-string-input-stream "42"))
       (out (make-string-output-stream))
       (two-way (make-two-way-stream in out)))
  (format two-way "answer: ~a~%"
          (read two-way))
  (get-output-stream-string out))
;; => "answer: 42
;; "
~~~

**エコーストリーム** は双方向ストリームの一種で、入力ストリームから読み取ったすべてを出力ストリームにそのまま書き出します。これは対話セッションのログ記録や録画に便利です。

~~~lisp
(let* ((in (make-string-input-stream "hello"))
       (out (make-string-output-stream))
       (echo (make-echo-stream in out)))
  (read-char echo)  ;; #\h を読み取り、out にも書き込む
  (read-char echo)  ;; #\e を読み取り、out にも書き込む
  (get-output-stream-string out))
;; => "he"
~~~

## シノニムストリーム

シノニムストリームは間接参照として機能します。すべての操作を、あるシンボルの現在値であるストリームへ転送します。`*terminal-io*` は通常シノニムストリームです。

~~~lisp
(let* ((a-stream (make-string-input-stream "123"))
       (b-stream (make-string-input-stream "456"))
       (my-synonym (make-synonym-stream 'c-stream)))

  ;; シノニムストリームのシンボルを A に設定:
  (setf c-stream a-stream)
  (format t "reading stream A: ~a~&" (read my-synonym))

  ;; ストリームを B に切り替える:
  (setf c-stream b-stream)
  (format t "and now reading stream B: ~a~&" (read my-synonym)))
~~~

これにより、ストリームオブジェクト自体を変更せずに、シンボルの再束縛によってストリームの行き先をリダイレクトできます。

[​]{#stream--buffer-finish-output}

## 落とし穴: ストリームはバッファされることがある、`finish-output`

一部のストリームはバッファされることがあり、バッファされた出力はすぐに現れない可能性があることに注意してください。`finish-output` を使います。

起こり得ることは、バッファが短時間データを保持してからストリームに渡すということです。この仕組みは一般に、負荷がある状況で、入力元がストリームの処理能力より速くデータを供給する場合に便利です。

したがって、次のコードは通常移植性がなく、処理系や状況（忙しい端末で実行している等）に依存して変わる可能性があります。

~~~lisp
(write "enter an expression > ")
(read)
~~~

論理的には、プロンプト文字列を読んでから式を入力すると期待します。

しかし、端末にテキストが表示される前にブロッキングする `(read)` に入ってしまうことがあります。

すべてのストリーム output が時間どおりに書き込まれるようにするには、`finish-output` を使います。

~~~lisp
(write "enter an expression > ")
(finish-output)
(read)
~~~

`uiop` は `uiop:format!` も定義しており、これはストリームに出力する前後で `finish-output` を呼び出します。

[`force-output` と `clear-output`](https://cl-community-spec.github.io/pages/finish_002doutput.html) も参照してください（バッファの内容を出力し始めますが完了を待たず、出力操作の中止を試みます）。

[​]{#stream--macro}

## さらに多くのストリーム関数とマクロ

それらすべては [CLCS のストリーム辞書](https://cl-community-spec.github.io/pages/Streams-Dictionary.html) で参照できます。

### `listen`

[listen](https://cl-community-spec.github.io/pages/listen.html):

> input-stream から直ちに利用可能な文字がある場合 true を返し、それ以外の場合 false を返します。対話的でない input-stream では、ファイルの終端_1 の場合を除き listen は true を返します。ファイルの終端に遭遇した場合、listen は false を返します。listen は、input-stream がキーボードのような対話的なデバイスから文字を取得する場合に使うことを意図しています。


### `terpri, fresh-line`

[terpri](https://cl-community-spec.github.io/pages/terpri.html)
は常に出力ストリームに改行を書き込みます。

`fresh-line` は、ストリームが行頭にない場合にのみ改行を書き込みます。


### `y-or-n-p`, `yes-or-no-p`

[これらの関数](https://cl-community-spec.github.io/pages/y_002dor_002dn_002dp.html) は prompt を `*query-io*` に print し、ユーザー入力（1 文字の "y" または "n"、あるいは完全な "yes" または "no"）を待ち、boolean 値を返します。


### `with-open-stream`

[with-open-stream](https://cl-community-spec.github.io/pages/with_002dopen_002dstream.html)
は「ストリームに対して一連の操作を実行し、値を返した後、ストリームを閉じます」。

このマクロは、ストリームの context で式を実行し、その後確実に閉じるために使えます。

Lem editor からの例です。`make-buffer-output-stream` は editor buffer を作成し、そのストリームを開いたままにする primitive です。`with-open-stream` を使って content を書き込みます。

```lisp
(defun display-welcome ()
  (when *enable-welcome*
    ;; start buffer に welcome message を print する
    (with-open-stream (stream (make-buffer-output-stream (buffer-start-point (current-buffer))))
      (loop :with prefix := (/ (- (window-width (current-window)) *message-width*) 2)
            :for line :in (str:lines *message-content*)
            :do (format stream "~v@{~a~:*~}" prefix " ")
            :do (format stream "~a~%" line)))))
```


## Gray stream: protocol の拡張

標準のストリーム型は Common Lisp ランタイムによって実装されています。それらを使ってファイル、文字列、ソケット、端末のストリームを _利用_ できますが、通常の Common Lisp 入出力操作に対応する新しいストリームクラスの定義方法は標準化されていません。独自の動作を持つストリーム（たとえば、データを圧縮するストリーム、バイト数を数えるストリーム、文字を変換するストリーム、ファイル記述子ではなくアプリケーションオブジェクトから読み込むストリーム）が必要なら、**Gray ストリーム**を使えます。

Gray ストリームは de facto standard です。ANSI Common Lisp が final になる前に提案され、CLtL のストリーム章に基づいています。ANSI 標準には入りませんでしたが、人気のあるほとんどの処理系はこの protocol をサポートしています。実際には、`read-char`、`write-char`、`read-sequence`、`write-sequence` のような標準関数で動く custom ストリームを定義する通常の方法が Gray ストリームです。

[`trivial-gray-streams`](https://github.com/trivial-gray-streams/trivial-gray-streams)
ライブラリは portable インターフェイスを提供します。

これを使うには、下の `fundamental-character-output-stream` のような fundamental gray ストリームを subclass し、新しいストリームクラスに必要なメソッドを定義します。下の文字 output ストリームでは、`stream-write-char` と `stream-line-column` という 2 つのメソッドを定義しなければなりません。


~~~lisp
;; .asd 内:
;; :depends-on ("trivial-gray-streams")

(defclass counting-stream (trivial-gray-streams:fundamental-character-output-stream)
  ((inner :initarg :inner :reader inner-stream)
   (count :initform 0 :accessor char-count)))

(defmethod trivial-gray-streams:stream-write-char ((stream counting-stream) char)
  (incf (char-count stream))
  (write-char char (inner-stream stream)))

(defmethod trivial-gray-streams:stream-line-column ((stream counting-stream))
  nil)
~~~

そして次のように使います。

~~~lisp
(let* ((out (make-string-output-stream))
       (counting (make-instance 'counting-stream :inner out)))
  (write-string "hello" counting)
  (values (get-output-stream-string out)
          (char-count counting)))
;; => "hello"
;; => 5
~~~

### Gray stream: fundamental class

このライブラリは次のクラスを定義します。

```
trivial-gray-streams:fundamental-stream
trivial-gray-streams:fundamental-input-stream
trivial-gray-streams:fundamental-binary-stream
trivial-gray-streams:fundamental-output-stream
trivial-gray-streams:fundamental-character-stream
trivial-gray-streams:fundamental-binary-input-stream
trivial-gray-streams:fundamental-binary-output-stream
trivial-gray-streams:fundamental-character-input-stream
trivial-gray-streams:fundamental-character-output-stream
```

### Gray stream: method

実装すべき主要なメソッドはストリームの型に依存します。どのメソッドが必須で、どれが省略可能かに注意してください。

**character input streams** について:

- `stream-read-char` - 1 文字を読む。
  - ストリームが end-of-file の場合、シンボル `:eof` を返します。
- `stream-unread-char` - 文字を押し戻す。
- `stream-read-char-no-hang`（optional）- blocking しない文字 read
- `stream-read-line`（optional、performance のため）
- `stream-read-sequence`（optional、performance のため）

`` のすべての subclass は、最初の 2 つの関数のメソッドを定義しなければなりません。

**character output streams** について:

- `stream-write-char` - 1 文字を書き込む
- `stream-line-column` - 次の文字が書き込まれる column number を返す。このストリームで意味がない場合は NIL を返す。
- `stream-write-string`（optional、performance のため）
- `stream-write-sequence`（optional、performance のため）

**binary streams** について:

- `stream-read-byte`
- `stream-write-byte`
- `stream-read-sequence` / `stream-write-sequence`

シーケンス用メソッドにより、ストリームはデータのまとまった範囲を一度に移動できます。これは 1 文字または 1 バイトずつ読み書きするより、多くの場合はるかに高速です。

## 参考

- [CLHS: Streams](http://www.lispworks.com/documentation/HyperSpec/Body/21_.htm)
- [CLtL2: Streams](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node329.html)
- [trivial-gray-streams](https://github.com/trivial-gray-streams/trivial-gray-streams)
- [flexi-streams](https://edicl.github.io/flexi-streams/) - FLEXI-STREAMS は「実体のあるバイナリストリームまたは双方向型ストリームの上に重ねられ、各種の単一オクテットまたは複数オクテットの符号化方式で文字データを読み書きでき、その符号化方式を動的に変更できる仮想的な双方向型ストリーム」を実装します。また、文字列ストリームに似たメモリ上のバイナリストリームも提供します。
- [nontrivial-gray-streams](https://github.com/yitzchak/nontrivial-gray-streams) - Gray ストリーム protocol の拡張（Sequence Extensions、File Position Extensions…）。trivial-gray-streams とは異なり、fundamental ストリームクラスの独自 subclass を導入しません。代わりに、CL 処理系の fundamental ストリームクラスを直接 export します。
- [SBCL の双方向型ストリーム](https://www.sbcl.org/manual/#Bivalent-Streams) - 「双方向型ストリームは `character` と `(unsigned-byte 8)` の値をどちらも読み書きできます。引数 `:element-type :default` を指定して `open` を呼び出すことで作成します。このストリームでは、通常の入出力関数でバイナリデータと文字データの両方を読み書きできます。」
- [Allegro CL's simple-streams](https://franz.com/support/documentation/10.1/doc/streams.htm) - [SBCL の subset](https://www.sbcl.org/manual/#Simple-Streams) もあります。
 
#  コードのテスト {#chapter-testing}
 

書いているコードを手軽にテストしたいですか。このレシピでは、自動テストの書き方とコードカバレッジの確認方法を扱います。さらに、GitHub Actions、GitLab CI、Travis CI、Coveralls といった現代的な継続的インテグレーションサービスへ組み込むための手がかりも示します。

ここでは、[FiveAM](https://github.com/lispci/fiveam) という成熟したテストフレームワークを使います。テストスイート、ランダムテスト、テストフィクスチャ、そしてもちろん対話的開発をサポートしています。

以前の Cookbook では [Prove](https://github.com/fukamachi/prove) を使っていました。かつては広く好まれたテストフレームワークでしたが、いくつかの弱点があり、のちにリポジトリはアーカイブされました。後継の [Rove](https://github.com/fukamachi/rove) はまだ安定性が十分ではなく、いくつかの機能も不足しているため、ここでは採用しませんでした。気が向けば、[他のテストフレームワーク](https://github.com/CodyReichert/awesome-cl#unit-testing) も試してみてください。

FiveAM には [API ドキュメント](https://common-lisp.net/project/fiveam/docs/index.html) があります。そこを参照してもよいですし、コード中の docstring を読むだけでもかまいません。たいていは、それだけで疑問に答えるのに十分な情報が得られます。ここに載っていない場合でもです。では始めましょう。

## FiveAM でテストする

FiveAM には 3 段階の抽象化があります。`check`、`test`、`suite` です。名前の通りです。

1. **check** は、引数が真であることを確認する単一のアサーションです。もっともよく使うのは `is` です。たとえば `(is (= 2 (+ 1 1)))` です。
2. **test** は、実行可能な最小単位です。1 つのテストケースに複数の check を含められます。どれか 1 つでも失敗すると、そのテスト全体が失敗になります。
3. **suite** はテストの集合です。suite を実行すると、その中のすべてのテストが実行されます。suite には親子関係を持たせられるので、ある suite を走らせると、その中で定義されたテストと子 suite のテストもまとめて実行されます。

上の 3 つの基本ブロックを含む簡単な例は次のとおりです。

~~~lisp
(def-suite* my-suite)

(test my-test
  (is (= 2 (+ 1 1))))
~~~

テストと suite の階層は、完全に利用者次第です。ここでは主に FiveAM の使い方に注目します。

かなり複雑なシステムを作っていて、次の関数がその一部だとしましょう。

~~~lisp
;; We have a custom "file doesn't exist" condition.
(define-condition file-not-existing-error (error)
  ((filename :type string :initarg :filename :reader filename)))

;; We have a function that tries to read a file and signals the above condition
;; if the file doesn't exist.
(defun read-file-as-string (filename &key (error-if-not-exists t))
  "Read file content as string. FILENAME specifies the path of file.

Keyword ERROR-IF-NOT-EXISTS specifies the operation to perform when the file
is not found. T (by default) means an error will be signaled. When given NIL,
the function will return NIL in that case."
  (cond
    ((uiop:file-exists-p filename)
     (uiop:read-file-string filename))
    (error-if-not-exists
     (error 'file-not-existing-error :filename filename))
    (t nil)))
~~~

このコードに対するテストを書きます。特に、次を保証する必要があります。

- ファイルから読み込んだ内容が期待どおりであること
- ファイルが存在しないときに条件がシグナルされること


### インストールと読み込み

`FiveAM` は Quicklisp にあり、次のコマンドで読み込めます。

~~~lisp
(ql:quickload "fiveam")
~~~

パッケージ名は `fiveam` で、ニックネームは `5am` です。簡単のため、以下のコード例ではパッケージ接頭辞を省略します。

これは、テスト用パッケージ定義で fiveam を `:use` したのと同じようなものです。REPL では `(use-package :fiveam)` として追いかけてもかまいません。

使えるパッケージ定義の例を示します。

```lisp
(in-package :cl-user)
(defpackage my-fiveam-test
  (:use :cl
        :fiveam))
(in-package :my-fiveam-test)
```

### suite を定義する (`def-suite`, `def-suite*`)

FiveAM でのテストは、通常 suite を定義するところから始まります。suite を使うと、テストを小さなまとまりに分けられて整理しやすくなります。ASDF との統合を考えるなら、単一の *root* suite を定義することを強く勧めます。これについては後で触れます。ここではまず、テストそのものに集中しましょう。

以下のコードは `my-system` という suite を定義しています。システム全体の root suite として使います。

~~~lisp
(def-suite my-system
  :description "Test my system")
~~~

次に、`read-file-as-string` 関数をテストする別の suite を定義しましょう。

~~~lisp
;; suite を定義し、以降のテストのデフォルトに設定する。
(def-suite read-file-as-string
  :description "Test the read-file-as-string function."
  :in my-system)
(in-suite read-file-as-string)

;; Alternatively, the following line is a combination of the 2 lines above.
(def-suite* read-file-as-string :in my-system)
~~~

ここで `read-file-as-string` という新しい suite を定義しました。`:in` キーワードで指定したとおり、`my-system` の子 suite になっています。マクロ `in-suite` は、後で定義するテストのデフォルト suite をこの suite に設定します。

### テストを定義する

テストに入る前に、テストの中で使える check を簡単に紹介します。

* `is` マクロは、おそらくもっともよく使う check です。与えた式が真値を返すかを確認し、それに応じて `test-passed` または `test-failure` を返します。
* `skip` マクロは理由を受け取り、`test-skipped` を返します。
* `signals` マクロは、実行中に指定した条件がシグナルされたかを確認します。

ほかにもあります。

* `finishes`: アサーション本体が正常終了すれば成功です。つまり、本体がエラーをシグナルしたり非ローカルなジャンプを行ったりした場合、このテストは失敗します。
* `pass`: テストを成功としてマークします。
* `is-true`: `is` に似ていますが、失敗の報告内容を決めるためにアサーション本体を調べません。これと同様に `is-false` もあります。

なお、すべての check はオプションで理由文字列を受け取れます。この文字列は `format` ディレクティブで整形できます（後述）。省略した場合、FiveAM は関数に渡された引数に基づいて失敗理由を説明するレポートを生成します。

`test` マクロは、名前付きのテストを簡単に定義するためのものです。

*以下では 2 つのファイルが存在すると仮定します。`/tmp/hello.txt` には "hello" が入っていて、`/tmp/empty.txt` は空です。*

~~~lisp
;; 最初の基本ケース: "hello" を含むファイルを読む。
(test read-file-as-string-normal-file
  (let ((result (read-file-as-string "/tmp/hello.txt")))
    ;; ヒント: = や equal, string= などでは、期待値を第 1 引数に置く。
    ;; FiveAM はこの慣例に従うと、より読みやすいレポートを生成する。
    (is (string= "hello" result))))

;; 空のファイルを読む。
(test read-file-as-string-empty-file
  (let ((result (read-file-as-string "/tmp/empty.txt")))
    (is (not (null result)))
    ;; 理由には整形済みテキストを指定できる。
    (is (= 0 (length result)))
        "Empty string expected but got ~a" result))

;; では、存在しないファイルを読むとこの条件がシグナルされることを確認する。
(test read-file-as-string-non-existing-file
  (let ((result (read-file-as-string "/tmp/non-existing-file.txt"
                                     :error-if-not-exists nil)))
    (is (null result)
      "Reading a file should return NIL when :ERROR-IF-NOT-EXISTS is set to NIL"))
  ;; SIGNALS は、クォートしない条件名と評価する本体を受け取る。
  ;; ここでは FILE-NOT-EXISTING-ERROR がシグナルされるかを調べる。
  (signals file-not-existing-error
    (read-file-as-string "/tmp/non-existing-file.txt"
                         :error-if-not-exists t)))
~~~

上のコードでは、3 つのテストと合計 5 つの check を定義しました。デモのために、いくつかの check は実際には冗長です。すべての check を 1 つの大きなテストにまとめてもよいですし、複数のシナリオに分けてもかまいません。そこは自由です。

`test` マクロは、`def-test` を使って単純なテストを定義するための便利なラッパーです。たとえば `:depends-on` についても含め、より詳しくは docstring を読んでください。

### テストを実行する

FiveAM にはテストの実行方法がいくつかあります。開発中の出発点としては、`run!` マクロが便利です。suite 名または test 名を受け取り、それを実行して標準出力にレポートを出します。では、実際に走らせてみましょう。

~~~lisp
(run! 'my-system)
; Running test suite MY-SYSTEM
;  Running test READ-FILE-AS-STRING-EMPTY-FILE ..
;  Running test READ-FILE-AS-STRING-NON-EXISTING-FILE ..
;  Running test READ-FILE-AS-STRING-NORMAL-FILE .
;  Did 5 checks.
;     Pass: 5 (100%)
;     Skip: 0 ( 0%)
;     Fail: 0 ( 0%)
;  => T, NIL, NIL
~~~

`read-file-as-string-non-existing-file` の `/tmp/non-existing-file.txt` を `/tmp/hello.txt` に置き換えて壊すと、期待どおり（当然！）テストは失敗します。

~~~lisp
(run! 'read-file-as-string-non-existing-file)
; Running test READ-FILE-AS-STRING-NON-EXISTING-FILE ff
;  Did 2 checks.
;     Pass: 0 ( 0%)
;     Skip: 0 ( 0%)
;     Fail: 2 (100%)
;  Failure Details:
;  --------------------------------
;  READ-FILE-AS-STRING-NON-EXISTING-FILE []:
;       Should return NIL when :ERROR-IF-NOT-EXISTS is set to NIL.
;  --------------------------------
;  --------------------------------
;  READ-FILE-AS-STRING-NON-EXISTING-FILE []:
;       Failed to signal a FILE-NOT-EXISTING-ERROR.
;  --------------------------------
;  => NIL
; (#<IT.BESE.FIVEAM::TEST-FAILURE {10064485F3}>
;  #<IT.BESE.FIVEAM::TEST-FAILURE {1006438663}>)
; NIL
~~~

suite/test ランナーの挙動は `*on-failure*` 変数で調整できます。これは check が失敗したときにどうするかを制御します。次の値を設定できます。

- `:debug`: デバッガに入る。
- `:backtrace`: バックトレースを表示して続行する。
- `NIL`（既定値）: そのまま続行し、レポートを表示する。

`*on-error*` もあります。

#### コンパイル時にテストを実行する

通常、テストは書いてコンパイルし（Slime ならおなじみの `C-c C-c`）、実行はその後で別に行います。定義した瞬間に（`C-c C-c` で）テストを実行したいなら、次のように設定します。

~~~lisp
(setf fiveam:*run-test-when-defined* t)
~~~


### テスト説明をカスタマイズする

先ほど、check は `format` ディレクティブで整形できる任意の理由を受け取れると説明しました。簡単な例を示します。

ここでは数値関数をテストします。

~~~lisp
(fiveam:test simple-maths
  (is (= 3 (+ 1 1))))
~~~

これを `run!` すると、少し長いですが情報量のある出力が表示されます。これは重要です。

```
Running test suite NIL
 Running test SIMPLE-MATHS f
 Did 1 check.
    Pass: 0 ( 0%)
    Skip: 0 ( 0%)
    Fail: 1 (100%)

 Failure Details:
 --------------------------------
 SIMPLE-MATHS []:

(+ 1 1)

 evaluated to

2

 which is not

=

 to

3


 --------------------------------
```

では、独自の理由を付けてみましょう。

~~~lisp
(fiveam:test simple-maths
  (is (= 3 (+ 1 1))
      "Maths should work, right? ~a. Another parameter is: ~S" t :foo))
~~~


すると次のようになります。

~~~
Running test suite NIL
 Running test SIMPLE-MATHS f
 Did 1 check.
    Pass: 0 ( 0%)
    Skip: 0 ( 0%)
    Fail: 1 (100%)

 Failure Details:
 --------------------------------
 SIMPLE-MATHS []:
      Maths should work, right? T. Another parameter is: :FOO
 --------------------------------
~~~

### フィクスチャ

FiveAM には、テストコンテキストを整えるための **fixture** という機能もあります。目的は、ある関数を呼ばずに常に同じ結果を返すようにすることです。ネットワークにアクセスする関数を想像してください。ネットワーク呼び出しを小さな関数に切り出し、fixture を書いて、テスト中はその関数が常に同じ既知の結果を返すようにしたいわけです。（ただし、その場合でも、実データとすべてのコードを使った "end to end" テストが別途必要になるかもしれません。）

ただし、FiveAM の fixture システムはマクロ以上のものではなく、[Mockingbird](https://github.com/pfdietz/mockingbird) のような他のライブラリと比べて機能は豊富ではありません。FiveAM のメンテナも、代わりに「ただマクロを使えばよい」と勧めています。

Mockingbird（おそらく他のライブラリも同様）では、基本機能に加えて、関数が何回呼ばれたか、どんな引数で呼ばれたか、といったことも数えられます。

### ランダムテスト

ランダムテストの目的は、開発者がテストケースを生成するのを助け、思いつかなかったケースを見つけることです。

使えるデータジェネレータはいくつかあります。たとえば次のものです。

~~~lisp
(gen-float)
#<CLOSURE (LAMBDA () :IN GEN-FLOAT) {1005A906AB}>

(funcall (gen-float))
9.220082e37

(funcall (gen-integer :max 27 :min -16))
26
~~~

ほかにも `gen-string`、`gen-list`、`gen-tree`、`gen-buffer`、`gen-character` があります。

また、与えたジェネレータから毎回新しい値を取り出して 100 回の check を実行する `for-all` もあります。

~~~lisp
(test randomtest
  (for-all ((a (gen-integer :min 1 :max 10))
            (b (gen-integer :min 1 :max 10)))
    "Test random tests."
    (is (<= a b))))
~~~

これを `run! 'randomtest` すると、おそらくエラーになるはずです。毎回 `a` が `b` 以下になるとは限りませんから。

詳細は [FiveAM のドキュメント](https://common-lisp.net/project/fiveam/docs/Checks.html#Random_0020_0028QuickCheck-ish_0029_0020testing) を参照してください。

Haskell の [QuickCheck](https://en.wikipedia.org/wiki/QuickCheck) に触発された [cl-quickcheck](https://github.com/mcandre/cl-quickcheck) や [Check-it](https://github.com/DalekBaldwin/check-it) もあります。


### ASDF 統合

`my-system` を 1 行でテストできると便利です。root suite を用意したほうがよいと言ったのを覚えていますか。理由はここにあります。

~~~lisp
(asdf:defsystem my-system
  ;; Parts omitted.
  :in-order-to ((test-op (test-op :my-system/test))))

(asdf:defsystem mitogrator/test
  ;; Parts omitted.
  :perform (test-op (op c)
                    (symbol-call :fiveam :run!
                                 (find-symbol* :my-system :my-system/test))))
~~~

最後の行は、ASDF に `my-system/test` パッケージからシンボル `:my-system` を読み込み、`fiveam:run!` を呼ぶよう指示しています。実際には、先ほど述べた `(run! 'my-system)` と同じです。

### ターミナルでテストを実行する

ここまでは、エディタの REPL からテストを実行していました。では、ターミナルからはどう実行するのでしょうか。

いつものように、必要な手順は次のとおりです。

- Lisp を起動する
- Quicklisp が有効になっていることを確認する（外部依存がある場合）
- 本体システムを読み込む
- テストシステムを読み込む
- FiveAM のテストを実行する

これらを新しい `run-tests.lisp` ファイルにまとめられます。

~~~lisp
(load "mysystem.lisp")
(load "mysystem-tests.lisp") ;; <-- where all the FiveAM tests are written.
(in-package :mysystem-tests)

(run!)  ;; <-- run all the tests and print the report.
~~~

そして、ソースファイルや Makefile から次のように呼び出せます。

~~~lisp
rlwrap sbcl --non-interactive --load mysystem.asd --eval '(ql:quickload :mysystem)' --load run-tests.lisp
;; Quicklisp がインストール済みで読み込まれていると仮定しています。
;; これは .sbclrc のような Lisp 起動ファイルで行えます。
~~~

ただしその方法に進む前に、下の継続的インテグレーション節で使う `CI-Utils` ツールを見てください。これには、ここまでの作業をすべてやってくれる `run-fiveam` コマンドがあります。

ただし、この方法でテストを回すなら、気をつけるべき点があります。それは **終了コード** です。`(run!)` はレポートを表示しますが、テストが成功したかどうかや、終了コードを 0 にするか（成功）、それ以外にするか（エラー）までは Lisp に伝えません。そのため、CI 上ではテストが失敗しても常に緑になってしまいます。これを避けるには、`run!` を次のように置き換えます。

~~~lisp
(let ((result (run!)))
  (cond
    ((null result)
     (log:info "Tests failed!")  ;; FiveAM printed the report already.
     (uiop:quit 1))
    (t
     (log:info "All pass.")
     (uiop:quit))))
~~~

シェルで `echo $?` を確認して、終了コードが正しいか見てください。


### テストレポートをカスタマイズする

自分でテストレポートを生成することもできます。`run!` マクロは、`explain!` と `run` を組み合わせただけのものです。

`run!` のようにレポートを直接出す代わりに、`run` 関数は渡された suite や test を実行し、`test-result` のリストを返します。通常は `test-failure` や `test-passed` のサブクラスのインスタンスです。

`text-explainer` クラスは、テストレポート生成用の基本クラスとして定義されています。汎用関数 `explain` は `text-plainer` インスタンスと `run` が返した `test-result` インスタンスを受け取り、テストレポートを生成します。次の 2 つのコードは同値です。

~~~lisp
(run! 'read-file-as-string-non-existing-file)

(explain (make-instance '5am::detailed-text-explainer)
         (run 'read-file-as-string-non-existing-file))
~~~

`text-explainer` の新しいサブクラスを作り、それに対する `explain` メソッドを定義すれば、新しいテスト報告システムを作れます。

以下のコードは、概念実証としての実装にすぎません。完全に理解するには `5am::detailed-text-explainer` のソースを読む必要があるかもしれません。

~~~lisp
(defclass my-explainer (5am::text-explainer)
  ())

(defmethod 5am:explain ((explainer my-explainer) results &optional (stream *standard-output*) recursive-deps)
  (loop for result in results
        do (case (type-of result)
             ('5am::test-passed
              (format stream "~%Test ~a passed" (5am::name (5am::test-case result))))
             ('5am::test-failure
              (format stream "~%Test ~a failed" (5am::name (5am::test-case result)))))))

(explain (make-instace 'my-explainer)
         (run 'read-file-as-string-non-existing-file))
; Test READ-FILE-AS-STRING-NON-EXISTING-FILE failed
; Test READ-FILE-AS-STRING-NON-EXISTING-FILE passed => NIL
~~~


## 対話的にユニットテストを修正する

Common Lisp は本質的に対話的です（ほとんどの実装もそうです）。テストフレームワークはその特性を活かせます。失敗したテストでデバッガを開かせ、スタックトレースを確認して該当行へすぐ移動し、修正してから、提案された *restart* を選んで中断したところから再実行できます。

FiveAM では、`fiveam:*on-failure*` を `:debug` に設定します。

~~~lisp
(setf fiveam:*on-failure* :debug)
~~~

エラーが起きると対話デバッガに入ります。

`:backtrace` を使うと、バックトレースを表示して残りのテストを続行し、FiveAM のレポートを出します。

既定値は `nil` で、テスト実行を続けてレポートを表示します。


デバッガでは次の点に注意してください。

- バックトレース上で `<enter>` を押すと、さらに表示されます
- バックトレース上で `v` を押すと、対応する行や関数へ移動します
- ほかの操作はメニューから確認できます


## コードカバレッジ

コードカバレッジツールは、どの部分のコードがテストされ、どの部分がされていないかを視覚的に示します。


![](assets/coverage.png "source: https://www.snellman.net/blog/archive/2007-05-03-code-coverage-tool-for-sbcl.html")

こうした機能は Lisp 実装に組み込まれています。たとえば SBCL には [sb-cover](http://www.sbcl.org/manual/index.html#sb_002dcover) モジュールがあり、[CCL](https://ccl.clozure.com/docs/ccl.html#code-coverage) や [LispWorks](http://www.lispworks.com/documentation/lw71/LW/html/lw-68.htm) にも同様の機能があります。

### HTML のカバレッジ出力を生成する

SBCL の [sb-cover](http://www.sbcl.org/manual/index.html#sb_002dcover) でやってみましょう。

カバレッジレポートは、`compile-file` でコンパイルされたコードに対してのみ生成されます。その際、`sb-cover:store-coverage-data` の最適化品質を 3 に設定します。

~~~lisp
;;; Load SB-COVER
(require :sb-cover)

;;; Turn on generation of code coverage instrumentation
;;; in the compiler
(declaim (optimize sb-cover:store-coverage-data))

;;; Load some code, ensuring that it's recompiled
;;; with the new optimization policy.
(asdf:oos 'asdf:load-op :cl-ppcre-test :force t)

;;; Run the test suite.
(fiveam:run! yoursystem-test)
~~~

カバレッジレポートを出力するには、出力先ディレクトリを指定します。

~~~lisp
(sb-cover:report "coverage/")
~~~

最後に、計測をオフにします。

~~~lisp
(declaim (optimize (sb-cover:store-coverage-data 0)))
~~~

ブラウザで `../yourproject/t/coverage/cover-index.html` を開くと、上の画像のようなレポート、または [cl-ppcre のカバレッジ例](https://www.snellman.net/sbcl/cover/cl-ppcre-report-3/cover-index.html) のような表示を確認できます。


[​]{#continuous-integration}

## 継続的インテグレーション

継続的インテグレーションは、コミット後や pull request の前に自動テストを走らせたり、コード品質チェックを行ったり、ソフトウェアをビルドして配布したりするために重要です。要するに、ソフトウェア周りの作業を自動化するためのものです。

プログラムを Lisp 実装間で移植可能にしたいので、CI パイプラインを組み、複数の実装でテストを走らせます。もちろん SBCL と CCL でもよいですし、せっかくなら ABCL、ECL、ほかの実装も含められます。

利用できる継続的インテグレーションサービスには、Travis CI、Circle、GitLab CI、現在なら GitHub Actions などがあります（GitHub Actions より前から存在するものも多いです）。ここでは Common Lisp 用の CI パイプラインの組み方を見ていき、最後は少し GitLab CI に重点を置きます。

あわせて、カバレッジレポートを [Coveralls](https://coveralls.io/) に公開する方法も簡単に示します。[cl-coveralls](https://github.com/fukamachi/cl-coveralls) を使うと、カバレッジをこのサービスへ送れます。

### CI-Utils を使う GitHub Actions、Circle CI、Travis など

ここでは、たくさんの例を含むユーティリティ集 [CI-Utils](https://neil-lindquist.github.io/CI-Utils/) を使います。CI システムとは何かをより正確に説明し、十数種類のサービスも比較しています。

Lisp 実装のインストールとテスト実行には [Roswell](https://github.com/roswell/roswell/) を使います。インストールは bash の 1 行で済みます。

    curl -L https://raw.githubusercontent.com/roswell/roswell/release/scripts/install-for-ci.sh | bash

(GitLab CI の例では、これらをすべて含んだすぐ使える Docker イメージを使います)

FiveAM 用のテストランナーも付属しており、端末へ正しいエラーコードを返すといった面倒な部分を楽にしてくれます。Roswell で ci-utils をインストールすると、`run-fiveam` 実行ファイルが手に入ります。

すると、次のようにテストを実行できます。

    run-fiveam -e t -l foo/test :foo-tests  # foo is our project

以下は完全な `.travis.yml` です。

最初の部分は見れば分かるはずです。

```yml
### Travis CI の設定例 ###
language: generic

addons:
  homebrew:
    update: true
    packages:
    - roswell
  apt:
    packages:
      - libc6-i386 # needed for a couple implementations
      - default-jre # needed for abcl

# 各 OS で各 Lisp 実装を走らせる
os:
  - linux
#  - osx # OSX has a long setup on travis, so it's likely easier
#          to just run select implementations on OSX.
```

こうして実装マトリクスを設定し、複数の Lisp 実装でテストを実行します。SBCL で作ったテストカバレッジは Coveralls に送ります。

```yml
env:
  global:
    - PATH=~/.roswell/bin:$PATH
    - ROSWELL_INSTALL_DIR=$HOME/.roswell
#    - COVERAGE_EXCLUDE=t  # for rove
  jobs:
    # The implementation and whether coverage
    # is sent to coveralls are controlled
    # with these environmental variables
    - LISP=sbcl-bin COVERALLS=true
    - LISP=ccl-bin
    - LISP=abcl
    - LISP=ecl   # warn: in our experience,
    # compilations times can be long on ECL.

# 生成された組み合わせに、追加の OS/Lisp 組み合わせを
# 加えることもできます
jobs:
  include:
    - os: osx
      env: LISP=sbcl-bin
    - os: osx
      env: LISP=ccl-bin
```

一部のジョブは失敗を許可することもできます。


```yml
# これは、そのシステムでライブラリを動かすことに
# 興味がない場合にだけ使うべきです
#  allow_failures:
#    - env: LISP=abcl
#    - env: LISP=ecl
#    - env: LISP=cmucl
#    - env: LISP=alisp
#      os: osx

  fast_finish: true
```

最後に Roswell と各実装をインストールし、テストを実行します。

```yml
cache:
  directories:
    - $HOME/.roswell
    - $HOME/.config/common-lisp

install:
  - curl -L https://raw.githubusercontent.com/roswell/roswell/release/scripts/install-for-ci.sh | sh
  - ros install ci-utils #for run-fiveam
#  - ros install rove #for [run-] rove

  # If asdf 3.16 or higher is needed, uncomment the following lines
  #- mkdir -p ~/common-lisp
  #- if [ "$LISP" == "ccl-bin" ]; then git clone https://gitlab.common-lisp.net/asdf/asdf.git ~/common-lisp; fi

script:
  - run-fiveam -e t -l foo/test :foo-tests
  #- rove foo.asd
```

以下の GitLab CI では、Lisp バイナリと Quicklisp ライブラリのビルドに必要な Debian パッケージをすべて含んだ Docker イメージを使います。


### GitLab CI

[Gitlab CI](https://docs.gitlab.com/ce/ci/README.html) は Gitlab の一部で、[Gitlab.com](https://gitlab.com/) 上で公開・非公開どちらのリポジトリでも利用できます。さっそくシンプルな `.gitlab-ci.yml` を見てみましょう。

~~~
variables:
  QUICKLISP_ADD_TO_INIT_FILE: "true"

image: clfoundation/sbcl:latest

before_script:
  - install-quicklisp
  - git clone https://github.com/foo/bar ~/quicklisp/local-projects/

test:
  script:
    - make test
~~~

GitLab CI は Docker ベースです。`image` で [clfoundation/sbcl](https://hub.docker.com/r/clfoundation/sbcl/) イメージの `latest` タグを使うよう指定しています。これには SBCL の最新版、CI に便利な OS パッケージ群、Quicklisp をインストールするスクリプトが含まれています。GitLab はこのイメージを読み込み、プロジェクトをクローンし、残りのコマンドを実行できる管理権限付きの状態でプロジェクトルートに置いてくれます。

`test` は定義する "job" で、`script` は実行するコマンドの一覧を受け取る既知のキーワードです。

テストの前に依存関係を入れる必要がある場合、`before_script` は各 job の前に実行されます。ここでは Quicklisp をインストールし（SBCL の初期化ファイルへ追加し）、Quicklisp が見つけられる場所にライブラリをクローンしています。

手元でも試せます。すでに [Docker](https://docs.docker.com/) をインストールしていて、デーモンを起動済み（`sudo service docker start`）なら、次のようにできます。

    docker run --rm -it -v /path/to/local/code:/usr/local/share/common-lisp/source clfoundation/sbcl:latest bash

これで Lisp イメージ（圧縮で約 300MB）がダウンロードされ、指定した場所にローカルのコードがマウントされ、bash が起動します。これで `make test` を試せます。

以下は、複数の CL 実装に対して並列にテストする、もう少し完全な例です。

~~~yml
variables:
  IMAGE_TAG: latest
  QUICKLISP_ADD_TO_INIT_FILE: "true"
  QUICKLISP_DIST_VERSION: latest

image: clfoundation/$LISP:$IMAGE_TAG

stages:
  - test
  - build

before_script:
  - install-quicklisp
  - git clone https://github.com/foo/bar ~/quicklisp/local-projects/

.test:
  stage: test
  script:
    - make test

abcl test:
  extends: .test
  variables:
    LISP: abcl

ccl test:
  extends: .test
  variables:
    LISP: ccl

ecl test:
  extends: .test
  variables:
    LISP: ecl

sbcl test:
  extends: .test
  variables:
    LISP: sbcl

build:
  stage: build
  variables:
    LISP: sbcl
  only:
    - tags
  script:
    - make build
  artifacts:
    paths:
      - some-file-name
~~~

ここでは 2 つの `stages`（[環境](https://docs.gitlab.com/ee/ci/environments/) を参照）"test" と "build" を定義し、順番に実行するようにしています。"build" ステージは "test" が成功したときだけ始まります。

"build" は、毎回のコミットではなく、新しいタグが push されたときにだけ `only` で実行されます。成功すると、`artifacts` の `paths` に列挙したファイルをダウンロード可能にします。これらは GitLab の Pipelines UI から、または URL からダウンロードできます。次の URL は、最新の "build" job から "some-file-name" をダウンロードします。

    https://gitlab.com/username/project-name/-/jobs/artifacts/master/raw/some-file-name?job=build

パイプラインが通ると、次のように表示されます。

![](assets/img-ci-build.png)

これで、すぐ使える GitLab CI の設定ができました。

### SourceHut

[SourceHut](https://sr.ht/) の Common Lisp 向け CI を設定するのはとても簡単です。以下は最小構成の `.build.yml` で、[build manifest tester](https://builds.sr.ht/) で試せます。

```yaml
image: archlinux
packages:
- sbcl
- quicklisp
sources:
- https://git.sr.ht/~fosskers/cl-transducers
tasks:
# If our project isn't in the special `common-lisp` directory, quicklisp won't
# be able to find it for loading.
- move: |
    mkdir common-lisp
    mv cl-transducers ~/common-lisp
- quicklisp: |
    sbcl --non-interactive --load /usr/share/quicklisp/quicklisp.lisp --eval "(quicklisp-quickstart:install)"
- test: |
    cd common-lisp/cl-transducers
    sbcl --non-interactive --load ~/quicklisp/setup.lisp --load run-tests.lisp
```

与えられる Docker イメージはほぼ空なので、`sbcl` と `quicklisp` を手動でインストールする必要があります。さらに、テスト駆動用に `run-tests.lisp` ファイルを実行している点にも注意してください。例は次のようになります。

```lisp
(ql:quickload :transducers/tests)
(in-package :transducers/tests)

(let ((status (parachute:status (parachute:test 'transducers/tests))))
  (cond ((eq :PASSED status) (uiop:quit))
        (t (uiop:quit 1))))
```

ここでは [Parachute](https://shinmera.github.io/parachute/) テストライブラリの例を示しています。ほかの箇所でも述べたように、どれか 1 つでもテストが失敗したら CI ジョブ全体を失敗にするには、テスト結果の状態を手動で確認し、問題があれば `1` を返します。

## Emacs 統合: Slite を使ってテストを走らせる

[Slite](https://github.com/tdrhq/slite) は SLIme TEst runner の略です。テスト失敗の要約を見たり、テスト定義へ飛んだり、デバッガ付きでテストを再実行したりできます。しかも、これらを Emacs の中だけで行えます。緑と赤のバッジが並ぶダッシュボード風バッファが表示され、そこからテストに対処できます。テストの流れがさらに一体化し、対話的になります。

これは ASDF システムと Emacs パッケージで構成されています。新しいプロジェクト（2021 年半ばに登場）なので、2021 年 9 月時点では Quicklisp や MELPA からはまだインストールできません。導入方法は [リポジトリ](https://github.com/tdrhq/slite) を参照してください。

## 参考文献

- [Tutorial: Working with FiveAM](http://turtleware.eu/posts/Tutorial-Working-with-FiveAM.html), by Tomek "uint" Kurcz
- [Comparison of Common Lisp Testing Frameworks](https://sabracrolleton.github.io/testing-framework), by Sabra Crolleton.
- the [CL Foundation Docker images](https://hub.docker.com/u/clfoundation)

## 関連項目

- [cl-cookieproject](https://github.com/vindarel/cl-cookieproject), a project skeleton with a FiveAM tests structure.
 
#  データベースアクセスと永続化 {#chapter-databases}
 

[Database section on the Awesome-cl list](https://github.com/CodyReichert/awesome-cl#database)
は、さまざまな種類のデータベースを扱うための人気ライブラリを一覧したリソースです。
おおまかに 4 つのカテゴリに分類できます。

- 1 つのデータベースエンジン向けのラッパー (cl-sqlite, postmodern, cl-redis, …),
- 複数の DB エンジン向けのインターフェイス (clsql, sxql, …),
- 永続オブジェクトデータベース (bknr.datastore ("Common Lisp Recipes" の 21 章を参照), ubiquitous, …),
- [Object Relational Mappers](https://en.wikipedia.org/wiki/Object-relational_mapping) (Mito),

そのほかの DB 関連ツール (pgloader) もあります。

まず Mito の概要から始めます。既存の DB を扱う必要があるなら、
[cl-dbi](https://github.com/fukamachi/cl-dbi) や [clsql](https://clsql.kpe.io/manual/) を見てみるとよいでしょう。
SQL データベースが不要で、Lisp オブジェクトの自動永続化が欲しい場合にも、いくつかのライブラリを選べます。


## Mito ORM と SxQL

Mito は Quicklisp にあります。

~~~lisp
(ql:quickload "mito")
~~~

Mito は、使うデータベースドライバに応じて別のシステムをその場でロードします。
それらのシステムは次のとおりです。

    :dbd-sqlite3
    :dbd-mysql
    :dbd-postgres

これらのどれかをあらかじめ "quickload" してもよいですし、必要になったときに Mito (実際には cl-dbi) に任せてもかまいません。

ただし、プログラムの実行ファイルをビルドし、それを Quicklisp がインストールされていないマシンで使う予定なら、
必要な追加システムを .asd システム定義から参照しておく必要があります。


### 概要

[Mito](https://github.com/fukamachi/mito) is "an ORM for Common Lisp
with migrations, relationships and PostgreSQL support" です。

- **MySQL、PostgreSQL、SQLite3 をサポート**します。
- モデルを定義すると、Ruby の ActiveRecord や Django のように、デフォルトで `id`（連番の主キー）、
  `created_at`、`updated_at` フィールドを追加します。
- サポートするバックエンド向けの DB **マイグレーション**を扱います。
- DB **スキーマのバージョン管理**ができます。
- SBCL と CCL でテストされています。

ORM として、クラス定義を書き、リレーションを指定でき、データベースを問い合わせるための関数を提供します。
カスタムクエリには [SxQL](https://github.com/fukamachi/sxql) を使います。
SxQL は複数のバックエンドに同じインターフェイスを提供する SQL ジェネレータです。

Mito を使う作業は、一般に次の手順になります。

- DB に接続する
- モデルを定義するために [CLOS][Fundamentals of CLOS] クラスを書く
- テーブルを作成または変更するためにマイグレーションを実行する
- オブジェクトを作成し、DB に保存する

そして、この流れを繰り返します。

### DB への接続

Mito は RDBMS への接続を確立するために `connect-toplevel` 関数を提供します。

~~~lisp
(mito:connect-toplevel :mysql
                       :database-name "myapp"
                       :username "fukamachi"
                       :password "c0mon-1isp")
~~~

ドライバ種別には `:mysql`、`:sqlite3`、`:postgres` を指定できます。

sqlite ではユーザー名とパスワードは不要です。

~~~lisp
(mito:connect-toplevel :sqlite3 :database-name "myapp")
~~~

通常どおり、MySQL や PostgreSQL のデータベースは事前に作成しておく必要があります。
それぞれのドキュメントを参照してください。

接続すると `mito:*connection*` に新しい接続が設定され、その接続が返されます。

切断には `disconnect-toplevel` を使います。

ラッパー関数を用意すると便利でしょう。

~~~lisp
(defun connect ()
  "Connect to the DB."
  (mito:connect-toplevel :sqlite3 :database-name "myapp"))
~~~

### インメモリ DB への接続 (SQLite)

`sqlite3` のインメモリデータベースに接続するには、DB 名として ":memory:" 文字列を使います。
これは SQLite にとって特別な意味を持ちます。

~~~lisp
(mito:connect-toplevel :sqlite3 :database-name ":memory:")
~~~

これはディスク上にファイルを作成せず、DB もさらに高速になります。
ただし、接続を閉じるとすべてのデータを失います。
そのため、ユニットテストや一時的な分析用データのロードなどに特に便利です。

詳しくは [in-memory SQLite databases here](https://www.sqlite.org/inmemorydb.html) を参照してください。

### モデル

#### モデルの定義

Mito では、`deftable` マクロでデータベーステーブルに対応するクラスを定義できます。

~~~lisp
(mito:deftable user ()
  ((name :col-type (:varchar 64))
   (email :col-type (or (:varchar 128) :null))))
~~~
あるいは、通常のクラス定義で `(:metaclass mito:dao-table-class)` を指定することもできます。

`deftable` マクロはいくつかのスロットを自動的に追加します。主キーがない場合は `id` という名前の主キーを追加し、タイムスタンプ記録用に `created_at` と `updated_at` も追加します。
`deftable` フォームで `(:auto-pk nil)` と `(:record-timestamps nil)` を指定すると、これらの挙動を無効にできます。
`deftable` クラスには、名前付きスロットごとに、スロット名にちなんだ初期化引数と `<class-name>-<slot-name>` 形式のアクセサも用意されます。
たとえば上のテーブル定義の `name` スロットでは、コンストラクタに initarg `:name` が追加され、アクセサ `user-name` が作成されます。

新しいクラスは調べられます。

~~~lisp
(mito.class:table-column-slots (find-class 'user))
;=> (#<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS MITO.DAO.MIXIN::ID>
;    #<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS COMMON-LISP-USER::NAME>
;    #<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS COMMON-LISP-USER::EMAIL>
;    #<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS MITO.DAO.MIXIN::CREATED-AT>
;    #<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS MITO.DAO.MIXIN::UPDATED-AT>)
~~~

このクラスは暗黙に `mito:dao-class` を継承します。

~~~lisp
(find-class 'user)
;=> #<MITO.DAO.TABLE:DAO-TABLE-CLASS COMMON-LISP-USER::USER>

(c2mop:class-direct-superclasses *)
;=> (#<STANDARD-CLASS MITO.DAO.TABLE:DAO-CLASS>)
~~~

これは、すべてのテーブルクラスに適用できるメソッドを定義するときに便利かもしれません。

Common Lisp Object System の使い方について詳しくは [clos][Fundamentals of CLOS] ページを参照してください。


#### テーブルの作成

モデルを定義したら、テーブルを作成する必要があります。

~~~lisp
(mito:ensure-table-exists 'user)
~~~

そこで、ヘルパー関数を用意します。

~~~lisp
(defun ensure-tables ()
  (mapcar #'mito:ensure-table-exists '(user foo bar)))
~~~


ほかの方法については
[Mito's documentation](https://github.com/fukamachi/mito#generating-table-definitions)
も参照してください。

モデルを変更したら DB マイグレーションを実行する必要があります。次のセクションを参照してください。

#### フィールド

##### フィールド型

フィールド型は次のとおりです。

`(:varchar <integer>)`, `text`,

`:serial`, `:bigserial`, `:integer`, `:bigint`, `:unsigned`,

`:timestamp`, `:timestamptz`,

`:bytea`,

##### オプションフィールド

`(or <real type> :null)` を使います。

~~~lisp
   (email :col-type (or (:varchar 128) :null))
~~~


##### フィールド制約

`:unique-keys` は次のように使えます。

~~~lisp
(mito:deftable user ()
  ((name :col-type (:varchar 64))
   (email :col-type (:varchar 128))
  (:unique-keys email))
~~~

`:primary-key` はすでに見ました。

`:table-name` でテーブル名を変更できます。

#### リレーション

`:col-type` に外部クラスを指定することでリレーションを定義できます。

~~~lisp
(mito:deftable tweet ()
  ((status :col-type :text)
   ;; このスロットは USER クラスを参照する
   (user :col-type user))

(table-definition (find-class 'tweet))
;=> (#<SXQL-STATEMENT: CREATE TABLE tweet (
;        id BIGSERIAL NOT NULL PRIMARY KEY,
;        status TEXT NOT NULL,
;        user_id BIGINT NOT NULL,
;        created_at TIMESTAMP,
;        updated_at TIMESTAMP
;    )>)
~~~

これで `USER-ID` ではなく `USER` オブジェクトによって `TWEET` を作成または取得できます。

~~~lisp
(defvar *user* (mito:create-dao 'user :name "Eitaro Fukamachi"))
(mito:create-dao 'tweet :user *user*)

(mito:find-dao 'tweet :user *user*)
~~~

Mito は参照先テーブルに外部キー制約を追加しません。

##### 一対一

一対一のリレーションは、スロット上の単純な外部キーで表されます (`tweet` クラスの `:col-type user` など)。
さらに、`(:unique-keys email)` のように一意性制約を追加できます。

##### 一対多、多対一

上の tweet の例は、ユーザーとその tweet の一対多リレーションを示しています。
1 人のユーザーは多くの tweet を書けますが、1 つの tweet は 1 人のユーザーだけに属します。

このリレーションは、「多」側に置いた外部キーで「一」側へ戻るリンクとして定義します。
ここでは `tweet` クラスが `user` 外部キーを定義しているため、tweet は 1 人のユーザーだけを持てます。
`user` クラスを編集する必要はありませんでした。

多対一リレーションは、実際には一対多の逆です。
適切な側に外部キーを置く必要があります。

##### 多対多

多対多リレーションには中間テーブルが必要です。
この中間テーブルは、仲介する 2 つのテーブルそれぞれに対する「多」側になります。

そして結合テーブルのおかげで、リレーションに関する追加情報を保存できます。

`book` クラスを定義してみます。

~~~lisp
(mito:deftable book ()
    ((title :col-type (:varchar 128))
     (ean :col-type (or (:varchar 128) :null))))
~~~

ユーザーは多くの本を持てます。また、本 (物理的なコピーではなくタイトルとしての本) は多くの人のライブラリに含まれ得ます。
中間クラスは次のようになります。

~~~lisp
(mito:deftable user-books ()
    ((user :col-type user)
     (book :col-type book)))
~~~

ユーザーのコレクションに本を追加したいときは毎回 (`add-book` 関数内などで)、新しい `user-books` オブジェクトを作成します。

ただし、誰かが同じ本を複数冊所有していることも十分あり得ます。
これは結合テーブルに保存できる情報です。

~~~lisp
(mito:deftable user-books ()
    ((user :col-type user)
     (book :col-type book)
    ;; 数量を設定する。デフォルトは 1:
     (quantity :col-type :integer)))
~~~


#### 継承とミックスイン

DAO-CLASS のサブクラスは継承できます。
似たカラムを持つクラスが必要なときに便利です。

~~~lisp
(mito:deftable user ()
  ((name :col-type (:varchar 64))
   (email :col-type (:varchar 128)))
  (:unique-keys email))

(mito:deftable temporary-user (user)
  ((registered-at :col-type :timestamp)))

(mito:table-definition 'temporary-user)
;=> (#<SXQL-STATEMENT: CREATE TABLE temporary_user (
;        id BIGSERIAL NOT NULL PRIMARY KEY,
;        name VARCHAR(64) NOT NULL,
;        email VARCHAR(128) NOT NULL,
;        registered_at TIMESTAMP NOT NULL,
;        created_at TIMESTAMP,
;        updated_at TIMESTAMP,
;        UNIQUE (email)
;    )>)
~~~

どのデータベーステーブルにも関連しないテーブル用の「テンプレート」が必要な場合は、`defclass` フォームで `DAO-TABLE-MIXIN` を使えます。
下の `has-email` クラスはテーブルを作成しません。

~~~lisp
(defclass has-email ()
  ((email :col-type (:varchar 128)
          :initarg :email
          :accessor object-email))
  (:metaclass mito:dao-table-mixin)
  (:unique-keys email))
;=> #<MITO.DAO.MIXIN:DAO-TABLE-MIXIN COMMON-LISP-USER::HAS-EMAIL>

(mito:deftable user (has-email)
  ((name :col-type (:varchar 64))))
;=> #<MITO.DAO.TABLE:DAO-TABLE-CLASS COMMON-LISP-USER::USER>

(mito:table-definition 'user)
;=> (#<SXQL-STATEMENT: CREATE TABLE user (
;       id BIGSERIAL NOT NULL PRIMARY KEY,
;       name VARCHAR(64) NOT NULL,
;       email VARCHAR(128) NOT NULL,
;       created_at TIMESTAMP,
;       updated_at TIMESTAMP,
;       UNIQUE (email)
;   )>)
~~~

使用例は [mito-auth](https://github.com/fukamachi/mito-auth/) にさらにあります。


#### トラブルシューティング

##### "Cannot CHANGE-CLASS objects into CLASS metaobjects."

次のエラーメッセージが出た場合:

~~~
Cannot CHANGE-CLASS objects into CLASS metaobjects.
   [Condition of type SB-PCL::METAOBJECT-INITIALIZATION-VIOLATION]
See also:
  The Art of the Metaobject Protocol, CLASS [:initialization]
~~~

おそらく、最初にクラス定義を書き、その*後で* Mito のメタクラスを追加して、クラス定義をもう一度評価しようとしたためです。

この場合、現在のパッケージからクラス定義を取り除く必要があります。

~~~lisp
(setf (find-class 'foo) nil)
~~~

または Slime inspector でクラスをクリックし、"remove" ボタンを探します。

詳細は [here](https://stackoverflow.com/questions/38811931/how-to-change-classs-metaclass) にあります。

### マイグレーション

データベースマイグレーションは、下に示すように手動で実行できます。
また、モデル定義の変更後に自動でマイグレーションを実行することもできます。
自動マイグレーションを有効にするには、`mito:*auto-migration-mode*` を `t` に設定します。

最初の手順は、必要ならテーブルを作成することです。

~~~lisp
(ensure-table-exists 'user)
~~~

次にテーブルを変更します。

~~~lisp
(mito:migrate-table 'user)
~~~

生成される SQL コードは `migration-expressions 'class` で確認できます。
たとえば、`user` テーブルを作成します。

~~~lisp
(ensure-table-exists 'user)
;-> ;; CREATE TABLE IF NOT EXISTS "user" (
;       "id" BIGSERIAL NOT NULL PRIMARY KEY,
;       "name" VARCHAR(64) NOT NULL,
;       "email" VARCHAR(128),
;       "created_at" TIMESTAMP,
;       "updated_at" TIMESTAMP
;   ) () [0 rows] | MITO.DAO:ENSURE-TABLE-EXISTS
~~~

前の user 定義から変更はありません。

~~~lisp
(mito:migration-expressions 'user)
;=> NIL
~~~

では、一意な `email` フィールドを追加しましょう。

~~~lisp
(mito:deftable user ()
  ((name :col-type (:varchar 64))
   (email :col-type (:varchar 128)))
  (:unique-keys email))
~~~

マイグレーションは次のコードを実行します。

~~~lisp
(mito:migration-expressions 'user)
;=> (#<SXQL-STATEMENT: ALTER TABLE user ALTER COLUMN email TYPE character varying(128), ALTER COLUMN email SET NOT NULL>
;    #<SXQL-STATEMENT: CREATE UNIQUE INDEX unique_user_email ON user (email)>)
~~~

では適用します。

~~~lisp
(mito:migrate-table 'user)
;-> ;; ALTER TABLE "user" ALTER COLUMN "email" TYPE character varying(128), ALTER COLUMN "email" SET NOT NULL () [0 rows] | MITO.MIGRATION.TABLE:MIGRATE-TABLE
;   ;; CREATE UNIQUE INDEX "unique_user_email" ON "user" ("email") () [0 rows] | MITO.MIGRATION.TABLE:MIGRATE-TABLE
;-> (#<SXQL-STATEMENT: ALTER TABLE user ALTER COLUMN email TYPE character varying(128), ALTER COLUMN email SET NOT NULL>
;    #<SXQL-STATEMENT: CREATE UNIQUE INDEX unique_user_email ON user (email)>)
~~~


### クエリ

#### オブジェクトの作成

通常の `make-instance` で user オブジェクトを作成できます。

~~~lisp
(defvar me
  (make-instance 'user :name "Eitaro Fukamachi" :email "e.arrows@gmail.com"))
;=> USER
~~~

DB に保存するには `insert-dao` を使います。

~~~lisp
(mito:insert-dao me)
;-> ;; INSERT INTO `user` (`name`, `email`, `created_at`, `updated_at`) VALUES (?, ?, ?, ?) ("Eitaro Fukamachi", "e.arrows@gmail.com", "2016-02-04T19:55:16.365543Z", "2016-02-04T19:55:16.365543Z") [0 rows] | MITO.DAO:INSERT-DAO
;=> #<USER {10053C4453}>
~~~

上の 2 つの手順を一度に実行します。

~~~lisp
(mito:create-dao 'user :name "Eitaro Fukamachi" :email "e.arrows@gmail.com")
~~~

`user` シンボルを export せず、代わりに user を作成するヘルパー関数を使うことをおすすめします。

~~~lisp
(defun make-user (&key name)
  (make-instance 'user :name name))
~~~

いずれにせよ、データベース関連の操作はすべて、たとえば `models` パッケージとファイルにカプセル化するのがよい習慣です。


#### フィールドの更新

~~~lisp
(setf (slot-value me 'name) "nitro_idiot")
;=> "nitro_idiot"
~~~

そして保存します。

~~~lisp
(mito:save-dao me)
~~~

#### 削除

~~~lisp
(mito:delete-dao me)
;-> ;; DELETE FROM `user` WHERE (`id` = ?) (1) [0 rows] | MITO.DAO:DELETE-DAO

;; または:
(mito:delete-by-values 'user :id 1)
;-> ;; DELETE FROM `user` WHERE (`id` = ?) (1) [0 rows] | MITO.DAO:DELETE-DAO
~~~

#### 主キー値の取得

~~~lisp
(mito:object-id me)
;=> 1
~~~

#### カウント

~~~lisp
(mito:count-dao 'user)
;=> 1
~~~

#### 1 件検索

~~~lisp
(mito:find-dao 'user :id 1)
;-> ;; SELECT * FROM `user` WHERE (`id` = ?) LIMIT 1 (1) [1 row] | MITO.DB:RETRIEVE-BY-SQL
;=> #<USER {10077C6073}>
~~~

指定したキーでオブジェクトを検索する汎用ヘルパーの例を示します。

~~~lisp
(defgeneric find-user (key-name key-value)
  (:documentation "Retrieves an user from the data base by one of the unique
keys."))

(defmethod find-user ((key-name (eql :id)) (key-value integer))
  (mito:find-dao 'user key-value))

(defmethod find-user ((key-name (eql :name)) (key-value string))
  (first (mito:select-dao 'user
                          (sxql:where (:= :name key-value)))))
~~~

#### 全件検索

`select-dao` マクロを使います。

すべてのユーザーのリストを取得します。

~~~lisp
(mito:select-dao 'user)
;(#<USER {10077C6073}>)
;#<SXQL-STATEMENT: SELECT * FROM user>
~~~


#### リレーションによる検索

上で見たとおりです。

~~~lisp
(mito:find-dao 'tweet :user *user*)
~~~

#### カスタムクエリ

`select-dao` に [SxQL](https://github.com/fukamachi/sxql) 文を渡すことで、より精密なクエリを書けます。

例:

~~~lisp
(select-dao 'tweet
    (where (:like :status "%Japan%")))
~~~

別の例:

~~~lisp
(select (:id :name :sex)
  (from (:as :person :p))
  (where (:and (:>= :age 18)
               (:< :age 65)))
  (order-by (:desc :age)))
~~~

通常の Lisp コードでクエリを組み立てられます。

~~~lisp
(defun find-tweets (&key user)
  (select-dao 'tweet
    (when user
      (where (:= :user user)))
    (order-by :object-created)))
~~~

`select-dao` は適切なものへ展開されるマクロです。

<div class="info-box info">
<strong>Note:</strong> SXQL を <code>use</code> していない場合は、<code>(sxql:where …)</code> や <code>(sxql:order-by …)</code> と書きます。
</div>

#### クエリの合成

[SxQL's query composer](https://github.com/fukamachi/sxql/blob/master/COMPOSER.md) でクエリを合成できます。

以下の `->` は SxQL の threading マクロです。
クエリを連鎖させるための主要なインターフェイスです。
初期値を受け取り、それを一連の変換へ通していきます。

基本クエリを定義できます。ここではアクティブなユーザーを選択します。

```lisp
(use-package :sxql)  ;; sxql の全シンボルを import する。

(defvar *base-query*
  (-> (from :users)
      (where (:= :active 1))))
```

このクエリに `*base-query*` という名前を付けました。

これを拡張できます。以下では admin ユーザーでフィルタします。

```lisp
(defvar *admin-users*
  (-> *base-query*
      (where (:= :role "admin"))
      (order-by :name)))
```

Lisp の条件式を追加して、クエリを動的に構築することもできます。
`->` マクロは `nil` に評価される式をスキップします。

```lisp
(defun find-users (&key active role min-age search)
  (-> (from :users)
      (when active
        (where (:= :active 1)))
      (when role
        (where (:= :role role)))
      (when min-age
        (where (:>= :age min-age)))
      (when search
        (where (:like :name (format nil "%~A%" search))))
      (order-by :name)))

;; 使用例
(find-users :active t :role "admin" :min-age 18)
;=> SELECT * FROM users WHERE (((active = ?) AND (role = ?)) AND (age >= ?)) ORDER BY name
;   (1 "admin" 18)
```

SxQL は SQL クエリを構築・合成するための便利な方法を提供します。
詳しくはドキュメントを読んでください。


#### さらにカスタムクエリ

通常の Lisp S 式操作で SxQL 式を合成する例を示します。

空白区切りの単語で構成されているかもしれない `query` 文字列を受け取り、それらの単語のいずれかをタイトルまたは著者名に含む本を検索したいとします。
"alice adventure" を検索すると、タイトルに "adventure" があり著者名に "alice" がある本、または両方がタイトルにある本が返ります。

例を単純にするため、author は別テーブルへのリンクではなく文字列とします。

~~~lisp
(mito:deftable book ()
    ((title :col-type (:varchar 128))
     (author :col-type (:varchar 128))
     (ean :col-type (or (:varchar 128) :null))))
~~~

各単語について両方のフィールドを検索する句を追加したいとします。

~~~lisp
(defun find-books (&key query (order :desc))
  "Return a list of books.
If a query string is given, search on both the title
and the author fields."
  (mito:select-dao 'book
    (when (str:non-blank-string-p query)
      (sxql:where
       `(:and
         ,@(loop for word in (str:words query)
              :collect `(:or (:like :title
                                    ,(str:concat "%" word "%"))
                             (:like :authors
                                    ,(str:concat "%" word "%")))))))
       (sxql:order-by `(,order :created-at))))
~~~

ちなみに、ここではまだ `LIKE` 文を使っていますが、小さくないデータセットではデータベースの全文検索エンジンを使いたくなるでしょう。


#### 句

[SxQL documentation](https://github.com/fukamachi/sxql#sql-clauses) を参照してください。

例:

~~~lisp
(select-dao 'foo
  (where (:and (:> :age 20) (:<= :age 65))))
~~~

~~~lisp
(order-by :age (:desc :id))
~~~

~~~lisp
(group-by :sex)
~~~

~~~lisp
(having (:>= (:sum :hoge) 88))
~~~

~~~lisp
(limit 0 10)
~~~

ほかにも `join` などがあります。


#### 演算子

~~~lisp
:not
:is-null, :not-null
:asc, :desc
:distinct
:=, :!=
:<, :>, :<= :>=
:a<, :a>
:as
:in, :not-in
:like
:and, :or
:+, :-, :* :/ :%
:raw
~~~

### トリガー

`insert-dao`、`update-dao`、`delete-dao` は総称関数として定義されているため、通常の [メソッド結合](#qualifiers-and-method-combination) と同じように、それらに対して `:before`、`:after`、`:around` メソッドを定義できます。

~~~lisp
(defmethod mito:insert-dao :before ((object user))
  (format t "~&Adding ~S...~%" (user-name object)))

(mito:create-dao 'user :name "Eitaro Fukamachi" :email "e.arrows@gmail.com")
;-> Adding "Eitaro Fukamachi"...
;   ;; INSERT INTO "user" ("name", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?) ("Eitaro Fukamachi", "e.arrows@gmail.com", "2016-02-16 21:13:47", "2016-02-16 21:13:47") [0 rows] | MITO.DAO:INSERT-DAO
;=> #<USER {100835FB33}>
~~~

### Inflation/Deflation

Inflation/Deflation は、Mito と RDBMS の間で値を変換するための機能です。

~~~lisp
(mito:deftable user-report ()
  ((title :col-type (:varchar 100))
   (body :col-type :text
         :initform "")
   (reported-at :col-type :timestamp
                :initform (local-time:now)
                :inflate #'local-time:universal-to-timestamp
                :deflate #'local-time:timestamp-to-universal)))
~~~

### 事前読み込み（Eager loading）

ORM を使う際の悩みの 1 つが "N+1 query" 問題です。

~~~lisp
;; 悪い例

(use-package '(:mito :sxql))

(defvar *tweets-contain-japan*
  (select-dao 'tweet
    (where (:like :status "%Japan%"))))

;; tweet したユーザーの名前を取得する。
(mapcar (lambda (tweet)
          (user-name (tweet-user tweet)))
        *tweets-contain-japan*)
~~~

この例では、各反復で "SELECT * FROM user WHERE id = ?" のようなユーザー取得クエリを送信します。

この性能問題を避けるには、上のクエリに `includes` を追加します。
これにより、N 個のクエリではなく単一の WHERE IN クエリだけが送信されます。

~~~lisp
;; eager loading を使った良い例

(use-package '(:mito :sxql))

(defvar *tweets-contain-japan*
  (select-dao 'tweet
    (includes 'user)
    (where (:like :status "%Japan%"))))
;-> ;; SELECT * FROM `tweet` WHERE (`status` LIKE ?) ("%Japan%") [3 row] | MITO.DB:RETRIEVE-BY-SQL
;-> ;; SELECT * FROM `user` WHERE (`id` IN (?, ?, ?)) (1, 3, 12) [3 row] | MITO.DB:RETRIEVE-BY-SQL
;=> (#<TWEET {1003513EC3}> #<TWEET {1007BABEF3}> #<TWEET {1007BB9D63}>)

;; 追加の SQL は実行されない。
(tweet-user (first *))
;=> #<USER {100361E813}>
~~~

### カーソルによる反復 (do-select)

`do-select` は、`SELECT` の結果を 1 件ずつ反復するためのマクロです。

PostgreSQL では `CURSOR` を使います。
すべての結果をメモリにロードしないため、メモリ使用量を減らせます。

```common-lisp
(do-select (dao (select-dao 'user (where (:< "2024-07-01" :created_at))))
  ;; より複雑な条件でもよい
  (when (equal (user-name dao) "Eitaro")
    (return dao)))

;; 同じことを CURSOR を使わずに行う
(loop for dao in (select-dao 'user (where (:< "2024-07-01" :created_at)))
      when (equal (user-name dao) "Eitaro")
      do (return dao))
```

> NOTE: do-select は 2024 年 8 月に追加されました。DBI v0.11.1 以上が必要です。


### スキーマのバージョン管理

~~~
$ ros install mito
$ mito
Usage: mito command [option...]

Commands:
    generate-migrations
    migrate

Options:
    -t, --type DRIVER-TYPE          DBI driver type (one of "mysql", "postgres" or "sqlite3")
    -d, --database DATABASE-NAME    Database name to use
    -u, --username USERNAME         Username for RDBMS
    -p, --password PASSWORD         Password for RDBMS
    -s, --system SYSTEM             ASDF system to load (several -s's allowed)
    -D, --directory DIRECTORY       Directory path to keep migration SQL files (default: "/Users/nitro_idiot/Programs/lib/mito/db/")
    --dry-run                       List SQL expressions to migrate
~~~

### イントロスペクション

Mito はイントロスペクション用の関数をいくつか提供しています。

`(mito.class.column:...)` の関数で **columns** の情報にアクセスできます。

- `table-column-[class, name, info, not-null-p,...]`
- `primary-key-p`

同様に、**tables** については `(mito.class.table:...)` を使います。

クラスのスロット一覧を取得したとします。

~~~lisp
(ql:quickload "closer-mop")

(closer-mop:class-direct-slots (find-class 'user))
;; (#<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS NAME>
;;  #<MITO.DAO.COLUMN:DAO-TABLE-COLUMN-CLASS EMAIL>)

(defparameter user-slots *)
~~~

次のような問いに答えられます。

#### このカラムの型は何か?

~~~lisp
(mito.class.column:table-column-type (first user-slots))
;; (:VARCHAR 64)
~~~

#### このカラムは nullable か?

~~~lisp
(mito.class.column:table-column-not-null-p
  (first user-slots))
;; T
(mito.class.column:table-column-not-null-p
  (second user-slots))
;; NIL
~~~


### テスト

DB 操作を本番 DB に対してテストしたくはありません。
各テストの前に一時 DB を作成する必要があります。

下のマクロはランダムな名前の一時 DB を作成し、テーブルを作成し、コードを実行してから元の DB 接続へ戻します。

~~~lisp
(defpackage my-test.utils
  (:use :cl)
  (:import-from :my.models
                :*db*
                :*db-name*
                :connect
                :ensure-tables-exist
                :migrate-all)
  (:export :with-empty-db))

(in-package my-test.utils)

(defun random-string (length)
  ;; 40ants/hacrm に感謝。
  (let ((chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))
    (coerce (loop repeat length
                  collect (aref chars (random (length chars))))
            'string)))

(defmacro with-empty-db (&body body)
  "Run `body` with a new temporary DB."
  `(let* ((*random-state* (make-random-state t))
          (prefix (concatenate 'string
                               (random-string 8)
                               "/"))
          ;; 現在の DB 接続を保存する。
          (connection mito:*connection*))
     (uiop:with-temporary-file (:pathname name :prefix prefix)
       ;; 新しい DB を作成するため、*db-name* を新しい名前に束縛する。
       (let* ((*db-name* name))
         ;; body 内でエラーが起きても、常に実 DB へ再接続する。
         (unwind-protect
           (progn
             ;; DB へ接続し、テーブルを作成し、マイグレーションを実行する関数。
             (connect)
             (ensure-tables-exist)
             (migrate-all)
             ,@body)

           (setf mito:*connection* connection))))))
~~~

次のように使います。

~~~lisp
(prove:subtest "Creation in a temporary DB."
  (with-empty-db
    (let ((user (make-user :name "Cookbook")))
      (save-user user)

      (prove:is (name user)
                "Cookbook"
                "Test username in a temp DB."))))
;; Creation in a temporary DB
;;  CREATE TABLE "user" (
;;       id BIGSERIAL NOT NULL PRIMARY KEY,
;;       name VARCHAR(64) NOT NULL,
;;       email VARCHAR(128) NOT NULL,
;;       created_at TIMESTAMP,
;;       updated_at TIMESTAMP,
;;       UNIQUE (email)
;; ) () [0 rows] | MITO.DB:EXECUTE-SQL
;; ✓ Test username in a temp DB.
~~~

## 参考

- [exploring an existing (PostgreSQL) database with postmodern](https://sites.google.com/site/sabraonthehill/postmodern-examples/exploring-a-database)

- [mito-attachment](https://github.com/fukamachi/mito-attachment)
- [mito-auth](https://github.com/fukamachi/mito-auth)
- [can](https://github.com/fukamachi/can/) ロールベースのアクセス権制御ライブラリ

<!-- # todo: 既存 DB のモデル生成 -->
 
#  GUI ツールキット {#chapter-gui}
 

Lisp には長く豊かな歴史があり、GUI 開発にも同じことが言えます。実際、最初の GUI ビルダーは Lisp で書かれました（そして Apple に売却され、今では Interface Builder になっています）。

Lisp は対話的開発能力でも有名で、GUI アプリケーション開発ではこの利点がさらに大きくなります。関数 1 つをコンパイルしただけで GUI が即座に更新される様子を想像できるでしょうか。今日では多くの GUI フレームワークでこれが可能ですが、細部はそれぞれ異なります。

最後に、ソフトウェア開発では、どうビルドしてどう利用者へ届けるかも重要です。ここでも、主要な 3 つの OS 向けに自己完結型バイナリを作り、利用者がダブルクリックで実行できるようにできます。

ここでは、適切な GUI フレームワークを選ぶための情報を整理して示します。[contribute](https://github.com/LispCookbook/cl-cookbook/issues/) して、さらに例を追加したり、元のドキュメントを補ったりするのは歓迎です。


[​]{#introduction}

## はじめに

このレシピでは、次の GUI ツールキットを紹介します。

- [Tk][tk] と [Ltk][ltk] / [nodgui][nodgui]
- [Qt4][qt4] と [Qtools][qtools]
- [IUP][iup-tecgraf] と [lispnik/iup][iup-lisp]
- [Gtk3][gtk] と [cl-cffi-gtk][cl-cffi-gtk]
  - Gtk4 のバインディングが欲しい場合は [cl-gtk4](https://github.com/bohonghuang/cl-gtk4) を見てください。これは 2022 年 9 月に公開された新しいバインディングです。

- [Nuklear][nuklear] と [Bodge-Nuklear][bodge-nuklear]

加えて、次のものも見ておくとよいでしょう。

- [CAPI][capi] ツールキット（Common Application Programming Interface）,
  これは LispWorks 製のプロプライエタリなツールキットです。Windows、Gtk+、Cocoa をまたぐ完全なクロスプラットフォームツールキットで、利用者の評判も高いです。LispWorks には [iOS と Android のランタイム](http://www.lispworks.com/products/lw4mr.html) もあります。CAPI で作られた例として [ScoreCloud](https://scorecloud.com/) があります。LispWorks の無料デモで試せます。
- [Allegro CL の IDE と Common Graphics ウィンドウシステム](https://franz.com/products/allegro-common-lisp/acl_ide.lhtml)（プロプライエタリ）: Allegro の IDE はアプリケーション開発のための一般的な環境です。Common Graphics というウィンドウシステムと連携して動きます。この IDE は、Allegro CL の Microsoft Windows 版、Linux プラットフォーム、Free BSD、Mac 版で利用できます。
  - NEW! 🎉 Allegro CL 10.1（2022 年 3 月公開）以降、IDE と Common Graphics GUI ツールキットはブラウザ上で動きます。これを [CG/JS](https://franz.com/ftp/pri/acl/cgjs/doc.html) と呼びます。
- [CCL の組み込み Cocoa
  interface](https://ccl.clozure.com/docs/ccl.html#the-objective-c-bridge),
  [Opusmodus](https://opusmodus.com/) のようなアプリケーションを作るのに使われています。
- Clozure CL の組み込み [Objective-C bridge](https://ccl.clozure.com/docs/ccl.html#the-objective-c-bridge) と [CocoaInterface](https://github.com/plkrueger/CocoaInterface/) は、CCL 向けの Cocoa インターフェイスです。Lisp コードだけで Cocoa のユーザインターフェイスのウィンドウを動的に作れ、典型的な Xcode の手順を飛ばせます。
  - この bridge は ObjC エラーを拾って Lisp エラーに変換するのが得意なので、macOS GUI アプリケーションでも REPL ベースの反復開発サイクルを回せます。
* [McCLIM](https://common-lisp.net/project/mcclim/) と [Garnet](https://github.com/earl-ducaine/cl-garnet) は 100% Common Lisp のツールキットです。McCLIM には Broadway プロトコルでブラウザ上で動く [プロトタイプ](https://techfak.de/~jmoringe/mcclim-broadway-7.ogv) があり、Garnet には Gtk への継続的なインターフェイスがあります。
* [Alloy](https://github.com/Shirakumo/alloy) は、これも新しめの 100% Common Lisp ツールキットで、たとえば [Kandria](https://github.com/shinmera/kandria) ゲームで使われています。
* [eql, eql5, eql5-android](https://gitlab.com/eql) は、ECL に埋め込まれ、Qt にも埋め込める Qt4/Qt5 Lisp です。EQL5 の Android 移植版もあります。
* [ABCL から Java Swing を使うデモ](https://github.com/defunkydrummer/abcl-jazz)
* [SBCL で C ファイルなしに Gtk を使う例](https://github.com/mifpasoti/Gtk-Demos) と GTK-server。
* [Ceramic][ceramic] は、Electron でクロスプラットフォーム Web アプリを配布するためのものです。
  * 詳しくは Web Apps in Lisp の [Electron](https://web-apps-in-lisp.github.io/building-blocks/electron/index.html) と [Web view (webview, webui, CLOG Frame)](https://web-apps-in-lisp.github.io/building-blocks/web-views/index.html) を見てください。
* [Barium ツールキット](https://tomscii.sig7.se/barium/)
  * 例のアプリケーション: [ChessLab](https://tomscii.sig7.se/chesslab/) (2025)

そのほか、[awesome-cl#gui](https://github.com/CodyReichert/awesome-cl#Gui) と [Cliki](https://www.cliki.net/GUI) にあるものも参照してください。

### Tk (Ltk and nodgui)

[Tk][tk]（あるいは Tcl/Tk。Tcl がプログラミング言語です）は、古臭い見た目だという悪評があります。ですが、それは今では（それほど）当てはまりません。1997 年のバージョン 8 以降は特にそうです。たぶん、思っているより良いものです。

これは nodgui の組み込みテーマを使ったシンプルな GUI です（詳細は後述）。

![](assets/gui/nodgui-feet2meters-yaru.png)

同じテーマの treeview です。

![](assets/gui/nodgui-treeview-yaru.png)

Arc テーマを使った、ツリーリスト、チェックボックス、ボタン、ラベルを表示するおもちゃのメディアプレーヤーです。

![](assets/gui/mediaplayer-nodgui-arc.png)

MacOS テーマのデモです。

![](assets/gui/ltk-on-macos.png)

これらに加えて、[ttkthemes](https://ttkthemes.readthedocs.io/en/latest/themes.html) や [Forest テーマ](https://github.com/rdbende/Forest-ttk-theme) など多数のテーマを使えます。[この tcl/tk の一覧](https://wiki.tcl-lang.org/page/List+of+ttk+Themes) を見てください。

では Tk は何に向いているのでしょうか。Tk のウィジェットの種類は豊富ではありませんが、便利なキャンバスがあり、さらにいくつか独自の特徴があります。GUI を **完全に対話的に** 開発でき、コアアプリから GUI を **遠隔実行** できます。しかもクロスプラットフォームです。

つまり Tk はネイティブではなく、最先端の機能を備えているわけでもありませんが、実績のある GUI ツールキット（兼プログラミング言語）で、今も業界で使われています。単純な GUI を素早く作りたいとき、配布のしやすさを重視したいとき、安定性が必要なときに向いています。

Lisp バインディングは 2 つあります。[Ltk][ltk] と [nodgui][nodgui] です。Nodgui（"No Drama GUI"）は Ltk のフォークで、追加ウィジェット（たとえば自動補完リストウィジェット）、非同期イベントループ、そして何よりライブラリに付属する意外と見栄えの良い "Yaru" テーマを備えています。ほかのテーマを入れて使うのも簡単です。詳細は後述します。

- **Tk の実装言語**: Tcl
- **移植性**: クロスプラットフォーム (Windows, macOS, Linux).

- **ウィジェット**: Tk はウィジェットの豊富さが売りではありません。既定ウィジェットは **少数** で、デートピッカーのような重要なものが欠けています。拡張（**Nodgui** など）で補えますが、あまりネイティブには見えません。カレンダーは Tk 拡張が提供しており、こちらのほうが見栄えがよいです。

- **対話的な開発**: 非常に向いています。

- **GUI ビルダー**: なし

- **その他の機能**:
  - **遠隔実行**: Lisp と Tcl/Tk の接続はストリーム経由で行われます。そのため、Lisp プログラムを 1 台のコンピュータで動かし、GUI を別のコンピュータに表示できます。クライアント側に必要なのは tcl/tk のインストールと remote.tcl スクリプトだけです。[Ltk-remote](http://www.peter-herth.de/ltk/ltkdoc/node46.html) を見てください。

- **バインディングのドキュメント**: 短いですが十分です。Nodgui も同様です。
- **バインディングの安定性**: とても安定しています。
- **バインディングの活動状況**: Ltk は低め（主に保守）、Nodgui は活発（新機能あり）です。
- **ライセンス**: Tcl/Tk は BSD 風、Ltk は LGPL です。
- 例:
  - [Fulci](https://notabug.org/cage/fulci/) - 映画コレクションを整理するプログラムです。
  - [Ltk small games](https://github.com/mijohnson99/ltk-small-games) - snake と tic-tac-toe です。
  - [cl-pkr](https://github.com/VitoVan/cl-pkr) - クロスプラットフォームのカラーピッカーです。
  - [cl-torrents](https://github.com/vindarel/cl-torrents) - 人気のトラッカーのトレントを検索します。CLI、readline、シンプルな Tk GUI を備えています。
- 追加の例:
  - [https://peterlane.netlify.app/ltk-examples/](https://peterlane.netlify.app/ltk-examples/): [tkdocs](https://tkdocs.com/tutorial/index.html) チュートリアル向けの LTk 例です。
  - [LTk Plotchart](https://peterlane.netlify.app/ltk-plotchart/) - tklib/plotchart ライブラリを LTk で使うためのラッパーです。xy プロット、ガントチャート、3D 棒チャートなど 20 種類以上のチャートを含みます。


**ウィジェット一覧**

(網羅的な一覧ではありません)

```
Button Canvas Check-button Entry Frame Label Labelframe Listbox
Menu Menubutton Message
Paned-window
Radio-button Scale
Scrollbar Spinbox Text
Toplevel Widget Canvas

Ltk-megawidgets:
    progress
    history-entry
    menu-entry
```

nodgui に追加されるもの:

```
treelist tooltip searchable-listbox date-picker calendar autocomplete-listbox
password-entry progress-bar-star notify-window
dot-plot bar-chart equalizer-bar
swap-list
```

### Qt4 (Qtools)

Qt と [Qt4][qt4] を改めて紹介する必要があるでしょうか。Qt は非常に大きく、何でも入っています。UI ウィジェットだけでなく、ネットワークや D-BUS など多くの層を提供します。

Qt はオープンソースソフトウェアなら無料で使えますが、プロプライエタリソフトウェアを配布する場合は条件を確認してください。

[Qtools][qtools] バインディングは Qt4 を対象にしています。Qt5 の Lisp バインディングは [https://github.com/commonqt/commonqt5/](in the works) で、まだ本番向けではありません。

Qtools の付属ライブラリとして、最初の Qtools アプリケーションを作ったらぜひ見ておきたいのが [Qtools-ui](https://github.com/Shinmera/qtools-ui) です。便利なウィジェットと既成コンポーネントの集まりで、短い [デモ動画](https://www.youtube.com/playlist?list=PLkDl6Irujx9Mh3BWdBmt4JtIrwYgihTWp) もあります。

<!-- possible future: gobject-introspection -->

- **フレームワークの実装言語**: C++
- **フレームワークの移植性**: マルチプラットフォーム、Android、組み込みシステム、WASM。
- **バインディングの移植性**: Qtools は Windows、macOS、GNU/Linux の x86 デスクトッププラットフォームで動きます。

- **ウィジェットの選択肢**: 豊富。

- **GUI ビルダー**: あり。

- **その他の機能**: Web ブラウザなど多数。

- **バインディングのドキュメント**: 詳しい説明と少数の例があります。Qt の事前知識が必要です。
- **バインディングの安定性**: 安定。
- **バインディングの活動状況**: 活発。
- **Qt のライセンス**: 商用とオープンソースの両方があります。
- 例:
  - https://github.com/Shinmera/qtools/tree/master/examples
  - https://github.com/Shirakumo/lionchat
  - https://github.com/shinmera/halftone - シンプルな画像 viewer


### Gtk+3 (cl-cffi-gtk)

[Gtk+3][gtk] は [GNOME][gnome] アプリケーションを作る主要ライブラリです。Lisp バインディングとしては、現時点で最も進んでいるものが [cl-cffi-gtk][cl-cffi-gtk] です。主に GNU/Linux 向けに作られましたが、Gtk は macOS でも問題なく動き、今では Windows でも使えます。


- **フレームワークの実装言語**: C
- **移植性**: GNU/Linux と macOS、Windows でも可。

- **ウィジェットの選択肢**: 豊富。

- **GUI ビルダー**: あり: Glade。
- **その他の機能**: Web ブラウザ (WebKitGTK)

- **バインディングのドキュメント**: とても良いです: http://www.crategus.com/books/cl-gtk/gtk-tutorial.html
- **バインディングの安定性**: 安定。
- **バインディングの活動状況**: 活動量は少なめですが、開発は続いています。
- **ライセンス**: LGPL
- 例:
  - Glade で作られた [Atmosphere Calculator](https://github.com/ralph-schleicher/atmosphere-calculator)。
- 追加の documentation と例:
  - [Learn Common Lisp by Example: GTK GUI with SBCL](https://dev.to/goober99/learn-common-lisp-by-example-gtk-gui-with-sbcl-5e5c)


### IUP (lispnik/IUP)

[IUP][iup-tecgraf] は、ブラジルのリオデジャネイロ・カトリック大学で活発に開発されているクロスプラットフォーム GUI ツールキットです。**ネイティブコントロール** を使い、Windows では Windows API、GNU/Linux では Gtk3 を使います。執筆時点では Cocoa 版も開発中で、iOS、Android、WASM 版もあります。IUP の特徴は **API が小さい** ことです。

[Lisp バインディング] は [lispnik/iup](https://github.com/lispnik/iup/) です。C ソースから自動生成されているため、よくできています。新しい IUP バージョンに追従する手間が少なく、必要な手順も文書化されています。これにより bus factor の面でも安心です。

IUP は Tk と Gtk/Qt の中間にある、非常に良い選択肢です。

- **フレームワークの実装言語**: C（公式 API は Lua と LED にもあります）
- **移植性**: Windows と Linux、Cocoa、iOS、Android、WASM 版も作業中です。

- **ウィジェットの選択肢**: 中程度。Web ブラウザウィンドウを含みます（Linux では WebkitGTK、Windows では IE の WebBrowser）。

- **GUI ビルダー**: あり: [IupVisualLED](http://webserver2.tecgraf.puc-rio.br/iup/en/iupvisualled.html)

- **その他の機能**: OpenGL、Web ブラウザ（GNU/Linux では WebKitGTK）、作図、Scintilla テキストエディタ

- **バインディングのドキュメント**: 例と README は良いですが、それ以外は少なめです。
- **バインディングの安定性**: alpha（ただし完全に生成されていて、問題なく動きます）。
- **バインディングの活動状況**: 少なめですが安定していて、新しい IUP バージョンにも反応します。
- **ライセンス**: IUP もバインディングも MIT license です。


**ウィジェット一覧**

```
Radio, Tabs, FlatTabs, ScrollBox, DetachBox,
Button, FlatButton, DropButton, Calendar, Canvas, Colorbar, ColorBrowser, DatePick, Dial, Gauge, Label, FlatLabel,
FlatSeparator, Link, List, FlatList, ProgressBar, Spin, Text, Toggle, Tree, Val,
listDialog, Alarm, Color, Message, Font, Scintilla, file-dialog…
Cells, Matrix, MatrixEx, MatrixList,
GLCanvas, Plot, MglPlot, OleControl, WebBrowser (WebKit/Gtk+)…
drag-and-drop
WebBrowser
```

<!-- editor's note: found missing a list view with columns. -->

![](assets/iup-demo.png)


### Nuklear (Bodge-Nuklear)

[Nuklear][nuklear] は小さな [immediate-mode](https://en.wikipedia.org/wiki/Immediate_mode_GUI) GUI ツールキットです。

> [Nuklear] は、ANSI C で書かれ、パブリックドメインでライセンスされた、最小限の状態しか持たないイミディエイトモードのグラフィカルユーザインターフェイスツールキットです。アプリケーションに組み込めるシンプルなユーザインターフェイスとして設計されており、依存関係も、デフォルトのレンダリングバックエンドも、OS のウィンドウ/入力処理も持ちません。代わりに、入力用のシンプルな入力状態と、出力としてプリミティブな図形を記述する描画コマンドを備えた、高度にモジュール化されたライブラリベースの方式を提供します。つまり、数多くのプラットフォームやレンダリングバックエンドを抽象化しようとする階層化されたライブラリを提供するのではなく、実際の UI だけに集中しています。

Lisp バインディングは [Bodge-Nuklear][bodge-nuklear] で、上位の付属として [bodge-ui](https://github.com/borodust/bodge-ui) と [bodge-ui-window](https://github.com/borodust/bodge-ui-window) があります。

従来の UI フレームワークと違い、Nuklear では描画ループや入力管理を開発者が引き継げます。設定は少し増えますが、ゲームや、新しいコントロールを作りたいアプリケーションには特に向いています。


- **フレームワークの実装言語**: ANSI C、single-header ライブラリ。
- **移植性**: C が動くところならどこでも。Nuklear にはプラットフォーム固有コードは含まれていません。OS やウィンドウの直接処理も Nuklear では行われません。その代わり、*すべての入力状態をプラットフォーム固有コードが提供する必要があります*。

- **ウィジェットの選択肢**: 少ない。

- **GUI ビルダー**: なし。

- **その他の機能**: skin と customization が完全に可能。

- **バインディングの安定性**: 安定。
- **バインディングの活動状況**: 活発。
- **ライセンス**: MIT か Public Domain（unlicense）。
- アプリケーションの例:
  - [Trivial-gamekit](https://github.com/borodust/trivial-gamekit)
  - [Obvius](https://github.com/thicksteadTHpp/Obvius/) - a resurrected image processing library.
  - [Notalone](https://github.com/borodust/notalone) - an autumn 2017 Lisp Game Jam entry.

**ウィジェット一覧**

抜粋です。

```
buttons, progressbar, image selector, (collapsable) tree, list, grid, range, slider, color picker,
date-picker
```

![](assets/gui/nuklear.png)

[​]{#getting-started}

## 使ってみる

### Tk

Ltk はすぐに使えて、つかみやすいものです。

~~~lisp
(ql:quickload "ltk")
(in-package :ltk-user)
~~~


**ウィジェットの作り方**

ウィジェットはすべて、通常の `make-instance` とウィジェット名で作ります。

~~~lisp
(make-instance 'button)
(make-instance 'treeview)
~~~

これにより、デフォルトのシンボル補完で Ltk をたどっていけます。

**メインループの始め方**

たいていのバインディングと同じく、GUI 関連のコードはメインループを扱うマクロ（ここでは `with-ltk`）の中で始める必要があります。

~~~lisp
(with-ltk ()
  (let ((frame (make-instance 'frame)))
    …))
~~~

**ウィジェットの表示の仕方**

ウィジェットを作ったら、レイアウトに配置する必要があります。Tk にはいくつか配置方法がありますが、今使うべきなのは `grid` です。`grid` はウィジェット、列、行、いくつかの optional パラメータを引数に取る関数です。

通常の Lisp コードと同じく、関数のシグネチャはエディタに出ます。これも Ltk をたどりやすくしてくれます。

ボタンを表示する例です。

~~~lisp
(with-ltk ()
  (let ((button (make-instance 'button :text "hello")))
    (grid button 0 0)))
~~~

やることはそれだけです。


[​]{#event-}

#### イベントに反応する

多くのウィジェットには `:command` 引数があり、ウィジェットのイベントが発生したときに実行される lambda を受け取ります。ボタンの場合はクリック時です。

~~~lisp
(make-instance 'button
  :text "Hello"
  :command (lambda ()
             (format t "clicked")))
~~~


#### 対話的開発

`(start-wish)` で Tk プロセスを background で起動すると、ウィジェットを作って grid に置く作業を対話的に行えます。

詳しくは [ドキュメント](http://www.peter-herth.de/ltk/ltkdoc/node8.html) を見てください。

終わったら `(exit-wish)` を呼びます。


#### Nodgui

Nodgui のデモを試すには次のようにします。

~~~lisp
(ql:quickload "nodgui")
(nodgui.demo:demo)
~~~

見た目のよいテーマでデモを読み込むなら、次のようにします。

~~~lisp
(nodgui.demo:demo :theme "yaru")
~~~

or

~~~lisp
(setf nodgui:*default-theme* "yaru")
(nodgui.demo:demo)
~~~

#### Nodgui UI theme

nodgui に付属する "yaru" テーマを使うには、単純に次のようにします。

~~~lisp
(with-nodgui ()
  (use-theme "yaru")
  …)
~~~

or

~~~lisp
(with-nodgui (:theme "yaru")
  …)
~~~

or

~~~lisp
(setf nodgui:*default-theme* "yaru")
(with-nodgui ()
  …)
~~~

別の tcl テーマをインストールして読み込むこともできます。たとえば [Forest ttk テーマ](https://github.com/rdbende/Forest-ttk-theme) や [ttkthemes](https://github.com/TkinterEP/ttkthemes/) を clone します。project ディレクトリは次のようになります。

```
yourgui.asd
yourgui.lisp
ttkthemes/
```

`ttkthemes/` の中では `png/` ディレクトリにテーマがあり、それ以外は現時点で未対応です。

    /ttkthemes/ttkthemes/png/arc/arc.tcl

nodgui で .tcl ファイルを読み込み、このテーマを使うよう指示します。

~~~lisp
(with-nodgui ()
   (eval-tcl-file "/ttkthemes/ttkthemes/png/arc/arc.tcl")
   (use-theme "arc")
   … code here …)
~~~

これで終わりです。アプリケーションは新しい、そこそこ見栄えのよい GUI テーマを使うようになります。

### Qt4

~~~lisp
(ql:quickload '(:qtools :qtcore :qtgui))
~~~

~~~lisp
(defpackage #:qtools-test
  (:use #:cl+qt)
  (:export #:main))
(in-package :qtools-test)
(in-readtable :qtools)
~~~

残りを入れるメインウィジェットを作ります。

~~~lisp
(define-widget main-window (QWidget)
  ())
~~~

このメインウィジェットの中に入力フィールドとボタンを作ります。

~~~lisp
(define-subwidget (main-window name) (q+:make-qlineedit main-window)
  (setf (q+:placeholder-text name) "Your name please."))
~~~

~~~lisp
(define-subwidget (main-window go-button) (q+:make-qpushbutton "Go!" main-window))
~~~

横に並べます。

~~~lisp
(define-subwidget (main-window layout) (q+:make-qhboxlayout main-window)
  (q+:add-widget layout name)
  (q+:add-widget layout go-button))
~~~

そして表示します。

~~~lisp
(with-main-window
  (window 'main-window))
~~~

![](assets/gui/qtools-intro.png)

これで形はできましたが、まだ click イベントには反応していません。

[​]{#event--1}

#### イベントに反応する

Qt でイベントに反応するにはシグナルとスロットを使います。**スロット** はシグナルを受け取る、あるいはシグナルに "接続する" 関数で、**シグナル** はイベントの運び手です。

ウィジェットはすでに自前のシグナルを送っています。たとえばボタンは "pressed" イベントを送ります。そのため、たいていはそれに接続するだけで済みます。

ただし、必要なら独自のシグナル群を作ることもできます。

[​]{#event}

##### 組み込みイベント

`go-button` を `pressed` と `return-pressed` イベントに接続し、メッセージボックスを表示します。

- これを `define-slot` 関数の中で行い、
- その中でイベントへの接続を確立し、
- さらにメッセージボックスを作ります。`name` 入力フィールドのテキストは `(q+:text name)` で取得します。

~~~lisp
(define-slot (main-window go-button) ()
  (declare (connected go-button (pressed)))
  (declare (connected name (return-pressed)))
  (q+:qmessagebox-information main-window
                              "Greetings"  ;; title
                              (format NIL "Good day to you, ~a!" (q+:text name))))
~~~

これで完成です。次のように実行します。

~~~lisp
(with-main-window (window 'main-window))
~~~

[​]{#event-1}

##### 独自イベント

上と同じ機能を実装しますが、説明のためにボタンクリック時に発火する `name-set` という独自シグナルを作ります。

まずシグナルを定義します。これは `main-window` の中で行い、型は `string` です。

~~~lisp
(define-signal (main-window name-set) (string))
~~~

最初のスロットを作ってボタンを `pressed` と `return-pressed` イベントに反応させます。ただしここでは上のようにメッセージボックスを作るのではなく、入力フィールドの値を載せた `name-set` シグナルを送ります。

~~~lisp
(define-slot (main-window go-button) ()
  (declare (connected go-button (pressed)))
  (declare (connected name (return-pressed)))
  (signal! main-window (name-set string) (q+:text name)))
~~~

ここまでのところ、`name-set` に反応するものはありません。そこで、これに接続してメッセージを表示する **2 つ目の slot** を作ります。ここでもパラメータの型を明示します。

~~~lisp
(define-slot (main-window name-set) ((new-name string))
  (declare (connected main-window (name-set string)))
  (q+:qmessagebox-information main-window "Greetings"
        (format NIL "Good day to you, ~a!" new-name)))
~~~

そして実行します。

~~~lisp
(with-main-window (window 'main-window))
~~~

[​]{#building-and-deployment}

#### ビルドと配布

バイナリをビルドし、必要な共有ライブラリすべてと一緒にまとめて配布できます。

[https://github.com/Shinmera/qtools#deployment](https://github.com/Shinmera/qtools#deployment) を読んでください。

3 つの OS 向けに自己完結型のバイナリをビルドする [この Travis CI スクリプト](https://github.com/phoe-trash/furcadia-post-splitter/blob/master/.travis.yml) も参考になるでしょう。


### Gtk3

[ドキュメント](http://www.crategus.com/books/cl-gtk/gtk-tutorial.html)は、初心者向けも含めて非常によくできています。

quickload するライブラリは `cl-cffi-gtk` です。これは数多くのライブラリから成り、自分のパッケージで `:use` する必要があります。

~~~lisp
(ql:quickload "cl-cffi-gtk")

(defpackage :gtk-tutorial
  (:use :gtk :gdk :gdk-pixbuf :gobject
   :glib :gio :pango :cairo :common-lisp))

(in-package :gtk-tutorial)
~~~

**メインループの実行の仕方**

ほかのライブラリと同じく、すべてはメインループのラッパー（ここでは `with-main-loop`）の中で起こります。

**ウィンドウの作り方**

`(make-instance 'gtk-window :type :toplevel :title "hello" ...)`。

**ウィジェットの作り方**

ウィジェットにはすべて対応するクラスがあります。`make-instance 'widget-class` で作れますが、できればコンストラクタを使うのが望ましいです。

コンストラクタは "new" で終わります（または "new" を含みます）。

```lisp
(gtk-label-new)
(gtk-button-new-with-label "Label")
```

**layout の作り方**

~~~lisp
(let ((box (make-instance 'gtk-box :orientation :horizontal
                                   :spacing 6))) ...)
~~~

続いてウィジェットをボックスに詰め込みます。

~~~lisp
(gtk-box-pack-start box mybutton-1)
~~~

そしてボックスをウィンドウに追加します。

~~~lisp
(gtk-container-add window box)
~~~

最後にすべてを表示します。

~~~lisp
(gtk-widget-show-all window)
~~~

[​]{#reacting-to-events}

#### イベントに反応する

`g-signal-connect` ＋対象のウィジェット＋イベント名（文字列）＋ウィジェットを引数に取る lambda、という形で使います。

~~~lisp
(g-signal-connect window "destroy"
  (lambda (widget)
    (declare (ignore widget))
    (leave-gtk-main)))
~~~

あるいは、もうひとつ例を挙げます。

~~~lisp
(g-signal-connect button "clicked"
  (lambda (widget)
    (declare (ignore widget))
    (format t "Button was pressed.~%")))
~~~

[​]{#full-example}

#### 完全な例

~~~lisp
(defun hello-world ()
  ;; in the docs, this is example-upgraded-hello-world-2.
  (within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Hello Buttons"
                                 :default-width 250
                                 :default-height 75
                                 :border-width 12))
          (box (make-instance 'gtk-box
                              :orientation :horizontal
                              :spacing 6)))
      (g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      (let ((button (gtk-button-new-with-label "Button 1")))
        (g-signal-connect button "clicked"
                          (lambda (widget)
                            (declare (ignore widget))
                            (format t "Button 1 was pressed.~%")))
        (gtk-box-pack-start box button))
      (let ((button (gtk-button-new-with-label "Button 2")))
        (g-signal-connect button "clicked"
                        (lambda (widget)
                          (declare (ignore widget))
                          (format t "Button 2 was pressed.~%")))
        (gtk-box-pack-start box button))
      (gtk-container-add window box)
      (gtk-widget-show-all window))))
~~~

![](assets/gui/gtk3-hello-buttons.png)


### IUP

インストール手順は上流のドキュメントで確認してください。GNU/Linux ではシステム依存パッケージが 1 つ必要になることがあり、Windows では環境変数を変更する必要があるかもしれません。

最後に、次を実行します。

~~~lisp
(ql:quickload "iup")
~~~

IUP は `:use` しません（そもそも一般的によくない習慣です）。

~~~lisp
(defpackage :test-iup
  (:use :cl))
(in-package :test-iup)
~~~

次のスニペットは、テキストラベルを表示するダイアログフレームを作ります。

~~~lisp
(defun hello ()
  (iup:with-iup ()
    (let* ((label (iup:label
                     :title
                     (format nil "Hello, World!~%IUP ~A~%~A ~A"
                       (iup:version)
                       (lisp-implementation-type)
                       (lisp-implementation-version))))
           (dialog (iup:dialog label :title "Hello, World!")))
      (iup:show dialog)
      (iup:main-loop))))
(hello)
~~~

SBCL についての重要な注意です。現時点ではゼロ除算エラーを捕捉する必要があります（[この issue](https://github.com/lispnik/iup/issues/30) の進展を見てください）。そのため、スニペットは次のように実行します。

~~~lisp
(defun run-gui-function ()
  #-sbcl (gui-function)
  #+sbcl
  (sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (gui-function)))
~~~


**メインループの起動方法**

ここまで見てきたバインディングと同様に、ウィジェットは `with-iup` マクロの中で表示し、`iup:main-loop` を呼びます。

**ウィジェットの作り方**

コンストラクタ関数はウィジェット名そのものです。`iup:label`、`iup:dialog` などです。

**ウィジェットの表示方法**

必ず "show" してください。`(iup:show dialog)` です。

ウィジェットは `frame` にまとめられ、縦 (`vbox`) や横 (`hbox`) に並べられます（下の例を参照）。

ウィンドウのリサイズ時にウィジェットを伸縮させたい場合は `:expand :yes` を使います（または `:horizontal`、`:vertical`）。

`:alignement` property も使えます。

**widget の属性の取得と設定**

属性の値を得るには `(iup:attribute widget attribute)` を使い、設定するときはそれに `setf` します。


[​]{#event--2}

#### イベントに反応する

ほとんどのウィジェットは `:action` パラメータを取り、1 つのパラメータ（ハンドル）を持つ lambda を受け取ります。

~~~lisp
(iup:button :title "Test &1"
            :expand :yes
            :tip "Callback inline at control creation"
            :action (lambda (handle)
                      (iup:message "title" "button1's action callback")
                      iup:+default+))
~~~

以下ではラベルを作り、その下にボタンを置きます。ボタンをクリックするとメッセージ dialog を表示します。

~~~lisp
(defun click-button ()
  (iup:with-iup ()
    (let* ((label (iup:label :title
                      (format nil "Hello, World!~%IUP ~A~%~A ~A"
                          (iup:version)
                          (lisp-implementation-type)
                          (lisp-implementation-version))))
           (button (iup:button :title "Click me"
                               :expand :yes
                               :tip "yes, click me"
                               :action
                               (lambda (handle)
                                 (declare (ignorable handle))
                                 (iup:message "title"
                                              "button clicked")
                                 iup:+default+)))
           (vbox
            (iup:vbox (list label button)
                      :gap "10"
                      :margin "10x10"
                      :alignment :acenter))
           (dialog (iup:dialog vbox :title "Hello, World!")))
      (iup:show dialog)
      (iup:main-loop))))

#+sbcl
(sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (click-button))
~~~

クリック回数のカウンターを作る似た例を示します。ラベルとその `title` に回数を保持します。`title` は整数です。

~~~lisp
(defun counter ()
  (iup:with-iup ()
    (let* ((counter (iup:label :title 0))
           (label (iup:label :title
                     (format nil "The button was clicked ~a time(s)."
                             (iup:attribute counter :title))))
           (button (iup:button :title "Click me"
                               :expand :yes
                               :tip "yes, click me"
                               :action (lambda (handle)
                                         (declare (ignorable handle))
                                         (setf (iup:attribute counter :title)
                                               (1+ (iup:attribute counter :title 'number)))
                                         (setf (iup:attribute label :title)
                                               (format nil "The button was clicked ~a times."
                                                       (iup:attribute counter :title)))
                                         iup:+default+)))
           (vbox
            (iup:vbox (list label button)
                      :gap "10"
                      :margin "10x10"
                      :alignment :acenter))
           (dialog (iup:dialog vbox :title "Counter")))
      (iup:show dialog)
      (iup:main-loop))))

(defun run-counter ()
  #-sbcl
  (counter)
  #+sbcl
  (sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (counter)))
~~~

[​]{#list-widget-}

#### リストウィジェットの例

以下では、単一選択と複数選択のリストウィジェットを 3 つ作り、既定値（事前選択行）を設定して、横に並べます。

~~~lisp
(defun list-test ()
  (iup:with-iup ()
    (let*  ((list-1 (iup:list :tip "List 1"  ;; tooltip
                              ;; multiple selection
                              :multiple :yes
                              :expand :yes))
            (list-2 (iup:list :value 2   ;; default index of the selected row
                              :tip "List 2" :expand :yes))
            (list-3 (iup:list :value 9 :tip "List 3" :expand :yes))
            (frame (iup:frame
                    (iup:hbox
                     (progn
                       ;; populate the lists: display integers.
                       (loop for i from 1 upto 10
                          do (setf (iup:attribute list-1 i)
                                   (format nil "~A" i))
                          do (setf (iup:attribute list-2 i)
                                   (format nil "~A" (+ i 10)))
                          do (setf (iup:attribute list-3 i)
                                   (format nil "~A" (+ i 50))))
                       ;; hbox wants a list of widgets.
                       (list list-1 list-2 list-3)))
                    :title "IUP List"))
            (dialog (iup:dialog frame :menu "menu" :title "List example")))

      (iup:map dialog)
      (iup:show dialog)
      (iup:main-loop))))

(defun run-list-test ()
  #-sbcl (hello)
  #+sbcl
  (sb-int:with-float-traps-masked
      (:divide-by-zero :invalid)
    (list-test)))
~~~

### Nuklear

**注意**: 執筆時点で著者の言葉によれば、bodge-ui はまだ開発初期段階で、一般利用には未対応です。修正が必要な癖がいくつかあり、API に変更が入る可能性があります。

`bodge-ui` は Quicklisp 本体ではなく、独自の Quicklisp distribution にあります。まずそれをインストールします。

~~~lisp
(ql-dist:install-dist "http://bodge.borodust.org/dist/org.borodust.bodge.txt" :replace t :prompt nil)
~~~

OpenGL 2 renderer を有効にしたい場合だけ、この行のコメントを外して評価します。

~~~lisp
;; (cl:pushnew :bodge-gl2 cl:*features*)
~~~

`bodge-ui-window` を quickload します。

~~~lisp
(ql:quickload "bodge-ui-window")
~~~

組み込み例を実行できます。

~~~lisp
(ql:quickload "bodge-ui-window/examples")
(bodge-ui-window.example.basic:run)
~~~

では、簡単なアプリケーションを書くためのパッケージを定義します。

~~~lisp
(cl:defpackage :bodge-ui-window-test
  (:use :cl :bodge-ui :bodge-host))
(in-package :bodge-ui-window-test)
~~~

~~~lisp
(defpanel (main-panel
           (:title "Bodge UI へようこそ")
           (:origin 200 50)
           (:width 400) (:height 400)
           (:options :movable :resizable
                     :minimizable :scrollable
                     :closable))
    (label :text "入れ子の widget:")
  (horizontal-layout
   (radio-group
    (radio :label "選択肢 1")
    (radio :label "選択肢 2" :activated t))
   (vertical-layout
    (check-box :label "チェック 1" :width 100)
    (check-box :label "チェック 2"))
   (vertical-layout
    (label :text "左寄せ" :align :left)
    (label :text "中央" :align :centered)
    (label :text "右寄せ" :align :right)))
  (label :text "幅に応じて伸縮:")
  (horizontal-layout
   (button :label "可変")
   (button :label "最小幅" :width 80)
   (button :label "固定幅" :expandable nil :width 100))
  (label :text "幅に応じて伸縮:")
  (horizontal-layout
   (button :label "1.0" :expand-ratio 1.0)
   (button :label "0.75" :expand-ratio 0.75)
   (button :label "0.5" :expand-ratio 0.5))
  (label :text "残り:")
  (button :label "最上位ボタン"))

(defparameter *window-width* 800)
(defparameter *window-height* 600)

(defclass main-window (bodge-ui-window:ui-window) ()
  (:default-initargs
   :title "Bodge UI Window の例"
   :width *window-width*
   :height *window-height*
   :panels '(main-panel)
   :floating t
   :opengl-version #+bodge-gl2 '(2 1)
                   #+bodge-gl2 '(3 3)))


(defun run ()
  (bodge-host:open-window (make-instance 'main-window)))
~~~

そして実行します。

~~~lisp
(run)
~~~

![](assets/gui/nuklear-test.png)

イベントに反応するには、次のシグナルを使います。

```
:on-click
:on-hover
:on-leave
:on-change
:on-mouse-press
:on-mouse-release
```

これらは引数 1 つ、つまりパネルを取る関数を受け取ります。ただし注意してください。ウィジェットがその状態にあるあいだは描画 cycle ごとに呼ばれるため、かなり頻繁になることがあります。


#### 対話的開発

REPL で例を動かしただけでは、何が面白いかは見えません。コードを Lisp ファイルに入れて実行し、ウィンドウを出してください。そうすればパネルウィジェットやレイアウトを変えたとき、その変更がアプリケーションの実行中に即座に反映されるのが分かります。


## まとめ

楽しんでください。体験談やアプリケーションの共有も遠慮なくどうぞ。


[tk]: https://www.tcl.tk
[ltk]: http://www.peter-herth.de/ltk/ltkdoc/
[nodgui]: https://codeberg.org/cage/nodgui
[qt4]: https://doc.qt.io/archives/qt-4.8/index.html
[gtk]: https://www.gtk.org/
[qtools]: https://github.com/Shinmera/qtools
[cl-cffi-gtk]: https://github.com/Ferada/cl-cffi-gtk/
[iup-tecgraf]: http://webserver2.tecgraf.puc-rio.br/iup/
[iup-lisp]: https://github.com/lispnik/iup/
[gnome]: https://www.gnome.org/
[nuklear]: https://github.com/Immediate-Mode-UI/Nuklear
[bodge-nuklear]: https://github.com/borodust/bodge-nuklear
[capi]: http://www.lispworks.com/products/capi.html
[ceramic]: http://ceramic.github.io/
 
#  Web 開発 {#chapter-web}
 


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


[​]{#server-}

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


[​]{#get--post-parameter-}

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


![](assets/clack-errors.png)
   

## Weblocks - "JavaScript 問題" を解く ©

[Weblocks][weblocks] は、ウィジェットベースでサーバーベースのフレームワークで、組み込みの ajax 更新機構を持っています。JavaScript を書かずに、また JavaScript にトランスパイルされる Lisp コードを書かずに、動的な web アプリケーションを書けます。

![](assets/weblocks-quickstart-check-task.gif)

Weblocks は、Slava Akhmechet、Stephen Compall、Leslie Polzer によって開発された古いフレームワークです。しばらく落ち着いたあと、Alexander Artemenko による非常に活発な更新、リファクタリング、書き直しが進んでいます。

もともとは継続（continuation）ベースでした（現在は除去されています）。そのため、Smalltalk の [Seaside](https://en.wikipedia.org/wiki/Seaside_(software)) の Lisp 版とも言えます。Haskell の Haste、OCaml の Eliom、Elixir の Phoenix LiveView などとも比較できます。

[Ultralisp](http://ultralisp.org/) のウェブサイトは、CL コミュニティで知られる本番運用中の Weblocks サイトの例です。

 

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

詳しくは [databases の節](#chapter-databases) を見てください。Mito ORM は SQLite3、PostgreSQL、MySQL をサポートし、マイグレーションや DB スキーマのバージョン管理などもあります。

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

[​]{#application-}

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

[scripting#for-web-apps](#for-web-apps) のレシピを参照してください。


### Travis CI や GitLab CI で継続的デリバリーを行う

[testing#continuous-integration](#continuous-integration) の節を見てください。


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
  - このレシピの [scripting#for-web-apps](#for-web-apps) で、Web サーバースレッドをどう生かしておくかを見てください。
  - 実行中の Lisp イメージに接続したいがアプリの REPL には入れない、という場合は [Swank サーバー](#remote-debugging) を使います。
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
 
#  ウェブスクレイピング {#chapter-web-scraping}
 

Common Lisp でウェブスクレイピングを行うための道具立てはかなり揃っており、使っていて快適です。この短いチュートリアルでは、HTTP リクエストを行い、HTML を解析し、内容を抽出し、非同期リクエストを行う方法を見ます。

ここでの単純な課題は、CL Cookbook のインデックスページにあるリンクの一覧を抽出し、それらに到達できるか確認することです。

次のライブラリを使います。

- [Dexador](https://github.com/fukamachi/dexador) - HTTP クライアント
  (由緒ある Drakma を置き換えることを目指しています)。
- [Plump](https://shinmera.github.io/plump/) - 壊れた HTML にも対応するマークアップパーサー。
- [Lquery](https://shinmera.github.io/lquery/) - Plump の結果から内容を抽出するための DOM 操作
  ライブラリ。
- [lparallel](https://lparallel.org/pmap-family/) - 並列プログラミング用ライブラリ (詳しくは[プロセスの節](#chapter-process)を読んでください)。

始める前に、Quicklisp でこれらのライブラリをインストールしましょう。

~~~lisp
(ql:quickload '("dexador" "plump" "lquery" "lparallel"))
~~~

## HTTP リクエスト

まずは簡単なことからです。Dexador をインストールします。そして `get` 関数を使います。

~~~lisp
(defvar *url* "https://lispcookbook.github.io/cl-cookbook/")
(defvar *request* (dex:get *url*))
~~~

これは複数の値を返します。ページの内容全体、戻りコード
(200)、レスポンスヘッダ、URI、ストリームです。

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

思い出してください。Slime ではオブジェクトを右クリックして inspect できます。

## CSS セレクタで解析し、内容を抽出する

HTML を解析して内容を抽出するために `lquery` を使います。

- [https://shinmera.github.io/lquery/](https://shinmera.github.io/lquery/)

まず HTML を内部データ構造へ解析する必要があります。
`(lquery:$ (initialize <html>))` を使います。

~~~lisp
(defvar *parsed-content* (lquery:$ (initialize *request*)))
;; => #<PLUMP-DOM:ROOT {1009EE5FE3}>
~~~

lquery は内部で [Plump](https://shinmera.github.io/plump/) を使います。

次に CSS セレクタでリンクを抽出します。

__Note__: 関心のある要素の CSS セレクタを知るには、ブラウザでその要素を右クリックし、"Inspect element" を選びます。するとブラウザの開発者ツールのインスペクタが開き、ページの構造を調べられます。

抽出したいリンクは、`id` が "content" のページ内にあり、通常のリスト要素 (`li`) に含まれています。

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

うまく動きました。ここでは plump の要素のベクトルが得られます。

これらの要素が何であるかを簡単に確認したいところです。HTML 全体を見るには、lquery の行を `(serialize)` で終えます。

~~~lisp
(lquery:$  *parsed-content* "#content li" (serialize))
#("<li><a href=\"license.html\">License</a></li>"
  "<li><a href=\"getting-started.html\">Getting started</a></li>"
  "<li><a href=\"editor-support.html\">Editor support</a></li>"
  […]
~~~

また、その*テキスト*としての内容（HTML 内で利用者に見えるテキスト）を見るには、代わりに `(text)` を使えます。

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

*Note*: `attr` の後に `(serialize)` を使うとエラーになります。

これでページのリンクの一覧（正確にはベクトル）が得られました。次に、それらに到達できるかを確認して検証する非同期プログラムを書きます。

外部リソース:

- [CSS selectors](https://developer.mozilla.org/en-US/docs/Glossary/CSS_Selector)

## 非同期リクエスト

この例では、上で得た URL の一覧を取り、それらに到達できるか確認します。これは非同期で行いたいのですが、利点を見るために、まず同期的に実行します。

まずメールアドレスを除外するために少しフィルタリングする必要があります（CSS セレクタでできたかもしれません）。

URL のベクトルを変数に入れます。

~~~lisp
(defvar *urls* (lquery:$  *parsed-content* "#content li a" (attr :href)))
~~~

"mailto:" で始まる要素を削除します（[文字列](#chapter-strings)のページを少し見ると助けになります）。

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

実際には、任意のシーケンス（ベクトルを含む）に対して動く `remove-if` を書く前に、結果が実際に `nil` または `t` になることを確認するため、`(map 'vector …)` で試しました。

余談ですが、Quicklisp で利用できる "str" ライブラリには便利な `starts-with-p` 関数があります。したがって次のようにも書けます。

~~~lisp
(map 'vector (lambda (it)
                (str:starts-with-p "mailto:" it))
             *urls*)
~~~

ついでに、ウェブスクレイピングに関係ない内容をあまり書きすぎないよう、"http" で始まるリンクだけを対象にします。

~~~lisp
(remove-if-not (lambda (it)
                 (string= it "http" :start1 0 :end1 (length "http")))
               *)
~~~

よし、この結果を別の変数に入れます。

~~~lisp
(defvar *filtered-urls* *)
~~~

ここから本題です。各 URL についてリクエストし、戻りコードが 200 であることを確認します。特定のエラーは無視しなければなりません。実際、リクエストはタイムアウトすることも、リダイレクトされることも（これは望みません）、エラーコードを返すこともあります。

実際に近い条件にするため、タイムアウトするリンクを一覧に追加します。

~~~lisp
(setf (aref *filtered-urls* 0) "http://lisp.org")  ;; :/
~~~

エラーを無視し、その場合は `nil` を返す単純な方法を取ります。すべてうまくいけば、200 であるはずの戻りコードを返します。

冒頭で見たように、`dex:get` は戻りコードを含む多くの値を返します。ここでは `multiple-value-bind` で全てを受け取る代わりに、`nth-value` でこの値だけにアクセスします。また、エラーの場合に nil を返す `ignore-errors` を使います。`handler-case` を使って特定のエラー型を扱うこともできます（dexador のドキュメントの例を参照してください）。

(*ignore-errors には、エラーが起きたとき、それがどの要素から来たのかを返せないという注意点があります。それでもここでの目的は達成できます。*)


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

21 秒です。明らかにこの同期的なやり方は効率的ではありません。タイムアウトするリンクに 10 秒待っています。非同期版を書いて測定する時です。

`lparallel` をインストールし、[そのドキュメント](https://lparallel.org/)を見たところ、並列版の map である [pmap](https://lparallel.org/pmap-family/) が欲しいものに見えます。しかも変更は一語だけです。試してみましょう。

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

やりました。タイムアウトするリクエストを 1 つ 10 秒待つため、まだ 10 秒以上かかっています。しかしそれ以外では HTTP リクエストがすべて並列に進むため、ずっと高速です。

到達できない URL を取得し、それらを一覧から削除し、同期と非同期の場合の実行時間を測ってみましょうか。

行うことは、戻りコードだけを返す代わりに、それが有効かを確認して URL を返すことです。

~~~lisp
... (if (and status (= 200 status)) it) ...
(defvar *valid-urls* *)
~~~

いくつかの `nil` を含む URL のベクトルが得られます。実のところ、到達できない URL は 1 つだけだと思っていたのですが、もう 1 つ発見しました。あなたがこのチュートリアルを試す前に、修正を push できていることを願います。

では、それらは何でしょうか。ステータスコードは見ましたが URL は見ていません。すべての URL のベクトルと、有効なもののベクトルがあります。単純にそれらを集合として扱い、差分を計算します。これで問題のあるものがわかります。そのためにはベクトルをリストに変換する必要があります。

~~~lisp
(set-difference (coerce *filtered-urls* 'list)
                (coerce *valid-urls* 'list))
;; => ("http://lisp-lang.org/" "http://www.psg.com/~dlamkins/sl/cover.html")
~~~

見つかりました。

ちなみに、有効な URL の一覧を同期的に確認するには、私の環境では実時間で 8.280 秒かかり、非同期では 2.857 秒でした。

CL でのウェブスクレイピングを楽しんでください。


さらに役立つライブラリ:

- [VCR](https://github.com/tsikov/vcr) を使うと、繰り返し実行できるテストを設定したり、REPL での実験を少し高速化したりするための、記録・再生ユーティリティとして使えます。
- [cl-async](https://github.com/orthecreedence/cl-async)、
  [carrier](https://github.com/orthecreedence/carrier)、およびその他の
  ネットワーク、並列処理、並行処理のライブラリは
  [awesome-cl](https://github.com/CodyReichert/awesome-cl) の一覧、
  [Cliki](http://www.cliki.net/)、または
  [Quickdocs](https://quickdocs.org/-/search?q=web) で探せます。
 
#  WebSockets {#chapter-websockets}
 

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

[​]{#chat-server-logic--handler-}

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

[​]{#server-}

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


[​]{#html-chat-client}

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


![](assets/sockets-lisp-chat.gif)
   

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
# 付録: 貢献者

すべての貢献者と、ここに名前が表示されない pull request レビュー担当者の皆さんに感謝します。

Github 上の貢献者は次のとおりです。

<!-- list generated with -->
<!-- git shortlog -sn | cut -f 2 | sed s/^/"* "/g > commiters.md -->

* vindarel
* Paul Nathan
* nhabedi [^nhabedi]
* Fernando Borretti
* bill_clementson
* chuchana
* Ben Dudson
* Janghyeon
* YUE Daian
* Pierre Neidhardt
* Rommel MARTINEZ
* digikar99
* em7
* nicklevine
* Danny YUE
* wmannis
* Carl Gay
* Dmitry Petrov
* otjura
* Colin Woodbury
* may
* jgart
* skeptomai
* alx-a
* thegoofist
* Francis St-Amour
* Johan Widén
* emres
* jdcal
* Александар Симић
* Boutade
* Kevin Galligan
* airfoyle
* contrapunctus
* mvilleneuve
* Alex Ponomarev
* Alexander Artemenko
* Johan Sjölén
* Mariano Montone
* albertoriva
* Blue
* Daniel Keogh
* David Pflug
* David Sun
* Jason Legler
* Jiho Sung
* Kilian M. Haemmerle
* Matteo Landi
* Nico Simoski
* Nikolaos Chatzikonstantinou
* Nisar Ahmad
* Nisen
* Vityok
* ctoid
* ozten
* reflektoin
* Ahmad Edrisy
* Alberto Ferreira
* Amol Dosanjh
* Andrew
* Andrew Hill
* André A. Gomes
* André Alexandre Gomes
* Ankit Chandawala
* August Feng
* B1nj0y
* Bibek Panthi
* Bo Yao
* Brandon Hale
* Burhanuddin Baharuddin
* Coin Okay
* Cthulhux
* Daniel Uber
* Danny Yue
* Eric Timmons
* Giorgos Makris
* HiPhish
* Inc0n
* James Price
* John Zhang
* Justin
* Kevin Layer
* Kevin Mazzarella
* Kevin Secretan
* Konstantin Kotenko
* LdBeth
* Marcus Kammer
* Matthew Kennedy
* Michał "phoe" Herda
* Momozor
* NCM
* Noor
* Oliver Nikolas Winspear
* Paul Donnelly
* Pavel Kulyov
* Phi-Long Nguyen
* R Primus
* Ralf Doering
* Ramses
* Salad Tea
* Victor Anyakin
* alaskasquirrel
* blackeuler
* contrapunctus-1
* convert-repo
* dangerdyke
* eoli
* grobe0ba
* jhgalino
* jthing
* kilianmh
* mavis
* mwgkgk
* nepomucen
* paul-donnelly
* various-and-sundry
* Štěpán Němec

（このリストはコミット数の順に並んでいます）

元の SourceForge 版の貢献者は次のとおりです。

* Marco Antoniotti
* [Zach Beane](mailto:xach@xach.com)
* Pierpaolo Bernardi
* [Christopher Brown](mailto:skeptomai@mac.com)
* [Frederic Brunel](mailto:brunel@mail.dotcom.fr)
* [Jeff Caldwell](mailto:jdcal@yahoo.com)
* [Bill Clementson](mailto:bill_clementson@yahoo.com)
* Martin Cracauer
* [Gerald Doussot](mailto:gdoussot@yahoo.com)
* [Paul Foley](mailto:mycroft@actrix.gen.nz)
* Jörg-Cyril Höhle
* [Nick Levine](mailto:ndl@ravenbrook.com)
* [Austin King](mailto:shout@ozten.com)
* [Lieven Marchand](mailto:mal@wyrd.be)
* [Drew McDermott](mailto:drew.mcdermott@yale.edu)
* [Kalman Reti](mailto:reti@ai.mit.edu)
* [Alberto Riva](mailto:alb@chip.org)
* [Rudi Schlatte](mailto:rschlatte@ist.tu-graz.ac.at)
* [Emre Sevinç](mailto:emres@bilgi.edu.tr)
* Paul Tarvydas
* Kenny Tilton
* [Reini Urban](mailto:rurban@x-ray.at)
* [Matthieu Villeneuve](mailto:matthieu@matthieu-villeneuve.net)
* [Edi Weitz](mailto:edi@agharta.de)

最後に、このプロジェクトを実際に生み出すきっかけになった功績は、おそらく [comp.lang.lisp][cll] に [このメッセージ][msg] を投稿した Edi Weitz にあります。

[cll]: news:comp.lang.lisp
[msg]: http://groups.google.com/groups?selm=76be8851.0201222259.70ecbcb1%40posting.google.com

[^nhabedi]: nhabedi は Edmund Weitz です ;)
