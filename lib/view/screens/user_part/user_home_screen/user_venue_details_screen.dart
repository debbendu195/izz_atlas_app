import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_home_screen/user_home_controller/user_details_controller.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import 'model/user_venue_details_model.dart';

class UserVenueDetailsScreen extends StatelessWidget {
  UserVenueDetailsScreen({super.key});

  final controller = Get.put(UserVenueDetailsController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dynamic argument = Get.arguments;
      if (argument != null && argument is String && argument.isNotEmpty) {
        controller.getVenueDetails(argument);
      } else {
        debugPrint("Error: Venue ID not found or invalid format in arguments");
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Venue Details"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        if (controller.venueDetails.value == null) {
          return const Center(child: CustomText(text: "No venue details found."));
        }

        final venue = controller.venueDetails.value!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Venue Name
                CustomText(
                  text: venue.venueName,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),

                // Location
                CustomText(
                  text: venue.location,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6B7280),
                  bottom: 16,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),

                // Venue Image (Dynamic Check)
                CustomNetworkImage(
                  imageUrl: (venue.venueImage.isNotEmpty) ? venue.venueImage : AppConstants.banner,
                  height: 220,
                  width: MediaQuery.sizeOf(context).width,
                  borderRadius: BorderRadius.circular(17),
                ),

                SizedBox(height: 16),

                // Rating & Reviews (Dynamic Data Check)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "OPERATION HOURS: ",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        CustomText(
                          text: venue.venueRating.isNotEmpty ? venue.venueRating : "0.0",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                          right: 10,
                        ),
                        CustomText(
                          text: "(${venue.venueReviewCount} Review)",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Type, Status, Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff111827),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: CustomText(
                            text: venue.sportsType,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: venue.venueStatus ? Color(0xff22C55E) : Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: CustomText(
                            text: venue.venueStatus ? "Active" : "Inactive",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: "RM ${venue.pricePerHour}/hr",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // ================= UPDATED OPERATION HOURS SECTION =================
                // এখন সব স্লট আলাদা আলাদা দেখাবে
                if (venue.venueAvailabilities.isNotEmpty)
                  ...venue.venueAvailabilities.map((availability) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Day Name (e.g., SUNDAY)
                          CustomText(
                            text: availability.day,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),

                          // Time Slots List (e.g., 09:00 AM - 10:00 AM)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: availability.scheduleSlots.isEmpty
                                  ? [
                                CustomText(
                                  text: "Closed",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                )
                              ]
                                  : availability.scheduleSlots.map((slot) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: CustomText(
                                    text: "${slot.from} - ${slot.to}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                // ================= END UPDATED SECTION =================

                SizedBox(height: 16),

                /// -------- AMENITIES --------
                QuickButton(
                  text: "AMENITIES",
                  onTap: controller.toggleAmenities,
                ),
                const SizedBox(height: 6),
                Obx(() => controller.isAmenitiesOpen.value
                    ? amenitiesWidget(venue.amenities)
                    : const SizedBox()),

                const SizedBox(height: 16),

                /// -------- VENUE INFO --------
                QuickButton(
                  text: "VENUE INFORMATION",
                  onTap: controller.toggleVenueInfo,
                ),
                const SizedBox(height: 6),
                Center(child: CustomImage(imageSrc: AppIcons.arrowDown)),

                Obx(() => controller.isVenueInfoOpen.value
                    ? venueInformationWidget(venue.description)
                    : const SizedBox()),

                const SizedBox(height: 20),

                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.bookYourSlotScreen, arguments: venue);
                  },
                  title: "BOOK NOW",
                  textColor: AppColors.white,
                ),

                const SizedBox(height: 16),

                CustomButtonTwo(
                  onTap: () {},
                  title: "CHAT WITH VENDOR",
                  textColor: AppColors.blue,
                  fillColor: AppColors.white,
                  borderColor: AppColors.blue,
                  borderWidth: 1,
                  isBorder: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }
}

/// ================= Helper Widgets (Same as before) =================
Widget amenitiesWidget(List<Amenity> amenities) {
  if (amenities.isEmpty) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CustomText(text: "No amenities listed"),
    );
  }
  return Column(
    children: [
      const SizedBox(height: 16),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: amenities.map((amenity) => _amenityItem(amenity.amenityName)).toList(),
      ),
    ],
  );
}

Widget _amenityItem(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xff111827), Color(0xff1F2937)],
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_outline, color: AppColors.white, size: 18),
        CustomText(
          left: 8,
          text: title,
          fontSize: 14,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}

Widget venueInformationWidget(String description) {
  return Column(
    children: [
      const SizedBox(height: 16),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff1F2937),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CustomText(
          text: description,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
          maxLines: 10,
          textAlign: TextAlign.start,
        ),
      ),
    ],
  );
}

class QuickButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const QuickButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyLight,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}