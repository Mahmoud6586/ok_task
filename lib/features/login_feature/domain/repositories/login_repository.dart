import 'package:dartz/dartz.dart';
import 'package:ok_task/core/error/failures.dart';
import 'package:ok_task/features/login_feature/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(LoginEntity login);
}
