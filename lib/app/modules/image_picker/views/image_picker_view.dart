import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/utils/controller_widget/database_controller.dart';
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
  late DatabaseController _databaseController;

  @override
  void initState() {
    super.initState();
    _databaseController =
        Get.find<DatabaseController>(); // Inisialisasi DatabaseController
  }

  final DatabaseController databaseController = Get.put(DatabaseController());

  Future<void> _addReview() async {
    final picker = ImagePicker();
    XFile? pickedFile;

    // Tampilkan dialog untuk memilih sumber gambar (kamera atau galeri)
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile == null) {
                        // User tidak memilih gambar
                        return;
                      }
                      // Prompt user for review details
                      final review = await _getReviewDetails(pickedFile!.path);
                      if (review != null) {
                        await _databaseController.storeUserName({
                          'name': review.name,
                          'price': review.price,
                          'imageUrl': review.imageUrl,
                          'rating': review.rating,
                          'description': review.description,
                        });
                        setState(() {
                          _productReviews.add(review);
                        });
                      }
                    } catch (e) {
                      print('Error picking image from camera: $e');
                    }
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile == null) {
                        // User tidak memilih gambar
                        return;
                      }
                      // Prompt user for review details
                      final review = await _getReviewDetails(pickedFile!.path);
                      if (review != null) {
                        setState(() {
                          _productReviews.add(review);
                        });
                      }
                    } catch (e) {
                      print('Error picking image from gallery: $e');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<ProductReview?> _getReviewDetails(String imagePath) async {
    return showDialog<ProductReview>(
      context: context,
      builder: (context) {
        String name = '';
        String description = '';
        double price = 0;
        double rating = 0;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Product Reviews',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
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
          int fullStars = _productReviews[index].rating.floor();
          double remainingStars = _productReviews[index].rating - fullStars;
          List<Widget> starIcons = List.generate(fullStars, (index) {
            return Icon(
              Icons.star,
              color: Color.fromARGB(255, 255, 230, 3),
            );
          });

          // Add a half star if remainingStars > 0
          if (remainingStars > 0) {
            starIcons.add(
              Icon(
                Icons.star_half,
                color: Color.fromARGB(255, 255, 230, 0),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_productReviews[index].imageUrl),
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  _productReviews[index].name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Rp ${_productReviews[index].price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
                Row(
                  children: starIcons,
                ),
                Text('${_productReviews[index].description}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        tooltip: 'Add Review',
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
      bottomNavigationBar: BottomNavBar(index: 1),
    );
  }
}
