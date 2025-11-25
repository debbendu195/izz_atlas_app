import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';

class UserNotificationScreen extends StatelessWidget {
  const UserNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Notification"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                //border: Border.all(color: AppColors.red),
                borderRadius: BorderRadius.circular(13),
                gradient: LinearGradient(
                  colors: [
                    AppColors.black,
                    Color(0xff111827),
                    Color(0xff1F2937),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        "Sarah Johnson booked Conference Room A for tomorrow 2-4 PM. Payment confirmed.",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    bottom: 8,
                  ),
                  CustomText(text: "Fri, 12 am",
                    fontSize: 10.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    textAlign: TextAlign.start,
               )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
