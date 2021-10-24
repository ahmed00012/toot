import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/models/cart_item.dart';
import 'package:toot/data/models/info.dart';
import 'package:toot/data/models/order.dart';
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

  // String? cartToken = LocalStorage.getData(key: 'cart_token');

  Future<void> addToCart(
      {int? shopId,
      int? productId,
      int? quantity,
      List? options,
      List? extras}) async {
    emit(CartLoading());

    var value = await cartRepository.addToCart(
        productId: productId,
        quantity: quantity,
        shopId: shopId,
        // cartToken: cartToken,
        extras: extras,
        options: options);
    await LocalStorage.saveData(
        key: 'cart_token', value: value['cart']['token']);
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    emit(AddedToCart());
  }

  Future<void> removeFromCart({int? productId, bool? lastItem}) async {
    await cartRepository.removeFromCart(
        productId: productId,
        cartToken: LocalStorage.getData(key: 'cart_token'),
        lastItem: lastItem);
    fetchCart();
    //     .then((value) async {
    //
    // }).catchError((e) {
    //   emit(CartError(error: e.toString()));
    // });
  }

  Future<void> fetchCart() async {
    emit(CartLoading());
    var cartDetails = await cartRepository.fetchCart();
    print("cartDetails $cartDetails");
    if (cartDetails != "Empty")
      emit(CartLoaded(cartDetails: cartDetails));
    else
      emit(CartEmpty());
    log(cartDetails.toString());
    // cartRepository.fetchCart().then((cartDetails) {
    //   print(cartDetails.length);
    //
    // }).catchError((e) {
    //   print(e.toString());
    //   emit(CartError(error: e.toString()));
    // });
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
    final long = LocalStorage.getData(key: 'long');
    final lat = LocalStorage.getData(key: 'lat');
    cartRepository
        .addAddress(
      address: address,
      district: district,
      cartToken: LocalStorage.getData(key: 'cart_token'),
      lng: long,
      lat: lat,
    )
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<dynamic> selectAddress({int? addressId}) async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    cartRepository
        .selectAddress(
            cartToken: LocalStorage.getData(key: 'cart_token'),
            addressId: addressId)
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
    cartRepository
        .selectPayment(
            cartToken: LocalStorage.getData(key: 'cart_token'), method: method)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future confirmOrder() async {
    emit(CartLoading());

    var value = await cartRepository.confirmOrder(
        cartToken: LocalStorage.getData(key: 'cart_token'));
    emit(OrderConfirmed(num: value['order']['id']));
    LocalStorage.saveData(key: 'cart_token', value: '');
  }

  Future<dynamic> promoCode({String? code}) async {
    cartRepository
        .promoCode(
            cartToken: LocalStorage.getData(key: 'cart_token'), code: code)
        .then((promoStatus) => emit(PromoLoaded(promo: promoStatus)))
        .catchError((e) {
      emit(CartError(error: e['message'].toString()));
    });
  }

  Future<void> fetchDatesAndTimes({int? id}) async {
    emit(CartLoading());
    cartRepository.fetchDatesAndTimes(id: id).then((info) {
      emit(InfoLoaded(info: info));
    }).catchError((e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> confirmInfoDateAndTime({String? date, int? id}) async {
    cartRepository
        .confirmInfoDateAndTime(
            token: LocalStorage.getData(key: 'cart_token'), id: id, date: date)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> fetchOrderStatus(int? id) async {
    emit(OrderStatusLoading());
    Order orderStatus = await cartRepository.orderStatus(id);
    emit(OrderStatusLoaded(order: orderStatus));
  }
}
