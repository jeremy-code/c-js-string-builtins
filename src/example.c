#include "stdint.h"

__externref_t js_from_code_point(uint32_t codePoint)
    __attribute__((import_module("wasm-js-string"),
                   import_name("_fromCodePoint")));

__externref_t js_concat(__externref_t a, __externref_t b)
    __attribute__((import_module("wasm-js-string"), import_name("_concat")));

const char *str = "Hello World!";

__attribute__((export_name("hello"))) __externref_t hello() {
  __externref_t output = __builtin_wasm_ref_null_extern();
  for (int i = 0; str[i] != '\0'; i++) {
    __externref_t js_char = js_from_code_point((unsigned char)str[i]);

    if (i == 0) {
      output = js_char;
    } else {
      output = js_concat(output, js_char);
    }
  }
  return output;
}
