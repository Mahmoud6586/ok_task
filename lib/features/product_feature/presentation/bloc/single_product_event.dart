part of 'single_product_bloc.dart';

abstract class SingleProductEvent extends Equatable {
  const SingleProductEvent();

  @override
  List<Object> get props => [];
}

class GetSingleProductEvent extends SingleProductEvent {
  final Product product;
  const GetSingleProductEvent(this.product);
}
