import 'package:api_bloc/features/posts/models/Post.dart';

abstract class PostsState{}

abstract class PostsActionState extends PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsErrorState extends PostsState {}

class PostSuccessfullyAddedState extends PostsActionState{}

class PostAdditionFailedState extends PostsActionState{}

class PostsFetchingSuccessfulState extends PostsState{
  List<PostModel> postsList;

  PostsFetchingSuccessfulState({required this.postsList});
}