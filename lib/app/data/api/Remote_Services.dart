import 'package:http/http.dart' as http;
import 'package:http/src/mock_client.dart';
import 'package:project/app/data/Models/Product.dart';

class RemoteServices {
  static var client = http.Client();

  RemoteServices(MockClient mockClient);

  static Future<List<Product>?> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
