import 'package:flutter/material.dart';

const Color mainColor = Colors.pinkAccent;
final Color mainColorLight = Color(0xffefa2ac);

const Color accentColor = Color(0xff5a5ad4);
const Color ovulationColor = Color(0xffd3f5ff);
const Color fontColor = Colors.black87;
const Color fontLightColor = Colors.black45;
const Color ovulationBgColor = Color(0xff8cdff9);
const Color ovulationDayColor = Color(0xff48caf3);
const Color greyDisabledColor = Color(0xffd0d0d0);
const Color greyFontColor = Color(0xff757373);
const Color greyBgColor = Color(0xfff4f4f4);
const Color bgColor = Color(0xffffffff);

MaterialColor primarySwatch = MaterialColor(
  accentColor.value,
  <int, Color>{
    50: accentColor.withOpacity(0.1),
    100: accentColor.withOpacity(0.2),
    200: accentColor.withOpacity(0.3),
    300: accentColor.withOpacity(0.4),
    400: accentColor.withOpacity(0.5),
    500: accentColor.withOpacity(0.6),
    600: accentColor.withOpacity(0.7),
    700: accentColor.withOpacity(0.8),
    800: accentColor.withOpacity(0.9),
    900: accentColor.withOpacity(1.0),
  },
);

const String home_screen = 'home';
const String profile_screen = 'profile';
const String settings = 'settings';
const String calendar = 'calendar';
const String ovulation = 'ovulation';
const String ovulationDay = 'ovulationDay';
const String ovulationMonth = 'ovulationMonth';
const String ovulationDayMonth = 'ovulationDayMonth';
