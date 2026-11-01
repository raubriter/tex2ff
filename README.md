# tex2ff

A helper script for [mt](https://github.com/raubriter/mt).

## Overview

`tex2ff` converts LaTeX project archives exported from [Overleaf](https://www.overleaf.com/) into the `.ff.bz2` question files consumed by [`mt`](https://github.com/raubriter/mt).

The source projects (ENEM 2009–2025, rewritten from scratch) live on Overleaf, e.g.:

```
https://www.overleaf.com/project/6ae30f8db91643c343a814d7/share#d6d9bd9c5f929d0da5930b6a469dff31fb54f150b024923c
```

**Note:** Each archive must be downloaded **manually** from Overleaf (`File → Download → Source (.zip)`). The Overleaf endpoint requires an authenticated session cookie, so automatic download is intentionally out of scope.

## Input

Each `.zip` contains one directory per question, each with a `main.tex` (and optional figures). The directory name encodes the question ID and its answer as the last character:

```
2009.zip
├── 2009-136-D
│   ├── fig1.png
│   └── main.tex
├── 2009-137-E
│   ├── fig1.png
│   └── main.tex
└── ...
```

A single wrapping directory (e.g., `2009/2009-136-D/main.tex`) is also accepted, since `main.tex` is located by name rather than by fixed depth.

## Output

For each project, `tex2ff` writes `<project>.ff.bz2` next to the caller:

```
2009-136-D.ff.bz2
2009-137-E.ff.bz2
...
```

Temporary files are removed on exit, including on failure.

## Dependencies

- `pdflatex` ([TeX Live](https://www.tug.org/texlive/))
- `pdftoppm` ([Poppler](https://poppler.freedesktop.org/))
- `png2ff` ([farbfeld](https://tools.suckless.org/farbfeld/))
- `bzip2`, `unzip`, `find`, `mktemp`, `dirname`

On Debian/Ubuntu:

```
apt install texlive-latex-base poppler-utils farbfeld bzip2 unzip
```

## Usage

```
tex2ff archive.zip [...]
```

Each archive is extracted to a temporary directory, every `main.tex` inside is compiled, and the result is written as `<project>.ff.bz2`.

Example:

```
chmod +x tex2ff.sh
./tex2ff.sh 2009.zip 2010.zip 2011.zip
```

## License

GNU General Public License v3 or later (GPLv3+). See the *LICENSE* file or <https://www.gnu.org/licenses/gpl-3.0.html>.
