import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:flutter/material.dart';

class ColorConstant {
  static final ColorConstant _instance = ColorConstant._init();
  static ColorConstant get instance => _instance;
  ColorConstant._init();

  Color red = const Color(0xffFD0054);
  Color pink = Colors.pink;
  Color purple = Colors.purple;
  Color indigo = Colors.indigo;
  Color blue = Colors.blue;
  Color cyan = Colors.cyan;
  Color teal = Colors.teal;
  Color green = Colors.green;
  Color lime = Colors.lime;
  Color yellow = Colors.yellow;
  Color amber = Colors.amber;
  Color orange = Colors.orange;
  Color deepOrange = Colors.deepOrange;
  Color brown = Colors.brown;
  Color grey = Colors.grey;
  Color blueGrey = Colors.blueGrey;

  Color dark = const Color(0xFF282828);
  Color darkBottomNavbar = Colors.black12;
  Color light = Colors.white;

  Color transparent = const Color(0x00000000);

  colorList() {
    return <Color>[
      red,
      pink,
      purple,
      indigo,
      blue,
      cyan,
      teal,
      green,
      lime,
      yellow,
      amber,
      orange,
      deepOrange,
      brown,
      grey,
      blueGrey,
    ];
  }

  Color _mainColor = Color(SystemCacheService.instance.getMainColor());
  Color get mainColor => _mainColor;
  void changeMainColor(Color color) {
    _mainColor = color;
  }
}
