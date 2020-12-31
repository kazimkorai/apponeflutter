import 'dart:ui';

import 'package:app_one/utils/dialog/AlertBox.dart';
import 'package:flutter/material.dart';

import 'MyColors.dart';

class CTheme {
  static getAppLogoImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/logo/logo.png",
        height: MediaQuery.of(context).size.height - 30,
        width: MediaQuery.of(context).size.width - 30,
      ),
    );
  }

  static defaultFont() => "Avenir-Heavy";

  static textRegular7White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 7,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular8Grey() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 8,
      color: MyColors.smallTextGreyColor,
      fontWeight: FontWeight.w400);

  static textRegular8Green() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 8,
      color: MyColors.adminBtnGreen,
      fontWeight: FontWeight.w400);

  static text8WhiteBold() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 8,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.bold);

  static textRegular11White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 11,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular11LogoOrange() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 11,
      color: MyColors.colorLogoOrange,
      fontWeight: FontWeight.w400);

  static textRegular11WhiteBold() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 11,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.bold);

  static textRegular11WhiteItalic() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 11,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic);

  static textRegular11Grey() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 11,
      color: MyColors.smallTextGreyColor,
      fontWeight: FontWeight.w400);

  static textRegular12WhiteBold() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 12,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.bold);

  static textRegular12RedBold() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 12,
      color: MyColors.colorRedPlay,
      fontWeight: FontWeight.bold);

  static textRegular12Grey() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 12,
      color: MyColors.smallTextGreyColor,
      fontWeight: FontWeight.w400);

  static textRegular13White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 13,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular13Black() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 13,
      color: MyColors.colorFullBlack,
      fontWeight: FontWeight.w400);

  static textRegularItalic14White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 14,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic);

  static textRegularBoldItalic14White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 14,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);

  static textRegular14LogoOrange() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 14,
      color: MyColors.colorLogoOrange,
      fontWeight: FontWeight.w400);

  static textRegular14White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 14,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular14Blue() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 14,
      color: MyColors.agreementColor,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w400);

  static textRegular15White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 15,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular16White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 16,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular16Black() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 16,
      color: MyColors.appBlue,
      fontWeight: FontWeight.w400);

  static textRegular16LogoOrange() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 16,
      color: MyColors.colorLogoOrange,
      fontWeight: FontWeight.w400);

  static textRegular18White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 18,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegularBold14White() => TextStyle(
        fontFamily: CTheme.defaultFont(),
        fontSize: 14,
        color: MyColors.colorWhite,
        fontWeight: FontWeight.bold,
      );

  static textRegular21White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 21,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular25LogoOrange() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 25,
      color: MyColors.profileTextColor,
      fontWeight: FontWeight.w400);

  static textRegular25White() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 25,
      color: MyColors.colorWhite,
      fontWeight: FontWeight.w400);

  static textRegular25blue() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 25,
      color: MyColors.categoryTextColor,
      fontWeight: FontWeight.w400);

  static textRegular26LogoOrange() => TextStyle(
      fontFamily: CTheme.defaultFont(),
      fontSize: 26,
      color: MyColors.colorLogoOrange,
      fontWeight: FontWeight.w400);

  static void showAppAlertTwoButton(
      {BuildContext context,
      String title,
      String bodyText,
      String btn1Title,
      String btn2Title,
      EWPAlertHandler handler1,
      EWPAlertHandler handler2,
      bool barrierDismissible = true,
      bool forNotification = false}) {
    showDialog(
        context: context,
        builder: (context) => CloseAlertDialog(
              title: title,
              actions: [
                EWPAlertAction(title: btn1Title, handler: handler1),
                EWPAlertAction(title: btn2Title, handler: handler2)
              ],
              description: bodyText,
              error: forNotification,
            ),
        barrierDismissible: barrierDismissible);
  }

  static void showAppAlertOneButton(String btnTitle,
      {BuildContext context,
      String title,
      String bodyText,
      EWPAlertHandler handler1,
      EWPAlertHandler handler2,
      bool barrierDismissible = true,
      bool forNotification = false}) {
    showDialog(
        context: context,
        builder: (context) => CloseAlertDialog(
              title: title,
              actions: [EWPAlertAction(title: btnTitle, handler: handler2)],
              description: bodyText,
              error: forNotification,
            ),
        barrierDismissible: barrierDismissible);
  }

  ///Delayed so that dialog can be called after build method.
  static showCircularProgressDialog(BuildContext context) {
    return Future.delayed(
        Duration(milliseconds: 100),
        () => {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            MyColors.colorLogoOrange),
                      ),
                    );
                  })
            });
  }

  static showCircularProgressIndicator({double strokeWidget}) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        MyColors.colorLogoOrange,
      ),
      strokeWidth: strokeWidget,
    );
  }
}
