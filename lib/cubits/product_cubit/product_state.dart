part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class CategoriesLoading extends ProductState {}

class CategoriesLoaded extends ProductState {
  final List<dynamic> categories;
  CategoriesLoaded({required this.categories});
}

class ShopCategoriesLoading extends ProductState {}

class ShopCategoriesLoaded extends ProductState {
  final List<dynamic> shopCategories;
  ShopCategoriesLoaded({required this.shopCategories});
}

class ErrorOccur extends ProductState {
  final String error;
  ErrorOccur({required this.error});
}
