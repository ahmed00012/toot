import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/models/cart_item.dart';
import 'package:toot/data/repositories/cart_repository.dart';
import 'package:toot/data/web_services/cart_web_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final CartRepository cartRepository = CartRepository(CartWebServices());

  @override
  void onChange(Change<CartState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  Future<void> addToCart(
      {int? shopId,
      int? productId,
      int? quantity,
      List? options,
      List? extras}) async {
    emit(CartLoading());
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
    cartRepository
        .addToCart(
            productId: productId,
            quantity: quantity,
            shopId: shopId,
            cartToken: cartToken,
            extras: extras,
            options: options)
        .then((value) async {
      emit(AddedToCart());
      await FlutterSecureStorage()
          .write(key: 'cart_token', value: value['cart']['token']);
    }).catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> removeFromCart({int? productId}) async {
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
    cartRepository
        .removeFromCart(productId: productId, cartToken: cartToken)
        .then((value) async {
      fetchCart();
    }).catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> fetchCart() async {
    emit(CartLoading());
    cartRepository
        .fetchCart()
        .then((cartDetails) => emit(CartLoaded(cartDetails: cartDetails)))
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> fetchAddress() async {
    emit(CartLoading());
    cartRepository.fetchAddress().then((addresses) {
      emit(AddressesLoaded(addresses: addresses));
    }).catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<dynamic> addAddress({String? address, String? district}) async {
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
    final long = LocalStorage.getData(key: 'long');
    final lat = LocalStorage.getData(key: 'lat');
    cartRepository
        .addAddress(
      address: address,
      district: district,
      cartToken: cartToken,
      lng: long,
      lat: lat,
    )
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<dynamic> selectAddress({int? addressId}) async {
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
    cartRepository
        .selectAddress(cartToken: cartToken, addressId: addressId)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> fetchPayments() async {
    emit(CartLoading());
    cartRepository.fetchPayments().then((payments) {
      emit(PaymentsLoaded(payments: payments));
    }).catchError((e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> selectPayment({String? method}) async {
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
    cartRepository
        .selectPayment(cartToken: cartToken, method: method)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> confirmOrder() async {
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');
    cartRepository.confirmOrder(cartToken: cartToken).catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<dynamic> promoCode({String? code}) async {
    String? cartToken = await FlutterSecureStorage().read(key: 'cart_token');

    cartRepository
        .promoCode(cartToken: cartToken, code: code)
        .then((promoStatus) => emit(PromoLoaded(promo: promoStatus)))
        .catchError((e) {
      emit(CartError(error: e['message'].toString()));
    });
  }
}
