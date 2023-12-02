import 'package:api_bloc/features/posts/models/Post.dart';

abstract class PostsEvent{}

class PostsInitialFetchEvent extends PostsEvent {}

class PostAddEvent extends PostsEvent {
  String title;
  String body;
  int userId;
  PostAddEvent({required this.title, required this.body, required this.userId});
}