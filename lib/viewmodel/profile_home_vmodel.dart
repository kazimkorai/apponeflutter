import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/all_friends.dart';
import 'package:app_one/model/response/post.dart';
import 'package:app_one/model/response/post_activity.dart';
import 'package:app_one/model/response/post_dislike.dart';
import 'package:app_one/model/response/post_reporting.dart';
import 'package:app_one/model/response/post_viewed.dart';
import 'package:app_one/model/response/user_categories.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHomeViewModel extends BaseModel {

  ApiServices apiService = locator<ApiServices>();
  AllFriends friendListData;
  bool friendsListSuccess;
  String friendsListErrorMsg;
  UserCategories categoriesData;
  bool categoriesSuccess;
  String categoriesErrorMsg;
  Post userPostsData;
  bool userPostsSuccess;
  String userPostsErrorMsg;
  PostActivity postActivityData;
  bool postActivitySuccess;
  String postActivityErrorMsg;
  PostRevertLike postRevertLikeData;
  bool postRevertLikeSuccess;
  String postRevertLikeErrorMsg;
  bool postViewedSuccess;
  PostViewed postViewedData;
  String postViewedErrorMsg;
  bool postReportingSuccess;
  String postReportingErrorMsg;
  PostReporting postReportingData;


  Future<bool> getFriendsList({String userId})async{
    friendsListSuccess=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
        var result=await apiService.apiRequestGetAllFriends(prefs.get(Globals.profileId));
    if(result[0]!='')
    {
      friendListData =result[0];
      friendsListSuccess = true;

    }
    else{
      friendsListErrorMsg = result[1];
      friendsListSuccess = false;
    }
    return friendsListSuccess;
  }
  Future<bool> getUserInterestedCategories({String userId})async{
    categoriesSuccess= null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestGetUserCategories(prefs.get(Globals.profileId));
    if(result[0]!='')
    {
      categoriesData =result[0];
      categoriesSuccess = true;

    }
    else{
      categoriesErrorMsg = result[1];
      categoriesSuccess = false;
    }
    return categoriesSuccess;
  }


  Future<bool> getUserPosts({String userId})async{
    userPostsSuccess= null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String urlPost=prefs.getString(Globals.userPostId);
    var result=await apiService.apiRequestGetAllPosts(prefs.get(Globals.profileId),urlPost);
    if(result[0]!='')
    {
      userPostsData =result[0];
      userPostsSuccess = true;

    }
    else{
      userPostsErrorMsg = result[1];
      userPostsSuccess = false;
    }
    return userPostsSuccess;
  }
  Future<bool> postActivities(parameterMap, {String userId})async{
    postActivitySuccess=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestPostActivities(parameterMap,
        prefs.get(Globals.profileId));
    if(result[0]!='')
    {
      postActivityData =result[0];
      postActivitySuccess = true;

    }
    else{
      postActivityErrorMsg = result[1];
      postActivitySuccess = false;
    }
    return postActivitySuccess;
  }
  Future<bool> postRevertLike(parameterMap, {String userId})async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestPostRevertLike(parameterMap,
      prefs.get(Globals.profileId),
     );
    if(result[0]!='')
    {
      postRevertLikeData =result[0];
      postRevertLikeSuccess = true;

    }
    else{
      postRevertLikeErrorMsg = result[1];
      postRevertLikeSuccess = false;
    }
    return postRevertLikeSuccess;
  }
  Future<bool> postViewed({String postId,String userId})async{
    postViewedSuccess= null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestPostViewed(prefs.get(Globals.profileId),postId);
    if(result[0]!='')
    {
      postViewedData =result[0];
      postViewedSuccess = true;

    }
    else{
      postViewedErrorMsg = result[1];
      postViewedSuccess = false;
    }
    return postViewedSuccess;
  }
  Future<bool> reportPost(parameterMap,{String postId,String userId})async{
    postReportingSuccess= null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestReportPost(parameterMap,
        prefs.get(Globals.profileId),postId);
    if(result[0]!='')
    {
      postReportingData =result[0];
      postReportingSuccess = true;

    }
    else{
      postReportingErrorMsg = result[1];
      postReportingSuccess = false;
    }
    return postReportingSuccess;
  }



}