import 'dart:developer';

import 'package:vendify_widgets_package/classes/products/product.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class ProductsApi extends BaseApi {
  static const String productsEndpoint = 'products';

  Future<List<ProductModel?>> getProducts() async {
    try {
      String response = await BaseApi.get("$productsEndpoint/", withToken: true);
      List<ProductModel> products = productModelFromJson(response);
      return products;
    } catch (e) {
      log("Error getting products: $e");
      return [];
    }
  }
}
