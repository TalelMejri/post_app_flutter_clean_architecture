import 'dart:convert';
import 'package:post_app/core/failures/exception.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
    Future<List<PostModel>> getAllPosts();
    Future<Unit> updatePost(PostModel postModel);
    Future<Unit> addPost(PostModel postModel);
    Future<Unit> deletePost(int postId);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {

  //Client backend
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});


  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body) as List;
      /*
      List<PostModel> postModels=[];
      for (var item in data){
          postModels.add(PostModel.fromJson(item));
      }
      */
      final List<PostModel> postModels =
        data.map<PostModel>((json) => PostModel.fromJson(json)).toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final request = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response =
        await client.post(
            Uri.parse(BASE_URL + "/posts/"),
            body: request);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final request = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await client.patch(
      Uri.parse(BASE_URL + "/posts/$postId"),
      body: request,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

}