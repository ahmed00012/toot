import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/repositories/product_repository.dart';
import 'package:toot/data/web_services/product_web_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductRepository productRepository = ProductRepository(ProductWebServices());
  ProductCubit() : super(ProductInitial());

  @override
  void onChange(Change<ProductState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  late double latitude;
  late double longitude;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude);
      LocalStorage.saveData(key: 'long', value: longitude);
      LocalStorage.saveData(key: 'lat', value: latitude);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCategories({double? lat, double? long}) async {
    emit(CategoriesLoading());
    await getLocation();
    productRepository.fetchCategories(long: long, lat: lat).then((categories) {
      emit(
        CategoriesLoaded(categories: categories),
      );
    }).catchError((e) {
      emit(ErrorOccur(error: e.toString()));
    });
  }

  Future<void> fetchShopCategories({int? shopId}) async {
    emit(ShopCategoriesLoading());
    productRepository
        .fetchShopCategories(shopId: shopId)
        .then((shopCategories) {
      emit(
        ShopCategoriesLoaded(shopCategories: shopCategories),
      );
    }).catchError((e) {
      emit(ErrorOccur(error: e.toString()));
    });
  }
}
