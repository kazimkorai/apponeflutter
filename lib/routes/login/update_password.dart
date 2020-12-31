import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:app_one/viewmodel/verify_email_vmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController passwordTC = TextEditingController();
  TextEditingController passwordConfrmd = TextEditingController();
  bool _passwordVisible;
  SharedPreferences pref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = true;
    setPrefrence();
  }

  setPrefrence() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyEmailModel>(
      builder: (context, model, child) => updatePassword(context, model),
    );
  }

  Scaffold updatePassword(BuildContext context, VerifyEmailModel model) {
    return Scaffold(
        backgroundColor: MyColors.appBlue,
        body: BaseScrollView().baseView(context, [
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
                Localization.stLocalized('logo'),
                style: CTheme.textRegular25White(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextFieldPassword(
                Localization.stLocalized('password'), passwordTC,
                obscureText: true, showHideIcon: true),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextFieldPassword(
                Localization.stLocalized('passwordConfirm'), passwordConfrmd,
                obscureText: true, showHideIcon: true),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child:
            roundedSquareButton(Localization.stLocalized('done'), () async {
              if (passwordTC.text
                  .trim()
                  .length > 0) {
                if (passwordConfrmd.text
                    .trim()
                    .length > 0) {
                  if (passwordTC.text.toString() ==
                      passwordConfrmd.text.toString()) {
                    await model.updatePassword(
                        pref.getString(Globals.forgetEmailTemp),
                        pref.getString(Globals.recoveryCode),
                        passwordConfrmd.text);
                    print(pref.getString(Globals.forgetEmailTemp));
                    print(pref.getString(Globals.recoveryCode));
                    print(model.verifySuccess);
                    if (model.verifySuccess) {
                   await   loginFireBase(pref.getString(Globals.forgetEmailTemp),   pref.getString(Globals.passwordTemp),
                   );
                   changePasswordFirebase(passwordConfrmd.text);
                      CTheme.showAppAlertOneButton(
                          "Okay",
                          context: context,
                          title: 'Update',
                          bodyText: "Your password has been updated",

                          handler2: (action) =>
                          {
                            Navigator.pop(context),

                          });
                    }
                  } else {
                    CTheme.showAppAlertOneButton(
                        "Okay",
                        context: context,
                        title: 'Password and Confirmed',
                        bodyText: "Password and confirmed not match",
                        handler2: (action) => {Navigator.pop(context)});
                  }
                } else {
                  CTheme.showAppAlertOneButton(
                      "Okay",
                      context: context,
                      title: 'Password is empty',
                      bodyText: "Please enter password",
                      handler2: (action) => {Navigator.pop(context)});
                }
              } else {
                CTheme.showAppAlertOneButton(
                    "Okay",
                    context: context,
                    title: 'Password is empty',
                    bodyText: "Please enter password",
                    handler2: (action) => {Navigator.pop(context)});
              }
            }),
          ),
        ]));
  }

  TextField plainTextFieldPassword(String hintText,
      TextEditingController controller,
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
  Future loginFireBase( String email,String password) async {

    LoginViewModel model=new LoginViewModel();
    await model.login(email, password);

  }
  void changePasswordFirebase(String password) async{
    //Create an instance of the current user.
      User user = await FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
