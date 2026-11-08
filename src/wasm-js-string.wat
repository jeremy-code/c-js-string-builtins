(module
  (import "wasm:js-string" "fromCharCode"
    (func $fromCharCode (param i32) (result (ref extern)))
  )
  (import "wasm:js-string" "fromCodePoint"
    (func $fromCodePoint (param i32) (result (ref extern)))
  )
  (import "wasm:js-string" "concat"
    (func $concat (param externref externref) (result (ref extern)))
  )
  (import "wasm:js-string" "substring"
    (func $substring (param externref i32 i32) (result (ref extern)))
  )
  (func (export "_fromCharCode") (param $charCode i32) (result externref)
    (call $fromCharCode (local.get $charCode))
  )
  (func (export "_fromCodePoint") (param $codePoint i32) (result externref)
    (call $fromCodePoint (local.get $codePoint))
  )
  (func (export "_concat") (param $a externref) (param $b externref) (result externref)
    (call $concat (local.get $a) (local.get $b))
  )
  (func (export "_substring") (param $string externref) (param $start i32) (param $end i32) (result externref)
    (call $substring (local.get $string) (local.get $start) (local.get $end))
  )
)
