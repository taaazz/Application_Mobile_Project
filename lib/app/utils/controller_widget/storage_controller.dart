import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project/app/utils/controller_widget/client_controller.dart';

class StorageController extends ClientController {
  Storage? storage;
  @override
  void onInit() {
    super.onInit();

// appwrite
    storage = Storage(client);
  }

  // aku nambahin ini kan buat bisa di panggil di image picker

  Future getImageUrl(String fileId) async {
    try {
      final file = await storage!.getFileDownload(
        fileId: ID.unique(),
        bucketId:
            '656ae869d99bfcc5afd1', // Ganti dengan ID bucket yang sesuai di Appwrite
      );
      final imageUrl = file['\$url']; // URL gambar dari file di Appwrite
      return imageUrl.toString(); // Pastikan imageUrl adalah String
    } catch (error) {
      throw Exception('Error fetching image URL: $error');
    }
  }

//nyampe sini

  Future storeImage(String imgPath, String imgName) async {
    try {
      final result = await storage!.createFile(
        bucketId: '656ae869d99bfcc5afd1',
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
