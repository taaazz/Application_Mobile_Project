import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:project/app/Models/appwrite.dart';
import 'package:project/app/utils/controller_widget/client_controller.dart';

class StorageController extends ClientController {
  @override
  void onInit() {
    super.onInit();

// appwrite
    storage = Storage(client);
  }

  // Future<String> getImageUrl(String fileId) async {
  //   try {
  //     final result = await storage.getFilePreview(
  //       fileId: fileId,
  //       bucketId: APPWRITE_IMAGE_BUCKET_ID,
  //     );

  //     // Mengonversi respons ke dalam bentuk AppwriteFile
  //     final decodedResult =
  //         AppwriteFile.fromMap(result as Map<String, dynamic>);

  //     // URL gambar yang dihasilkan
  //     final imageUrl =
  //         'https://cloud.appwrite.io/v1/storage/buckets/${decodedResult.bucket}/files/${decodedResult.$id}/preview?project=65659bad478c88787a1c';

  //     return imageUrl;
  //   } catch (e) {
  //     throw Exception('Error getting image URL: $e');
  //   }
  // }

  Future storeImage(String imgPath, String imgName) async {
    try {
      final result = await storage.createFile(
        bucketId: APPWRITE_IMAGE_BUCKET_ID,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: imgPath,
          filename: imgName,
        ),
      );

      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
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
