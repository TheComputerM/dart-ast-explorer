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

    if (WebAssembly.String === undefined) {
        console.log("WebAssembly.String is undefined, adding polyfill");
        WebAssembly.String = {
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
    }

    // Imports
    const dart2wasm = {

  _45: (x0,x1,x2,x3,x4) => new AstTreeNode(x0,x1,x2,x3,x4),
_46: (x0,x1) => x0.enterNode(x1),
_47: x0 => x0.exitNode(),
_65: () => globalThis.tree,
_90: s => stringToDartString(JSON.stringify(stringFromDartString(s))),
_91: s => console.log(stringFromDartString(s)),
_194: o => o === undefined,
_195: o => typeof o === 'boolean',
_196: o => typeof o === 'number',
_198: o => typeof o === 'string',
_201: o => o instanceof Int8Array,
_202: o => o instanceof Uint8Array,
_203: o => o instanceof Uint8ClampedArray,
_204: o => o instanceof Int16Array,
_205: o => o instanceof Uint16Array,
_206: o => o instanceof Int32Array,
_207: o => o instanceof Uint32Array,
_208: o => o instanceof Float32Array,
_209: o => o instanceof Float64Array,
_210: o => o instanceof ArrayBuffer,
_211: o => o instanceof DataView,
_212: o => o instanceof Array,
_213: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
_216: o => o instanceof RegExp,
_217: (l, r) => l === r,
_218: o => o,
_219: o => o,
_220: o => o,
_221: b => !!b,
_222: o => o.length,
_225: (o, i) => o[i],
_226: f => f.dartFunction,
_227: l => arrayFromDartList(Int8Array, l),
_228: l => arrayFromDartList(Uint8Array, l),
_229: l => arrayFromDartList(Uint8ClampedArray, l),
_230: l => arrayFromDartList(Int16Array, l),
_231: l => arrayFromDartList(Uint16Array, l),
_232: l => arrayFromDartList(Int32Array, l),
_233: l => arrayFromDartList(Uint32Array, l),
_234: l => arrayFromDartList(Float32Array, l),
_235: l => arrayFromDartList(Float64Array, l),
_236: (data, length) => {
          const view = new DataView(new ArrayBuffer(length));
          for (let i = 0; i < length; i++) {
              view.setUint8(i, dartInstance.exports.$byteDataGetUint8(data, i));
          }
          return view;
        },
_237: l => arrayFromDartList(Array, l),
_238: stringFromDartString,
_239: stringToDartString,
_246: (o, p) => o[p],
_183: (s, m) => {
          try {
            return new RegExp(s, m);
          } catch (e) {
            return String(e);
          }
        },
_184: (x0,x1) => x0.exec(x1),
_185: (x0,x1) => x0.test(x1),
_186: (x0,x1) => x0.exec(x1),
_187: (x0,x1) => x0.exec(x1),
_188: x0 => x0.pop(),
_242: l => new Array(l),
_250: o => String(o),
_255: x0 => x0.index,
_257: x0 => x0.length,
_259: (x0,x1) => x0[x1],
_263: x0 => x0.flags,
_264: x0 => x0.multiline,
_265: x0 => x0.ignoreCase,
_266: x0 => x0.unicode,
_267: x0 => x0.dotAll,
_268: (x0,x1) => x0.lastIndex = x1,
_143: Object.is,
_145: WebAssembly.String.concat,
_153: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
_103: (a, i) => a.push(i),
_114: a => a.length,
_116: (a, i) => a[i],
_117: (a, i, v) => a[i] = v,
_119: a => a.join(''),
_122: (s, t) => s.split(t),
_123: s => s.toLowerCase(),
_124: s => s.toUpperCase(),
_125: s => s.trim(),
_129: (s, p, i) => s.indexOf(p, i),
_130: (s, p, i) => s.lastIndexOf(p, i),
_132: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
_133: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
_134: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
_135: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
_136: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
_137: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
_138: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
_141: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
_142: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
_144: WebAssembly.String.charCodeAt,
_146: WebAssembly.String.substring,
_147: WebAssembly.String.length,
_148: WebAssembly.String.equals,
_149: WebAssembly.String.compare,
_150: WebAssembly.String.fromCharCode,
_157: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
_158: (b, o) => new DataView(b, o),
_160: Function.prototype.call.bind(DataView.prototype.getUint8),
_161: Function.prototype.call.bind(DataView.prototype.setUint8),
_162: Function.prototype.call.bind(DataView.prototype.getInt8),
_164: Function.prototype.call.bind(DataView.prototype.getUint16),
_166: Function.prototype.call.bind(DataView.prototype.getInt16),
_168: Function.prototype.call.bind(DataView.prototype.getUint32),
_170: Function.prototype.call.bind(DataView.prototype.getInt32),
_176: Function.prototype.call.bind(DataView.prototype.getFloat32),
_178: Function.prototype.call.bind(DataView.prototype.getFloat64),
_101: (c) =>
              queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
_180: s => stringToDartString(stringFromDartString(s).toUpperCase()),
_181: s => stringToDartString(stringFromDartString(s).toLowerCase()),
_66: v => stringToDartString(v.toString()),
_80: s => {
      const jsSource = stringFromDartString(s);
      if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(jsSource)) {
        return NaN;
      }
      return parseFloat(jsSource);
    },
_81: () => {
          let stackString = new Error().stack.toString();
          let frames = stackString.split('\n');
          let drop = 2;
          if (frames[0] === 'Error') {
              drop += 1;
          }
          return frames.slice(drop).join('\n');
        },
_85: () => {
      // On browsers return `globalThis.location.href`
      if (globalThis.location != null) {
        return stringToDartString(globalThis.location.href);
      }
      return null;
    },
_86: () => {
        return typeof process != undefined &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      }
      };

    const baseImports = {
        dart2wasm: dart2wasm,

  
          Math: Math,
        Date: Date,
        Object: Object,
        Array: Array,
        Reflect: Reflect,
    };
    dartInstance = await WebAssembly.instantiate(await modulePromise, {
        ...baseImports,
        ...(await importObjectPromise),
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

