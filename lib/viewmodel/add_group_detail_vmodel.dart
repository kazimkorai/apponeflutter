import 'package:app_one/locator/locator.dart';
import 'package:app_one/services/firebase/firebase_service.dart';
import 'package:app_one/viewmodel/base_model.dart';

class AddGroupDetailViewModel extends BaseModel {

  FireBaseService fireBaseService = locator<FireBaseService>();

  Future<String> createGroup({groupName,List<String> listOfGroupMembers,imageFile})async{
    return await FireBaseService().createGroup(groupName: groupName,
        listOfGroupMembers:listOfGroupMembers,imageFile: imageFile );
  }
}