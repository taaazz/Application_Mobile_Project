import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:project/app/utils/controller_widget/client_controller.dart';

class LoginController extends ClientController {
  late Account account;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createAccount(String email, String password, String name) async {
    try {
      final result = await account.create(
        email: email,
        password: password,
        name: name, // Gunakan nilai nama yang diterima dari formulir
        userId: '', // Sesuaikan dengan kebutuhan Anda
      );
      print("AccountController:: createAccount $result");
      // Tindakan setelah akun berhasil dibuat
    } catch (error) {
      showAlertDialog("Error Account", "$error");
    }
  }

  Future<void> createEmailSession(Map<String, dynamic> map) async {
    try {
      final result = await account.createEmailSession(
        email: map['email'],
        password: map['password'],
      );
      print("AccountController:: createEmailSession $result");
    } catch (error) {
      showAlertDialog("Error Account", "$error");
    }
  }

  void showAlertDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
      titleStyle: Get.context?.theme.textTheme.titleLarge,
      content: Text(
        message,
        style: Get.context?.theme.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
    );
  }
}
