import 'package:assume/gen/assets.gen.dart';
import 'package:assume/starter.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Assets.env.envProd);
  Flavor.create(
    Environment.production,
    color: Colors.purple,
    name: "Prod",
  );

  setupApp();
}
