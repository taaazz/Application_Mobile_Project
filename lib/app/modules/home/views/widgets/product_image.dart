import 'package:flutter/material.dart';

class ProductImage extends StatefulWidget {
  final String imagePath;

  ProductImage(this.imagePath);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      // Adjust the width as needed
      height: 40, // Adjust the height as needed
      child: Image.asset(
        widget.imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
