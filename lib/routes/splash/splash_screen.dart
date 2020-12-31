import 'dart:async';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/locator/locator.dart';
import 'package:app_one/services/firebase/notificationController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;
  @override
  void initState() {
    initializeFireBase();
    printChatRoomId();
    removeCurrentChatRoomId();
    setupLocator();
    NotificationController.instance.setNotificationWhenAppLaunch();
    NotificationController.instance.initLocalNotification();
    super.initState();

    Timer(
        Duration(seconds: 5),

            () => changeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBlue,
      body:Center(
        child: CTheme.getAppLogoImage(context),
      ),
    );
  }

  void changeScreen()async{

    try{
      SharedPreferences pref=await   SharedPreferences.getInstance();
      bool isHasSocialAccount = pref.getBool("isHasSocialAccount");

      if(isHasSocialAccount)
      {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/profile_home', (Route<dynamic> route) => false);
      }
      else{
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    }
    catch(Exception )
    {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }


    /*   if(FirebaseAuth.instance.currentUser!=null)
      {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/profile_home', (Route<dynamic> route) => false);
      }
    else{
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
*/
  }
  void prefrence() async
  {
    prefs = await SharedPreferences.getInstance();
  }
  void initializeFireBase() {
    Firebase.initializeApp();
  }

  void printChatRoomId() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("The Chatroom Id is: ${pref.get(Globals.currentChatRoomId)}");
  }
  void removeCurrentChatRoomId()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Globals.currentChatRoomId, 'None');
    print("From Remove OneToOne ChatRoomId: "
        "${ prefs.getString(Globals.currentChatRoomId)}");
  }
}