import 'package:flutter/material.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button.dart';
import 'package:izz_atlas_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text/custom_text.dart';

class AddVenueScreen extends StatelessWidget {
  AddVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Edit Venu"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.banner,
                height: 192,
                width: MediaQuery.sizeOf(context).width,
              ),
              SizedBox(height: 16),
              CustomFormCard(
                title: "Venue Name",
                hintText: "Downtown Sports Complex",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Sports Type",
                hintText: "Select",
                controller: TextEditingController(),
              ),
              Row(
                children: [
                  Flexible(
                    child: CustomFormCard(
                      title: "Price/Hour",
                      hintText: "\$45",
                      controller: TextEditingController(),
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: CustomFormCard(
                      title: "Capacity",
                      hintText: "20",
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              ),
              CustomFormCard(
                title: "Location",
                hintText: "123 Main Street, Downtown",
                controller: TextEditingController(),
              ),
              CustomText(
                text: "Venue Status",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                bottom: 8,
              ),
              Row(
                children: [
                  Switch(value: true, onChanged: (value) {}),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Active",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "Venue is visible and bookable",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomText(
                      text: "Amenities",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: CustomButton(
                      onTap: () {},
                      height: 40,
                      fontSize: 14,
                      textColor: AppColors.white,
                      title: "+  Add an Amenities",
                    ),
                  ),
                ],
              ),
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
              CustomFormCard(title: "Description",
                  hintText: "Type here.....",
                  maxLine: 4,
                  controller: TextEditingController()),
              Row(
                children: [
                  Flexible(child: CustomButton(onTap: (){},
                    fillColor: AppColors.black_05,
                    textColor: AppColors.white,
                    title: "Cancel",)),
                  SizedBox(width: 8,),
                  Flexible(child: CustomButton(onTap: (){},textColor: AppColors.white,title: "Save",))
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
