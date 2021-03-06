import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/services/firebase/notificationController.dart';
import 'package:app_one/utils/full_photo_view/fullphoto.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupChat extends StatefulWidget{
  Map<String,dynamic> groupData;

  GroupChat({this.groupData});

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}


class _GroupChatScreenState extends State<GroupChat> {
  var radioValue;
  double halfScreenSize;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController msgTextController = TextEditingController();
  ScrollController chatListScrollController = ScrollController();
  String messageType = 'Text';
  bool _isLoading = false;
  var messageOptionsVisibility = false;
  Color backgroundColorOnMsgOptions = Color(0xFF4FC3F7);

  var tappedIndexOfItem;

  Map<String,dynamic> selectedMsgItem;

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    halfScreenSize=MediaQuery.of(context).size.width/1.5;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //ListView For Chat
            Column  (
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 140,bottom: 50),
                    child:StreamBuilder<QuerySnapshot>(
                      stream:FirebaseFirestore.instance.
                      collection('groupMessages').doc(widget.groupData['id'])
                          .collection('messages')
                          .orderBy('datetime',descending: true)
                          .snapshots(),
                      builder: (context,snapshot)
                      {
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
                                    ?setItemByUser(position,snapshot.data)
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
                                        Navigator.pushNamed(context,
                                            '/group_settings',
                                            arguments:widget.groupData)
                                      },
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.groupData['groupImg'],
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
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(widget.groupData['groupName'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                            ),
                                            textAlign: TextAlign.start,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

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
                            if(selectedMsgItem['senderID']==
                                FirebaseAuth.instance.currentUser.uid)
                              {
                                FirebaseFirestore.instance
                                    .collection('groupMessages')
                                    .doc(widget.groupData['id'])
                                    .collection('messages')
                                    .doc(selectedMsgItem['messageId'])
                                    .delete()
                                    .whenComplete(() => {
                                  print('Document Deleted Succefully'),
                                })
                                    .catchError((error) =>
                                {print("Error Deleting: $error"),
                                  _showDialog('Error: $error')
                                })
                              }
                            else
                              {
                                _showDialog('Messages Of Other Users Cannot '
                                    'Be Deleted')
                              }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Text Message Field
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users')
              .doc(FireBaseService.getCurrentUserUid()).snapshots(),
              builder: (context,currentUserSnapshot){
                return Column(
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
                                  PickImageController.instance.cropImageFromFile().then((croppedFile) {
                                    if (croppedFile != null) {
                                      setState(() {
                                        messageType = 'Image'; _isLoading = true; });
                                      _saveUserImageToFirebaseStorage(croppedFile);
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
                                  if(msgTextController.text.isNotEmpty)
                                    {
                                      sendMessageInGroup(currentUserSnapshot:
                                      currentUserSnapshot.data),
                                    }
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
                );
              },
            )
          ],
        )
    );
  }

  Widget itemLeft(int position,QuerySnapshot snapshot){
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
                                snapshot.docs[position].get('senderName'),
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
                      snapshot.docs[position].get('datetime')!= null?
                      DateFormat.jm().format(snapshot.docs[position].get('datetime')
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
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5,top: 5,bottom: 5),
                    child: Text(
                      snapshot.docs[position].get('senderName'),
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
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 5,bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      snapshot.docs[position].get('datetime')!= null?
                      DateFormat.jm().format(snapshot.docs[position].get('datetime')
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
    );
  }

  Widget itemRight(int position,QuerySnapshot snapshot){
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
                      snapshot.docs[position].get('datetime')!= null?
                      DateFormat.jm().format(snapshot.docs[position].get('datetime')
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
                              Stack(
                                children: [
                                  Visibility(
                                    visible: false,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Icon(
                                      Icons.done_all,
                                      color: Colors.orangeAccent,
                                      size: 10,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
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
                          ? snapshot.docs[position].get('datetime') !=
                          null
                          ? DateFormat.jm().format(snapshot
                          .docs[position]
                          .get('datetime')
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
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  width: halfScreenSize,
                  height: halfScreenSize,
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: true,
                    child: Icon(
                      Icons.done_all,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget setItemByUser(int position,QuerySnapshot snapshot) {
    if(snapshot.docs[position].get('senderID') ==
        FirebaseAuth.instance.currentUser.uid)
    {
      return itemRight(position,snapshot);
    }
    else
    {
      return itemLeft(position,snapshot);
    }
  }

  sendMessageInGroup({String imageUrl,DocumentSnapshot currentUserSnapshot}) async {
    String msgText = msgTextController.text;
    msgTextController.clear();
    var message;
    var senderName;
    var uniqueDocId = FirebaseFirestore.instance.
    collection('groupMessages').doc(widget.groupData["id"])
        .collection('messages').doc().id;

    if(messageType == 'Image')
    {
      msgText = '(Image)';
      message=
        {
          "datetime": FieldValue.serverTimestamp(),
          "messageId": uniqueDocId,
          "message": imageUrl,
          "msgseen": false,
          "receiver": widget.groupData["id"],
          "senderID": FirebaseAuth.instance.currentUser.uid,
          "senderName": currentUserSnapshot.get('name'),
          "type": messageType
      };
    }
    else
    {
      messageType = 'Text';
      message = {
        "datetime": FieldValue.serverTimestamp(),
        "messageId": uniqueDocId,
        "message": msgText,
        "messageStarred": false,
        "msgseen": false,
        "receiver": widget.groupData["id"],
        "senderID": FirebaseAuth.instance.currentUser.uid,
        "senderName": currentUserSnapshot.get('name'),
        "type": messageType
      };
    }
    await FirebaseFirestore.instance.collection('groupMessages')
        .doc(widget.groupData["id"]).collection('messages')
        .doc(uniqueDocId).set(message).whenComplete(() =>{
      print('Message Sent'),
      chatListScrollController.jumpTo(0.0),
      FirebaseFirestore.instance.collection('groups')
          .doc(widget.groupData["id"]).get().then((value) => {
        value.get('members').asMap().forEach((index,element) {
          FirebaseFirestore.instance.collection('users')
              .doc(element).get().then((value) => {
            sendNotificationMessageToPeerUser(value,index,msgText,messageType),
          });
        }),
      })
    });
  }
  //
  Future sendNotificationMessageToPeerUser(DocumentSnapshot value,int index,
      String msgText,String msgType)
  async{
    await NotificationController.instance.
    sendNotificationMessageToPeerUser(
        0,
        msgType,
        "${value.get('name')}: $msgText",
        widget.groupData['groupName'],
        widget.groupData['groupName'],
        value.get('fcmToken'));
        index == widget.groupData['members'].length-1
        ?msgTextController.clear(): msgTextController.text;
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

  Future<void> _saveUserImageToFirebaseStorage(croppedFile) async {
    try {
      FirebaseStorage.instance.ref()
          .child('groupChatImages/${widget.groupData["id"]}/')
          .putFile(croppedFile).onComplete.then((value) =>
      {
        value.ref.getDownloadURL().then((value) => {

          sendMessageInGroup(imageUrl:value.toString())
        })

      });
    }catch(e) {
      _showDialog('Error add user image to storage');
    }
  }
}