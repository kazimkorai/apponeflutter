import 'dart:io';
import 'dart:ui';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/utils/full_photo_view/fullphoto.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:app_one/viewmodel/onoToOne_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneToOneChatBox extends StatefulWidget  {

  final String chatWithUserId;

  OneToOneChatBox({this.chatWithUserId});


  @override
  _OneToOneChatBoxScreenState createState() => _OneToOneChatBoxScreenState();


}


class _OneToOneChatBoxScreenState extends State<OneToOneChatBox> with WidgetsBindingObserver{

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var radioValue;
  double halfScreenSize;
  TextEditingController msgTextController = TextEditingController();
  ScrollController chatListScrollController = ScrollController();
  String messageType = 'Text';
  var messageOptionsVisibility = false;
  Color backgroundColorOnMsgOptions = Color(0xFF4FC3F7);
  var tappedIndexOfItem;
  Map<String,dynamic> selectedMsgItem;
  File imageFile;
  String chatType='Followers';


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    addCurrentChatRoomId();
    super.initState();
    print("oneToOneChatBox");
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    removeCurrentChatRoomId();
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state)  {
    if(state== AppLifecycleState.paused)
    {
      removeCurrentChatRoomId();
      if(WidgetsBinding.instance != null)
        {
          // WidgetsBinding.instance.removeObserver(this);
          print(WidgetsBinding.instance);
        }
    }
    if(state== AppLifecycleState.resumed)
    {
      addCurrentChatRoomId();
      if(WidgetsBinding.instance == null)
        {
          WidgetsBinding.instance.addObserver(this);
        }
    }
    super.didChangeAppLifecycleState(state);
  }


  @override
  Widget build(BuildContext context) {
    halfScreenSize=MediaQuery.of(context).size.width/1.5;
    return BaseView<OneToOneViewModel>(
      onModelReady: (model) async {

      },
      builder: (context, model, child) => chatView(context, model),
    );
  }
  Scaffold chatView(BuildContext context,OneToOneViewModel model) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: StreamBuilder<DocumentSnapshot>(
        stream:FirebaseFirestore.instance.collection('users')
            .doc(widget.chatWithUserId)
            .snapshots(),
        builder: (context,chatToUserSnapshot){
          return Stack(
            children: [
              //ListView For Chat
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 140,bottom: 50),
                      child:StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('oneToOneChat')
                            .doc("${FireBaseService.getCurrentUserUid()}-"
                            "${chatToUserSnapshot.data.get('userId')}")
                            .collection('messages')
                            .orderBy('sentTime',descending: true)
                            .snapshots(),
                        builder: (context,snapshot)
                        {
                          if(snapshot.hasData){
                            for(var data in snapshot.data.docs){
                              if(data.get('receiver')==
                                  FirebaseAuth.instance.currentUser.uid
                                  &&data.get('msgSeen')== false)
                              {
                                var msgForOther = data.get('messageId');
                                if(data.reference!=null)
                                {
                                  FirebaseFirestore.instance
                                      .runTransaction((transaction)async{
                                    transaction.update(data.reference,
                                        {'msgSeen':true});

                                   var messageDoc= FirebaseFirestore.instance
                                        .collection('oneToOneChat')
                                        .doc("${chatToUserSnapshot.data.get('userId')}-"
                                        "${FireBaseService.getCurrentUserUid()}")
                                        .collection("messages")
                                        .doc(msgForOther);
                                   if(messageDoc!=null){
                                    messageDoc.update(
                                    {'msgSeen':true});
                                   }
                                  }
                                  );
                                }
                              }
                            }
                          };
                          return Container(
                            child: ListView.builder(
                                reverse: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.hasData?
                                snapshot.data.docs.length
                                    :0,
                                shrinkWrap: true,
                                controller: chatListScrollController,
                                itemBuilder: (context,position){
                                  return snapshot.hasData
                                      ?setItemByUser(position,snapshot.data,
                                  chatToUserSnapshot.data)
                                      :Center(child: LinearProgressIndicator());
                                }),
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
              //Top Group Icon Name
              Stack(
                children: [
                  Container(
                    height: 145,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 1)
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40,left: 20),
                          child: GestureDetector(
                            onTap: () => {},
                            child: Container(
                              color: Colors.blueGrey,

                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: ()=>{
                                        Navigator.pushNamed(context, '/single_chat_settings',
                                        arguments: widget.chatWithUserId)
                                        },
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  chatToUserSnapshot.hasData?Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child:chatToUserSnapshot.data.get('userImageUrl').toString()!=""? CachedNetworkImage(
                                            imageUrl: chatToUserSnapshot.data.get('userImageUrl'),
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
                                          ):CircleAvatar(),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(chatToUserSnapshot.data.get('name'),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white
                                              ),
                                              textAlign: TextAlign.start,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ):
                                  Container(),

                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Visibility(
                    visible: messageOptionsVisibility,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      height: 145,
                      padding: EdgeInsets.only(left: 20,right: 20),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(2),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: ()=>{
                              setState((){
                                messageOptionsVisibility = false;
                                backgroundColorOnMsgOptions = Colors.transparent;
                              })
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.all(2),
                            icon: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: ()=>{
                              FirebaseFirestore.instance.collection('users')
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .collection('starredMessages')
                                  .doc(selectedMsgItem['messageId'])
                                  .set(selectedMsgItem).whenComplete(() => {
                                print('Message Starred'),
                                setState(() {
                                  messageOptionsVisibility = false;
                                  backgroundColorOnMsgOptions =
                                      Colors.transparent;
                                })
                              })
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.all(2),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: ()=>{
                              setState((){
                                messageOptionsVisibility = false;
                                backgroundColorOnMsgOptions = Colors.transparent;
                              }),
                              ///Delete Group Message Code
                                  FirebaseFirestore.instance
                                      .collection('oneToOneChat')
                                      .doc("${FireBaseService.getCurrentUserUid()}-"
                                      "${chatToUserSnapshot.data.get('userId')}")
                                      .collection('messages')
                                      .doc(selectedMsgItem['messageId'])
                                      .delete()
                                      .whenComplete(() => {
                                    CTheme.showAppAlertOneButton(   "Okay",context: context,
                                    title: 'Message Deleted',
                                    bodyText: 'Message Successfully Deleted',

                                    ),
                                  })
                                      .catchError((error) =>
                                  {print("Error Deleting: $error"),
                                    _showDialog('Error: $error')
                                  })
                              //   }
                              // else
                              //   {
                              //     _showDialog('Messages Of Other Users Cannot '
                              //         'Be Deleted')
                              //   }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //Text Message Field
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin:EdgeInsets.only(left: 5,right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: msgTextController,
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 15,right: 90,bottom: 10,top: 10)
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){
                                PickImageController.instance.cropImageFromFile()
                                    .then((croppedFile) async{
                                  if (croppedFile != null) {
                                    setState(() {
                                      messageType = 'Image';
                                    });
                                     imageFile = croppedFile;
                                    model.sendMessage(
                                        imageFile: imageFile,
                                        msgType: messageType,
                                        chatToUserId:chatToUserSnapshot.data.get('userId'),
                                      peerUserToken: chatToUserSnapshot.data.get('fcmToken'),
                                      senderName: chatToUserSnapshot.data.get('name')
                                    );
                                  }else {
                                    // _showDialog('No Image Selected');
                                  }
                                });
                              },
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerRight,
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: ()=>{
                                messageType = 'Text',
                                model.sendMessage(
                                  chatToUserId:chatToUserSnapshot.data.get('userId'),
                                  msgTxt: msgTextController.text,
                                  msgType: messageType,
                                  peerUserToken:chatToUserSnapshot.data.get('fcmToken'),
                                    senderName: chatToUserSnapshot.data.get('name')

                                ),
                                msgTextController.clear(),
                              },
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              iconSize: 20,
                              icon: Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              )
            ],
          );
        },
      )

  );
  }

  Widget itemLeft(int position,QuerySnapshot snapshot,
      DocumentSnapshot chatToUserSnapshot){
    return snapshot.docs[position].get('type')=='Text'
        ?GestureDetector(
      onLongPress: ()=>{
        setState((){
          backgroundColorOnMsgOptions = Color(0xFF4FC3F7);
          messageOptionsVisibility = true;
          tappedIndexOfItem = position;
          selectedMsgItem = snapshot.docs[position].data();
        })
      },
      child: Container(
        color: tappedIndexOfItem== position
            ?backgroundColorOnMsgOptions:Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 5,
              child: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color:Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10,top: 7,bottom: 7),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                chatToUserSnapshot.get('name'),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orangeAccent
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                              child: Text(
                                snapshot.docs[position].get('message'),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                ),

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 5,bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      snapshot.docs[position].get('sentTime')!= null?
                      DateFormat.jm().format(snapshot.docs[position].get('sentTime')
                          .toDate()) :'fetching',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    )
        :GestureDetector(
      onLongPress: ()=>{
        setState((){
          backgroundColorOnMsgOptions = Color(0xFF4FC3F7);
          messageOptionsVisibility = true;
          tappedIndexOfItem = position;
          selectedMsgItem = snapshot.docs[position].data();

        })
      },
      child: Container(
        color: tappedIndexOfItem== position
            ?backgroundColorOnMsgOptions:Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10,left: 10),
                  width: halfScreenSize,
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5,top: 5,bottom: 5),
                    child: Text(
                      chatToUserSnapshot.get('name'),
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,bottom: 10),
                  width:halfScreenSize,
                  height: halfScreenSize,
                  child:  GestureDetector(
                    onTap: ()=>{
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          FullPhoto(url: snapshot.docs[position].get('message'))))
                    },
                    child: ClipRRect(
                      borderRadius:BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)
                      ),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.docs[position].get('message'),
                        placeholder: (context, url) => Container(
                          transform:
                          Matrix4.translationValues(0, 0, 0),
                          child: Container(
                              width: halfScreenSize,
                              height: halfScreenSize,
                              child: Center(
                                  child:
                                  new CircularProgressIndicator())),
                        ),
                        errorWidget: (context, url, error) =>
                        new Icon(Icons.error),
                        width: halfScreenSize,
                        height: halfScreenSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget itemRight(int position,QuerySnapshot snapshot){
    print("Message read Status ${snapshot.docs[position].get('msgSeen')}");
    return snapshot.docs[position].get('type')=='Text'
        ?GestureDetector(
      onLongPress: ()=>{
        setState((){
          backgroundColorOnMsgOptions = Color(0xFF4FC3F7);
          messageOptionsVisibility = true;
          tappedIndexOfItem = position;
          selectedMsgItem = snapshot.docs[position].data();
        })
      },
      child: Container(
        color: tappedIndexOfItem== position
            ?backgroundColorOnMsgOptions:Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(
              flex: 1,
            ),

            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 5,bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      snapshot!=null?
                      snapshot.docs[position].get('sentTime')!= null?
                      DateFormat.jm().format(snapshot.docs[position].get('sentTime')
                          .toDate()) :'sending':'fetching',
                      style:TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Flexible(
              flex: 5,
              child: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color:Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(right: 10,top: 7,bottom: 7),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 0,top: 10),
                              child: Text(
                                snapshot.docs[position].get('message'),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),


                        Padding(
                          padding: const EdgeInsets.only(right: 5,bottom: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              snapshot.docs[position].get('msgSeen')== false
                                  ? Visibility(
                                visible: true,
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              )
                                  : Visibility(
                                visible: true,
                                child: Icon(
                                  Icons.done_all,
                                  color: Colors.orangeAccent,
                                  size: 10,
                                ),
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        :GestureDetector(
      onLongPress: ()=>{
        setState((){
          backgroundColorOnMsgOptions = Color(0xFF4FC3F7);
          messageOptionsVisibility = true;
          tappedIndexOfItem = position;
          selectedMsgItem = snapshot.docs[position].data();
        })
      },
      child: Container(
        color: tappedIndexOfItem== position
            ?backgroundColorOnMsgOptions:Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      snapshot != null
                          ? snapshot.docs[position].get('sentTime') !=
                          null
                          ? DateFormat.jm().format(snapshot
                          .docs[position]
                          .get('sentTime')
                          .toDate())
                          : 'sending'
                          : 'fetching',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  width: halfScreenSize,
                  height: halfScreenSize,
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullPhoto(
                                  url: snapshot.docs[position]
                                      .get('message')))),
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.docs[position].get('message'),
                        placeholder: (context, url) => Container(
                          transform: Matrix4.translationValues(0, 0, 0),
                          child: Container(
                              width: halfScreenSize,
                              height: halfScreenSize,
                              child: Center(
                                  child: new CircularProgressIndicator())),
                        ),
                        errorWidget: (context, url, error) =>
                        new Icon(Icons.error),
                        width: halfScreenSize,
                        height: halfScreenSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  width: halfScreenSize,
                  height: halfScreenSize,
                  alignment: Alignment.bottomRight,
                  child:  snapshot.docs[position].get('msgSeen')== false
                      ? Visibility(
                    visible: true,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                      : Visibility(
                    visible: true,
                    child: Icon(
                      Icons.done_all,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                  ),
                )
              ] ,
            ),
          ],
        ),
      ),
    );

  }

  Widget setItemByUser(int position,QuerySnapshot snapshot,
      DocumentSnapshot chatToUserSnapshot) {
    print("Doc Id is : ${snapshot.docs[position].get('sender')}");
    if(snapshot.docs[position].get('sender') ==
       FireBaseService.getCurrentUserUid())
    {
      return itemRight(position,snapshot);
    }
    else
    {
      return itemLeft(position,snapshot,chatToUserSnapshot);
    }
  }


  _showDialog(String msg){
    showDialog(
        context: context,
        builder:(context) {
          return AlertDialog(
            content: Text(msg),
          );
        }
    );
  }

  void removeCurrentChatRoomId()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Globals.currentChatRoomId, 'None');
    print("From Remove OneToOne ChatRoomId: "
        "${ prefs.getString(Globals.currentChatRoomId)}");
  }
  void addCurrentChatRoomId()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Globals.currentChatRoomId, widget.chatWithUserId);
    print("FromAdd OneToOne ChatRoomId: "
        "${ prefs.getString(Globals.currentChatRoomId)}");
  }


}