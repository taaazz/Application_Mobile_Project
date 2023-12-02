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

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  Future<void> _uploadReview() async {
    if (_imageFile != null) {
      final String imagePath = _imageFile!.path;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Product Details'),
            content: Column(
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
                  final int price = int.parse(_priceController.text);

                  if (price >= 1 && price <= 100000) {
                    final Map<String, dynamic> reviewData = {
                      'nama_produk': productName,
                      'deskripsi': description,
                      'price': price,
                      'rating': _rating,
                    };

                    await _storageController.storeImage(
                        imagePath, 'product_review_image.jpg');
                    await _databaseController.storeReview(reviewData);

                    Navigator.of(context).pop(); // Tutup dialog
                    _navigateToProductReviewList(); // Pindah ke halaman daftar review
                  } else {
                    Get.snackbar(
                        'Error', 'Price must be between 1 and 100,000');
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
              onTap: _getImage,
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
        onPressed: _uploadReview,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductReviewListScreen extends StatelessWidget {
  final DatabaseController _databaseController = Get.find<
      DatabaseController>(); // Menggunakan instance DatabaseController yang sama

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
              itemCount: reviewData.length,
              itemBuilder: (context, index) {
                final review = reviewData[index];
                return ListTile(
                  title: Text(review['nama_produk']),
                  subtitle: Text(review['deskripsi']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
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
                            // Tambahkan logika untuk fungsi edit di sini
                            _editReview(
                                review); // Fungsi _editReview belum dibuat
                          } else if (choice == 'Delete') {
                            // Tambahkan logika untuk fungsi delete di sini
                            _deleteReview(
                                review); // Fungsi _deleteReview belum dibuat
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
