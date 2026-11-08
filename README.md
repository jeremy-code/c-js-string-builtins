```wat
(module
  (import "wasm:js-string" "fromCharCode"
    (func $fromCharCode (param i32) (result (ref extern))))
  (import "wasm:js-string" "concat"
    (func $concat (param externref externref) (result (ref extern))))

  (func (export "hello") (result (ref extern))
    (local $str (ref extern))
    (local.set $str (call $fromCharCode (i32.const 72)))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 101))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 108))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 108))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 111))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 32))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 119))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 111))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 114))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 108))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 100))))
    (local.set $str (call $concat (local.get $str) (call $fromCharCode (i32.const 33))))
    (local.get $str)
  )
)
```

```shell
wat2wasm ./example.wat -o example.wasm --enable-gc
```

```js
import { hello } from "./example.wasm";

console.log(hello());
```

```shell
node index.js
Hello world!
(node:69543) ExperimentalWarning: Importing WebAssembly module instances is an experimental feature and might change at any time
```

---

wasm-as ./wat/example.wat --output ./wat/example.wasm --enable-gc --enable-reference-types
node wat/index.js
Hello world!
(node:58677) ExperimentalWarning: Importing WebAssembly module instances is an experimental feature and might change at any time
