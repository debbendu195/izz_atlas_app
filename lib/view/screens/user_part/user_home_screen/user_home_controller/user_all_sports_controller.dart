import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../model/all_spoets_model.dart';

class UserAllSportsController extends GetxController{

  var sportsVenueGroups = <SportsVenueGroup>[].obs;
  var isLoading = true.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;
  int totalPage = 1;


  Future<void> allSports({bool loadMore = false}) async {
    if (isLoading.value || isLoadMore.value) return;

    try {
      if (loadMore) {
        if (currentPage >= totalPage) return;
        isLoadMore.value = true;
        currentPage++;
      } else {
        isLoading.value = true;
        currentPage = 1;
        sportsVenueGroups.clear();
      }

      final response = await ApiClient.getData(ApiUrl.allSports(page: currentPage.toString()));

      final Map<String, dynamic> jsonResponse =
      response.body is String
          ? jsonDecode(response.body)
          : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {

        final venueResponse = VenueResponse.fromJson(jsonResponse);

        final meta = venueResponse.data.meta;
        totalPage = (meta.total / meta.limit).ceil();

        sportsVenueGroups.addAll(venueResponse.data.data);

      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Update failed",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar(e.toString(), isError: true);
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
    }
  }


}