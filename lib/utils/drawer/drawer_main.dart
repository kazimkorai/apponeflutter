import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/drawer_right_vmodel.dart';
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMain extends StatefulWidget {
  final BuildContext context;

  DrawerMain({this.context});

  @override
  DrawerMainState createState() => DrawerMainState();
}

class DrawerMainState extends State<DrawerMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DrawerRightViewModel>(
      builder: (context, model, child) => WidgetA(context, model),
    );
  }

  WidgetA(BuildContext context, DrawerRightViewModel model) {
    return SafeArea(
      child: Theme(
          data:
              Theme.of(context).copyWith(canvasColor: MyColors.colorDarkBlack),
          child: Drawer(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: MyColors.colorDarkBlack,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35, left: 40),
                      child: InkWell(
                        onTap: () {
                          /*       print('edit_account');
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/edit_account');*/
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: MyColors.colorWhite,
                              ),
                              child:    ClipOval(
                                child: CachedNetworkImage(
                                  height: 90,
                                  fit:BoxFit.cover ,
                                  width: 90,
                                  imageUrl: Globals. profileImageForMainDrawer,
                                ),
                              ),
                            ),
                            Globals.profileNameForMainDrawer == null
                                ? FutureBuilder<bool>(
                                    future: model.getProfileCounts(),
                                    builder: (context, profileCountSnapshot) {
                                      if (model.profileCountData != null) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                Globals
                                                    .profileNameForMainDrawer,
                                                style:
                                                    CTheme.textRegular21White(),
                                              ),
                                              Text(
                                                'Selected Account',
                                                style: CTheme
                                                    .textRegular11WhiteItalic(),
                                              ),
                                              /*   Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                child: roundedSquareButton(
                                  "Edit Profile",
                                      () async {

                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/edit_account');
                                  },
                                ))*/
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Text("");
                                      }
                                    })
                                : Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          Globals.profileNameForMainDrawer,
                                          style: CTheme.textRegular21White(),
                                        ),
                                        Text(
                                          'Selected Account',
                                          style:
                                              CTheme.textRegular11WhiteItalic(),
                                        ),
                                        /*   Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                child: roundedSquareButton(
                                  "Edit Profile",
                                      () async {

                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/edit_account');
                                  },
                                ))*/
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50, left: 30),
                      child: navTextItem(
                          'Home',
                          () => {
                                Globals.goToRoute = '/profile_home',
                                if (Globals.goToRoute != Globals.currentRoute)
                                  {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Globals.goToRoute,
                                        (route) => false).then((value) => {}),
                                    Globals.currentRoute = Globals.goToRoute,
                                    print(Globals.currentRoute)
                                  }
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navTextItem(
                          'Inbox',
                          () => {
                                handleNavDrawerRouting(
                                    goToRoute: '/social_inbox',
                                    currentRoute: Globals.currentRoute,
                                    homeRoute: '/profile_home')
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navTextItem(
                          'Notifications',
                          () => {
                                Navigator.pop(context),
                                handleNavDrawerRouting(
                                    goToRoute: '/notifications',
                                    currentRoute: Globals.currentRoute,
                                    homeRoute: '/profile_home')
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navTextItem(
                          'Create Image Post',
                          () => {
                                handleNavDrawerRouting(
                                    goToRoute: '/create_post',
                                    currentRoute: Globals.currentRoute,
                                    homeRoute: '/profile_home')
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navTextItem(
                          'Create Video Post',
                              () => {
                            handleNavDrawerRouting(
                                goToRoute: '/create_video_post',
                                currentRoute: Globals.currentRoute,
                                homeRoute: '/profile_home')
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navTextItem(
                          'Settings',
                          () => {
                                Navigator.pop(context),
                                handleNavDrawerRouting(
                                    goToRoute: '/settings',
                                    currentRoute: Globals.currentRoute,
                                    homeRoute: '/profile_home')
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navTextItem(
                          'About Us',
                          () => {
                                Navigator.pop(context),
                                handleNavDrawerRouting(
                                    goToRoute: '/about_us',
                                    currentRoute: Globals.currentRoute,
                                    homeRoute: '/profile_home'),
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: navIconTextIcon(
                          "Advertise With Us",
                          () => {
                                print('I clicked advertise'),
                                CTheme.showAppAlertOneButton(
                                  "DONE",
                                  context: context,
                                  title: 'Advertise with us -Tutorial',
                                  bodyText: '',
                                ),
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100, left: 30, bottom: 30),
                      child: navIconTextItemNoLine(
                          "Logout",
                          () async => {
                                CTheme.showCircularProgressDialog(context),
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FireBaseService.getCurrentUserUid())
                                    .update({'fcmToken': null})
                                    .then((value) => {
                                          FirebaseAuth.instance.signOut(),
                                          print(
                                              "Login: Token Update Successful "),
                                          Navigator.pop(context),
                                          Navigator.pushReplacementNamed(
                                              context, '/login')
                                        })
                                    .catchError((error) => {
                                          print(error),
                                          Navigator.pop(context),
                                          CTheme.showAppAlertOneButton("Okay",
                                              context: context,
                                              title: 'Error',
                                              bodyText: "Error Logging Out!",
                                              handler2: (action) => {
                                                    Navigator.pop(context),
                                                  })
                                        }),
                              }),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget navTextItem(String text, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: Text(
                            text,
                            style: CTheme.textRegular18White(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navIconTextItemNoLine(String text, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        child: Text(
                          text,
                          style: CTheme.textRegular18White(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navIconTextIcon(String text, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        child: Text(
                          text,
                          style: CTheme.textRegular18White(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 5),
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColors.colorWhite,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '?',
                            style: CTheme.textRegular13Black(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleNavDrawerRouting(
      {String goToRoute, String currentRoute, String homeRoute}) {
    Globals.goToRoute = goToRoute;
    if (Globals.goToRoute != Globals.currentRoute) {
      if (Globals.currentRoute == homeRoute) {
        Navigator.pop(context);
        Navigator.pushNamed(context, Globals.goToRoute);
        Globals.currentRoute = Globals.goToRoute;
        print(Globals.currentRoute);
      } else {
        Navigator.pushReplacementNamed(
          context,
          Globals.goToRoute,
        );
        Globals.currentRoute = Globals.goToRoute;
        print(Globals.currentRoute);
      }
    }
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
}
