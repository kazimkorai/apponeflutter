import 'dart:io';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:app_one/utils/locations/get_locations.dart';
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  PickedFile imageFile;
  SharedPreferences prefs;
  String abc;
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
    LogoutHasSocialAccount();

  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) => loginView(context, model),
    );
  }

  Scaffold loginView(BuildContext context, LoginViewModel model) {
    return Scaffold(
        backgroundColor: MyColors.appBlue,
        body: BaseScrollView().baseView(context, [
          //Round Logo
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Container(
              height: 150,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.colorLogoOrange,
              ),
              child: Text(
                'LOGO',
                style: CTheme.textRegular25White(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child: plainTextFieldEmail(
                Localization.stLocalized('email'), emailTC,
                obscureText: false, showHideIcon: false),
          ),

          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextField(
                Localization.stLocalized('password'), passwordTC,
                obscureText: true, showHideIcon: true),
          ),

          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child: roundedSquareButton(Localization.stLocalized('login'),
                () async {
              /*    CTheme.showAppAlertOneButton(
                  context: context,
                  title: 'Account Registered',
                  bodyText: "Welcome to App One",
                  handler2: (action) => {
                    Navigator.pushReplacementNamed(context, '/create_business_profile')
                  });*/

              if (validate()) {
                CTheme.showCircularProgressDialog(context);
                await model.loginUser({
                  "email": emailTC.text.trim(),
                  "password": passwordTC.text.trimRight(),
                  "device_key": "sdadadsdadasdasdadad",
                  "user_type": "user"
                });
                if (model.loginSuccess) {
                  addValueToSharedPreference(model);
                  print("Successful");
                  print(model.loginData.data.name);
                  loginFireBase(model, context);
                } else {
                  Navigator.pop(context);
                  CTheme.showAppAlertOneButton("Okay",
                      context: context,
                      title: 'Error',
                      bodyText: "Incorrect email or password",
                      handler2: (action) => {
                            Navigator.pop(context),
                          });
                  print("Error");
                }
              }
            }),
          ),

          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: roundedSquareButton(
                Localization.stLocalized('createAccount'), () async {
              Navigator.pushNamed(context, '/create_account');
              // model.createUserWithEP()
            }),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, '/forgot_password');
              },
              child: Text(
                Localization.stLocalized('forgotPassword'),
                style: CTheme.textRegularBoldItalic14White(),
              ),
            ),
          )
        ]));
  }

  void setHasSocialAccount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isHasSocialAccount", true);
  }

  void LogoutHasSocialAccount() async {
    await GetUserLocations().getLocation();

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isHasSocialAccount", false);
  }

  Future loginFireBase(LoginViewModel model, BuildContext context) async {
    String loginResult =
    await model.login(emailTC.text.trim(), passwordTC.text.trimRight());
    if (loginResult == 'Successful') {

      var tokenResult = await model.updateUserFcmToken();
      if (tokenResult) {
        String profileStatus;
        try {
          profileStatus = prefs.getString(Globals.profileStatus).toString();
          print(profileStatus);
        } catch (Exception) {}
        if (profileStatus.toString() == 'null') {
          Navigator.pop(context);
          CTheme.showAppAlertOneButton("Okay",
              context: context,
              title: 'Create Social Account',
              bodyText: "Please Create Social Account First",
              handler2: (action) => {
                    Navigator.pushReplacementNamed(
                        context, '/create_social_profile')
                  });
        } else {
          setHasSocialAccount();
          Navigator.pop(context);
          Globals.currentRoute = '/profile_home';
          Navigator.pushNamedAndRemoveUntil(
              context, '/profile_home', (route) => false);
        }
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        CTheme.showAppAlertOneButton("Okay",
            context: context,
            title: 'Error',
            bodyText: "Error Logging In",
            handler2: (action) => {
                  Navigator.pop(context),
                });
      }
    } else {
      Navigator.pop(context);
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Error',
          bodyText: loginResult,
          handler2: (action) => {
                Navigator.pop(context),
              });
    }
  }

  bool validate() {
    prefrence();
    var isValidated = false;
    if (emailTC.text.trim().length == 0) {
      File file = File("assets/images/list_image/image_list_model.png");
      print(file.path.toString());
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Field Empty',
        bodyText: 'Please enter email',
      );
    } else if (!EmailValidator.validate(emailTC.text.trim())) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Email Error',
        bodyText: 'Please enter valid email',
      );
    } else if (passwordTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Field Empty',
          bodyText: 'Please enter password');
    } else {
      isValidated = true;
    }
    return isValidated;
  }

  Widget roundedSquareButton(String btnText, Function onTap) {
    return Row(
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
    );
  }

  TextField plainTextField(String hintText, TextEditingController controller,
      {bool obscureText, bool showHideIcon}) {
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
        suffixIcon: showHideIcon
            ? IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: MyColors.colorLogoOrange,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : Container(width: 1),
      ),
      obscureText: obscureText ? _passwordVisible : false,
    );
  }

  TextField plainTextFieldEmail(
      String hintText, TextEditingController controller,
      {bool obscureText, bool showHideIcon}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
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
        suffixIcon: showHideIcon
            ? IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: MyColors.colorLogoOrange,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : Container(width: 1),
      ),
      obscureText: obscureText ? _passwordVisible : false,
    );
  }

  Future addValueToSharedPreference(LoginViewModel model) async {
    await SharedPreferences.getInstance().then((value) => {
          value.setString(Globals.userAuthToken, model.loginData.data.token),
          value.setString(Globals.userName, model.loginData.data.name),
          value.setString(
              Globals.profileId, model.loginData.data.userProfileId.toString()),
      value.setString(Globals.socialProfileId, model.loginData.data.userProfileId.toString()),
    print("profileId==> "+model.loginData.data.userProfileId.toString()),
          value.setString(
              Globals.userId, model.loginData.data.userId.toString()),
          value.setString(Globals.profileType,
              model.loginData.data.profileStatus.toString()),
          value.setString(Globals.profileStatus,
              model.loginData.data.profileStatus.toString()),
          value.setString(
              Globals.emailId, model.loginData.data.email.toString()),
          value.setString(
              Globals.dateOfBirth, model.loginData.data.dateOfBirth.toString()),
          value.setString(
              Globals.cityId, model.loginData.data.userCityId.toString()),
          value.setString(Globals.cityName, model.loginData.data.userCityName),
          value.setString(
              Globals.countryId, model.loginData.data.userCountryId.toString()),
          value.setString(
              Globals.countryName, model.loginData.data.userCountryName),
          value.setString(
              Globals.gender, model.loginData.data.gender.toString()),
          Globals.serverToken = model.loginData.data.token.toString(),
          value.setString(Globals.defualtRoundColor,"defualt"),
      value.setString(Globals.urlImageSocial,  model.loginData.data.profileImage.toString()),
      print("profileImage===>"+value.getString(Globals.urlImageSocial)),

        });
  }

  void prefrence() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(Globals.afterSelectedAccountValue, "");
    prefs.setString(Globals.userPostId, "");
  }
}
