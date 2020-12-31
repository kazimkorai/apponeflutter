
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/about_settings.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';

class AboutSettingsViewModel extends BaseModel
{

  FireBaseService fireBaseService = locator<FireBaseService>();
  ApiServices apiService = locator<ApiServices>();
  bool aboutUsSettingsSuccess=false;
  AboutUsSettings aboutUsSettingsData;


  Future<bool> aboutUsSettings() async
  {
    var result=await apiService.apiRequestGetAboutSettings();
    print(result[0].toString());
    if (result[0] != '') {
      aboutUsSettingsData = result[0];
      aboutUsSettingsSuccess = true;
    } else {

      aboutUsSettingsSuccess = false;
    }
    return aboutUsSettingsSuccess;
  }


}