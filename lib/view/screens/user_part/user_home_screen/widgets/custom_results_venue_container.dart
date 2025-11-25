import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomResultsVenueContainer extends StatelessWidget {
  const CustomResultsVenueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: (){
          Get.toNamed(AppRoutes.userVenueDetailsScreen);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff1F2937),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.banner,
                height: 160,
                width: MediaQuery.sizeOf(context).width,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Westfield Sports Lab",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (value) {
                                return Icon(Icons.star, color: Colors.amberAccent);
                              }),

                            ),
                            CustomText(
                              text: "4.2",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomText(
                      text: "124 Lorem Ave, Dhaka",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      bottom: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff6B7280),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                child: CustomText(text: "Football", fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.white,)
                            ),
                            CustomText(
                              left: 10,
                              text: "RM 1,20/hr",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xff6B7280),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                            child: CustomText(text: "Full", fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.white,)
                        )
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
