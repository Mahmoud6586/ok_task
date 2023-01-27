import 'package:ok_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ok_task/features/login_feature/data/datasources/login_remote_datasource.dart';
import 'package:ok_task/features/login_feature/domain/entities/login_entity.dart';
import 'package:ok_task/features/login_feature/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasource remoteDatasource;

  LoginRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, String>> login(LoginEntity login) async {
    try {
      final String token = await remoteDatasource.loginUser(login);
      if (token == 'Unauthorized') {
        return Left(ServerFailure());
      }
      return Right(token);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
