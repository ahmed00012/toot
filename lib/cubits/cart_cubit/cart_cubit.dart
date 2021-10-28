import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/models/cart_item.dart';
import 'package:toot/data/models/info.dart';
import 'package:toot/data/models/order.dart';
import 'package:toot/data/models/points.dart';
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
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    emit(CartLoading());

    var value = await cartRepository.addToCart(
        productId: productId,
        quantity: quantity,
        shopId: shopId,
        cartToken: LocalStorage.getData(key: 'cart_token'),
        extras: extras,
        options: options);
    print(value['cart']['token']);
    await LocalStorage.saveData(
        key: 'cart_token', value: value['cart']['token']);
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    emit(AddedToCart());
  }

  Future<void> removeFromCart({int? productId, bool? lastItem}) async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
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
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    // if (LocalStorage.getData(key: 'cart_token') == '' ||
    //     LocalStorage.getData(key: 'cart_token') == null) {
    //   emit(CartEmpty());
    //   var cartDetails = await cartRepository.fetchCart();
    //   print(cartDetails);
    // }
    // else {
    emit(CartLoading());
    var cartDetails = await cartRepository.fetchCart();
    if (cartDetails != "Empty")
      emit(CartLoaded(cartDetails: cartDetails));
    else
      emit(CartEmpty());
    // }

    // cartRepository.fetchCart().then((cartDetails) {
    //   print(cartDetails.length);
    //
    // }).catchError((e) {
    //   print(e.toString());
    //   emit(CartError(error: e.toString()));
    // });
  }

  Future<void> fetchAddress() async {
    print("card ${LocalStorage.getData(key: 'token')}");
    emit(CartLoading());
    var addresses = await cartRepository.fetchAddress();
    emit(AddressesLoaded(addresses: addresses));
  }

  Future<dynamic> addAddress({String? address, String? district}) async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    final long = LocalStorage.getData(key: 'long');
    final lat = LocalStorage.getData(key: 'lat');
    await cartRepository.addAddress(
      address: address,
      district: district,
      cartToken: LocalStorage.getData(key: 'cart_token'),
      lng: long,
      lat: lat,
    );
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
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    emit(CartLoading());
    cartRepository.fetchPayments().then((payments) {
      emit(PaymentsLoaded(payments: payments));
    }).catchError((e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> selectPayment({String? method}) async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    cartRepository
        .selectPayment(
            cartToken: LocalStorage.getData(key: 'cart_token'), method: method)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future confirmOrder() async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
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
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    emit(CartLoading());
    cartRepository.fetchDatesAndTimes(id: id).then((info) {
      emit(InfoLoaded(info: info));
    }).catchError((e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> confirmInfoDateAndTime({String? date, int? id}) async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    cartRepository
        .confirmInfoDateAndTime(
            token: LocalStorage.getData(key: 'cart_token'), id: id, date: date)
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> fetchOrderStatus(int? id) async {
    print("card ${LocalStorage.getData(key: 'cart_token')}");
    emit(OrderStatusLoading());
    Order orderStatus = await cartRepository.orderStatus(id);
    print(orderStatus.id.toString());
    emit(OrderStatusLoaded(order: orderStatus));
  }

  Future<void> fetchLastOrders() async {
    emit(LastOrdersLoading());

    var orders = await cartRepository.fetchLastOrders();
    emit(LastOrdersLoaded(orders: orders));
    //     .then((orders) => emit(LastOrdersLoaded(orders: orders)))
    //     .catchError((e) {
    //   emit(CartError(error: e.toString()));
    // });
  }

  Future<void> fetchMyPoints() async {
    emit(MyPointsLoading());
    cartRepository
        .fetchMyPoints()
        .then((points) => emit(MyPointsLoaded(points: points)))
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }

  Future<void> covertPoints() async {
    emit(NewBalancedLoading());
    cartRepository
        .covertPoints()
        .then((points) => emit(NewBalancedFetched(newBalance: points)))
        .catchError((e) {
      emit(CartError(error: e.toString()));
    });
  }
}
