import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:api_bloc/features/posts/models/Post.dart';
import 'package:api_bloc/features/posts/repos/posts_repo.dart';
import 'package:http/http.dart' as http;
import 'package:api_bloc/features/posts/bloc/posts_event.dart';
import 'package:api_bloc/features/posts/bloc/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState>{
  PostsBloc() : super (PostsInitialState()){
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async {

    //Loading starts
    emit(PostsLoadingState());

    //API call
    List<PostModel> postsList = await PostsRepo.fetchPosts();

    //Data passed to UI
    emit(PostsFetchingSuccessfulState(postsList: postsList));
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostsState> emit) async {

    //API call
    bool isPostAdded = await PostsRepo.addPost(event.title, event.body, event.userId);
    if(isPostAdded){
      emit(PostSuccessfullyAddedState());
    } else {
      emit(PostAdditionFailedState());
    }
  }
}