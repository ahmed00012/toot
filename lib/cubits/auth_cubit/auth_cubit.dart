import 'package:bloc/bloc.dart';
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
    await authRepository
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

  Future<dynamic> login({String? phone, String? password}) async {
    emit(AuthLoading());
    await authRepository
        .login(
      password: password,
      phone: phone,
    )
        .then((value) {
      emit(AuthLoaded());
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }

  Future<void> fetchIntroductionImages() async {
    emit(ImagesLoading());
    await authRepository.fetchIntroductionImages().then((images) {
      emit(ImagesLoaded(images: images));
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }

  Future<dynamic> otp({String? phone, String? otp}) async {
    await authRepository.otp(phone: phone, otp: otp).then((token) {
      print(token);
      return token;
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }
}
