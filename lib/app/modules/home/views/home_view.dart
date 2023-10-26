import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../../../utils/widgets/bottom_nav_bar.dart';
import '../../../utils/widgets/productCard.dart';
import 'widgets/product_image.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          padding: EdgeInsets.only(top: 25, right: 16, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: ClipRRect(
                      child: Image.asset(
                        'lib/aset/images/Luskins.png',
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
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.cart,
                          color:
                              Colors.black, // Suggested change for visibility
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.WEBVIEW_PAGE);
                        },
                        child: Container(
                          width: 400, // Lebar container sesuaikan dengan gambar
                          height:
                              200, // Tinggi container sesuaikan dengan gambar
                          child: Image.asset(
                            'lib/aset/images/Banner.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.WEBVIEW_PAGE);
                        },
                        child: Container(
                          width: 400, // Lebar container sesuaikan dengan gambar
                          height:
                              200, // Tinggi container sesuaikan dengan gambar
                          child: Image.asset(
                            'lib/aset/images/Banner-2.png',
                            fit: BoxFit.cover,
                          ),
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
                              Get.toNamed(Routes.PRODUCT);
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black,
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
                              Get.toNamed(Routes.PRODUCT);
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(index: 0),
    );
  }
}
