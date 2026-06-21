.PHONY = run clean clean-en clean-ja epub pdf epub+pdf epub-en pdf-en epub+pdf-en

SED_CMD ?= sed
export SED_CMD

JA_BUILD_ENV = SOURCE_DIR=ja OUTPUT_DIR=ja METADATA_FILE=ja/metadata.txt BOOKNAME=ja/common-lisp-cookbook-ja.epub PDFNAME=ja/common-lisp-cookbook-ja.pdf
EN_BUILD_ENV = SOURCE_DIR=. OUTPUT_DIR=. METADATA_FILE=metadata.txt BOOKNAME=common-lisp-cookbook.epub PDFNAME=common-lisp-cookbook.pdf

run:
	bundle exe jekyll serve --incremental

clean: clean-ja

clean-en:
	rm -f full.md full.typ full-with-preamble.typ full-with-preamble.pdf common-lisp-cookbook.epub common-lisp-cookbook.pdf

clean-ja:
	rm -f ja/full.md ja/full.typ ja/full-with-preamble.typ ja/full-with-preamble.pdf ja/common-lisp-cookbook-ja.epub ja/common-lisp-cookbook-ja.pdf

epub: clean-ja
	$(JA_BUILD_ENV) sbcl --load make-cookbook.lisp --eval '(generate)' --eval '(to-epub)' --eval '(uiop:quit)'

pdf: clean-ja
	$(JA_BUILD_ENV) sbcl --disable-debugger --load make-cookbook.lisp --eval '(generate)' --eval '(to-pdf)' --eval '(uiop:quit)'

sample-pdf: clean-ja
	sbcl --load make-cookbook.lisp --eval '(generate)' --eval '(sample-pdf)' --eval '(uiop:quit)'

epub+pdf: epub
	$(JA_BUILD_ENV) sbcl --load make-cookbook.lisp --eval '(to-pdf)' --eval '(uiop:quit)'

epub-en: clean-en
	$(EN_BUILD_ENV) sbcl --load make-cookbook.lisp --eval '(generate)' --eval '(to-epub)' --eval '(uiop:quit)'

pdf-en: clean-en
	$(EN_BUILD_ENV) sbcl --disable-debugger --load make-cookbook.lisp --eval '(generate)' --eval '(to-pdf)' --eval '(uiop:quit)'

epub+pdf-en: epub-en
	$(EN_BUILD_ENV) sbcl --load make-cookbook.lisp --eval '(to-pdf)' --eval '(uiop:quit)'
