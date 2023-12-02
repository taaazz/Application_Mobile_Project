import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/utils/controller_widget/database_controller.dart';
import 'package:project/app/utils/controller_widget/storage_controller.dart';

class ProductReviewScreen extends StatefulWidget {
  final Map<String, dynamic>? initialReviewData; // Data ulasan awal

  ProductReviewScreen({this.initialReviewData});

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
  }

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
      final String productName = _productNameController.text;
      final String description = _descriptionController.text;
      final int price = int.parse(_priceController.text);

      // Periksa apakah harga berada dalam rentang yang valid
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
      } else {
        // Tampilkan pesan kesalahan jika harga di luar rentang yang valid
        Get.snackbar('Error', 'Price must be between 1 and 100,000');
      }
    } else {
      // Show error if image is not selected
      Get.snackbar('Error', 'Please select an image');
    }
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadReview,
              child: Text('Upload Review'),
            ),
          ],
        ),
      ),
    );
  }
}
