
import 'dart:async';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectProfileType extends StatefulWidget {

  @override
  _SelectProfileTypeScreenState createState() => _SelectProfileTypeScreenState();
}


class _SelectProfileTypeScreenState extends State<SelectProfileType> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.appBlue,
        body: BaseScrollView().baseView(context, [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child:Container(
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
            padding: EdgeInsets.only(top: 50,left: 20,right: 20),
            child: profileTypeBox(Localization.stLocalized('socialProfile'),
            Localization.stLocalized('theDoorIs'),
                Localization.stLocalized('createSocialProfile'),
                ()=>{
              Navigator.pushNamed(context,'/create_social_profile')
                }
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 40),
            child: profileTypeBox(Localization.stLocalized('businessProfile'),
                Localization.stLocalized('theDoorIs'),
                Localization.stLocalized('createBusinessProfile'),
                    ()=>{
              Navigator.pushNamed(context, '/create_business_profile')
                    }
            ),
          ),
        ])
    );
  }

  Widget profileTypeBox(String headingText,String subText,String btnText
      ,Function onTap)
  {
    return Container(
            decoration: BoxDecoration(
              color: MyColors.appBlue,
              border: Border(
                left: BorderSide(
                  color: MyColors.colorLogoOrange,
                  width: 5,
                ),
                right: BorderSide(
                  color: MyColors.colorLogoOrange,
                  width: 5,
                ),
                bottom: BorderSide(
                  color: MyColors.colorLogoOrange,
                  width: 5,
                ),
                top: BorderSide(
                  color: MyColors.colorLogoOrange,
                  width: 5,
                ),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    headingText,
                    style: CTheme.textRegular26LogoOrange(),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      height: 0.5,
                      width: 200,
                      color: MyColors.colorLogoOrange,
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(top:10,left: 75,right: 75),
                  child: Text(
                    subText,
                    style: CTheme.textRegular11WhiteItalic(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25,left: 30,right: 30,bottom: 25),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onTap,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: (
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF242A37),
                                        Color(0xFF4E586E)
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                            child: Text(
                              btnText,
                              style: CTheme.textRegularBold14White(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          );
  }

  Widget roundedSquareButton(String btnText,Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: (
                  BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF242A37),
                          Color(0xFF4E586E)
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp
                    ),
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
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
        hintText:hintText,
        hintStyle: CTheme.textRegular18White(),

      ),
    );
  }

}