import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/utils/controller_widget/database_controller.dart';
import 'package:project/app/utils/controller_widget/storage_controller.dart';

import '../../../utils/widgets/bottom_nav_bar.dart';
import '../controllers/image_picker_controller.dart';

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
  final TextEditingController _ratingController = TextEditingController();

  XFile? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      _uploadReview();
    }
  }

  Future<void> _uploadReview() async {
    if (_imageFile != null) {
      // final String imagePath = _imageFile!.path;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tulis Review Kamu'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _productNameController,
                    onChanged: (value) {
                      // You can handle onChanged event if needed
                    },
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    onChanged: (value) {
                      // You can handle onChanged event if needed
                    },
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // You can handle onChanged event if needed
                    },
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                  TextField(
                    controller: _ratingController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // You can handle onChanged event if needed
                    },
                    decoration: InputDecoration(labelText: 'Rating (0-5)'),
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
                  final int rating = int.tryParse(_ratingController.text) ?? 0;

                  if (price >= 1 && price <= 100000) {
                    final Map<String, dynamic> reviewData = {
                      'nama_produk': productName,
                      'deskripsi': description,
                      'price': price,
                      'rating': rating,
                    };

                    //aku tambahin baru di sini

                    // Fungsi untuk mengupdate review dengan gambar
                    void updateReviewWithImage(
                        String imagePath, Map<String, dynamic> review) async {
                      try {
                        //     // Simpan gambar ke storage Appwrite
                        //     await _storageController.storeImage(
                        //       imagePath,
                        //       'product_review_image.jpg', // Ganti dengan nama file yang sesuai
                        //     );

                        //     // Dapatkan URL gambar dari Appwrite setelah disimpan

                        //     // String imageUrl =
                        //     //     await _storageController.getImageUrl('imagePath');

                        //     // // Update data review dengan URL gambar baru
                        //     // review['imagePath'] = imageUrl;

                        //     // Panggil fungsi untuk update review
                        _databaseController.updateReview(
                            review['\$id'], review);
                      } catch (error) {
                        // Tangani kesalahan jika terjadi
                        print("Error updating review with image: $error");
                      }
                    }

                    //buat nyimpen di storage
                    await _storageController.storeImage(
                      _imageFile!.path,
                      'product_review_image.jpg',
                    );
                    await _databaseController.storeReview(reviewData);

                    Navigator.of(context).pop(); // Close dialog
                  } else {
                    Get.snackbar(
                      'Error',
                      'Price must be between 1 and 100,000,000',
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

  void _updateReview(Map<String, dynamic> review) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController ratingController = TextEditingController();

    productNameController.text = review['nama_produk'];
    descriptionController.text = review['deskripsi'];
    priceController.text = review['price'].toString();
    ratingController.text = review['rating'].toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Review'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: productNameController,
                  onChanged: (value) {
                    // You can handle onChanged event if needed
                  },
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: descriptionController,
                  onChanged: (value) {
                    // You can handle onChanged event if needed
                  },
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // You can handle onChanged event if needed
                  },
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: ratingController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // You can handle onChanged event if needed
                  },
                  decoration: InputDecoration(labelText: 'Rating (0-5)'),
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
                final String productName = productNameController.text;
                final String description = descriptionController.text;
                final int price = int.tryParse(priceController.text) ?? 0;
                final int rating = int.tryParse(ratingController.text) ?? 0;

                if (price >= 1 && price <= 100000) {
                  final Map<String, dynamic> updatedReviewData = {
                    'nama_produk': productName,
                    'deskripsi': description,
                    'price': price,
                    'rating': rating,
                  };

                  // Panggil fungsi untuk update review
                  String documentId = review['\$id'];
                  _databaseController.updateReview(
                      documentId, updatedReviewData);

                  Navigator.of(context).pop(); // Close dialog
                } else {
                  Get.snackbar(
                    'Error',
                    'Price must be between 1 and 100,000,000',
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteReview(Map<String, dynamic> review) {
    String documentId = review['\$id'];
    _databaseController.deleteReview(documentId);
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Review Product',
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _databaseController.getReviewData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching data'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No reviews available'));
            } else {
              List<Map<String, dynamic>> reviewData = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount:
                    reviewData.length + 1, // Tambahan satu item untuk FAB
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FloatingActionButton.extended(
                        onPressed: _showImagePicker,
                        label: Text(
                          'Upload Image',
                          style: TextStyle(
                              color: Colors.white), // Ubah warna teks label
                        ),
                        icon: Icon(Icons.add_a_photo),
                        backgroundColor:
                            Colors.black, // Ubah warna background button
                      ),
                    );
                  }

                  final review = reviewData[index - 1];
                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Menyesuaikan radius card
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        review['imagePath'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        10.0)), // Menyesuaikan radius gambar
                                child: Image.network(
                                  review[
                                      'url'], // Gunakan URL gambar dari data review
                                  height: 150.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                // Tampilkan placeholder jika tidak ada URL gambar
                                height: 150.0,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 243, 243, 243),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          10.0)), // Menyesuaikan radius gambar
                                ),
                                child: Icon(Icons.image, size: 50.0),
                                alignment: Alignment.center,
                              ),
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    icon: Icon(Icons.more_vert),
                                    itemBuilder: (BuildContext context) {
                                      return ['Edit', 'Delete']
                                          .map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (String choice) {
                                      if (choice == 'Edit') {
                                        _updateReview(
                                            review); // Panggil fungsi untuk edit
                                      } else if (choice == 'Delete') {
                                        _deleteReview(
                                            review); // Panggil fungsi untuk delete
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Rp ${review['price'].toStringAsFixed(0)}',
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  _buildStarRating(review['rating']),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavBar(index: 1),
      );
    });
  }
}
