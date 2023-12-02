import 'package:post_app/features/post/data/dataressource/post_local_data_source.dart';
import 'package:post_app/features/post/data/dataressource/post_remote_data_source.dart';
import 'package:post_app/features/post/data/repositories/post_repository.dart';
import 'package:post_app/features/post/domain/repositories/post_repository.dart';
import 'package:post_app/features/post/domain/usecases/add_post.dart';
import 'package:post_app/features/post/domain/usecases/delete_post.dart';
import 'package:post_app/features/post/domain/usecases/get_all_post.dart';
import 'package:post_app/features/post/domain/usecases/update_post.dart';
import 'package:post_app/features/post/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:post_app/features/post/presentation/bloc/posts/posts_bloc.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {


// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}