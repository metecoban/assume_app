import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashWidgets {
  Widget body(BuildContext context) {
    return Container(
      height: context.dynamicHeight(1),
      width: context.dynamicWidth(1),
      color: context.color.mainColor,
      child: Center(
        child: Image.asset(Assets.images.logo.path),
      ),
    );
  }
}
