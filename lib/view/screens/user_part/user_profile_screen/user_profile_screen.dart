import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/core/app_routes/app_routes.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_nav_bar/navbar.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_profile_screen/widgets/custom_profile_card.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_logout_popup/custom_logout_popup.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.girlsPhoto,
                      height: 80,
                      width: 80,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: Colors.amberAccent, width: 2),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -16,
                      child: CustomImage(imageSrc: AppIcons.powerIcon),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Alexa Pia",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff1F2937), Color(0xff4B5563)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              //   CustomImage(imageSrc: ""),
                              CustomText(
                                text: "Level 5",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.amberAccent,
                              ),
                            ],
                          ),
                        ),
                        CustomText(
                          left: 12,
                          text: "Weekend Warrior",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              color: AppColors.greyLight,
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "XP: 1,250 / 1,500 to Level 6",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.userCollectScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        //   CustomImage(imageSrc: ""),
                        CustomText(
                          text: "Collect",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomProfileCard(
              nameTitle: "Chats",
              onTap: () {
                Get.toNamed(AppRoutes.userMessageListScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Edit Profile",
              onTap: () {
                Get.toNamed(AppRoutes.userEditProfileScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Notification",
              onTap: () {
                Get.toNamed(AppRoutes.userNotificationSettingScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Account Settings",
              onTap: () {
                Get.toNamed(AppRoutes.userAccountSettings);
              },
            ),
            CustomProfileCard(nameTitle: "Help & support", onTap: () {
              Get.toNamed(AppRoutes.userHelpSupportScreen);
            },),

            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.white,
                    insetPadding: EdgeInsets.all(8),
                    contentPadding: EdgeInsets.all(8),
                    content: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: CustomShowDialog(
                        textColor: AppColors.black,
                        buttonTextColor: AppColors.white,
                        title: "Logout Your Account",
                        discription:
                        "Are you sure you want to\nUser Logout",
                        showRowButton: true,
                        showCloseButton: true,
                        leftTextButton: "Yes",
                        rightTextButton: "No",
                        leftOnTap: (){
                          Get.toNamed(AppRoutes.frameScreen);
                        },
                        rightOnTap: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Color(0xffEF4444), Color(0xff1E1E1E)],
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Logout",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 2),
    );
  }
}
