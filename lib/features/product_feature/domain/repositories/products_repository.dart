import 'package:dartz/dartz.dart';
import 'package:ok_task/core/error/failures.dart';
import 'package:ok_task/features/product_feature/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllPruducts();

  Future<Either<Failure, Product>> getSingleProduct(int id);
}
