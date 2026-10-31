# tex2ff

A helper script for [mt](https://github.com/raubriter/mt).

## Overview

`tex2ff` is meant to be used with [mt](https://github.com/raubriter/mt) on LaTeX project archives exported from [Overleaf](https://www.overleaf.com/) in the pattern described [here](https://github.com/raubriter/mt/blob/main/data/list.txt). The TeX files and their figures are stored in Overleaf, such as the one at:

```
https://www.overleaf.com/project/6ae30f8db91643c343a814d7
```

That is to say, all tests from <a href="https://www.gov.br/inep/pt-br/areas-de-atuacao/avaliacao-e-exames-educacionais/enem/provas-e-gabaritos">ENEM between 2009 and 2025</a> are rewritten from scratch like this:

<img width="1913" height="926" alt="image" src="https://github.com/user-attachments/assets/94b9c17e-bc51-43f6-8bb2-18d0ff3dbf97" /><br/><br/>

**NOTE:** The archive must be downloaded **manually** from Overleaf (`File → Download → Source (.zip)` in the editor). The resulting `.zip` is then passed to `tex2ff`, which produces one `.bz2` per project. Automatic download is intentionally out of scope — the Overleaf endpoint requires an authenticated session cookie.

## Expected structure

Each input `.zip` must contain one directory per project, and each such directory must contain a `main.tex`:

```
2009.zip
├── 2009-136-D
│   ├── fig1.png
│   └── main.tex
├── 2009-137-E
│   ├── fig1.png
│   └── main.tex
├── 2009-138-C
│   ├── fig1.png
│   └── main.tex
├── 2009-139-A
│   ├── fig1.png
│   └── main.tex
├── 2009-140-D
│   └── main.tex
├── 2009-141-C
│   ├── fig1.png
│   └── main.tex
└── ...
```

The same layout applies to `2010.zip`, `2011.zip`, and so on. A single wrapping directory (e.g. `2009/2009-136-D/main.tex`) is also accepted, since `main.tex` is located by name rather than by fixed depth.

## Dependencies

`tex2ff` depends on the following tools, most of them already present in Unix-like systems:

- pdflatex ([TeX Live](https://www.tug.org/texlive/))
- pdftoppm ([Poppler](https://poppler.freedesktop.org/))
- png2ff ([farbfeld](https://tools.suckless.org/farbfeld/))
- bzip2
- unzip, find, mktemp, dirname (basic utilities)

For Debian/Ubuntu, the full set can be installed with:

```
apt install texlive-latex-base poppler-utils farbfeld bzip2 unzip
```

## Usage

```
tex2ff archive.zip [...]
```

Each `.zip` is extracted to a temporary directory, every `main.tex` found inside is compiled, and the result is written next to the caller as `<project>.ff.bz2`, where `<project>` is the name of the directory containing `main.tex`.

Example:

```
tex2ff 2009.zip 2010.zip 2011.zip
```

Given the `2009.zip` above, the script produces:

```
2009-136-D.ff.bz2
2009-137-E.ff.bz2
2009-138-C.ff.bz2
2009-139-A.ff.bz2
2009-140-D.ff.bz2
2009-141-C.ff.bz2
```

Temporary files are removed on exit, including when a conversion fails.

## License

Distributed under the GNU General Public License v3 or later (GPLv3+).

See the *LICENSE* file or visit: https://www.gnu.org/licenses/gpl-3.0.html
