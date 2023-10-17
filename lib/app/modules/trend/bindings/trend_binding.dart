import 'package:get/get.dart';

import '../controllers/trend_controller.dart';

class TrendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrendController>(
      () => TrendController(),
    );
  }
}
