import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/profile_count.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerRightViewModel extends BaseModel {
  ApiServices apiService = locator<ApiServices>();
  ProfileCount profileCountData;
  bool profileCountSuccess;
  String profileCountErrorMsg;
  String currentSocialProfileName;

  Future<bool> getProfileCounts({String userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result =
        await apiService.apiRequestGetProfileCount(prefs.get(Globals.userId));
    if (result[0] != '') {
      profileCountData = result[0];

      print(profileCountData.data.buisnessProfiles.length.toString());
      currentSocialProfileName =
          profileCountData.data.socialProfiles[0].profileName.toString();
      Globals.currentSelectedAcountName =
          profileCountData.data.socialProfiles[0].profileName.toString();
      Globals.SocialAccount =
          profileCountData.data.socialProfiles[0].profileName.toString();

      await prefs.setString(Globals.urlImageSocial, profileCountData.data.socialProfiles[0].profileImage.toString());

      if (prefs.getString(Globals.afterSelectedAccountValue).toString() == "") {


        await prefs.setString(Globals.afterSelectedAccountValue,
            Globals.currentSelectedAcountName);

      }
      profileCountSuccess = true;
    } else {
      profileCountErrorMsg = result[1];
      profileCountSuccess = false;
    }
    return profileCountSuccess;
  }
}
