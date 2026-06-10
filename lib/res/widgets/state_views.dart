import 'package:flutter/material.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/utils/utils.dart';

Widget loadingView() => Center(child: Utils.loader());

Widget errorView({required String message, void Function()? onRetry}) => Center(
      child: Padding(
        padding: paddingAll(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColor.grey,
              size: 48.0,
            ),
            verticalSpace(12.0),
            labels(
              text: message,
              color: AppColor.grey,
              size: 14.0,
              maxLine: 3,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              verticalSpace(16.0),
              button(
                text: "Retry",
                width: 160.0,
                height: 44.0,
                fontWeight: FontWeight.w600,
                onTap: onRetry,
              ),
            ],
          ],
        ),
      ),
    );

Widget emptyView({
  required String message,
  IconData icon = Icons.inbox_outlined,
}) =>
    Center(
      child: Padding(
        padding: paddingAll(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColor.grey, size: 48.0),
            verticalSpace(12.0),
            labels(
              text: message,
              color: AppColor.grey,
              size: 14.0,
              maxLine: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
