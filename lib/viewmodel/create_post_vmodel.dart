import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/create_post.dart';
import 'package:app_one/model/response/login.dart';
import 'package:app_one/model/response/profile_info.dart';
import 'package:app_one/model/response/register_user.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostViewModel extends BaseModel {

  ApiServices apiService = locator<ApiServices>();
  CreatePost createPostData;
  bool createPostSuccess;
  String createPostErrorMsg;


  Future<bool> createPost(parameterMap,String profileId)async{
    var result=await apiService.apiRequestCreatePost(parameterMap,profileId);
    if(result[0]!='')
    {
      createPostData =result[0];
      createPostSuccess = true;

    }
    else{
      createPostErrorMsg = result[1];
      createPostSuccess = false;
    }
    return createPostSuccess;
  }

}