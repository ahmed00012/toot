import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toot/data/repositories/auth_repository.dart';
import 'package:toot/data/web_services/auth_web_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository = AuthRepository(AuthWebServices());
  AuthCubit() : super(AuthInitial());

  Future<void> register(
      {String? name,
      String? email,
      String? phone,
      String? password,
      String? confirmPassword}) async {
    emit(AuthLoading());
    authRepository
        .register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    )
        .then((value) {
      emit(AuthLoaded());
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }

  Future<void> login({String? phone, String? password}) async {
    emit(AuthLoading());
    authRepository
        .register(
      password: password,
      phone: phone,
    )
        .then((value) {
      emit(AuthLoaded());
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }
}
