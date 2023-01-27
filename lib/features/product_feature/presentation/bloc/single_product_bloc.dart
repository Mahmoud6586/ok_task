import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_single_product_usecase.dart';

part 'single_product_event.dart';
part 'single_product_state.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final GetSingleProductUsecase getSingleProductUsecase;
  SingleProductBloc({
    required this.getSingleProductUsecase,
  }) : super(SingleProductInitial()) {
    on<SingleProductEvent>((event, emit) {});
    on<GetSingleProductEvent>(
      (event, emit) async {
        emit(GetSingleProductLoading());

        final data =
            await getSingleProductUsecase.call(Params(id: event.product.id));

        data.fold(
          (failure) => emit(const GetSingleProductError('Server Failure')),
          (right) => emit(GetSingleProductCompleted(right)),
        );
      },
    );
  }
}
