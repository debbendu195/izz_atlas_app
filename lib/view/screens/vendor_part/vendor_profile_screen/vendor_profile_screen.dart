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
import '../../../components/custom_nav_bar/vendor_navbar.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.girlsPhoto,
                  height: 80,
                  width: 80,
                  boxShape: BoxShape.circle,
                  border: Border.all(color: Colors.amberAccent, width: 2),
                ),
                CustomText(
                  left: 8,
                  text: "Mehedi Bin Ab. Salam",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomProfileCard(
              nameTitle: "Chats",
              onTap: () {
                Get.toNamed(AppRoutes.vendorMessageListScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Edit Profile",
              onTap: () {
                Get.toNamed(AppRoutes.vendorEditProfileScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Notification",
              onTap: () {
                Get.toNamed(AppRoutes.vendorNotificationSettingScreen);
              },
            ),
            CustomProfileCard(
              nameTitle: "Account Settings",
              onTap: () {
                Get.toNamed(AppRoutes.vendorAccountSettings);
              },
            ),
            CustomProfileCard(
              nameTitle: "Help & support",
              onTap: () {
                Get.toNamed(AppRoutes.vendorHelpSupportScreen);
              },
            ),
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
                        "Are you sure you want to\n Vendor  Logout",
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
      bottomNavigationBar: VendorNavbar(currentIndex: 2),
    );
  }
}
