import 'package:bloc/bloc.dart';
import 'package:toot/data/models/category.dart';
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

  Future<void> fetchCategories({double? lat, double? long}) async {
    emit(ProductsLoading());
    productRepository.fetchCategories(long: long, lat: lat).then((categories) {
      emit(
        ProductsLoaded(categories: categories),
      );
    }).catchError((e) {
      print(e.toString());
      emit(ErrorOccur(error: e.toString()));
    });
  }
}
