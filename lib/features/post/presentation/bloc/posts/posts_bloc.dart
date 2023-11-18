import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_app/core/failures/failures.dart';
import 'package:post_app/core/strings/failures.dart';
import 'package:post_app/features/post/domain/entities/post.dart';
import 'package:post_app/features/post/domain/usecases/get_all_post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final GetAllPostsUsecase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        
        emit(LoadingPostsState());
        final futurePosts =
            await getAllPosts(); 
        futurePosts.fold((failure) {
          emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPostsState(posts: posts));
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UKNOWN_FAILURE_MESSAGE;
    }
  }

}