---
title: Streams
---

Streams are the standard abstraction for input and output in
Common Lisp. Every time you read from a file, write to the
terminal, or communicate over a network socket, you are using
a stream.

Many built-in functions have a stream argument, maybe optional:

```lisp
(print object &optional stream)

(format stream control-string &rest format-arguments)

(defmethod print-object (object stream) &body body)

(with-open-file (stream filespec …) &body body)
```

This chapter covers the stream types, how to create
and use them, and how to extend the stream protocol.

## What is a stream anyways?

A stream represents data that flows from one (or many) direction(s) to
another (or others). It can represent a small, well delimited amount
of data, as well as a possibly infinite amount of data.

In English, a "stream" can represent a small river, an uninterrupted
flow and, well, audio or video broadcast.

While working with streams, we look at the data passing by us, instead
of capturing all the stream *and then* doing our work. When we count
boats passing by the river, we don't collect all the river into a
bucket, and then count how many boats we captured. When reading a
small file into CSV, we can read the file at once and then parse it,
but if we work with very big files, we'll need a streaming API, and
divide our work by logical chunks.


## Stream basics

A stream is an object that represents a source or sink of
characters or bytes. The standard defines several stream
types:

- **Input streams** support reading (`read-char` and `unread-char`,
  `read-byte`, `read-line`, `read`).
- **Output streams** support writing (`write-char`,
  `write-byte`, `write-string`, `format`).
- **Bidirectional streams** support both.

Separately, streams have an element type:

- **Character streams** carry characters, which is what
  `read-char`, `read-line`, `format`, and most examples in
  this chapter use by default.
- **Binary streams** carry bytes, usually declared with an
  element type like `(unsigned-byte 8)`.

You can test what a stream supports:

~~~lisp
(input-stream-p *standard-input*)   ;; => T
(output-stream-p *standard-output*) ;; => T
(stream-element-type *standard-input*)
;; => CHARACTER
~~~

## Standard stream variables

Common Lisp provides several global stream variables that
are bound by default:

| Variable | Purpose |
|---|---|
| `*standard-input*` | Default input (your terminal or REPL) |
| `*standard-output*` | Default output (your terminal or REPL) |
| `*error-output*` | Error/warning messages |
| `*trace-output*` | Output from `trace` |
| `*debug-io*` | Interactive debugging I/O |
| `*query-io*` | User yes/no questions |
| `*terminal-io*` | The actual terminal stream |

Functions like `read`, `print`, and `format` use these by
default when you don't specify a stream:

~~~lisp
;; these are equivalent:
(print "hello")
(print "hello" *standard-output*) ;; or (print "hello" t)

(format *standard-output* "hello") ;; or (format t "hello")
~~~

You can rebind them to redirect output.

### Capturing or redirecting a program output

Do you want, for example, to capture some function output, that
normally prints to standard output, to a string?

You can generally use a `let` binding of this form:

~~~lisp
(let ((*standard-output* some-other-stream))
  (print "hello"))  ;; or another function call.
  ;; prints to some-other-stream
~~~

In this (convoluted) example we create a string stream and we bind
`*standard-output*` to it:

```lisp
(with-output-to-string (s)
 (let ((*standard-output* s))
   ;; some function calls here…
   (princ "hello")
   (princ " ")
   (princ "streams")))
;; => "hello streams"
```

We use `princ` to print an "aesthetic" representation of the
object. `print` would print the quotes and a newline.

This example can, by the way, be shortened to this:

```lisp
(with-output-to-string (*standard-output*)
  (princ "hello")
  (princ " ")
  (princ "streams"))
```

## File streams

Use `open` to create a file stream, or the
`with-open-file` macro which ensures the stream is
properly closed:

~~~lisp
;; processing a file line by line:
(with-open-file (my-file-stream "test.txt")
  ;;            ^^^ bind this symbol in the macro body.
  (loop for line = (read-line my-file-stream nil)
        while line
        when (search "cat" line)
          do (format t "this line is about cats: ~s~&" line)))
~~~

~~~lisp
;; writing to a file:
(with-open-file (stream "/tmp/out.txt"
                 :direction :output
                 :if-exists :supersede)
  (format stream "Hello, streams!~%"))
~~~

The `:direction` keyword controls the stream type:

- `:input` (default) — read only
- `:output` — write only
- `:io` — read and write
- `:probe` — just check if the file exists, then close.

For binary files, specify `:element-type`:

~~~lisp
(with-open-file (stream "/tmp/data.bin"
                 :direction :output
                 :if-exists :supersede
                 :element-type '(unsigned-byte 8))
  (write-byte 72 stream)
  (write-byte 101 stream))
~~~

## String streams

String streams let you treat strings as streams, which is
useful for building output or parsing input without files.

### Writing to a string: `with-output-to-string`

This macro allows to bind a symbol to a stream, to call functions that
print to this stream in the macro body, and in the end to create a
string:

~~~lisp
(with-output-to-string (s)
  ;; more clever processing…
  (format s "Hello, ")
  (format s "world!"))
;; => "Hello, world!"
~~~

You can use `format`, `write-string`, or other stream operations.

This can be seen as a more flexible equivalent of using `format` with
a destination of `nil`:

~~~lisp
(format nil "Hello, world!")
;; => "Hello, world!"
~~~

### Reading from a string: `with-input-from-string`

Reading from a string is useful for small parsers, REPL helpers, or
tests where you want input without touching the filesystem.

For this example, because `read` parses tokens from a
stream, we need to emulate an input stream with `with-input-from-string`:

~~~lisp
;; see also read-from-string to parse one form.
(with-input-from-string (s "123 456")
  (list (read s) (read s)))
;; => (123 456)
~~~

For more options:

- read [`with-input-from-string` on the Community Spec](https://cl-community-spec.github.io/pages/with_002dinput_002dfrom_002dstring.html)


### `make-string-input-stream` and `make-string-output-stream`

For cases where the macro forms are inconvenient, you
can create string streams directly. This is common when you
need to create the stream in one place and consume it later.

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

## Concatenated streams

`make-concatenated-stream` creates a stream that reads
from multiple input streams in sequence. When the first
stream is exhausted, reading continues from the next. This is
useful when several inputs should look like one continuous
source to existing stream-consuming code:

~~~lisp
(let* ((s1 (make-string-input-stream "Hello, "))
       (s2 (make-string-input-stream "world!"))
       (combined (make-concatenated-stream s1 s2)))
  (read-line combined))
;; => "Hello, world!"
~~~

## Broadcast streams

`make-broadcast-stream` creates a stream that sends
output to multiple streams simultaneously:

~~~lisp
(with-output-to-string (s)
  (let ((broadcast (make-broadcast-stream *standard-output* s)))
     (format broadcast "to both")))
;; prints "to both" to the terminal
;; => and returns the "to both" string.
~~~

or also:

~~~lisp
(let* ((s (make-string-output-stream))
       (broadcast (make-broadcast-stream *standard-output* s)))
  (format broadcast "to both")
  (get-output-stream-string str))
~~~

This is useful for logging to both the console and a
file at the same time.

### Discarding output (writing to /dev/null)

Calling `make-broadcast-stream` with no arguments is also the
portable equivalent of writing to `/dev/null`: output sent to
that stream is discarded.

~~~lisp
(let ((sink (make-broadcast-stream)))
  (format sink "this goes nowhere"))
~~~

## Example: one report, many destinations

A common pattern in real programs is to write functions that
accept a stream instead of deciding for themselves whether
output should go to the terminal, a file, or an in-memory
string. That keeps the formatting code in one place and makes
it easy to reuse.

Below, the stream argument is an optional argument (it could also be a
`&key` argument) and defaults to standard output.

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

The same function can now target different destinations:

~~~lisp
(let ((expenses '(("Books" 12.50)
                  ("Train" 24.10)
                  ("Lunch" 18.00))))
  ;; 1. print to the REPL / terminal (default)
  (write-expense-report expenses)

  ;; 2. save to a file
  (with-open-file (out "/tmp/expenses.txt"
                       :direction :output
                       :if-exists :supersede)
    (write-expense-report expenses out))

  ;; 3. capture as a string, for a test or an email body
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

### Writing to 2 streams at once

If you want tee-style output — that is, writing the same output
to two streams at once, like the Unix `tee` command — you can
also combine destinations with a broadcast stream:

~~~lisp
(let* ((expenses '(("Books" 12.50)
                   ("Train" 24.10)))
       (copy (make-string-output-stream))
       (tee (make-broadcast-stream *standard-output* copy)))
  (write-expense-report expenses tee)
  (get-output-stream-string copy))
~~~

## Two-way and echo streams

A **two-way stream** bundles an input and output stream
into a single bidirectional stream:

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

An **echo stream** is a two-way stream that also echoes
everything read from the input stream onto the output
stream. This is useful for logging or recording
interactive sessions:

~~~lisp
(let* ((in (make-string-input-stream "hello"))
       (out (make-string-output-stream))
       (echo (make-echo-stream in out)))
  (read-char echo)  ;; reads #\h, also writes to out
  (read-char echo)  ;; reads #\e, also writes to out
  (get-output-stream-string out))
;; => "he"
~~~

## Synonym streams

A synonym stream is an indirection — it forwards all
operations to the stream that is the current value of a
symbol. `*terminal-io*` is typically a synonym stream.

~~~lisp
(let* ((a-stream (make-string-input-stream "123"))
       (b-stream (make-string-input-stream "456"))
       (my-synonym (make-synonym-stream 'c-stream)))

  ;; setting our synonym stream symbol to A:
  (setf c-stream a-stream)
  (format t "reading stream A: ~a~&" (read my-synonym))

  ;; switching streams to B:
  (setf c-stream b-stream)
  (format t "and now reading stream B: ~a~&" (read my-synonym)))
~~~

This lets you redirect where a stream goes by rebinding
the symbol, without changing the stream object itself.

## Pitfall: streams may be buffered, `finish-output`

Be aware that some streams can be buffered and that buffered output
may not appear immediately. Use `finish-output`.

What may happen is that the buffer may hold data for a short while
before passing it to the stream. This mechanism is generally useful
under load, when the input source feeds data faster than the stream
can handle it.

Also, when writing to `*standard-output*`, the buffer is by default only
flushed when writing a newline.

As such, this snippet is typically not portable, it may vary across
implementations and may depend on the context (running this in a busy
terminal, etc):

~~~lisp
(write "enter an expression > ")
(read)
~~~

You logically expect to read the prompt string, then to enter an expression.

But you could get the blocking `(read)` before seeing the text on your terminal.

To ensure all the stream output is written in time, use `finish-output`:

~~~lisp
(write "enter an expression > ")
(finish-output)
(read)
~~~

`uiop` also defines `uiop:format!` which calls `finish-output` before
and after printing to the stream.

See also [force-output and clear-output](https://cl-community-spec.github.io/pages/finish_002doutput.html) (initiate the emptying of buffers but don't wait, attempt to abord output operations).

## More stream functions and macros

See all of them in the [streams dictionary on the CLCS](https://cl-community-spec.github.io/pages/Streams-Dictionary.html).

### `listen`

[listen](https://cl-community-spec.github.io/pages/listen.html):

> Returns true if there is a character immediately available from input-stream; otherwise, returns false. On a non-interactive input-stream, listen returns true except when at end of file_1. If an end of file is encountered, listen returns false. listen is intended to be used when input-stream obtains characters from an interactive device such as a keyboard.


### `terpri, fresh-line`

[terpri](https://cl-community-spec.github.io/pages/terpri.html)
always writes a newline to an output stream.

`fresh-line` writes a newline only if the stream isn't at the start of a newline.


### `y-or-n-p`, `yes-or-no-p`

[These functions](https://cl-community-spec.github.io/pages/y_002dor_002dn_002dp.html) print a prompt to `*query-io*`, wait for user input (a
one-letter "y" or "n", or a complete "yes" or "no"), and return a
boolean value.


### `with-open-stream`

[with-open-stream](https://cl-community-spec.github.io/pages/with_002dopen_002dstream.html)
"performs a series of operations on the stream, returns a value, and then
closes the stream."

This macro can be used to run expressions in the context of the stream
and ensure it is closed afterwards.

Example from the Lem editor: `make-buffer-output-stream` is a
primitive to create an editor buffer, and keep its stream open. We use
`with-open-stream` to write content.

```lisp
(defun display-welcome ()
  (when *enable-welcome*
    ;; print the welcome message to the start buffer
    (with-open-stream (stream (make-buffer-output-stream (buffer-start-point (current-buffer))))
      (loop :with prefix := (/ (- (window-width (current-window)) *message-width*) 2)
            :for line :in (str:lines *message-content*)
            :do (format stream "~v@{~a~:*~}" prefix " ")
            :do (format stream "~a~%" line)))))
```


## Gray streams: extending the protocol

The standard stream types are implemented by the
Common Lisp runtime. They let you *use* file, string, socket,
and terminal streams, but they do not standardize how you
define new stream classes that participate in ordinary Common
Lisp I/O operations. If you need custom stream behavior
(for example, a stream that compresses data, counts
bytes, transforms characters, or reads from an application
object instead of a file descriptor), you can use
**Gray streams**.

Gray streams are a de facto standard, proposed before ANSI
Common Lisp was finalized and based on the stream chapter from
CLtL. They did not make it into the ANSI standard, but most
popular implementations support this protocol anyway. In
practice, Gray streams are the usual way to define custom
streams that work with standard functions like `read-char`,
`write-char`, `read-sequence`, or `write-sequence`.

The [`trivial-gray-streams`](https://github.com/trivial-gray-streams/trivial-gray-streams)
library provides a portable interface.

To use it, we subclass a fundamental gray stream, such as
`fundamental-character-output-stream` below, and we define the
required methods for our new stream class. Below, for this character
output stream, we must define two methods, `stream-write-char` and
`stream-line-column`.


~~~lisp
;; in your .asd:
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

And now:

~~~lisp
(let* ((out (make-string-output-stream))
       (counting (make-instance 'counting-stream :inner out)))
  (write-string "hello" counting)
  (values (get-output-stream-string out)
          (char-count counting)))
;; => "hello"
;; => 5
~~~

### Gray streams: fundamental classes

The library defines the following classes:

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

### Gray streams: methods

The key methods to implement depend on the stream type. Take note of
which methods are mandatory to implement, and which are optional.

For **character input streams**:

- `stream-read-char` — read one character.
  - returns the symbol `:eof` if the stream is at end-of-file.
- `stream-unread-char` — push a character back.
- `stream-read-char-no-hang` (optional) — non-blocking character read
- `stream-read-line` (optional, for performance)
- `stream-read-sequence` (optional, for performance)

Every subclass of `` must define a
method for the first two functions.

For **character output streams**:

- `stream-write-char` — write one character
- `stream-line-column` —  Return the column number where the next character will be written, or NIL if that is not meaningful for this stream.
- `stream-write-string` (optional, for performance)
- `stream-write-sequence` (optional, for performance)

For **binary streams**:

- `stream-read-byte`
- `stream-write-byte`
- `stream-read-sequence` / `stream-write-sequence`

The sequence methods let your stream move whole slices of data
at once, which is often much faster than reading or writing
one character or byte at a time.

## Further reading

- [CLHS: Streams](http://www.lispworks.com/documentation/HyperSpec/Body/21_.htm)
- [CLtL2: Streams](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node329.html)
- [trivial-gray-streams](https://github.com/trivial-gray-streams/trivial-gray-streams)
- [flexi-streams](https://edicl.github.io/flexi-streams/) - FLEXI-STREAMS "implements "virtual" bivalent streams that can be layered atop real binary or bivalent streams and that can be used to read and write character data in various single- or multi-octet encodings which can be changed on the fly. It also supplies in-memory binary streams which are similar to string streams".
- [nontrivial-gray-streams](https://github.com/yitzchak/nontrivial-gray-streams) - extensions to the Gray stream protocol (Sequence Extensions, File Position Extensions…) and, unlike trivial-gray-streams, it does not introduce its own subclasses of the fundamental stream classes. Instead it exports the CL implementation's fundamental stream classes directly.
- [SBCL's bivalent streams](https://www.sbcl.org/manual/#Bivalent-Streams) - "A bivalent stream can be used to read and write both `character` and `(unsigned-byte 8)` values. A bivalent stream is created by calling open with the argument :element-type :default. On such a stream, both binary and character data can be read and written with the usual input and output functions."
- [Allegro CL's simple-streams](https://franz.com/support/documentation/10.1/doc/streams.htm) - also [a subset in SBCL](https://www.sbcl.org/manual/#Simple-Streams).
