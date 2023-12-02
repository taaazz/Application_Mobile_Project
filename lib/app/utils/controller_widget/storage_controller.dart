import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:project/app/utils/controller_widget/client_controller.dart';
=======

import 'client_controller.dart';
>>>>>>> 33dfb321425613a61af7c78c9955f281dee48af6

class StorageController extends ClientController {
  Storage? storage;
  @override
  void onInit() {
    super.onInit();
// appwrite
    storage = Storage(client);
  }

  Future storeImage(String imgPath, String imgName) async {
    try {
      final result = await storage!.createFile(
<<<<<<< HEAD
        bucketId: '6566c841487a3f65533c',
=======
        bucketId: '656ae869d99bfcc5afd1',
>>>>>>> 33dfb321425613a61af7c78c9955f281dee48af6
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
