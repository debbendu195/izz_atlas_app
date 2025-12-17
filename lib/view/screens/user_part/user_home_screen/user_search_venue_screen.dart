import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_home_screen/user_home_controller/user_all_sports_controller.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_home_screen/widgets/custom_results_venue_container.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class UserSearchVenueScreen extends StatelessWidget {
  UserSearchVenueScreen({super.key});

  final UserAllSportsController userAllSportsController = Get.put(UserAllSportsController());
  final String sportsType = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userAllSportsController.allSports();
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Search"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // --- Fixed Header Section (Search & Filter) ---
            CustomTextField(
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.greyLight,
              prefixIcon: Icon(Icons.search, color: AppColors.greyLight),
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.greyLight),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "RESULTS FOR 'VENUE'",
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
                Row(
                  children: [
                    CustomImage(
                      imageSrc: AppIcons.filterIcon,
                      height: 20,
                      width: 20,
                    ),
                    CustomText(
                      text: "FILTERS",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            // --- Scrollable List Section with Pagination ---
            Expanded(
              child: Obx(() {
                // 1. Initial Loading State
                if (userAllSportsController.isLoading.value && userAllSportsController.sportsVenueGroups.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.black),
                  );
                }

                // 2. Empty Data State
                if (userAllSportsController.sportsVenueGroups.isEmpty && !userAllSportsController.isLoading.value) {
                  return Center(
                    child: CustomText(
                      text: "No venues found",
                      color: AppColors.greyLight,
                    ),
                  );
                }

                // 3. List Data with Pagination
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!userAllSportsController.isLoadMore.value &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                        userAllSportsController.currentPage < userAllSportsController.totalPage) {

                      userAllSportsController.allSports(loadMore: true);
                    }
                    return true;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 20),
                    itemCount: userAllSportsController.sportsVenueGroups.length +
                        (userAllSportsController.isLoadMore.value ? 1 : 0),
                    itemBuilder: (context, index) {

                      // Bottom Loader Logic
                      if (index >= userAllSportsController.sportsVenueGroups.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(color: AppColors.black),
                          ),
                        );
                      }

                      // Data Binding
                      final group = userAllSportsController.sportsVenueGroups[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: group.venues.map((venue) {
                          return CustomResultsVenueContainer(
                            venueName: venue.venueName,
                            sportName: venue.sportsType,
                            location: venue.location,
                            price: "RM ${venue.pricePerHour}/hr",
                            status: venue.venueStatus ? "Active" : "Booked",
                            rating: "4.5",
                            imageUrl: venue.venueImage,
                            onTap: () {
                              Get.toNamed(AppRoutes.userVenueDetailsScreen);
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}