import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_nav_bar/vendor_navbar.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../user_part/user_home_screen/user_venue_details_screen.dart';
import '../vendor_profile_screen/controller/vendor_profile_controller.dart';
import 'controller/vendor_controller.dart';



class VendorHomeScreen extends StatelessWidget {
  VendorHomeScreen({super.key});

  // Initialize controller
  final VendorHomeController controller = Get.put(VendorHomeController());
  final VendorProfileController vendorProfileController = Get.put(VendorProfileController());

  @override
  Widget build(BuildContext context) {
    // Call API once per screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vendorProfileController.getUserProfile();
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, right: 16, left: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Dashboard",
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

              // Welcome text (Reactive)
              Obx(() {
                final name = vendorProfileController.userProfileModel.value.name ?? "";
                return CustomText(
                  text: "Welcome Back, $name",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  bottom: 20,
                );
              }),

              // Dashboard cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDashboardCard("Total Bookings", "128", "This month"),
                  _buildDashboardCard("Total Earnings", "85,200", "This month"),
                ],
              ),

              CustomText(
                text: "Quick Actions",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                top: 16,
                bottom: 20,
              ),

              QuickButton(
                text: "+ADD VENUE",
                onTap: () {
                  Get.toNamed(AppRoutes.addVenueScreen);
                },
              ),
              SizedBox(height: 20),
              QuickButton(
                text: "MY VENUES",
                onTap: () {
                  Get.toNamed(AppRoutes.vendorMyVenuesScreen);
                },
              ),
              SizedBox(height: 20),

              // Toggle button for Earnings Trend chart (Reactive)
              QuickButton(
                text: "EARNINGS TREND",
                onTap: controller.toggleChart,
              ),
              Obx(() => controller.isChartVisible.value
                  ? _buildEarningsChart()
                  : SizedBox()
              ),

              SizedBox(height: 20),
              QuickButton(
                text: "BOOKINGS TREND",
                onTap: () {},
              ),
              Center(child: CustomImage(imageSrc: AppIcons.arrowDown)),
              SizedBox(height: 20),
              CustomText(
                text: "Recent Activity",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                top: 16,
                bottom: 20,
              ),
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: VendorNavbar(currentIndex: 0),
    );
  }

  Widget _buildDashboardCard(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff111827), Color(0xff1F2937)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textClr,
          ),
          CustomText(
            text: value,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          CustomText(
            text: subtitle,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textClr,
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsChart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CustomText(
            text: "Earnings Trend Chart (Placeholder)",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: CustomText(
                text: "Chart Goes Here",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff111827), Color(0xff1F2937)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Football Ground A",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              CustomText(
                text: "10:00 AM - 12:00 PM",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textClr,
              ),
              CustomText(
                text: "John Smith",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textClr,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.green2.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: CustomText(
              text: "CONFIRMED",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.green2,
            ),
          ),
        ],
      ),
    );
  }
}

