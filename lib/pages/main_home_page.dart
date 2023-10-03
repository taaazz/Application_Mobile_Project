import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomepage extends StatelessWidget {
  const MainHomepage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: ClipRRect(
                          child: Image.asset(
                            'lib/aset/images/Luskins.png', // Fixed image asset path
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 100,
                        height: 20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 40, // Lebar container
                          height: 40, // Tinggi container
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle, // Menggunakan bentuk lingkaran
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey, // Warna garis
                              width: 0.5, // Lebar garis
                            ),
                            // Warna latar belakang lingkaran
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.search,
                              color: Colors.black, // Warna ikon
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 40, // Lebar container
                        height: 40, // Tinggi container
                        decoration: BoxDecoration(
                          shape:
                              BoxShape.circle, // Menggunakan bentuk lingkaran
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey, // Warna garis
                            width: 0.5, // Lebar garis
                          ), // Warna latar belakang lingkaran
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.bell,
                            color: Colors.black, // Warna ikon
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 400, // Lebar container sesuaikan dengan gambar
                    height: 200, // Tinggi container sesuaikan dengan gambar
                    child: Image.asset(
                      'lib/aset/images/Banner.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 400, // Lebar container sesuaikan dengan gambar
                    height: 200, // Tinggi container sesuaikan dengan gambar
                    child: Image.asset(
                      'lib/aset/images/Banner-2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white, // Background color white
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProductImage('lib/aset/logo/scarlett.webp'),
                    ProductImage('lib/aset/logo/Npure.jpg'),
                    ProductImage('lib/aset/logo/Avoskin_Logo.png'),
                    ProductImage('lib/aset/logo/wardah.png'),
                    ProductImage('lib/aset/logo/somethinc.png'),
                    ProductImage('lib/aset/logo/aubree.webp'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imagePath;

  ProductImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 70, // Adjust the width as needed
      height: 50, // Adjust the height as needed
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
