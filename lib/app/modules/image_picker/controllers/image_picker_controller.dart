import 'package:get/get.dart';

import '../../../utils/controller_widget/database_controller.dart';
// ignore: depend_on_referenced_packages

class ImagePickerController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;

  final databaseController = Get.put(DatabaseController());
  final reviewData = <Map<String, dynamic>>[].obs;

  void updateReviewData(List<Map<String, dynamic>> newData) {
    reviewData.assignAll(newData);
  }

  Future<void> deleteReview(String documentId) async {
    await databaseController.deleteReview(documentId);
    reviewData.removeWhere((review) => review['\$id'] == documentId);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
