import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/pages/main_home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/MainHomepage': (context) => MainHomepage(),
      },
    );
  }
}
