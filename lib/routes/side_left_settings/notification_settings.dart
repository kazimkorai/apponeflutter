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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NotificationSettings extends StatefulWidget {


  NotificationSettings({this.initValueNotification});
  int initValueNotification;
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  String contentTermsAndConds = "";
  String name = "";
  SharedPreferences sharedPreferences;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  int isNotificationOn = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefrence();

    if (widget.initValueNotification == null) {
      setState(() {
        widget.initValueNotification = 0;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AboutSettingsViewModel>(
      onModelReady: (model) async {
        /*       CTheme.showCircularProgressDialog(context);
      await  model.aboutUsSettings();
        print(model.aboutUsSettingsData.data.sideBar[1].content.toString());
        setState(() {
          contentTermsAndConds=model.aboutUsSettingsData.data.sideBar[1].content.toString();
        });
        Navigator.pop(context);*/
      },
      builder: (context, model, child) => notificationView(context, model),
    );
  }

  WillPopScope notificationView(BuildContext context, AboutSettingsViewModel) {
    return WillPopScope(
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
                Localization.stLocalized('notificationSrttings'),
                style: CTheme.textRegular21White(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: ToggleSwitch(
                minWidth: 95.0,
                minHeight: 50.0,
                fontSize: 16.0,
                initialLabelIndex:
                0
                /*sharedPreferences.getInt(Globals.notificationOnKey)*/
                /*!sharedPreferences.containsKey(Globals.notificationOnKey)
                    ? 0
                    : sharedPreferences.getInt(Globals.notificationOnKey)*/,
                activeBgColor: MyColors.colorLogoOrange,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.grey[900],
                labels: ['On', 'Off'],
                onToggle: (index) {
                  isNotificationOn = index;
                  /*sharedPreferences.setInt(
                      Globals.notificationOnKey, isNotificationOn);*/
                  print('switched to: $index');
                },
              ),
            ),
          ])),
    );
  }

  void prefrence() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
