import 'dart:convert';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/about_settings.dart';
import 'package:app_one/model/response/add_topics.dart';
import 'package:app_one/model/response/all_categories.dart';
import 'package:app_one/model/response/all_friends.dart';
import 'package:app_one/model/response/business_profile.dart';
import 'package:app_one/model/response/cities.dart';
import 'package:app_one/model/response/create_social_account.dart';
import 'package:app_one/model/response/edit_business_profile.dart';
import 'package:app_one/model/response/follow.dart';
import 'package:app_one/model/response/forgot_password.dart';
import 'package:app_one/model/response/hash_tags.dart';
import 'package:app_one/model/response/interests.dart';
import 'package:app_one/model/response/intrests.dart';
import 'package:app_one/model/response/like_comment.dart';
import 'package:app_one/model/response/post.dart';
import 'package:app_one/model/response/post_activity.dart';
import 'package:app_one/model/response/post_comment.dart';
import 'package:app_one/model/response/countries.dart';
import 'package:app_one/model/response/create_post.dart';
import 'package:app_one/model/response/edit_profile.dart';
import 'package:app_one/model/response/login.dart';
import 'package:app_one/model/response/post_detail.dart';
import 'package:app_one/model/response/post_dislike.dart';
import 'package:app_one/model/response/post_reporting.dart';
import 'package:app_one/model/response/post_viewed.dart';
import 'package:app_one/model/response/profile_count.dart';
import 'package:app_one/model/response/profile_data.dart';
import 'package:app_one/model/response/profile_info.dart';
import 'package:app_one/model/response/register_user.dart';
import 'package:app_one/model/response/specific_profile_details.dart';
import 'package:app_one/model/response/suggested_friends.dart';
import 'package:app_one/model/response/topics.dart';
import 'package:app_one/model/response/unfollow.dart';
import 'package:app_one/model/response/user_categories.dart';
import 'package:app_one/model/response/verify_recovery_code.dart';
import 'package:app_one/routes/create_account/edit_buisness_profile.dart';
import 'package:app_one/routes/login/verify_email_forgot.dart';
import 'package:app_one/viewmodel/create_user_social_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
 /* {{url}}/code-verify*/
  String baseURL = 'https://breakhot.com/app_one/api';
  String token = Globals.serverToken;
  Future<List<dynamic>> apiRequestRegisterUser(parameterMap) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/register",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',

      },
      body: jsonEncode(parameterMap),
    );
    RegisterUser registeredUserData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      registeredUserData = RegisterUser.fromJson(json.decode(response.body));
      listOfResponseData.add(registeredUserData);
      listOfResponseData.add('');
      return listOfResponseData;
    }

    else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }
  Future<List<dynamic>> apiRequestCreateSocialProfile(parameterMap) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/create/profile",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(parameterMap),
    );
    CreateSocialAccount registeredSocialData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      registeredSocialData = CreateSocialAccount.fromJson(json.decode(response.body));
      listOfResponseData.add(registeredSocialData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestEditBusinessProfile(parameterMap,String profileId) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.put(
      "$baseURL/user/profile/edit/$profileId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(parameterMap),
    );
    EditBuisnessProfileRes registeredSocialData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      registeredSocialData = EditBuisnessProfileRes.fromJson(json.decode(response.body));
      listOfResponseData.add(registeredSocialData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestBusinessAccount(String profileId ) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/profile/detail/$profileId",
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    SpecificProfileDetails   profileDetails;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      profileDetails = SpecificProfileDetails.fromJson(json.decode(response.body));
      listOfResponseData.add(profileDetails);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = " Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }


  Future<List<dynamic>> apiRequestGetCities(String countryId) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/cities/$countryId",
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Cities citiesList;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      citiesList = Cities.fromJson(json.decode(response.body));
      listOfResponseData.add(citiesList);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  ////
  Future<List<dynamic>> apiRequestVerifyRecovery(String email, String code,BuildContext context) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/code-verify",
      body: {
        'email':email,
        'code':code
      },
      headers: <String, String>{

        'Accept': 'application/json',

      },

    );
    VerifyRecoveryCode verifyRecoveryCode;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      try{
        verifyRecoveryCode = VerifyRecoveryCode.fromJson(json.decode(response.body));
        listOfResponseData.add(verifyRecoveryCode);
        listOfResponseData.add('');
      }
      catch(Exception)
    {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Error',
        handler2: (action) => {Navigator.pop(context)},
        bodyText: 'Recovery code not match',
      );
    }
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }
  //

  Future<List<dynamic>> apiRequestGetIntrests() async {
    List<dynamic> listOfResponseData = [];
    final response =
        await http.get('$baseURL/categories', headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    Intrests interests;
    if (response.statusCode == 200) {
      interests = Intrests.fromJson(json.decode(response.body));
      listOfResponseData.add(interests);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }


  Future<List<dynamic>> apiRequestGetHasTag() async {
    List<dynamic> listOfResponseData = [];
    final response =
    await http.get('$baseURL/hashtag', headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    HashTags hashTags;
    if (response.statusCode == 200) {
      hashTags = HashTags.fromJson(json.decode(response.body));
      listOfResponseData.add(hashTags);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = " Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }




  Future<List<dynamic>> apiUpdatePassword(String email,String password,String code) async {
    List<dynamic> listOfResponseData = [];


    
    final response = await http.post(
      "$baseURL/update_password",
      body:{
        'email':email,
        'verification_code':code,
        'password':password
      },
      headers: <String, String>{
        'Accept': 'application/json',

      },
    );
    ForgotDataModel forgotModel;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      forgotModel = ForgotDataModel.fromJson(json.decode(response.body));
      listOfResponseData.add(forgotModel);
      listOfResponseData.add('');
      return listOfResponseData;
    }
    else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }



  Future<List<dynamic>> apiRequestVerifyEmail(String email) async {
    List<dynamic> listOfResponseData = [];
    dynamic bodyData = {"email": email};
    final response = await http.post(
      "$baseURL/forgot_password",
      body: jsonEncode(bodyData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    ForgotDataModel forgotModel;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      forgotModel = ForgotDataModel.fromJson(json.decode(response.body));
      listOfResponseData.add(forgotModel);
      listOfResponseData.add('');
      return listOfResponseData;
    }
    else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future <List<dynamic>> apiRequestGetAboutSettings() async
  {
    List<dynamic> listOfResponseData = [];

    final response = await http.get(
      "$baseURL/about/us",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    AboutUsSettings aboutUsSettings;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      aboutUsSettings = AboutUsSettings.fromJson(json.decode(response.body));
      listOfResponseData.add(aboutUsSettings);
      print("*AboutUsContent ==>"+aboutUsSettings.data.sideBar[0].content.toString());
      listOfResponseData.add('');
      return listOfResponseData;
    }
    else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }

  }



/*  Future <List<dynamic>> apiRequestUpdatePassword(parameterMap) async{
    ///Todo:Kazim you will work here
    final response = await http.post(
      "$baseURL/forgot_password",
      body: jsonEncode(parameterMap),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
*//*      forgotModel = ForgotDataModel.fromJson(json.decode(response.body));
      listOfResponseData.add(forgotModel);
      listOfResponseData.add('');
      return listOfResponseData;*//*
    }
    else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }

  }*/


  Future<List<dynamic>> apiRequestLogin(parameterMap) async {
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(parameterMap),
    );
    LoginDataModel loginUserData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      loginUserData = LoginDataModel.fromJson(json.decode(response.body));
      print("Auth Token: ${loginUserData.data.token}");
      listOfResponseData.add(loginUserData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }






  Future<List<dynamic>> apiRequestCreateBusinessProfile(parameterMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/create/profile",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    BusinessProfile businessProfileData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      businessProfileData =
          BusinessProfile.fromJson(json.decode(response.body));
      listOfResponseData.add(businessProfileData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetAllCategories(String countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/categories",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    AllCategories allCategories;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      allCategories = AllCategories.fromJson(json.decode(response.body));
      listOfResponseData.add(allCategories);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetProfileCount(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/profilescount/$userId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    ProfileCount profileCount;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      profileCount = ProfileCount.fromJson(json.decode(response.body));
      listOfResponseData.add(profileCount);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetUserCategories(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/$userId/interested/categories",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );

    UserCategories userCategories;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      userCategories = UserCategories.fromJson(json.decode(response.body));
      print("UserCat==>"+userCategories.data.length.toString());
      listOfResponseData.add(userCategories);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestViewSocialProfile(
      parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final uri = Uri.http("breakhot.com",
        '/apponecms/api/user/$userId/view/socialprofile/private', parameterMap);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    ProfileInfo profileInfo;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      profileInfo = ProfileInfo.fromJson(json.decode(response.body));
      listOfResponseData.add(profileInfo);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetTopics(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/$userId/get/topics",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    Topics topicsData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      topicsData = Topics.fromJson(json.decode(response.body));
      listOfResponseData.add(topicsData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestAddTopic(String userId, parameterMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/$userId/add/topics",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    AddTopics addTopicsData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      addTopicsData = AddTopics.fromJson(json.decode(response.body));
      listOfResponseData.add(addTopicsData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestCreatePost(
      parameterMap, String profileId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/$profileId/creat/post",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    CreatePost createPostData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      createPostData = CreatePost.fromJson(json.decode(response.body));
      listOfResponseData.add(createPostData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }


  Future<List<dynamic>> apiRequestPostComment(
      String userId, parameterMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/$userId/post/comment",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    PostComment commentPostData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      commentPostData = PostComment.fromJson(json.decode(response.body));
      listOfResponseData.add(commentPostData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestPostActivities(
      parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http
        .post(
          "$baseURL/user/$userId/post/activities",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
          },
          body: jsonEncode(parameterMap),
        )
        .timeout(Duration(minutes: 2));
    PostActivity postActivityData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      postActivityData = PostActivity.fromJson(json.decode(response.body));
      listOfResponseData.add(postActivityData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        case 408:
          error = "Request timed out";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestPostRevertLike(
      parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.patch(
      "$baseURL/user/$userId/post/dislike",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    PostRevertLike postDislikeData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      postDislikeData = PostRevertLike.fromJson(json.decode(response.body));
      listOfResponseData.add(postDislikeData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestFollow(parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/$userId/follow",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    Follow follow;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      follow = Follow.fromJson(json.decode(response.body));
      listOfResponseData.add(follow);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestUnfollow(
      String userId, String unFollowId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/$userId/unfollow/$unFollowId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    Unfollow unfollowData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      unfollowData = Unfollow.fromJson(json.decode(response.body));
      listOfResponseData.add(unfollowData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "User Does Not Exist";
          break;
        case 422:
          error = "Already Followed";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestViewProfileData(
      parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final uri = Uri.http(
        "breakhot.com", '/user/$userId/view/buisness/profile', parameterMap);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    ProfileData profileData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      profileData = ProfileData.fromJson(json.decode(response.body));
      listOfResponseData.add(profileData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetAllFriends(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/$userId/friends",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    AllFriends allFriendsData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      allFriendsData = AllFriends.fromJson(json.decode(response.body));
      listOfResponseData.add(allFriendsData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }
/*  {{url}}/user/75/userposts*/

  ////used posts for social profile and use userposts for specific bussniess profile
  Future<List<dynamic>> apiRequestGetAllPosts(String userId,String urlPost) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('$baseURL/user/$userId/posts');
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/$userId/$urlPost",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    Post postData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      postData = Post.fromJson(json.decode(response.body));
      listOfResponseData.add(postData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetPostDetail(
      String userId, String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/user/$userId/post/$postId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    PostDetail postDetailData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      postDetailData = PostDetail.fromJson(json.decode(response.body));
      listOfResponseData.add(postDetailData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found";
          break;
        case 422:
          error = "Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetHashTags(
      String userId, String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.get(
      "$baseURL/hashtag",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    HashTags hashTagsData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      hashTagsData = HashTags.fromJson(json.decode(response.body));
      listOfResponseData.add(hashTagsData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found";
          break;
        case 422:
          error = "Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestPostCommentLike(
      parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http
        .post(
          "$baseURL/user/$userId/comment/like",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
          },
          body: jsonEncode(parameterMap),
        )
        .timeout(Duration(minutes: 2));
    LikeComment likeCommentData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      likeCommentData = LikeComment.fromJson(json.decode(response.body));
      listOfResponseData.add(likeCommentData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Username or password is incorrect";
          break;
        case 422:
          error = "Email already used Or information missing";
          break;
        case 500:
          error = "Server down try later";
          break;
        case 408:
          error = "Request timed out";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestPostViewed(
      String userId, String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/$userId/post/view/$postId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    PostViewed postViewedData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      postViewedData = PostViewed.fromJson(json.decode(response.body));
      listOfResponseData.add(postViewedData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "User Does Not Exist";
          break;
        case 422:
          error = "Already Followed";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestReportPost(
      parameterMap, String userId, String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final response = await http.post(
      "$baseURL/user/$userId/post/reporting/$postId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
      body: jsonEncode(parameterMap),
    );
    PostReporting postReportingData;
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      postReportingData = PostReporting.fromJson(json.decode(response.body));
      listOfResponseData.add(postReportingData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.statusCode);
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "User Does Not Exist";
          break;
        case 422:
          error = "Already Followed";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }

  Future<List<dynamic>> apiRequestGetSuggestedFriends(
      parameterMap, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> listOfResponseData = [];
    final uri = Uri.http(
        "breakhot.com", '/user/$userId/suggested/friends', parameterMap);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.get(Globals.userAuthToken)}'
      },
    );
    SuggestedFriends suggestedFriendsData;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      suggestedFriendsData =
          SuggestedFriends.fromJson(json.decode(response.body));
      listOfResponseData.add(suggestedFriendsData);
      listOfResponseData.add('');
      return listOfResponseData;
    } else {
      print(response.body);
      var error;
      switch (response.statusCode) {
        case 404:
          error = "Data Not Found For User";
          break;
        case 422:
          error = "Email Already Used Or Information Missing";
          break;
        case 500:
          error = "Server Down Try Later";
          break;
        default:
          error = response.reasonPhrase;
      }
      print(error);
      listOfResponseData.add('');
      listOfResponseData.add(error);
      return listOfResponseData;
    }
  }
}
