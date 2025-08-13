import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:riverpod_tutorials/core/services/preference_manager.dart';
import 'package:riverpod_tutorials/features/auth/model/user_model.dart';
import 'package:riverpod_tutorials/core/constant/api_endpoint.dart';

class AuthRepo {
  Future<UserModel> postApiRequest(final credentials) async {
    final url = Uri.parse(ApiEndpoint.kLogin);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(credentials),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return UserModel.fromJson(jsonResponse);
      } else {
        throw Exception("unable to login ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error while login $e");
    }
  }

  Future<bool> logout() async {
    await PreferenceManager.instance.clearAccessToken();
    return false;
  }
}
