import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/snack_bar_message.dart';
import 'package:post_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:post_app/features/auth/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
        //naviguer vers liste de post
        } else if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Colors.black), // Icône de retour en noir
        ),
        backgroundColor: Colors.white,
        body: LoginForm(),
      ),
    );
  }
}
