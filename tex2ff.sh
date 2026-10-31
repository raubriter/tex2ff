#!/bin/sh
set -eu

PROGRAM=${0##*/}
OUTPUT_DIR=$PWD

usage() {
    printf 'Usage: %s archive.zip [...]\n' "$PROGRAM" >&2
    exit 1
}

require() {
    for cmd; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            printf '%s: missing dependency: %s\n' "$PROGRAM" "$cmd" >&2
            exit 1
        fi
    done
}

convert_project() (
    dir=$1
    name=${dir##*/}
    cd "$dir"
    pdflatex -interaction=nonstopmode main.tex >/dev/null 2>&1
    pdftoppm -png -singlefile main.pdf main >/dev/null 2>&1
    png2ff <main.png | bzip2 >"$OUTPUT_DIR/$name.ff.bz2"
)

process_archive() (
    archive=$1
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT INT TERM
    unzip -q "$archive" -d "$tmp"
    find "$tmp" -type f -name main.tex -exec dirname {} \; |
        while IFS= read -r dir; do
            convert_project "$dir"
        done
)

[ $# -ge 1 ] || usage
require unzip pdflatex pdftoppm png2ff bzip2

for archive; do
    process_archive "$archive"
done
