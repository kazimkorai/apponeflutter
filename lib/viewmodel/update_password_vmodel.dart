

import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/create_social_account.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdatePasswordViewModel extends BaseModel {
  ApiServices apiService = locator<ApiServices>();
  bool createBuisnessSuccess;
  String createBuisnessErrorMsg;
  dynamic createBuisnessData;

  Future<bool> updatePassword(parameterMap) async {
    var result = await apiService.apiRequestCreateSocialProfile(parameterMap);
    if (result[0] != '') {
      createBuisnessData = result[0];
      createBuisnessSuccess = true;
    } else {
      createBuisnessData = result[1];
      createBuisnessSuccess = false;
    }
    return createBuisnessSuccess;
  }

}
