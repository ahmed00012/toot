import 'package:dio/dio.dart';
import 'package:toot/data/web_services/favorites_web_service.dart';

class FavoritesRepository {
  final FavoritesWebServices favoritesWebServices;
  FavoritesRepository(this.favoritesWebServices);

  Future<bool> toggleFavoriteStatus({int? itemId}) async {
    FormData formData = FormData.fromMap({'product_id': itemId.toString()});
    return await favoritesWebServices.toggleFavoriteStatus(formData);
  }

  // Future<List<FavoriteItem>> fetchFavorites() async {
  //   final rawData = await favoritesWebServices.fetchFavorites();
  //   return rawData.map((element) => FavoriteItem.fromJson(element)).toList();
  // }
}
