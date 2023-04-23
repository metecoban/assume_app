import 'package:flutter/material.dart';

class CustomCardTheme {
  static CardTheme cardTheme({required Brightness brightness}) {
    return CardTheme(
        /*   color: brightness == Brightness.dark
            ? ColorConstant.instance.grey
            : ColorConstant.instance.light, */
        //shadowColor: ColorConstant.instance.mainColor,
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ));
  }
}
