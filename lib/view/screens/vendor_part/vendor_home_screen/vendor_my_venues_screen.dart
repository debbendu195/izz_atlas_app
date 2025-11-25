import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/screens/vendor_part/vendor_home_screen/widgets/custom_booking_card.dart';
import 'package:izz_atlas_app/view/screens/vendor_part/vendor_home_screen/widgets/custom_my_venues_main_card.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';

class VendorMyVenuesScreen extends StatelessWidget {
  const VendorMyVenuesScreen({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: CustomText(
                    text: "My Venues",
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.addVenueScreen);
                    },
                    height: 40,
                    fontSize: 14,
                    textColor: AppColors.white,
                    title: "+  ADD New",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            CustomMyVenuesMainCard(),
            CustomMyVenuesMainCard(title: "Urban Basketball Court",iconData: AppIcons.venues2,subTitle: "Kuala Lumpur, Malaysia",buttonText: "Inactive",),
            CustomMyVenuesMainCard(title: "Elite Badminton Hall",iconData: AppIcons.venues3,subTitle: "Chittagong, Bangladesh",buttonText: "Active",),
          ],
        ),
      ),
    );
  }
}
