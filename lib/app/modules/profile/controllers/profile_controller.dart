import 'dart:io';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  final count = 0.obs;

  Rx<File?> imageFile = Rx<File?>(null);

  // Metode untuk memperbarui gambar profil
  void updateProfileImage(File newImage) {
    imageFile.value = newImage;
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

  void increment() => count.value++;
}
