

import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/create_social_account.dart';
import 'package:app_one/model/response/edit_business_profile.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBuisnessAccountViewModel extends BaseModel {
  ApiServices apiService = locator<ApiServices>();
  bool createBuisnessSuccess;
  String createBuisnessErrorMsg;
  dynamic createBuisnessData;

  bool editBussinessSuccess=false;
  EditBuisnessProfileRes editBussinessData;


  Future<bool> createBuisnessAccount(parameterMap) async {
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



  Future<bool> editBuisnessAccount(parameterMap) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String profileId=pref.getString(Globals.profileId).toString();

    var result = await apiService.apiRequestEditBusinessProfile(parameterMap,profileId);
    if (result[0] != '') {
      editBussinessData = result[0];
      editBussinessSuccess = true;
    } else {
      editBussinessData = result[1];
      editBussinessSuccess = false;
    }
    return editBussinessSuccess;
  }
}
