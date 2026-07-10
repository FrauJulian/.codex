---
name: latex-document
description: Create and revise professional LaTeX documents with clear structure and readable layout. Use for .tex files, tables, figures, equations, bibliographies, and LaTeX troubleshooting.
---

# LaTeX Document

## Principles

- Prefer content over decoration.
- Establish structure before styling.
- Load only packages that are used.
- Avoid unnecessary complexity.

## Workflow

1. Identify the document type: article, report, thesis, letter, or presentation.
2. Preserve the project's class, preamble, language, and conventions.
3. Build a clear hierarchy with `\title`, `\author`, `\date`, sections, labels, and references.
4. Use consistent reference prefixes such as `sec:`, `fig:`, `tab:`, and `eq:`.
5. Split prose into short, coherent paragraphs.
6. Give every table and figure a caption and a reference in the text.
7. Use mathematical notation consistently.
8. Fix errors with the smallest stable change.

## Minimal preamble

```latex
\documentclass[11pt,a4paper]{article}
\usepackage[T1]{fontenc}
\usepackage[english]{babel}
\usepackage{microtype}
\usepackage{amsmath,amssymb}
\usepackage{graphicx}
\usepackage{booktabs}
\usepackage[hidelinks]{hyperref}
\title{Title}
\author{Author}
\date{\today}
```

LaTeX has processed UTF-8 by default since 2018. With LuaLaTeX or XeLaTeX, use `fontspec` and omit `fontenc`. Preserve a repository's existing document language instead of forcing English.

## Typography

- Use `booktabs` for tables and avoid vertical rules.
- Do not use `\\` as a paragraph separator.
- Use descriptive headings.
- Use `\emph{}` for emphasis instead of custom formatting.
- Introduce every figure and table in the surrounding text.

## Output

- New document: provide a complete, minimal, compilable `.tex` file.
- Existing document: provide a focused patch or replacement section.
- Troubleshooting: state the cause and provide the smallest compiling fix.
