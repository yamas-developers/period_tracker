import 'package:flutter/material.dart';
import 'package:period_tracker/utils/constants.dart';

class ThemeClass{
  Color mainColor=Color(0xff5a5ad4);
  Color darkMainColor=Color(0xffffffff);
  Color fontColor=Colors.black87;
  Color darkFontColor=bgColor;
static ThemeData lightTheme=ThemeData(
  primaryColor: ThemeData.light().scaffoldBackgroundColor,
  colorScheme: ColorScheme.light().copyWith(
    primary: _themeClass.mainColor,
    secondary: _themeClass.fontColor,
  ),
);
static ThemeData darkTheme=ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: ColorScheme.dark().copyWith(
        primary: _themeClass.darkMainColor,
        secondary: _themeClass.darkFontColor
    ));
}
ThemeClass _themeClass=ThemeClass();