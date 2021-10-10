import 'dart:io';

import 'package:dio/dio.dart';

import '../local_storage.dart';

class FavoritesWebServices {
  late Dio dio;

  FavoritesWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: LocalStorage.getData(key: 'token') == null
            ? {
                'X-Requested-With': 'XMLHttpRequest',
                'Content-Type': 'application/json',
                'Content-Language': 'ar',
              }
            : {
                'X-Requested-With': 'XMLHttpRequest',
                'Content-Type': 'application/json',
                'Content-Language': 'ar',
                HttpHeaders.authorizationHeader:
                    "Bearer" + LocalStorage.getData(key: 'token')
              });

    dio = Dio(options);
  }

  Future<bool> toggleFavoriteStatus(FormData formData) async {
    try {
      Response response =
          await dio.post('customer/favourite/toggle', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.response.toString());
      return false;
    }
  }

  Future<List<dynamic>> fetchFavorites() async {
    try {
      final response = await dio.get('customer/favourite/list');
      return response.data;
    } on DioError catch (e) {
      print(e.response.toString());
      return [];
    }
  }
}
