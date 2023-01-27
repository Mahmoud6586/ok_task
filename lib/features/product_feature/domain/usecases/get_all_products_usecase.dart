import 'package:ok_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ok_task/core/usecases/usecase.dart';
import 'package:ok_task/features/product_feature/domain/repositories/products_repository.dart';

import '../entities/product.dart';

class GetAllProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductsRepository repository;

  GetAllProductsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(params) async {
    return await repository.getAllPruducts();
  }
}
