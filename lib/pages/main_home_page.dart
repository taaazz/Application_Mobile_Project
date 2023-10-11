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
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 5.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.brown.shade400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 18, right: 18),
                      child: Row(
                        children: [
                          Container(
                            height: 250,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Border radius untuk gambar
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'lib/aset/product/serum1.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Serum Somethinc Retinol',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'RP. 100.000',
                                            style: TextStyle(
                                                color: Colors.brown,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Container(
                                            width: 40, // Lebar container
                                            height: 40, // Tinggi container
                                            decoration: BoxDecoration(
                                              shape: BoxShape
                                                  .circle, // Menggunakan bentuk lingkaran
                                              color: Colors.brown.shade700,
                                              border: Border.all(
                                                // Warna garis
                                                width: 0.5, // Lebar garis
                                              ), // Warna latar belakang lingkaran
                                            ),
                                            child: Center(
                                              child: Icon(
                                                CupertinoIcons.bag,
                                                color:
                                                    Colors.white, // Warna ikon
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
