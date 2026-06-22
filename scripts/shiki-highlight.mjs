// Replace fenced code blocks in a Markdown file with Shiki HTML (github-light).
// Build-time only: the EPUB gets static <pre class="shiki"> HTML, no JavaScript.
// Usage: node scripts/shiki-highlight.mjs <input.md> <output.md>
import { readFileSync, writeFileSync } from "node:fs";
import { createHighlighter } from "shiki";

const [, , inPath, outPath] = process.argv;
if (!inPath || !outPath) {
  console.error("usage: shiki-highlight.mjs <input.md> <output.md>");
  process.exit(1);
}

// Fence language -> Shiki language. Everything else falls back to "text".
const LANGS = ["common-lisp", "bash", "text", "python", "c", "cmake", "json", "yaml", "html"];
const ALIAS = {
  lisp: "common-lisp", "common-lisp": "common-lisp",
  sh: "bash", shell: "bash", bash: "bash",
  txt: "text", text: "text", "": "text",
  python: "python", c: "c", cmake: "cmake",
  json: "json", yml: "yaml", yaml: "yaml", html: "html",
};

const warned = new Set();
function resolveLang(raw) {
  const key = raw.toLowerCase();
  if (key in ALIAS) return ALIAS[key];
  if (!warned.has(key)) {
    console.warn(`shiki: unknown language "${raw}", using text`);
    warned.add(key);
  }
  return "text";
}

const highlighter = await createHighlighter({ themes: ["github-light"], langs: LANGS });

const lines = readFileSync(inPath, "utf8").split("\n");
// ponytail: line scanner over fences, not a regex — handles ```/~~~ of any length.
const FENCE = /^(\s*)(`{3,}|~{3,})\s*([^\s`]*)\s*$/;
const out = [];
let i = 0;
while (i < lines.length) {
  const m = lines[i].match(FENCE);
  if (!m) { out.push(lines[i]); i++; continue; }
  const [, indent, fence, info] = m;
  const close = new RegExp(`^\\s*${fence[0]}{${fence.length},}\\s*$`);
  const body = [];
  i++;
  while (i < lines.length && !close.test(lines[i])) { body.push(lines[i]); i++; }
  i++; // skip closing fence (or fall off the end)
  const html = highlighter.codeToHtml(body.join("\n"), {
    lang: resolveLang(info),
    theme: "github-light",
  });
  // Blank lines around the raw HTML block so Pandoc treats it as a raw block.
  out.push(indent + "", html, "");
}

writeFileSync(outPath, out.join("\n"));
