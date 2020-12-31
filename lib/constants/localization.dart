import 'dart:ui';

import 'package:flutter/material.dart';

class Localization with ChangeNotifier {
  String localized(String key) {
    ///remove "" to check missing values at runtime
    return stLocalized(key);
  }

  static String stLocalized(String key) {
    return _localizedValues["en"][key];
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {

      //Login Screen
      "logoToBePlaced": "LOGO To Be Placed",
      "forgotPassword": 'Forgot Password',
      'login':'LOGIN',
      "createAccount":'CREATE ACCOUNT',

      "logo":'LOGO',
      "email":'EMAIL',
      "emailAddress":'Email Address',
      "done":'DONE',
      'password':'PASSWORD',
      'passwordConfirm':'Confirm Password',
      //Create Account
      'firstName':'First Name',
      'lastName':'Last Name',
      'gender':'Gender',
      'dateOfBirth':'Date Of Birth',
      'country':'Country',
      'city':'City',
      'createPassword':'Password',
      'confirmPassword':'Confirm Password',
      'iAccept':'I Accept The ',
      'termAndCondition':'Term & Conditions',
      ////Forgot Password

      'recoveryCode':'Recovery code',
       ///Edit Account
      'editAccount':'UPDATE ACCOUNT',
      //Select Profile Type Screen
      'theDoorIs': "The door is opening! how exciting oh, it's you, meh pee in"
          " the shoe run in circles going to catch the red dot today going to"
          " catch the red dot today yet spit up on light gray carpet instead "
          "of adjacent linoleum. Kick up litter.",
      'socialProfile':'Social Profile',
      'createSocialProfile':'CREATE SOCIAL PROFILE',
      'updateSocialProfile':'UPDATE SOCIAL PROFILE',
      'createGroup':'CREATE GROUP',
      'businessProfile':'Business Profile',
      'createBusinessProfile':'CREATE BUSINESS PROFILE',
      'updateBusinessProfile':'UPDATE BUSINESS PROFILE',
      //Create Social Profile
      'profileImage':'Profile Image',
      'groupImage':'Group Image',
      'uploadImage':'UPLOAD IMAGE',
      'profileName':'Profile Name',
      'aboutMe':'About Me',
      'profileType':'Profile Type',
      'selectInterests':'Select Your Interests',
      //Create Business Profile
      'businessName':'Business Name',
      'emailUsed':'Email Used For Business',
      'businessWebsite':'Business Website',
      ///settings
      'notificationSrttings':'Notification settings',
      //About Us
      'appName':'App One',
      'descriptionOfApp':'Description of this app and the idea around it'
          ' will go here, this it to tellusers what you are all about.',
      'socialTutorial':'Social Tutorials',
      //Upload Image
      'title':'Title',
      'description':'Description',
      'selectCategories':'Select Categories',
      'selectTopics':'Select Topics',
      'createNewTopic':'Create New Topic',
      'hashTags':'Hashtags',
      'upload':'Upload',
      'image':'Image',
      'uploadVideo':'UPLOAD VIDEO',
      'video':'Video',
      //Confirm Post
      'hashTagText':'#relax, #travel',
      'coventryIsACity':'Coventry is a city with a thousand years of history '
          'that has plenty to offer the visiting tourist. Located in the heart '
          'of Warwickshire, which is well-known as Shakespeare’s county.'
          'of Warwickshire, which is well-known as Shakespeare’s county.'
          'of Warwickshire, which is well-known as Shakespeare’s county.of'
          ' Warwickshire, which is well-known as Shakespeare’s county.'
          'of Warwickshire, which is well-known as Shakespeare’s county.of'
          ' Warwickshire, which is well-known as Shakespeare’s county.',
      //Social Profile
      'antonio':'Antonia Berger',
      'fashionModel':'Fashion model & photographer',
      'antoniaCom':'antonia.com',

    },
  };

  static TextDirection textDirectionLtr() {
    return TextDirection.rtl;
  }

  static TextDirection textDirectionRtl() {
    return TextDirection.rtl;
  }

  static TextAlign textAlignLeft() {
    return isEnglish() ? TextAlign.left : TextAlign.right;
  }

  static TextAlign textAlignRight() {
    return !isEnglish() ? TextAlign.left : TextAlign.right;
  }

  static Alignment alignmentTopLeft() {
    return !isEnglish() ? Alignment.topRight : Alignment.topLeft;
  }

  static Alignment alignmentTopRight() {
    return isEnglish() ? Alignment.topRight : Alignment.topLeft;
  }

  static FractionalOffset fractionalOffsetTopRight() {
    return isEnglish() ? FractionalOffset.topRight : FractionalOffset.topLeft;
  }

  static String defaultAlertTitle() {
    return stLocalized("alert_title");
  }

  static String defaultAlertButtonTitle() {
    return stLocalized("default_alert_btn_title");
  }

  static bool isEnglish() {
    return true;
  }
}
