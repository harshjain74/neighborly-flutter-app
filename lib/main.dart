import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/routes.dart';
import 'core/utils/app_initializers.dart';
import 'dependency_injection.dart' as di;
import 'features/authentication/presentation/bloc/fogot_password_bloc/forgot_password_bloc.dart';
import 'features/authentication/presentation/bloc/google_authentication_bloc/google_authentication_bloc.dart';
import 'features/authentication/presentation/bloc/login_with_email_bloc/login_with_email_bloc.dart';
import 'features/authentication/presentation/bloc/register_bloc/register_bloc.dart';
import 'features/authentication/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'features/authentication/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'features/chat/presentation/bloc/chat_group_cubit.dart';
import 'features/chat/presentation/bloc/chat_main_cubit.dart';
import 'features/chat/presentation/bloc/chat_private_cubit.dart';
import 'features/communities/presentation/bloc/communities_create_cubit.dart';
import 'features/communities/presentation/bloc/communities_main_cubit.dart';
import 'features/communities/presentation/bloc/communities_search_cubit.dart';
import 'features/communities/presentation/bloc/community_detail_cubit.dart';
import 'features/event/presentation/bloc/event_create_cubit.dart';
import 'features/event/presentation/bloc/event_detail_cubit.dart';
import 'features/event/presentation/bloc/event_join_cubit.dart';
import 'features/event/presentation/bloc/event_main_cubit.dart';
import 'features/event/presentation/bloc/event_search_cubit.dart';
import 'features/homePage/bloc/update_location_bloc/update_location_bloc.dart';
import 'features/notification/presentation/bloc/notification_general_cubit.dart';
import 'features/notification/presentation/bloc/notification_list_cubit.dart';
import 'features/posts/presentation/bloc/add_comment_bloc/add_comment_bloc.dart';
import 'features/posts/presentation/bloc/delete_post_bloc/delete_post_bloc.dart';
import 'features/posts/presentation/bloc/feedback_bloc/feedback_bloc.dart';
import 'features/posts/presentation/bloc/fetch_comment_reply_bloc/fetch_comment_reply_bloc.dart';
import 'features/posts/presentation/bloc/get_all_posts_bloc/get_all_posts_bloc.dart';
import 'features/posts/presentation/bloc/get_comments_by_postId_bloc/get_comments_by_postId_bloc.dart';
import 'features/posts/presentation/bloc/get_post_by_id_bloc/get_post_by_id_bloc.dart';
import 'features/posts/presentation/bloc/give_award_bloc/give_award_bloc.dart';
import 'features/posts/presentation/bloc/report_post_bloc/report_post_bloc.dart';
import 'features/posts/presentation/bloc/vote_poll_bloc/vote_poll_bloc.dart';
import 'features/profile/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'features/profile/presentation/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'features/profile/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'features/profile/presentation/bloc/get_gender_and_DOB_bloc/get_gender_and_DOB_bloc.dart';
import 'features/profile/presentation/bloc/get_my_awards_bloc/get_my_awards_bloc.dart';
import 'features/profile/presentation/bloc/get_my_comments_bloc/get_my_comments_bloc.dart';
import 'features/profile/presentation/bloc/get_my_groups_bloc/get_my_groups_bloc.dart';
import 'features/profile/presentation/bloc/get_my_posts_bloc/get_my_posts_bloc.dart';
import 'features/profile/presentation/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'features/profile/presentation/bloc/get_user_info_bloc/get_user_info_bloc.dart';
import 'features/profile/presentation/bloc/logout_bloc.dart/logout_bloc.dart';
import 'features/profile/presentation/bloc/send_feedback_bloc/send_feedback_bloc.dart';
import 'features/upload/presentation/bloc/upload_file_bloc/upload_file_bloc.dart';
import 'features/upload/presentation/bloc/upload_post_bloc/upload_post_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializers.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>(
            create: (context) => di.sl<RegisterBloc>(),
          ),
          BlocProvider<LoginWithEmailBloc>(
            create: (context) => di.sl<LoginWithEmailBloc>(),
          ),
          BlocProvider<ResendOtpBloc>(
            create: (context) => di.sl<ResendOtpBloc>(),
          ),
          BlocProvider<ForgotPasswordBloc>(
            create: (context) => di.sl<ForgotPasswordBloc>(),
          ),
          BlocProvider<OtpBloc>(
            create: (context) => di.sl<OtpBloc>(),
          ),
          BlocProvider<GoogleAuthenticationBloc>(
            create: (context) => di.sl<GoogleAuthenticationBloc>(),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => di.sl<ChangePasswordBloc>(),
          ),
          BlocProvider<GetAllPostsBloc>(
            create: (context) => di.sl<GetAllPostsBloc>(),
          ),
          BlocProvider<UploadPostBloc>(
            create: (context) => di.sl<UploadPostBloc>(),
          ),
          BlocProvider<ReportPostBloc>(
            create: (context) => di.sl<ReportPostBloc>(),
          ),
          BlocProvider<FeedbackBloc>(
            create: (context) => di.sl<FeedbackBloc>(),
          ),
          BlocProvider<GetPostByIdBloc>(
            create: (context) => di.sl<GetPostByIdBloc>(),
          ),
          BlocProvider<GetCommentsByPostIdBloc>(
            create: (context) => di.sl<GetCommentsByPostIdBloc>(),
          ),
          BlocProvider<UpdateLocationBloc>(
            create: (context) => di.sl<UpdateLocationBloc>(),
          ),
          BlocProvider<DeletePostBloc>(
            create: (context) => di.sl<DeletePostBloc>(),
          ),
          BlocProvider<UploadFileBloc>(
            create: (context) => di.sl<UploadFileBloc>(),
          ),
          BlocProvider<AddCommentBloc>(
            create: (context) => di.sl<AddCommentBloc>(),
          ),
          BlocProvider<VotePollBloc>(
            create: (context) => di.sl<VotePollBloc>(),
          ),
          BlocProvider<FetchCommentReplyBloc>(
            create: (context) => di.sl<FetchCommentReplyBloc>(),
          ),
          BlocProvider<GiveAwardBloc>(
            create: (context) => di.sl<GiveAwardBloc>(),
          ),
          BlocProvider<GetGenderAndDOBBloc>(
            create: (context) => di.sl<GetGenderAndDOBBloc>(),
          ),
          BlocProvider<GetProfileBloc>(
            create: (context) => di.sl<GetProfileBloc>(),
          ),
          BlocProvider<LogoutBloc>(
            create: (context) => di.sl<LogoutBloc>(),
          ),
          BlocProvider<GetMyPostsBloc>(
            create: (context) => di.sl<GetMyPostsBloc>(),
          ),
          BlocProvider<SendFeedbackBloc>(
            create: (context) => di.sl<SendFeedbackBloc>(),
          ),
          BlocProvider<DeleteAccountBloc>(
            create: (context) => di.sl<DeleteAccountBloc>(),
          ),
          BlocProvider<GetUserInfoBloc>(
            create: (context) => di.sl<GetUserInfoBloc>(),
          ),
          BlocProvider<GetMyCommentsBloc>(
            create: (context) => di.sl<GetMyCommentsBloc>(),
          ),
          BlocProvider<GetMyGroupsBloc>(
            create: (context) => di.sl<GetMyGroupsBloc>(),
          ),
          BlocProvider<EditProfileBloc>(
            create: (context) => di.sl<EditProfileBloc>(),
          ),
          BlocProvider<GetMyAwardsBloc>(
            create: (context) => di.sl<GetMyAwardsBloc>(),
          ),
          BlocProvider<CommunityMainCubit>(
            create: (context) => di.sl<CommunityMainCubit>(),
          ),
          BlocProvider<CommunityCreateCubit>(
            create: (context) => di.sl<CommunityCreateCubit>(),
          ),
          BlocProvider<CommunitySearchCubit>(
            create: (context) => di.sl<CommunitySearchCubit>(),
          ),
          BlocProvider<CommunityDetailsCubit>(
            create: (context) => di.sl<CommunityDetailsCubit>(),
          ),
          BlocProvider<ChatMainCubit>(
            create: (context) => di.sl<ChatMainCubit>(),
          ),
          BlocProvider<ChatPrivateCubit>(
            create: (context) => di.sl<ChatPrivateCubit>(),
          ),
          BlocProvider<ChatGroupCubit>(
            create: (context) => di.sl<ChatGroupCubit>(),
          ),
          BlocProvider<EventMainCubit>(
            create: (context) => di.sl<EventMainCubit>(),
          ),
          BlocProvider<EventCreateCubit>(
            create: (context) => di.sl<EventCreateCubit>(),
          ),
          BlocProvider<EventDetailCubit>(
            create: (context) => di.sl<EventDetailCubit>(),
          ),
          BlocProvider<EventSearchCubit>(
            create: (context) => di.sl<EventSearchCubit>(),
          ),
          BlocProvider<EventJoinCubit>(
            create: (context) => di.sl<EventJoinCubit>(),
          ),
          BlocProvider<NotificationGeneralCubit>(
            create: (context) => di.sl<NotificationGeneralCubit>(),
          ),
          BlocProvider<NotificationListCubit>(
            create: (context) => di.sl<NotificationListCubit>(),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: 'Roboto',
          ),
          debugShowCheckedModeBanner: false,
          title: 'Neighborly',
          routerConfig: router,
        ));
  }
}
