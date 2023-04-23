import 'package:hive_flutter/hive_flutter.dart';

abstract class IBaseCacheManager<T> {
  Box<T>? _box;
  final String boxName;

  IBaseCacheManager(this.boxName);

  Future<void> openBox() async {
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox<T>(boxName);
    }
  }

  Future<void> clearBox() async {
    await _box?.clear();
  }

  closeBox() {
    _box?.close();
  }

  saveItem(T item) {
    _box?.add(item);
  }

  saveItemWithKey(dynamic key, T item) {
    _box?.put(key, item);
  }

  updateItem(dynamic key, T item) {
    _box?.put(key, item);
  }

  T? getItem(dynamic key) {
    return _box?.get(key);
  }

  deleteItem(dynamic key) {
    _box?.delete(key);
  }
}
