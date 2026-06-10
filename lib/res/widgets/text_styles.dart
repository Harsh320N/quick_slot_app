import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';

//TODO: TEXT
Widget labels({
  required String text,
  Color color = AppColor.iconTextColor,
  FontWeight fontWeight = FontWeight.normal,
  double? height,
  double size = 16.0,
  double letterSpacing = 0.5,
  int maxLine = 1,
  TextAlign? textAlign,
  TextDecoration? decoration,
  String fontFamily = "Amaranth",
  TextOverflow overflow = TextOverflow.ellipsis,
  double wordSpacing = 0,
  Color decorationColor = AppColor.transparent,
}) =>
    Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      textScaler: const TextScaler.linear(1.0),
      style: defaultTextStyle(
        color: color,
        fontWeight: fontWeight,
        height: height,
        size: size,
        letterSpace: letterSpacing,
        decoration: decoration,
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
        decorationColor: decorationColor,
      ),
    );

//TODO: TEXT STYLE
TextStyle defaultTextStyle({
  Color color = AppColor.iconTextColor,
  Color decorationColor = AppColor.transparent,
  double? height,
  double size = 14.0,
  double? wordSpacing,
  double? letterSpace,
  String fontFamily = "Amaranth",
  FontWeight fontWeight = FontWeight.normal,
  TextDecoration? decoration,
}) =>
    TextStyle(
      color: color,
      height: height,
      fontSize: size,
      letterSpacing: letterSpace,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      decoration: decoration,
      wordSpacing: wordSpacing,
      decorationColor: decorationColor,
      decorationThickness: 2.0,
    );