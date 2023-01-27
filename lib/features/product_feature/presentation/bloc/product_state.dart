part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

// States for fetching all products -------------
class GetAllProductsLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class GetAllProductsCompleted extends ProductState {
  final List<Product> productsList;

  const GetAllProductsCompleted(this.productsList);

  @override
  List<Object> get props => [productsList];
}

class GetAllProductsError extends ProductState {
  final String message;
  const GetAllProductsError(this.message);

  @override
  List<Object> get props => [message];
}
