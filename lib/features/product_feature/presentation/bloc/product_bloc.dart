import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ok_task/core/usecases/usecase.dart';
import 'package:ok_task/features/product_feature/domain/usecases/get_all_products_usecase.dart';

import '../../domain/entities/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUsecase getAllProductsUsecase;

  ProductBloc({
    required this.getAllProductsUsecase,
  }) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});

    on<GetAllProductsEvent>(
      (event, emit) async {
        emit(GetAllProductsLoading());
        final data = await getAllProductsUsecase.call(NoParams());

        data.fold(
          (failure) => emit(const GetAllProductsError('Server Failure')),
          (right) => emit(GetAllProductsCompleted(right)),
        );
      },
    );
  }
}
