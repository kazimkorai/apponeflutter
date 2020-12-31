
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/verify_recovery_code.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:flutter/cupertino.dart';

class VerifyRecoveryEmailModel extends BaseModel
{
  FireBaseService fireBaseService = locator<FireBaseService>();
  ApiServices apiService = locator<ApiServices>();
  bool verifySuccess=false;
  VerifyRecoveryCode verifyCodeModel;

  Future<bool> verifyRecoveryCode(String email,String code,BuildContext context) async
  {
    var result = await apiService.apiRequestVerifyRecovery(email,code,context);

    print(result[0].toString());
    if (result[0] != '') {
      verifyCodeModel = result[0];
      verifySuccess = true;
    } else {

      verifySuccess = false;
    }
    return verifySuccess;
  }
}