import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:post_app/features/post/presentation/pages/posts_pages.dart';

import 'core/app_theme.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>di.sl<PostsBloc>()),
    ], child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bonjour',
        theme: appTheme,
        home: PostPage(),
     )
    );
  }
}