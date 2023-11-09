

import 'package:post_app/core/failures/failures.dart';
import '../entities/post.dart';
import 'package:dartz/dartz.dart';

//Specefi Contat
abstract class PostsRepository {
  // si correct ListPsot return else Failure return 
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}