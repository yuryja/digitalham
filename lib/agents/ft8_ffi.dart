import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

class LibFT8 {
  static final DynamicLibrary? _lib = _loadLib();

  static DynamicLibrary? _loadLib() {
    try {
      if (Platform.isAndroid) {
        return DynamicLibrary.open('libft8_wrapper.so');
      } else if (Platform.isMacOS || Platform.isIOS) {
        return DynamicLibrary.process();
      }
      return null;
    } catch (e) {
      print("[FFI] Error loading library: $e");
      return null;
    }
  }

  // Native function lookups - must be explicit literal types
  static final int Function(Pointer<Utf8>, Pointer<Uint8>, Pointer<Int32>)? _genMessage = 
    _lib?.lookup<NativeFunction<Int32 Function(Pointer<Utf8>, Pointer<Uint8>, Pointer<Int32>)>>('gen_ft8_message').asFunction();

  static final int Function(Pointer<Uint8>, Pointer<Uint8>)? _encode = 
    _lib?.lookup<NativeFunction<Int32 Function(Pointer<Uint8>, Pointer<Uint8>)>>('encode_ft8').asFunction();

  static final int Function(Pointer<Uint8>, Pointer<Uint8>)? _decode = 
    _lib?.lookup<NativeFunction<Int32 Function(Pointer<Uint8>, Pointer<Uint8>)>>('decode_ft8').asFunction();

  static ({Uint8List payload, Uint8List tones}) encodeMessageWithTones(String message) {
    if (_genMessage == null) return (payload: Uint8List(0), tones: Uint8List(0));
    
    final msgPtr = message.toNativeUtf8();
    final payloadPtr = calloc<Uint8>(10);
    final tonesPtr = calloc<Int32>(79);
    final toneCountPtr = calloc<Int32>();
    
    _genMessage!(msgPtr, payloadPtr, toneCountPtr);
    
    final payload = Uint8List.fromList(payloadPtr.asTypedList(10));
    final toneCount = toneCountPtr.value;
    final tones = Uint8List.fromList(tonesPtr.asTypedList(toneCount));
    
    calloc.free(msgPtr);
    calloc.free(payloadPtr);
    calloc.free(tonesPtr);
    calloc.free(toneCountPtr);
    return (payload: payload, tones: tones);
  }

  static Uint8List encodePayload(Uint8List payloadBits) {
    if (_encode == null) return Uint8List(0);
    final inPtr = calloc<Uint8>(payloadBits.length);
    for (var i = 0; i < payloadBits.length; i++) inPtr[i] = payloadBits[i];
    final outPtr = calloc<Uint8>(22);
    _encode!(inPtr, outPtr);
    final out = Uint8List.fromList(outPtr.asTypedList(22));
    calloc.free(inPtr);
    calloc.free(outPtr);
    return out;
  }

  static Uint8List decodePayload(Uint8List codeword) {
    if (_decode == null) return Uint8List(0);
    final inPtr = calloc<Uint8>(codeword.length);
    for (var i = 0; i < codeword.length; i++) inPtr[i] = codeword[i];
    final outPtr = calloc<Uint8>(10);
    _decode!(inPtr, outPtr);
    final out = Uint8List.fromList(outPtr.asTypedList(10));
    calloc.free(inPtr);
    calloc.free(outPtr);
    return out;
  }
}
