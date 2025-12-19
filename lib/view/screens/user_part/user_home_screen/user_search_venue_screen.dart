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
import 'model/all_sports_model.dart';

class UserSearchVenueScreen extends StatelessWidget {
  UserSearchVenueScreen({super.key});

  final UserAllSportsController userAllSportsController = Get.find<UserAllSportsController>();
  final String selectedSportsType = Get.arguments ?? "";

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(userAllSportsController.sportsVenueGroups.isEmpty){
        userAllSportsController.allSports();
      }
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
                  text: "RESULTS FOR '${selectedSportsType.isNotEmpty ? selectedSportsType : 'VENUE'}'",
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

            // --- Scrollable List Section ---
            Expanded(
              child: Obx(() {
                // 1. Loading Check
                if (userAllSportsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.black),
                  );
                }

                SportsVenueGroup? targetGroup;
                try {
                  targetGroup = userAllSportsController.sportsVenueGroups.firstWhere(
                        (group) => group.sportsType.toUpperCase() == selectedSportsType.toUpperCase(),
                  );
                } catch (e) {
                  targetGroup = null;
                }

                // 3. Empty State Logic
                if (targetGroup == null || targetGroup.venues.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: "No venues found for $selectedSportsType",
                      color: AppColors.greyLight,
                    ),
                  );
                }

                // 4. List Data Display (Specific Venues only)
                final venuesList = targetGroup.venues;

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: venuesList.length,
                  itemBuilder: (context, index) {
                    final venue = venuesList[index];

                    return CustomResultsVenueContainer(
                      venueName: venue.venueName,
                      sportName: venue.sportsType,
                      location: venue.location,
                      price: "RM ${venue.pricePerHour}/hr",
                      status: venue.venueStatus ? "Active" : "Booked",
                      rating: "0.0",
                      imageUrl: venue.venueImage,
                      onTap: () {
                        Get.toNamed(AppRoutes.userVenueDetailsScreen, arguments: venue);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}