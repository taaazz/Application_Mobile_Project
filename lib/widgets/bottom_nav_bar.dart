import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey.withAlpha(100),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MainHomepage');
                // Navigator.pushNamed(context, MainHomepage.routeName);
              },
              icon: const Icon(Icons.home_filled),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Container(
            child: IconButton(
              onPressed: () {
                print('No Wishlist screen yet');
              },
              icon: const Icon(CupertinoIcons.heart_fill),
            ),
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Container(
            child: IconButton(
              onPressed: () {
                print('No Wishlist screen yet');
              },
              icon: const Icon(Icons.notifications),
            ),
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Container(
            child: IconButton(
              onPressed: () {
                print('No Wishlist screen yet');
              },
              icon: const Icon(Icons.person),
            ),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
