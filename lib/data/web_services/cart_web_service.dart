import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        headers: token == null
            ? {
                'Accept': 'application/json',
                'Content-Language': 'ar',
                'X-Requested-With': 'XMLHttpRequest',
              }
            : {
                'Accept': 'application/json',
                'Content-Language': 'ar',
                'X-Requested-With': 'XMLHttpRequest',
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

  Future<dynamic> addAddress(FormData formData) async {
    try {
      Response response = await dio.post('cart/add_address', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> selectAddress(FormData formData) async {
    try {
      Response response = await dio.post('cart/choose_address', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchPayments() async {
    try {
      Response response = await dio.get('cart/payment_method');
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> selectPayment(FormData formData) async {
    try {
      Response response = await dio.post('cart/add_payment', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> confirmOrder(FormData formData) async {
    try {
      Response response = await dio.post('cart/confirm', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> promoCode(FormData formData) async {
    try {
      Response response = await dio.post('cart/add_coupon', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }
}
