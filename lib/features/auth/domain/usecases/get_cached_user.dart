import 'package:post_app/features/auth/domain/entities/user_enttity.dart';
import 'package:post_app/features/auth/domain/repositories/user_repo.dart';

class GetCachedUserUseCase {

  final UserRepository userRepository;
  //injecter par SL
  GetCachedUserUseCase(this.userRepository);
    Future<UserEntity?> call() async {
          return await userRepository.getCachedUser();
    }

}