#include "constants.h"

#include "stdint.h"

__externref_t decode_string_to_js(const char *buf_ptr, uint32_t length)
    __attribute__((import_module("./helpers.js"),
                   import_name("decodeStringToJs")));

__attribute__((export_name("hello"))) __externref_t hello()
{
  return decode_string_to_js(BIG_STRING, __builtin_strlen(BIG_STRING));
}
