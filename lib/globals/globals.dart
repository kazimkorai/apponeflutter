import 'package:flutter/cupertino.dart';

class Globals {
// Url For Apis
  static String loginUrl = 'https://strawberrypop.arcticapps.dev/api/signin';
  static String serverToken = "";
  static String firebaseCloudServerToken =
      "AAAArGWF1DA:APA91bGCHo5eUZFzrQrb_E4kzp8"
      "LYHBVHKdso2zuo3U8khGv8Llg8DGdkkccGnWC9jH5PnEp7vjcvQLYOQegMQnp0ZycgVF8-"
      "DOAAfrJW-GKn6YKrEH1zf_rV_uRQl3a_czXdZHVE60j";

  ///Static String Value Set For Key In Shared Preference.
  ///To Store ID For ChatWith User.
  static String currentChatRoomId = "currentChatRoomId";
  static String userAuthToken = "2|Z6DIbIMcwJrCpRziziA6pmmdcFClzDCgyb04l5Ht";
  static String userName = "userName";
  static String profileId = "profileId";
  static String userId = "userId";
  static String profileType = "profileType";
  static String profileStatus = "profileStatus";
  static String countryId = "countryId";
  static String cityId = "cityId";
  static String emailId = "emailId";
  static bool isHasSocialAccount = false;
  static String forgetEmailTemp = 'forgetEmailTemp';
  static String recoveryCode = 'forgetcode';

  static String dateOfBirth = 'dateOfBirth';
  static String cityName = "cityName";
  static String countryName = "countryName";
  static String socialProfileName = "";
  static String socialProfileImage = "";
  static String gender = "gender";

  static String currentSelectedAcountName="";
  static String SocialAccount="";
  static String afterSelectedAccountValue="";
  static String socialProfileId="socialProfile";
  static String passwordTemp="temp";
static  String defualtRoundColor="defualtRoundColor";

  static String userPostId="userPostId";
  static String profileNameForMainDrawer="";
  static String profileImageForMainDrawer="";

  static String urlImageSocial="urlImageSocial";
  static String urlImageBusiness="urlImageBusiness";
  static String addressLine="addressLine";
  ///Save Route Info For Navigation.
  static String currentRoute;
  static String goToRoute;
}
