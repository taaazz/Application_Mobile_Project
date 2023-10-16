import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "lib/aset/images/Luskins.png",
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 4,
        ),
      ),
    );
  }
}
