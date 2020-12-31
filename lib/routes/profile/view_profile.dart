import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/dialog/custom_dialogs.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/viewmodel/view_profile_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabbar/tabbar.dart';

class ViewProfile extends StatefulWidget {
  final Map<String, dynamic> data;

  ViewProfile({this.data});

  @override
  _SocialProfileScreenState createState() => _SocialProfileScreenState();
}

class _SocialProfileScreenState extends State<ViewProfile> {
  var tabController = PageController();
  double widthOfProfileContent;
  double widthOfProfileContent2;
  int itemCount = 20;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController addTopicDialogTC = TextEditingController();
  bool addTopicBtnVisibility = false;
  bool profileDetailsVisibility = true;
  bool lockIconVisibility = false;
  String userId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widthOfProfileContent = MediaQuery.of(context).size.width / 4;
    widthOfProfileContent2 = MediaQuery.of(context).size.width / 4;

    return BaseView<ViewProfileViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => viewProfileView(context, model),
    );
  }

  Widget viewProfileView(BuildContext context, ViewProfileViewModel model) {
    return FutureBuilder(
      future: model.getProfileInfo({
        "profile_status": widget.data['userData'].profileStatus.toString(),
        "profile_type": widget.data['userData'].profileType.toString(),
        "current_user_profile_id": widget.data['currentUserId'].toString()
      }, widget.data["userData"].profileId.toString()),
      builder: (context, userProfileSnapshot) {
        return model.profileSuccess != null
            ? model.profileSuccess
                ? Scaffold(
                    key: scaffoldKey,
                    drawer: DrawerMain(
                      context: context,
                    ),
                    endDrawer: DrawerRight(
                      context: context,
                    ),
                    backgroundColor: MyColors.colorDarkBlack,
                    bottomNavigationBar: MyBottomNavigationBar(
                      context: context,
                      scaffoldKey: scaffoldKey,
                    ),
                    body: BaseScrollView().baseView(context, [
                      Padding(
                        padding: EdgeInsets.only(top: 50, left: 15, right: 15),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 65),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: MyColors.searchBoxColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: TextField(
                                        style: CTheme.textRegular16White(),
                                        decoration: InputDecoration(
                                            hintText: 'Search Chat',
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: MyColors.colorWhite,
                                              size: 20,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: MyColors.appBlue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(
                                    Icons.add,
                                    size: 35,
                                    color: MyColors.colorWhite,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ///Commented To Do Profile Image.
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(30),
                              //   child: CachedNetworkImage(
                              //     imageUrl: model.userPostsData.data[position]
                              //         .userProfile.profileImage,
                              //     placeholder: (context, url) => Container(
                              //       transform:
                              //       Matrix4.translationValues(0, 0, 0),
                              //       child: Container(
                              //           width: 40,
                              //           height: 40,
                              //           child: Center(
                              //               child:
                              //               new CircularProgressIndicator())),
                              //     ),
                              //     errorWidget: (context, url, error) =>
                              //     new Icon(Icons.error,color: MyColors.colorWhite,),
                              //     width: 40,
                              //     height: 40,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: MyColors.colorWhite,
                                    borderRadius: BorderRadius.circular(60)),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.profileData.data.name,
                                        style: CTheme.textRegular16White(),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        model.profileData.data.interest,
                                        style: CTheme.textRegular11Grey(),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        model.profileData.data.email,
                                        style: CTheme.textRegular11White(),
                                        textAlign: TextAlign.start,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 50, left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    model.profileData.data.posts.toString(),
                                    style: CTheme.textRegular16White(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    ' Post',
                                    style: CTheme.textRegular11LogoOrange(),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    model.profileData.data.followers.toString(),
                                    style: CTheme.textRegular16White(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Followers',
                                    style: CTheme.textRegular11LogoOrange(),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    model.profileData.data.followeing
                                        .toString(),
                                    style: CTheme.textRegular16White(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Following',
                                    style: CTheme.textRegular11LogoOrange(),
                                  )
                                ],
                              ),
                            ],
                          )),

                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 35, right: 35),
                        child: Container(
                          height: 1,
                          color: MyColors.colorLogoOrange,
                        ),
                      ),

                      ///Follow Button
                      widget.data["userData"].profileId.toString() !=
                              widget.data['currentUserId'].toString()
                          ? Padding(
                              padding:
                                  EdgeInsets.only(left: 35, top: 30, right: 35),
                              child: roundedSquareButton(
                                  model.profileData.data.isFollowing == "true"
                                      ? 'UNFOLLOW'
                                      : 'FOLLOW', () async {
                                if (model.profileData.data.isFollowing ==
                                    "true") {
                                  CTheme.showCircularProgressDialog(context);
                                  await model.unfollowProfile(
                                      unfollowId:
                                          model.profileData.data.id.toString());
                                  if (model.unfollowSuccess) {
                                    Navigator.pop(context);
                                    setState(() {
                                      model.profileData.data;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    CTheme.showAppAlertOneButton(
                                      "Okay",
                                      context: context,
                                      title: "Error UnFollowing",
                                      bodyText:
                                          "There was some issue unFollowing the user",
                                    );
                                  }
                                } else {
                                  CTheme.showCircularProgressDialog(context);
                                  await model.followProfile({
                                    "follow_to":
                                        model.profileData.data.id.toString()
                                  });
                                  if (model.followSuccess) {
                                    Navigator.pop(context);
                                    setState(() {
                                      model.profileData.data;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    CTheme.showAppAlertOneButton(
                                      "Okay",
                                      context: context,
                                      title: "Error Following",
                                      bodyText:
                                          "There was some issue Following the user ",
                                    );
                                  }
                                }
                              }),
                            )
                          : Container(),

                      Stack(
                        children: [
                          ///Profile Details If Public.
                          Visibility(
                            visible: profileDetailsVisibility,
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Visibility(
                                      visible: false,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.laptop,
                                            color: MyColors.colorWhite,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Website',
                                              style:
                                                  CTheme.textRegular16White(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: SizedBox(
                                      height: 190,
                                      child: Card(
                                        color: MyColors.appBlue,
                                        elevation: 5,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Visibility(
                                                visible: addTopicBtnVisibility,
                                                child:
                                                    roundedSquareButtonAddTopic(
                                                        'Add Topic',
                                                        () => {
                                                              CustomDialogs
                                                                  .showTopicsDialog(
                                                                      context:
                                                                          context,
                                                                      controller:
                                                                          addTopicDialogTC,
                                                                      onDialogAddPressed:
                                                                          () async {
                                                                        CTheme.showCircularProgressDialog(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                        SharedPreferences
                                                                            prefs =
                                                                            await SharedPreferences.getInstance();
                                                                        await model.addTopic(
                                                                            prefs.get(Globals.profileId),
                                                                            {
                                                                              "user_id": prefs.get(Globals.profileId),
                                                                              "topics": [
                                                                                {
                                                                                  "id": null,
                                                                                  "name": addTopicDialogTC.text.trim()
                                                                                },
                                                                              ]
                                                                            });
                                                                        if (model
                                                                            .addTopicSuccess) {
                                                                          addTopicDialogTC
                                                                              .clear();
                                                                          Navigator.pop(
                                                                              context);
                                                                          print(
                                                                              'Success');
                                                                        } else {
                                                                          addTopicDialogTC
                                                                              .clear();
                                                                          Navigator.pop(
                                                                              context);
                                                                          CTheme.showAppAlertOneButton(
                                                                              "Okay",
                                                                              context: context,
                                                                              bodyText: "Topic already exists",
                                                                              title: "Error");
                                                                          print(
                                                                              "Error");
                                                                        }
                                                                      })
                                                            }),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: FutureBuilder<bool>(
                                                  future: model.getUserTopics(
                                                      widget.data["userData"]
                                                          .profileId
                                                          .toString()),
                                                  builder: (context,
                                                      topicsListSnapshot) {
                                                    return topicsListSnapshot
                                                                .data !=
                                                            null
                                                        ? topicsListSnapshot
                                                                .data
                                                            ? ListView.builder(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                scrollDirection: Axis
                                                                    .horizontal,
                                                                itemCount: model
                                                                    .topicsData
                                                                    .data
                                                                    .length,
                                                                shrinkWrap:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        position) {
                                                                  return itemCategoryRow(
                                                                      model,
                                                                      position);
                                                                })
                                                            : Container()
                                                        : Container();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: TabbarHeader(
                                      indicatorColor: MyColors.colorDarkBlack,
                                      backgroundColor: MyColors.colorDarkBlack,
                                      controller: tabController,
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            'Gallery',
                                            style: CTheme.textRegular16White(),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Videos',
                                            style: CTheme.textRegular16White(),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Featured',
                                            style: CTheme.textRegular16White(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: SizedBox(
                                      height:
                                          widthOfProfileContent * itemCount / 2,
                                      child: TabbarContent(
                                        controller: tabController,
                                        children: [
                                          Container(
                                            color: MyColors.colorDarkBlack,
                                            child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3),
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: itemCount,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (context, position) {
                                                  return itemProfileContent();
                                                }),
                                          ),
                                          Container(
                                            color: MyColors.colorDarkBlack,
                                            child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3),
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: itemCount,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (context, position) {
                                                  return itemProfileContent();
                                                }),
                                          ),
                                          Container(
                                            color: MyColors.colorDarkBlack,
                                            child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3),
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: itemCount,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (context, position) {
                                                  return itemProfileContent();
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ///Lock Icon If Private.
                          Visibility(
                            visible: lockIconVisibility,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Container(
                                height: 165,
                                width: 165,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF242A37),
                                        Color(0xFF4E586E)
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.lock,
                                  color: MyColors.colorWhite,
                                  size: 85,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  )
                : Scaffold(
                    body: Center(
                      child: Text("Error Retrieving Data"),
                    ),
                  )
            : loadingView();
      },
    );
  }

  Scaffold loadingView() {
    return Scaffold(
        backgroundColor: MyColors.colorDarkBlack,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.colorLogoOrange),
          ),
        ));
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
                style: CTheme.textRegular11LogoOrange(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget roundedSquareButtonAddTopic(String btnText, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: 25,
            width: 150,
            decoration: (BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(5),
            )),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        btnText,
                        style: CTheme.textRegular11White(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: MyColors.appBlue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.add,
                          color: MyColors.colorWhite,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ],
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

  Widget itemCategoryRow(ViewProfileViewModel model, int position) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        children: [
          Text(
            model.topicsData.data[position].name,
            style: CTheme.textRegular16White(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: MyColors.appBlue,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset(
                'assets/images/list_image/image_list_model.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemProfileContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  height: widthOfProfileContent,
                  width: widthOfProfileContent,
                  decoration: BoxDecoration(
                      color: MyColors.appBlue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.asset(
                    'assets/images/list_image/image_list_model.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemProfileContent2() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  height: widthOfProfileContent2,
                  width: widthOfProfileContent2,
                  decoration: BoxDecoration(
                      color: MyColors.appBlue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.asset(
                    'assets/images/list_image/image_list_model.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
