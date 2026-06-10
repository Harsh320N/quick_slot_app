import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';

//TODO: HORIZONTAL DIVIDER
Widget divider({
  Color color = AppColor.dividerColor,
  double thickness = 1.0,
  double height = 1.0,
}) =>
    Divider(
      color: color,
      thickness: thickness,
      height: height,
    );

//TODO: VERTICAL DIVIDER
Widget verticalDivider({
  Color color = AppColor.dividerColor,
  double thickness = 1.0,
  double width = 1.0,
}) =>
    VerticalDivider(
      color: color,
      thickness: thickness,
      width: width,
    );