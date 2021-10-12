part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class AddedToCart extends CartState {}

class CartLoaded extends CartState {
  final CartItem cartDetails;
  CartLoaded({required this.cartDetails});
}

class AddressesLoaded extends CartState {
  final List addresses;
  AddressesLoaded({required this.addresses});
}

class PaymentsLoaded extends CartState {
  final List payments;
  PaymentsLoaded({required this.payments});
}

class CartError extends CartState {
  final String error;
  CartError({required this.error});
}
