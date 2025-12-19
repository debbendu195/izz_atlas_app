import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_home_screen/user_home_controller/user_all_sports_controller.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class UserAllSportsScreen extends StatelessWidget {
  UserAllSportsScreen({super.key});

  final UserAllSportsController userAllSportsController = Get.put(UserAllSportsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "All Sports"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.greyLight,
              prefixIcon: Icon(Icons.search, color: AppColors.greyLight),
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.greyLight),
            ),
            SizedBox(height: 20),
            // Result and filter section
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

            // GridView অংশটি Obx দিয়ে র‍্যাপ করা হয়েছে
            Expanded(
              child: Obx(() {
                if (userAllSportsController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userAllSportsController.sportsVenueGroups.isEmpty) {
                  return const Center(child: Text("No sports found"));
                }

                return GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: userAllSportsController.sportsVenueGroups.length,
                  itemBuilder: (BuildContext context, int index) {
                    final sportGroup = userAllSportsController.sportsVenueGroups[index];

                    return GestureDetector(
                      onTap: () {
                        debugPrint("${sportGroup.sportsType.toUpperCase()}");
                        Get.toNamed(
                            AppRoutes.userSearchVenueScreen,
                            arguments: sportGroup.sportsType.toUpperCase()
                        );
                      },
                      child: Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl: (sportGroup.sportsImage != null && sportGroup.sportsImage!.isNotEmpty)
                                ? sportGroup.sportsImage!
                                : AppConstants.banner,
                            height: 190.h,
                            width: MediaQuery.sizeOf(context).width / 2.2,
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 10,
                            child: CustomText(
                              text: sportGroup.sportsType.toUpperCase(),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          )
                        ],
                      ),
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