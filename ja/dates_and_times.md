---
title: Dates and Times
---

Common Lisp は time を見る 2 つの異なる方法を提供します。"real world" における time を意味する universal time と、computer の CPU から見た time を意味する run time です。ここではそれぞれを分けて扱います。

<a name="univ"></a>


## Built-in time functions

### Universal Time

Universal time は、GMT time zone の 1900 年 1 月 1 日 00:00 から経過した秒数として表されます。function
[`get-universal-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get_un.htm)
は現在の universal time を返します。

~~~lisp
CL-USER> (get-universal-time)
3220993326
~~~

もちろんこの値はあまり読みやすくないため、function
[`decode-universal-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_dec_un.htm)
を使って "calendar time" representation に変換できます。

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

**NB**: 次の section では、`local-time` library を使って、より user-friendly な function を得ます。たとえば `(local-time:universal-to-timestamp (get-universal-time))` は `@2021-06-25T09:16:29.000000+02:00` を返します。

この `decode-universal-time` 呼び出しは 9 つの値を返します。`seconds, minutes, hours, day, month, year, day of
the week, daylight savings time flag and time zone` です。day of the week は 0..6 の範囲の integer として表され、0 が Monday、6 が Sunday であることに注意してください。また、**time zone** は current time に足すと GMT time になる時間数として表されます。

したがってこの例では、decoded time は EST time zone における `2002 年 1 月 25 日 Friday の 19:22:06` で、daylight savings は有効ではありません。もちろんこれは computer 自身の clock に依存するため、正しく設定されていることを確認してください (time zone と DST flag を含みます)。shortcut として、
[`get-decoded-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get_un.htm)
を使うと、current time の calendar time representation を直接得られます。

~~~lisp
CL-USER> (get-decoded-time)
~~~

これは次と同等です。

~~~lisp
CL-USER> (decode-universal-time (get-universal-time))
~~~

これらの function を program 内で使う方法の例です (ただし率直に言えば、代わりに `local-time` library を使ってください)。

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

もちろん上の `get-decoded-time` 呼び出しは、任意の date を print するために、n を任意の integer number として `(decode-universal-time n)` に置き換えられます。逆方向へ進むこともできます。function
[`encode-universal-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_encode.htm)
を使うと、calendar time を対応する universal time に encode できます。この function は 6 つの mandatory argument (seconds, minutes, hours, day, month, year) と 1 つの optional argument (time zone) を取り、universal time を返します。

~~~lisp
CL-USER> (encode-universal-time 6 22 19 25 1 2002)
3220993326
~~~

time zone が指定されない場合、result は daylight savings time に対して自動的に調整されることに注意してください。指定された場合、Lisp は指定された time zone がすでに daylight savings time を考慮していると見なし、調整は行われません。

universal time は単なる number なので、calendar time より操作が簡単で安全です。date と time は、可能であれば常に universal time として保存し、output のためだけに string representation へ変換するべきです。たとえば、2 つの date のどちらが先かを知るには、対応する 2 つの universal time を `<` で比較するだけで簡単です。

### Internal Time

Internal time は、あなたの Lisp environment が computer の clock を使って測る time です。これは 3 つの重要な点で universal time と異なります。まず、internal time は指定された時点から測られるわけではありません。Lisp を起動した瞬間、machine を boot した瞬間、または過去の任意の時点から測られるかもしれません。すぐに見るように、internal time の absolute value はほとんど常に意味を持たず、internal time 同士の差だけが有用です。2 つ目の違いは、internal time は秒ではなく、[`internal-time-units-per-second`](http://www.lispworks.com/documentation/HyperSpec/Body/v_intern.htm) から推測できる (通常はより小さい) unit で測られることです。

~~~lisp
CL-USER> internal-time-units-per-second
1000
~~~

これは、この例で使われている Lisp environment では internal time が millisecond で測られることを意味します。

最後に、"internal time" clock は何を測っているのでしょうか。実際には Lisp には 2 つの異なる internal time clock があります。

- その 1 つは "real" time の経過を測ります (universal time が測るのと同じ time ですが、unit が異なります)。
- もう 1 つは CPU time の経過、つまり CPU が current Lisp process のために実際の computation を行うのに費やした time を測ります。

ほとんどの modern computer では、これら 2 つの time は異なります。CPU が program だけに完全に専念することはないからです (single-user machine でさえ、CPU は interrupt の処理や I/O の実行などに時間の一部を割く必要があります)。internal time を取得するために使う 2 つの function は、それぞれ [`get-internal-real-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get_in.htm) と [`get-internal-run-time`](http://www.lispworks.com/documentation/HyperSpec/Body/f_get__1.htm) と呼ばれます。これらを使えば、function の run time を測るという上の問題を解決できます。これは built-in macro `time` が行っていることです。

~~~lisp
CL-USER> (time (sleep 1))
Evaluation took:
  1.000 seconds of real time
  0.000049 seconds of total run time (0.000044 user, 0.000005 system)
  0.00% CPU
  2,594,553,447 processor cycles
  0 bytes consed
~~~


## `local-time` library

[local-time](https://common-lisp.net/project/local-time/) library ([GitHub](https://github.com/dlowe-net/local-time/)) は、standard で定義されたやや限られた functionality を拡張する、とても便利な library です。

特に、次のことができます。

- timestamp をさまざまな standard format または custom format で print する (例: RFC1123 や RFC3339)
- timestring を parse する
- time arithmetic を行う
- Unix time、timestamp、universal time の相互変換を行う

以下では、最も有用だと思う function を紹介します。完全な詳細は [manual](https://common-lisp.net/project/local-time/manual.html) を見てください。

Quicklisp で利用できます。

~~~lisp
CL-USER> (ql:quickload "local-time")
~~~

### timestamp を作成する (encode-timestamp, universal-to-timestamp)

`encode-timestamp` で timestamp を作成します。nanosecond、second、minute、day、month、year の数を渡します。

~~~lisp
(local-time:encode-timestamp 0 0 0 0 1 1 1984)
@1984-01-01T00:00:00.000000+01:00
~~~

完全な signature は次です。

    **encode-timestamp** nsec sec minute hour day month year &key timezone offset into

    offset は locale の UTC からの offset 秒数です。offset が指定されていない場合、offset は timezone から推測されます。into argument として timestamp が渡された場合、その value が設定され、その timestamp が返されます。それ以外の場合は、新しい timestamp が作成されます。

`universal-to-timestamp` で universal time から timestamp を作成します。

~~~lisp
(get-universal-time)
3833588757
(local-time:universal-to-timestamp (get-universal-time))
@2021-06-25T07:45:59.000000+02:00
~~~

human-readable な time string を parse することもできます。

~~~lisp
(local-time:parse-timestring "1984-01-01")
@1984-01-01T01:00:00.000000+01:00
~~~

ただし timestring の parsing についての section も見てください。

### 今日の日付を得る (now, today)

`now` または `today` を使います。

~~~lisp
(local-time:now)
@2019-11-13T20:02:13.529541+01:00

(local-time:today)
@2019-11-13T01:00:00.000000+01:00
~~~

"today" は UTC zone における current day の midnight です。

"yesterday" と "tomorrow" を計算するには、下を参照してください。

### time を加算または減算する (timestamp+, timestamp-)

`timestamp+` と `timestamp-` を使います。それぞれ 3 つの argument、date、number、unit を取ります (optional で timezone と offset も取ります)。

~~~lisp
(local-time:now)
@2021-06-25T07:19:39.836973+02:00

(local-time:timestamp+ (local-time:now) 1 :day)
@2021-06-26T07:16:58.086226+02:00

(local-time:timestamp- (local-time:now) 1 :day)
@2021-06-24T07:17:02.861763+02:00
~~~

利用できる unit は `:sec :minute :hour :day :year` です。

この operation は `adjust-timestamp` でも可能です。これは次の section ですぐ見るように、もう少し多くのことができます (一度に多くの operation を行えます)。

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

### 任意の offset で timestamp を変更する (adjust-timestamp)

`adjust-timestamp` の最初の argument は操作対象の timestamp で、その後に full `&body changes` を受け取ります。"change" は `(offset :part value)` という form です。

前の Monday を指してください。

~~~lisp
(local-time:adjust-timestamp (today) (offset :day-of-week :monday))
@2021-06-21T02:00:00.000000+02:00
~~~

一度に多くの change を適用できます。time travel します。

~~~lisp
(local-time:adjust-timestamp (today)
  (offset :day 3)
  (offset :year 110)
  (offset :month -1))
@2131-05-28T02:00:00.000000+01:00
~~~

destructive version として `adjust-timestamp!` があります。


### timestamp を比較する (timestamp<, timestamp<, timestamp= …)

これらは self-explanatory でしょう。

~~~lisp
timestamp< time-a time-b
timestamp<= time-a time-b
timestamp> time-a time-b
timestamp>= time-a time-b
timestamp= time-a time-b
timestamp/= time-a time-b
~~~

### 最小または最大の timestamp を見つける

`timestamp-minimum` と `timestamp-maximum` を使います。これらは任意個の argument を受け取ります。

~~~lisp
(local-time:timestamp-minimum (local-time:today)
                              (local-time:timestamp- (local-time:today) 100 :year))
@1921-06-25T02:00:00.000000+01:00
~~~

timestamp の list がある場合は、`(apply #'timestamp-minimum <your list of timestamps>)` を使います。

### time unit に従って timestamp を maximize または minimize する (timestamp-maximize-part, timestamp-minimize-part)

この便利な function でかなり多くの質問に答えられます。

例です。この month の last day をください。

~~~lisp
(let ((in-february (local-time:parse-timestring "1984-02-01")))
  (local-time:timestamp-maximize-part in-february :day))

@1984-02-29T23:59:59.999999+01:00
~~~


### timestamp object に query する (day、day of week、days in month などを得る)

次を使います。

~~~lisp
timestamp-[year, month, day, hour, minute, second, millisecond, microsecond,
           day-of-week (starts at 0 for sunday),
           millenium, century, decade]
~~~

すべての値を一度に得るには `decode-timestamp` を使います。

この便利な macro で、選んだ value を variable に bind します。

~~~lisp
(local-time:with-decoded-timestamp (:hour h)
     (now)
   (print h))

8
8
~~~

もちろん各 time unit (`:sec :minute :day`) を任意の順序でそれぞれの variable に bind できます。

`(days-in-month <month> <year>)` も参照してください。


### time string の formatting (format, format-timestring, +iso-8601-format+)

local-time の date representation は `@` で始まります。通常どおり `format` できます。たとえば aesthetic directive を使うと、普通の date representation を得られます。

~~~lisp
(local-time:now)
@2019-11-13T18:07:57.425654+01:00
~~~

~~~lisp
(format nil "~a" (local-time:now))
"2019-11-13T18:08:23.312664+01:00"
~~~

`format` のように使える `format-timestring` を使えます (したがって最初の argument として stream を取ります)。

~~~lisp
(local-time:format-timestring nil (local-time:now))
"2019-11-13T18:09:06.313650+01:00"
~~~

ここで `nil` は新しい string を返します。`t` なら `*standard-output*` に print します。

しかし `format-timestring` は `:format` argument も受け取ります。predefined date format を使うことも、s-expression friendly な方法で独自のものを与えることもできます (次の section を参照)。

default value は
`+iso-8601-format+` で、output は上に示したものです。`+rfc3339-format+` format はこれを default にします。

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


これらをまとめると、Unix time を human readable string として返す function は次のようになります。

~~~lisp
(defun unix-time-to-human-string (unix-time)
  (local-time:format-timestring
   nil
   (local-time:unix-to-timestamp unix-time)
   :format local-time:+asctime-format+))

(unix-time-to-human-string (get-universal-time))
"Mon Jun 25 06:46:49 2091"
~~~


### format string を定義する (format-timestring (:year "-" :month "-" :day))

custom `:format` argument を `format-timestring` に渡せます。

syntax は、特別な意味を持つ symbol (`:year`, `:day` など)、string、character からなる list です。

~~~lisp
(local-time:format-timestring nil (local-time:now) :format '(:year "-" :month "-" :day))
"2019-11-13"
~~~

symbol の list は documentation にあります: [https://common-lisp.net/project/local-time/manual.html#Parsing-and-Formatting](https://common-lisp.net/project/local-time/manual.html#Parsing-and-Formatting)

`:year :month :day :weekday :hour :hour12 :min :sec :msec`、long notation と short notation (`:long-weekday` は "Monday"、`:short-weekday` は
"Mon."、`:minimal-weekday` は "Mo."、同様に `:long-month` は "January"、`:short-month` は "Jan.")、gmt offset、timezone marker、`:ampm`、`:ordinal-day` (1st, 23rd)、iso number などがあります。

`+rfc-1123-format+` 自体は次のように定義されています。

~~~lisp
(defparameter +rfc-1123-format+
  ;; Sun, 06 Nov 1994 08:49:37 GMT
  '(:short-weekday ", " (:day 2) #\space :short-month #\space (:year 4) #\space
    (:hour 2) #\: (:min 2) #\: (:sec 2) #\space :gmt-offset-hhmm)
  "See the RFC 1123 for the details about the possible values of the timezone field.")
~~~

`(:day 2)` という form が見えます。2 は **padding** 用で、day が 2 桁で print されることを保証します (`1` だけでなく `01`)。optional な 3 つ目の argument として、padding に使う character を指定できます (default は `#\0`)。

### time string を parse する

`parse-timestring` を使って、`2019-11-13T18:09:06.313650+01:00` という form の timestring を parse します。default でさまざまな format に対応し、必要に合わせて parameter を変更できます。

"Thu Jul 23 19:42:23 2013" (asctime) のようなさらに多くの format を parse するには、[cl-date-time-parser](https://github.com/tkych/cl-date-time-parser) library を使います。

`parse-timestring` の docstring は次です。

>  timestring を parse し、対応する timestamp を返します。parsing は start から始まり、end position で止まります。timestring 内に invalid character があり fail-on-error が T の場合、invalid-timestring error が signal されます。そうでなければ NIL が返されます。
>
> timestring に timezone が指定されていない場合、offset が default timezone offset (秒単位) として使われます。

例:

~~~lisp
(local-time:parse-timestring "2019-11-13T18:09:06.313650+01:00")
;; @2019-11-13T18:09:06.313650+01:00
~~~

~~~lisp
(local-time:parse-timestring "2019-11-13")
;; @2019-11-13T01:00:00.000000+01:00
~~~

この custom format は default では失敗します: "2019/11/13"。しかし `:date-separator` を "/" に設定できます。

~~~lisp
(local-time:parse-timestring "2019/11/13" :date-separator #\/)
;; @2019-11-13T19:42:32.394092+01:00
~~~

`:time-separator` (default は `#\:`) と
`:date-time-separator` (`#\T`) もあります。

その他の option には次があります。

- start position と end position
- `fail-on-error` (default は `t`)
- `(allow-missing-elements t)`
- `(allow-missing-date-part allow-missing-elements)`
- `(allow-missing-time-part allow-missing-elements)`
- `(allow-missing-timezone-part allow-missing-elements)`
- `(offset 0)`

今度は ""Wed Nov 13 18:13:15 2019" のような format は失敗します。`cl-date-time-parser` library を使います。

~~~lisp
(cl-date-time-parser:parse-date-time "Wed Nov 13 18:13:15 2019")
;; 3782657595
;; 0
~~~

これは universal time を返し、それを local-time library に取り込めます。

~~~lisp
(local-time:universal-to-timestamp *)
;; @2019-11-13T19:13:15.000000+01:00
~~~

### Misc

Alice の anniversary かどうかを調べるには、`timestamp-whole-year-difference time-a time-b` を使います。
