import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  static final _storage = FlutterSecureStorage();

  static Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }
}
