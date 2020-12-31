import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class NotificationController {

  List<String> listOfNewMessages=[];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static NotificationController get instance => NotificationController();


  Future setNotificationWhenAppLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try{
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
          sound: true,
          badge: true,
          alert: true
        ));
      }

      _firebaseMessaging.configure(

        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          listOfNewMessages.add(message['notification']['body']);
          String msg = 'notibody';
          String name = 'AppOne';
          if (Platform.isIOS) {
            msg = message['aps']['alert']['body'];
            name = message['aps']['alert']['title'];
          }else {
            msg = message['notification']['body'];
            name = message['notification']['title'];
          }


          if(Platform.isIOS) {
            if(message['chatroomid'] != pref.get(Globals.currentChatRoomId)) {
              sendLocalNotification(name,msg,message["chatroomid"],message);
            }
          }
          else {
            if(message['data']['chatroomid'] != pref.get(Globals.currentChatRoomId)) {
              sendLocalNotification(name,msg,message['data']["chatroomid"],message);
            }
          }
        },

        onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,

        onLaunch: (Map<String, dynamic> message) async {
          await MyApp.navigatorKey.currentState.pushReplacementNamed('/one_to_one_chatbox',
              arguments: message['data']['chatroomid']);
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          await MyApp.navigatorKey.currentState.pushReplacementNamed('/one_to_one_chatbox',
          arguments: message['data']['chatroomid']);
          print('onResume: $message');
        },
      );

    }catch(e) {
      print(e.message);
    }
  }

  Future initLocalNotification() async{
    if (Platform.isIOS) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
      AndroidInitializationSettings('app_one');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }else {// set Android Local notification.
      var initializationSettingsAndroid = AndroidInitializationSettings('app_one');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }

  Future _onDidReceiveLocalNotification(int id, String title, String body, String payload)
  async { }

  Future _selectNotification(String payload) async {
    listOfNewMessages.clear();
    await MyApp.navigatorKey.currentState.pushNamed('/one_to_one_chatbox',
        arguments: payload);

  }

  sendLocalNotification(name,msg,groupKey,payload) async{

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "app_one", "AppOne", "Message Notification",
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker',
    color: MyColors.colorDarkBlack,
      icon: "app_one",
      groupKey:groupKey,

    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    );
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, name, msg, platformChannelSpecifics,
        payload: payload["data"]['chatroomid']);

  }

  // Send a notification message
  Future<void> sendNotificationMessageToPeerUser(unReadMSGCount,messageType,
      textFromTextField,senderName,chatID,peerUserToken) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Globals.firebaseCloudServerToken}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': messageType == 'Text' ? '$textFromTextField' : '(Photo)',
            'title': '$senderName',
            'badge':'$unReadMSGCount',//'$unReadMSGCount'
            "sound" : "default",
            "collapseKey": chatID,

          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': 'app_one',
            'status': 'done',
            'chatroomid': chatID,

          },
          'to': peerUserToken,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
  }

}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async{

    print(message);
  if (message.containsKey('data')) {
    print('myBackgroundMessageHandler data');
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    print('myBackgroundMessageHandler notification');
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}
