import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

enum AppPermission { microphone, location, storage }

class PermissionResult {
  final bool granted;
  final bool permanentlyDenied;
  final String? error;

  PermissionResult({
    required this.granted,
    this.permanentlyDenied = false,
    this.error,
  });
}

class SecurityAgent {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<PermissionResult> requestPermission(AppPermission permission) async {
    switch (permission) {
      case AppPermission.microphone:
        return _requestMicrophone();
      case AppPermission.location:
        return _requestLocation();
      case AppPermission.storage:
        return _requestStorage();
    }
  }

  Future<PermissionResult> _requestMicrophone() async {
    final status = await Permission.microphone.request();

    return PermissionResult(
      granted: status.isGranted,
      permanentlyDenied: status.isPermanentlyDenied,
    );
  }

  Future<PermissionResult> _requestLocation() async {
    final status = await Permission.location.request();

    return PermissionResult(
      granted: status.isGranted,
      permanentlyDenied: status.isPermanentlyDenied,
    );
  }

  Future<PermissionResult> _requestStorage() async {
    final status = await Permission.storage.request();

    return PermissionResult(
      granted: status.isGranted || status.isLimited,
      permanentlyDenied: status.isPermanentlyDenied,
    );
  }

  Future<bool> checkPermission(AppPermission permission) async {
    switch (permission) {
      case AppPermission.microphone:
        return await Permission.microphone.isGranted;
      case AppPermission.location:
        return await Permission.location.isGranted;
      case AppPermission.storage:
        return await Permission.storage.isGranted ||
            await Permission.storage.isLimited;
    }
  }

  Future<bool> isMicrophoneGranted() async {
    return await Permission.microphone.isGranted;
  }

  Future<void> openAppSettingsPage() async {
    await openAppSettings();
  }

  Future<void> storeSecret(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecret(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecret(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<bool> hasSecret(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null && value.isNotEmpty;
  }

  Future<void> storeApiKey(String service, String apiKey) async {
    await storeSecret('api_key_$service', apiKey);
  }

  Future<String?> getApiKey(String service) async {
    return await readSecret('api_key_$service');
  }

  Future<void> clearAllSecrets() async {
    await _secureStorage.deleteAll();
  }
}
