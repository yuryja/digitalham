import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserCredentials {
  final String callsign;
  final String qthLocator;
  final String qrzPassword;
  final String hamQthPassword;

  UserCredentials({
    this.callsign = '',
    this.qthLocator = '',
    this.qrzPassword = '',
    this.hamQthPassword = '',
  });
}

class SecurityAgent {
  final _storage = const FlutterSecureStorage();

  static const _keyCallsign = 'user_callsign';
  static const _keyQth = 'user_qth';
  static const _keyQrz = 'user_qrz_pass';
  static const _keyHamQth = 'user_hamqth_pass';

  Future<void> saveCredentials(UserCredentials creds) async {
    await _storage.write(key: _keyCallsign, value: creds.callsign);
    await _storage.write(key: _keyQth, value: creds.qthLocator);
    await _storage.write(key: _keyQrz, value: creds.qrzPassword);
    await _storage.write(key: _keyHamQth, value: creds.hamQthPassword);
  }

  Future<UserCredentials> getCredentials() async {
    final call = await _storage.read(key: _keyCallsign) ?? '';
    final qth = await _storage.read(key: _keyQth) ?? '';
    final qrz = await _storage.read(key: _keyQrz) ?? '';
    final ham = await _storage.read(key: _keyHamQth) ?? '';

    return UserCredentials(
      callsign: call,
      qthLocator: qth,
      qrzPassword: qrz,
      hamQthPassword: ham,
    );
  }
}
