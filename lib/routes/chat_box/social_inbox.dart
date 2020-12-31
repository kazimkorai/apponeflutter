import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SocialInbox extends StatefulWidget {

  @override
  _SocialInboxScreenState createState() => _SocialInboxScreenState();
}


class _SocialInboxScreenState extends State<SocialInbox> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  bool chatToUserVisibility= true;

  bool groupListVisibility = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Globals.currentRoute = '/profile_home';
        print(Globals.currentRoute);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: DrawerMain(context: context,),
        endDrawer: DrawerRight(context: context,),
        backgroundColor: MyColors.colorDarkBlack,
        bottomNavigationBar: MyBottomNavigationBar(context: context,
        scaffoldKey: scaffoldKey,),
        body: BaseScrollView().baseView(context, [

          Padding(
            padding: EdgeInsets.only(top: 50,left:15,right: 15),
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
                              )
                            ),
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
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: MyColors.colorWhite,
                        ),
                        onPressed: ()=>{
                          if(chatToUserVisibility&&!groupListVisibility)
                            {
                              Navigator.pushNamed(context,'/chat_with_new_user')

                            },
                          if(groupListVisibility&&!chatToUserVisibility)
                            {
                              Navigator.pushNamed(context, '/create_group')

                            }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: ()=>{
                      setState((){
                        chatToUserVisibility=true;
                        groupListVisibility = false;
                      })
                    },
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      color: MyColors.appBlue,
                      child: Text(
                          'Followers',
                        style:chatToUserVisibility?CTheme.textRegular16LogoOrange()
                            :CTheme.textRegular16White(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: ()=>{
                        setState((){
                          chatToUserVisibility = false;
                          groupListVisibility = true;
                        })
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        color: MyColors.appBlue,
                        child: Text(
                            'Groups',
                          style:groupListVisibility?CTheme.textRegular16LogoOrange()
                              :CTheme.textRegular16White(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          chatToUserVisibility
              ?StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users')
                .doc(FireBaseService.getCurrentUserUid())
                .collection("chattedWith").orderBy("lastMessageTime",descending:true)
                .snapshots(),
            builder: (context,usersListSnapshot){
              return Visibility(
                visible: chatToUserVisibility,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child:ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: usersListSnapshot.hasData
                          ?usersListSnapshot.data.docs.length
                      :0,
                      shrinkWrap: true,
                      itemBuilder: (context,position){
                        if(usersListSnapshot.hasData) {
                                return itemSocialMessageRow(
                                    usersListSnapshot.data, position);
                              } else{
                          return Container();
                        }
                            }),
                ),
              );
            },
          )
              :StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').
            doc(FireBaseService.getCurrentUserUid()).collection('groupsIn')
                .snapshots(),
            builder: (context,groupListSnapshot){
              return Visibility(
                visible: groupListVisibility,
                child: groupListSnapshot.hasData
                    ?groupListSnapshot.data.docs.isNotEmpty
                    ?Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child:ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: groupListSnapshot.hasData
                          ?groupListSnapshot.data.docs.length
                          :0,
                      shrinkWrap: true,
                      itemBuilder: (context,position){
                          return StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.collection('groups')
                            .doc(groupListSnapshot.data.docs[position].id)
                            .snapshots(),
                            builder: (context,groupDataSnapshot){
                              if(groupDataSnapshot.hasData&&groupDataSnapshot.data.data()!=null)
                                {
                                  return itemGroupMessageRow(groupDataSnapshot.data,
                                      position);
                                }
                              else{
                                return Container();
                              }

                            },
                          );

                      }),
                )
                :Container()
                    :Container(),
              );
            },
          ),
        ]),
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

  Widget itemSocialMessageRow(QuerySnapshot userListSnapshot,int position) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').
      doc(userListSnapshot.docs[position].id).snapshots(),
      builder: (context,userDataSnapshot){
        return Padding(
          padding: const EdgeInsets.only(top: 2),
          child: GestureDetector(
            onTap: ()=>{
              Navigator.pushNamed(context,'/one_to_one_chatbox',
                  arguments:userListSnapshot.docs[position].id)
            },
            child: userListSnapshot!=null&&
                userDataSnapshot.data!=null
                ?StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('oneToOneChat')
                  .doc("${FireBaseService.getCurrentUserUid()}-"
                  "${userListSnapshot.docs[position].id}")
                  .collection('messages')
                  .orderBy('sentTime',descending: true)
                  .snapshots(),
              builder: (context,latestMsgSnapshot)
              {
                return Container(
                  color: MyColors.appBlue,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: userListSnapshot!=null&&
                                  userDataSnapshot.data.data().
                                  containsKey('userImageUrl')
                                  ?CachedNetworkImage(
                                imageUrl: userDataSnapshot.data
                                    .get('userImageUrl'),
                                placeholder: (context, url) => Container(
                                  transform:
                                  Matrix4.translationValues(0, 0, 0),
                                  child: Container(width: 40,height: 40,
                                      child: Center(child:new CircularProgressIndicator())),),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                                width: 40,height: 40,fit: BoxFit.cover,
                              )
                                  :Container(
                                decoration: BoxDecoration(
                                    color: MyColors.colorWhite,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userListSnapshot.docs.isNotEmpty&&
                                    userDataSnapshot.data.data().containsKey('name')
                                    ?userDataSnapshot.data.get('name')
                                    :'',
                                  style: CTheme.textRegular16White(),
                                  textAlign: TextAlign.start,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10,),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width/1.5,
                                    child: Text(latestMsgSnapshot.hasData&&
                                        latestMsgSnapshot.data!=null
                                        ? latestMsgSnapshot.data.docs.isNotEmpty
                                        ?latestMsgSnapshot.data.docs[0].get('type')
                                        =="Text"
                                        ?latestMsgSnapshot.data.docs[0].get('message')
                                        :'(Image)'
                                        :'Start Conversation'
                                        :'',
                                        overflow: TextOverflow.ellipsis,
                                        style: CTheme.textRegular11White()),
                                  ),
                                ),
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
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    latestMsgSnapshot!=null&&latestMsgSnapshot.hasData?
                                    latestMsgSnapshot.data.size>0&&
                                        latestMsgSnapshot.data.docs[0].get('sentTime')!=null?
                                    DateFormat.jm().format(latestMsgSnapshot.data.docs[0].get('sentTime')
                                        .toDate()) :'':'',
                                    style: CTheme.textRegular11White(),
                                    textAlign: TextAlign.start,),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('oneToOneChat')
                                        .doc("${FireBaseService.getCurrentUserUid()}-"
                                        "${userDataSnapshot.data.get('userId')}")
                                        .collection('messages')
                                        .where('msgSeen',isEqualTo: false)
                                        .where('sender',isEqualTo:userDataSnapshot.data.get('userId'))
                                        .snapshots(),
                                    builder: (context,unreadMsgSnapshot){
                                      return  Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Stack(
                                          children: [
                                            unreadMsgSnapshot.hasData&&
                                                unreadMsgSnapshot.data.docs.length>0
                                                ?Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: MyColors.colorLogoOrange,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  unreadMsgSnapshot.data.docs.length.toString(),
                                                  style: CTheme.textRegular11White(),
                                                ),
                                              ),
                                            )
                                                :Container()
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                );
              },
            )
                :Container(),
          ),
        );
      },
    );
  }

  Widget itemGroupMessageRow(DocumentSnapshot groupDataSnapshot,int position) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: GestureDetector(
        onTap: ()=>{
          Navigator.pushNamed(context,'/group_chat',
              arguments:groupDataSnapshot.data())
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('groupMessages')
              .doc(groupDataSnapshot.get('id')).collection("messages")
              .orderBy('datetime',descending: true)
              .snapshots(),
          builder: (context,groupLastMessageSnapshot){
            return  Container(
              color: MyColors.appBlue,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: groupDataSnapshot.data()!=null
                              ?CachedNetworkImage(
                            imageUrl: groupDataSnapshot.get('groupImg'),
                            placeholder: (context, url) => Container(
                              transform:
                              Matrix4.translationValues(0, 0, 0),
                              child: Container(width: 40,height: 40,
                                  child: Center(child:new CircularProgressIndicator())),),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                            width: 40,height: 40,fit: BoxFit.cover,
                          )
                              :Container(
                            decoration: BoxDecoration(
                                color: MyColors.colorWhite,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(groupDataSnapshot.data()!=null
                                ?groupDataSnapshot.get('groupName')
                                :'',
                              style: CTheme.textRegular15White(),
                              textAlign: TextAlign.start,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child:  Text(groupLastMessageSnapshot.hasData&&
                                  groupLastMessageSnapshot.data!=null
                                      ? groupLastMessageSnapshot.data.docs.isNotEmpty
                                      ?groupLastMessageSnapshot.data.docs[0].get('type')
                                      =="Text"
                                      ?groupLastMessageSnapshot.data.docs[0].get('message')
                                      :'(Image)'
                                      :'Start Conversation'
                                      :'',
                                      overflow: TextOverflow.ellipsis,
                                      style: CTheme.textRegular11White()),
                            ),
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
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                          Text(
                          groupLastMessageSnapshot!=null&&groupLastMessageSnapshot.hasData?
                          groupLastMessageSnapshot.data.size>0?
                          DateFormat.jm().format(groupLastMessageSnapshot.data.docs[0]
                              .get('datetime')
                              .toDate()) :'':'',
                          style: CTheme.textRegular11White(),
                          textAlign: TextAlign.start,),
                              ///Group Unread Message To be Done.
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 5),
                              //   child: Container(
                              //             height: 20,
                              //             width: 20,
                              //             decoration: BoxDecoration(
                              //                 color: MyColors.colorLogoOrange,
                              //                 borderRadius: BorderRadius.circular(20)
                              //             ),
                              //             child: Center(
                              //               child: Text(
                              //                 '1',
                              //                 style: CTheme.textRegular11White(),
                              //               ),
                              //             ),
                              //           )
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

}