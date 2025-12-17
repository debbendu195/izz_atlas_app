import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_loader/custom_loader.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'controller/vendor_profile_controller.dart'; // কন্ট্রোলার ইম্পোর্ট করুন

class VendorPrivacyScreen extends StatefulWidget {
  const VendorPrivacyScreen({super.key});

  @override
  State<VendorPrivacyScreen> createState() => _VendorPrivacyScreenState();
}

class _VendorPrivacyScreenState extends State<VendorPrivacyScreen> {
  // কন্ট্রোলার ইনিশিলাইজ
  final VendorProfileController controller = Get.put(VendorProfileController());

  @override
  void initState() {
    super.initState();
    // স্ক্রিন ওপেন হওয়ার সাথে সাথে ডাটা ফেচ করবে
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPrivacyPolicy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Privacy Policy",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
        child: Obx(() {
          // ১. লোডিং অবস্থা চেক
          if (controller.isLoading.value) {
            return const CustomLoader();
          }

          // ২. ডাটা না থাকলে মেসেজ দেখানো
          if (controller.privacyContent.value.isEmpty) {
            return const Center(
              child: CustomText(
                text: "No Privacy Policy found.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          }

          // ৩. ডাটা থাকলে দেখানো
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomText(
                  text: controller.privacyContent.value,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  maxLines: 1000, // পুরো টেক্সট দেখানোর জন্য
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