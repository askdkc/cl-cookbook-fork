---
title: ファイルとディレクトリ
---

ここでは file と directory を操作するための関数とライブラリをいくつか見ていきます。

この章では主に
[namestrings](http://www.lispworks.com/documentation/HyperSpec/Body/19_aa.htm)
を使って
[specify filenames](http://www.lispworks.com/documentation/HyperSpec/Body/19_.htm).
file name を指定します。いくつかの recipe では
[pathnames](http://www.lispworks.com/documentation/HyperSpec/Body/19_ab.htm).
も使います。

多くの関数は UIOP 由来なので、直接見ておくことを勧めます。

* [UIOP/filesystem](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fFILESYSTEM)
* [UIOP/pathname](https://common-lisp.net/project/asdf/uiop.html#UIOP_002fPATHNAME)

もちろん、次も見逃さないでください。

* [Files and File I/O in Practical Common Lisp](http://gigamonkeys.com/book/files-and-file-io.html)


### pathname の構成要素を取得する

#### file name (directory なし)

pathname から file name を取得するには `file-namestring` を使います。

~~~lisp
(file-namestring #p"/path/to/file.lisp") ;; => "file.lisp"
~~~

#### file extension

file extension は Lisp 用語では "pathname type" と呼ばれます。

~~~lisp
(pathname-type "~/foo.org")  ;; => "org"
~~~

#### file basename

basename は "pathname name" と呼ばれます。

~~~lisp
(pathname-name "~/foo.org")  ;; => "foo"
(pathname-name "~/foo")      ;; => "foo"
~~~

directory pathname に trailing slash がある場合、`pathname-name` は `nil` を返すことがあります。代わりに `pathname-directory` を使います。

~~~lisp
(pathname-name "~/foo/")     ;; => NIL
(first (last (pathname-directory #P"~/foo/"))) ;; => "foo"
~~~

#### parent directory

~~~lisp
(uiop:pathname-parent-directory-pathname #P"/foo/bar/quux/")
;; => #P"/foo/bar/"
~~~

### file が存在するか test する

function
[`probe-file`](http://www.lispworks.com/documentation/HyperSpec/Body/f_probe_.htm)
を使います。これは
[generalized boolean](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_g.htm#generalized_boolean) -
を返します。file が存在しなければ `nil`、存在するならその
[truename](http://www.lispworks.com/documentation/HyperSpec/Body/20_ac.htm)
(渡した引数とは異なる場合があります) を返します。

より portable にするには、`uiop:probe-file*` または `uiop:file-exists-p` を使います。これらは (存在する場合) file pathname を返します。

file name に `*`、`[`、`]` などの wildcard 文字が含まれているかもしれない場合は、下を読んでください。


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

### file が存在するか test する (wildcard 文字に注意)

`(make-pathname :name filename-with-wild-chars)` の後に `probe-file` を使うか、SBCL では `sb-ext:parse-native-namestring` を使います。なぜでしょうか。

`*` だけでなく `[` と `]` も wildcard 文字です。file name の中では、これらは制限付きの [wildcard pathnames](https://cl-community-spec.github.io/pages/Restrictions-on-Wildcard-Pathnames.html) を作ります。

file name にこれらが含まれている場合、file が存在していても `uiop:probe-file*` と `uiop:file-exists-p` は NIL を返します。

"best-of-[2000]-01.mp3" という music file があるとします。

```txt
$ touch best-of-\[2000\]-01.mp3
```

2 つの backslash で文字を escape しない限り、`probe-file` は使えません (これは `str:replace-all` で行うことになるでしょう)。

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

`uiop:ensure-pathname` では `:want-non-wild t` key パラメータを使えます。


### tilde (`~`) を含む file name または directory name を展開する

portability のために `uiop:native-namestring` を使います。

~~~lisp
(uiop:native-namestring "~/.emacs.d/")
"/home/me/.emacs.d/"
~~~

存在しない file や directory についても tilde を展開します。

~~~lisp
(uiop:native-namestring "~/foo987.txt")
:: "/home/me/foo987.txt"
~~~

いくつかの処理系 (CCL、ABCL、ECL、CLISP、LispWorks) では、`namestring` も同様に動作します。SBCL では file または directory が存在しない場合、`namestring` は path を展開せず、tilde を含む引数を返します。

存在する file には `truename` も使えます。ただし少なくとも SBCL では、path が存在しない場合エラーを返します。

<a id="pathname--windows--directory-separator--string-"></a>

### pathname を Windows の directory separator を使う文字列に変換する

ここでも `uiop:native-namestring` を使います。

~~~lisp
CL-USER> (uiop:native-namestring #p"~/foo/")
"C:\\Users\\You\\foo\\"
~~~

逆の operation には `uiop:parse-native-namestring` も参照してください。

### directory を作成する

function
[ensure-directories-exist](http://www.lispworks.com/documentation/HyperSpec/Body/f_ensu_1.htm)
は、directory が存在しない場合に作成します。

~~~lisp
(ensure-directories-exist "foo/bar/baz/")
~~~

これは `foo`、`bar`、`baz` を作成するかもしれません。trailing slash を忘れないでください。

### directory を削除する

pathname (`#p`)、trailing slash、`:validate` key とともに `uiop:delete-directory-tree` を使います。

~~~lisp
;; mkdir dirtest
(uiop:delete-directory-tree #p"dirtest/" :validate t)
~~~

directory を指す文字列を `pathname` で包んで使うこともできます。

~~~lisp
(defun rmdir (path)
  (uiop:delete-directory-tree (pathname path) :validate t))
~~~

UIOP には `delete-empty-directory` もあります。

[cl-fad][cl-fad] has `(fad:delete-directory-and-files "dirtest")`.

### file と directory を merge する

`merge-pathnames` を使いますが、注意点が 1 つあります。directory を append したい場合、第 2 引数には trailing `/` が必要です。

いつものように UIOP 関数を見てください。corner case を修正する `uiop:merge-pathnames*` 相当があります。

ある directory に別の directory を append する方法は次のとおりです。

~~~lisp
(merge-pathnames "otherpath" "/home/vince/projects/")
;; 重要:                                         ^^
;; trailing / は directory を表す
;; => #P"/home/vince/projects/otherpath"
~~~

違いを見てください。どちらの path にも trailing slash を含めない場合、`otherpath` と `projects` は file と見なされるため、`otherpath` は `projects` を含む base directory に append されます。

~~~lisp
(merge-pathnames "otherpath" "/home/vince/projects")
;; #P"/home/vince/otherpath"
;;               ^^ "projects" はない。file と見なされたため
~~~

あるいは、`otherpath/` (trailing `/` 付き) だが `projects` は file と見なされる場合です。

~~~lisp
(merge-pathnames "otherpath/" "/home/vince/projects")
;; #P"/home/vince/otherpath/projects"
;;                ^^ ここに挿入される
~~~

### current working directory (CWD) を取得する

`uiop/os:getcwd` を使います。

~~~lisp
(uiop/os:getcwd)
;; #P"/home/vince/projects/cl-cookbook/"
;;                                    ^ trailing slash 付き。merge-pathnames に便利
~~~

### Lisp project からの相対 current directory を取得する

`asdf:system-relative-pathname system path` を使います。

`mysystem` の中で作業しているとします。これは ASDF system declaration を持ち、その system は Lisp image に load されています。この ASDF file は filesystem のどこかにあり、`src/web/` への path が欲しいとします。次のようにします。

~~~lisp
(asdf:system-relative-pathname "mysystem" "src/web/")
;; => #P"/home/vince/projects/mysystem/src/web/"
~~~

これは system source が別の場所にある他の user の machine でも動作します。


### current working directory を設定する

[`uiop:chdir`](https://asdf.common-lisp.dev/uiop.html#Function-uiop_002fos_003achdir) _`path`_ を使います。

~~~lisp
(uiop:chdir "/bin/")
0
~~~

_path_ の trailing slash は optional です。

または、次の operation だけ current directory を設定するには、`uiop:with-current-directory` を使います。

~~~lisp
(let ((dir "/path/to/another/directory/"))
  (uiop:with-current-directory (dir)
      (directory-files "./")))
~~~


### file を開く

Common Lisp には
[`open`](http://www.lispworks.com/documentation/HyperSpec/Body/f_open.htm) と
[`close`](http://www.lispworks.com/documentation/HyperSpec/Body/f_close.htm)
関数があり、これはおそらく馴染みのある他の programming language の同名の関数に似ています。しかし、ほとんど常にマクロ
[`with-open-file`](http://www.lispworks.com/documentation/HyperSpec/Body/m_w_open.htm)
を使うことを勧めます。このマクロは file を開き、終わったら閉じるだけではありません。code が body から異常に抜けた場合 (
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

*   `str` は、file を開くことで作成されるストリームに bind される変数です。
*   `<_file-spec_>` は truename または pathname になります。
*   `<_direction_>` は通常 `:input` (file から読みたい場合)、`:output` (file に書きたい場合)、または `:io` (同時に read _and_ write する場合) です。default は `:input` です。
*   `<_if-exists_>` は、書き込み用に file を開きたいが同名の file がすでに存在する場合にどうするかを指定します。file から読むだけなら、この option は無視されます。default は `:error` で、エラーが signalled されることを意味します。他に便利な option として、`:supersede` (新しい file が古いものを置き換える)、`:append` (content が file に追加される)、`nil` (ストリーム変数が `nil` に bind される)、`:rename` (つまり古い file が rename される) があります。
*   `<_if-does-not-exist_>` は、開きたい file が存在しない場合にどうするかを指定します。エラーを signal する `:error`、空の file を作成する `:create`、ストリーム変数を `nil` に bind する `nil` のいずれかです。default は簡単に言えば、指定した他の option に応じて正しいことをする、というものです。詳細は CLHS を参照してください。

`with-open-file` にはさらに多くの option がある点に注意してください。詳細は
[the CLHS entry for `open`](http://www.lispworks.com/documentation/HyperSpec/Body/f_open.htm)
を参照してください。下に `with-open-file` の使い方の例があります。また、既存の file を読むために開くだけなら、通常 keyword 引数を指定する必要はありません。

### file を読む

<a id="file--string--line--list-"></a>

#### file を文字列または line の list に読む

file の内容に文字列形式で access したり、line の list を取得したりする必要はかなりよくあります。

uiop は ASDF に含まれており (追加で install するライブラリや load する system はありません)、次の関数を持ちます。


~~~lisp
(uiop:read-file-string "file.txt")
~~~

and

~~~lisp
(uiop:read-file-lines "file.txt")
~~~

*別の方法として*、これは `read-line` や `read-char` 関数でも実現できますが、おそらく最善の解決策ではありません。file が複数行に分かれていないかもしれませんし、1 文字ずつ読むと大きな performance 問題を招くかもしれません。この問題を解決するには、特定 size の bucket を使って file を読めます。

~~~lisp
(with-output-to-string (out)
  (with-open-file (in "/path/to/big/file")
    (loop with buffer = (make-array 8192 :element-type 'character)
          for n-characters = (read-sequence buffer in)
          while (< 0 n-characters)
          do (write-sequence buffer out :start 0 :end n-characters)))))
~~~

さらに、常に文字型の element を使う代わりに、read/write される data の format を自由に変更できます。たとえば octet として data を読むには、`with-output-to-string`、`with-open-file`、`make-array` 関数の `:element-type` type 引数を `'(unsigned-byte 8)` に設定できます。

#### utf-8 encoding で読む

`ASCII stream decoding error` を避けるために UTF-8 encoding を指定したい場合があります。

~~~lisp
(with-open-file (in "/path/to/big/file"
                     :external-format :utf-8)
                 ...
~~~

#### SBCL の default encoding format を utf-8 に設定する

ライブラリの内部を control できないことがあるため、default encoding を utf-8 に設定しておく方がよいでしょう。`~/.sbclrc` に次の行を追加します。

    (setf sb-impl::*default-external-format* :utf-8)

必要に応じて:

    (setf sb-alien::*default-c-string-external-format* :utf-8)

#### file を 1 line ずつ読む

[`read-line`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_lin.htm)
はストリームから 1 line を読みます (default は
[_standard input_](http://www.lispworks.com/documentation/HyperSpec/Body/26_glo_s.htm#standard_input))
です)。line の終端は newline 文字または file の終端で決まります。この line は trailing newline 文字 _なし_ の文字列として返ります。(`read-line` には第 2 戻り値があり、trailing newline がなかった場合、つまり line が file の終端で終わった場合に true になる点に注意してください。) `read-line` は default では file の終端に到達するとエラーを signal します。第 2 引数に NIL を渡すとこれを抑制できます。その場合、file の終端に到達すると `read-line` は `nil` を返します。

~~~lisp
(with-open-file (stream "/etc/passwd")
  (do ((line (read-line stream nil)
       (read-line stream nil)))
       ((null line))
       (print line)))
~~~

file の終端を signal するために `nil` の代わりに使われる第 3 引数も指定できます。

~~~lisp
(with-open-file (stream "/etc/passwd")
  (loop for line = (read-line stream nil 'foo)
   until (eq line 'foo)
   do (print line)))
~~~

<a id="file--1-character-"></a>

#### file を 1 文字ずつ読む

[`read-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_cha.htm)
は `read-line` に似ていますが、1 line ではなく 1 文字だけを読みます。もちろん、この関数では newline 文字は他の文字と異なる扱いを受けません。

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
です。これは最初の (optional) 引数に応じて 3 つの異なる目的に使えます (第 2 引数は読む対象のストリームです)。最初の引数が `nil` の場合、`peek-char` はストリームで待っている次の文字をそのまま返します。

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
文字を skip します。つまりストリームで待っている次の non-whitespace 文字を返します。whitespace 文字は `read-char` で読まれたかのようにストリームから消えます。

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

`peek-char` の最初の引数が文字の場合、その特定の文字が見つかるまですべての文字を skip します。

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

`peek-char` には、`read-line` や `read-char` と同様に end-of-file 時の behaviour を control する追加の optional 引数がある点に注意してください (default ではエラーを signal します)。

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

function
[`unread-char`](http://www.lispworks.com/documentation/HyperSpec/Body/f_unrd_c.htm). You
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

ストリームの先頭は stack のようには振る舞わない点に注意してください。ストリームに戻せるのは正確に _1_ 文字だけです。また、以前に読んだものと同じ文字を戻さなければならず、まだ何も読んでいない場合は文字を unread できません。

#### file への random access

function
[`file-position`](http://www.lispworks.com/documentation/HyperSpec/Body/f_file_p.htm)
を file への random access に使います。この関数を 1 つの引数 (ストリーム) で使うと、ストリーム内の現在 position を返します。2 つの引数で使うと (下を参照)、ストリーム内の
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

### content を file に書く

`with-open-file` では `:direction :output` を指定し、内部で `write-sequence` を使います。

~~~lisp
(with-open-file (f <pathname> :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create)
    (write-sequence s f))
~~~

file が存在する場合、content を `:append` することもできます。

存在しない場合は `:error` にできます。詳細は [the standard](http://www.lispworks.com/documentation/HyperSpec/Body/f_open.htm) を参照してください。

<a id="library-"></a>

#### ライブラリを使う

[Alexandria](https://common-lisp.net/project/alexandria/draft/alexandria.html#Conses) ライブラリには [write-string-into-file](https://gitlab.common-lisp.net/alexandria/alexandria/-/blob/master/alexandria-1/io.lisp#L73) という関数があります。

~~~lisp
(alexandria:write-string-into-file content "file.txt")
~~~

また、[str](https://github.com/vindarel/cl-str) ライブラリには `to-file` 関数があります。

~~~lisp
(str:to-file "file.txt" content) ;; optional option 付き
~~~

`alexandria:write-string-into-file` と `str:to-file` はどちらも、file creation を control する `cl:open` と同じ keyword 引数、つまり `:if-exists` と `if-does-not-exists` を取ります。

### file attribute (size、access time など) を取得する

[Osicat](https://www.common-lisp.net/project/osicat/)
は Windows を含む POSIX-like system 向けの Common Lisp の軽量 operating system インターフェイスです。Osicat を使うと、**environment variables** の取得と設定 (現在は `uiop:getenv` でも可能)、**files and directories**、**pathnames** などの操作ができます。

[file-attributes](https://github.com/Shinmera/file-attributes/) is a
新しく軽量な OS portability ライブラリで、system call (cffi) を使って file attribute を取得することに特化しています。

`sb-posix` contrib を持つ SBCL も使えます。

#### file attribute (Osicat)

Osicat を install すると、file attribute を取得できる `osicat-posix` system も定義されます。

~~~lisp
(ql:quickload "osicat")

(let ((stat (osicat-posix:stat #P"./files.md")))
  (osicat-posix:stat-size stat))  ;; => 10629
~~~

他の attribute は次のメソッドで取得できます。

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

#### file attribute (file-attributes)

ライブラリは次で install します。

    (ql:quickload "file-attributes")

パッケージは `org.shirakumo.file-attributes` です。関数に短く access するために、たとえば package-local nickname を使えます。

~~~lisp
(uiop:add-package-local-nickname :file-attributes :org.shirakumo.file-attributes)
~~~

あとは単に関数を使います。

- `access-time`, `modification-time`, `creation-time`。これらは `setf` できます。
- `owner`, `group`, `attributes`。これらの関数で使われる値は OS specific です。attribute flag は `decode-attributes` と `encode-attributes` により standardized form で decode/encode できます。

~~~lisp
CL-USER> (file-attributes:decode-attributes
           (file-attributes:attributes #p"test.txt"))
(:READ-ONLY NIL :HIDDEN NIL :SYSTEM-FILE NIL :DIRECTORY NIL :ARCHIVED T :DEVICE
 NIL :NORMAL NIL :TEMPORARY NIL :SPARSE NIL :LINK NIL :COMPRESSED NIL :OFFLINE
 NIL :NOT-INDEXED NIL :ENCRYPTED NIL :INTEGRITY NIL :VIRTUAL NIL :NO-SCRUB NIL
 :RECALL NIL)
~~~

[documentation](https://shinmera.github.io/file-attributes) を参照してください。

#### file attribute (sb-posix)

この contrib は POSIX system では default で load されます。

まず file の stat オブジェクトを取得し、それから必要な stat を取得します。

~~~lisp
CL-USER> (sb-posix:stat "test.txt")
#<SB-POSIX:STAT {10053FCBE3}>

CL-USER> (sb-posix:stat-mtime *)
1686671405
~~~


### file と directory を list する

下のいくつかの関数は pathname を返すため、次が必要になるかもしれません。

~~~lisp
(namestring #p"/foo/bar/baz.txt")           ==> "/foo/bar/baz.txt"
(directory-namestring #p"/foo/bar/baz.txt") ==> "/foo/bar/"
(file-namestring #p"/foo/bar/baz.txt")      ==> "baz.txt"
~~~


#### directory 内の file を list する

~~~lisp
(uiop:directory-files "./")
~~~

pathname の list を返します。

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

#### sub-directory を list する

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

#### file を iterate する (lazy に)

上の関数に加えて、directory を *lazy* に traverse する解決策にも触れておきます。これらは file の list 全体を load してから返すわけではありません。

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

#### directory を recursively に traverse (walk) する

`uiop/filesystem:collect-sub*directories` を参照してください。これは引数として次を取ります。

- a `directory`
- a `collectp` function
- a `recursep` function
- a `collector` function

directory が与えられると、`collectp` がその directory に対して true を返した場合、その directory に対して `collector` 関数を call し、`recursep` が true を返す各 subdirectory を recurse します。

したがって、この関数により filesystem hierarchy を traverse でき、`cl-fad:walk-directory` の機能を置き換えられます。

symlink が存在する場合の behavior は portable ではありません。そのような状況を扱うには IOlib を使います。

例:

- subdirectory だけを collect します。

~~~lisp
(defparameter *dirs* nil "All recursive directories.")

(uiop:collect-sub*directories "~/cl-cookbook"
    (constantly t)
    (constantly t)
    (lambda (it) (push it *dirs*)))
~~~

- file と subdirectory を collect します。

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

- もちろん external tool も使えます。古き良き unix `find`、またはより新しい `fd` (Debian では `fdfind`) です。`fd` はより単純な syntax を持ち、common files and directories の集合を default で filter out します (node_modules、.git など)。

~~~lisp
(str:lines (uiop:run-program (list "find" ".") :output :string))
;; または
(str:lines (uiop:run-program (list "fdfind") :output :string))
~~~

ここでは `str` ライブラリの助けを借りています。


#### pattern に match する file を探す

下では単に directory の file を list し、その name が与えられた文字列を含むかを確認します。

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

`pathname` を文字列に変換するために `namestring` を使いました。これにより、`search` が扱える sequence になります。


#### wildcard で file を探す

unix wildcard を portable Common Lisp にそのまま移すことはできません。

pathname 文字列では `*` と `**` を wildcard として使えます。これは absolute pathname と relative pathname で動作します。

~~~lisp
(directory #P"*.jpg")
~~~

~~~lisp
(directory #P"**/*.png")
~~~


#### default pathname を変更する

current directory を表す `.` という概念は portable Common Lisp には存在しません。これは特定の filesystem や特定の処理系には存在するかもしれません。

home directory を表す `~` も存在しません。いくつかの処理系は non-portable extension として認識することがあります。


`*default-pathname-defaults*` は一部の pathname operation に default を提供します。

~~~lisp
(let ((*default-pathname-defaults* (pathname "/bin/")))
          (directory "*sh"))
(#P"/bin/zsh" #P"/bin/tcsh" #P"/bin/sh" #P"/bin/ksh" #P"/bin/csh" #P"/bin/bash")
~~~

`(user-homedir-pathname)` も参照してください。

[cl-fad]: https://edicl.github.io/cl-fad/
