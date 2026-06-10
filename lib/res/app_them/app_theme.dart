import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';

class AppTheme {
  //TODO: DARK MODE THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkModeColor,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColor.white),
  );

  //TODO: LIGHT MODE THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.lightModeColor,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColor.iconTextColor),
  );
}
