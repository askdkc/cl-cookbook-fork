# sed script for the Japanese EPUB/PDF build only (applied after fix-epub-links.sed).
#
# The English build fixes internal links with the link-text-dependent rules in
# fix-epub-links.sed. Those rules don't match the translated Japanese link text,
# so the Japanese full.md was left with broken relative .html links. These rules
# fix that in a link-text-independent way.
#
# Requires GNU sed.

# 1. Turn the translators' raw HTML anchors (<a id="x"></a>) into pandoc-native
#    spans. Raw HTML anchors work in HTML/EPUB but are dropped when pandoc
#    generates Typst, so fragment links (foo.html#x -> #x) would have no target
#    in the PDF. The span content is a zero-width space (U+200B, \xe2\x80\x8b) so
#    Typst attaches the label to the span's own (invisible) box instead of
#    gloming it onto an adjacent heading, which would collide with that heading id.
s@<a id="\([^"]*\)"></a>@[\xe2\x80\x8b]{#\1}@g
s@<a name="\([^"]*\)"></a>@[\xe2\x80\x8b]{#\1}@g

# 2. Convert remaining relative chapter links to internal anchors:
#      foo.html       -> #chapter-foo  (matches the {#chapter-foo} id added to
#                                       each chapter title in make-cookbook.lisp)
#      foo.html#frag  -> #frag         (matches an in-page anchor/span)
#    External URLs are left untouched: the stem must follow "](" or href="
#    directly, so http(s):// links never match.
s/](\([a-zA-Z0-9_-][a-zA-Z0-9_-]*\)\.html#\([^)]*\))/](#\2)/g
s/](\([a-zA-Z0-9_-][a-zA-Z0-9_-]*\)\.html)/](#chapter-\1)/g
s/href="\([a-zA-Z0-9_-][a-zA-Z0-9_-]*\)\.html#\([^"]*\)"/href="#\2"/g
s/href="\([a-zA-Z0-9_-][a-zA-Z0-9_-]*\)\.html"/href="#chapter-\1"/g
