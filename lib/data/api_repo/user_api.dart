import 'dart:math';

import 'package:api_practice/data/model/user_model.dart';
import 'package:dio/dio.dart';

class UserApi {
  final Dio _dio = Dio();
  // final String _url = "https://jsonplaceholder.typicode.com/users/$userID/";

  Future<UserModel> fetchUserList() async {
    int userID = Random().nextInt(10);
    try {
      Response response =
          await _dio.get("https://jsonplaceholder.typicode.com/users/$userID/");
      return UserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception: $error stackTrace: $stacktrace");
      return UserModel();
    }
  }
}
