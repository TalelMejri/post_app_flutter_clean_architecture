import '../repositories/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:post_app/core/failures/failures.dart';

class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}