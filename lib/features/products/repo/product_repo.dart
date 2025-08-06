import 'dart:convert';

import 'package:riverpod_tutorials/features/products/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  final String baseurl = "https://dummyjson.com";
  Future<ProductModel> fetchProduct() async {
    try {
      final url = Uri.parse("$baseurl/products");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final data = ProductModel.fromJson(decodedJson);

        return data;
      } else {
        throw Exception("failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error fetching $e");
    }
  }

  Future<Product> FetchProductDetails({required String id}) async {
    try {
      final url = Uri.parse("$baseurl/products/$id");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonresponse = json.decode(response.body);
        return Product.fromJson(jsonresponse);
      } else {
        throw Exception("unable to fetch ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error fetching $e");
    }
  }
}
