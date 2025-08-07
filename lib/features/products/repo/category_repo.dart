import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_tutorials/core/constant/api_endpoint.dart';
import 'package:riverpod_tutorials/features/products/model/category_model.dart';
import 'package:riverpod_tutorials/features/products/model/product_model.dart';

class CategoryRepo {
  Future<List<CategoryModel>> getCategories() async {
    final url = Uri.parse('${ApiEndpoint.baseUrl}${ApiEndpoint.kCateogies}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseDecode = jsonDecode(response.body) as List;

        List<CategoryModel> categoryList = responseDecode
            .map((value) => CategoryModel.fromJson(value))
            .toList();

        return categoryList;
      } else {
        throw Exception("error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }

  Future<ProductModel> getCategoryProduct(String categoryName) async {
    final url = Uri.parse("${ApiEndpoint.baseUrl}/category/$categoryName");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseDecode = json.decode(response.body);
        print("responseDecode $responseDecode");
        return ProductModel.fromJson(responseDecode);
      } else {
        throw Exception("something went wrong ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error while fetching $e");
    }
  }
}
