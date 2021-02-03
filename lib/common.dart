import 'package:flutter/material.dart';

class CommonColors {
  CommonColors._();

  static int boxInsetBackground = 0xFFC06C4C;
  static int listHeader = 0xFF9E5235;
  static int lightBorder = 0x5FEFCBBA;
  static int darkBorder = 0x5A000000;
}

class CommonText {
  CommonText._();

  static TextStyle panelTitle =
      TextStyle(fontSize: 18, height: 1, color: Colors.white);
  static TextStyle itemTitle =
      TextStyle(color: Colors.white, fontSize: 14, height: 1.2);
  static TextStyle itemSubtitle =
      TextStyle(color: Colors.white, fontSize: 14, height: 1.5);
}

class Common {
  Common._();

  static Border insetBorder = Border(
      right: BorderSide(color: Color(CommonColors.lightBorder), width: 4.0),
      bottom: BorderSide(color: Color(CommonColors.lightBorder), width: 4.0),
      left: BorderSide(color: Color(CommonColors.darkBorder), width: 4.0),
      top: BorderSide(color: Color(CommonColors.darkBorder), width: 4.0));
}
