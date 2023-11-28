import 'package:get/get.dart';

import '../controllers/client_controller.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(
      () => ClientController(),
    );
  }
}
