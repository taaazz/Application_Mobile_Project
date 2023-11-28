import 'package:get/get.dart';
import 'package:http/http.dart';

class ClientController extends GetxController {
  //TODO: Implement ClientController

  final count = 0.obs;

  final endPoint = "https://cloud.appwrite.io/v1";
  final projectID = "65659bad478c88787a1c";
  late final Client client;

  // @override
  // void onInit() {
  //   super.onInit();
  //   client = Client();
  //   client.setEndpoint(endPoint).setProject(projectID).setSelfSigned(status: true);
  // }

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
