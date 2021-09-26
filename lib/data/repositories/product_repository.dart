import 'package:toot/data/models/category.dart';
import 'package:toot/data/web_services/product_web_service.dart';

class ProductRepository {
  final ProductWebServices productWebServices;
  ProductRepository(this.productWebServices);

  Future<List<Category>> fetchCategories({double? lat, double? long}) async {
    final rawData =
        await productWebServices.fetchCategories(lat: lat, long: long);
    return rawData.map((category) => Category.fromJson(category)).toList();
  }
}
