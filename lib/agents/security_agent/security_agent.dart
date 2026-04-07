class SecurityAgent {
  final Map<String, String> _store = {};

  Future<bool> requestMicrophonePermission() async {
    // Placeholder – always grant for now.
    return true;
  }

  Future<void> storeSecret(String key, String value) async {
    _store[key] = value;
  }

  Future<String?> readSecret(String key) async {
    return _store[key];
  }
}
