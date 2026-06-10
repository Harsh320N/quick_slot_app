import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';

Widget listTile({
  Widget leading = const SizedBox(),
  Widget title = const SizedBox(),
  Widget subTitle = const SizedBox(),
  Widget trailing = const SizedBox(),
  Widget threeLine = const SizedBox(),
  double spaceTitleSubTitle = 13.0,
  double spaceLeadingTitle = 10.0,
  double spaceSubTitleThreeLine = 0,
}) {
  return Row(
    children: [
      leading,
      horizontalSpace(spaceLeadingTitle),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title,
            verticalSpace(spaceTitleSubTitle),
            subTitle,
            verticalSpace(spaceSubTitleThreeLine),
            threeLine,
          ],
        ),
      ),
      trailing,
      horizontalSpace(13.0),
    ],
  );
}


Widget leadingTopListTile({
  Widget leading = const SizedBox(),
  Widget title = const SizedBox(),
  Widget subTitle = const SizedBox(),
  Widget trailing = const SizedBox(),
  Widget threeLine = const SizedBox(),
  double spaceTitleSubTitle = 13.0,
  double spaceTitleTrailing = 13.0,
  double spaceLeadingTitle = 25.0,
  double spaceSubTitleThreeLine = 0,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      leading,
      horizontalSpace(spaceLeadingTitle),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title,
            verticalSpace(spaceTitleSubTitle),
            subTitle,
            verticalSpace(spaceSubTitleThreeLine),
            threeLine,
          ],
        ),
      ),
      horizontalSpace(spaceTitleTrailing),
      trailing,
    ],
  );
}