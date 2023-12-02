import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:project/app/utils/controller_widget/client_controller.dart';

class DatabaseController extends ClientController {
  Databases? databases;
  @override
  void onInit() {
    super.onInit();
// appwrite
    databases = Databases(client);
  }

  Future<void> storeReview(Map<String, dynamic> reviewData) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "6567509d3961f03c48dc",
        documentId: ID.unique(),
        collectionId: "656760763d5de370996e",
        data: reviewData,
        permissions: [
          Permission.read(Role.any()),
          Permission.update(Role.any()),
          Permission.delete(Role.any()),
        ],
      );
      print("DatabaseController:: storeReview $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "Error storing review data: $error", // Menampilkan pesan kesalahan
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future<void> updateReview(
      String documentId, Map<String, dynamic> reviewData) async {
    try {
      final result = await databases!.updateDocument(
        databaseId: "6567509d3961f03c48dc",
        documentId: documentId,
        data: reviewData,
        collectionId: '',
      );
      print("DatabaseController:: updateReview $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "Error updating review data: $error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future<void> deleteReview(String documentId) async {
    try {
      final result = await databases!.deleteDocument(
        databaseId: "6567509d3961f03c48dc",
        documentId: documentId,
        collectionId: '',
      );
      print("DatabaseController:: deleteReview $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "Error deleting review data: $error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future storeUserName(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "6567509d3961f03c48dc",
        documentId: ID.unique(),
        collectionId: "656760763d5de370996e",
        data: map,
        permissions: [
          Permission.read(Role.any()),
          Permission.update(Role.any()),
          Permission.delete(Role.any()),
        ],
      );
      print("DatabaseController:: storeUserName $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
