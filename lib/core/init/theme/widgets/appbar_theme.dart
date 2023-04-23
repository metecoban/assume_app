import 'package:assume/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomAppBarTheme {
  static AppBarTheme appBarTheme({required Brightness brightness}) {
    return AppBarTheme(
      backgroundColor: brightness == Brightness.dark
          ? ColorConstant.instance.dark
          : ColorConstant.instance.light,
     
      elevation: 0,
      centerTitle: true,
      titleTextStyle: ThemeData().textTheme.headlineMedium,
      iconTheme: IconThemeData(color: ColorConstant.instance.mainColor),
    );
  }
}
