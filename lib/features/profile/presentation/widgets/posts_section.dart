import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/widgets/poll_widget.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/widgets/post_sheemer_widget.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/widgets/post_widget.dart';
import 'package:neighborly_flutter_app/features/profile/presentation/bloc/get_my_posts_bloc/get_my_posts_bloc.dart';

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() {
    BlocProvider.of<GetMyPostsBloc>(context)
        .add(GetMyPostsButtonPressedEvent()); // Use isHome state
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<GetMyPostsBloc>(context)
        .add(GetMyPostsButtonPressedEvent()); // Use isHome state
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<GetMyPostsBloc, GetMyPostsState>(
          builder: (context, state) {
            if (state is GetMyPostsLoadingState) {
              return const PostSheemerWidget();
            } else if (state is GetMyPostsSuccessState) {
              return ListView.separated(
                itemCount: state.post.length,
                itemBuilder: (context, index) {
                  final post = state.post[index];
                  if (post.type == 'post') {
                    return PostWidget(post: post);
                  } else if (post.type == 'poll') {
                    return PollWidget(
                      post: post,
                    );
                  }
                  return const SizedBox();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  );
                },
              );
            } else if (state is GetMyPostsFailureState) {
              if (state.error.contains('Invalid Token')) {
                context.go('/loginScreengin');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.error.contains('Internal server error')) {
                return const Center(
                    child: Text(
                  'Server Error',
                  style: TextStyle(color: Colors.red),
                ));
              }
              return Center(child: Text(state.error));
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ));
  }
}