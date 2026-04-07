class SignalAgent {
  // TODO: Implement FT8/FT4/FT2 generation and decoding using libft8 via FFI.
  Future<void> initialize() async {
    // Initialize FFI bindings.
  }

  Future<String> decode(List<int> audioSamples) async {
    // Decode audio samples and return decoded message.
    return '';
  }

  Future<List<int>> encode(String message) async {
    // Encode message into audio samples.
    return [];
  }
}
