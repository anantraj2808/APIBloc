import 'package:api_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:api_bloc/features/posts/bloc/posts_event.dart';
import 'package:api_bloc/features/posts/bloc/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Posts Page", style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: (){
          postsBloc.add(PostAddEvent(title: "Dummy title added", body: "Sample body", userId: 9));
        },
        label: const Text("Add Post", style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add, color: Colors.white,),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        builder: (context, state){
          switch(state.runtimeType){
            case PostsFetchingSuccessfulState:
              final successState = state as PostsFetchingSuccessfulState;
              return SafeArea(
                child: ListView.builder(
                  itemCount: successState.postsList.length,
                  itemBuilder: (context, index){
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title: ${successState.postsList[index].title}"),
                          Text("Body: ${successState.postsList[index].body}"),
                        ],
                      ),
                    );
                  },
                ),
              );
            case PostsLoadingState:
              return const SafeArea(
                child: Center(child: CircularProgressIndicator(),),
              );
            case PostsErrorState:
              return const SafeArea(
                child: Center(child: Text("Error")),
              );
            default:
              return Container();
          }
        },
        listener: (context, state){
          if(state is PostAdditionFailedState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post addition failed!")));
          } else if (state is PostSuccessfullyAddedState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post added successfully")));
          }
        },
        buildWhen: (prev, current){
          return current is !PostsActionState;
        },
        listenWhen: (prev, current){
          return current is PostsActionState;
        },
      ),
    );
  }
}
