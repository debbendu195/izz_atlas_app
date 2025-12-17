import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_loader/custom_loader.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'controller/vendor_profile_controller.dart';

class VendorTermsScreen extends StatelessWidget {
  const VendorTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final VendorProfileController controller = Get.put(VendorProfileController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Terms of Conditions",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
        child: Obx(() {
          // Show Loader while fetching
          if (controller.isLoading.value) {
            return const CustomLoader();
          }

          // Show Message if content is empty
          if (controller.termsContent.value.isEmpty) {
            return const Center(
              child: CustomText(
                text: "No Terms and Conditions found.",
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
                  text: controller.termsContent.value,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  maxLines: 1000, // Increase max lines to show full text
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