import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_nav_bar/vendor_navbar.dart';
import '../../../components/custom_row_container/custom_row_container.dart';
import '../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../../../components/custom_text/custom_text.dart';

class VendorBookingRequestScreen extends StatelessWidget {
 const VendorBookingRequestScreen({super.key});

  //final vendorHomeController = Get.find<VendorBookingRequestScreen>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "My Booking Request",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomTabBar(
              tabs: ["Requests", "Completed"],
              textColor: AppColors.black,
              selectedColor: AppColors.primary,
              onTabSelected: (value) {},
              selectedIndex: 0,
              isTextColorActive: true,
              isPadding: true,
              unselectedColor: AppColors.black_80,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff111827), Color(0xff1F2937)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 80,
                            width: 80,
                            boxShape: BoxShape.circle,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                left: 8,
                                text: "Mehedi Bin Ab. Salam",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                              CustomText(
                                left: 8,
                                text: "2 hours ago",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textClr,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CustomText(
                          text: "Pending",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.map,
                        height: 20,
                        width: 20,
                      ),
                      CustomText(
                        left: 8,
                        text: "Westfield Sports Complex",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.footboll,
                        height: 20,
                        width: 20,
                      ),
                      CustomText(
                        left: 8,
                        text: "Football Field A",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.calender2,
                        height: 20,
                        width: 20,
                      ),
                      CustomText(
                        left: 8,
                        text: "Sep 25, 2024 • 6:00 PM - 7:00 PM",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            CustomText(
                              text: "Approve",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.black_05,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            CustomImage(imageSrc: AppIcons.cancel,height: 20,width: 20,),
                            CustomText(
                              text: "Decline",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.vendorBookingDetailsScreen);
                        },
                          child: CustomImage(imageSrc: AppIcons.eyeImage, height: 42, )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: VendorNavbar(currentIndex: 1),
    );

  }
}
