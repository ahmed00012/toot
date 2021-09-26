part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  List<Category> categories;
  ProductsLoaded({required this.categories});
}

class ErrorOccur extends ProductState {
  final String error;
  ErrorOccur({required this.error});
}
