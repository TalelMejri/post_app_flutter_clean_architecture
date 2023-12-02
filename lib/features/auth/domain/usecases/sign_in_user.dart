import 'package:dartz/dartz.dart';
import 'package:post_app/core/failures/failures.dart';
import 'package:post_app/features/auth/domain/entities/user_enttity.dart';
import 'package:post_app/features/auth/domain/repositories/user_repo.dart';

class SignInUserUseCase {
  final UserRepository userRepository;
//injecter par SL
  SignInUserUseCase(this.userRepository);
      Future<Either<Failure, Unit>> call(UserEntity user) async {
        return await userRepository.signIn(user);
      }
}