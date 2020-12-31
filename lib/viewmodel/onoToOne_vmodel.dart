import 'package:app_one/locator/locator.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';

class OneToOneViewModel extends BaseModel {

  FireBaseService fireBaseService = locator<FireBaseService>();

  Future<dynamic> sendMessage({msgTxt,msgType,chatToUserId,imageFile,peerUserToken,
  senderName}){
    return fireBaseService.sendMessage(msgText:msgTxt,messageType:msgType,
        chatToUserId:chatToUserId,imageFile: imageFile,peerUserToken: peerUserToken,
    senderName: senderName);
  }
}