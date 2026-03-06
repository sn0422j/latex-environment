#!/bin/bash
set -euxo pipefail
# `chmod +x scripts/build-diff.sh` is required to run this script.

if [ $# -lt 2 ]; then
  echo "Usage: $0 input.tex REVISION [OUTPUT_TEX]"
  echo "Example: $0 main.tex HEAD~1"
  exit 1
fi

INPUT="$(realpath "$1")"
REVISION="$2"
DIR="$(dirname "$INPUT")"
BASE="$(basename "$INPUT" .tex)"

if [ $# -ge 3 ]; then
  OUTPUT_TEX="$3"
else
  OUTPUT_TEX="$DIR/${BASE}-diff.tex"
fi

OUTPUT_TEX="$(realpath -m "$OUTPUT_TEX")"
OUTPUT_DIR="$(dirname "$OUTPUT_TEX")"
OUTPUT_BASE="$(basename "$OUTPUT_TEX" .tex)"

mkdir -p "$OUTPUT_DIR"
cd "$DIR"

echo "Generating latexdiff-vc output"
echo "  input    : $INPUT"
echo "  revision : $REVISION"
echo "  output   : $OUTPUT_TEX"

latexdiff-vc \
  --git \
  --flatten \
  --force \
  -r "$REVISION" \
  "$BASE.tex"

# latexdiff-vc は通常 BASE-diffREV.tex を作るので、それを拾う
GENERATED_TEX="$(find . -maxdepth 1 -type f -name "${BASE}-diff*.tex" | head -n 1 || true)"

if [ -z "$GENERATED_TEX" ]; then
  echo "Error: latexdiff-vc did not generate a diff tex file."
  exit 2
fi

GENERATED_TEX="${GENERATED_TEX#./}"

if [ "$DIR/$GENERATED_TEX" != "$OUTPUT_TEX" ]; then
  mv "$GENERATED_TEX" "$OUTPUT_TEX"
fi

echo "Diff TeX created: $OUTPUT_TEX"
