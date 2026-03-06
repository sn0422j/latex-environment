#!/bin/bash
set -euxo pipefail
# `chmod +x scripts/build-docx.sh` is required to run this script.

if [ $# -lt 1 ]; then
  echo "Usage: $0 input.tex"
  exit 1
fi

INPUT="$(realpath "$1")"
DIR="$(dirname "$INPUT")"
BASE="$(basename "$INPUT" .tex)"
OUT="$DIR/$BASE.docx"

cd "$DIR"

REFERENCE_DOC="reference.docx"

ARGS=(
  "$BASE.tex"
  --from=latex
  --to=docx
  --citeproc
  --wrap=none
  --standalone
  --resource-path="$DIR"
  # --bibliography=refs.bib
)

if [ -f "$REFERENCE_DOC" ]; then
  echo "Using reference docx template: $REFERENCE_DOC"
  ARGS+=(--reference-doc="$REFERENCE_DOC")
fi

ARGS+=(-o "$OUT")

echo "Converting $INPUT -> $OUT"

pandoc "${ARGS[@]}"

echo "Done: $OUT"

