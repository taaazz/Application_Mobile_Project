import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:project/app/data/Models/Product.dart';
import 'package:project/app/data/api/Remote_Services.dart';

void main() {
  group('RemoteServices', () {
    test(
      'fetchProducts returns a list of products if the http call completes successfully',
      () async {
        const sampleResponse = '''
        [
          {
            "id": 123,
            "brand": "maybelline",
            "name": "Sample Product",
            "price": "20",
            "price_sign": null,
            "currency": null,
            "image_link": "https://sample-image-link.com/image.jpg",
            "product_link": "https://sample-product-link.com",
            "website_link": "https://sample-website-link.com",
            "description": "Sample product description",
            "rating": 4.5,
            "category": "sample category",
            "product_type": "sample type",
            "tag_list": ["tag1", "tag2"],
            "created_at": "2023-12-31T23:59:59Z",
            "updated_at": "2023-12-31T23:59:59Z",
            "product_api_url": "https://sample-api-url.com",
            "api_featured_image": "https://sample-featured-image.com/image.jpg",
            "product_colors": [
              {
                "hex_value": "#FFFFFF",
                "colour_name": "White"
              }
            ]
          }
        ]
        ''';

        final mockClient = MockClient((request) async {
          // Ensure the correct URL and method are used
          expect(request.url.toString(),
              'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');
          expect(request.method, 'GET');

          return http.Response(sampleResponse, 200);
        });

        // Set up the MockClient in RemoteServices
        RemoteServices.client = mockClient;

        final products = await RemoteServices.fetchProducts();

        expect(products, isA<List<Product>>());
        // Check if products are not null and contain the expected number of items
        expect(products!.length, 1);

        // Validate details of the first product
        expect(products[0].id, 123);
        expect(products[0].brand, Brand.MAYBELLINE);
        expect(products[0].name, 'Sample Product');
        expect(products[0].price, '20');
        // Add more expectations for other product details
      },
    );

    test('fetchProducts returns null if the http call fails', () async {
      final mockClient = MockClient((request) async {
        // Simulate server error response
        return http.Response('Server error', 500);
      });

      RemoteServices.client = mockClient;

      final products = await RemoteServices.fetchProducts();

      expect(products, isNull);
    });
  });
}
