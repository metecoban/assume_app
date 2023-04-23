import 'package:assume/core/constants/color_constants.dart';
import 'package:assume/core/init/theme/theme_widgets.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData theme({required Brightness brightness}) => ThemeData(
      colorScheme: ColorScheme.fromSwatch(brightness: brightness),
      scaffoldBackgroundColor: brightness == Brightness.dark
          ? ColorConstant.instance.dark
          : ColorConstant.instance.light,
      cardTheme: CustomCardTheme.cardTheme(brightness: brightness),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: brightness == Brightness.dark
            ? ColorConstant.instance.dark
            : ColorConstant.instance.light,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorConstant.instance.mainColor,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: brightness == Brightness.dark
            ? const CardTheme().color
            : ColorConstant.instance.light,
      ),
      textTheme: CustomTextTheme.textTheme(brightness: brightness),
      bottomNavigationBarTheme:
          CustomBottomNavBarTheme.bottomNavBar(brightness: brightness),
      appBarTheme: CustomAppBarTheme.appBarTheme(brightness: brightness),
      iconTheme: CustomIconTheme.iconTheme(),
      elevatedButtonTheme:
          CustomElevatedButtonTheme.elevatedButtonTheme(brightness: brightness),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorConstant.instance.mainColor,
      ));
}
