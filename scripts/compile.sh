#!/bin/bash

if [ ! -d "dist" ]; then
  mkdir -p "dist"
fi

clang \
  --target=wasm32 \
  --no-standard-libraries \
  -Wl,--no-entry \
  -Wl,--no-merge-data-segments \
  -Wl,--keep-section=target_features \
  -Wl,--extra-features=gc \
  -o dist/example.wasm \
  src/example.c

wasm-merge \
  src/wasm-js-string.wat wasm-js-string \
  dist/example.wasm example \
  -o dist/example-merged.wasm \
  --enable-reference-types \
  --enable-gc

rm -rf dist/example.wasm
rm -rf dist/wasm-js-string.wasm
mv dist/example-merged.wasm dist/example.wasm

wasm-opt \
  --enable-gc \
  --enable-reference-types \
  --remove-exports="_*" \
  -O3 \
  dist/example.wasm \
  -o dist/example.wasm

wasm-dis \
  dist/example.wasm \
  -o dist/example.wat \
  --enable-reference-types \
  --enable-gc

printf "export function hello(): string;\n" > dist/example.d.wasm.ts
