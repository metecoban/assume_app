import 'package:assume/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextTheme textTheme({required Brightness brightness}) {
    return TextTheme(
      // Display => AppBar Title
      displayLarge: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.25,
          color: ColorConstant.instance.mainColor),
      displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.25,
          color: ColorConstant.instance.mainColor),
      // Headline
      headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
          color: brightness == Brightness.dark
              ? ColorConstant.instance.light
              : ColorConstant.instance.dark),
      headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
          color: brightness == Brightness.dark
              ? ColorConstant.instance.light
              : ColorConstant.instance.dark),
      headlineSmall: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.15),
      // Title => Button
      titleLarge: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      // Body
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: brightness == Brightness.dark
              ? ColorConstant.instance.light.withOpacity(0.7)
              : ColorConstant.instance.dark.withOpacity(0.7)),
      bodyMedium: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      // Label
      labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: ColorConstant.instance.mainColor),
      labelMedium: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      labelSmall: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    );
  }
}
