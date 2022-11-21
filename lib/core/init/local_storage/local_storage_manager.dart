import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageManager {
  static LocalStorageManager? _instance;
  static LocalStorageManager get instance {
    if (_instance != null) return _instance!;
    _instance = LocalStorageManager._init();
    return _instance!;
  }

  LocalStorageManager._init();

  static const _androidOptions =
      AndroidOptions(encryptedSharedPreferences: true);
  static const _iosOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static const FlutterSecureStorage _secureStorage =
      FlutterSecureStorage(iOptions: _iosOptions, aOptions: _androidOptions);

  Future<Set<String>?> getKeys() async =>
      (await _secureStorage.readAll()).keys.toSet();

  Future<bool> containsKey(String key) async =>
      await _secureStorage.containsKey(key: key);

  Future<void> setString(String key, String value) async =>
      await _secureStorage.write(key: key, value: value);

  Future<void> setBool(String key, bool value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  Future<void> setNum(String key, num value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  Future<void> _setList<T>(String key, List<T> value) async {
    String buffer = json.encode(value);
    await _secureStorage.write(key: key, value: buffer);
  }

  Future<void> setStringList(String key, List<String> value) =>
      _setList<String>(key, value);

  Future<void> setNumList(String key, List<num> value) =>
      _setList<num>(key, value);

  Future<void> setBoolList(String key, List<bool> value) =>
      _setList<bool>(key, value);

  Future<String?> getString(String key) async =>
      await _secureStorage.read(key: key);

  Future<bool?> getBool(String key) async {
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

  Future<num?> getNum(String key) async =>
      num.tryParse(await _secureStorage.read(key: key) ?? '');

  Future<List<T>?> _getList<T>(String key) async {
    String? string = await _secureStorage.read(key: key);
    if (string == null) return null;
    List<T> list = (json.decode(string) as List).cast<T>();
    return list;
  }

  Future<List<String>?> getStringList(String key) => _getList<String>(key);

  Future<List<num>?> getNumList(String key) => _getList<num>(key);

  Future<List<bool>?> getBoolList(String key) => _getList<bool>(key);

  Future<void> remove(String key) async =>
      await _secureStorage.delete(key: key);

  Future<void> clearAll() async => await _secureStorage.deleteAll();
}
