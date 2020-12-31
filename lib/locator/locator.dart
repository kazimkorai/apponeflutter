import 'package:app_one/model/response/create_post.dart';
import 'package:app_one/model/response/forgot_password.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/about_us_settings_viewmodel.dart';
import 'package:app_one/viewmodel/add_group_detail_vmodel.dart';
import 'package:app_one/viewmodel/create_post_vmodel.dart';
import 'package:app_one/viewmodel/create_user_social_account.dart';
import 'package:app_one/viewmodel/create_user_vmodel.dart';
import 'package:app_one/viewmodel/drawer_right_vmodel.dart';
import 'package:app_one/viewmodel/verify_email_vmodel.dart';
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:app_one/viewmodel/onoToOne_vmodel.dart';
import 'package:app_one/viewmodel/post_detail_vmodel.dart';
import 'package:app_one/viewmodel/profile_home_vmodel.dart';
import 'package:app_one/viewmodel/verify_recovery_code.dart';
import 'package:app_one/viewmodel/view_profile_vmodel.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerFactory(() => FireBaseService());
  locator.registerFactory(() => ApiServices());
  locator.registerFactory(() => CreateUserViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => OneToOneViewModel());
  locator.registerFactory(() => AddGroupDetailViewModel());
  locator.registerFactory(() => ViewProfileViewModel());
  locator.registerFactory(() => ProfileHomeViewModel());
  locator.registerFactory(() => DrawerRightViewModel());
  locator.registerFactory(() => CreatePostViewModel());
  locator.registerFactory(() => PostDetailViewModel());
  locator.registerFactory(() => VerifyEmailModel());
  locator.registerFactory(() => CreateSocialAccountViewModel());
  locator.registerFactory(() => AboutSettingsViewModel());
  locator.registerFactory(() => VerifyRecoveryEmailModel());

}
