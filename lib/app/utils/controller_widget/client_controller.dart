import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:appwrite/appwrite.dart';
import 'package:project/app/data/api/appwrite.dart';
// import 'package:http/http.dart';

class ClientController extends GetxController {
  late Client client;
  late Account account;
  late Databases databases;
  late Storage storage;

  @override
  void onInit() {
    client = Client()
        .setEndpoint(APPWRITE_END_POINT)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
    super.onInit();
  }
}
