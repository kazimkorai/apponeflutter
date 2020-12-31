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


class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupScreenAppState createState() => _CreateGroupScreenAppState();
}

class _CreateGroupScreenAppState extends State<CreateGroup> {
  List<User> userList = [];
  List<String> strList = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Set _saved = Set();
  List<String> listOfUserNames=[];
  List<Map<String,dynamic>> listOfUsersForGroup=[];

  List<Map<String,dynamic>> listOfUsersData = [];

  int lengthOfData=0;



  @override
  void initState() {
    for (var i = 0; i < 100; i++) {
      var name = faker.person.name();
      userList.add(User(name, faker.company.name(), false));
    }
    for (var i = 0; i < 4; i++) {
      var name = faker.person.name();
      userList.add(User(name, faker.company.name(), true));
    }
    userList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
    });
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
                    return  itemRowTest(index);
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
                                  padding: const EdgeInsets.only(right: 65),
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

                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: roundedSquareButtonAddGroup('Create Group', ()=>{
                              if(listOfUsersForGroup.isNotEmpty)
                              {
                                    Navigator.pushNamed(
                                        context, '/group_details',
                                        arguments: listOfUsersForGroup)
                                  }
                              else{
                                CTheme.showAppAlertOneButton(   "Okay",context: context,
                          bodyText: 'No Users Selected',
                                  title: "Select Users",handler1: (ecp)=>{
                                  Navigator.pop(context)
                                    }
                                )
                              }
                                }),
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

  ListTile itemRowTest(int position) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            listOfUsersData[position]['userImageUrl']),
      ),
      title: Text(
        listOfUsersData[position]['name'],
        style: CTheme.textRegular16White(),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 0,bottom: 0,right: 35),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: MyColors.colorWhite
          ),
          child: Checkbox(
            value: _saved.contains(position),
            onChanged: (value){
              setState(() {
                listOfUserNames;
                if(value == true){
                  _saved.add(position);
                  listOfUsersForGroup.add(listOfUsersData[position]);
                } else{
                  _saved.remove(position);
                  listOfUsersForGroup.removeWhere((element) => element["email"]==
                      listOfUsersData[position]['email']);
                }
                print("CheckBox ${listOfUsersForGroup.length}");

              });
            },
          ),
        ),
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

  filterList() {
    List<User> users = [];
    users.addAll(userList);
    favouriteList = [];
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) =>
          user.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()));
    }
    users.forEach((user) {
      if (user.favourite) {
        favouriteList.add(
          ListTile(
            leading: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                  NetworkImage("http://placeimg.com/200/200/people"),
                ),
                Container(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.star,
                        color: MyColors.appBlue,
                      ),
                    ))
              ],
            ),
            title: Text(
              user.name,
              style: CTheme.textRegular16White(),
            ),
          ),
        );
      } else {
        normalList.add(
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage("http://placeimg.com/200/200/people"),
            ),
            title: Text(
              user.name,
              style: CTheme.textRegular16White(),
            ),
          ),

        );
        strList.add(user.name);
      }
    });

    setState(() {
      strList;
      favouriteList;
      normalList;
      strList;
    });
  }

  Widget itemSearchProfile(int position,QuerySnapshot usersListSnapshot) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: GestureDetector(
        onTap: ()=> {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(40)
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: usersListSnapshot.docs[position]
                            .get('userImageUrl'),
                        placeholder: (context, url) => Container(
                          transform:
                          Matrix4.translationValues(0, 0, 0),
                          child: Container(width: 60,height: 60,
                              child: Center(child:new CircularProgressIndicator())),),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                        width: 60,height: 60,fit: BoxFit.cover,
                      ),
                    ),

                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(usersListSnapshot.docs[position]
                            .get('name'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                          textAlign: TextAlign.start,),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10,top: 5),
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Checkbox(
                                  value: _saved.contains(position),
                                  onChanged: (value){
                                    setState(() {
                                      if(value == true){
                                        _saved.add(position);
                                        // listOfUsersForGroup.add(listOfUsers[position]);
                                      } else{
                                        _saved.remove(position);
                                        // listOfUsersForGroup.remove(listOfUsers[position]);
                                      }
                                      print(listOfUsersForGroup.length);
                                    });
                                  },
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class User {
  final String name;
  final String company;
  final bool favourite;

  User(this.name, this.company, this.favourite);
}
