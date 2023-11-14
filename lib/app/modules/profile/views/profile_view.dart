import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:project/app/utils/widgets/bottom_nav_bar.dart';

import '../../../utils/widgets/bottom_nav_bar.dart';
import '../../login/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logout();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(index: 3),
    );
  }
}
