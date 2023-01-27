import 'package:equatable/equatable.dart';
import 'package:ok_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ok_task/core/usecases/usecase.dart';
import 'package:ok_task/features/login_feature/domain/entities/login_entity.dart';
import 'package:ok_task/features/login_feature/domain/repositories/login_repository.dart';

class LoginUsecase implements UseCase<String, Params> {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginEntity login;

  Params({
    required this.login,
  });

  @override
  List<Object> get props => [login];
}
