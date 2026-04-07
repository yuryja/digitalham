import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

class LibFT8 {
  // Load the native library (different name per platform)
  static final DynamicLibrary _lib = Platform.isAndroid
      ? DynamicLibrary.open('libft8_wrapper.so')
      : DynamicLibrary.process(); // iOS embeds the lib in the app binary

  // C signatures
  static final _genMessage = _lib
      .lookup<
        NativeFunction<
          Int32 Function(Pointer<Utf8>, Pointer<Uint8>, Pointer<Int32>)
        >
      >('gen_ft8_message')
      .asFunction<
        int Function(Pointer<Utf8>, Pointer<Uint8>, Pointer<Int32>)
      >();

  static final _encode = _lib
      .lookup<NativeFunction<Int32 Function(Pointer<Uint8>, Pointer<Uint8>)>>(
        'encode_ft8',
      )
      .asFunction<int Function(Pointer<Uint8>, Pointer<Uint8>)>();

  static final _decode = _lib
      .lookup<NativeFunction<Int32 Function(Pointer<Uint8>, Pointer<Uint8>)>>(
        'decode_ft8',
      )
      .asFunction<int Function(Pointer<Uint8>, Pointer<Uint8>)>();

  /// Encode a message and also retrieve the tone sequence.
  static ({Uint8List payload, Uint8List tones}) encodeMessageWithTones(
    String message,
  ) {
    final msgPtr = message.toNativeUtf8();
    final payloadPtr = calloc<Uint8>(10);
    final tonesPtr = calloc<Int32>(79);
    final toneCountPtr = calloc<Int32>();
    _genMessage(msgPtr, payloadPtr, toneCountPtr);
    // Retrieve payload bits.
    final payload = Uint8List.fromList(payloadPtr.asTypedList(10));
    // Retrieve tones.
    final toneCount = toneCountPtr.value;
    final tones = Uint8List.fromList(tonesPtr.asTypedList(toneCount));
    // Clean up.
    calloc.free(msgPtr);
    calloc.free(payloadPtr);
    calloc.free(tonesPtr);
    calloc.free(toneCountPtr);
    return (payload: payload, tones: tones);
  }

  static Uint8List encodePayload(Uint8List payloadBits) {
    final inPtr = calloc<Uint8>(payloadBits.length);
    for (var i = 0; i < payloadBits.length; i++) {
      inPtr[i] = payloadBits[i];
    }
    final outPtr = calloc<Uint8>(22);
    _encode(inPtr, outPtr);
    final out = Uint8List.fromList(outPtr.asTypedList(22));
    calloc.free(inPtr);
    calloc.free(outPtr);
    return out;
  }

  static Uint8List decodePayload(Uint8List codeword) {
    final inPtr = calloc<Uint8>(codeword.length);
    for (var i = 0; i < codeword.length; i++) {
      inPtr[i] = codeword[i];
    }
    final outPtr = calloc<Uint8>(10);
    _decode(inPtr, outPtr);
    final out = Uint8List.fromList(outPtr.asTypedList(10));
    calloc.free(inPtr);
    calloc.free(outPtr);
    return out;
  }
}
