import 'package:get/get.dart';

import '../../../utils/widgets/controller_widget/account_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
