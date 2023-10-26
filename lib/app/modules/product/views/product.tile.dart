import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/Models/Product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8.0),
      child: Container(
        height: 250,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            product.imageLink), // Menggunakan gambar dari URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Obx(() => CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: product.isFavorite.value
                              ? const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors
                                      .red, // Ganti warna ikon hati jika sudah difavoritkan
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors
                                      .black, // Ganti warna ikon hati jika belum difavoritkan
                                ),
                          onPressed: () {
                            product.isFavorite
                                .toggle(); // Mengganti status favorit saat ikon ditekan
                          },
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      color: Colors.black, // Mengganti warna teks
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                          color: Colors.black, // Mengganti warna teks
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          border: Border.all(
                            width: 0.5,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
