import 'dart:convert';
import 'dart:developer';

import 'package:api_bloc/features/posts/models/Post.dart';
import 'package:http/http.dart' as http;

class PostsRepo {

  static Future<List<PostModel>> fetchPosts() async {
    var client = http.Client();
    List<PostModel> postsList = [];
    try {
      var response = await client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var data = jsonDecode(response.body);
      for(int i=0 ; i<data.length ; i++){
        postsList.add(PostModel.fromJson(data[i]));
      }
      return postsList;
    } catch (e){
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost(String title, String body, int userId) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {'title': title, 'body': body, 'userId': userId.toString()}
      );
      return response.statusCode == 201;
    } catch (e){
      log(e.toString());
      return false;
    }
  }
}