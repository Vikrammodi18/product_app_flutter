import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_tutorials/core/constant/api_endpoint.dart';
import 'package:riverpod_tutorials/features/cart/model/cart_model.dart';

class CartRepo {
  Future<CartModel> fetchCartData() async {
    final url = Uri.parse(ApiEndpoint.kCart);
    try {
        final response = await http.get(url);
    if (response.statusCode == 200) {
      final responseDecode = jsonDecode(response.body);
      return CartModel.fromJson(responseDecode);
    } else {
      throw Exception("unable to fetch cart data ${response.body}");
    }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
