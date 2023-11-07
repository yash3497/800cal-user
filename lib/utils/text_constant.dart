import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle bodyText12(FontWeight fontWeight, Color color) =>
    TextStyle(fontSize: 12, color: color, fontWeight: fontWeight);

TextStyle bodyText14(FontWeight fontWeight, Color color) =>
    TextStyle(fontSize: 14, color: color, fontWeight: fontWeight);

TextStyle bodyText18(FontWeight fontWeight, Color color) =>
    TextStyle(fontSize: 18, color: color, fontWeight: fontWeight);

TextStyle bodyText20(FontWeight fontWeight, Color color) =>
    TextStyle(fontSize: 20, color: color, fontWeight: fontWeight);

TextStyle appBarStyle() => TextStyle(
      color: AppColor.whiteColor,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );
