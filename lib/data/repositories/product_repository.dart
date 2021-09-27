import 'package:toot/data/models/category.dart';
import 'package:toot/data/models/shop_category.dart';
import 'package:toot/data/web_services/product_web_service.dart';

class ProductRepository {
  final ProductWebServices productWebServices;
  ProductRepository(this.productWebServices);

  Future<dynamic> fetchCategories({double? lat, double? long}) async {
    final rawData =
        await productWebServices.fetchCategories(lat: lat, long: long);
    return rawData.map((category) => Category.fromJson(category)).toList();
  }

  Future<dynamic> fetchShopCategories({int? shopId}) async {
    final rawData =
        await productWebServices.fetchShopCategories(shopId: shopId);
    return rawData
        .map((shopCategory) => ShopCategory.fromJson(shopCategory))
        .toList();
  }
}
