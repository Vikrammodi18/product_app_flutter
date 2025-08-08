import 'dart:convert';

import 'package:riverpod_tutorials/core/constant/api_endpoint.dart';
import 'package:riverpod_tutorials/features/products/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<ProductModel> fetchProduct() async {
    try {
      final url = Uri.parse("${ApiEndpoint.baseUrl}/?limit=50&skip=20");
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

  Future<Product> fetchProductDetails({required String id}) async {
    try {
      final url = Uri.parse("${ApiEndpoint.baseUrl}/$id");
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

  Future<ProductModel> fetchSearchPrduct({required String items}) async {
    try {
      final url = Uri.parse("${ApiEndpoint.baseUrl}/search?q=$items");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseDecode = json.decode(response.body);
        return ProductModel.fromJson(responseDecode);
      } else {
        throw Exception("items not found ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error while fetching searched Items $e");
    }
  }
}
