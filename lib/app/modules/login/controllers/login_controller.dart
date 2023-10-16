import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  File? image;
  final count = 0.obs;
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

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageX = await picker.pickImage(source: ImageSource.gallery);
    if (imageX == null) return;
    image = File(imageX.path);
    update();
  }
}
