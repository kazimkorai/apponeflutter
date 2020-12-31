import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/dialog/custom_dialogs.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/viewmodel/profile_home_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabbar/tabbar.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeScreenState createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHome> {
  var tabController = PageController();
  double widthOfProfileContent;
  double widthOfProfileContent2;
  int itemCount = 20;
  int tappedIndexRow2 = 0;
  int tappedIndexRow1 = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  WidgetsBindingObserver observer;
  bool isLike;
  bool onTapClicked = false;
  List<Map<String, dynamic>> listOfLikeAndCountForPost;
  ScrollController profileHomeScrollController = ScrollController();
  double minHeightBound1 = 690;
  double minHeightBound2 = 780;
  double postHeight = 540;
  bool isInViewListen = false;
  ScrollPhysics postListScrollPhysics = NeverScrollableScrollPhysics();
  bool isListScrollable = false;
  ScrollPhysics profileHomeScrollPhysics;
  ScrollController postListController = ScrollController();
  int currentPostPosition;
  TextEditingController reportTC = TextEditingController();
  String id=" 67";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    widthOfProfileContent = MediaQuery.of(context).size.width / 4;
    widthOfProfileContent2 = MediaQuery.of(context).size.width / 2.5;

        return  BaseView<ProfileHomeViewModel>(
          onModelReady: (model) {
            ///Scroll Listeners.
            attachScrollListeners(model);
            getSuggestedFriends(model);
          },
          builder: (context, model, child) => profileHomeView(context, model),
        );
  }

  Scaffold profileHomeView(BuildContext context, ProfileHomeViewModel model) {
    return Scaffold(
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
      body: BaseScrollView().baseView(
          context,
          [
            ///Search Box and Add Button
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
                                borderRadius: BorderRadius.circular(25)),
                            child: TextField(
                              onTap: () => {},
                              style: CTheme.textRegular16White(),
                              decoration: InputDecoration(
                                  hintText: 'Search',
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
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(
                              context, '/create_business_profile'),
                          print(
                              "Is Scrolling ${profileHomeScrollController.position.isScrollingNotifier.value}")
                        },
                        child: Container(
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
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            ///List Of Friends
            FutureBuilder<bool>(
              future: model.getFriendsList(),
              builder: (context, friendsList) {
                return Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 80,
                    child: friendsList.data != null
                        ? friendsList.data &&
                                model.friendListData.data.length > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              model.friendListData.data.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, position) {
                                            return itemFriendsList(
                                                model, position);
                                          }),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Friends To Show',
                                    style: CTheme.textRegular15White(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                        : Container(
                            height: 20,
                          ),
                  ),
                );
              },
            ),

            ///Discover Text.
            Padding(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => {},
                        child: Text(
                          'Discover',
                          style: CTheme.textRegular25White(),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Edit Categories',
                        style: CTheme.textRegular13White(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
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
                  ),
                ],
              ),
            ),

            ///Category List Widget
            FutureBuilder<bool>(
              future: model.getUserInterestedCategories(),
              builder: (context, categoriesSnapshot) {
                return Padding(
                  padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: SizedBox(
                    height: 80,
                    child: categoriesSnapshot.data != null
                        ? categoriesSnapshot.data &&
                                model.categoriesData.data.length > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              model.categoriesData.data.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, position) {
                                            return itemCategoryRow(
                                                position, model);
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  'No Categories To Show',
                                  style: CTheme.textRegular15White(),
                                ),
                              )
                        : Container(),
                  ),
                );
              },
            ),

            ///Story Row
            Padding(
              padding: EdgeInsets.only(top: 0, left: 15, right: 15),
              child: SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, position) {
                            return itemSuggestedFriendRow();
                          }),
                    ),
                  ],
                ),
              ),
            ),

            ///Trending List Row
            Padding(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, position) {
                            return itemCategoryRow2(position);
                          }),
                    ),
                  ],
                ),
              ),
            ),

            ///Posts Tab Headers
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: TabbarHeader(
                indicatorColor: MyColors.colorDarkBlack,
                backgroundColor: MyColors.colorDarkBlack,
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'All Posts',
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
                      'Images',
                      style: CTheme.textRegular16White(),
                    ),
                  ),
                ],
              ),
            ),

            ///Posts Tab Content
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: FutureBuilder<bool>(
                  future: model.getUserPosts(),
                  builder: (context, postListSnapshot) {
                    return postListSnapshot.data != null
                        ? postListSnapshot.data
                            ? SizedBox(
                                height: 550.0,
                                child: TabbarContent(
                                  controller: tabController,
                                  children: [
                                    ///Tab All Posts
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            right: 25),
                                                    child: Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          color: MyColors
                                                              .searchBoxColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: TextField(
                                                        style: CTheme
                                                            .textRegular16White(),
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'Search HashTag',
                                                                border:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: MyColors
                                                                      .colorWhite,
                                                                  size: 20,
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: SizedBox(
                                                  height: 500,
                                                  child: model.userPostsData
                                                          .data.isNotEmpty
                                                      ? InViewNotifierList(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10,
                                                                  bottom: 10),
                                                          controller:
                                                              postListController,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          physics:
                                                              postListScrollPhysics,
                                                          itemCount: model
                                                              .userPostsData
                                                              .data
                                                              .length,
                                                          shrinkWrap: true,
                                                          isInViewPortCondition:
                                                              (double deltaTop,
                                                                  double
                                                                      deltaBottom,
                                                                  double
                                                                      vpHeight) {
                                                            return deltaTop <
                                                                    (0.5 *
                                                                        vpHeight) &&
                                                                deltaBottom >
                                                                    (0.5 *
                                                                        vpHeight);
                                                          },
                                                          builder: (context,
                                                              position) {
                                                            if (!onTapClicked) {
                                                              listOfLikeAndCountForPost =
                                                                  [];
                                                              for (var items
                                                                  in model
                                                                      .userPostsData
                                                                      .data) {
                                                                items.isSelfLike ==
                                                                        'true'
                                                                    ? listOfLikeAndCountForPost
                                                                        .add({
                                                                        "isLiked":
                                                                            true,
                                                                        "likeCount":
                                                                            items.isLikeCount
                                                                      })
                                                                    : listOfLikeAndCountForPost
                                                                        .add({
                                                                        "isLiked":
                                                                            false,
                                                                        "likeCount":
                                                                            items.isLikeCount
                                                                      });
                                                              }
                                                            }
                                                            listOfLikeAndCountForPost
                                                                .length;
                                                            return postItemAllPosts(
                                                                model,
                                                                position);
                                                          })
                                                      : Container(
                                                          child: Center(
                                                            child: Text(
                                                              "No Posts Yet!",
                                                              style: CTheme
                                                                  .textRegular16White(),
                                                            ),
                                                          ),
                                                        ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),

                                    ///Tab Videos
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            right: 25),
                                                    child: Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          color: MyColors
                                                              .searchBoxColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: TextField(
                                                        style: CTheme
                                                            .textRegular16White(),
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'Search Hashtag',
                                                                border:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: MyColors
                                                                      .colorWhite,
                                                                  size: 20,
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: 0,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, position) {
                                                    return postItem(
                                                        model, position);
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    ///Tab Images
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            right: 25),
                                                    child: Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          color: MyColors
                                                              .searchBoxColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: TextField(
                                                        style: CTheme
                                                            .textRegular16White(),
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'Search Hashtag',
                                                                border:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: MyColors
                                                                      .colorWhite,
                                                                  size: 20,
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: 0,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, position) {
                                                    return postItem(
                                                        model, position);
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: 100,
                              )
                        : Container(
                            height: 100,
                          );
                  }),
            ),
          ],
          controller: profileHomeScrollController,
          baseScrollPhysics: profileHomeScrollPhysics),
    );
  }



  void attachScrollListeners(ProfileHomeViewModel model) {
    ///Scroll Listener For List Of Posts.
    postListController.addListener(() {
      // print("Is Scrolling List ${postListController.position.isScrollingNotifier.value}");
      print("Post List Controller Offset${postListController.offset}");
      if (postListController.offset == 0.0) {
        profileHomeScrollController.animateTo(
            profileHomeScrollController.offset - 10,
            duration: Duration(milliseconds: 50),
            curve: Curves.easeIn);
        setState(() {
          postListScrollPhysics = NeverScrollableScrollPhysics();
        });
      }
    });

    ///Scroll Listener For Main Profile Page.
    profileHomeScrollController.addListener(() {
      print("isInView Listen $isInViewListen");
      // print("Is Scrolling Home${profileHomeScrollController.position.isScrollingNotifier.value}");
      print(profileHomeScrollController.offset);
      if (profileHomeScrollController.offset ==
              profileHomeScrollController.position.maxScrollExtent &&
          model.userPostsData.data.isNotEmpty) {
        postListController.jumpTo(1.0);
        setState(() {
          postListScrollPhysics = AlwaysScrollableScrollPhysics();
        });
      }
      if (profileHomeScrollController.offset <
              profileHomeScrollController.position.maxScrollExtent &&
          model.userPostsData.data.isNotEmpty) {
        postListController.jumpTo(0.0);
        postListScrollPhysics = NeverScrollableScrollPhysics();
      }
    });
  }

  Widget postItem(ProfileHomeViewModel model, int position) {
    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, '/comment_on_post')},
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.appBlue,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Card(
                  elevation: 0,
                  color: MyColors.appBlue,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.colorWhite,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 40,
                              width: 40,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.userPostsData.data[position].userProfile
                                      .profileName,
                                  style: CTheme.textRegular18White(),
                                  textAlign: TextAlign.start,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                      model.userPostsData.data[position]
                                          .createdAt,
                                      style: CTheme.textRegular11Grey()),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 230,
                        child: Image.asset(
                          'assets/images/confirm_post/femaleimage.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Row(
                          children: [
                            Text(
                              Localization.stLocalized('hashTagText'),
                              style: CTheme.textRegular14LogoOrange(),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: SizedBox(
                          height: 65,
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    model.userPostsData.data[position]
                                        .description,
                                    style: CTheme.textRegular14White(),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30, left: 15, right: 15, bottom: 20),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: MyColors.colorWhite,
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    model.userPostsData.data[position]
                                        .isLikeCount
                                        .toString(),
                                    style: CTheme.textRegular11White(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Icon(
                                    Icons.mode_comment,
                                    color: MyColors.colorWhite,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    model.userPostsData.data[position]
                                        .postCommentsCount
                                        .toString(),
                                    style: CTheme.textRegular11White(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Icon(
                                    Icons.share,
                                    color: MyColors.colorWhite,
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    model.userPostsData.data[position]
                                        .isShareCount
                                        .toString(),
                                    style: CTheme.textRegular11White(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: MyColors.colorWhite,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Icon(
                                    Icons.flag,
                                    color: MyColors.colorRedPlay,
                                    size: 15,
                                  ),
                                )
                              ],
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
        ),
      ),
    );
  }

  Widget postItemAllPosts(ProfileHomeViewModel model, int position) {
    return InViewNotifierWidget(
      id: "$position",
      builder: (context, isInView, child) {
        if (isInView && currentPostPosition != position) {
          currentPostPosition = position;
          Future.delayed(Duration(seconds: 3), () async {
            if (!postListController.position.isScrollingNotifier.value &&
                !profileHomeScrollController
                    .position.isScrollingNotifier.value) {
              await model.postViewed(
                  postId: model.userPostsData.data[position].postId.toString());
              if (model.postViewedSuccess)
                print("Success Viewing Post");
              else
                print("Failed Viewing Post");
            }
          });
        }
        return GestureDetector(
          onTap: () => {
            print(
                "Is Scrolling List ${postListController.position.isScrollingNotifier.value}"),
            Navigator.pushNamed(context, '/post_detail_view',
                arguments: model.userPostsData.data[position])
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: MyColors.appBlue,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Card(
                      elevation: 0,
                      color: MyColors.appBlue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 10, bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    imageUrl: model.userPostsData.data[position]
                                        .userProfile.profileImage,
                                    placeholder: (context, url) => Container(
                                      transform:
                                          Matrix4.translationValues(0, 0, 0),
                                      child: Container(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                              child:
                                                  new CircularProgressIndicator())),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        new Icon(
                                      Icons.error,
                                      color: MyColors.colorWhite,
                                    ),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.userPostsData.data[position]
                                          .userProfile.profileName,
                                      style: CTheme.textRegular18White(),
                                      textAlign: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                          model.userPostsData.data[position]
                                              .createdAt,
                                          style: CTheme.textRegular11Grey()),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: model
                                  .userPostsData.data[position].images[0].image,
                              placeholder: (context, url) => Container(
                                transform: Matrix4.translationValues(0, 0, 0),
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    height: 200,
                                    child: Center(
                                        child:
                                            new CircularProgressIndicator())),
                              ),
                              errorWidget: (context, url, error) => new Icon(
                                Icons.error,
                                size: 50,
                                color: MyColors.colorWhite,
                              ),
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  Localization.stLocalized('hashTagText'),
                                  style: CTheme.textRegular14LogoOrange(),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: SizedBox(
                              height: 65,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      model.userPostsData.data[position]
                                          .description,
                                      style: CTheme.textRegular14White(),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30, left: 15, right: 15, bottom: 15),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: MyColors.colorRedPlay,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Icon(
                                        Icons.favorite,
                                        color:
                                            listOfLikeAndCountForPost[position]
                                                    ['isLiked']
                                                ? MyColors.colorRedPlay
                                                : MyColors.colorWhite,
                                        size: 20,
                                      ),
                                      onTap: () {
                                        onTapClicked = true;
                                        print(listOfLikeAndCountForPost.length);
                                        listOfLikeAndCountForPost[position]
                                            .update(
                                                'isLiked',
                                                (value) => value =
                                                    !listOfLikeAndCountForPost[
                                                        position]['isLiked']);

                                        if (!listOfLikeAndCountForPost[position]
                                                ['isLiked'] ==
                                            true) {
                                          listOfLikeAndCountForPost[position]
                                              .update(
                                                  'likeCount',
                                                  (value) => value =
                                                      listOfLikeAndCountForPost[
                                                                  position]
                                                              ['likeCount'] -
                                                          1);
                                        }
                                        if (!listOfLikeAndCountForPost[position]
                                                ['isLiked'] ==
                                            false) {
                                          listOfLikeAndCountForPost[position]
                                              .update(
                                                  'likeCount',
                                                  (value) => value =
                                                      (listOfLikeAndCountForPost[
                                                                  position]
                                                              ['likeCount']) +
                                                          1);
                                        }
                                        print(listOfLikeAndCountForPost.length);
                                        callLikeApi(model, position);
                                        setState(() {
                                          listOfLikeAndCountForPost;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        listOfLikeAndCountForPost[position]
                                                ['likeCount']
                                            .toString(),
                                        style: CTheme.textRegular11White(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Icon(
                                        Icons.mode_comment,
                                        color: MyColors.colorWhite,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        model.userPostsData.data[position]
                                            .postCommentsCount
                                            .toString(),
                                        style: CTheme.textRegular11White(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Icon(
                                        Icons.share,
                                        color: MyColors.colorWhite,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        model.userPostsData.data[position]
                                            .isShareCount
                                            .toString(),
                                        style: CTheme.textRegular11White(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: MyColors.colorRedPlay,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: MyColors.colorWhite,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Icon(
                                          Icons.flag,
                                          color: MyColors.colorRedPlay,
                                          size: 15,
                                        ),
                                      ),
                                      onTap: () {
                                        reportPost(context, model, position);
                                      },
                                    ),
                                  ],
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
            ),
          ),
        );
      },
    );
  }

  reportPost(
      BuildContext context, ProfileHomeViewModel model, int position) async {
    CustomDialogs.showCommentDialog(
        context: context,
        controller: reportTC,
        btn1Text: 'Cancel',
        btn2Text: 'Submit',
        labelText: 'Reason',
        onDialogAddPressed: () async {
          if (reportTC.text.trim().length != 0) {
            CTheme.showCircularProgressDialog(context);
            await model.reportPost({"comment": reportTC.text},
                postId: model.userPostsData.data[position].postId.toString());

            if (model.postReportingSuccess) {
              reportTC.clear();
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              CTheme.showAppAlertOneButton(
                "Okay",
                context: context,
                title: 'Comment Error',
                bodyText: "Error submitting report",
              );
            }
          } else {
            CTheme.showAppAlertOneButton(
              "Okay",
              context: context,
              title: 'Report Error',
              bodyText: "No reason given for report",

            );
          }
        });
  }

  Future callLikeApi(ProfileHomeViewModel model, int position) async {
    await model.postActivities({
      "post_id": model.userPostsData.data[position].postId,
      "is_like": "${listOfLikeAndCountForPost[position]['isLiked']}",
      "is_share": "false",
      "is_favourite": "false"
    });
    if (model.postActivitySuccess)
      onTapClicked = false;
    else
      onTapClicked = false;
  }

  Widget itemFriendsList(ProfileHomeViewModel model, int position) {
    return GestureDetector(
      onTap: () async {
        var userId = await getCurrentUserId();
        Navigator.pushNamed(context, '/view_profile', arguments: {
          "userData": model.friendListData.data[position],
          "currentUserId": userId
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 40,
                width: 40,
                child: DottedBorder(
                  dashPattern: [3],
                  borderType: BorderType.Circle,
                  color: MyColors.orangeStory,
                  strokeWidth: 2,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/list_image/image_list_model.png'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  model.friendListData.data[position].profileName,
                  style: CTheme.textRegular11White(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCategoryRow(int position, ProfileHomeViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => {
                  setState(() {
                    tappedIndexRow1 = position;
                  })
                },
                child: Text(
                  model.categoriesData.data[position].name,
                  style: tappedIndexRow1 == position
                      ? CTheme.textRegular25White()
                      : CTheme.textRegular25blue(),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCategoryRow2(int position) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => {
                  setState(() {
                    tappedIndexRow2 = position;
                  })
                },
                child: Text(
                  'Trending',
                  style: tappedIndexRow2 == position
                      ? CTheme.textRegular25White()
                      : CTheme.textRegular25blue(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemSuggestedFriendRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 135,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        'assets/images/list_image/image_list_model.png'),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: MyColors.colorRedPlay, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              'assets/images/list_image/image_list_model.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      'Edgars',
                      style: CTheme.textRegular11White(),
                    ),
                  )
                ],
              ),
            ),
          )
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

  Future<String> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Globals.profileId);
  }

  void getSuggestedFriends(ProfileHomeViewModel model) {}
}
