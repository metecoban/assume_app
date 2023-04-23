import 'package:assume/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme(
      {required Brightness brightness}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstant.instance.mainColor,
        side: BorderSide(
            color: brightness == Brightness.dark
                ? ColorConstant.instance.light
                : ColorConstant.instance.dark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
