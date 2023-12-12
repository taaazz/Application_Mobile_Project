import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project/app/data/Models/Product.dart';
import 'package:project/app/data/api/Remote_Services.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient((request) async {
      return http.Response('{"message": "Custom response"}', 200);
    });
  });

  group('RemoteServices', () {
    test(
        'Products returns a list of products if the http call completes successfully',
        () async {
      const sampleResponse = '''
      [
        {
          "id": 123,
          "brand": "maybelline",
          "name": "Sample Product",
          "price": "20",
          // ... (rest of the sample JSON)
        }
      ]
    ''';

      when(mockClient.get(Uri.parse(
              'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline')))
          .thenAnswer((_) async => http.Response(sampleResponse, 200));

      final products = await RemoteServices.fetchProducts();

      expect(products, isA<List<Product>>());
      expect(products!.length, 1);
      // Ensure that the product details match the expected data
      expect(products[0].id, 123);
      expect(products[0].brand, Brand.MAYBELLINE);
      expect(products[0].name, 'Sample Product');
      // ... other expectations for product details

      // Verify if the color details of the product match the expected data
      expect(products[0].productColors.length, 1);
      expect(products[0].productColors[0].hexValue, '#FFFFFF');
      expect(products[0].productColors[0].colourName, 'White');
    });

    test('Products returns null if the http call fails', () async {
      when(mockClient.get(Uri.parse(
              'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline')))
          .thenAnswer((_) async => http.Response('Server error', 500));

      // ignore: unused_local_variable
      final remoteService = RemoteServices(mockClient);
      final products = await RemoteServices.fetchProducts();

      expect(products, isNull);
    });
  });
}
