

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scratch_me/interfaces/i_app_storage.dart';

class AppStorage implements IAPPStorage {
  final _storage = const FlutterSecureStorage();

  @override
  FlutterSecureStorage get appStorageInstance => throw UnimplementedError();

  @override
  Future<void> deleteStorageValue(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<Map<String, String>> getAllStorageValues(String key) async {
    Map<String, String> allValues = await _storage.readAll();
    return allValues;
  }

  @override
  Future<String?> getStorageValue(String key) async {
    String? value = await _storage.read(key: key);
    return value;
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  void resetStorage() {
    _storage.deleteAll();
  }

  @override
  Future<void> writeStorageValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
