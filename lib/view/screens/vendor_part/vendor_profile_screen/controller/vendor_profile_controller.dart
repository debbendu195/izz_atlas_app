import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// আপনার ফোল্ডার স্ট্রাকচার অনুযায়ী ইম্পোর্টগুলো ঠিক রাখুন
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_check.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../vendor_home_screen/model/about_model.dart';
import '../../vendor_home_screen/model/vedor_privacy_model.dart';
import '../../vendor_home_screen/model/vendor_trems_and_conditions.dart';

class VendorProfileController extends GetxController {

  ///========= Image Picker GetX Controller Code ===========//
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;

  // Content Strings
  RxString termsContent = "".obs;
  RxString privacyContent = "".obs;
  RxString aboutUsContent = "".obs;

  // Loading States
  RxBool updateProfileLoading = false.obs;
  RxBool isProfileLoading = false.obs;
  RxBool updatePasswordLoading = false.obs;

  // Text Controllers for Profile
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;

  // Image Pickers
  //==========================================
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  //==========================================
  // Terms, Privacy, About Us (Existing Logic)
  //==========================================
  final rxTermsStatus = Status.loading.obs;
  void setTermsStatus(Status value) => rxTermsStatus.value = value;
  Rx<VendorTremsAndConditions> termsModel = VendorTremsAndConditions().obs;

  Future<void> getTermsAndConditions() async {
    isLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiUrl.termsCondition);
      if (response.statusCode == 200) {
        var responseData = response.body['data'];
        if (responseData != null && responseData is List) {
          List<VendorTremsAndConditions> data = responseData
              .map((e) => VendorTremsAndConditions.fromJson(e))
              .toList();
          termsContent.value = data.map((e) => e.description ?? "").join("\n\n");
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("Error fetching terms: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPrivacyPolicy() async {
    isLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiUrl.privacyPolicy);
      if (response.statusCode == 200) {
        var responseData = response.body['data'];
        if (responseData != null && responseData is List) {
          List<PrivacyPolicyModel> data = responseData
              .map((e) => PrivacyPolicyModel.fromJson(e))
              .toList();
          privacyContent.value = data.map((e) => e.description ?? "").join("\n\n");
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("Error fetching privacy policy: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAboutUsData() async {
    isLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiUrl.aboutUs);
      if (response.statusCode == 200) {
        var responseData = response.body['data'];
        if (responseData != null && responseData is List) {
          List<VendorAboutUsModel> data = responseData
              .map((e) => VendorAboutUsModel.fromJson(e))
              .toList();
          aboutUsContent.value = data.map((e) => e.description ?? "").join("\n\n");
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("Error fetching about us: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //==========================================
  // Change Password (UPDATED with JSON Encode)
  //==========================================
  Future<void> changePassword() async {
    updatePasswordLoading.value = true;
    // refresh(); // GetX এ update() ব্যবহার করাই শ্রেয়, refresh() সব সময় দরকার হয় না

    try {
      Map<String, String> body = {
        "oldPassword": oldPasswordController.value.text.trim(),
        "newPassword": newPasswordController.value.text.trim(),
      };

      // FIX: jsonEncode এবং Headers ব্যবহার করা হয়েছে
      var response = await ApiClient.putData(
        ApiUrl.changePassword,
        jsonEncode(body),
        headers: {"Content-Type": "application/json"}, // JSON হেডার
      );

      updatePasswordLoading.value = false;
      // refresh();

      var jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message'] ?? "Password changed!", isError: false);
        resetPasswordFields();
        Get.back();
      } else {
        showCustomSnackBar(jsonResponse['message'] ?? "Failed to change password", isError: true);
      }
    } catch (e) {
      updatePasswordLoading.value = false;
      // refresh();
      print("Change Password Error: $e");
      showCustomSnackBar("Something went wrong.", isError: true);
    }
  }

  void resetPasswordFields() {
    oldPasswordController.value.clear();
    newPasswordController.value.clear();
    confirmPasswordController.value.clear();
  }





  Rx<UserProfileModel> userProfileModel = UserProfileModel(
      id: '', name: '', email: '', phoneNumber: '', dateOfBirth: '', photo: ''

  ).obs;

  Future<void> getUserProfile() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.vendorProfile);

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        var data = response.body['data'];
        userProfileModel.value = UserProfileModel.fromJson(data);

        if (nameController.value.text.isEmpty) {
          nameController.value.text = userProfileModel.value.name;
        }
        emailController.value.text = userProfileModel.value.email;
        if (phoneController.value.text.isEmpty) {
          phoneController.value.text = userProfileModel.value.phoneNumber;
        }
        if (dobController.value.text.isEmpty) {
          dobController.value.text = userProfileModel.value.dateOfBirth ??"";
        }

        // setRequestStatus(Status.completed);
        update();
      } catch (e) {
        // setRequestStatus(Status.error);
        debugPrint("Parsing error: $e");
      }
    } else {
      // setRequestStatus(Status.error);
      Get.snackbar("Error", "Failed to load user profile.");
    }
  }

  Future<void> updateProfile() async {
    updateProfileLoading.value = true;
    refresh();

    try {
      Map<String, String> body = {
        "name": nameController.value.text.trim(),
        "phoneNumber": nameController.value.text.trim(),
        "dateOfBirth": dobController.value.text,
      };

      dynamic response;
      if (selectedImage.value != null) {
        response = await ApiClient.patchMultipartData(ApiUrl.updateProfile, body,
          multipartBody: [
            MultipartBody("file", selectedImage.value!),
          ],
        );
      } else {
        response = await ApiClient.patchData(ApiUrl.updateProfile, jsonEncode(body),);
      }

      updateProfileLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Profile updated successfully!",
          isError: false,
        );

        String? userRole = await SharePrefsHelper.getString(AppConstants.role);
        resetPasswordFields();
        // if (userRole.toLowerCase() == "host") {
        //   Get.offAllNamed(AppRoutes.profileScreen);
        // } else {
        //   Get.offAllNamed(AppRoutes.dmProfileScreen);
        // }
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Update failed",
          isError: true,
        );
      }
    } catch (e) {
      updateProfileLoading.value = false;
      refresh();
      showCustomSnackBar(
        "An error occurred. Please try again.",
        isError: true,
      );
      debugPrint("Profile update error: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}



class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? dateOfBirth;
  final String? country;
  final String? address;
  final String photo;

  UserProfileModel( {
    this.country, this.address,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.dateOfBirth,
    required this.photo,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? json['id'] ?? '',
      name: json['fullName'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      country: json['country'] ?? '',
      phoneNumber: json['contactNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      photo: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': name,
      'email': email,
      'contactNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'profileImage': photo,
      'country': photo,
      'address': photo,
    };
  }
}