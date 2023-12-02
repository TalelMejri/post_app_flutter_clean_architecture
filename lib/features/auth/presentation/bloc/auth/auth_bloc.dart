import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_app/features/auth/domain/entities/user_enttity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
