(module
  (type $i16_array (array (mut i16)))

  (import "wasm:js-string" "fromCharCodeArray"
    (func $fromCharCodeArray
      (param (ref null $i16_array) i32 i32)
      (result (ref extern))))

  (func (export "hello") (result (ref extern))
    (call $fromCharCodeArray
      (array.new_fixed $i16_array 12
        (i32.const 72)  ;; H
        (i32.const 101) ;; e
        (i32.const 108) ;; l
        (i32.const 108) ;; l
        (i32.const 111) ;; o
        (i32.const 32)  ;; ' '
        (i32.const 119) ;; 'w'
        (i32.const 111) ;; 'o'
        (i32.const 114) ;; 'r'
        (i32.const 108) ;; 'l'
        (i32.const 100) ;; 'd'
        (i32.const 33)) ;; '!'
      (i32.const 0)
      (i32.const 12))
  )
)
