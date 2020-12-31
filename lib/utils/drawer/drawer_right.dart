import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/all_friends.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/viewmodel/drawer_right_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerRight extends StatefulWidget {
  final BuildContext context;

  DrawerRight({this.context});

  @override
  DrawerRightState createState() => DrawerRightState();
}

class DrawerRightState extends State<DrawerRight> {
  SharedPreferences preferences;
  String selectedAccount = "";
  Color colorsSocial = Color(0xFFD4AB59);
  String urlSelectedImage="";

  @override
  void initState() {
    getUserDateForDrawer();
    initPrefrence();
    super.initState();
  }

  initPrefrence() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      selectedAccount = preferences.getString(Globals.afterSelectedAccountValue);
      Globals.profileNameForMainDrawer = selectedAccount;
      urlSelectedImage=preferences.getString(Globals.urlImageBusiness);
      Globals.profileImageForMainDrawer=urlSelectedImage;
      if (preferences.getString(Globals.defualtRoundColor) == "defualt") {
        urlSelectedImage = preferences.getString(Globals.urlImageSocial);
        Globals.profileImageForMainDrawer=urlSelectedImage;
        colorsSocial = Color(0xFFD4AB59);
      } else {
        colorsSocial = Color(0x000000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DrawerRightViewModel>(
      builder: (context, model, child) => drawerRightView(context, model),
    );
  }

  ////
  SafeArea drawerRightView(BuildContext context, DrawerRightViewModel model) {
    return SafeArea(
      child: Drawer(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: MyColors.colorDarkBlack,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 40),
                child: InkWell(
                  onTap: () {
                    print(Globals.SocialAccount);
                    print(selectedAccount);
                    print('edit_account');
                    if (Globals.SocialAccount == selectedAccount) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/edit_social_profile');
                      print(preferences.getString(Globals.socialProfileId));
                    } else {
                      print(preferences.getString(Globals.profileId));
                      ////todo: going to edit buisness profile account
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/edit_buisness_profile');
                    }
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
                            imageUrl: urlSelectedImage,
                          ),
                        ),
                      ),
                      selectedAccount == null
                          ? FutureBuilder<bool>(
                              future: model.getProfileCounts(),
                              builder: (context, profileCountSnapshot) {
                                if (model.profileCountData != null) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          selectedAccount,
                                          style: CTheme.textRegular21White(),
                                        ),
                                        Text(
                                          'Social Account',
                                          style:
                                              CTheme.textRegular11WhiteItalic(),
                                        ),

                                      ],
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "n",
                                    style: TextStyle(color: Colors.white),
                                  );
                                }
                              })
                          : Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Text(
                                    selectedAccount,
                                    style: CTheme.textRegular21White(),
                                  ),
                                  Text(
                                    'Selected Account',
                                    style: CTheme.textRegular11WhiteItalic(),
                                  ),

                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: navRightTextIconBusiness(
                    'Business Account', () => {}, false, true, model),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget navRightTextIconSocial(
      String text,
      Function onTap,
      bool selectedProfileVisibility,
      bool countVisibility,
      String countBuisness) {
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
                      Visibility(
                        visible: selectedProfileVisibility,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: colorsSocial,
                                borderRadius: BorderRadius.circular(15)),
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        ///todo:image here
                        preferences.setString(Globals.defualtRoundColor, "defualt");
                        preferences.setString(Globals.afterSelectedAccountValue, Globals.SocialAccount);

                        selectedAccount = Globals.SocialAccount;
                        String profileId = preferences.getString(Globals.socialProfileId);
                        print("profileId socialSelected ==> " + profileId);
                        preferences.setString(Globals.profileId, profileId);
                        preferences.setString(Globals.userPostId, "posts");




                      });
                      Navigator.pop(context);
                      Globals.currentRoute = '/profile_home';
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/profile_home', (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 8, top: 5, bottom: 5),
                          child: Text(
                            text,
                            style: CTheme.textRegular18White(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: countVisibility,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15, top: 5),
                          child: Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: MyColors.colorRedPlay,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              countBuisness,
                              style: CTheme.textRegular11White(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navRightTextIconBusiness(
      String text,
      Function onTap,
      bool selectedProfileVisibility,
      bool countVisibility,
      DrawerRightViewModel model) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Stack(
                children: [
                  FutureBuilder<bool>(
                      future: model.getProfileCounts(),
                      builder: (context, profileCountSnapshot) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 25),
                                  child: profileCountSnapshot.data != null
                                      ? profileCountSnapshot.data
                                          ? Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                model.profileCountData.data
                                                            .buisnessCount !=
                                                        null
                                                    ? ""
                                                    : "",
                                                style:
                                                    CTheme.textRegular11White(),
                                              ),
                                            )
                                          : Container()
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          child: CTheme
                                              .showCircularProgressIndicator(
                                                  strokeWidget: 2)),
                                ),
                              ],
                            ),
                            ////Social Account
                            Padding(
                              padding: EdgeInsets.only(top: 5, left: 20),
                              child: navRightTextIconSocial(
                                  Globals.SocialAccount == null
                                      ? ""
                                      : Globals.SocialAccount, () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                Navigator.pushNamed(context, '/view_profile',
                                    arguments: {
                                      "userData": Data(
                                        profileId: int.parse(
                                            prefs.getString(Globals.profileId)),
                                        profileStatus: 'public',
                                        profileType: prefs
                                            .getString(Globals.profileType),
                                      ),
                                      "currentUserId":
                                          prefs.getString(Globals.profileId)
                                    });
                              }, true, false, ''),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            model.profileCountData != null
                                ? model.profileCountData.data.buisnessProfiles
                                            .length >
                                        0
                                    ? Container(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: model.profileCountData.data
                                              .buisnessProfiles.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  
                                                  preferences.setString(Globals.urlImageBusiness, model.profileCountData.data
                                                      .buisnessProfiles[index].profileImage);

                                                  preferences.setString(
                                                      Globals.defualtRoundColor,
                                                      "Nodefualt");
                                                  preferences.setString(
                                                      Globals.userPostId,
                                                      "userposts");
                                                  preferences.setString(
                                                      Globals
                                                          .afterSelectedAccountValue,
                                                      model
                                                          .profileCountData
                                                          .data
                                                          .buisnessProfiles[
                                                              index]
                                                          .profileName
                                                          .toString());

                                                  selectedAccount = model
                                                      .profileCountData
                                                      .data
                                                      .buisnessProfiles[index]
                                                      .profileName
                                                      .toString();
                                                  preferences.setString(
                                                      Globals.profileId,
                                                      model
                                                          .profileCountData
                                                          .data
                                                          .buisnessProfiles[
                                                              index]
                                                          .id
                                                          .toString());

                                                  Navigator.pop(context);
                                                  Globals.currentRoute =
                                                      '/profile_home';
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          '/profile_home',
                                                          (route) => false);
                                                });
                                              },
                                              child: ListTile(
                                                title: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    getData(model, index),
                                                    Divider(
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container()
                                : Container(),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 0, right: 50),
                                child: Container(
                                  height: 40,
                                  child: roundedSquareButton(
                                    "ADD PROFILE",
                                    () async {
                                      Navigator.pushNamed(
                                          context, '/create_business_profile');
                                    },
                                  ),
                                ))
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getData(DrawerRightViewModel model, int index) {
    String selectedId = preferences.getString(Globals.profileId);
    print("Selected==>" + selectedId);

    if (selectedId.toString() ==
        model.profileCountData.data.buisnessProfiles[index].id.toString()) {
      return Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.colorLogoOrange,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Text(
                model.profileCountData.data.buisnessProfiles[index].profileName,
                style: CTheme.textRegular18White()),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Text(model.profileCountData.data.buisnessProfiles[index].profileName,
              style: CTheme.textRegular18White())
        ],
      );
    }
  }

  getUserDateForDrawer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
