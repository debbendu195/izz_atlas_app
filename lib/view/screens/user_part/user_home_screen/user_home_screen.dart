import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/core/app_routes/app_routes.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_home_screen/widgets/custom_nearby_container.dart';

import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_nav_bar/navbar.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "ATLAS",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.userNotificationScreen);
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: AppColors.black,
                    size: 28,
                  ),
                ),
              ],
            ),
            CustomTextField(
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.greyLight,
              prefixIcon: Icon(Icons.search, color: AppColors.greyLight),
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.greyLight),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: "HI IZZ!",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    top: 16,
                  ),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Ready for your next adventure?",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    bottom: 20,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.userSearchVenueScreen);
                        },
                        child: CustomNetworkImage(
                          imageUrl: AppConstants.ntrition,
                          height: 220.h,
                          width: MediaQuery.sizeOf(context).width,
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: CustomText(
                            text: "SPORTS OF THE WEEK",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 10,
                        right: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "PICKLEBALL",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff111827),
                                    Color(0xff1F2937),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: CustomText(
                                text: "Book",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomNearbyContainer(
                    imageUrl: AppConstants.nearbyVenuesImage,
                    title: "NEARBY VENUES",
                  ),
                  CustomNearbyContainer(
                    imageUrl: AppConstants.allSportsImage,
                    title: "ALL SPORTS",
                    onTap: (){
                      Get.toNamed(AppRoutes.userAllSportsScreen);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 0),
    );
  }
}
