import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/login.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:app_one/viewmodel/verify_recovery_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyRecoverCode extends StatefulWidget {
  @override
  _VerifyRecoverCodeState createState() => _VerifyRecoverCodeState();
}

class _VerifyRecoverCodeState extends State<VerifyRecoverCode> {
  TextEditingController recoveryCodeTC = TextEditingController();
  SharedPreferences pref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPrefrence();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyRecoveryEmailModel>(
      builder: (context, model, child) => verifyRecoveryCode(context, model),
    );
  }

  setPrefrence() async {
    pref = await SharedPreferences.getInstance();
  }

  Scaffold verifyRecoveryCode(
      BuildContext context, VerifyRecoveryEmailModel model) {
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
            child: plainTextField(Localization.stLocalized('recoveryCode')),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child:
                roundedSquareButton(Localization.stLocalized('done'), () async {
              String emailll = pref.get(Globals.forgetEmailTemp);

              print(emailll);
              if (recoveryCodeTC.text.trim().length != 0) {

                CTheme.showCircularProgressDialog(context);
               await  model.verifyRecoveryCode(emailll, recoveryCodeTC.text.toString(),context);

               Navigator.pop(context);
                if (model.verifySuccess) {
                  print(model.verifySuccess);
                  FirebaseAuth.instance.signOut();
                  print(model.verifyCodeModel.data.password);
                  print(model.verifyCodeModel.data.email);
                  String password=model.verifyCodeModel.data.password;
                  String email=model.verifyCodeModel.data.email;
                  print(password);

                  loginFireBase(email,password);

                  CTheme.showAppAlertOneButton(
                    "Continue",
                    context: context,
                    title: "Verified",
                    handler2: (action) => {
                      pref.setString(Globals.passwordTemp, password.toString()),
                      pref.setString(
                          Globals.recoveryCode, recoveryCodeTC.text.toString()),
                      Navigator.pushNamed(context, '/update_password')
                    },

                    bodyText: 'Recovery code  has been verified',
                  );
                }
                else {
                  CTheme.showAppAlertOneButton(
                    "Okay",
                    context: context,
                    title: 'Error',
                    handler2: (action) => {Navigator.pop(context)},
                    bodyText: 'Recovery code not match',
                  );
                }
              } else {

                CTheme.showAppAlertOneButton(
                  "Okay",
                  context: context,
                  title: 'Field Empty',
                  handler2: (action) => {Navigator.pop(context)},
                  bodyText: 'Please enter recovery code',
                );
              }
            }),
          ),
        ]));
  }

  Future loginFireBase( String email,String password) async {

    LoginViewModel model=new LoginViewModel();
 await model.login(email, password);


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
      maxLength: 6,
      controller: recoveryCodeTC,
      keyboardType: TextInputType.number,
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
