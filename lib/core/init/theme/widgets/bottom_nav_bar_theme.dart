import 'package:assume/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBarTheme {
  static BottomNavigationBarThemeData bottomNavBar(
      {required Brightness brightness}) {
    return const BottomNavigationBarThemeData().copyWith(
      type: BottomNavigationBarType.fixed, // Fixed

      backgroundColor: brightness == Brightness.dark
          ? ColorConstant.instance.darkBottomNavbar
          : ColorConstant.instance.light,
      selectedItemColor: ColorConstant.instance.mainColor,
      unselectedItemColor: brightness == Brightness.dark
          ? ColorConstant.instance.light
          : ColorConstant.instance.dark,
    );
  }
}
