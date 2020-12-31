
import 'dart:async';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<Settings> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int initValueNotification=0;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    print('I am Setting');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Globals.currentRoute = '/profile_home';
        print(Globals.currentRoute);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
          drawer: DrawerMain(context: context,),
          endDrawer: DrawerRight(context: context,),
        bottomNavigationBar: MyBottomNavigationBar(context: context,
        scaffoldKey: scaffoldKey,),
        backgroundColor: MyColors.colorDarkBlack,
        body: BaseScrollView().baseView(context, [


          Padding(
            padding: EdgeInsets.only(top: 60),
            child: dropDownVideoItem('Notification Settings',
                    () async=>{

              Navigator.pushNamed(context, '/notification_settings',arguments:initValueNotification ),

              print("Notification Settings")
                    }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: dropDownVideoItem('Blocked Users',
                    ()=>{}),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: dropDownVideoItem('Terms And Conditions',
                    ()=>{
              print('clicked Terms'),
                      Navigator.pushNamed(context, '/terms_cond')
                    }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: dropDownVideoItem('Privacy Policy',
                    ()=>{

              Navigator.pushNamed(context, "/privacy_policy")

                    }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: dropDownVideoItem('Chat Settings',
                    ()=>{}),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: dropDownVideoItem('Profile Settings',
                    () async=>{
                  print("Profile Settings"),

                ////todo: going to edit social profile account

      Navigator.pushNamed(context, '/edit_account')
                }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: dropDownVideoItem('Unsubscribe',
                    ()=>{}),
          ),

        ])
      ),
    );
  }


  Widget dropDownVideoItem(String text,Function onTap) {
    return
      SizedBox(
        height: 60,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 3,
            color: MyColors.appBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    text,
                    style: CTheme.textRegular25White(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: MyColors.colorWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  }



}