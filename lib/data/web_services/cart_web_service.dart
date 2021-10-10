import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../local_storage.dart';

class CartWebServices {
  late Dio dio;
  static late var token;

  static init() async {
    token = await FlutterSecureStorage().read(key: 'token');
  }

  CartWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: LocalStorage.getData(key: 'token') == null
            ? {
                'Accept': 'application/json',
              }
            : {
                'Accept': 'application/json',
                HttpHeaders.authorizationHeader: "Bearer " + token
              });

    dio = Dio(options);
  }
  Future<dynamic> addToCart(FormData formData) async {
    try {
      Response response = await dio.post('cart/add_product', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> removeFromCart(FormData formData) async {
    try {
      Response response = await dio.post('cart/remove_product', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchCart() async {
    try {
      String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
      Response response = await dio.get('cart/get_cart/${cartToken ?? ''}');
      print(response.data);
      if (response.data['success'] == 0) {
        throw response.data['message'];
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchAddress() async {
    try {
      Response response = await dio.get('customer/addresses');
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }
}
