import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/features/post/data/dataressource/post_local_data_source.dart';
import 'package:post_app/features/post/data/dataressource/post_remote_data_source.dart';
import 'package:post_app/features/post/data/repositories/post_repository.dart';
import 'package:post_app/features/post/domain/repositories/post_repository.dart';
import 'package:post_app/features/post/domain/usecases/get_all_post.dart';
import 'package:post_app/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


final sl=GetIt.instance;//Service Locator equivalent @autowired

Future<void> init () async{
  
  //Features posts
  //bloc : app reste en attente au démarrage

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  
  //UseCases

  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));


  //repositories

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl())
  );


  //DataSources

  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));


  //Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));


  //External

  final sharedPreferences=await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  
}
