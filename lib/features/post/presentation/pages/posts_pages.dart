import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/widgets/loading_widget.dart';
import 'package:post_app/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:post_app/features/post/presentation/widgets/posts_widgets/message_display_widget.dart';
import 'package:post_app/features/post/presentation/widgets/posts_widgets/posts_list_widgets.dart';
class PostPage extends StatelessWidget {
  const PostPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buidAppBar(),
        body: _buildBody()
    );
  }

  AppBar _buidAppBar()=>AppBar(title: const Text("Posts"));

  Widget _buildBody(){
     return Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<PostsBloc,PostsState>(builder: (context,state){
            if(state is LoadingWidget){
              return LoadingWidget();
            }else if(state is LoadedPostsState){
              return PostListWidget(posts: state.posts);
            }else if(state is ErrorPostsState){
              return MessageDisplayWidget(message: state.message);
            }else{
              return LoadingWidget();
            }
          }),
      );
  }
}