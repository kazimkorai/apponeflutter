
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/create_social_account.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateSocialAccountViewModel extends BaseModel {

  ApiServices apiService = locator<ApiServices>();
  bool createSocialSuccess;
  String createSocialErrorMsg;
  dynamic createSocialData;

  Future<bool> createSocialAccount(parameterMap) async {
    var result = await apiService.apiRequestCreateSocialProfile(parameterMap);
    if (result[0] != '') {
      createSocialData = result[0];
      createSocialSuccess = true;
    } else {
      createSocialData = result[1];
      createSocialSuccess = false;
    }
    return createSocialSuccess;
  }





}
