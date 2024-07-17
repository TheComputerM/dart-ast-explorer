let buildArgsList;

// `modulePromise` is a promise to the `WebAssembly.module` object to be
//   instantiated.
// `importObjectPromise` is a promise to an object that contains any additional
//   imports needed by the module that aren't provided by the standard runtime.
//   The fields on this object will be merged into the importObject with which
//   the module will be instantiated.
// This function returns a promise to the instantiated module.
export const instantiate = async (modulePromise, importObjectPromise) => {
    let dartInstance;

    function stringFromDartString(string) {
        const totalLength = dartInstance.exports.$stringLength(string);
        let result = '';
        let index = 0;
        while (index < totalLength) {
          let chunkLength = Math.min(totalLength - index, 0xFFFF);
          const array = new Array(chunkLength);
          for (let i = 0; i < chunkLength; i++) {
              array[i] = dartInstance.exports.$stringRead(string, index++);
          }
          result += String.fromCharCode(...array);
        }
        return result;
    }

    function stringToDartString(string) {
        const length = string.length;
        let range = 0;
        for (let i = 0; i < length; i++) {
            range |= string.codePointAt(i);
        }
        if (range < 256) {
            const dartString = dartInstance.exports.$stringAllocate1(length);
            for (let i = 0; i < length; i++) {
                dartInstance.exports.$stringWrite1(dartString, i, string.codePointAt(i));
            }
            return dartString;
        } else {
            const dartString = dartInstance.exports.$stringAllocate2(length);
            for (let i = 0; i < length; i++) {
                dartInstance.exports.$stringWrite2(dartString, i, string.charCodeAt(i));
            }
            return dartString;
        }
    }

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + js;
    }

    // Converts a Dart List to a JS array. Any Dart objects will be converted, but
    // this will be cheap for JSValues.
    function arrayFromDartList(constructor, list) {
        const length = dartInstance.exports.$listLength(list);
        const array = new constructor(length);
        for (let i = 0; i < length; i++) {
            array[i] = dartInstance.exports.$listRead(list, i);
        }
        return array;
    }

    buildArgsList = function(list) {
        const dartList = dartInstance.exports.$makeStringList();
        for (let i = 0; i < list.length; i++) {
            dartInstance.exports.$listAdd(dartList, stringToDartString(list[i]));
        }
        return dartList;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
        wrapped.dartFunction = dartFunction;
        wrapped[jsWrappedDartFunctionSymbol] = true;
        return wrapped;
    }

    // Imports
    const dart2wasm = {

_48: (x0,x1,x2,x3,x4) => new AstTreeNode(x0,x1,x2,x3,x4),
_49: (x0,x1) => x0.enterNode(x1),
_50: x0 => x0.exitNode(),
_68: () => globalThis.tree,
_69: v => stringToDartString(v.toString()),
_83: s => {
      const jsSource = stringFromDartString(s);
      if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(jsSource)) {
        return NaN;
      }
      return parseFloat(jsSource);
    },
_84: () => {
          let stackString = new Error().stack.toString();
          let frames = stackString.split('\n');
          let drop = 2;
          if (frames[0] === 'Error') {
              drop += 1;
          }
          return frames.slice(drop).join('\n');
        },
_88: () => {
      // On browsers return `globalThis.location.href`
      if (globalThis.location != null) {
        return stringToDartString(globalThis.location.href);
      }
      return null;
    },
_89: () => {
        return typeof process != undefined &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
_93: s => stringToDartString(JSON.stringify(stringFromDartString(s))),
_94: s => printToConsole(stringFromDartString(s)),
_112: (c) =>
              queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
_114: (a, i) => a.push(i),
_125: a => a.length,
_127: (a, i) => a[i],
_128: (a, i, v) => a[i] = v,
_130: a => a.join(''),
_133: (s, t) => s.split(t),
_134: s => s.toLowerCase(),
_135: s => s.toUpperCase(),
_136: s => s.trim(),
_140: (s, p, i) => s.indexOf(p, i),
_141: (s, p, i) => s.lastIndexOf(p, i),
_143: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
_144: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
_145: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
_146: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
_147: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
_148: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
_149: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
_152: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
_153: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
_154: Object.is,
_157: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
_161: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
_162: (b, o) => new DataView(b, o),
_164: Function.prototype.call.bind(DataView.prototype.getUint8),
_165: Function.prototype.call.bind(DataView.prototype.setUint8),
_166: Function.prototype.call.bind(DataView.prototype.getInt8),
_168: Function.prototype.call.bind(DataView.prototype.getUint16),
_170: Function.prototype.call.bind(DataView.prototype.getInt16),
_172: Function.prototype.call.bind(DataView.prototype.getUint32),
_174: Function.prototype.call.bind(DataView.prototype.getInt32),
_180: Function.prototype.call.bind(DataView.prototype.getFloat32),
_182: Function.prototype.call.bind(DataView.prototype.getFloat64),
_189: s => stringToDartString(stringFromDartString(s).toUpperCase()),
_190: s => stringToDartString(stringFromDartString(s).toLowerCase()),
_192: (s, m) => {
          try {
            return new RegExp(s, m);
          } catch (e) {
            return String(e);
          }
        },
_193: (x0,x1) => x0.exec(x1),
_194: (x0,x1) => x0.test(x1),
_195: (x0,x1) => x0.exec(x1),
_196: (x0,x1) => x0.exec(x1),
_197: x0 => x0.pop(),
_203: o => o === undefined,
_204: o => typeof o === 'boolean',
_205: o => typeof o === 'number',
_207: o => typeof o === 'string',
_210: o => o instanceof Int8Array,
_211: o => o instanceof Uint8Array,
_212: o => o instanceof Uint8ClampedArray,
_213: o => o instanceof Int16Array,
_214: o => o instanceof Uint16Array,
_215: o => o instanceof Int32Array,
_216: o => o instanceof Uint32Array,
_217: o => o instanceof Float32Array,
_218: o => o instanceof Float64Array,
_219: o => o instanceof ArrayBuffer,
_220: o => o instanceof DataView,
_221: o => o instanceof Array,
_222: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
_225: o => o instanceof RegExp,
_226: (l, r) => l === r,
_227: o => o,
_228: o => o,
_229: o => o,
_230: b => !!b,
_231: o => o.length,
_234: (o, i) => o[i],
_235: f => f.dartFunction,
_236: l => arrayFromDartList(Int8Array, l),
_237: l => arrayFromDartList(Uint8Array, l),
_238: l => arrayFromDartList(Uint8ClampedArray, l),
_239: l => arrayFromDartList(Int16Array, l),
_240: l => arrayFromDartList(Uint16Array, l),
_241: l => arrayFromDartList(Int32Array, l),
_242: l => arrayFromDartList(Uint32Array, l),
_243: l => arrayFromDartList(Float32Array, l),
_244: l => arrayFromDartList(Float64Array, l),
_245: (data, length) => {
          const view = new DataView(new ArrayBuffer(length));
          for (let i = 0; i < length; i++) {
              view.setUint8(i, dartInstance.exports.$byteDataGetUint8(data, i));
          }
          return view;
        },
_246: l => arrayFromDartList(Array, l),
_247: stringFromDartString,
_248: stringToDartString,
_251: l => new Array(l),
_255: (o, p) => o[p],
_259: o => String(o),
_264: x0 => x0.index,
_266: x0 => x0.length,
_268: (x0,x1) => x0[x1],
_272: x0 => x0.flags,
_273: x0 => x0.multiline,
_274: x0 => x0.ignoreCase,
_275: x0 => x0.unicode,
_276: x0 => x0.dotAll,
_277: (x0,x1) => x0.lastIndex = x1
    };

    const baseImports = {
        dart2wasm: dart2wasm,


        Math: Math,
        Date: Date,
        Object: Object,
        Array: Array,
        Reflect: Reflect,
    };

    const jsStringPolyfill = {
        "charCodeAt": (s, i) => s.charCodeAt(i),
        "compare": (s1, s2) => {
            if (s1 < s2) return -1;
            if (s1 > s2) return 1;
            return 0;
        },
        "concat": (s1, s2) => s1 + s2,
        "equals": (s1, s2) => s1 === s2,
        "fromCharCode": (i) => String.fromCharCode(i),
        "length": (s) => s.length,
        "substring": (s, a, b) => s.substring(a, b),
    };

    dartInstance = await WebAssembly.instantiate(await modulePromise, {
        ...baseImports,
        ...(await importObjectPromise),
        "wasm:js-string": jsStringPolyfill,
    });

    return dartInstance;
}

// Call the main function for the instantiated module
// `moduleInstance` is the instantiated dart2wasm module
// `args` are any arguments that should be passed into the main function.
export const invoke = (moduleInstance, ...args) => {
    const dartMain = moduleInstance.exports.$getMain();
    const dartArgs = buildArgsList(args);
    moduleInstance.exports.$invokeMain(dartMain, dartArgs);
}

