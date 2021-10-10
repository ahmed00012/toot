import 'package:dio/dio.dart';
import 'package:toot/data/models/favorite.dart';
import 'package:toot/data/web_services/favorites_web_service.dart';

class FavoritesRepository {
  final FavoritesWebServices favoritesWebServices;
  FavoritesRepository(this.favoritesWebServices);

  Future<bool> toggleFavoriteStatus({int? itemId}) async {
    print(itemId);
    FormData formData = FormData.fromMap({'product_id': itemId});
    return await favoritesWebServices.toggleFavoriteStatus(formData);
  }

  Future<dynamic> fetchFavorites() async {
    final rawData = await favoritesWebServices.fetchFavorites();
    return rawData.map((fav) => Favorite.fromJson(fav)).toList();
  }
}
