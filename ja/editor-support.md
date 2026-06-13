---
title: エディタサポート
---

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

<!-- pdf-include-start
![](assets/plain-cl-slime-interaction.png)
   pdf-include-end -->

<!-- todo: PDF generation: lacks IMG images -->


### Emacs を IDE として使う

["Using Emacs as an IDE"](emacs-ide.html) を参照してください。


## Vim & Neovim

[Slimv](https://github.com/kovisoft/slimv) は、Vim 内で Common Lisp を扱うための本格的な環境です。

[Vlime](https://github.com/vlime/vlime) は Vim（および Neovim）向けの Common Lisp 開発環境で、Emacs の SLIME や Vim の SLIMV に似ています。

<img src="assets/slimv.jpg"
     style="width: 800px" alt="The Slimv plugin with an open REPL"/>

<!-- pdf-include-start
![](assets/slimv.jpg)
   pdf-include-end -->

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

<!-- pdf-include-start
![](assets/atom-slime.png)
   pdf-include-end -->

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

<!-- pdf-include-start
![](assets/olive-repl.png)
   pdf-include-end -->

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

<!-- pdf-include-start
![](assets/commonlisp-vscode-alive.png)
   pdf-include-end -->

### VSCode で Alive を使う

[Using VSCode with Alive](vscode-alive.html) を参照してください。

### commonlisp-vscode

[commonlisp-vscode extension](https://marketplace.visualstudio.com/items?itemName=ailisp.commonlisp-vscode) は [cl-lsp](https://github.com/ailisp/cl-lsp) 言語サーバ経由で動作し、ほかのエディタで動く LSP クライアントを書くこともできます。[Roswell](https://roswell.github.io/Home.html) に大きく依存しています。現在サポートしている機能は次のとおりです。

- REPL の実行
- コードの評価
- 自動インデント
- コード補完
- 定義へ移動
- ホバー時のドキュメント表示

<img src="assets/commonlisp-vscode.png" style="width: 800px" alt="The VSCode extension with a Lisp REPL, code completion and a mini-map."/>


<!-- pdf-include-start
![](assets/commonlisp-vscode.png)
   pdf-include-end -->


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

<!-- pdf-include-start
![](assets/jetbrains-slt.png)
   pdf-include-end -->


## Eclipse

[Dandelion](https://github.com/Ragnaroek/dandelion) は Eclipse IDE 用のプラグインです。

Windows、Mac、Linux で利用でき、SBCL と CLISP の組み込みサポート、ほかの環境へ接続する機能、restart 付きの対話的デバッガ、マクロ展開、括弧対応の表示などを備えています。

<img src="assets/dandelion.png" style="width: 800px" alt="Dandelion, a simple Common Lisp plugin for Eclipse"/>

<!-- pdf-include-start
![](assets/dandelion.png)
   pdf-include-end -->

## Lem

[Lem](https://github.com/lem-project/lem/) は汎用エディタです。Common Lisp で作られており、Common Lisp で土台から対話的に拡張でき、Common Lisp 開発に合わせて作られています。インストールすればすぐ作業を始められます。組み込みの LSP クライアントにより、Python、Go、Rust、JS、Clojure、Kotlin、Scheme、HTML、CSS など、[多くのプログラミング言語を標準でサポート](https://lem-project.github.io/modes/)しています。ディレクトリモード、優れた vim レイヤー、対話的な Git モードなどもあります。

インターフェイスは Emacs と SLIME に似ています（ショートカットも同じです）。ncurses フロントエンド、Web ビュー、（非推奨の）SDL2 フロントエンドが付属しています。3 つのプラットフォーム向けにビルド済みバイナリをダウンロードできます。

<img src="assets/lem-sdl2.png"
     style="width: 800px" alt="Lem running in a SDL2 GUI."/>

<!-- pdf-include-start
![](assets/lem-sdl2.png)
   pdf-include-end -->

ターミナルですぐ REPL として起動できます。次のように実行します。

    lem --eval "(lem-lisp-mode:start-lisp-repl t)"

そのため、シェルエイリアスを用意したくなるでしょう。

    alias ilem='lem --eval "(lem-lisp-mode:start-lisp-repl t)"'

さらに次のものもあります。

* 🚀 [Lem on the cloud](https://www.youtube.com/watch?v=IMN7feOQOak)（動画プレゼンテーション）Rooms は Common Lisp で作られたテキストエディタ Lem を Cloud 上で動かし、複数ユーザーで利用できるようにする製品です。
  * Lem on the cloud は 2024 年 4 月時点の新しいものです。執筆時点ではプライベートベータです。

<img src="assets/lem1.png" style="width: 800px" title="Lem's REPL" alt="Lem running in the terminal with the Lisp REPL full screen, showing a completion window."/>

<!-- pdf-include-start
![](assets/lem1.png)
   pdf-include-end -->


## Sublime Text

[Sublime Text](http://www.sublimetext.com/3) は現在、Common Lisp を十分にサポートしています。

まず "SublimeREPL" パッケージをインストールし、それから Tools/SublimeREPL のオプションで CL 処理系を選びます。

次に [Slyblime](https://github.com/s-clerc/slyblime) が、実行中の Lisp イメージとやり取りする IDE 風の機能を提供します。これは SLY の実装で、同じバックエンド（SLYNK）を使います。スタックフレーム調査付きデバッガなど、高度な機能を提供します。

<img src="assets/editor-sublime.png"
     style="width: 800px" alt="A Lisp REPL in Sublime Text"/>

<!-- pdf-include-start
![](assets/editor-sublime.png)
   pdf-include-end -->


## LispWorks（プロプライエタリ）

[LispWorks](http://www.lispworks.com/) は、独自の統合開発環境（IDE）と、CAPI GUI ツールキットなどの独自機能を備えた Common Lisp 処理系です。これは**プロプライエタリ**で、**無料の制限版**を提供しています。

[LispWorks のレビューはこちら](lispworks.html)で読めます。

<img src="assets/lispworks/two-sided-view.png" style="width: 800px" title="The LispWorks IDE" alt="The LispWorks listener and the editor in the Mate desktop environment"/>

<!-- pdf-include-start
![](assets/lispworks/two-sided-view.png)
   pdf-include-end -->

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

<!-- pdf-include-start
![](assets/geany.png)
   pdf-include-end -->


## Notebooks

[common-lisp-jupyter](https://github.com/yitzchak/common-lisp-jupyter) は Jupyter notebook 用の Common Lisp カーネルです。

[Lisp で書かれたライブ Jupyter notebook をこちらで見る](https://nbviewer.jupyter.org/github/yitzchak/common-lisp-jupyter/blob/master/examples/about.ipynb)ことができます。インストールは簡単です（Roswell、repo2docker、Docker レシピ）。

<img src="assets/jupyterpreview.png"
     style="width: 800px" alt="A Jupyter notebook running a Common Lisp kernel, exploring the Lorentz system of differential equations, showing a colorful 3D plot with interactive controls (note: the code in the screenshot is actually not Lisp!)"/>

<!-- pdf-include-start
![](assets/jupyterpreview.png)
   pdf-include-end -->

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

<!-- epub-exclude-start -->

![](https://raw.githubusercontent.com/atgreen/icl/master/assets/terminal-demo.gif)

![](https://raw.githubusercontent.com/atgreen/icl/master/assets/browser-demo.gif)

<!-- epub-exclude-end -->

### cl-repl - readline ベースのシンプルな ipython 風 REPL

[cl-repl](https://github.com/lisp-maintainers/cl-repl) は ipython 風の REPL です。シンボル補完、magic コマンドとシェルコマンド、複数行編集、ファイル内でのコマンド編集、シンプルなデバッガをサポートします。

バイナリとして利用できます。


<img src="assets/cl-repl.png"
     style="width: 500px" alt="cl-repl 0.4.1 runnning in the terminal, built with Roswell, featuring multi-line prompts and syntax highlighting."/>

<!-- pdf-include-start
![](assets/cl-repl.png)
   pdf-include-end -->


## その他

ほかにも、多少開発が止まっているものも含め、いくつかのエディタがあります。また Allegro CL など、ほかの Lisp ベンダーの無料版もあります。

関連項目として、Web ベースの GUI ビルダーで Lisp エディタも付属する Common Lisp Omnificent GUI、[CLOG](https://github.com/rabbibotton/clog) も参照してください。
