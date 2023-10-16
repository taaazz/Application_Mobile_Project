import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        print('Indonesia button tapped');
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: ClipRRect(
                                child: Image.asset(
                                  'lib/aset/images/vendera.png',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Indonesia',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 120.0),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.LOGINDETAIL);
                      },
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {
                      print('Sign Up tapped');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
