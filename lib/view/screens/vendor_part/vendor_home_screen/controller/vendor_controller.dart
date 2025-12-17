import 'package:get/get.dart';

import '../../vendor_profile_screen/controller/vendor_profile_controller.dart';

class VendorHomeController extends GetxController {
  RxBool isChartVisible = false.obs;

  void toggleChart() {
    isChartVisible.value = !isChartVisible.value;
  }
}
