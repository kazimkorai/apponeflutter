import 'package:app_one/globals/globals.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleChatSettings extends StatefulWidget {
  final String selectedUserId;
  SingleChatSettings({this.selectedUserId});
  @override
  _SingleChatSettingsScreenState createState() => _SingleChatSettingsScreenState();
}


class _SingleChatSettingsScreenState extends State<SingleChatSettings> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    removeCurrentChatRoomId();
    printChatRoomId();
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
      backgroundColor: Colors.black,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users')
        .doc(widget.selectedUserId).snapshots(),
        builder: (context,chatToUserSnapshot){
          return  BaseScrollView().baseView(context,
              [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: chatToUserSnapshot.hasData == false
                      ? Container()
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: chatToUserSnapshot.data.data()['userImageUrl'],
                      placeholder: (context, url) => Container(
                        transform: Matrix4.translationValues(0, 0, 0),
                        child: Container(
                            width: 60,
                            height: 60,
                            child:
                            Center(child: new CircularProgressIndicator())),
                      ),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        chatToUserSnapshot.hasData
                            ?chatToUserSnapshot.data.get('name')
                        :'Fetching',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        'Antonia Berger',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 8
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text(
                        'antonia.com',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 15),
                  color: Colors.white,
                  height: 2,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                      onTap: ()=>{
                      },
                      child: itemSettingButtonCenter('View Profile',
                          TextStyle(
                              color: Colors.white,
                              fontSize: 12
                          ))),
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('oneToOneChat')
              .doc("${FireBaseService.getCurrentUserUid()}-"
               "${widget.selectedUserId}")
              .collection('messages')
                  .where('type',isEqualTo:'Image').snapshots(),
                  builder: (context,snapshot){
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: itemSettingButton('Media',
                          snapshot.hasData?snapshot.data.docs.length.toString():'0',
                          TextStyle(
                          color: Colors.white,
                          fontSize: 12)),
                    );
                  },
                ),

                ///Document And Links Commented
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: itemSettingButton('Document and Links','425',TextStyle(color: Colors.white,fontSize: 12)),
                // ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('starredMessages')
                      .snapshots(),
                  builder: (context, snapshot) {

                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: itemSettingButton(
                          'Starred Messages',
                          snapshot.hasData ? "${snapshot.data.docs.length}":'0',
                          TextStyle(fontSize: 12, color: Colors.white)),
                    );
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5),
                //   child: itemSettingButton('Starred Messages',
                //       '24',
                //       TextStyle(color: Colors.white,fontSize: 12)),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: itemSettingButton('Search Chat','',TextStyle(color: Colors.white,fontSize: 12)),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: itemSettingButton('Custom Sound','',TextStyle(color: Colors.white,fontSize: 12)),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: itemSettingButton('Share Profile','',TextStyle(color: Colors.white,fontSize: 12)),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: itemSettingButton('Mute','',TextStyle(color: Colors.white,fontSize: 12)),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: itemSettingButton('Clear Chat','',TextStyle(color: Colors.red,
                      fontSize: 12)),
                ),

                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('blockList')
                      .doc(widget.selectedUserId)
                  .snapshots(),
                  builder: (context,snapshot){
                    return snapshot.hasData
                        ?Padding(
                      padding: const EdgeInsets.only(top: 5,bottom: 30),
                      child: itemSettingButton(
                          snapshot.data.exists?'Unblock User':'Block User',
                          '',
                          TextStyle(color: Colors.red,
                              fontSize: 12),
                              ()=>{
                              snapshot.data.exists
                                  ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser.uid)
                                      .collection('blockList')
                                      .doc(widget.selectedUserId)
                                      .delete()
                                  : FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser.uid)
                                      .collection('blockList')
                                      .doc(widget.selectedUserId)
                                      .set({
                                      'blockedId': widget.selectedUserId
                                    }).whenComplete(() => {
                                            print('User Blocked'),
                                          })
                            }
                      ),
                    )
                        :Padding(
                      padding: const EdgeInsets.only(top: 5,bottom: 30),
                      child: itemSettingButton(
                          'Loading',
                          '',
                          TextStyle(color: Colors.red,
                              fontSize: 12),
                      ),
                    );
                  },
                ),
              ]);
        },

      )
    );
  }


  Widget itemSettingButton(String title,String subtitle,TextStyle style,
      [Function onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 40,
          color: Colors.blueGrey,
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
                  style: TextStyle(color: Colors.white,fontSize: 12),
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget itemSettingButtonCenter(String title,TextStyle style) {
    return Container(
      height: 40,
      color: Colors.blueGrey,
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
  void printChatRoomId() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("The Chatroom Id is: ${pref.get(Globals.currentChatRoomId)}");
  }

  void removeCurrentChatRoomId()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Globals.currentChatRoomId, 'None');
    print("SingleChatSettings ChatRoomId: "
        "${ prefs.getString(Globals.currentChatRoomId)}");
  }
}