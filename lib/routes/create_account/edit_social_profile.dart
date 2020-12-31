import 'dart:io';
import 'dart:convert';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/interests.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:app_one/utils/locations/get_locations.dart';
import 'package:app_one/viewmodel/create_user_social_account.dart';
import 'package:app_one/viewmodel/create_user_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSocialProfile extends StatefulWidget {
  final Map<String, dynamic> userRegistrationData;

  EditSocialProfile({this.userRegistrationData});

  @override
  _CreateSocialProfileScreenState createState() =>
      _CreateSocialProfileScreenState();
}

class _CreateSocialProfileScreenState extends State<EditSocialProfile> {
  var _valueProfileType = "public";
  List<Map<String, String>> selectedInterestsList = new List();
  List previousSelectedCat = new List();
  PickedFile imageFile;
  bool isImageSelect = false;
  TextEditingController profileNameTC = TextEditingController();
  TextEditingController aboutTC = TextEditingController();
  Map<String, dynamic> userSociaData;
  String valueInterest;
  List<dynamic> listIntrests = List();
  List<Map<String, String>> listMap = new List();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String prefUserId = "";
  String prefCountry_id = "";
  String prefCity_id = "";
  String prefEmail = "";
  String _lineAddress = "";
  SharedPreferences prefs;
  String imageSocial="";

  @override
  void initState() {
    super.initState();
    print("EditSocial");
    getIntresets();

  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateUserViewModel>(
      builder: (context, model, child) =>
          createSocialAccountView(context, model),
    );
  }

  void _onFormSaved() {
    final FormState form = _formKey.currentState;
    form.save();
  }

  getIntresets() async {
    prefs = await SharedPreferences.getInstance();
    CreateUserViewModel model = new CreateUserViewModel();
    CTheme.showCircularProgressDialog(context);
    await model.GetBusinessProfileDetils();
    if (model.getSocialSuccess) {

       setState(() {
        profileNameTC.text = model.specificProfileDetails.data.profileName;
        aboutTC.text =
            model.specificProfileDetails.data.profileAbout.toString();
        _valueProfileType =
            model.specificProfileDetails.data.profileStatus.toString();
        imageSocial=model.specificProfileDetails.data.profileImage.toString();
        print("_valueProfileType==> " +
            model.specificProfileDetails.data.profileStatus);
        print("profileWebsite==> " +
            model.specificProfileDetails.data.profileWebsite);
        previousSelectedCat = new List();
        for (int index = 0;
        index < model.specificProfileDetails.data.category.length;
        index++) {
          previousSelectedCat.add(model
              .specificProfileDetails.data.category[index].categoryId
              .toString());

          print("selectedDataToMap===> " + previousSelectedCat.toString());
        }
      });
    }

    GetUserLocations getUserLocations = new GetUserLocations();
    getUserLocations.getLocation();
    setState(() {
      _lineAddress = prefs.getString(Globals.addressLine);
    });

    await model.getIntrests();

    if (model.intrestsSuccess) {
      setState(() {
        print(model.intrestsData.data.category.length);
        listIntrests = model.intrestsData.data.category;
        for (int index = 0;
            index < model.intrestsData.data.category.length;
            index++) {
          print(model.intrestsData.data.category[index].name);
          Map<String, String> dataMap = {
            'name': model.intrestsData.data.category[index].name,
            'id': model.intrestsData.data.category[index].id.toString(),
          };
          listMap.add(dataMap);
        }
        print(listIntrests.length);
      });
      Navigator.pop(context);
      return listIntrests;
    } else {
      Navigator.pop(context);
      print("Error");
    }
  }

  Scaffold createSocialAccountView(
      BuildContext context, CreateUserViewModel model) {
    return Scaffold(
        backgroundColor: MyColors.colorDarkBlack,
        body: BaseScrollView().baseView(context, [
          Padding(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15, bottom: 30),
            child: profileItem(() async {
              imageFile = await PickImageController.instance.picker
                  .getImage(source: ImageSource.gallery, imageQuality: 30);
              if (imageFile != null) {
                print("${File(imageFile.path).lengthSync() * 0.001} Kb");
                setState(() {
                  isImageSelect = true;
                  imageFile;
                });
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
            child: plainTextField(
                Localization.stLocalized('profileName'), profileNameTC),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              Localization.stLocalized('aboutMe'),
              style: CTheme.textRegular21White(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50, right: 50),
            child: whiteMultilineTextField(aboutTC),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              Localization.stLocalized('profileType'),
              style: CTheme.textRegular21White(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Stack(
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: MyColors.colorLogoOrange,
                        ),
                        child: RadioListTile(
                          activeColor: MyColors.colorLogoOrange,
                          groupValue: _valueProfileType,
                          controlAffinity: ListTileControlAffinity.platform,
                          value: "public",
                          onChanged: (value) => {
                            setState(() {
                              _valueProfileType = value;
                            })
                          },
                          // contentPadding: EdgeInsets.only(left: 5),

                          title: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Public",
                              style: CTheme.textRegular16White(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: MyColors.colorLogoOrange),
                        child: RadioListTile(
                          activeColor: MyColors.colorLogoOrange,
                          groupValue: _valueProfileType,
                          value: "private",
                          onChanged: (value) => {
                            setState(() {
                              _valueProfileType = value;
                            })
                          },
                          title: Text(
                            "Private",
                            style: CTheme.textRegular16White(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              Localization.stLocalized('selectInterests'),
              style: CTheme.textRegular21White(),
            ),
          ),
          listIntrests.length != 0
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 40, right: 40, bottom: 30),
                  child: Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new MultiSelect(
                            autovalidate: true,
                            initialValue: previousSelectedCat,
                            dataSource: listMap,
                            textField: 'name',
                            valueField: 'id',
                            titleText: 'Select Your Interests ',
                            hintText:
                                "Please select interests (Min: 2 and Max: 8)",
                            maxLength: 8,

                            // optional
                            validator: (dynamic value) {
                              if (value == null) {
                                return 'Please select at least 2 interests';
                              }
                              return null;
                            },
                            filterable: true,
                            required: true,
                            onSaved: (value) {
                              if (value != null) {
                                print('The value is $value');
                                print(value.length);
                                selectedInterestsList = new List();
                                for (int index = 0;
                                    index < value.length;
                                    index++) {
                                  Map<String, String> selectedDataToMap = {
                                    'id': value[index]
                                  };
                                  selectedInterestsList.add(selectedDataToMap);
                                }
                                print(selectedInterestsList.length);
                              }
                            },
                            selectIcon: Icons.add,
                            saveButtonColor: MyColors.colorLogoOrange,
                            checkBoxColor: MyColors.colorLogoOrange,
                            cancelButtonColor: MyColors.colorLogoOrange,
                            cancelButtonTextColor: MyColors.colorWhite,
                            //  searchBoxColor: MyColors.colorLogoOrange,
                            selectIconColor: MyColors.colorWhite,
                            clearButtonColor: Color(0xFF242A37),
                            maxLengthText: "",
                            maxLengthIndicatorColor: MyColors.colorWhite,
                            clearButtonTextColor: MyColors.colorWhite,
                            titleTextColor: MyColors.colorLogoOrange,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        /*       RaisedButton(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    onPressed: () {
                      _onFormSaved();
                    },
                  )*/
                      ],
                    ),
                  ),
                )
              : Text("loading"),
          Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 50, right: 50, bottom: 30),
            child: roundedSquareButton(
                Localization.stLocalized('updateSocialProfile'), 50, () async {
              if (validateFields()) {
                userSociaData = {
                  "user_id": prefUserId.toString(),
                  "country_id": prefCountry_id.toString(),
                  "city_id": prefCity_id.toString(),
                  "profile_name": profileNameTC.text,
                  "profile_email": prefEmail.toString(),
                  "profile_phone": "",
                  "profile_address": _lineAddress.toString(),
                  "profile_website": "",
                  "profile_about": aboutTC.text.toString(),
                  "profile_type": "Social",
                  "profile_status": _valueProfileType,
                  "about": "test abus us",
                  "interest": selectedInterestsList
                };

                if (imageFile != null) {
                  userSociaData['profile_image'] =
                      await convertImageToBase64(imageFile);
                }

                String createSocialAccountStatus =
                    await createSocialAccountFirebase(
                        email: prefEmail.toString());
                if (createSocialAccountStatus == "Successful") {
                  registerSocialAccount(userSociaData);
                } else {
                  print('error' + createSocialAccountStatus);
                }

                /*  createUserInFirebase(userRegistrationData['email'],
                    userRegistrationData['password'], model);*/
              }
            }),
          )
        ]));
  }

  Widget profileItem(Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            color: MyColors.appBlue,
            elevation: 8,
            shadowColor: MyColors.appBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: imageFile == null
                      ? Container(
                    height: 140,
                    width: 140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.colorWhite,
                        border: Border.all(
                            color: MyColors.colorLogoOrange, width: 6)),
                    child:  ClipOval(
                      child: CachedNetworkImage(
                        height: 120,
                        fit:BoxFit.cover ,
                        width: 120,
                        imageUrl: imageSocial,
                      ),
                    ),
                  )
                      : Container(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75)),
                              child: Image.file(
                                File(imageFile.path),
                                fit: BoxFit.cover,
                              ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 85, right: 85, bottom: 20),
                  child: roundedSquareButton(
                      Localization.stLocalized('uploadImage'), 30, onTap),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container whiteMultilineTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.colorWhite, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: controller,
          maxLines: 4,
          style: CTheme.textRegular16Black(),
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            fillColor: MyColors.colorWhite,
          ),
        ),
      ),
    );
  }

  Widget profileTypeBox(
      String headingText, String subText, String btnText, Function onTap) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.appBlue,
        border: Border(
          left: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          right: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          bottom: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          top: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              headingText,
              style: CTheme.textRegular26LogoOrange(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 0.5,
              width: 200,
              color: MyColors.colorLogoOrange,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 75, right: 75),
            child: Text(
              subText,
              style: CTheme.textRegular11WhiteItalic(),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 40, right: 40, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: (BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10),
                        )),
                        child: Text(
                          btnText,
                          style: CTheme.textRegularBold14White(),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget roundedSquareButton(String btnText, double height, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: height,
              decoration: (BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
              )),
              child: Text(
                btnText,
                style: CTheme.textRegularBold14White(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextField plainTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: CTheme.textRegular18White(),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        hintText: hintText,
        hintStyle: CTheme.textRegular18White(),
      ),
    );
  }

  bool validateFields() {
    _onFormSaved();
    var isValidated = false;
    if (imageFile == null) {
/*      CTheme.showAppAlertOneButton(context: context,title: 'Image Error',
          bodyText: 'Please select profile image to proceed',btnTitle: 'Okay');*/
    }
    if (profileNameTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Field Empty',
        bodyText: 'Please specify profile name',
      );
    } else if (aboutTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Field Empty',
        bodyText: 'Please specify About me',
      );
    } else if (_valueProfileType == null) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Select Profile Type',
        bodyText: 'Please select type of profile',
      );
    } else if (selectedInterestsList.length < 2) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Error',
        bodyText: 'Please select at least 2 interests',
      );
    } else {
      isValidated = true;
    }
    return isValidated;
  }

  Future<String> createSocialAccountFirebase(
      {String email, File userImageFile}) async {
    var signUpSuccess;
    try {
      {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final User user = auth.currentUser;
        final uid = user.uid;

        userImageFile != null
            ? await FirebaseStorage()
                .ref()
                .child('userSocialAccount/${uid}/')
                .putFile(userImageFile)
                .onComplete
                .then((storageValue) async {
                await FirebaseFirestore.instance
                    .collection('userSocialAccount')
                    .doc(uid)
                    .set({
                      'userId': uid,
                      'fcmToken': await getToken(),
                      'createdAt': FieldValue.serverTimestamp(),
                      'name': email.substring(0, email.indexOf('@')),
                      'email': email,
                      "country_id": prefCountry_id,
                      "city_id": prefCity_id,
                      "profile_name": profileNameTC.text.toString(),
                      "profile_email": email,
                      "profile_phone": "",
                      "profile_address": _lineAddress.toString(),
                      "profile_website": "",
                      "profile_about": aboutTC.text.toString(),
                      "profile_type": "Social",
                      "profile_status": _valueProfileType,
                      "about": aboutTC.text.toString(),
                      'userImageUrl': userImageFile != null
                          ? await storageValue.ref.getDownloadURL()
                          : "",
                    })
                    .whenComplete(() => {signUpSuccess = 'Successful'})
                    .catchError((error) => {
                          error = error.toString().substring(
                              error.toString().indexOf(']') + 1,
                              error.toString().length - 1),
                          signUpSuccess = error
                        });
              }).catchError((error) => {
                      error = error.toString().substring(
                          error.toString().indexOf(']') + 1,
                          error.toString().length - 1),
                      signUpSuccess = error
                    })
            : await FirebaseFirestore.instance
                .collection('userSocialAccount')
                .doc(uid)
                .set({
                  'userId': uid,
                  'fcmToken': await getToken(),
                  'createdAt': FieldValue.serverTimestamp(),
                  'name': email.substring(0, email.indexOf('@')),
                  'email': email,
                  "country_id": prefCity_id,
                  "city_id": prefCountry_id,
                  "profile_name": profileNameTC.text.toString(),
                  "profile_email": email,
                  "profile_phone": "",
                  "profile_address": "",
                  "profile_website": "",
                  "profile_about": aboutTC.text.toString(),
                  "profile_type": "Social",
                  "profile_status": _valueProfileType,
                  "about": aboutTC.text.toString(),
                })
                .whenComplete(() => {signUpSuccess = 'Successful'})
                .catchError((error) => {
                      error = error.toString().substring(
                          error.toString().indexOf(']') + 1,
                          error.toString().length - 1),
                      signUpSuccess = error
                    });
      }
    } catch (error) {
      print(error);
    }
    return signUpSuccess;
  }

  Future<String> getToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String tokenResult;
    await _firebaseMessaging
        .getToken()
        .then((value) => {
              print('Token For User Is: ' + value),
              tokenResult = value,
            })
        .catchError((error) => {
              print('Get Token Error is : ${error.toString()}'),
              tokenResult = 'Failed'
            });
    return tokenResult;
  }

  createUserInFirebase(email, password, CreateUserViewModel model) async {
    String signUpResult;

    ///Kazim todo: Kazim this method is not be used it is old;
    ///
    if (isImageSelect) {
      signUpResult = await model.createUser(
          email: email,
          password: password,
          userImageFile: File(imageFile.path));
    } else {
      signUpResult = await model.createUser(
        email: email,
        password: password,
      );
    }
    if (signUpResult == 'Successful') {
      print(signUpResult);
      //// Todo: kazim here Your ServerApiCall
      registerUserInApi(model);
    } else {
      print(signUpResult);
      Navigator.pop(context);
      CTheme.showAppAlertOneButton("Okay",
          context: context, title: 'Error Signing Up', bodyText: signUpResult);
    }
  }

  registerSocialAccount(parameterMap) async {
    CTheme.showCircularProgressDialog(context);
    CreateSocialAccountViewModel model = new CreateSocialAccountViewModel();
    await model.createSocialAccount(parameterMap);
    if (model.createSocialSuccess) {
      Navigator.pop(context);
      print("Successful");
      prefs.setString(Globals.socialProfileName, profileNameTC.text.toString());
      //  prefs.setString(Globals.socialProfileImage, imageFile.path.toString());
      print(model.createSocialData.data.userId);
      Globals.currentRoute = '/profile_home';
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Social Account Registered',
          bodyText: "Welcome to App One",
          handler2: (action) => {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/profile_home', (route) => false)
              });

      /*
      CTheme.showAppAlertTwoButton(
          context: context,
          title: "Social Account",
          btn1Title: 'Create',
          btn2Title: 'Continue',
          bodyText:
          "Social Account created successfully do you want to create Business Account?",
          handler1: (handler) =>
          {Navigator.pushNamed(context, '/create_business_profile')},
          handler2: (handler) =>
          {
            Globals.currentRoute == '/profile_home',
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile_home', (route) => false)
          });*/
    } else {
      Navigator.pop(context);
      print("Error Create Social Profile");
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Error Create Social Profile',
          bodyText: "Social Profile already exist.");
    }
  }

  void setHasSocialAccount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isHasSocialAccount", true);
  }

  registerUserInApi(CreateUserViewModel model) async {
    ///todo: kazim this is old method
    await model.registerUser(userSociaData);
    if (model.registerSuccess) {
      Navigator.pop(context);
      print("Successful");
      setHasSocialAccount();
      print(model.registrationData.data.email);
      await addValueToSharedPreference(model);
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Account Registered',
          bodyText: "Welcome to App One",
          handler2: (action) =>
              {Navigator.pushReplacementNamed(context, '/profile_home')});
    } else {
      deleteUserFromDatabase();
      Navigator.pop(context);
      print("Error Register User Api");
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Error Signing Up',
          bodyText: "The was some error creating profile try later.");
    }
  }

  Future addValueToSharedPreference(CreateUserViewModel model) async {
    await SharedPreferences.getInstance().then((value) => {
          value.setString(
              Globals.userAuthToken, model.registrationData.data.token),
          value.setString(Globals.userName, model.registrationData.data.name),
          value.setString(Globals.profileId,
              model.registrationData.data.userProfileId.toString()),
          value.setString(
              Globals.userId, model.registrationData.data.userId.toString()),
          value.setString(Globals.profileType,
              model.registrationData.data.profileStatus.toString()),
          value.setString(Globals.profileStatus,
              model.registrationData.data.profileStatus.toString()),
          value.setString(Globals.socialProfileId,
              model.registrationData.data.userProfileId.toString()),
          value.setBool("isHasSocialAccount", true)
        });
  }

  void deleteUserFromDatabase() {
    ///Todo
  }

  Future<String> convertImageToBase64(imageFile) async {
    var headerString = 'data:image/png;base64,';
    File image = new File(imageFile.path);
    List<int> imageBytes = await image.readAsBytesSync();
    String base64Image = await base64.encode(imageBytes);
    var encodedImage = "$headerString$base64Image";
    print("Base64 Image Content: $encodedImage");
    return encodedImage;
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: MyColors.colorLogoOrange,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 15,
        color: MyColors.colorWhite,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
