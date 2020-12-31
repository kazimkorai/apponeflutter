import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/like_comment.dart';
import 'package:app_one/model/response/post_activity.dart';
import 'package:app_one/model/response/post_comment.dart';
import 'package:app_one/model/response/post_detail.dart';
import 'package:app_one/model/response/post_dislike.dart';
import 'package:app_one/model/response/post_viewed.dart';
import 'package:app_one/model/response/profile_count.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDetailViewModel extends BaseModel {

  ApiServices apiService = locator<ApiServices>();
  PostDetail postDetailData;
  bool postDetailSuccess;
  String postDetailErrorMsg;
  PostComment postCommentData;
  bool postCommentSuccess;
  String postCommentErrorMsg;
  PostRevertLike postRevertLikeData;
  String postRevertLikeErrorMsg;
  bool postRevertLikeSuccess;
  bool postActivitySuccess;
  PostActivity postActivityData;
  String postActivityErrorMsg;
  bool postCommentLikeSuccess;
  LikeComment postCommentLikeData;
  String postCommentLikeErrorMsg;
  bool postViewedSuccess;
  PostViewed postViewedData;
  String postViewedErrorMsg;


  Future<bool> getPostDetails({String userId,String postId})async{
    postDetailSuccess = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestGetPostDetail(prefs.get(Globals.profileId),
        postId);
    if(result[0]!='')
    {
      postDetailData =result[0];
      postDetailSuccess = true;

    }
    else{
      postDetailErrorMsg = result[1];
      postDetailSuccess = false;
    }
    return postDetailSuccess;
  }

  Future<bool> commentOnPost({String userId,parameterMap})async{
    postCommentSuccess= null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestPostComment(prefs.get(Globals.profileId),
        parameterMap);
    if(result[0]!='')
    {
      postCommentData =result[0];
      postCommentSuccess = true;

    }
    else{
      postCommentErrorMsg = result[1];
      postCommentSuccess = false;
    }
    return postCommentSuccess;
  }

  Future<bool> postRevertLike(parameterMap,{String userId})async{
    postRevertLikeSuccess = null;
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

  Future<bool> postActivities(parameterMap,{String userId})async{
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

  Future<bool> postCommentLike(parameterMap,{String userId})async{
    postCommentLikeSuccess=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result=await apiService.apiRequestPostCommentLike(parameterMap,
        prefs.get(Globals.profileId));
    if(result[0]!='')
    {
      postCommentLikeData =result[0];
      postCommentLikeSuccess = true;

    }
    else{
      postCommentLikeErrorMsg = result[1];
      postCommentLikeSuccess = false;
    }
    return postCommentLikeSuccess;
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

}