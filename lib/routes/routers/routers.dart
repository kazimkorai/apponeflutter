import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/about_us/about_us.dart';
import 'package:app_one/routes/chat_box/add_group_details.dart';
import 'package:app_one/routes/chat_box/chat_with_new_user.dart';
import 'package:app_one/routes/chat_box/notifications.dart';
import 'package:app_one/routes/chat_box/chat_main.dart';
import 'package:app_one/routes/chat_box/create_group.dart';
import 'package:app_one/routes/chat_box/group_chat.dart';
import 'package:app_one/routes/chat_box/oneToOne_chatbox.dart';
import 'package:app_one/routes/chat_box/social_inbox.dart';
import 'package:app_one/routes/create_account/create_account.dart';
import 'package:app_one/routes/create_account/create_buisness_profile.dart';
import 'package:app_one/routes/create_account/create_social_profile.dart';
import 'package:app_one/routes/create_account/edit_buisness_profile.dart';
import 'package:app_one/routes/create_account/edit_account.dart';
import 'package:app_one/routes/create_account/edit_social_profile.dart';
import 'package:app_one/routes/create_account/select_profile_type.dart';
import 'package:app_one/routes/create_post/create_post.dart';
import 'package:app_one/routes/create_post/create_video_post.dart';
import 'package:app_one/routes/login/update_password.dart';
import 'package:app_one/routes/login/verify_email_forgot.dart';
import 'package:app_one/routes/login/login.dart';
import 'package:app_one/routes/login/verify_recovery_code.dart';
import 'package:app_one/routes/profile/post_detail_view.dart';
import 'package:app_one/routes/profile/profile_searched.dart';
import 'package:app_one/routes/profile/view_profile.dart';
import 'package:app_one/routes/profile/profile_home.dart';
import 'package:app_one/routes/settings/group_settings.dart';
import 'package:app_one/routes/settings/message_options.dart';
import 'file:///D:/apponeflutterKazimStart/apponeflutter/lib/routes/side_left_settings/settings.dart';
import 'package:app_one/routes/settings/single_chat_settings.dart';
import 'package:app_one/routes/side_left_settings/notification_settings.dart';
import 'package:app_one/routes/side_left_settings/privacy_policy.dart';
import 'package:app_one/routes/side_left_settings/terms_conditions.dart';
import 'package:app_one/routes/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routers{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch (settings.name)
    {
      case '/':
        return MaterialPageRoute(builder: (_)=> SplashScreen());
      case '/login':
        Globals.currentRoute="/login";
        return MaterialPageRoute(builder: (_)=> Login());
      case '/forgot_password':
        Globals.currentRoute="/forgot_password";
        return MaterialPageRoute(builder: (_)=> VerifyEmailForgt());

      case '/verify_recovery_code':
        Globals.currentRoute="/verify_recovery_code";
        return MaterialPageRoute(builder: (_)=>VerifyRecoverCode());

      case '/update_password':
        Globals.currentRoute="/update_password";
        return MaterialPageRoute(builder: (_)=>UpdatePassword());

      case '/create_account':
        Globals.currentRoute="/create_account";
        return MaterialPageRoute(builder: (_)=> CreateAccount());

      case '/edit_account':
        Globals.currentRoute="/edit_account";
        return MaterialPageRoute(builder: (_)=>EditAccount());
      case '/edit_social_profile':
        Globals.currentRoute="/edit_social_profile";
        return MaterialPageRoute(builder: (_)=>EditSocialProfile());


      case '/select_profile_type':
        Globals.currentRoute="/select_profile_type";
        return MaterialPageRoute(builder: (_)=> SelectProfileType());
      case '/create_social_profile':
        Globals.currentRoute="/create_social_profile";
        return MaterialPageRoute(builder: (_)=> CreateSocialProfile(
          userRegistrationData:settings.arguments,));
      case '/create_business_profile':
        Globals.currentRoute="/create_business_profile";
        return MaterialPageRoute(builder: (_)=> CreateBusinessProfile());
      case '/notifications':
        Globals.currentRoute="/notifications";
        return MaterialPageRoute(builder: (_)=> NotificationsScreen());
      case '/chat_main':
        Globals.currentRoute="/chat_main";
        return MaterialPageRoute(builder: (_)=> ChatMain());
      case '/about_us':
        Globals.currentRoute="/about_us";
        return MaterialPageRoute(builder: (_)=> AboutUs());
      case '/settings':
        Globals.currentRoute="/settings";
        return MaterialPageRoute(builder: (_)=> Settings());
      case '/terms_cond':
        Globals.currentRoute="/terms_cond";
        return MaterialPageRoute(builder: (_)=>TermsAndConditions());

      case '/privacy_policy':
        Globals.currentRoute="/privacy_policy";
        return MaterialPageRoute(builder: (_)=>PrivacyPolicy());

      case '/notification_settings':
        Globals.currentRoute="/notification_settings";
        return MaterialPageRoute(builder:(_)=> NotificationSettings());

      case '/create_post':
        Globals.currentRoute="/create_post";
        return MaterialPageRoute(builder: (_)=> CreatePost());
      case '/create_video_post':
        Globals.currentRoute="/create_video_post";
      return MaterialPageRoute(builder: (_)=> CreateVideoPost());
      case '/view_profile':
        Globals.currentRoute="/view_profile";
        return MaterialPageRoute(builder: (_)=> ViewProfile(data: settings.arguments,));
      case '/profile_home':
        Globals.currentRoute="/profile_home";
        return MaterialPageRoute(builder: (_)=> ProfileHome());

      case '/edit_buisness_profile':
        Globals.currentRoute="/edit_buisness_profile";

    return MaterialPageRoute(builder: (_)=>EditBuisnessProfile());

      case '/profile_searched':
        Globals.currentRoute="/profile_searched";
      return MaterialPageRoute(builder: (_)=> ProfileSearched());
      case '/post_detail_view':
        Globals.currentRoute="/post_detail_view";
        return MaterialPageRoute(builder: (_)=> PostDetailView(postData: settings.arguments,));
      case '/social_inbox':
        Globals.currentRoute="/social_inbox";
        return MaterialPageRoute(builder: (_)=> SocialInbox());
      case '/create_group':
        Globals.currentRoute="/create_group";
        return MaterialPageRoute(builder: (_)=> CreateGroup());
      case '/chat_with_new_user':
        Globals.currentRoute="/chat_with_new_user";
        return MaterialPageRoute(builder: (_)=> ChatWithNewUser());
      case '/group_details':
        Globals.currentRoute="/group_details";
        return MaterialPageRoute(builder: (_)=> AddGroupDetails(
          selectedGroupUsers: settings.arguments,));
      case '/group_chat':
        Globals.currentRoute="/group_chat";
        return MaterialPageRoute(builder: (_)=> GroupChat(
          groupData: settings.arguments,));
      case '/group_settings':
        Globals.currentRoute="/group_settings";
        return MaterialPageRoute(builder: (_)=> GroupSettings(groupData: settings.arguments,));
      case '/one_to_one_chatbox':
        Globals.currentRoute="/one_to_one_chatbox";
        return MaterialPageRoute(builder: (_)=> OneToOneChatBox(
          chatWithUserId:settings.arguments,));
      case '/message_options':
        Globals.currentRoute="/message_options";
        return MaterialPageRoute(builder: (_)=> MessageOptions());
      case '/single_chat_settings':
        Globals.currentRoute="/single_chat_settings";
        return MaterialPageRoute(builder: (_)=> SingleChatSettings(
          selectedUserId: settings.arguments,
        ));
      default:
        return MaterialPageRoute(builder: (_)=> Scaffold(
          body: Center(child: Text('No Route Defined For ${settings.name}'),),
        ));
    }
  }
}