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
      return response.data['success'];
    } on DioError catch (e) {
      throw e.response!.data['error'];
      // Map errors = e.response!.data['error'];
      // errors.values.forEach((element) {
      //   throw (element[0]);
      // });
    }
  }

  Future<dynamic> login(FormData formData) async {
    try {
      Response response = await dio.post('auth/login', data: formData);
      return response.data['success'];
    } on DioError catch (e) {
      throw e.response!.data['message'];
    }
  }
}
