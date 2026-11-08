#!/bin/bash

OUTPUT_DIR="${PWD}/dist"

if [ ! -d "${OUTPUT_DIR}" ]; then
  mkdir -p "${OUTPUT_DIR}"
fi


clang \
  --target=wasm32-wasip1 \
  -nostartfiles \
  -Wl,--no-entry \
  -Wl,--no-merge-data-segments \
  -Wl,--keep-section=target_features \
  -Wl,--extra-features=gc \
  -Wl,--strip-debug \
  -o  ${OUTPUT_DIR}/example-builtin.wasm \
  ${PWD}/src/example-builtin.c

clang \
  --target=wasm32-wasip1 \
  -nostartfiles \
  -Wl,--no-entry \
  -Wl,--no-merge-data-segments \
  -Wl,--keep-section=target_features \
  -Wl,--extra-features=gc \
  -Wl,--strip-debug \
  -Xlinker --import-memory=./helpers.js,memory \
  -o ${OUTPUT_DIR}/example-import.wasm \
  ${PWD}/src/example-import.c

cp ${PWD}/src/helpers.js ${OUTPUT_DIR}/helpers.js

wasm-as \
  ${PWD}/src/wasm-js-string.wat \
  -o ${OUTPUT_DIR}/wasm-js-string.wasm \
  --enable-reference-types \
  --enable-gc

wasm-merge \
  ${OUTPUT_DIR}/wasm-js-string.wasm wasm-js-string \
  ${OUTPUT_DIR}/example-builtin.wasm example \
  -o ${OUTPUT_DIR}/example-builtin-merged.wasm \
  --enable-reference-types \
  --enable-gc

rm -rf ${OUTPUT_DIR}/example-builtin.wasm
rm -rf ${OUTPUT_DIR}/wasm-js-string.wasm
mv ${OUTPUT_DIR}/example-builtin-merged.wasm ${OUTPUT_DIR}/example-builtin.wasm

wasm-opt \
  --enable-gc \
  --enable-reference-types \
  --remove-exports="_*" \
  -O3 \
  ${OUTPUT_DIR}/example-builtin.wasm \
  -o ${OUTPUT_DIR}/example-builtin.wasm

wasm-opt \
  -O3 \
  ${OUTPUT_DIR}/example-import.wasm \
  -o ${OUTPUT_DIR}/example-import.wasm

printf "export function hello(): string;\n" > ${OUTPUT_DIR}/example-builtin.d.wasm.ts
printf "export function hello(): string;\n" > ${OUTPUT_DIR}/example-import.d.wasm.ts
