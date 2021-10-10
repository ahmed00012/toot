import 'package:dio/dio.dart';
import 'package:toot/data/models/address.dart';
import 'package:toot/data/models/cart_item.dart';
import 'package:toot/data/web_services/cart_web_service.dart';

class CartRepository {
  final CartWebServices cartWebServices;
  CartRepository(this.cartWebServices);

  Future<dynamic> addToCart(
      {int? shopId, int? productId, int? quantity, String? cartToken}) async {
    FormData formData = FormData.fromMap({
      'vendor_id': shopId,
      'product_id': productId,
      'quantity': quantity,
      'cart_token': cartToken
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
}
