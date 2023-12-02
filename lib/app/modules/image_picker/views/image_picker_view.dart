import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/utils/controller_widget/database_controller.dart';
<<<<<<< HEAD
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
=======
import 'package:project/app/utils/controller_widget/storage_controller.dart';
>>>>>>> e96200fea1f88f6bf3b749f0f62f72cf2a39da69

class ProductReviewScreen extends StatefulWidget {
  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
<<<<<<< HEAD
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
=======
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final StorageController _storageController = Get.put(StorageController());
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int _rating = 0;
  XFile? _imageFile;

<<<<<<< HEAD
=======
  @override
  void initState() {
    super.initState();
    // Set nilai teks controller jika ada data ulasan awal
    if (widget.initialReviewData != null) {
      _productNameController.text = widget.initialReviewData!['nama_produk'];
      _descriptionController.text = widget.initialReviewData!['deskripsi'];
      _priceController.text = widget.initialReviewData!['price'].toString();
      _rating = widget.initialReviewData!['rating'];
    }
>>>>>>> e96200fea1f88f6bf3b749f0f62f72cf2a39da69
  }

>>>>>>> ee3ec5f7c631ac61166e65b61d8c5ddeff2c3eb8
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

<<<<<<< HEAD
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
=======
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
>>>>>>> e96200fea1f88f6bf3b749f0f62f72cf2a39da69
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
