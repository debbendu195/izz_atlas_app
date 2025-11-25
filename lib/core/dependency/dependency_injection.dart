import 'package:get/get.dart';

import '../../view/screens/user_part/user_profile_screen/controller/user_profile_controller.dart';
import '../../view/screens/vendor_part/vendor_home_screen/controller/vendor_home_controller.dart';
import '../../view/screens/vendor_part/vendor_profile_screen/controller/vendor_profile_controller.dart';
class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => UserProfileController(), fenix: true);
    Get.lazyPut(() => VendorProfileController(), fenix: true);

  }
}
