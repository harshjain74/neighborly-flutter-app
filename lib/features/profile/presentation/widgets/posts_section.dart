import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/text_style.dart';
import '../../../posts/presentation/widgets/poll_widget.dart';
import '../../../posts/presentation/widgets/post_sheemer_widget.dart';
import '../../../posts/presentation/widgets/post_widget.dart';
import '../bloc/get_my_posts_bloc/get_my_posts_bloc.dart';

class PostSection extends StatefulWidget {
  final String? userId;
  const PostSection({super.key, this.userId});

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
    var postState = context.read<GetMyPostsBloc>().state;
    if (postState is! GetMyPostsSuccessState) {
      BlocProvider.of<GetMyPostsBloc>(context).add(GetMyPostsButtonPressedEvent(
        userId: widget.userId,
      ));
    }
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<GetMyPostsBloc>(context).add(GetMyPostsButtonPressedEvent(
      userId: widget.userId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5FF),
      ),
      child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<GetMyPostsBloc, GetMyPostsState>(
            builder: (context, state) {
              if (state is GetMyPostsLoadingState) {
                return const PostSheemerWidget();
              } else if (state is GetMyPostsSuccessState) {
                if (state.post.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome! Your space is empty.',
                          style: onboardingHeading2Style,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            context.go('/create');
                          },
                          child: Text(
                            'Create your first post',
                            style: bluemediumTextStyleBlack,
                          ),
                        ),
                      ],
                    ),
                  );
                }
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
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    );
                  },
                );
              } else if (state is GetMyPostsFailureState) {
                if (state.error.contains('Invalid Token')) {
                  context.go('/loginScreen');
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
                return const SizedBox();
              }
            },
          )),
    );
  }
}
