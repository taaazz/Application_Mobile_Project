import 'package:get/get.dart';
import 'package:project/app/utils/widgets/controller_widget/client_controller.dart';
import '../../../modules/login/controllers/account_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientController(), permanent: true);

    Get.lazyPut(() => LoginController());
  }
}
