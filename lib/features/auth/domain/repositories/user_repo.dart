import 'package:dartz/dartz.dart';
import 'package:post_app/core/failures/failures.dart';
import 'package:post_app/features/auth/domain/entities/user_enttity.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> signIn(UserEntity user);
  Future<Either<Failure, Unit>> signOut();
  Future<UserEntity?> getCachedUser();
}