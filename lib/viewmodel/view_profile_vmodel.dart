import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/add_topics.dart';
import 'package:app_one/model/response/follow.dart';
import 'package:app_one/model/response/profile_info.dart';
import 'package:app_one/model/response/topics.dart';
import 'package:app_one/model/response/unfollow.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfileViewModel extends BaseModel {

  ApiServices apiService = locator<ApiServices>();
  ProfileInfo profileData;
  bool profileSuccess;
  String profileInfoErrorMsg;
  AddTopics addTopicData;
  bool addTopicSuccess;
  String addTopicErrorMsg;
  Topics topicsData;
  bool topicsSuccess;
  String topicsErrorMsg;
  Unfollow unfollowData;
  bool unfollowSuccess;
  String unfollowErrorMsg;
  bool followSuccess;
  Follow followData;
  String followErrorMsg;


  Future<bool> getProfileInfo(parameterMap,String userId)async{
    var result=await apiService.apiRequestViewSocialProfile(parameterMap,userId);
    if(result[0]!='')
    {
      profileData =result[0];
      profileSuccess = true;

    }
    else{
      profileInfoErrorMsg = result[1];
      profileSuccess = false;
    }
    return profileSuccess;
  }

  Future<bool> addTopic(String userId,parameterMap)async{
    var result=await apiService.apiRequestAddTopic(userId,parameterMap);
    if(result[0]!='')
    {
      addTopicData =result[0];
      addTopicSuccess = true;

    }
    else{
      addTopicErrorMsg = result[1];
      addTopicSuccess = false;
    }
    return addTopicSuccess;
  }

  Future<bool> getUserTopics(String userId)async{
    var result=await apiService.apiRequestGetTopics(userId);
    if(result[0]!='')
    {
      topicsData =result[0];
      topicsSuccess = true;

    }
    else{
      topicsErrorMsg = result[1];
      topicsSuccess = false;
    }
    return topicsSuccess;
  }

  Future<bool> unfollowProfile({String userId,String unfollowId})async{
    unfollowSuccess= null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestUnfollow(prefs.getString(Globals.profileId),unfollowId);
    if(result[0]!='')
    {
      unfollowData =result[0];
      unfollowSuccess = true;

    }
    else{
      unfollowErrorMsg = result[1];
      unfollowSuccess = false;
    }
    return unfollowSuccess;
  }

  Future<bool> followProfile(parameterMap, {String userId})async{
    followSuccess = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestFollow(parameterMap,
        prefs.getString(Globals.profileId));
    if(result[0]!='')
    {
      followData =result[0];
      followSuccess = true;

    }
    else{
      followErrorMsg = result[1];
      followSuccess = false;
    }
    return profileSuccess;
  }

}