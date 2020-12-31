import 'dart:io';
import 'package:app_one/services/firebase/notificationController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseService{
  static String createdUserUid;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String groupCreated;


  ///Get Unique User Id.
  static String getCurrentUserUid(){
    return FirebaseAuth.instance.currentUser.uid;
  }

  ///Login User With Credentials.
  Future<String> loginUserWithEmailPassword({String email,String password})async
  {

    String loginSuccess;
    String tokenResult;

    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email,
          password: password)
          .then((value)async {
            tokenResult = await getToken();
            if(tokenResult !='Failed')
              {
                loginSuccess = 'Successful';
              }
            else
              {
                loginSuccess = 'Failed';
                FirebaseAuth.instance.signOut();
              }
          })
          .catchError((error) => {
         error = error.toString().substring(error.toString().indexOf(']')+1),
                print("The Login Error is: ${error.toString()}"),
                loginSuccess = error.toString(),
              });
    }
    catch(error){
     print(error);
    }
    return loginSuccess;
  }

  ///Create User in Auth, In Cloud Storage and Upload Profile Image in Storage.
  Future<String> createUserWithEmailPass({String email,String password, File userImageFile}) async {
    var signUpSuccess;
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
          .then((authValue) async {
        userImageFile!=null?   await FirebaseStorage().ref().child('userProfileImages/${authValue.user.uid}/').putFile(userImageFile)
          .onComplete.then((storageValue) async {

           await FirebaseFirestore.instance.collection('users')
               .doc(authValue.user.uid)
               .set({
             'userId':authValue.user.uid,
             'fcmToken':await getToken(),
             'createdAt':FieldValue.serverTimestamp(),
             'name':email.substring(0,email.indexOf('@')),
             'email':email,
             'userImageUrl':userImageFile!=null?await storageValue.ref.getDownloadURL():"",
           }).whenComplete(() => {
             signUpSuccess ='Successful'
           })
               .catchError((error)=>{
             error = error.toString().substring(error.toString().indexOf(']')+1,
                 error.toString().length-1),
             signUpSuccess = error
           });
      })
               .catchError((error)=>{
             error = error.toString().substring(error.toString().indexOf(']')+1,
                 error.toString().length-1),
             signUpSuccess = error
           }): await FirebaseFirestore.instance.collection('users')
            .doc(authValue.user.uid)
            .set({
          'userId':authValue.user.uid,
          'fcmToken':await getToken(),
          'createdAt':FieldValue.serverTimestamp(),
          'name':email.substring(0,email.indexOf('@')),
          'email':email,
          'userImageUrl': "https://firebasestorage.googleapis.com/v0/b/appone-2e064.appspot.com/o/userProfileImages%2Fdefault_user.png?alt=media&token=8c687fb0-d708-47e4-8a7a-ebd044f3a00c",
        }).whenComplete(() => {
          signUpSuccess ='Successful'
        })
            .catchError((error)=>{
          error = error.toString().substring(error.toString().indexOf(']')+1,
              error.toString().length-1),
          signUpSuccess = error
        });
      })
          .catchError((error) => {
            error = error.toString().substring(error.toString().indexOf(']')+1,
                error.toString().length-1),
            signUpSuccess = error
          });
    }
    catch(error){
      print(error);
    }
    return signUpSuccess;
  }

  ////Create User in Auth Without Loading Image


  ///Get FCM Token For Notification.
  Future<String> getToken() async{
    String tokenResult;
    await _firebaseMessaging.getToken().then((value) => {
      print('Token For User Is: '+value),
      tokenResult = value,
    }).catchError((error)=>{
      print('Get Token Error is : ${error.toString()}'),
      tokenResult = 'Failed'
    });
    return tokenResult;
  }

  ///Send Message OneToOne Chat
  Future<dynamic> sendMessage({String msgText,String chatToUserId,
    String senderName,String messageType,File imageFile,String peerUserToken}) async{
    var messageSent;
    if(messageType == 'Image')
      {
        await FirebaseStorage().ref().
        child('oneToOneChatImages/${FireBaseService.getCurrentUserUid()}/images/')
            .putFile(imageFile)
            .onComplete.then((value)async{
               msgText = await value.ref.getDownloadURL();
          String uniqueDocId = FirebaseFirestore.instance
              .collection('oneToOneChat')
              .doc("${getCurrentUserUid()}-$chatToUserId")
              .collection('messages')
              .doc().id;
          FirebaseFirestore.instance.collection('oneToOneChat')
              .doc("${getCurrentUserUid()}-$chatToUserId")
              .collection('messages')
              .doc(uniqueDocId).set(
              {
                'sentTime':FieldValue.serverTimestamp(),
                'message':msgText,
                'messageId':uniqueDocId,
                "msgSeen":false,
                "receiver":chatToUserId,
                "sender":getCurrentUserUid(),
                "type":messageType
              }
          ).whenComplete(()async{

            await FirebaseFirestore.instance.collection('oneToOneChat')
                .doc("$chatToUserId-${getCurrentUserUid()}")
                .collection('messages')
                .doc(uniqueDocId).set(
                {
                  'sentTime':FieldValue.serverTimestamp(),
                  'message':msgText,
                  'messageId':uniqueDocId,
                  "msgSeen":false,
                  "receiver":chatToUserId,
                  "sender":getCurrentUserUid(),
                  "type":messageType
                })
                .whenComplete(() => {
            messageSent = 'Successful'
            })
            .catchError((error)=>{
              print(error),
              messageSent = 'Failed'
            });
          }).catchError((error)=>{
            print(error),
            messageSent = 'Failed'
          });
        }).catchError((error)=>{
          print(error),
          messageSent = 'Failed'
        });
        return messageSent;
      }
    else
    {
      String uniqueDocId = FirebaseFirestore.instance
          .collection('oneToOneChat')
          .doc("${getCurrentUserUid()}-$chatToUserId")
          .collection('messages')
          .doc()
          .id;
      await FirebaseFirestore.instance
          .collection('oneToOneChat')
          .doc("${getCurrentUserUid()}-$chatToUserId")
          .collection('messages')
          .doc(uniqueDocId)
          .set({
        'sentTime': FieldValue.serverTimestamp(),
        'message': msgText,
        'messageId': uniqueDocId,
        "msgSeen": false,
        "receiver": chatToUserId,
        "sender": getCurrentUserUid(),
        "type": messageType
      }).whenComplete(() async
      {
                await FirebaseFirestore.instance
                    .collection('oneToOneChat')
                    .doc("$chatToUserId-${getCurrentUserUid()}")
                    .collection('messages')
                    .doc(uniqueDocId)
                    .set({
                  'sentTime': FieldValue.serverTimestamp(),
                  'message': msgText,
                  'messageId': uniqueDocId,
                  "msgSeen": false,
                  "receiver": chatToUserId,
                  "sender": getCurrentUserUid(),
                  "type": messageType
                }).whenComplete(() => {
                  NotificationController.instance.sendNotificationMessageToPeerUser(
                      0, messageType, msgText, senderName,
                      FireBaseService.getCurrentUserUid(),
                      peerUserToken),
                  messageSent = 'Successful',
                  FirebaseFirestore.instance.collection('users')
                      .doc(FireBaseService.getCurrentUserUid())
                      .collection('chattedWith').doc(chatToUserId)
                      .set({'ChattedWith':chatToUserId,
                    'lastMessageTime':FieldValue.serverTimestamp()
                  }).whenComplete(() =>
                  {
                FirebaseFirestore.instance.collection('users')
                    .doc(chatToUserId)
                    .collection('chattedWith').doc(FireBaseService.getCurrentUserUid())
                    .set({'ChattedWith':FireBaseService.getCurrentUserUid(),
                  'lastMessageTime':FieldValue.serverTimestamp()
                }).whenComplete(()=>{
                      print('Chat With Added SuccessFul')
                }
                )})
                }).catchError((error)=>{
                  print(error),
                  messageSent = 'Failed'
                });
              }).catchError((error)=>{
        print(error),
        messageSent = 'Failed'
      });
      return messageSent;
    }
  }

  ///Create Group
  Future<String> createGroup({groupName,List<String>listOfGroupMembers,imageFile})
  async{
    listOfGroupMembers.add(FireBaseService.getCurrentUserUid());
    var uniqueDocId = FirebaseFirestore.instance.collection('groups').doc().id;
     await FirebaseFirestore.instance.collection('groups').doc(uniqueDocId)
        .set(
        {
          "createdAt": FieldValue.serverTimestamp(),
        "admin":FirebaseAuth.instance.currentUser.uid,
        "groupName":groupName,
        "id": uniqueDocId,
        "lastMsg": null,
        "groupImg": await uploadGroupImage(uniqueDocId,groupName,imageFile),
        "lastMsgTime":null,
        "members": listOfGroupMembers
        }).whenComplete(()async{
      await listOfGroupMembers.forEach((element) async {
        groupCreated= 'Successful';
        FirebaseFirestore.instance.collection('users').doc(element)
        .collection('groupsIn').doc(uniqueDocId)
        .set({'groupName':groupName}).whenComplete(()async
    {
      await print('Complete');
        groupCreated= await 'Successful';}
      ).catchError((error){
      groupCreated='Failed';
      print(error);
    });
    });
    }).catchError((error)=>{
        print(error),
       groupCreated='Failed',
    });
     return groupCreated;
  }

  ///Upload Image For Group
  Future<String> uploadGroupImage(String uniqueDocId,String groupName,
      File imageFile) async{
    String filePath = 'groupImage/$uniqueDocId/'
        '${groupName}';
    final StorageReference storageReference = FirebaseStorage().ref().child(filePath);
    final StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
    return imageURL;
  }

}
