import 'package:dartz/dartz.dart';
import 'package:post_app/core/failures/exception.dart';
import 'package:post_app/core/failures/failures.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/features/auth/data/datasource/user_local_data_source.dart';
import 'package:post_app/features/auth/data/datasource/user_remote_data_source.dart';
import 'package:post_app/features/auth/data/models/user_model.dart';
import 'package:post_app/features/auth/domain/entities/user_enttity.dart';
import 'package:post_app/features/auth/domain/repositories/user_repo.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfo networtkInfo;
  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl(
      {required this.networtkInfo,
      required this.userLocalDataSource,
      required this.userRemoteDataSource});
  @override
  Future<Either<Failure, Unit>> signIn(UserEntity user) async {
    final UserModel userModel =
        UserModel(username: user.username, password: user.password);
    if (await networtkInfo.isConnected) {
      try {
        final remoteUser = await userRemoteDataSource.signInUser(userModel);
        userLocalDataSource.cacheUser(remoteUser);
        return const Right(unit);
      } on LoginException {
        return Left(LoginFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    userLocalDataSource.clearCachedUser();
    return const Right(unit);
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    try {
      final UserModel userModel = await userLocalDataSource.getCachedUser();
      UserEntity userEntity = UserEntity(
          username: userModel.username,
          password: userModel.password,
          id: userModel.id,
          roles: userModel.roles,
          accessToken: userModel.accessToken);
      return userEntity;
    } catch (e) {
      return null;
    }
  }
}
