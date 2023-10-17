import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';
import '../../../utils/widgets/login_button_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              'lib/aset/images/loading.png', // Sesuaikan dengan path gambar Anda
              fit: BoxFit.cover,
            ),

            // Content
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    width: width,
                    text: "Log In",
                    btnColor: Colors.white,
                    btnTextColor: Colors.black,
                    route: Routes
                        .LOGINDETAIL, // tentukan rute yang ingin Anda arahkan
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                    width: width,
                    text: "Sign Up",
                    btnColor: Colors.brown,
                    btnTextColor: Colors.white,
                    route: Routes
                        .SIGNUPDETAIL, // tentukan rute yang ingin Anda arahkan
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
