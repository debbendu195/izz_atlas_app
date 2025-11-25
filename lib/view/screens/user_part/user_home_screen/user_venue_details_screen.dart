import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_image/custom_image.dart';

class UserVenueDetailsScreen extends StatefulWidget {
  const UserVenueDetailsScreen({super.key});

  @override
  State<UserVenueDetailsScreen> createState() => _UserVenueDetailsScreenState();
}

class _UserVenueDetailsScreenState extends State<UserVenueDetailsScreen> {
  // Variable to track chart visibility
  bool _isrouting = false;
  bool _isvenueInformation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Venue Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "PICKLE POINT",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: "12,JALAN TIPU,40150,LAS VEGAS, KAMPUNG BARU, KUALA LOCO",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                maxLines: 3,
                textAlign: TextAlign.start,
                color: Color(0xff6B7280),
                bottom: 16,
              ),
              CustomNetworkImage(
                imageUrl: AppConstants.banner,
                height: 220,
                width: MediaQuery.sizeOf(context).width,
                borderRadius: BorderRadius.circular(17),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "OPERATION HOURS: ",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      CustomText(
                        text: "4.8",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber,
                        right: 10,
                      ),
                      CustomText(
                        text: "(8 Review)",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff111827),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: CustomText(
                          text: "Football",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff22C55E),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: CustomText(
                          text: "Active",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: "RM 120/hr",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: 16),
              CustomText(
                text: "10 AM - 12 AM (WEEKDAYS)",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                bottom: 8,
              ),
              CustomText(
                text: "10AM - 2 AM (WEEKENDS)",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                bottom: 20,
              ),
              QuickButton(
                text: "AMENITIES",
                onTap: () {
                  setState(() {
                    _isrouting = !_isrouting;
                  });
                },
              ),
              SizedBox(height: 6),
              Center(child: CustomImage(imageSrc: AppIcons.arrowDown)),
              SizedBox(height: 16),
              if (_isrouting) _amenities(),
              QuickButton(
                text: "VENUE INFORMATION",
                onTap: () {
                  setState(() {
                    _isvenueInformation = !_isvenueInformation;
                  });
                },
              ),
              SizedBox(height: 6),
              Center(child: CustomImage(imageSrc: AppIcons.arrowDown)),
              if (_isvenueInformation) _venueInformation(),
              SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.bookYourSlotScreen);
                },
                title: "BOOK NOW",
                textColor: AppColors.white,
              ),
              SizedBox(height: 16),
              CustomButtonTwo(
                onTap: (){

                },
                title: "CHAT WITH VENDOR",
                textColor: AppColors.blue,
                fillColor: AppColors.white,
                borderColor: AppColors.blue,
                borderWidth: 1,
                isBorder: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

//===============Down Slider

Widget _amenities() {
  return Column(
    children: [
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff111827), Color(0xff1F2937)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomImage(imageSrc: AppIcons.wifi),
                CustomText(
                  left: 8,
                  text: "Wi-Fi",
                  fontSize: 14,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff111827), Color(0xff1F2937)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomImage(imageSrc: AppIcons.wifi2),
                CustomText(
                  left: 8,
                  text: "Wi-Fi",
                  fontSize: 14,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff111827), Color(0xff1F2937)],
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                CustomImage(imageSrc: AppIcons.wifi3),
                CustomText(
                  left: 8,
                  text: "Parking",
                  fontSize: 14,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _venueInformation() {
  return Column(
    children: [
      SizedBox(height: 16),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xff1F2937),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CustomText(
          text:
              "We were only sad not to stay longer. We hope to be back to explore Nantes some more and woul)",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
          textAlign: TextAlign.start,
          maxLines: 5,
        ),
      ),
    ],
  );
}

class QuickButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  const QuickButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: AppColors.white,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyLight,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: CustomText(
              text: text ?? "",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
