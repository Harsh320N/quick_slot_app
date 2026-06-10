import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';

Decoration circularBoxDecoration({
  Color containerColor = AppColor.white,
  double? circularRadius,
  double? topLeftRadius,
  double? topRightRadius,
  double? bottomLeftRadius,
  double? bottomRightRadius,
  BoxBorder? border,
  Gradient? gradient,
  DecorationImage? decorationImage,
  List<BoxShadow>? boxShadow,
  BoxShape? boxShape,
}) =>
    BoxDecoration(
      color: containerColor,
      gradient: gradient,
      image: decorationImage,
      boxShadow: boxShadow,
      shape: boxShape ?? BoxShape.rectangle,
      borderRadius: boxShape == null
          ? BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius ?? circularRadius ?? 0),
              topRight: Radius.circular(topRightRadius ?? circularRadius ?? 0),
              bottomLeft:
                  Radius.circular(bottomLeftRadius ?? circularRadius ?? 0),
              bottomRight:
                  Radius.circular(bottomRightRadius ?? circularRadius ?? 0),
            )
          : null,
      border: border,
    );
