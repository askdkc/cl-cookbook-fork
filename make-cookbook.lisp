;;
;; pandoc from markdown to epub
;; typst from markdown to Typst to pdf
;;
;; Usage:
;;
;; make epub
;; make pdf
;; make epub+pdf
;;
;; Metadata is in metadata.txt
;; -> change the date

(require 'asdf)

;; You need the str library already installed:
;; (ql:quickload "str")
;; We use str:replace-all which relies on ppcre, so we need a library anyways.
;; That's why I'm doing and using CIEL: small scripts are much easier to run and share.

(handler-case
    (require 'str)
  (error ()
    (format t "~&Please install the 'str' library to generate the PDF: (ql:quickload \"str\")~&")
    (uiop:quit 1)))

(defun normalize-dir (value)
  "Return VALUE with a trailing slash when it is non-empty."
  (let ((dir (or value "")))
    (if (or (string= dir "")
            (char= (char dir (1- (length dir))) #\/))
        dir
        (concatenate 'string dir "/"))))

(defparameter *source-dir* (normalize-dir (uiop:getenv "SOURCE_DIR")))
(defparameter *output-dir* (normalize-dir (uiop:getenv "OUTPUT_DIR")))
;; The Japanese build needs extra link fixing that the English build doesn't:
;; the link-text-dependent rules in fix-epub-links.sed don't match translated text.
(defparameter *japanese-p* (string= *source-dir* "ja/"))
(defparameter *metadata-file*
  (or (uiop:getenv "METADATA_FILE")
      (concatenate 'string *source-dir* "metadata.txt")))

(defparameter chapters
  (list
   "index.md"
   "license.md"
   "foreword.md"
   "getting-started.md"
   "editor-support.md"
   "emacs-ide.md"
   "vscode-alive.md"
   "lispworks.md"
   "variables.md"
   "functions.md"
   "data-structures.md"
   "strings.md"
   "numbers.md"
   "iteration.md"
   "arrays.md"
   "dates_and_times.md"
   "pattern_matching.md"
   "regexp.md"
   "io.md"
   "files.md"
   "error_handling.md"
   "packages.md"
   "macros.md"
   "clos.md"
   "type.md"
   "sockets.md"
   "os.md"
   "ffi.md"
   "dynamic-libraries.md"
   "process.md"
   "systems.md"
   ;; "win32.md" ; Excluded because: Out of date
   "debugging.md"
   "performance.md"
   "scripting.md"
   "streams.md"
   "testing.md"
   "databases.md"
   "gui.md"
   "web.md"
   "web-scraping.md"
   "websockets.md"
   ;; "misc.md" ; Excluded because: Lack of relevant content
   ;; "awesome-cl.md"
   "contributors.md"
   ))

(defparameter *typst-preamble* "typst-preamble.typ"
  "Typst declarations and settings to which we add the full typ document.")

(defparameter *sed-command* (uiop:getenv "SED_CMD"))
(defparameter *full-markdown* (concatenate 'string *output-dir* "full.md"))
;; EPUB-only intermediate: full.md with code blocks turned into Shiki HTML.
;; The PDF build keeps using the raw *full-markdown*.
(defparameter *full-epub-markdown* (concatenate 'string *output-dir* "full.epub.md"))
(defparameter *full-with-preamble* (concatenate 'string *output-dir* "full-with-preamble.typ"))
(defparameter *bookname*
  (or (uiop:getenv "BOOKNAME")
      (concatenate 'string *output-dir* "common-lisp-cookbook.epub")))
(defparameter *pdfname*
  (or (uiop:getenv "PDFNAME")
      (concatenate 'string *output-dir* "common-lisp-cookbook.pdf")))
(defparameter *epub-command-placeholder* "pandoc -o ~a --toc ~a~a ~a"
  "format with book name, metadata, css flag, sources file.")

(defun shiki-highlight ()
  "Turn fenced code blocks in *full-markdown* into static Shiki HTML, written to
  *full-epub-markdown*. Build-time only; the EPUB carries no JavaScript.
  Requires node_modules (run 'npm ci')."
  (unless (probe-file "node_modules/shiki")
    (format t "~&Shiki is not installed. Run 'npm ci' first.~&")
    (uiop:quit 1))
  (format t "~&Highlighting code blocks with Shiki...~&")
  (uiop:run-program (format nil "node scripts/shiki-highlight.mjs ~a ~a"
                            *full-markdown* *full-epub-markdown*)
                    :output t :error-output t))

(defparameter pdf-toc "== Table Of Contents (High-level)
<high-level-table-of-contents>
#outline(title: none, depth:1)

#pagebreak()

== Table Of Contents (Detailed)
<detailed-table-of-contents>
#outline(title: none, depth:3)
")

(defun reset-target ()
  (uiop:run-program (format nil "echo > ~a" *full-markdown*)))

(defun full-editing ()
  "Transform markdown frontmatters to a title, etc."
  (format t "Edit the markdown...~&")
  (uiop:run-program (format nil "~a -i \"s/title:/# /g\" ~a" *sed-command* *full-markdown*))
  (uiop:run-program (format nil "~a -i \"/^---/s/---/ /g\" ~a" *sed-command* *full-markdown*))
  ;; Exclude regions that don't export correctly, like embedded videos.
  (uiop:run-program (format nil
                            "~a -i \"/<\!-- epub-exclude-start -->/,/<\!-- epub-exclude-end -->/d\" ~a"
                            *sed-command*
                            *full-markdown*))
  ;; Make internal links work in the generated EPUB.
  (uiop:run-program (format nil "~a -i -f fix-epub-links.sed ~a" *sed-command* *full-markdown*))
  ;; The Japanese build needs link-text-independent fixing on top of the above.
  (when *japanese-p*
    (uiop:run-program (format nil "~a -i -f fix-ja-links.sed ~a" *sed-command* *full-markdown*))))

(defun to-epub ()
  (shiki-highlight)
  (format t "~&Generating ~a...~&" *bookname*)
  (let* ((css (concatenate 'string *output-dir* "epub.css"))
         (css-flag (if (probe-file css) (format nil " --css=~a" css) "")))
    (uiop:run-program (format nil *epub-command-placeholder*
                              *bookname* *metadata-file* css-flag *full-epub-markdown*))))

(defun sample-pdf ()
  (format t "~&Generating a very short PDF sample.~&")
  (uiop:run-program (format nil "typst compile ~a" *typst-preamble*)))

(defun insert-pdf-tocs ()
  "Replace {{PDF-TOCS}} in the .typ file with a proper TOC declaration.

  Using sed was tooooo cumbersome."
  (format t "~&Inserting our table of contents into ~a…~&" *full-with-preamble*)
  (let* ((file.typ *full-with-preamble*)
         (file-string (uiop:read-file-string file.typ))
         (new-content (str:replace-all "{{PDF-TOCS}}" pdf-toc file-string)))
    (str:to-file file.typ new-content)))

(defun to-pdf ()
  "Needs pandoc >= 3.8 with Markdown to Typst conversion,
  and the typst binary on the path."
  (format t "~&Generating the pdf with pandoc >= 3.8 and Typst...~&")

  ;; Include images for the PDF.
  ;; The issue: our images in HTLM <img> tags are not brought along in the .typ then PDF.
  (uiop:run-program
   (format nil "~a -f include-pdf-images.sed ~a > ~a.tmp && mv ~a.tmp ~a"
           *sed-command*
           *full-markdown*
           *full-markdown*
           *full-markdown*
           *full-markdown*)
   :output t
   :error-output t)

  ;; Transform our md file to .typ, using typst-preamble.typ as a Pandoc
  ;; template so Skylighting's token functions ($highlighting-definitions$)
  ;; are defined in the standalone output. Needs pandoc >= 3.8.
  (uiop:run-program (format nil "pandoc --standalone --template=~a --syntax-highlighting=pandoc-light.theme -o ~a ~a"
                            *typst-preamble* *full-with-preamble* *full-markdown*)
                    :output t
                    :error-output t)

  ;; Insert our two outlines:
  (insert-pdf-tocs)

  ;; Compile the Typst document:
  (uiop:run-program
   (format nil "typst compile ~a ~a" *full-with-preamble* *pdfname*)
   :output t
   :error-output t)

  (format t "Done: ~a" *pdfname*))

(defun effective-chapters ()
  "Chapters to include. The Japanese index TOC links to the equality chapter
  (not inside an epub-exclude region), so the Japanese build must include it.
  The English build keeps its original chapter set."
  (if *japanese-p*
      (loop for chap in chapters
	    collect chap
	    when (string= chap "numbers.md") collect "equality.md")
      chapters))

(defun build-full-source ()
  (format t "Creating the full source into ~a...~&" *full-markdown*)
  ;; For the Japanese build, tag each chapter title with an explicit {#chapter-stem}
  ;; id (e.g. variables.md -> {#chapter-variables}). This gives every chapter a stable
  ;; anchor that matches the foo.html -> #chapter-foo rewrite in fix-ja-links.sed,
  ;; independent of the translated title text. The "chapter-" prefix avoids colliding
  ;; with auto-generated ids of same-named section headings (e.g. a "Debugging" one).
  ;; The English build relies on fix-epub-links.sed's auto-id references instead, so
  ;; it must NOT get these explicit ids, and just concatenates the chapters as-is.
  (loop for chap in (effective-chapters)
	for stem = (pathname-name (pathname chap))
	for src = (concatenate 'string *source-dir* chap)
	for cmd = (if *japanese-p*
		      (format nil "~a 's/^title:.*/& {#chapter-~a}/' ~a >> ~a"
			      *sed-command* stem src *full-markdown*)
		      (format nil "cat ~a >> ~a" src *full-markdown*))
	do (uiop:run-program cmd))
  (full-editing))

(defun generate ()
  (reset-target)
  (build-full-source))
