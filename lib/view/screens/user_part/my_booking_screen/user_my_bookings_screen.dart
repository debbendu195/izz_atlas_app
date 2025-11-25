import 'package:flutter/material.dart';
import 'package:izz_atlas_app/utils/app_colors/app_colors.dart';
import 'package:izz_atlas_app/view/components/custom_nav_bar/navbar.dart';

import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../user_home_screen/widgets/custom_user_my_bokings_container.dart';

class UserMyBookingsScreen extends StatefulWidget {
  const UserMyBookingsScreen({super.key});

  @override
  _UserMyBookingsScreenState createState() => _UserMyBookingsScreenState();
}

class _UserMyBookingsScreenState extends State<UserMyBookingsScreen> {
  int _selectedTabIndex = 0; // Track the selected tab index (0 for Requests, 1 for Completed)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "My Booking"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomTabBar(
              tabs: ["Requests", "Completed"],
              textColor: AppColors.black,
              selectedColor: AppColors.primary,
              onTabSelected: (value) {
                setState(() {
                  _selectedTabIndex = value; // Update the selected tab index
                });
              },
              selectedIndex: _selectedTabIndex,
              isTextColorActive: true,
              isPadding: true,
              unselectedColor: AppColors.black_80,
            ),
            SizedBox(height: 20),
            // Conditionally render content based on the selected tab
            if (_selectedTabIndex == 0)
              Column(
                children: List.generate(2, (value) {
                  return CustomUserMyBokingsContainer(); // Render Requests list
                }),
              ),
            if (_selectedTabIndex == 1)
              Column(
                children: List.generate(1, (value) {
                  return CustomUserMyBokingsContainer(); // Render Completed list
                }),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 1),
    );
  }
}