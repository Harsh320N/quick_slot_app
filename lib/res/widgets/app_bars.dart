import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/icons/app_icon.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';

//TODO: APPBAR FOR DASHBOARD
AppBar dashboardAppBar(BuildContext context,{
  Widget title = const SizedBox(),
  void Function()? onPressed,
}) =>
    AppBar(
      automaticallyImplyLeading: false,
      title: title,
      backgroundColor: AppColor.transparent,
      elevation: 0,
      centerTitle: true,
    );

//TODO: APPBAR FOR SCREENS
AppBar appbars(BuildContext context,{
  String title = "",
  void Function()? onPressed,
}) =>
    AppBar(
      leading: iconButton(context,
        onPressed: onPressed ??
            () {
            },
        color: Theme.of(context).iconTheme.color!,
        icon: AppIcons.icArrowBackIosRounded,
        size: 28.0,
      ),
      title: labels(
        text: title,
        color: Theme.of(context).iconTheme.color!,
        fontWeight: FontWeight.w700,
        size: 20.0,
      ),
      backgroundColor: AppColor.transparent,
      elevation: 0,
      centerTitle: true,
    );
