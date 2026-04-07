import 'dart:typed_data';
import '../ft8_ffi.dart';

class SignalAgent {
  /// Encode a human‑readable FT8 message and return the tone sequence.
  Future<List<int>> encode(String message) async {
    // Use the new FFI helper that also returns tones.
    final result = LibFT8.encodeMessageWithTones(message);
    // Convert Uint8List tones to List<int>.
    return result.tones.map((b) => b.toInt()).toList();
  }

  /// Decode a received FT8 payload (174‑bit codeword) into a human‑readable message.
  /// The `codeword` is expected as a Uint8List of length 22 (174 bits).
  Future<String> decode(Uint8List codeword) async {
    // Recover the 77-bit payload.
    LibFT8.decodePayload(codeword);
    // Next, you would need a Dart implementation that reverses `genft8`.
    // For now we return a placeholder string.
    return 'Decoded message (TODO)';
  }
}
