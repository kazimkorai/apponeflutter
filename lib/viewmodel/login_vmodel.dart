import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/login.dart';
import 'package:app_one/model/response/register_user.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseModel {

  FireBaseService fireBaseService = locator<FireBaseService>();
  ApiServices apiService = locator<ApiServices>();
  RegisterUser registrationData;
  bool registerSuccess;
  String registrationErrorMsg;
  LoginDataModel loginData;
  bool loginSuccess;
  String loginErrorMsg;
  Future<String> login(email,password)async{
    return await fireBaseService.loginUserWithEmailPassword(email: email,
        password: password);
  }
  Future<bool> updateUserFcmToken()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var update=false;
    var tokenResult =await fireBaseService.getToken();
    if(tokenResult != 'Failed')
      {
        await FirebaseFirestore.instance.collection("users")
            .doc(FireBaseService.getCurrentUserUid()).update({
          'fcmToken':tokenResult
        }).then((value) => {
          pref.setString('userFcmToken', tokenResult),
         print("Login: Token Update Successful $tokenResult"),
         update = true
        }).catchError((error)=>{
          print(error),
          update = false
        });
      }
    else{
      update = false;
    }
   return update;
  }
  Future<bool> registerUser(parameterMap)async{
     var result=await apiService.apiRequestRegisterUser(parameterMap);
     if(result[0]!='')
       {
         registrationData =result[0];
         registerSuccess = true;

       }
     else{
       registrationErrorMsg = result[1];
       registerSuccess = false;
     }
     return registerSuccess;
  }

  Future<bool> loginUser(parameterMap)async{
    var result=await apiService.apiRequestLogin(parameterMap);
    if(result[0]!='')
    {
      loginData =result[0];
      loginSuccess = true;

    }
    else{
      loginErrorMsg = result[1];
      loginSuccess = false;
    }
    return loginSuccess;
  }
}