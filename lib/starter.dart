import 'package:assume/app/app.dart';
import 'package:assume/core/config/starter_configurator.dart';
import 'package:flutter/material.dart';

Future<void> setupApp() async {
  await starterConfigurator();
  runApp(const AssumeApp());
}
