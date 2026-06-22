// Pandoc custom Typst template (pandoc --standalone --template=typst-preamble.typ).
// Layout only: document setup, fonts, code-block spacing. Skylighting token
// colours are injected below from the --syntax-highlighting theme.
#set document(
    title: [the Common Lisp Cookbook],
    date: auto,
    author: "collective",
    keywords: ("programming", "lisp", "common lisp", "free"),
    description: [A code-first tutorial and language reference for Common Lisp],
)

#set text(
  lang: "ja",
  font: "Noto Serif CJK JP",
)

$if(highlighting-definitions)$
// syntax highlighting functions from skylighting:
$highlighting-definitions$
$endif$

#show heading.where(level: 1, outlined: true): it => {
	pagebreak()
	it
}

// Do NOT add a global `show raw.where(block: false)` rule. Pandoc's Skylighting
// renderer builds both the tokens AND the line breaks (EndLine = raw("\n")) from
// inline raw, so any such rule boxes every newline and collapses code blocks
// onto a single line. Inline code therefore stays plain coloured mono text.
//
// Give highlighted code blocks a container (background, padding, rounded
// corners) by wrapping Pandoc's generated Skylighting function. The background
// matches pandoc-light.theme's background-color so the seams are invisible.
#let __skylighting-orig = Skylighting
#let Skylighting(..args) = block(
  fill: rgb("#f6f8fa"),
  inset: 8pt,
  radius: 4pt,
  width: 100%,
  {
    // ponytail: shrink code font so long lines fit the page width; a few very
    // long unbreakable lines (URLs, paths) can still overflow — break them in
    // the source if it matters.
    set text(size: 9pt)
    __skylighting-orig(..args)
  },
)

#show image: it => {
  align(center, it)
}

// The image is too small and pixelated.
#image("orly-cover.png", width: 90%),

#pagebreak(
    to: "even"
)

#set heading(numbering: "1.")
#show link: underline

#set page(numbering: "1")
#counter(page).update(1)

$body$
