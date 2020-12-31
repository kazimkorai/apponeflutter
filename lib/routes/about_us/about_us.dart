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
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUs> {
  bool userTutorialVisibility = false;
  bool businessTutorialVisibility = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String contentAbout="";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AboutSettingsViewModel>(
      onModelReady: (model) async {
        CTheme.showCircularProgressDialog(context);
        await model.aboutUsSettings();
        print(model.aboutUsSettingsSuccess.toString());
        print(model.aboutUsSettingsData.data.sideBar[0].content.toString());
        setState(() {
          contentAbout=model.aboutUsSettingsData.data.sideBar[0].content.toString();
        });
        Navigator.pop(context);
      },
      builder: (context, model, child) => aboutUsView(context, model),
    );
  }

  WillPopScope aboutUsView(BuildContext context, AboutSettingsViewModel) {
  return  WillPopScope(
      onWillPop: () async {
        Globals.currentRoute = '/profile_home';
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
                contentAbout,
            /*    Localization.stLocalized('descriptionOfApp'),*/
                style: CTheme.textRegular15White(),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: dropDownVideoItem(
                    'User Tutorials',
                    () => {
                          setState(() {
                            userTutorialVisibility = !userTutorialVisibility;
                          })
                        })),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Visibility(
                visible: userTutorialVisibility,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return videoItemList();
                    }),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                child: dropDownVideoItem(
                    'Business Tutorials',
                    () => {
                          setState(() {
                            businessTutorialVisibility =
                                !businessTutorialVisibility;
                          })
                        })),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Visibility(
                visible: businessTutorialVisibility,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return videoItemList();
                    }),
              ),
            ),
          ])),
    );
  }

  Widget videoItemList() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            Localization.stLocalized('socialTutorial'),
            style: CTheme.textRegular21White(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 0, right: 0),
            child: Container(
              height: 180,
              color: MyColors.colorFullBlack,
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 0,right: 0),
                  height: 180,
                 /* decoration: BoxDecoration(
                     // color: MyColors.colorRedPlay,
                      borderRadius: BorderRadius.circular(50)),*/
                 /* height: 100,
                  width: 100,*/
                  child: VimeoPlayer(id: '395212534', autoPlay: false),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget roundedSquareButton(String btnText, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: (BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
              )),
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
        hintText: hintText,
        hintStyle: CTheme.textRegular18White(),
      ),
    );
  }

  Widget dropDownVideoItem(String text, Function onTap) {
    return SizedBox(
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
                  style: CTheme.textRegular18White(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.arrow_drop_down,
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
