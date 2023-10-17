import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/utils/widgets/bottom_nav_bar.dart';

class ProductReview {
  String name;
  double price;
  String imageUrl;
  double rating;
  String description;

  ProductReview({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
  });
}

class ProductReviewScreen extends StatefulWidget {
  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  List<ProductReview> _productReviews = [];

  Future<void> _addReview() async {
    final picker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print('Error picking image: $e');
      return;
    }

    if (pickedFile != null) {
      // Prompt user for review details
      final review = await _getReviewDetails(pickedFile.path);
      if (review != null) {
        setState(() {
          _productReviews.add(review);
        });
      }
    }
  }

  Future<ProductReview?> _getReviewDetails(String imagePath) async {
    return showDialog<ProductReview>(
      context: context,
      builder: (context) {
        String name = '';
        String description = '';
        double price = 0.0;
        double rating = 0.0;

        return AlertDialog(
          title: Text('Add Review'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  onChanged: (value) {
                    price = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  onChanged: (value) {
                    rating = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Rating (0-5)'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (rating < 0 || rating > 5) {
                      // Show an error message for invalid rating
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid rating!')),
                      );
                      return;
                    }
                    Navigator.of(context).pop(
                      ProductReview(
                        name: name,
                        price: price,
                        imageUrl: imagePath,
                        rating: rating,
                        description: description,
                      ),
                    );
                  },
                  child: Text('Submit Review'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Reviews',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _productReviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(
              File(_productReviews[index].imageUrl),
              width: 50,
              height: 50,
            ),
            title: Text(_productReviews[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${_productReviews[index].name}'),
                Text('Price: \$${_productReviews[index].price}'),
                Text('Rating: ${_productReviews[index].rating}'),
                Text('Description: ${_productReviews[index].description}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        tooltip: 'Add Review',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(index: 1),
    );
  }
}
