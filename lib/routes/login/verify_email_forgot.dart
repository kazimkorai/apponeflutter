import 'dart:async';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/forgot_password.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/viewmodel/verify_email_vmodel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmailForgt extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<VerifyEmailForgt> {
  TextEditingController emailTC = TextEditingController();

  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    prefrence();
  }

  prefrence() async
  {
    preferences=await  SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyEmailModel>(
      builder: (context, model, child) => forgotView(context, model),
    );
  }

  Scaffold forgotView(BuildContext context, VerifyEmailModel model) {
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
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child: plainTextField(Localization.stLocalized('emailAddress')),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child: roundedSquareButton(Localization.stLocalized('done'), () async {
              bool isValid = true;
              if (emailTC.text.trim().length == 0) {
                setState(() {
                  isValid = false;
                });
                CTheme.showAppAlertOneButton(
                  "Okay",
                    context: context,
                    title: 'Field Empty',
                    bodyText: 'Please enter email',
     );
              } else if (!EmailValidator.validate(emailTC.text.trim())) {
                setState(() {
                  isValid = false;
                });
                CTheme.showAppAlertOneButton(
                    "Okay",
                    context: context,
                    title: 'Email Error',
                    bodyText: 'Please enter valid email',
);
              }
              if (isValid) {
                CTheme.showCircularProgressDialog(context);
                {
                  await model.verifyEmail(emailTC.text);
                  Navigator.pop(context);
                  if (model.verifySuccess) {
                    return CTheme.showAppAlertOneButton(
                        "Continue",
                        context: context,
                        title: 'Email has been sent',
                        bodyText: "A recovery email has been sent on your email.",

                        handler2: (action) => {
                          Navigator.pop(context),
                          if(emailTC.text.toString().isNotEmpty){
                            preferences.setString(Globals.forgetEmailTemp, emailTC.text.toString())
                            ,Navigator.pushNamed(context, '/verify_recovery_code',),
                          }
                          else{
                            print(emailTC.text.toString())
                          }

                              /// todo:Kazim here going to verify OTP code pageView
                            });
                  } else {
                    print("selected Email is not found");
                    return CTheme.showAppAlertOneButton(
                        "Okay",
                        context: context,
                        title: 'Error',
                        bodyText: "The enter email is not found.",

                        handler2: (action) => {
                              Navigator.pop(context),

                        });
                  }
                }
              }
            }),
          ),
        ]));
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

  TextField plainTextField(String hintText) {
    return TextField(
      controller: emailTC,
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
      ),
    );
  }
}
