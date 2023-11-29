import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

class LoginController extends GetxController {
  late Account account;
  late Client client;

  @override
  void onInit() {
    super.onInit();
    initializeAppwrite();
  }

  void initializeAppwrite() {
    client = Client();
    client
        .setEndpoint(
            'YOUR_APPWRITE_ENDPOINT') // Ganti dengan endpoint Appwrite Anda
        .setProject(
            'YOUR_APPWRITE_PROJECT_ID') // Ganti dengan ID proyek Appwrite Anda
        .setSelfSigned(); // Atau setSelfSigned(status: true) jika menggunakan SSL self-signed

    account = Account(client);
  }

  Future<void> createAccount(Map<String, dynamic> map) async {
    try {
      final result = await account.create(
        email: map['email'],
        password: map['password'],
        name: map['name'],
        userId: '',
      );
      print("AccountController:: createAccount $result");
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
