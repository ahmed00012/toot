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

  Future<String?> register(FormData formData) async {
    try {
      Response response = await dio.post('auth/register', data: formData);
      print(response.data['success']);
      return response.data['success'];
    } on DioError catch (e) {
      print(e.response!.data['success']);
      return e.response!.data['errors'];
    }
  }

  Future<String?> login(FormData formData) async {
    try {
      Response response = await dio.post('auth/login', data: formData);
      return response.data['success'];
    } on DioError catch (e) {
      return e.response!.data['errors'];
    }
  }
}
