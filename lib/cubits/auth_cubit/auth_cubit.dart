import 'package:bloc/bloc.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/repositories/auth_repository.dart';
import 'package:toot/data/web_services/auth_web_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository = AuthRepository(AuthWebServices());
  AuthCubit() : super(AuthInitial());

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

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
            fcmToken: LocalStorage.getData(key: 'token_fcm'))
        .then((token) async {
      LocalStorage.saveData(key: 'token', value: token);
      LocalStorage.saveData(key: 'isLogin', value: true);
      emit(AuthLoaded());
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }

  Future<void> fetchIntroductionImages() async {
    emit(ImagesLoading());
    authRepository.fetchIntroductionImages().then((images) {
      emit(ImagesLoaded(images: images));
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }

  Future<dynamic> otp({
    String? phone,
    String? otp,
    String? name,
    String? password,
    String? email,
  }) async {
    await authRepository
        .otp(
            phone: phone,
            otp: otp,
            password: password,
            email: email,
            name: name,
            fcmToken: LocalStorage.getData(key: 'token_fcm'))
        .then((token) async {
      LocalStorage.saveData(key: 'token', value: token);
      LocalStorage.saveData(key: 'isLogin', value: true);
      emit(OtpSuccess());
    }).catchError((e) {
      emit(AuthError(error: e.toString()));
    });
  }
}
