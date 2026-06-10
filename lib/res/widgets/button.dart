import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/utils/utils.dart';

//TODO: SIMPLE BUTTON BASED ON PRIMARY COLOR OF APPLICATION
Widget button({
  required String text,
  void Function()? onTap,
  double height = 50.0,
  double width = 400.0,
  Color fontColor = AppColor.white,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 16.0,
  bool loading = false,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: circularBoxDecoration(
          circularRadius: 10.0,
          containerColor: AppColor.primaryColor,
        ),
        child: loading
            ? Center(
            child: Utils.loader()
        )
            : Center(
          child: labels(
            text: text,
            color: fontColor,
            fontWeight: fontWeight,
            size: fontSize,
          ),
        ),
      ),
    );

//TODO: ICON BUTTON
Widget iconButton(BuildContext context, {
  void Function()? onPressed,
  double size = 24.0,
  IconData? icon,
  Color color = AppColor.iconTextColor,
}) =>
    IconButton(
      onPressed: onPressed,
      icon: icons(
        context,
        icon: icon!,
        size: size,
        color: color,
      ),
      splashColor: AppColor.transparent,
      hoverColor: AppColor.transparent,
      focusColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
    );

//TODO: TEXT BUTTON
Widget textButton({
  Widget child = const SizedBox(),
  void Function()? onPressed,
}) =>
    TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.focused)) {
                return AppColor.transparent;
              }
              if (states.contains(WidgetState.hovered)) {
                return AppColor.transparent;
              }
              if (states.contains(WidgetState.pressed)) {
                return AppColor.transparent;
              }
              return AppColor.white;
            }),
      ),
      child: child,
    );