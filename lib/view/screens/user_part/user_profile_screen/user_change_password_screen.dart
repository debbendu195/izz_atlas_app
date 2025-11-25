import 'package:flutter/material.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button.dart';
import 'package:izz_atlas_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

class UserChangePasswordScreen extends StatelessWidget {
  const UserChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Change Password"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40.0),
        child: Column(
          children: [
            CustomFormCard(
              title: "Old Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            CustomFormCard(
              title: "New Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            CustomFormCard(
              title: "Confirm New Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            Spacer(),
            CustomButton(
              onTap: () {},
              title: "UPDATE PASSWORD",
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
