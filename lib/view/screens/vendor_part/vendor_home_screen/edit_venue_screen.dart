import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:izz_atlas_app/utils/app_icons/app_icons.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button.dart';
import 'package:izz_atlas_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:izz_atlas_app/view/components/custom_image/custom_image.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/vendor_home_controller.dart';

// ================== SCREEN ==================
class EditVenueScreen extends StatelessWidget {
  const EditVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddVenueController controller = Get.put(AddVenueController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Edit Venu"),
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ============= Image Picker Section =============
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: 192,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          image: controller.selectedImage.value != null
                              ? DecorationImage(
                            image: FileImage(controller.selectedImage.value!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: controller.selectedImage.value == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                            Text("Tap to upload venue image"),
                          ],
                        )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ============= Form Fields =============
                    CustomFormCard(
                      title: "Venue Name",
                      hintText: "Downtown Sports Complex",
                      controller: TextEditingController(),
                    ),

                    // ========== Sports Type Dropdown ==========
                    CustomText(
                      text: "Sports Type",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 8,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedSportType.value,
                          icon: const Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          items: controller.sportsTypeList.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              controller.selectedSportType.value = newValue;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ===============================================

                    Row(
                      children: [
                        Flexible(
                          child: CustomFormCard(
                            title: "Price/Hour",
                            hintText: "1200",
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: CustomFormCard(
                            title: "Capacity",
                            hintText: "22",
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(),
                          ),
                        ),
                      ],
                    ),
                    CustomFormCard(
                      title: "Location",
                      hintText: "Dhanmondi, Dhaka",
                      controller: TextEditingController(),
                    ),

                    const SizedBox(height: 16),

                    // ============= Schedule Section =============
                    CustomText(
                      text: "Schedule",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 8,
                    ),

                    Column(
                      children: List.generate(controller.scheduleList.length, (dayIndex) {
                        var dayBlock = controller.scheduleList[dayIndex];
                        List slots = dayBlock['slots'];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Day Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: dayBlock['day'],
                                          icon: Icon(Icons.arrow_drop_down),
                                          items: controller.daysList.map((String day) {
                                            return DropdownMenuItem<String>(
                                              value: day,
                                              child: Text(day),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) => controller.changeDay(dayIndex, newValue),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: dayBlock['isActive'],
                                          onChanged: (val) => controller.toggleScheduleActive(dayIndex, val),
                                          activeColor: Colors.deepPurple,
                                        ),
                                        InkWell(
                                          onTap: () => controller.removeDayBlock(dayIndex),
                                          child: Icon(Icons.delete_outline, color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Divider(height: 1, color: Colors.grey.shade200),
                                const SizedBox(height: 12),

                                // Slots Loop
                                ...List.generate(slots.length, (slotIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _buildTimeController(
                                            time: slots[slotIndex]['start'],
                                            onDecrease: () => controller.changeTime(dayIndex, slotIndex, "start", -30),
                                            onIncrease: () => controller.changeTime(dayIndex, slotIndex, "start", 30),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: _buildTimeController(
                                            time: slots[slotIndex]['end'],
                                            onDecrease: () => controller.changeTime(dayIndex, slotIndex, "end", -30),
                                            onIncrease: () => controller.changeTime(dayIndex, slotIndex, "end", 30),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () => controller.removeSlotFromDay(dayIndex, slotIndex),
                                              child: const Icon(Icons.remove_circle_outline, color: Colors.red, size: 28),
                                            ),
                                            const SizedBox(width: 8),
                                            InkWell(
                                              onTap: () => controller.addSlotToDay(dayIndex),
                                              child: const Icon(Icons.add_circle_outline, color: Colors.blue, size: 28),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: controller.addNewDayBlock,
                        icon: const Icon(Icons.calendar_today, color: Colors.white),
                        label: const Text(
                          "Add New Day Schedule",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    CustomText(text: "Amenities", fontSize: 16, fontWeight: FontWeight.w700),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _amenitySelectableItem(controller, AppIcons.wifi, "Wi-Fi"),
                          SizedBox(width: 10),
                          _amenitySelectableItem(controller, AppIcons.wifi2, "Flood Lights"),
                          SizedBox(width: 10),
                          _amenitySelectableItem(controller, AppIcons.wifi3, "Changing Room"),
                          SizedBox(width: 10),
                          _amenitySelectableItem(controller, AppIcons.wifi3, "Parking"),
                        ],
                      ),
                    ),

                    CustomFormCard(
                      title: "Description",
                      hintText: "Type description here...",
                      maxLine: 4,
                      controller: TextEditingController(),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Flexible(
                          child: CustomButton(
                            onTap: () => Get.back(),
                            fillColor: AppColors.black_05,
                            textColor: AppColors.white,
                            title: "Cancel",
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: CustomButton(
                            onTap: (){},
                            textColor: AppColors.white,
                            title: "Save",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Helper Widgets
  Widget _amenitySelectableItem(AddVenueController controller, String icon, String text) {
    return Obx(() {
      bool isSelected = controller.selectedAmenities.contains(text);
      return GestureDetector(
        onTap: () => controller.toggleAmenity(text),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(colors: [Color(0xff111827), Color(0xff1F2937)])
                : null,
            color: isSelected ? null : Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? Colors.transparent : Colors.grey),
          ),
          child: Row(
            children: [
              CustomImage(imageSrc: icon, imageColor: isSelected ? Colors.white : Colors.black),
              CustomText(
                  left: 8,
                  text: text,
                  fontSize: 14,
                  color: isSelected ? AppColors.white : Colors.black,
                  fontWeight: FontWeight.w600
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTimeController({
    required String time,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onDecrease,
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0), child: Icon(Icons.remove, size: 16)),
          ),
          Text(time, style: TextStyle(color: Colors.grey.shade800, fontSize: 13, fontWeight: FontWeight.bold)),
          InkWell(
            onTap: onIncrease,
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0), child: Icon(Icons.add, size: 16)),
          ),
        ],
      ),
    );
  }
}

