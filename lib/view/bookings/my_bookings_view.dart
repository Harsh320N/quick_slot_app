import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_slot_app/data/response/status.dart';
import 'package:quick_slot_app/model/booking_model.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/view_model/bookings/my_bookings_view_model.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBookingsViewModel controller = Get.put(MyBookingsViewModel());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appbars(context, title: "My Bookings", onPressed: Get.back),
      body: Obx(() {
        final response = controller.bookings.value;
        if (response.state == Status.loading) {
          return loadingView();
        }
        if (response.state == Status.error) {
          return errorView(
            message: response.message ?? 'Something went wrong.',
            onRetry: controller.fetchBookings,
          );
        }
        final bookings = response.data ?? const <BookingModel>[];
        if (bookings.isEmpty) {
          return emptyView(
            message: "You have no bookings yet.",
            icon: Icons.event_busy_outlined,
          );
        }
        return RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: controller.fetchBookings,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: paddingSymmetric(horizontal: 20.0, vertical: 14.0),
            itemCount: bookings.length,
            separatorBuilder: (context, index) => verticalSpace(12.0),
            itemBuilder: (_, index) =>
                _bookingCard(context, controller, bookings[index]),
          ),
        );
      }),
    );
  }

  Widget _bookingCard(
    BuildContext context,
    MyBookingsViewModel controller,
    BookingModel booking,
  ) {
    return Container(
      padding: paddingAll(14.0),
      decoration: circularBoxDecoration(
        containerColor: AppColor.white,
        circularRadius: 14.0,
        border: Border.all(color: AppColor.dividerColor, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labels(
            text: booking.venueName,
            fontWeight: FontWeight.w700,
            size: 16.0,
          ),
          verticalSpace(8.0),
          _infoRow(Icons.calendar_today_rounded, _formatDate(booking.date)),
          verticalSpace(6.0),
          _infoRow(Icons.schedule_rounded, booking.timeRange),
          verticalSpace(6.0),
          _infoRow(
            Icons.location_on_outlined,
            "${booking.location}  ·  ${booking.sport}",
          ),
          verticalSpace(14.0),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(() {
              final loading = controller.cancellingId.value == booking.id;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: loading
                    ? null
                    : () => _confirmCancel(controller, booking),
                child: Container(
                  height: 38.0,
                  padding: paddingSymmetric(horizontal: 18.0),
                  alignment: Alignment.center,
                  decoration: circularBoxDecoration(
                    containerColor: AppColor.red.withValues(alpha: 0.08),
                    circularRadius: 9.0,
                    border: Border.all(
                      color: AppColor.red.withValues(alpha: 0.4),
                      width: 1.0,
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          height: 18.0,
                          width: 18.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: AppColor.red,
                          ),
                        )
                      : labels(
                          text: "Cancel",
                          color: AppColor.red,
                          fontWeight: FontWeight.w600,
                          size: 13.0,
                        ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15.0, color: AppColor.grey),
        horizontalSpace(8.0),
        Flexible(
          child: labels(text: text, color: AppColor.iconTextColor, size: 13.0),
        ),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      return DateFormat('EEE, dd MMM yyyy').format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  void _confirmCancel(MyBookingsViewModel controller, BookingModel booking) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: paddingAll(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labels(
                text: "Cancel booking?",
                fontWeight: FontWeight.w700,
                size: 18.0,
              ),
              verticalSpace(10.0),
              labels(
                text:
                    "${booking.venueName}, ${booking.timeRange} on ${_formatDate(booking.date)}",
                color: AppColor.grey,
                size: 13.5,
                maxLine: 3,
              ),
              verticalSpace(22.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        height: 48.0,
                        alignment: Alignment.center,
                        decoration: circularBoxDecoration(
                          containerColor: AppColor.lightModeColor,
                          circularRadius: 10.0,
                        ),
                        child: labels(
                          text: "Keep",
                          fontWeight: FontWeight.w600,
                          size: 15.0,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(12.0),
                  Expanded(
                    child: button(
                      text: "Cancel booking",
                      height: 48.0,
                      width: double.infinity,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      onTap: () {
                        Get.back();
                        controller.cancel(booking);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
