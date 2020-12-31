
import 'dart:async';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageOptions extends StatefulWidget {

  @override
  _MessageOptionsScreenState createState() => _MessageOptionsScreenState();
}


class _MessageOptionsScreenState extends State<MessageOptions> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        drawer: DrawerMain(context: context,),
        endDrawer: DrawerRight(context: context,),
      bottomNavigationBar: MyBottomNavigationBar(context: context,
      scaffoldKey: scaffoldKey,),
      backgroundColor: MyColors.colorDarkBlack,
      body: BaseScrollView().baseView(context, [
       Container(
         margin: EdgeInsets.only(top: 50),
         height: 220,
         width: 220,
         decoration:BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           image: DecorationImage(
             fit: BoxFit.fill,
             image: AssetImage(
               "assets/images/confirm_post/femaleimage.png",
             ),
           )
         ),
       ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Antonia Berger',
                style: CTheme.textRegular16White(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                'Antonia Berger',
                style: CTheme.textRegular8Grey(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                'antonia.com',
                style: CTheme.text8WhiteBold(),
              ),
            ),
          ],
        ),

        Container(
          margin: EdgeInsets.only(top: 15),
          color: MyColors.colorWhite,
          height: 2,
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: ()=>{
              Navigator.pushNamed(context, '/send_new_message')
            },
              child: itemSettingButtonCenter('View Profile',
                  CTheme.textRegular12WhiteBold())),
        ),


        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Media','4778',CTheme.textRegular12WhiteBold()),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Document and Links','425',CTheme.textRegular12WhiteBold()),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Starred Messages','24',CTheme.textRegular12WhiteBold()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Search Chat','',CTheme.textRegular12WhiteBold()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Custom Sound','',CTheme.textRegular12WhiteBold()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Share Profile','',CTheme.textRegular12WhiteBold()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Mute','',CTheme.textRegular12WhiteBold()),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: itemSettingButton('Clear Chat','',CTheme.textRegular12RedBold()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5,bottom: 30),
          child: itemSettingButton('Block Profile','',CTheme.textRegular12RedBold()),
        ),
      ])
    );
  }


  Widget itemSettingButton(String title,String subtitle,TextStyle style) {
    return Container(
        height: 40,
        color: MyColors.appBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                title,
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                  subtitle,
                style: CTheme.textRegular12WhiteBold(),
              ),
            )
          ],
        ),
      );
  }

  Widget itemSettingButtonCenter(String title,TextStyle style) {
    return Container(
      height: 40,
      color: MyColors.appBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title,
              style: style,
            ),
          ),
        ],
      ),
    );
  }


}