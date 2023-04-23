import 'package:assume/core/service/local/hive/mission_cache.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/local/notification/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

starterConfigurator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _cacheInitialize();
  await _notificationInitialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> _notificationInitialize() async {
  if (await Permission.notification.isGranted) {
    await NotificationService().initNotification();
    tz.initializeTimeZones();
  }
}

Future<void> _cacheInitialize() async {
  await Hive.initFlutter();
  await MissionCacheService.instance.openMissionsBox();
  await SystemCacheService.instance.openSystemBox();
  await UserCacheService.instance.openUserBox();
}
