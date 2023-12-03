import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/app/modules/splash/bindings/splash_binding.dart';
import 'package:project/app/utils/controller_widget/database_controller.dart';
import 'package:project/app/utils/widgets/notification_handler.dart';
import 'package:project/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/login/controllers/Auth_controller.dart';
import 'app/routes/app_pages.dart';
// import 'package:appwrite/appwrite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  final AuthController _authController = Get.put(AuthController());
  final DatabaseController databaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: _authController.isLoggedIn.value
          ? Routes.HOME // Jika pengguna telah login, buka halaman HOME
          : Routes.LOGIN,
      getPages: AppPages.routes,
      initialBinding: SplashBinding(),
    );
  }
}
