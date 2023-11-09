import 'package:dartz/dartz.dart';

import 'package:post_app/core/failures/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}