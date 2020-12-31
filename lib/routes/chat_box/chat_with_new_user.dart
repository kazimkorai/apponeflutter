import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatWithNewUser extends StatefulWidget {
  @override
  _ChatWithNewUserAppState createState() => _ChatWithNewUserAppState();
}

class _ChatWithNewUserAppState extends State<ChatWithNewUser> {
  TextEditingController searchController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Set _saved = Set();
  List<String> listOfUserNames=[];
  List<Map<String,dynamic>> listOfUsersForGroup=[];
  List<Map<String,dynamic>> listOfUsersData = [];
  int lengthOfData=0;



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
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMain(context: context,),
      endDrawer: DrawerRight(context: context,),
          backgroundColor: MyColors.colorDarkBlack,
          bottomNavigationBar: MyBottomNavigationBar(context:context,
          scaffoldKey: scaffoldKey,),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').
              orderBy('name').snapshots(),
              builder: (context,usersListSnapshot){
                if(usersListSnapshot.hasData){
              if (usersListSnapshot.data.docs.length != lengthOfData) {
                listOfUserNames = [];
                listOfUsersData = [];
                lengthOfData = usersListSnapshot.data.docs.length;
                for (var item in usersListSnapshot.data.docs) {
                  if (item.id != FireBaseService.getCurrentUserUid()) {
                    listOfUserNames
                        .add(item.get('name').toString().toUpperCase());
                    listOfUsersData.add(item.data());
                  }
                }
                print("Length of user Data ${listOfUsersData.length}");
              }
            }

            return AlphabetListScrollView(

                  normalTextStyle: CTheme.textRegular16White(),
                  strList:listOfUserNames,
                  highlightTextStyle: TextStyle(
                    color: Colors.yellow,
                  ),
                  showPreview: true,
                  itemBuilder: (context, index) {
                    return  itemRowTest(usersListSnapshot.data,index);
                  },
                  indexedHeight: (i) {
                    return 80;
                  },
                  keyboardUsage: true,
                  headerWidgetList: <AlphabetScrollListHeader>[
                    AlphabetScrollListHeader(
                        widgetList: [
                          Padding(
                            padding: EdgeInsets.only(top: 40,left:15,right: 15),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 65,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color:MyColors.searchBoxColor,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: TextField(
                                            controller: searchController,
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
                                                )
                                            ),
                                            onChanged: (text)=>{

                                            },
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
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: MyColors.colorWhite,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                          ),

                        ],
                        icon: Icon(
                            Icons.search
                        ),
                        indexedHeaderHeight: (index) => 80),
                  ],
                );
              }
          ),
        );
  }

  ListTile itemRowTest(QuerySnapshot userListSnapshot,int position) {
    print(listOfUsersData[position]['userImageUrl'].toString());
    String urlImage=    listOfUsersData[position]['userImageUrl'].toString();
    return ListTile(

      onTap: ()=>{
        Navigator.pushReplacementNamed(context, '/one_to_one_chatbox',arguments:
        listOfUsersData[position]['userId'])
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      leading:urlImage!='null'? CircleAvatar(
        backgroundImage: NetworkImage(
            listOfUsersData[position]['userImageUrl']),
      ):CircleAvatar(),
      title: Text(
        listOfUsersData[position]['name'],
        style: CTheme.textRegular16White(),
      ),
    );
  }

  Widget roundedSquareButtonAddGroup(String btnText,Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: 25,
            width: 150,
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
                  borderRadius: BorderRadius.circular(5),
                )
            ),
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
                            borderRadius: BorderRadius.circular(20)
                        ),
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

  // filterList() {
  //   List<User> users = [];
  //   users.addAll(userList);
  //   favouriteList = [];
  //   normalList = [];
  //   strList = [];
  //   if (searchController.text.isNotEmpty) {
  //     users.retainWhere((user) =>
  //         user.name
  //             .toLowerCase()
  //             .contains(searchController.text.toLowerCase()));
  //   }
  //   users.forEach((user) {
  //     if (user.favourite) {
  //       favouriteList.add(
  //         ListTile(
  //           leading: Stack(
  //             children: <Widget>[
  //               CircleAvatar(
  //                 backgroundImage:
  //                 NetworkImage("http://placeimg.com/200/200/people"),
  //               ),
  //               Container(
  //                   height: 40,
  //                   width: 40,
  //                   child: Center(
  //                     child: Icon(
  //                       Icons.star,
  //                       color: MyColors.appBlue,
  //                     ),
  //                   ))
  //             ],
  //           ),
  //           title: Text(
  //             user.name,
  //             style: CTheme.textRegular16White(),
  //           ),
  //         ),
  //       );
  //     } else {
  //       normalList.add(
  //         ListTile(
  //           leading: CircleAvatar(
  //             backgroundImage:
  //             NetworkImage("http://placeimg.com/200/200/people"),
  //           ),
  //           title: Text(
  //             user.name,
  //             style: CTheme.textRegular16White(),
  //           ),
  //         ),
  //
  //       );
  //       strList.add(user.name);
  //     }
  //   });
  //
  //   setState(() {
  //     strList;
  //     favouriteList;
  //     normalList;
  //     strList;
  //   });
  // }

}
