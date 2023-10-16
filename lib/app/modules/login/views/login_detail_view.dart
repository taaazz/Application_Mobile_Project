import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/modules/login/controllers/login_controller.dart';

class LoginDetail extends StatelessWidget {
  const LoginDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text(
                  "Image file",
                  style: TextStyle(fontSize: 30),
                ),
              ),

              // image file
              if (controller.image != null) ...[
                Container(
                  height: 350,
                  width: 350,
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Image.file(controller.image!, fit: BoxFit.fitWidth),
                ),
              ] else ...[
                Container(
                  height: 350,
                  width: 350,
                  padding: const EdgeInsets.all(100),
                  margin: const EdgeInsets.only(bottom: 25),
                  child: const CircularProgressIndicator(),
                ),
              ],

              // button
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () async {
                  await controller.getImage();
                },
                child: const Text(
                  'Pick Image',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
