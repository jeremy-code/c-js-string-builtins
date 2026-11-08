const memory = new WebAssembly.Memory({ initial: 2 });

const textDecoder = new TextDecoder();

/**
 * @param {number} buf_ptr
 * @param {number} length
 */
const decodeStringToJs = (buf_ptr, length) => {
  return textDecoder.decode(new Uint8Array(memory.buffer, buf_ptr, length));
};

export { memory, decodeStringToJs };
