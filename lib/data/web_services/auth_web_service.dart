import 'package:dio/dio.dart';

class AuthWebServices {
  late Dio dio;

  AuthWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://toot.work/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 60 seconds,
        receiveTimeout: 20 * 1000,
        headers: {
          'Content-Type': 'application/json',
          'Content-Language': 'ar',
        });

    dio = Dio(options);
  }

  Future<dynamic> register(FormData formData) async {
    try {
      Response response = await dio.post('auth/register', data: formData);
      print(response.data.toString());
      return response.data['success'];
    } on DioError catch (e) {
      print(e.response!.data);
      Map errors = e.response!.data['error'];
      if (errors.containsKey('phone') && errors.containsKey('email')) {
        throw ('البريد الالكتروني و رقم الهاتف مُستخدمان من قبل');
      } else if (errors.containsKey('phone')) {
        throw ('رقم الهاتف مُستخدم من قبل');
      } else if (errors.containsKey('email')) {
        throw ('البريد الالكتروني مُستخدم من قبل');
      }
    }
  }

  Future<dynamic> login(FormData formData) async {
    try {
      Response response = await dio.post('auth/login', data: formData);
      print(response.data.toString());
      return response.data['access_token'];
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data['message'];
    }
  }

  Future<dynamic> fetchIntroductionImages() async {
    try {
      Response response = await dio.get('settings/app');
      return response.data['cities_slider'];
    } on DioError catch (e) {
      throw e.response!.data;
    }
  }

  Future<String> otp(FormData formData) async {
    try {
      Response response = await dio.post('auth/verify', data: formData);
      print(response.data.toString());
      return response.data['access_token'];
    } on DioError catch (e) {
      print(e.response!.data);
      throw e.response!.data['message'];
    }
  }
}
