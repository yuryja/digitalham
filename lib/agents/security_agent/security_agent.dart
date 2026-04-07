import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityAgent {
  final _storage = const FlutterSecureStorage();

  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> storeSecret(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readSecret(String key) async {
    return await _storage.read(key: key);
  }
}
