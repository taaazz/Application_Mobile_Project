import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:appwrite/appwrite.dart';
// import 'package:http/http.dart';

class ClientController extends GetxController {
  Client client = Client();
  @override
  void onInit() {
    super.onInit();
// appwrite
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectID = "65659bad478c88787a1c";
    client
        .setEndpoint(endPoint)
        .setProject(projectID)
        .setSelfSigned(status: true);
  }
}
