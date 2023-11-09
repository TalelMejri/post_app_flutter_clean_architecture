import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_app/core/failures/exception.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CACHED_KEY = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {

  //BD local
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_KEY, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_KEY);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
  
}