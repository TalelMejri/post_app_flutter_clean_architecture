import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String username;
  final String? password;
  final List<String>? roles;
  final String? accessToken;
  UserEntity(
      {this.id,
      required this.username,
      this.password,
      this.roles,
      this.accessToken});
  @override
  List<Object?> get props => [id, username];
}
