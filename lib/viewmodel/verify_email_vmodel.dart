
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/forgot_password.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:flutter/services.dart';
import 'package:app_one/services/apis/api_services.dart';

class VerifyEmailModel extends BaseModel
{
  FireBaseService fireBaseService = locator<FireBaseService>();
  ApiServices apiService = locator<ApiServices>();
  bool verifySuccess=false;
  ForgotDataModel forgotModel;


  Future<bool> verifyEmail(String email) async
  {
    var result = await apiService.apiRequestVerifyEmail(email);

    print(result[0].toString());
    if (result[0] != '') {
      forgotModel = result[0];
      verifySuccess = true;
    } else {

      verifySuccess = false;
    }
    return verifySuccess;
  }

  Future<bool> updatePassword(String email,String password,String code) async
  {
    var result = await apiService.apiUpdatePassword(email,password,code);

    print(result[0].toString());
    if (result[0] != '') {
      forgotModel = result[0];
      verifySuccess = true;
    } else {

      verifySuccess = false;
    }
    return verifySuccess;

  }
}