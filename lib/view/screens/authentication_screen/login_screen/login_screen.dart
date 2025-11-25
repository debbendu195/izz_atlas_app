import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_text/custom_text.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.black, Color(0xff111827), Color(0xff1F2937)],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 80.0,
                right: 16.w,
                left: 16.w,
                bottom: 40.h,
              ),
              child: Column(
                children: [
                  CustomText(
                    text: "ATLAS",
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    bottom: 80.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          CustomText(
                            text: "SIGN UP / LOG IN",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            bottom: 10.h,
                          ),
                          CustomFormCard(
                            title: "EMAIL / PHONE NUMBER",
                            hintText: "Enter your email or phone",
                            controller: TextEditingController(),
                          ),
                          CustomFormCard(
                            title: "PASSWORD",
                            hintText: "Enter your password",
                            controller: TextEditingController(),
                          ),
                          CustomButton(
                            onTap: () {
                              Get.toNamed(AppRoutes.frameScreen);
                            },
                            title: "LOG IN",
                            fillColor: AppColors.black,
                            textColor: AppColors.white,
                          ),
                          CustomText(
                            top: 20,
                            text: "CONTINUE WITH",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black.withValues(alpha: .3),
                            bottom: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(imageSrc: AppIcons.google,height: 40,width: 40,),
                              SizedBox(width: 26,),
                              CustomImage(imageSrc: AppIcons.apple,imageColor: AppColors.black,height: 65,width: 65,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Didn't have an account yet?",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black12,
                                bottom: 10.h,
                              ),  GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoutes.signUpScreen);
                                },
                                child: CustomText(
                                  text: " Sign Up",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                  bottom: 10.h,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.setNewPassword);
                            },
                            child: CustomText(
                              top: 20,
                              text: "Forgot Password?",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                              bottom: 10.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
