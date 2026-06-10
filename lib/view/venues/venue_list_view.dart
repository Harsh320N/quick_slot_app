import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: labels(
          text: "Venues",
          fontWeight: FontWeight.w700,
          size: 20.0,
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
      body: Center(
        child: labels(
          text: "Venues coming soon",
          color: AppColor.grey,
          size: 14.0,
        ),
      ),
    );
  }
}
