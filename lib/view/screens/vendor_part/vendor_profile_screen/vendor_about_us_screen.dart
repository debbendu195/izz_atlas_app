import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_loader/custom_loader.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'controller/vendor_profile_controller.dart';

class VendorAboutUsScreen extends StatelessWidget {
  const VendorAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final VendorProfileController controller = Get.put(VendorProfileController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "About Us",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
        child: Obx(() {
          // Show Loader
          if (controller.isLoading.value) {
            return const CustomLoader();
          }

          // Show message if no content
          if (controller.aboutUsContent.value.isEmpty) {
            return const Center(
              child: CustomText(
                text: "No About Us content found.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          }

          // Show Content
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomText(
                  text: controller.aboutUsContent.value,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  maxLines: 1000,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
