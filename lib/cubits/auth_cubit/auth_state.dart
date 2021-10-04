part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class ImagesLoading extends AuthState {}

class ImagesLoaded extends AuthState {
  final List<dynamic> images;
  ImagesLoaded({required this.images});
}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}

class OtpSuccess extends AuthState {}
