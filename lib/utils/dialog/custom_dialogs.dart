import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:flutter/material.dart';

class CustomDialogs{
    static showTopicsDialog({BuildContext context,TextEditingController controller,
      String labelText,String hintText,String btn1Text,String btn2Text,
      Function onDialogAddPressed,
    }) async {
      await showDialog<String>(
        context: context,
        child: AlertDialog(
          backgroundColor: MyColors.appBlue,
          contentPadding: const EdgeInsets.all(10.0),
          content:  Row(
            children: <Widget>[
              Expanded(
                child:  TextField(
                  controller: controller,
                  cursorColor: MyColors.colorLogoOrange,
                  style: CTheme.textRegular16LogoOrange(),
                  // autofocus: true,
                  decoration:  InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: MyColors.colorLogoOrange,
                        )
                      ),
                      enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      errorBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      disabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      labelText: 'Topic Name',
                      labelStyle: CTheme.textRegular16LogoOrange(),
                      hintText: 'eg. History',
                    hintStyle:  CTheme.textRegular14LogoOrange(),
                    contentPadding: EdgeInsets.all(5)
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child:  Text('CANCEL',style:CTheme.textRegular16LogoOrange(),),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child:  Text('ADD',style:CTheme.textRegular16LogoOrange()),
                onPressed: onDialogAddPressed
                )
          ],
        ),
      );
    }

    static showCommentDialog({BuildContext context,TextEditingController controller,
      String labelText,String btn1Text,String btn2Text,
      Function onDialogAddPressed,
    }) async {
      await showDialog<String>(
        context: context,
        child: AlertDialog(
          backgroundColor: MyColors.appBlue,
          contentPadding: const EdgeInsets.all(10.0),
          content:  Row(
            children: <Widget>[
              Expanded(
                child:  TextField(
                  controller: controller,
                  cursorColor: MyColors.colorLogoOrange,
                  style: CTheme.textRegular16LogoOrange(),
                  // autofocus: true,
                  decoration:  InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      errorBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      disabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: MyColors.colorLogoOrange,
                          )
                      ),
                      labelText: labelText,
                      labelStyle: CTheme.textRegular16LogoOrange(),
                      contentPadding: EdgeInsets.all(5)
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child:  Text(btn1Text,style:CTheme.textRegular16LogoOrange(),),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child:  Text(btn2Text,style:CTheme.textRegular16LogoOrange()),
                onPressed: onDialogAddPressed
            )
          ],
        ),
      );
    }
}
