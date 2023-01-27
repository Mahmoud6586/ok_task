import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ok_task/core/error/failures.dart';
import 'package:ok_task/core/usecases/usecase.dart';
import 'package:ok_task/features/product_feature/domain/repositories/products_repository.dart';

import '../entities/product.dart';

class GetSingleProductUsecase implements UseCase<Product, Params> {
  final ProductsRepository repository;

  GetSingleProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(Params params) async {
    return await repository.getSingleProduct(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
