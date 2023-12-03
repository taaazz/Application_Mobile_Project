import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/utils/controller_widget/database_controller.dart';
import 'package:project/app/utils/controller_widget/storage_controller.dart';

class ProductReviewScreen extends StatefulWidget {
  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final StorageController _storageController = Get.put(StorageController());
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int _rating = 0;
  XFile? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _getImage(ImageSource
                      .gallery); // Panggil _getImage dengan ImageSource.gallery
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _getImage(ImageSource
                      .camera); // Panggil _getImage dengan ImageSource.camera
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadReview() async {
    if (_imageFile != null) {
      final String imagePath = _imageFile!.path;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Product Details'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _productNameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                  Slider(
                    value: _rating.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (value) {
                      setState(() {
                        _rating = value.toInt();
                      });
                    },
                    label: 'Rating: $_rating',
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final String productName = _productNameController.text;
                  final String description = _descriptionController.text;
                  final int price = int.tryParse(_priceController.text) ?? 0;

                  if (price >= 1 && price <= 100000) {
                    final Map<String, dynamic> reviewData = {
                      'nama_produk': productName,
                      'deskripsi': description,
                      'price': price,
                      'rating': _rating,
                    };

                    await _storageController.storeImage(
                      imagePath,
                      'product_review_image.jpg',
                    );
                    await _databaseController.storeReview(reviewData);

                    Navigator.of(context).pop(); // Close dialog
                    _navigateToProductReviewList(); // Navigate to review list
                  } else {
                    Get.snackbar(
                      'Error',
                      'Price must be between 1 and 100,000',
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    } else {
      Get.snackbar('Error', 'Please select an image');
    }
  }

  void _navigateToProductReviewList() {
    Get.to(ProductReviewListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product Review'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                _showImagePicker();
              },
              child: _imageFile != null
                  ? Image.file(
                      File(_imageFile!.path),
                      height: 200.0,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 200.0,
                      color: Colors.grey[300],
                      child: Icon(Icons.camera_alt, size: 50.0),
                      alignment: Alignment.center,
                    ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _uploadReview(); // Memanggil modal untuk memilih gambar
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductReviewListScreen extends StatelessWidget {
  final DatabaseController _databaseController = Get.put(DatabaseController());

  ProductReviewListScreen({super.key});

  void _editReview(Map<String, dynamic> review) {
    _databaseController.updateReview(review['documentId'], review);
  }

  void _deleteReview(Map<String, dynamic> review) {
    _databaseController.deleteReview(review['documentId']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Reviews'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Get.find<DatabaseController>().getReviewData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reviews available'));
          } else {
            // Jika data tersedia, tampilkan dalam ListView
            List<Map<String, dynamic>> reviewData = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              itemCount: reviewData.length,
              itemBuilder: (context, index) {
                final review = reviewData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        review['imagePath'] != null
                            ? Image.network(
                                review[
                                    'product_review_image.jpg'], // Gunakan URL gambar dari data review
                                height: 200.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                // Tampilkan placeholder jika tidak ada URL gambar
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 244, 240, 240),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(Icons.image, size: 50.0),
                                alignment: Alignment.center,
                              ),
                        SizedBox(height: 8.0),
                        Text(
                          review['nama_produk'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          review['deskripsi'],
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Rp ${review['price'].toStringAsFixed(0)}',
                          style: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            _buildStarRating(review['rating']),
                          ],
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) {
                        return ['Edit', 'Delete'].map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                      onSelected: (String choice) {
                        if (choice == 'Edit') {
                          _editReview(review); // Panggil fungsi untuk edit
                        } else if (choice == 'Delete') {
                          _deleteReview(review); // Panggil fungsi untuk delete
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildStarRating(int rating) {
    List<Widget> starIcons = [];

    // Membuat icon full star sesuai dengan rating
    for (int i = 0; i < rating; i++) {
      starIcons.add(
        Icon(
          Icons.star,
          color: Color.fromARGB(255, 255, 230, 3),
        ),
      );
    }

    // Menambahkan icon half star jika diperlukan
    if (rating % 1 != 0) {
      starIcons.add(
        Icon(
          Icons.star_half,
          color: Color.fromARGB(255, 255, 230, 0),
        ),
      );
    }

    // Mengisi sisa icon dengan empty star
    while (starIcons.length < 5) {
      starIcons.add(
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 255, 230, 3),
        ),
      );
    }

    return Row(children: starIcons);
  }
}
