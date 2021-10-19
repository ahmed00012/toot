import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/models/cart_item.dart';
import 'package:toot/data/models/info.dart';
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

  String? cartToken = LocalStorage.getData(key: 'cart_token');

  Future<void> addToCart(
      {int? shopId,
      int? productId,
      int? quantity,
      List? options,
      List? extras}) async {
    emit(CartLoading());

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
      LocalStorage.saveData(key: 'cart_token', value: value['cart']['token']);
    }).catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> removeFromCart({int? productId}) async {
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
      print(e.toString());
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
    cartRepository
        .selectPayment(cartToken: cartToken, method: method)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future confirmOrder() async {
    emit(CartLoading());
    cartRepository.confirmOrder(cartToken: cartToken).then((value) {
      emit(OrderConfirmed(num: value['order']['id']));
    }).catchError((e) {
      print(e);
      emit(CartError(error: e.toString()));
    });
  }

  Future<dynamic> promoCode({String? code}) async {
    cartRepository
        .promoCode(cartToken: cartToken, code: code)
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
        .confirmInfoDateAndTime(token: cartToken, id: id, date: date)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }
}
