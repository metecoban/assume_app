import 'package:hive_flutter/adapters.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 3)
class AppSettings {
  @HiveField(0)
  bool? hasPermission;
  @HiveField(1)
  bool? isDarkMode;
  @HiveField(2)
  int? mainColor;
  @HiveField(3)
  int? language;

  AppSettings(
      {this.hasPermission, this.isDarkMode, this.mainColor, this.language});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      hasPermission: json['hasPermission'],
      isDarkMode: json['isDarkMode'],
      mainColor: json['mainColor'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasPermission': hasPermission,
      'isDarkMode': isDarkMode,
      'mainColor': mainColor,
      'language': language,
    };
  }
}
