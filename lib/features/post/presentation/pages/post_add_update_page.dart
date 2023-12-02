import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/snack_bar_message.dart';
import 'package:post_app/core/widgets/loading_widget.dart';
import 'package:post_app/features/post/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:post_app/features/post/presentation/pages/posts_pages.dart';
import 'package:post_app/features/post/presentation/widgets/post_add_update_widgets/form_widget.dart';
import '../../domain/entities/post.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child:
              BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeletePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostPage()),
                    (route) => false);
              } else if (state is ErrorAddUpdateDeletePostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
             if (state is LoadingAddUpdateDeletePostState) {
                return LoadingWidget();
             }
              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}