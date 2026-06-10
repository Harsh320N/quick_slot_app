import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/data/response/status.dart';
import 'package:quick_slot_app/model/slot_model.dart';
import 'package:quick_slot_app/model/venue_model.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/view_model/venues/venue_detail_view_model.dart';

class VenueDetailView extends StatelessWidget {
  const VenueDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final VenueModel venue = Get.arguments as VenueModel;
    final VenueDetailViewModel controller =
        Get.put(VenueDetailViewModel(venue));
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appbars(context, title: venue.name, onPressed: Get.back),
      body: Column(
        children: [
          _subHeader(venue),
          _dateSelector(context, controller),
          _legend(),
          divider(),
          Expanded(
            child: Obx(() {
              final response = controller.slots.value;
              if (response.state == Status.loading) {
                return loadingView();
              }
              if (response.state == Status.error) {
                return errorView(
                  message: response.message ?? 'Something went wrong.',
                  onRetry: controller.fetchSlots,
                );
              }
              final slots = response.data ?? const <SlotModel>[];
              if (slots.isEmpty) {
                return emptyView(message: "No slots for this date.");
              }
              return GridView.builder(
                padding: paddingSymmetric(horizontal: 20.0, vertical: 16.0),
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.55,
                ),
                itemCount: slots.length,
                itemBuilder: (_, index) => _slotChip(slots[index]),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _subHeader(VenueModel venue) {
    return Padding(
      padding: paddingOnly(left: 20.0, right: 20.0, top: 4.0, bottom: 14.0),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 16.0,
            color: AppColor.grey,
          ),
          horizontalSpace(4.0),
          Flexible(
            child: labels(
              text: "${venue.location}  ·  ${venue.sport}",
              color: AppColor.grey,
              size: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateSelector(BuildContext context, VenueDetailViewModel controller) {
    return Padding(
      padding: paddingSymmetric(horizontal: 20.0),
      child: Container(
        padding: paddingSymmetric(horizontal: 6.0, vertical: 4.0),
        decoration: circularBoxDecoration(
          containerColor: AppColor.lightModeColor,
          circularRadius: 12.0,
        ),
        child: Row(
          children: [
            Obx(
              () => iconButton(
                context,
                icon: Icons.chevron_left_rounded,
                color: controller.canGoPrev
                    ? AppColor.iconTextColor
                    : AppColor.grey,
                onPressed: controller.prevDay,
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _pickDate(context, controller),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 16.0,
                      color: AppColor.primaryColor,
                    ),
                    horizontalSpace(8.0),
                    Flexible(
                      child: Obx(
                        () => labels(
                          text: controller.displayDate,
                          fontWeight: FontWeight.w600,
                          size: 14.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            iconButton(
              context,
              icon: Icons.chevron_right_rounded,
              color: AppColor.iconTextColor,
              onPressed: controller.nextDay,
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend() {
    return Padding(
      padding: paddingSymmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        children: [
          _legendDot(AppColor.primaryColor, "Available"),
          horizontalSpace(20.0),
          _legendDot(AppColor.grey, "Booked"),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          height: 12.0,
          width: 12.0,
          decoration: circularBoxDecoration(
            containerColor: color,
            circularRadius: 4.0,
          ),
        ),
        horizontalSpace(6.0),
        labels(text: text, color: AppColor.grey, size: 12.0),
      ],
    );
  }

  Widget _slotChip(SlotModel slot) {
    final booked = slot.isBooked;
    return Container(
      alignment: Alignment.center,
      decoration: circularBoxDecoration(
        containerColor: booked ? AppColor.lightModeColor : AppColor.white,
        circularRadius: 10.0,
        border: Border.all(
          color: booked ? AppColor.dividerColor : AppColor.primaryColor,
          width: 1.3,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          labels(
            text: slot.startTime,
            color: booked ? AppColor.grey : AppColor.iconTextColor,
            fontWeight: FontWeight.w700,
            size: 15.0,
          ),
          verticalSpace(2.0),
          labels(
            text: booked ? "Booked" : "Available",
            color: booked ? AppColor.grey : AppColor.primaryColor,
            size: 10.0,
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    VenueDetailViewModel controller,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 60)),
    );
    if (picked != null) {
      controller.setDate(picked);
    }
  }
}
