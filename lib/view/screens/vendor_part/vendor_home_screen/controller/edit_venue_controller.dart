import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../service/api_check.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../user_part/user_home_screen/model/user_venue_details_model.dart';
import 'vendor_my_venue_controller.dart';

class EditVenueController extends GetxController {
  // ================= TEXT CONTROLLERS =================
  final venueNameController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();
  final courtNumberController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  // ================= VARIABLES =================
  var isLoading = false.obs;
  var isUpdating = false.obs;
  String venueId = "";

  var selectedImage = Rx<File?>(null);
  var networkImage = "".obs;

  final sportsTypeList = [
    "FOOTBALL", "CRICKET", "BADMINTON", "BASKETBALL", "TENNIS",
    "PICKLEBALL", "SWIMMING", "RUGBY", "PLIATES", "TAKRAW", "VOLLEYBALL", "OTHER"
  ];
  var selectedSportType = "FOOTBALL".obs;

  // ✅ FIXED: Changed to Uppercase to match API response
  final daysList = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];

  var amenitiesList = ["Wi-Fi", "Flood Lights", "Changing Room", "Parking", "Water", "Lockers"].obs;
  var selectedAmenities = <String>[].obs;

  var scheduleList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      venueId = Get.arguments;
      getVenueDetails(venueId);
    }
  }

  // ================= 1. FETCH DATA =================
  Future<void> getVenueDetails(String id) async {
    isLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.userVenueDetails(id: id));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : response.body;

        final venueResponse = VenueDetailsResponse.fromJson(jsonResponse);
        final venue = venueResponse.data;

        // Set Text Fields
        venueNameController.text = venue.venueName;
        priceController.text = venue.pricePerHour.toString();
        capacityController.text = venue.capacity.toString();
        courtNumberController.text = venue.courtNumbers.toString();
        locationController.text = venue.location;
        descriptionController.text = venue.description;

        // Set Sport Type
        if (sportsTypeList.contains(venue.sportsType.toUpperCase())) {
          selectedSportType.value = venue.sportsType.toUpperCase();
        } else {
          if(!sportsTypeList.contains(venue.sportsType.toUpperCase())) {
            sportsTypeList.add(venue.sportsType.toUpperCase());
          }
          selectedSportType.value = venue.sportsType.toUpperCase();
        }

        // Set Image
        networkImage.value = venue.venueImage;

        // Set Amenities
        selectedAmenities.clear();
        for (var element in venue.amenities) {
          selectedAmenities.add(element.amenityName);
          if(!amenitiesList.contains(element.amenityName)){
            amenitiesList.add(element.amenityName);
          }
        }

        // Set Schedule
        scheduleList.clear();
        for (var availability in venue.venueAvailabilities) {
          List<Map<String, String>> slots = [];
          for (var slot in availability.scheduleSlots) {
            slots.add({
              "start": slot.from,
              "end": slot.to
            });
          }

          // ✅ FIXED: Ensure day matches list (API usually returns uppercase)
          String apiDay = availability.day.toUpperCase();
          if(!daysList.contains(apiDay)){
            // If API sends "Sunday" but list is "SUNDAY", converting guarantees match
            apiDay = daysList.firstWhere((d) => d.toUpperCase() == apiDay, orElse: () => "SUNDAY");
          }

          scheduleList.add({
            "day": apiDay,
            "isActive": true,
            "slots": slots
          });
        }

        if (scheduleList.isEmpty) {
          addNewDayBlock();
        }

      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      showCustomSnackBar("Error fetching data: $e", isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= 2. UPDATE VENUE API =================
  Future<void> updateVenue() async {
    isUpdating.value = true;

    // --- Validation Start ---
    String priceInput = priceController.text.trim();
    String capacityInput = capacityController.text.trim();
    String courtInput = courtNumberController.text.trim();

    if (priceInput.isEmpty || capacityInput.isEmpty || courtInput.isEmpty) {
      showCustomSnackBar("All numeric fields are required!", isError: true);
      isUpdating.value = false;
      return;
    }

    double? price = double.tryParse(priceInput);
    int? capacity = int.tryParse(capacityInput);
    int? courtNumbers = int.tryParse(courtInput);

    if (price == null || capacity == null || courtNumbers == null) {
      showCustomSnackBar("Invalid number format!", isError: true);
      isUpdating.value = false;
      return;
    }

    if (price < 0 || capacity < 0 || courtNumbers < 0) {
      showCustomSnackBar("Values cannot be negative!", isError: true);
      isUpdating.value = false;
      return;
    }
    // --- Validation End ---

    try {
      debugPrint("Updating via Multipart");

      Map<String, String> fields = {
        "venueName": venueNameController.text,
        "sportsType": selectedSportType.value,
        "pricePerHour": price.toString(),
        "capacity": capacity.toString(),
        "courtNumbers": courtNumbers.toString(),
        "location": locationController.text,
        "description": descriptionController.text,
      };

      // Add Amenities
      for (int i = 0; i < selectedAmenities.length; i++) {
        fields["amenities[$i][amenityName]"] = selectedAmenities[i];
      }

      // Add Schedule
      int availabilityIndex = 0;
      for (var dayBlock in scheduleList) {
        if (dayBlock['isActive'] == true) {
          fields["venueAvailabilities[$availabilityIndex][day]"] = dayBlock['day'];

          List slots = dayBlock['slots'];
          for (int j = 0; j < slots.length; j++) {
            fields["venueAvailabilities[$availabilityIndex][scheduleSlots][$j][from]"] = slots[j]['start'];
            fields["venueAvailabilities[$availabilityIndex][scheduleSlots][$j][to]"] = slots[j]['end'];
          }
          availabilityIndex++;
        }
      }

      List<MultipartBody> multipartBody = [];
      if (selectedImage.value != null) {
        multipartBody.add(MultipartBody("venueImage", selectedImage.value!));
      }

      final response = await ApiClient.patchMultipartData(
        ApiUrl.updateVenue(id: venueId),
        fields,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        showCustomSnackBar("Venue updated successfully!", isError: false);

        if(Get.isRegistered<VendorMyVenueController>()){
          Get.find<VendorMyVenueController>().getMyVenues();
        }
      } else {
        String msg = response.statusText ?? "Update failed";
        try {
          if (response.body is String) {
            var json = jsonDecode(response.body);
            if(json['message'] != null) msg = json['message'];
          } else if (response.body is Map && response.body['message'] != null) {
            msg = response.body['message'];
          }
        } catch(e) {
          debugPrint("Error parsing error msg: $e");
        }
        showCustomSnackBar(msg, isError: true);
      }

    } catch (e) {
      showCustomSnackBar("Something went wrong: $e", isError: true);
      debugPrint("Update Exception: $e");
    } finally {
      isUpdating.value = false;
    }
  }

  // ================= 3. HELPER FUNCTIONS =================

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
  }

  void addCustomAmenity(String name) {
    if (name.isNotEmpty && !amenitiesList.contains(name)) {
      amenitiesList.add(name);
      Get.back();
    }
  }

  // Schedule Logic
  void addNewDayBlock() {
    scheduleList.add({
      "day": "SUNDAY",
      "isActive": true,
      "slots": [{"start": "09:00 AM", "end": "10:00 AM"}]
    });
  }

  void removeDayBlock(int index) {
    if (scheduleList.length > 1) {
      scheduleList.removeAt(index);
    } else {
      showCustomSnackBar("At least one day schedule is required", isError: true);
    }
  }

  void changeDay(int index, String? newDay) {
    if (newDay != null) {
      var item = scheduleList[index];
      item['day'] = newDay;
      scheduleList[index] = item;
      scheduleList.refresh();
    }
  }

  void toggleScheduleActive(int index, bool? val) {
    var item = scheduleList[index];
    item['isActive'] = val ?? false;
    scheduleList[index] = item;
    scheduleList.refresh();
  }

  void addSlotToDay(int dayIndex) {
    var dayBlock = scheduleList[dayIndex];
    List slots = dayBlock['slots'];
    slots.add({"start": "12:00 PM", "end": "01:00 PM"});
    scheduleList.refresh();
  }

  void removeSlotFromDay(int dayIndex, int slotIndex) {
    var dayBlock = scheduleList[dayIndex];
    List slots = dayBlock['slots'];
    if (slots.length > 1) {
      slots.removeAt(slotIndex);
      scheduleList.refresh();
    } else {
      showCustomSnackBar("At least one slot required", isError: true);
    }
  }

  void changeTime(int dayIndex, int slotIndex, String key, int minutes) {
    var dayBlock = scheduleList[dayIndex];
    List slots = dayBlock['slots'];
    String currentTime = slots[slotIndex][key];
    slots[slotIndex][key] = _adjustTime(currentTime, minutes);
    scheduleList.refresh();
  }

  String _adjustTime(String currentTime, int minutesToAdd) {
    try {
      final format = RegExp(r"(\d+):(\d+)\s(AM|PM)");
      final match = format.firstMatch(currentTime);
      if (match == null) return currentTime;
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!;
      if (period == 'PM' && hour != 12) hour += 12;
      if (period == 'AM' && hour == 12) hour = 0;
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, hour, minute);
      final newDt = dt.add(Duration(minutes: minutesToAdd));
      final newTimeOfDay = TimeOfDay.fromDateTime(newDt);
      final h = newTimeOfDay.hourOfPeriod == 0 ? 12 : newTimeOfDay.hourOfPeriod;
      final m = newTimeOfDay.minute.toString().padLeft(2, '0');
      final p = newTimeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
      return "$h:$m $p";
    } catch (e) {
      return currentTime;
    }
  }
}