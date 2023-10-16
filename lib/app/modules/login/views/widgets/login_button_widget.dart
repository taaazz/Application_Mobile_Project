import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.text,
    this.btnColor,
    this.btnTextColor,
    required this.route, // tambahkan parameter route
  }) : super(key: key);

  final double width;
  final String text;
  final Color? btnColor;
  final Color? btnTextColor;
  final String route; // tambahkan variabel route

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * .8,
      height: 50,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(route); // gunakan route yang diberikan
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: btnTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
