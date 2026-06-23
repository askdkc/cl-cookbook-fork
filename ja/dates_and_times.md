---
title: 日付と時刻
---

Common Lisp は time を見る 2 つの異なる方法を提供します。「現実世界」の time を意味する universal time と、コンピュータの CPU から見た time を意味する実行時間です。ここではそれぞれを分けて扱います。

<a name="univ"></a>


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


<a id="timestamp-object--query--dayday-of-weekdays-in-month-"></a>
<a id="timestamp--query--dayday-of-weekdays-in-month-"></a>

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


<a id="time-string--formatting-format-format-timestring-iso-8601-format"></a>

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


<a id="format-string--format-timestring-year---month---day"></a>

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

<a id="time-string--parse-"></a>

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
