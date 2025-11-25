import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomMessagesListCard extends StatelessWidget {
  const CustomMessagesListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Color(0xff1F2937), Color(0xff4B5563)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.girlsPhoto,
                  height: 50,
                  width: 50,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "John Smith",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ), CustomText(
                      text: "Hello, are you here?",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  text: "1:20 PM",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  bottom: 10,
                ),
                CustomImage(
                  imageSrc: AppIcons.markIcon,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
