#!/bin/bash

# This script builds the English and Chinese PDF manuals using pandoc.
# It places the output files in a dedicated 'pdf/' directory.

OUTPUT_DIR="pdf"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Building English PDF: $OUTPUT_DIR/WTHM-IoT-Device-Manual-EN.pdf"

( \
    cat docs/en/index.md; \
    echo; echo '\newpage'; echo; \
    cat docs/en/product-specs.md; \
    echo; echo '\newpage'; echo; \
    cat docs/en/panel-operations.md; \
    echo; echo '\newpage'; echo; \
    cat docs/en/wifi-config.md \
) | pandoc \
    --from=markdown-implicit_figures+raw_tex \
    --to=pdf \
    --table-of-contents \
    --pdf-engine=xelatex \
    --resource-path=docs/en \
    --resource-path=docs/assets/images \
    -V 'mainfont:Noto Sans CJK SC' \
    -V 'sansfont:Noto Sans CJK SC' \
    -V 'monofont:Noto Sans CJK SC' \
    -V geometry:margin=1in \
    -M title="WTHM IoT Device Manual" \
    -M author="Monigear" \
    -M date="$(date +'%Y-%m-%d')" \
    --output="$OUTPUT_DIR/WTHM-IoT-Device-Manual-EN.pdf"

echo "Building Chinese PDF: $OUTPUT_DIR/WTHM-IoT-设备使用手册-ZH.pdf"

( \
    cat docs/zh/index.md; \
    echo; echo '\newpage'; echo; \
    cat docs/zh/product-specs.md; \
    echo; echo '\newpage'; echo; \
    cat docs/zh/panel-operations.md; \
    echo; echo '\newpage'; echo; \
    cat docs/zh/wifi-config.md \
) | pandoc \
    --from=markdown-implicit_figures+raw_tex \
    --to=pdf \
    --table-of-contents \
    --pdf-engine=xelatex \
    --resource-path=docs/zh \
    --resource-path=docs/assets/images \
    -V 'mainfont:Noto Sans CJK SC' \
    -V 'sansfont:Noto Sans CJK SC' \
    -V 'monofont:Noto Sans CJK SC' \
    -V geometry:margin=1in \
    -M title="WTHM IoT 设备使用手册" \
    -M author="Monigear" \
    -M date="$(date +'%Y-%m-%d')" \
 \
    --output="$OUTPUT_DIR/WTHM-IoT-设备使用手册-ZH.pdf"

echo "Done. PDFs are in the '$OUTPUT_DIR/' directory."