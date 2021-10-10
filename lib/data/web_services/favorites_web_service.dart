import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoritesWebServices {
  late Dio dio;
  static late var token;

  static init() async {
    token = await FlutterSecureStorage().read(key: 'token');
  }

  FavoritesWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: {
          'Content-Type': 'application/json',
          'Content-Language': 'ar',
          'X-Requested-With': 'XMLHttpRequest',
          HttpHeaders.authorizationHeader: "Bearer " + token
        });

    dio = Dio(options);
  }

  Future<bool> toggleFavoriteStatus(FormData formData) async {
    try {
      print(dio.options.headers);
      Response response =
          await dio.post('customer/favourite/toggle', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.response.toString());
      return false;
    }
  }

  Future<dynamic> fetchFavorites() async {
    try {
      final response = await dio.get('customer/favourite/list');
      return response.data;
    } on DioError catch (e) {
      print(e.response.toString());
      throw (e.response!.data);
    }
  }
}
