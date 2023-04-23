import 'package:assume/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomIconTheme {
  static IconThemeData iconTheme() {
    return IconThemeData(
      color: ColorConstant.instance.mainColor,
    );
  }
}
