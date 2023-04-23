import 'dart:ui';

import 'package:assume/core/base/service/base_cache_manager.dart';
import 'package:assume/core/model/system/app_settings.dart';
import 'package:hive/hive.dart';

class SystemCacheService extends IBaseCacheManager<AppSettings> {
  static final SystemCacheService _instance = SystemCacheService._init();
  static SystemCacheService get instance => _instance;
  SystemCacheService._init() : super('system');

  openSystemBox() {
    Hive.registerAdapter(AppSettingsAdapter());
    super.openBox();
  }

  Future<void> _saveAppSettings(AppSettings value) async {
    await super.saveItemWithKey('system', value);
  }

  _getAppSettings() {
    return super.getItem('system') ?? AppSettings();
  }

  savePermission(bool value) async {
    final appSettings = _getAppSettings();
    appSettings.hasPermission = value;
    await _saveAppSettings(appSettings);
  }

  getPermission() {
    return _getAppSettings().hasPermission ?? false;
  }

  saveTheme(bool isDark) async {
    _getAppSettings().isDarkMode = isDark;
    await _saveAppSettings(_getAppSettings());
  }

  getTheme() {
    return _getAppSettings().isDarkMode ?? false;
  }

  saveLanguage(int language) async {
    _getAppSettings().language = language;
    await _saveAppSettings(_getAppSettings());
  }

  getLanguage() {
    return _getAppSettings().language ??
        (window.locale.toLanguageTag().split('-')[0] == 'tr' ? 1 : 0);
  }

  saveMainColor(int color) async {
    _getAppSettings().mainColor = color;
    await _saveAppSettings(_getAppSettings());
  }

  getMainColor() {
    return _getAppSettings().mainColor ?? 0xffFD0054;
  }
}

class LocaleAdapter extends TypeAdapter<Locale> {
  @override
  final typeId = 20;

  @override
  Locale read(BinaryReader reader) {
    final languageCode = reader.readString();
    final countryCode = reader.readString();
    return Locale(languageCode, countryCode);
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    writer.writeString(obj.languageCode);
    if (obj.countryCode != null) {
      writer.writeString(obj.countryCode!);
    }
  }
}
