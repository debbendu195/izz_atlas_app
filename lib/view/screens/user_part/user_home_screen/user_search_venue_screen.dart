import 'package:flutter/material.dart';
import 'package:izz_atlas_app/utils/app_const/app_const.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:izz_atlas_app/view/components/custom_text/custom_text.dart';
import 'package:izz_atlas_app/view/screens/user_part/user_home_screen/widgets/custom_results_venue_container.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class UserSearchVenueScreen extends StatelessWidget {
  const UserSearchVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Search"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                fillColor: AppColors.white,
                fieldBorderColor: AppColors.greyLight,
                prefixIcon: Icon(Icons.search, color: AppColors.greyLight),
                hintText: "Search",
                hintStyle: TextStyle(color: AppColors.greyLight),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "RESULTS FOR 'VENUE'",
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.filterIcon,
                        height: 20,
                        width: 20,
                      ),
                      CustomText(
                        text: "FILTERS",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: List.generate(4, (value){return CustomResultsVenueContainer();}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
