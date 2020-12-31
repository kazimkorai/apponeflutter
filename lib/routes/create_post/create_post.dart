import 'dart:convert';
import 'dart:io';

import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/routes/chat_box/create_group.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/dialog/AlertBox.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:app_one/viewmodel/create_post_vmodel.dart';
import 'package:app_one/viewmodel/create_user_vmodel.dart';
import 'package:app_one/viewmodel/login_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePost> {
  var radioValue;
  List<String> _listChipTagsCategory = [];
  List<String> _listChipTagsHashTags = [];
  var dropDownValue;
  var _listForDropdown = ['this', 'that', 'what'];
  TextEditingController titleTC = TextEditingController();
  PickedFile imageFile;
  TextEditingController descriptionTC = TextEditingController();
  final GlobalKey<FormState> _formKeyTopic = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyHashTag = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCat = new GlobalKey<FormState>();

  List<dynamic> listCat = List();
  List<Map<String, String>> listMapCat = new List();
  List<Map<String, String>> selectedCatList = new List();

  List<dynamic> listTopic = List();
  List<Map<String, String>> listMapTopic = new List();
  List<Map<String, String>> selectedTopicList = new List();

  List<dynamic> listHash = List();
  List<Map<String, String>> listMapHash = new List();
  List<Map<String, String>> selectedHashList = new List();

  @override
  void initState() {
    super.initState();
    getIntresets();
  }

  getIntresets() async {
    CreateUserViewModel model = new CreateUserViewModel();
    CTheme.showCircularProgressDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await model.getIntrests();
    if (model.intrestsSuccess) {
      setState(() {
        print(model.intrestsData.data.category.length);
        listCat = model.intrestsData.data.category;
        for (int index = 0;
            index < model.intrestsData.data.category.length;
            index++) {
          print(model.intrestsData.data.category[index].name);
          Map<String, String> dataMap = {
            'name': model.intrestsData.data.category[index].name,
            'id': model.intrestsData.data.category[index].id.toString(),
          };
          listMapCat.add(dataMap);
        }
        print(listCat.length);

        ///// hashTag
        for (int index = 0;
            index < model.intrestsData.data.hashtag.length;
            index++) {
          print(model.intrestsData.data.hashtag[index].name);
          listHash = model.intrestsData.data.hashtag;
          Map<String, String> dataMap = {
            'name': model.intrestsData.data.hashtag[index].name,
            'id': model.intrestsData.data.hashtag[index].id.toString(),
          };
          listMapHash.add(dataMap);
        }

        ///Topic
        for (int index = 0;
            index < model.intrestsData.data.topics.length;
            index++) {
          print(model.intrestsData.data.topics[index].name);
          listTopic = model.intrestsData.data.topics;
          Map<String, String> dataMap = {
            'name': model.intrestsData.data.topics[index].name,
            'id': model.intrestsData.data.topics[index].id.toString(),
          };
          listMapTopic.add(dataMap);
        }
      });
      Navigator.pop(context);
      return listCat;
    } else {
      Navigator.pop(context);
      print("Error");
    }
  }

  void _onFormSavedCat() {
    final FormState form = _formKeyCat.currentState;
    form.save();
  }

  void _onFormSavedTopics() {
    final FormState form = _formKeyTopic.currentState;
    form.save();
  }

  void _onFormSavedHashTag() {
    final FormState form = _formKeyHashTag.currentState;
    form.save();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreatePostViewModel>(
      builder: (context, model, child) => createPostView(context, model),
    );
  }

  WillPopScope createPostView(BuildContext context, CreatePostViewModel model) {
    return WillPopScope(
      onWillPop: () async {
        Globals.currentRoute = '/profile_home';
        print(Globals.currentRoute);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: MyColors.colorDarkBlack,
          body: BaseScrollView().baseView(context, [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
              child: plainTextField(Localization.stLocalized('title'), titleTC),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                Localization.stLocalized('description'),
                style: CTheme.textRegular21White(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 50, right: 50),
              child: whiteMultilineTextField(descriptionTC),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                Localization.stLocalized('selectCategories'),
                style: CTheme.textRegular21White(),
              ),
            ),
            listCat.length != 0
                ? Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 40, right: 40, bottom: 30),
                    child: Form(
                      key: _formKeyCat,
                      autovalidate: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new MultiSelect(
                              autovalidate: true,
                              dataSource: listMapCat,
                              textField: 'name',
                              valueField: 'id',
                              maxLength: 8,
                              hintText:
                              "Please select categories (Min: 2 and Max: 8)",
                              titleText: 'Select Your Categories',

                              // optional
                              validator: (dynamic value) {
                                if (value == null) {
                                  return 'Please select at least 2 categories';
                                }
                                return null;
                              },
                              filterable: true,
                              required: true,
                              onSaved: (value) {
                                print('The value is $value');
                                selectedCatList = new List();
                                if (value != null) {
                                  print(value.length);
                                  selectedCatList = new List();
                                  for (int index = 0;
                                      index < value.length;
                                      index++) {
                                    Map<String, String> selectedDataToMap = {
                                      'id': value[index]
                                    };
                                    selectedCatList.add(selectedDataToMap);
                                  }
                                  print(selectedCatList.length);
                                } else {
                                  print('selectCat');
                                }
                              },
                              selectIcon: Icons.add,
                              saveButtonColor: MyColors.colorLogoOrange,
                              checkBoxColor: MyColors.colorLogoOrange,
                              cancelButtonColor: MyColors.colorLogoOrange,
                              cancelButtonTextColor: MyColors.colorWhite,
                              //  searchBoxColor: MyColors.colorLogoOrange,
                              selectIconColor: MyColors.colorWhite,
                              clearButtonColor: Color(0xFF242A37),
                              maxLengthText: "",
                              maxLengthIndicatorColor: MyColors.colorWhite,
                              clearButtonTextColor: MyColors.colorWhite,
                              titleTextColor: MyColors.colorLogoOrange,
                            ),
                          ),
                          /*  SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _onFormSaved();
                          },
                        )*/
                        ],
                      ),
                    ),
                  )
                : Text("loading"),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                Localization.stLocalized('selectTopics'),
                style: CTheme.textRegular21White(),
              ),
            ),
            listTopic.length != 0
                ? Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 40, right: 40, bottom: 30),
                    child: Form(
                      key: _formKeyTopic,
                      autovalidate: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new MultiSelect(
                              autovalidate: true,
                              dataSource: listMapTopic,
                              textField: 'name',
                              valueField: 'id',
                              titleText: 'Select Your Topics',
                              hintText:
                              "Please select topics (Min: 2 and Max: 8)",

                              maxLength: 8,
                              // optional
                              validator: (dynamic value) {
                                if (value == null) {
                                  return 'Please select at least 2 topics';
                                }
                                return null;
                              },
                              filterable: true,
                              required: true,
                              onSaved: (value) {
                                if (value != null) {
                                  print('The value is $value');
                                  print(value.length);
                                  selectedTopicList = new List();
                                  for (int index = 0;
                                      index < value.length;
                                      index++) {
                                    Map<String, String> selectedDataToMap = {
                                      'id': value[index]
                                    };
                                    selectedTopicList.add(selectedDataToMap);
                                  }
                                  print(selectedTopicList.length);
                                }
                              },
                              selectIcon: Icons.add,
                              saveButtonColor: MyColors.colorLogoOrange,
                              checkBoxColor: MyColors.colorLogoOrange,
                              cancelButtonColor: MyColors.colorLogoOrange,
                              cancelButtonTextColor: MyColors.colorWhite,
                              //  searchBoxColor: MyColors.colorLogoOrange,
                              selectIconColor: MyColors.colorWhite,
                              clearButtonColor: Color(0xFF242A37),
                              maxLengthText: "",
                              maxLengthIndicatorColor: MyColors.colorWhite,
                              clearButtonTextColor: MyColors.colorWhite,
                              titleTextColor: MyColors.colorLogoOrange,
                            ),
                          ),
                          /*  SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _onFormSaved();
                          },
                        )*/
                        ],
                      ),
                    ),
                  )
                : Text("loading"),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                Localization.stLocalized('hashTags'),
                style: CTheme.textRegular21White(),
              ),
            ),
            listHash.length != 0
                ? Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 40, right: 40, bottom: 30),
                    child: Form(
                      key: _formKeyHashTag,
                      autovalidate: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new MultiSelect(
                              autovalidate: true,
                              dataSource: listMapHash,
                              textField: 'name',
                              valueField: 'id',
                              titleText: 'Select Your HashTags',
                              hintText:
                              "Please select hashTags (Min: 2 and Max: 8)",
                              maxLength: 8,
                              maxLengthText: '',

                              // optional
                              validator: (dynamic value) {
                                if (value == null) {
                                  return 'Please select at least 2 hashTags';
                                }
                                return null;
                              },
                              filterable: true,
                              required: true,
                              onSaved: (value) {
                                if (value != null) {
                                  print('The value is $value');
                                  print(value.length);
                                  selectedHashList = new List();
                                  for (int index = 0;
                                      index < value.length;
                                      index++) {
                                    Map<String, String> selectedDataToMap = {
                                      'id': value[index]
                                    };
                                    selectedHashList.add(selectedDataToMap);
                                  }
                                  print(selectedHashList.length);
                                }
                              },
                              selectIcon: Icons.add,
                              saveButtonColor: MyColors.colorLogoOrange,
                              checkBoxColor: MyColors.colorLogoOrange,
                              cancelButtonColor: MyColors.colorLogoOrange,
                              cancelButtonTextColor: MyColors.colorWhite,
                              //  searchBoxColor: MyColors.colorLogoOrange,
                              selectIconColor: MyColors.colorWhite,
                              clearButtonColor: Color(0xFF242A37),

                              maxLengthIndicatorColor: MyColors.colorLogoOrange,
                              clearButtonTextColor: Colors.white,
                              titleTextColor: MyColors.colorLogoOrange,
                            ),
                          ),
                          /*  SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _onFormSaved();
                          },
                        )*/
                        ],
                      ),
                    ),
                  )
                : Text("loading"),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: profileImageItemUpload(() async {
                imageFile = await PickImageController.instance.picker
                    .getImage(source: ImageSource.gallery, imageQuality: 30);
                if (imageFile != null) {
                  print("${File(imageFile.path).lengthSync() * 0.001} Kb");
                  setState(() {
                    imageFile;
                  });
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 50, right: 50, bottom: 30),
              child: roundedSquareButton(Localization.stLocalized('upload'), 50,
                  () async {
                if (validate()) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  print("Posted ID==>"+prefs.get(Globals.profileId).toString());
                  CTheme.showCircularProgressDialog(context);
                  await model.createPost({
                    "image": await convertImageToBase64(imageFile),
                    "user_id": prefs.get(Globals.userId),
                    "title": titleTC.text.trim(),
                    "description": descriptionTC.text.trim(),
                    "categories": selectedCatList,
                    "hashtag": selectedHashList,
                    "topic": selectedTopicList
                  }, prefs.get(Globals.profileId));
                  if (model.createPostSuccess) {
                    print('Post Created Successfully');
                    Navigator.pop(context);
                    CTheme.showAppAlertOneButton(
                        "Okay",
                        context: context,
                        title: "Created Successfully",
                        bodyText: "Post Created Successfully",
                        handler2: (action)=>
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/profile_home', (route) => false));

                  } else {
                    Navigator.pop(context);
                    CTheme.showAppAlertOneButton(
                    "Okay",
                        context: context,
                        title: "Error",
                        bodyText: "Error creating post try later",
             );
                    print("Error Creating Post");
                  }
                }
              }),
            )
          ])),
    );
  }

  bool validate() {
    bool isValidated = false;
    _onFormSavedCat();
    _onFormSavedTopics();
    _onFormSavedHashTag();
    print(selectedCatList.length.toString() + "cat");
    if (titleTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: "Title",
        bodyText: "Title for the post is missing",

      );
    } else if (selectedCatList.length<2) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: "Select Category",
        bodyText: "Please select a category",

      );
    } else if (selectedTopicList.length<2) {
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context,
          title: "Select Topic",
          bodyText: "Please select Topic");
    } else if (selectedHashList.length<2) {
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context,
          title: "Select HashTags",
          bodyText: "Please select hashtags");
    } else if (imageFile == null) {
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context,
          title: "Select Image",
          bodyText: "Please select image");
    } else {
      isValidated = true;
    }
    return isValidated;
  }

  Widget profileImageItemUpload(Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: imageFile == null
                ? Card(
                    color: MyColors.appBlue,
                    elevation: 8,
                    shadowColor: MyColors.appBlue,
                    child: SizedBox(
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                Localization.stLocalized('image'),
                                style: CTheme.textRegular25White(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 85, right: 85, bottom: 20),
                              child: roundedSquareButton(
                                  Localization.stLocalized('uploadImage'),
                                  30,
                                  onTap))
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 220,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.file(
                          File(imageFile.path),
                          fit: BoxFit.cover,
                        ))),
          ),
        ),
      ],
    );
  }

  Container whiteMultilineTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.colorWhite, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: controller,
          maxLines: 5,
          style: CTheme.textRegular16Black(),
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            fillColor: MyColors.colorWhite,
          ),
        ),
      ),
    );
  }

  Widget profileTypeBox(
      String headingText, String subText, String btnText, Function onTap) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.appBlue,
        border: Border(
          left: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          right: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          bottom: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          top: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              headingText,
              style: CTheme.textRegular26LogoOrange(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 0.5,
              width: 200,
              color: MyColors.colorLogoOrange,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 75, right: 75),
            child: Text(
              subText,
              style: CTheme.textRegular11WhiteItalic(),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 40, right: 40, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: (BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10),
                        )),
                        child: Text(
                          btnText,
                          style: CTheme.textRegularBold14White(),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget roundedSquareButton(String btnText, double height, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: height,
              decoration: (BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
              )),
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

  Widget roundedSquareButtonPopup(
      String btnText, double height, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: height,
              decoration: (BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
              )),
              child: Text(
                btnText,
                style: CTheme.textRegular11WhiteBold(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextField plainTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: CTheme.textRegular18White(),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        hintText: hintText,
        hintStyle: CTheme.textRegular18White(),
      ),
    );
  }

  Future<String> convertImageToBase64(imageFile) async {
    var headerString = 'data:image/png;base64,';
    File image = new File(imageFile.path);
    List<int> imageBytes = await image.readAsBytesSync();
    String base64Image = await base64.encode(imageBytes);
    var encodedImage = "$headerString$base64Image";
    print("Base64 Image Content: $encodedImage");
    return encodedImage;
  }
}

///Chips For Tags
class Chips extends StatelessWidget {
  const Chips({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: MyColors.colorLogoOrange,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 15,
        color: MyColors.colorWhite,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
