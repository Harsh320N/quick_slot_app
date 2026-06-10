import 'package:flutter/material.dart';

//TODO: PADDING ONLY
EdgeInsetsGeometry paddingOnly({
  double top = 0,
  double right = 0,
  double bottom = 0,
  double left = 0,
}) =>
    EdgeInsets.only(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );

//TODO: PADDING SYMMETRIC
EdgeInsetsGeometry paddingSymmetric({
  double horizontal = 0,
  double vertical = 0,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );

//TODO: PADDING ALL
EdgeInsetsGeometry paddingAll(double all) => EdgeInsets.all(all);