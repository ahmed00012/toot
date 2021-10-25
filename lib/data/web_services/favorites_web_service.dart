import 'dart:io';

import 'package:dio/dio.dart';

import '../local_storage.dart';

class FavoritesWebServices {
  late Dio dio;
  getHeaderWithInToken() {
    return {
      'Accept': 'application/json',
      'Content-Language': 'ar',
      'X-Requested-With': 'XMLHttpRequest',
      HttpHeaders.authorizationHeader:
          "Bearer " + LocalStorage.getData(key: 'token')
    };
  }

  getHeaderWithOutToken() {
    return {
      'Accept': 'application/json',
      'Content-Language': 'ar',
      'X-Requested-With': 'XMLHttpRequest'
    };
  }

  FavoritesWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: LocalStorage.getData(key: 'token') == null
            ? getHeaderWithOutToken()
            : getHeaderWithInToken());

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

  Future<dynamic> fetchFavorites() async {
    print(dio.options.headers);
    try {
      final response = await dio.get('customer/favourite/list');
      return response.data;
    } on DioError catch (e) {
      print(e.response.toString());
      throw (e.response!.data);
    }
  }
}
