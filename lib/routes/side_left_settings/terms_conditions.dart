import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/viewmodel/about_us_settings_viewmodel.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  String contentTermsAndConds="";
  String name="";
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseView<AboutSettingsViewModel>(
      onModelReady: (model) async{
        CTheme.showCircularProgressDialog(context);
      await  model.aboutUsSettings();
        print(model.aboutUsSettingsData.data.sideBar[1].content.toString());
        setState(() {
          contentTermsAndConds=model.aboutUsSettingsData.data.sideBar[1].content.toString();
        });
        Navigator.pop(context);
      } , builder: (context, model, child) => termsAndCondsView(context, model),
    );
  }



  WillPopScope termsAndCondsView(BuildContext context, AboutSettingsViewModel) {
    return  WillPopScope(
      onWillPop: () async {
        Globals.currentRoute = '/settings';
        print(Globals.currentRoute);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          key: scaffoldKey,
          drawer: DrawerMain(
            context: context,
          ),
          endDrawer: DrawerRight(
            context: context,
          ),
          bottomNavigationBar: MyBottomNavigationBar(
            context: context,
            scaffoldKey: scaffoldKey,
          ),
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
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                Localization.stLocalized('appName'),
                style: CTheme.textRegular21White(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: Text(
                contentTermsAndConds,
                /*    Localization.stLocalized('descriptionOfApp'),*/
                style: CTheme.textRegular15White(),
                textAlign: TextAlign.center,
              ),
            ),
          ])),
    );
  }
}
