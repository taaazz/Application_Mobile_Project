import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/bottom_nav_bar.dart';
import 'package:project/widgets/productCard.dart';
import 'package:project/widgets/product_image.dart';

class MainHomepage extends StatelessWidget {
  const MainHomepage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: const BottomNavBar(index: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
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
                              shape: BoxShape
                                  .circle, // Menggunakan bentuk lingkaran
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
              Container(
                child: SingleChildScrollView(
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
              ),
              Container(
                color: Colors.white, // Background color white
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductImage('lib/aset/logo/scarlett.webp'),
                      ProductImage('lib/aset/logo/somethinc.png'),
                      ProductImage('lib/aset/logo/aubree.webp'),
                      ProductImage('lib/aset/logo/Avoskin_Logo.png'),
                      ProductImage('lib/aset/logo/wardah.png'),
                      ProductImage('lib/aset/logo/Npure.jpg'),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 8),
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
                          InkWell(
                            onTap: () {
                              // Handle sign up tap
                              print('See All tapped');
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.brown,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(
                              imageAsset: 'lib/aset/product/or1.jpg',
                              productName: 'The Ordinary Moisturizer',
                              productPrice: 'RP. 270.000',
                            ),
                            ProductCard(
                              imageAsset: 'lib/aset/product/skintint.png',
                              productName: 'Somethinc Salmon DNA',
                              productPrice: 'RP. 120.000',
                            ),
                            ProductCard(
                              imageAsset: 'lib/aset/product/2.webp',
                              productName: 'The Ordinary Serum',
                              productPrice: 'RP. 500.000',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Product',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Handle sign up tap
                              print('See tapped');
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.brown,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(
                              imageAsset: 'lib/aset/product/or1.jpg',
                              productName: 'The Ordinary Moisturizer',
                              productPrice: 'RP. 270.000',
                            ),
                            ProductCard(
                              imageAsset: 'lib/aset/product/skintint.png',
                              productName: 'Somethinc Salmon DNA',
                              productPrice: 'RP. 120.000',
                            ),
                            ProductCard(
                              imageAsset: 'lib/aset/product/2.webp',
                              productName: 'The Ordinary Serum',
                              productPrice: 'RP. 500.000',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
