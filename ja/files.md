---
title: ファイルとディレクトリ
---

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


<a id="file--test--wildcard-character-"></a>

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

<a id="pathname--windows--directory-separator--string-"></a>

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

<a id="file--string--line--list-"></a>

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

<a id="file--1-character-"></a>

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

<a id="character-"></a>

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

<a id="file--random-access"></a>

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

<a id="library-"></a>

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

<a id="file-attribute-sizeaccess-time--"></a>

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
