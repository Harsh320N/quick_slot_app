import 'package:flutter/material.dart';

Widget icons(BuildContext context,{
  required IconData icon,
  Color? color,
  double size = 24.0,
}) =>
    Icon(
      icon,
      color: color ?? Theme.of(context).iconTheme.color!,
      size: size,
    );
