import 'dart:convert';

import 'package:post_app/features/auth/domain/entities/user_enttity.dart';

class UserModel extends UserEntity {
  UserModel(
      {String? id,
      required String username,
      password,
      List<String>? roles,
      String? accessToken})
      : super(
            id: id,
            username: username,
            password: password,
            roles: roles,
            accessToken: accessToken);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: '1', //json['id'].toString(),
        username: json['username'],
        password: json['password'],
        roles: List.from(json['roles']), //.cast<String>(),
        accessToken: json['accessToken']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'roles': jsonEncode(roles),
      'accessToken': accessToken
    };
  }
}
