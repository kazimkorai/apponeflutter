import 'dart:convert';

import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/model/response/countries.dart';
import 'package:app_one/model/response/countrymodel_kazim.dart';
import 'package:app_one/model/response/hash_tags.dart';
import 'package:app_one/model/response/intrests.dart';
import 'package:app_one/model/response/register_user.dart';
import 'package:app_one/model/response/specific_profile_details.dart';
import 'package:app_one/services/apis/api_services.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUserViewModel extends BaseModel {
  FireBaseService fireBaseService = locator<FireBaseService>();
  ApiServices apiService = locator<ApiServices>();
  RegisterUser registrationData;
  bool registerSuccess;
  String registrationErrorMsg;
  List<CountryKazim> listCountries=new List();
  SpecificProfileDetails specificProfileDetails;
  var countriesErrorMsg;
  bool countrySuccess;
  var cityData;
  bool citySuccess;
  var cityErrorMsg;
  var businessProfileData;
  bool businessProfileSuccess;
  var businessProfileErrorMsg;
  bool intrestsSuccess;
  var intrestsError;
  Intrests intrestsData;
  HashTags hashTagsData;
  bool hashTagSuccess=false;
  var hashTagError;
bool  getSocialSuccess=false;


  Future<String> createUser({email, password, userImageFile}) async {

    return await fireBaseService.createUserWithEmailPass(
        email: email, password: password, userImageFile: userImageFile);
  }
  Future<bool> updateUserFcmToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var update = false;
    var tokenResult = await fireBaseService.getToken();
    if (tokenResult != 'Failed') {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FireBaseService.getCurrentUserUid())
          .update({'fcmToken': tokenResult})
          .then((value) => {
                pref.setString('userFcmToken', tokenResult),
                print("Login: Token Update Successful $tokenResult"),
                update = true
              })
          .catchError((error) => {print(error), update = false});
    } else {
      update = false;
    }
    return update;
  }
  Future<bool> registerUser(parameterMap) async {

    var result = await apiService.apiRequestRegisterUser(parameterMap);
    if (result[0] != '') {
      registrationData = result[0];
      registerSuccess = true;
    } else {
      registrationErrorMsg = result[1];
      registerSuccess = false;
    }
    return registerSuccess;
  }
  Future<String>_loadFromAsset() async {
    return await rootBundle.loadString("assets/json/countries.json");
  }
  Future<bool> getCountries() async {
    countrySuccess=false;
    var jsonString = await _loadFromAsset();
    var jsonResponse = json.decode(jsonString);
    print(jsonResponse['data']);
    for(int index=0;index<jsonResponse['data'].length;index++)
      {
        CountryKazim dataModel=CountryKazim(jsonResponse['data'][index]['id'].toString(),jsonResponse['data'][index]['name'].toString());
        listCountries.add(dataModel);
        countrySuccess=true;

      }
    return countrySuccess;
  }
  Future<bool> getCities(String countryId) async {
    var result = await apiService.apiRequestGetCities(countryId);
    if (result[0] != '') {
      cityData = result[0];
      citySuccess = true;
    } else {
      cityErrorMsg = result[1];
      citySuccess = false;
    }
    return citySuccess;
  }
  Future<bool> createBusinessProfile(parameterMap) async {
    var result = await apiService.apiRequestCreateBusinessProfile(parameterMap);
    if (result[0] != '') {
      businessProfileData = result[0];
      businessProfileSuccess = true;
    } else {
      businessProfileErrorMsg = result[1];
      businessProfileSuccess = false;
    }
    return businessProfileSuccess;
  }
  Future <bool> getIntrests() async
  {
    var results=await apiService.apiRequestGetIntrests();
    if(results[0]!='')
    {
      intrestsData=results[0];
      intrestsSuccess=true;
    }
    else
    {intrestsError=results[1];
    intrestsSuccess=false;
    }
    return intrestsSuccess;
  }
  Future <bool> getHasTag() async
  {
    var results=await apiService.apiRequestGetHasTag();
    if(results[0]!='')
    {
      hashTagsData=results[0];
      hashTagSuccess=true;
    }
    else
    {hashTagError=results[1];
    hashTagSuccess=false;
    }
    return hashTagSuccess;
  }


  Future<bool> GetBusinessProfileDetils() async {

    SharedPreferences preferences=await SharedPreferences.getInstance();

    String profileId=preferences.getString(Globals.profileId);
    var result = await apiService.apiRequestBusinessAccount(profileId);
    if (result[0] != '') {
      specificProfileDetails = result[0];
      getSocialSuccess = true;
    } else {
      specificProfileDetails = result[1];
      getSocialSuccess = false;
    }
    return getSocialSuccess;
  }
}
