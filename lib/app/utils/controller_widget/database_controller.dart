import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project/app/data/api/appwrite.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:project/app/utils/controller_widget/client_controller.dart';

class DatabaseController extends ClientController {
  @override
  void onInit() {
    super.onInit();
// appwrite
  }

  Future<void> storeReview(Map<String, dynamic> reviewData) async {
    try {
      final result = await databases.createDocument(
        databaseId: APPWRITE_DATABASE_ID,
        documentId: ID.unique(),
        collectionId: APPWRITE_DATABASE_USER_COLLECTION_ID,
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

  Future<List<Map<String, dynamic>>> getReviewData() async {
    try {
      final response = await databases.listDocuments(
        databaseId: APPWRITE_DATABASE_ID,
        collectionId: APPWRITE_DATABASE_USER_COLLECTION_ID,
      );

      List<Map<String, dynamic>> reviews = [];
      response.documents.forEach((document) {
        reviews.add(document.data);
      });

      return reviews;
    } catch (error) {
      throw Exception('Error fetching review data: $error');
    }
  }

  void updateReview(String documentId, Map<String, dynamic> reviewData) async {
    try {
      final result = await databases.updateDocument(
        databaseId:
            APPWRITE_DATABASE_ID, // Ganti dengan ID database yang digunakan di Appwrite
        documentId: documentId,
        data: reviewData,
        collectionId: APPWRITE_DATABASE_USER_COLLECTION_ID,
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
      final result = await databases.deleteDocument(
        databaseId: "6567509d3961f03c48dc",
        documentId: documentId,
        collectionId: APPWRITE_DATABASE_USER_COLLECTION_ID,
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
}
