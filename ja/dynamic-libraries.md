---
title: 動的ライブラリを作る
---

Common Lisp 処理系の大多数には、C ABI を使うライブラリの関数を呼び出せる何らかの [外部関数インターフェイス](ffi.html) があります。しかし逆方向、つまり CL ライブラリを他の言語から C ABI 経由で呼び出せるライブラリとしてコンパイルすることは、あまり一般的ではないかもしれません。

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

<a id="environment-"></a>

## 環境の準備

<a id="shared-library-support--sbcl--build-"></a>

### 共有ライブラリ対応付きで SBCL をビルドする

SBCL のバイナリ配布物は通常、共有ライブラリとしてビルドされた SBCL を含んでいません。しかしこれは SBCL-Librarian に必要です。
[SBCL git リポジトリ](https://github.com/sbcl/sbcl) からダウンロードするか、[Roswell を使って](getting-started.html#with-roswell) `ros install sbcl-source` コマンドを実行して取得できます。

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
