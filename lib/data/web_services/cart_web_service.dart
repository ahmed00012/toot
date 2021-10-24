import 'dart:io';

import 'package:dio/dio.dart';

import '../local_storage.dart';

class CartWebServices {
  late Dio dio;

  CartWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: LocalStorage.getData(key: 'token') == null
            ? {
                'Accept': 'application/json',
                'Content-Language': 'ar',
                'X-Requested-With': 'XMLHttpRequest',
              }
            : {
                'Accept': 'application/json',
                'Content-Language': 'ar',
                'X-Requested-With': 'XMLHttpRequest',
                HttpHeaders.authorizationHeader:
                    "Bearer " + LocalStorage.getData(key: 'token')
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

  Future removeFromCart(int? id, String? cardToken, bool? lastItem) async {
    try {
      Response response = await dio.post('cart/remove_product', data: {
        "product_id": "$id",
        "cart_token": "$cardToken",
      });
      if (lastItem!) LocalStorage.removeData(key: 'cart_token');
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> fetchCart() async {
    // try {
    String? cartToken = LocalStorage.getData(key: 'cart_token');
    String? token = LocalStorage.getData(key: 'token');
    print("cartToken  => $cartToken");
    print("Token  => $token");
    Response response = await dio.get('cart/get_cart/$cartToken');
    print(response.data);
    return response.data;
    //     throw response.data['message'];
    //   } else {
    //     print(response.data);
    //     return response.data;
    //   }
    // } on DioError catch (e) {
    //   print(e.response!.data);
    //   throw e.response!.data;
    // }
  }

  Future<dynamic> fetchAddress() async {
    try {
      print(dio.options.headers);
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

  Future<dynamic> fetchDatesAndTimes({int? id}) async {
    try {
      Response response = await dio.get('cart/dates_times/$id');
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> confirmInfoDateAndTime(FormData formData) async {
    try {
      Response response =
          await dio.post('cart/add_delivery_date', data: formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data;
    }
  }

  Future<dynamic> orderStatus(int id) async {
    Response response = await dio.get('orders/$id/details');

    return response.data;
  }
}
