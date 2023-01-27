import 'package:ok_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ok_task/features/product_feature/data/datasources/remote_datasource.dart';
import 'package:ok_task/features/product_feature/domain/entities/product.dart';
import 'package:ok_task/features/product_feature/domain/repositories/products_repository.dart';

class ProductRepositoryImpl implements ProductsRepository {
  final RemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllPruducts() async {
    try {
      final List<Product> products = await remoteDataSource.getAllProducts();
      return Right(products);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(int id) async {
    try {
      final product = await remoteDataSource.getSingleProduct(id);
      return Right(product);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
