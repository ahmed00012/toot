import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductWebServices {
  late Dio dio;
  static late var token;

  static init() async {
    token = await FlutterSecureStorage().read(key: 'token');
  }

  ProductWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: token == null
            ? {
                'Content-Type': 'application/json',
                'Content-Language': 'ar',
                'X-Requested-With': 'XMLHttpRequest',
              }
            : {
                'Content-Type': 'application/json',
                'Content-Language': 'ar',
                'X-Requested-With': 'XMLHttpRequest',
                HttpHeaders.authorizationHeader: "Bearer " + token
              });

    dio = Dio(options);
  }

  Future<dynamic> fetchCategories({double? lat, double? long}) async {
    try {
      Response response = await dio.get('vendors', queryParameters: {
        'lat': lat ?? 21.543333,
        'long': long ?? 39.172779
      });
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchShopCategories({int? shopId}) async {
    try {
      Response response = await dio.get('vendors/$shopId/categories');
      return response.data['categories'];
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchItems({int? shopId, int? catId, int? page}) async {
    try {
      Response response = await dio.get('vendors/$shopId/$catId/products',
          queryParameters: {'page': page});
      print(dio.options.headers);
      return response.data['data'];
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchItemDetails(int itemId) async {
    try {
      Response response = await dio.get(
        'products/$itemId/details',
      );
      return response.data['product'];
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }
}
