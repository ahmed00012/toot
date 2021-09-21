import 'package:dio/dio.dart';
import 'package:toot/data/web_services/auth_web_service.dart';

class AuthRepository {
  final AuthWebServices authWebServices;
  AuthRepository(this.authWebServices);

  Future<dynamic> register(
      {String? name, String? email, String? phone, String? password}) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': password,
      'email': email,
    });
    return await authWebServices.register(formData);
  }

  Future<dynamic> login({String? phone, String? password}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'password': password,
    });
    return await authWebServices.login(formData);
  }
}
