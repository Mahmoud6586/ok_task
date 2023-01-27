part of 'single_product_bloc.dart';

abstract class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object> get props => [];
}

class SingleProductInitial extends SingleProductState {}
// States for fetching a single product -------------

class GetSingleProductLoading extends SingleProductState {
  @override
  List<Object> get props => [];
}

class GetSingleProductCompleted extends SingleProductState {
  final Product product;

  const GetSingleProductCompleted(this.product);
  @override
  List<Object> get props => [product];
}

class GetSingleProductError extends SingleProductState {
  final String message;
  const GetSingleProductError(this.message);
  @override
  List<Object> get props => [message];
}
