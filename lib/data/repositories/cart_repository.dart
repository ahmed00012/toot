import 'package:dio/dio.dart';
import 'package:toot/data/models/address.dart';
import 'package:toot/data/models/cart_item.dart';
import 'package:toot/data/models/payment.dart';
import 'package:toot/data/models/promo_status.dart';
import 'package:toot/data/web_services/cart_web_service.dart';

class CartRepository {
  final CartWebServices cartWebServices;
  CartRepository(this.cartWebServices);

  Future<dynamic> addToCart(
      {int? shopId,
      int? productId,
      int? quantity,
      String? cartToken,
      List? extras,
      List? options}) async {
    FormData formData = FormData.fromMap({
      'vendor_id': shopId,
      'product_id': productId,
      'quantity': quantity,
      'cart_token': cartToken,
      'options': options,
      'addons': extras
    });
    return await cartWebServices.addToCart(formData);
  }

  Future<dynamic> removeFromCart({int? productId, String? cartToken}) async {
    FormData formData =
        FormData.fromMap({'product_id': productId, 'cart_token': cartToken});
    return await cartWebServices.removeFromCart(formData);
  }

  Future<dynamic> fetchCart() async {
    final rawData = await cartWebServices.fetchCart();
    return CartItem.fromJson(rawData);
  }

  Future<dynamic> fetchAddress() async {
    final rawData = await cartWebServices.fetchAddress();
    return rawData.map((address) => Address.fromJson(address)).toList();
  }

  Future<dynamic> addAddress(
      {String? cartToken,
      String? address,
      String? district,
      double? lat,
      double? lng}) async {
    FormData formData = FormData.fromMap({
      'cart_token': cartToken,
      'address': address,
      'district': district,
      'lng': lng,
      'lat': lat
    });
    return await cartWebServices.addAddress(formData);
  }

  Future<dynamic> selectAddress({String? cartToken, int? addressId}) async {
    FormData formData =
        FormData.fromMap({'cart_token': cartToken, 'address_id': addressId});
    return await cartWebServices.selectAddress(formData);
  }

  Future<dynamic> fetchPayments() async {
    final rawData = await cartWebServices.fetchPayments();
    return rawData.map((address) => Payment.fromJson(address)).toList();
  }

  Future<dynamic> selectPayment({
    String? cartToken,
    String? method,
  }) async {
    FormData formData =
        FormData.fromMap({'cart_token': cartToken, 'payment_type': method});
    return await cartWebServices.selectPayment(formData);
  }

  Future<dynamic> confirmOrder({String? cartToken}) async {
    FormData formData = FormData.fromMap({'cart_token': cartToken});
    return await cartWebServices.confirmOrder(formData);
  }

  Future<dynamic> promoCode({String? cartToken, String? code}) async {
    FormData formData =
        FormData.fromMap({'cart_token': cartToken, 'code': code});
    final rawData = await cartWebServices.promoCode(formData);
    return PromoStatus.fromJson(rawData);
  }
}
