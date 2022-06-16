import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageManager {

  LocalStorageManager._();

  static const _iosOptions = IOSOptions(accessibility: IOSAccessibility.first_unlock);

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(iOptions: _iosOptions);

  static Future<Set<String>?> getKeys() async => (await _secureStorage.readAll()).keys.toSet();

  static Future<bool> containsKey(String key) async => await _secureStorage.containsKey(key: key);

  static Future<void> setString(String key, String value) async =>
      await _secureStorage.write(key: key, value: value);

  static Future<void> setBool(String key, bool value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  static Future<void> setNum(String key, num value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  static Future<void> _setList<T>(String key, List<T> value) async {
    String buffer = json.encode(value);
    await _secureStorage.write(key: key, value: buffer);
  }

  static Future<void> setStringList(String key, List<String> value) => _setList<String>(key, value);

  static Future<void> setNumList(String key, List<num> value) => _setList<num>(key, value);

  static Future<void> setBoolList(String key, List<bool> value) => _setList<bool>(key, value);

  static Future<String?> getString(String key) async => await _secureStorage.read(key: key);

  static Future<bool?> getBool(String key) async {
    String? string = await _secureStorage.read(key: key);
    if (string == null) return null;
    if (string == 'true') {
      return true;
    } else if (string == 'false') {
      return false;
    } else {
      return null;
    }
  }

  static Future<num?> getNum(String key) async =>
      num.tryParse(await _secureStorage.read(key: key) ?? '');

  static Future<List<T>?> _getList<T>(String key) async {
    String? string = await _secureStorage.read(key: key);
    if (string == null) return null;
    List<T> list = (json.decode(string) as List).cast<T>();
    return list;
  }

  static Future<List<String>?> getStringList(String key) => _getList<String>(key);

  static Future<List<num>?> getNumList(String key) => _getList<num>(key);

  static Future<List<bool>?> getBoolList(String key) => _getList<bool>(key);

  static Future<void> remove(String key) async => await _secureStorage.delete(key: key);

  static Future<void> clearAll() async => await _secureStorage.deleteAll();
}
