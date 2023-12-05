import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post_app/core/failures/exception.dart';
import 'package:post_app/features/auth/data/models/user_model.dart';
import 'package:post_app/features/post/data/dataressource/post_remote_data_source.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signInUser(UserModel userModel);
  Future<void> signOutUser();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {

  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signInUser(UserModel userModel) async {
    
    final body = jsonEncode(
        {"email": userModel.username, "password": userModel.password});
    print(body);
    late final response;
    try {
     
      response = await client.post(Uri.parse(BASE_URL+"/auth/loginUser"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: body);
         print(response.statusCode);
    } catch (e) {
      print("exception " + e.toString());
    }
   
    if (response.statusCode == 200) {
      try {
        print(response.body);
        final user = UserModel.fromJson(jsonDecode(response.body));
        return Future.value(user);
      } catch (e) {
         print("error"+e.toString());
        return Future.value(null);
      }
    } else {
       print("error Other");
      throw LoginException();
    }
  }

  @override
  Future<void> signOutUser() {
    // a faire plus tard
    throw UnimplementedError();
  }
}
