---
title: データベースアクセスと永続化
---

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
- モデルを定義すると、Ruby の ActiveRecord や Django のように、デフォルトで `id` (serial primary key)、
  `created_at`、`updated_at` フィールドを追加します。
- サポートするバックエンド向けの DB **マイグレーション**を扱います。
- DB **スキーマのバージョン管理**ができます。
- SBCL と CCL でテストされています。

ORM として、クラス定義を書き、リレーションを指定でき、データベースを問い合わせるための関数を提供します。
カスタムクエリには [SxQL](https://github.com/fukamachi/sxql) を使います。
SxQL は複数のバックエンドに同じインターフェイスを提供する SQL ジェネレータです。

Mito を使う作業は、一般に次の手順になります。

- DB に接続する
- モデルを定義するために [CLOS](clos.html) クラスを書く
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

Common Lisp Object System の使い方について詳しくは [clos](clos.html) ページを参照してください。


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

そして join table のおかげで、リレーションに関する追加情報を保存できます。

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
これは join table に保存できる情報です。

~~~lisp
(mito:deftable user-books ()
    ((user :col-type user)
     (book :col-type book)
    ;; 数量を設定する。デフォルトは 1:
     (quantity :col-type :integer)))
~~~


#### 継承と mixin

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
<!-- epub-exclude-start -->
<br>
<!-- epub-exclude-end -->

#### クエリの合成

[SxQL's query composer](https://github.com/fukamachi/sxql/blob/master/COMPOSER.md) でクエリを合成できます。

以下の `->` は SxQL の threading macro です。
クエリを連鎖させるための主要なインターフェイスです。
初期値を受け取り、それを一連の変換へ通していきます。

基本クエリを定義できます。ここでは active なユーザーを選択します。

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

`insert-dao`、`update-dao`、`delete-dao` は generic function として定義されているため、通常の [method combination](clos.html#qualifiers-and-method-combination) と同じように、それらに対して `:before`、`:after`、`:around` メソッドを定義できます。

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

### Eager loading

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
<!-- epub-exclude-start -->
- 高度な ["defmodel" macro](drafts/defmodel.lisp.html)。
<!-- epub-exclude-end -->

<!-- # todo: 既存 DB のモデル生成 -->
