import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/routes/app_pages.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 0,
      currentIndex: index,
      onTap: (int index) {
        if (index == 0) {
          Get.toNamed(Routes.HOME);
        } else if (index == 1) {
          Get.toNamed(Routes.IMAGE_PICKER);
        } else if (index == 2) {
          Get.toNamed(Routes.TREND);
        } else if (index == 3) {
          print('No Profile screen yet');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_filled),
          activeIcon: const Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.chat_bubble_text_fill),
          activeIcon: const Icon(CupertinoIcons.chat_bubble_text_fill,
              color: Colors.brown),
          label: 'Review',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          activeIcon: const Icon(Icons.favorite, color: Colors.brown),
          label: 'Trend',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          activeIcon: const Icon(Icons.person, color: Colors.brown),
          label: 'Profile',
        ),
      ],
    );
  }
}
