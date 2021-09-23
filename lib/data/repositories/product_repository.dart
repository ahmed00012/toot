import 'package:toot/data/web_services/product_web_service.dart';

class ProductRepository {
  final ProductWebServices productWebServices;
  ProductRepository(this.productWebServices);

  Future<dynamic> fetchCategories({double? lat, double? long}) async {
    // final rawData =await productWebServices.fetchCategories(lat: lat, long: long);
    // return
  }
}
