import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/data/response/status.dart';
import 'package:quick_slot_app/model/venue_model.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/view_model/venues/venue_list_view_model.dart';

class VenueListView extends StatelessWidget {
  const VenueListView({super.key});

  @override
  Widget build(BuildContext context) {
    final VenueListViewModel controller = Get.put(VenueListViewModel());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        elevation: 0,
        titleSpacing: 20.0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labels(text: "Venues", fontWeight: FontWeight.w700, size: 20.0),
            verticalSpace(2.0),
            labels(text: controller.greeting, color: AppColor.grey, size: 12.0),
          ],
        ),
        actions: [
          iconButton(
            context,
            icon: Icons.logout_rounded,
            color: AppColor.iconTextColor,
            onPressed: controller.logout,
          ),
        ],
      ),
      body: Obx(() {
        final response = controller.venues.value;
        if (response.state == Status.loading) {
          return loadingView();
        }
        if (response.state == Status.error) {
          return errorView(
            message: response.message ?? 'Something went wrong.',
            onRetry: controller.fetchVenues,
          );
        }
        final venues = response.data ?? const <VenueModel>[];
        if (venues.isEmpty) {
          return emptyView(
            message: "No venues available right now.",
            icon: Icons.stadium_outlined,
          );
        }
        return RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: controller.fetchVenues,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: paddingSymmetric(horizontal: 20.0, vertical: 14.0),
            itemCount: venues.length,
            separatorBuilder: (context, index) => verticalSpace(12.0),
            itemBuilder: (_, index) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => controller.openVenue(venues[index]),
              child: _venueCard(venues[index]),
            ),
          ),
        );
      }),
    );
  }

  Widget _venueCard(VenueModel venue) {
    return Container(
      padding: paddingAll(14.0),
      decoration: circularBoxDecoration(
        containerColor: AppColor.white,
        circularRadius: 14.0,
        border: Border.all(color: AppColor.dividerColor, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            height: 46.0,
            width: 46.0,
            alignment: Alignment.center,
            decoration: circularBoxDecoration(
              containerColor:
                  AppColor.primaryColor.withValues(alpha: 0.10),
              circularRadius: 12.0,
            ),
            child: Icon(
              _sportIcon(venue.sport),
              color: AppColor.primaryColor,
              size: 24.0,
            ),
          ),
          horizontalSpace(14.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labels(
                  text: venue.name,
                  fontWeight: FontWeight.w700,
                  size: 16.0,
                ),
                verticalSpace(5.0),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14.0,
                      color: AppColor.grey,
                    ),
                    horizontalSpace(4.0),
                    Flexible(
                      child: labels(
                        text: venue.location,
                        color: AppColor.grey,
                        size: 12.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          horizontalSpace(8.0),
          _sportChip(venue.sport),
        ],
      ),
    );
  }

  Widget _sportChip(String sport) {
    return Container(
      padding: paddingSymmetric(horizontal: 10.0, vertical: 5.0),
      decoration: circularBoxDecoration(
        containerColor: AppColor.secondaryColor.withValues(alpha: 0.18),
        circularRadius: 20.0,
      ),
      child: labels(
        text: sport,
        color: AppColor.iconTextColor,
        fontWeight: FontWeight.w600,
        size: 11.0,
      ),
    );
  }

  IconData _sportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'badminton':
        return Icons.sports_tennis;
      case 'football':
        return Icons.sports_soccer;
      case 'cricket':
        return Icons.sports_cricket;
      default:
        return Icons.sports;
    }
  }
}
