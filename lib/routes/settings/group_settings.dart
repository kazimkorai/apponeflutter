import 'package:app_one/utils/base_view/base_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatefulWidget {
  final Map<String,dynamic> groupData;

  GroupSettings({this.groupData});

  @override
  _GroupSettingsScreenState createState() => _GroupSettingsScreenState();
}

class _GroupSettingsScreenState extends State<GroupSettings> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  List<dynamic> listOfMembers = [];

  var userData;



  @override
  void initState() {
    listOfMembers= widget.groupData['members'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .doc(widget.groupData["id"])
              .snapshots(),
          builder: (context, snapshot) {
            return BaseScrollView().baseView(context, [
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: snapshot.hasData == false
                    ? Container()
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data.data()['groupImg'],
                    placeholder: (context, url) => Container(
                      transform: Matrix4.translationValues(0, 0, 0),
                      child: Container(
                          width: 60,
                          height: 60,
                          child: Center(
                              child: new CircularProgressIndicator())),
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
                      snapshot.hasData
                          ? snapshot.data.data()['groupName']
                          : 'Name',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Antonia Berger',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'antonia.com',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 15),
                color: Colors.white,
                height: 2,
              ),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('groupMessages')
                    .doc(widget.groupData["id"])
                    .collection('messages')
                    .where('type', isEqualTo: 'Image')
                    .snapshots(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: GestureDetector(
                        onTap: () => {},
                        child: itemSettingButton(
                            'Media',
                            snapshot.hasData
                                ? '${snapshot.data.docs.length}'
                                : '0',
                            TextStyle(fontSize: 12, color: Colors.white))),
                  );
                },
              ),

              ///Document And Links Commented.
              // Padding(
              //   padding: const EdgeInsets.only(top: 5),
              //   child: itemSettingButton('Document and Links','425',TextStyle(
              //       fontSize: 12,
              //       color: Colors.white
              //   )),
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
                        snapshot.hasData ? "${snapshot.data.docs.length}" : '0',
                        TextStyle(fontSize: 12, color: Colors.white)),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: itemSettingButton('Search Chat', '',
                    TextStyle(fontSize: 12, color: Colors.white)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: itemSettingButton('Custom Sound', '',
                    TextStyle(fontSize: 12, color: Colors.white)),
              ),

              widget.groupData["admin"]==
                  FirebaseAuth.instance.currentUser.uid
                  ?Padding(
                padding: const EdgeInsets.only(top: 5),
                child: itemSettingButton(
                    'Add Members', '', TextStyle(fontSize: 12,
                    color: Colors.white),
                        ()=>{
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) =>
                      //     AddMembers(groupData: widget.groupData)
                      // )
                      // )
                    }),
              )

                  :Container(),

              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: itemSettingButton(
                    'Mute', '', TextStyle(fontSize: 12, color: Colors.white)),
              ),

              widget.groupData["admin"]!=
                  FirebaseAuth.instance.currentUser.uid
                  ?Padding(
                padding: const EdgeInsets.only(top: 5),
                child: itemSettingButton('Leave Group', '',
                    TextStyle(color: Colors.red, fontSize: 12),
                        ()=>{
                      widget.groupData["admin"]!=FirebaseAuth.instance.currentUser.uid
                          ?leaveGroup(FirebaseAuth.instance.currentUser.uid)
                          :(){
                        deleteGroup();
                      },
                    }),
              )
                  :Padding(
                padding: const EdgeInsets.only(top: 5),
                child: itemSettingButton('Delete Group', '',
                    TextStyle(fontSize: 12, color: Colors.red),
                        ()=>{
                      widget.groupData["admin"]==FirebaseAuth.instance.currentUser.uid
                          ?deleteGroup():_showDialog('Only Admin Can Delete Group'),
                    }
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 20),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.hasData
                        ? snapshot.data.data()['members'].length
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return snapshot.hasData
                          ? itemUserInGroup(snapshot.data, position)
                          : Container();
                    }),
              ),
            ]);
          },
        ));
  }

  Widget itemUserInGroup(DocumentSnapshot snap, int position) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(snap.get('members')[position])
          .snapshots(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 2),
          child: GestureDetector(
            onTap: () => {},
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: snapshot.hasData
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.get('userImageUrl'),
                            placeholder: (context, url) => Container(
                              transform:
                              Matrix4.translationValues(0, 0, 0),
                              child: Container(
                                  width: 60,
                                  height: 60,
                                  child: Center(
                                      child:
                                      new CircularProgressIndicator())),
                            ),
                            errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.hasData
                                  ? snapshot.data.get('name')
                                  : 'Fetching',
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.start,
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
                        padding: EdgeInsets.only(right: 10, top: 5),
                        child: SizedBox(
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Visibility(
                                    visible: snapshot.hasData
                                        ? snap.get('admin') ==
                                        snapshot.data.get('userId')
                                        ? false
                                        : true
                                        : true,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: GestureDetector(
                                          onTap: () => FirebaseAuth.instance
                                              .currentUser.uid ==
                                              snap.get('admin')
                                              ? deleteUserFromGroup(
                                              snapshot.data)
                                              : _showDialog('Only Admin Can '
                                              'Delete Group Members'),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.red)),
                                            child: Icon(
                                              Icons.close,
                                              size: 15,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Visibility(
                                    visible: snapshot.hasData
                                        ? snap.get('admin') ==
                                        snapshot.data.get('userId')
                                        ? true
                                        : false
                                        : false,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              bottom: 2,
                                              right: 4,
                                              left: 4),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.greenAccent)),
                                          child: Text(
                                            'ADMIN',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.greenAccent),
                                          ),
                                        )),
                                  ),
                                ],
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
      },
    );
  }

  Widget itemSettingButton(String title, String subtitle,
      TextStyle style, [Function onTap]) {
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
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  String fetchUserInfo(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => {
          userData = value.get('name')});
    return userData.name;
  }

  deleteUserFromGroup(DocumentSnapshot snapshot) {
    print('The data is : ${snapshot.get('userId')}');
    var userToDelete = [];
    userToDelete.add(snapshot.get('userId'));
    FirebaseFirestore.instance
        .collection('groups')
        .doc(widget.groupData['id'])
        .update({'members': FieldValue.arrayRemove(userToDelete)}).whenComplete(
            () => {
          FirebaseFirestore.instance
              .collection('users')
              .doc(snapshot.get('userId'))
              .collection('groupsIn')
              .doc(widget.groupData['id'])
              .delete()
              .whenComplete(
                  () => {
                _showDialog('User Removed From Group')})
          });
  }

  leaveGroup(String currentUserId) {
    print('The data is : $currentUserId');
    var userToDelete = [];
    userToDelete.add(currentUserId);
    FirebaseFirestore.instance
        .collection('groups')
        .doc(widget.groupData['id'])
        .update({'members': FieldValue.arrayRemove(userToDelete)})
        .whenComplete(
            () => {
          FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserId)
              .collection('groupsIn')
              .doc(widget.groupData['id'])
              .delete()
              .whenComplete(
                  () =>  Navigator.pushNamedAndRemoveUntil(
                  context, "/profile_home",(route)=>false)
          )
        });
  }

  _showDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(msg),
          );
        });
  }

  deleteGroup() {
    FirebaseFirestore.instance.collection('groups')
        .doc(widget.groupData['id']).delete()
        .whenComplete(() => {
       listOfMembers.asMap().forEach((index,element) {
         FirebaseFirestore.instance
             .collection('users')
             .doc(element)
             .collection('groupsIn')
             .doc(widget.groupData['id'])
             .delete()
             .whenComplete(
                 () => {
                if(index==listOfMembers.length-1)
                  {
             Navigator.pushNamedAndRemoveUntil(
             context,'/profile_home',(route)=>false)
       }
               });


       })

    });
  }
}
