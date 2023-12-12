import 'package:get/get.dart';
import 'package:project/app/data/Models/Product.dart';
import 'package:project/app/data/api/Remote_Services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      productList.assignAll(products!); // Use assignAll to update the list
    } finally {
      isLoading(false);
    }
  }
}
