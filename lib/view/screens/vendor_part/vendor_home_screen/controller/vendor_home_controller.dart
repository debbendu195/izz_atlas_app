import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';

class AddVenueController extends GetxController {
  // ================= Text Controllers =================
  final TextEditingController venueNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController courtNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController newAmenityController = TextEditingController();

  // ================= Reactive Variables =================
  var selectedSportType = "FOOTBALL".obs;
  var isVenueActive = true.obs;
  var isLoading = false.obs;

  // Image Selection
  var selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  // Amenities
  var selectedAmenities = <String>[].obs;
  var customAmenities = <String>[].obs;

  // Sports List
  final List<String> sportsTypeList = [
    "FOOTBALL", "CRICKET", "BADMINTON", "BASKETBALL", "TENNIS",
    "PICKLEBALL", "SWIMMING", "RUGBY", "PLIATES", "TAKRAW", "VOLLEYBALL", "OTHER"
  ];

  // ================= Schedule Logic =================
  final List<String> daysList = [
    "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
  ];

  var scheduleList = <Map<String, dynamic>>[
    {
      "day": "Sunday",
      "isActive": true,
      "slots": [
        {"start": "09:00 AM", "end": "10:00 AM"}
      ]
    }
  ].obs;

  // ================= Methods =================

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
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

  void addNewAmenity() {
    if (newAmenityController.text.trim().isNotEmpty) {
      String name = newAmenityController.text.trim();
      if (!customAmenities.contains(name)) {
        customAmenities.add(name);
      }

      newAmenityController.clear();
      Get.back();
    }
  }

  // Schedule Methods
  void addNewDayBlock() {
    scheduleList.add({
      "day": "Sunday",
      "isActive": true,
      "slots": [{"start": "09:00 AM", "end": "10:00 AM"}]
    });
  }

  void removeDayBlock(int index) {
    if (scheduleList.length > 1) {
      scheduleList.removeAt(index);
    } else {
      Get.snackbar("Alert", "At least one day schedule is required",
          backgroundColor: Colors.orange, colorText: Colors.white);
    }
  }

  void addSlotToDay(int dayIndex) {
    List<Map<String, String>> slots = scheduleList[dayIndex]['slots'];
    slots.add({"start": "10:00 AM", "end": "11:00 AM"});
    scheduleList.refresh();
  }

  void removeSlotFromDay(int dayIndex, int slotIndex) {
    List<Map<String, String>> slots = scheduleList[dayIndex]['slots'];
    if (slots.length > 1) {
      slots.removeAt(slotIndex);
      scheduleList.refresh();
    } else {
      Get.snackbar("Alert", "At least one time slot is required",
          backgroundColor: Colors.orange, colorText: Colors.white);
    }
  }

  void changeDay(int index, String? newDay) {
    if (newDay != null) {
      scheduleList[index]['day'] = newDay;
      scheduleList.refresh();
    }
  }

  void toggleScheduleActive(int index, bool? val) {
    scheduleList[index]['isActive'] = val ?? true;
    scheduleList.refresh();
  }

  void changeTime(int dayIndex, int slotIndex, String key, int minutesToAdd) {
    List<Map<String, String>> slots = scheduleList[dayIndex]['slots'];
    String currentTime = slots[slotIndex][key]!;
    slots[slotIndex][key] = _adjustTime(currentTime, minutesToAdd);
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

  // ================= API Call =================
  Future<void> createVenue() async {
    if (venueNameController.text.isEmpty || selectedImage.value == null) {
      Get.snackbar("Required", "Please fill all fields and select an image",
          backgroundColor: Colors.redAccent, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10));
      return;
    }

    try {
      isLoading.value = true;

      List<Map<String, dynamic>> venueAvailabilities = [];
      for (var dayBlock in scheduleList) {
        if (dayBlock['isActive'] == true) {
          List<Map<String, String>> slots = dayBlock['slots'];
          List<Map<String, String>> formattedSlots = slots.map((s) => {"from": s['start']!, "to": s['end']!}).toList();
          venueAvailabilities.add({"day": dayBlock['day'], "scheduleSlots": formattedSlots});
        }
      }

      Map<String, dynamic> venueDataObj = {
        "venueName": venueNameController.text.trim(),
        "sportsType": selectedSportType.value,
        "pricePerHour": int.tryParse(priceController.text.trim()) ?? 0,
        "capacity": int.tryParse(capacityController.text.trim()) ?? 0,
        "location": locationController.text.trim(),
        "description": descriptionController.text.trim(),
        "amenities": selectedAmenities.map((e) => {"amenityName": e}).toList(),
        "courtNumbers": int.tryParse(courtNumberController.text.trim()) ?? 1,
        "venueStatus": isVenueActive.value,
        "venueAvailabilities": venueAvailabilities
      };

      Map<String, String> body = {'data': jsonEncode(venueDataObj)};
      List<MultipartBody> multipartList = [];
      if (selectedImage.value != null) {
        multipartList.add(MultipartBody('venueImage', selectedImage.value!));
      }

      var response = await ApiClient.postMultipartData(ApiUrl.createVenue, body, multipartBody: multipartList);
      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _clearFields();
        Get.snackbar("Success", "Venue Created Successfully!", backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10), borderRadius: 10, duration: const Duration(seconds: 3));
        Get.back();
      } else {
        String errorMessage = "Failed to create venue";
        try {
          var jsonResponse = (response.body is String) ? jsonDecode(response.body) : response.body;
          if(jsonResponse != null && jsonResponse['message'] != null) {
            errorMessage = jsonResponse['message'];
          }
        } catch(e) {
          print("Error parsing response: $e");
        }
        Get.snackbar("Error", errorMessage, backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10), borderRadius: 10, duration: const Duration(seconds: 3));
      }
    } catch (e) {
      isLoading.value = false;
      print("Exception: $e");
      Get.snackbar("Error", "Something went wrong.", backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10));
    }
  }

  void _clearFields() {
    venueNameController.clear();
    priceController.clear();
    capacityController.clear();
    courtNumberController.clear();
    locationController.clear();
    descriptionController.clear();
    newAmenityController.clear();
    selectedImage.value = null;
    selectedAmenities.clear();
    customAmenities.clear();
    scheduleList.assignAll([
      {"day": "Sunday", "isActive": true, "slots": [{"start": "09:00 AM", "end": "10:00 AM"}]}
    ]);
  }
}