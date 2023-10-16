import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final getStorage = GetStorage();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getStorage.write("status", "login");
  }

  @override
  void onReady() {
    super.onReady();
    if (getStorage.read("status") != "" && getStorage.read("status") != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
