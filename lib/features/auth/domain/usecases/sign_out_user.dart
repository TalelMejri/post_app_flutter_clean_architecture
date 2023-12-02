import 'package:dartz/dartz.dart';
import 'package:post_app/core/failures/failures.dart';
import 'package:post_app/features/auth/domain/repositories/user_repo.dart';

class SignOutUserUseCase {

  final UserRepository userRepository;
  //injecter par SL
  SignOutUserUseCase(this.userRepository);
    Future<Either<Failure, Unit>> call() async {
        return await userRepository.signOut();
    }
    
}