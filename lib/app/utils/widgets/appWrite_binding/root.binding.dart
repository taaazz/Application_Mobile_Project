import 'package:get/get.dart';
import 'package:project/app/modules/client/controllers/client_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientController(), permanent: true);

    // Get.lazyPut(() => AccountController());
  }
}
