import 'dart:io';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/viewmodel/add_group_detail_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddGroupDetails extends StatefulWidget {
  List<Map<String,dynamic>> selectedGroupUsers;
  AddGroupDetails({this.selectedGroupUsers});
  @override
  _AddGroupDetailsScreenState createState() => _AddGroupDetailsScreenState();
}


class _AddGroupDetailsScreenState extends State<AddGroupDetails> {
  var radioValue;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  PickedFile imageFile;
  List<Map<String,dynamic>> selectedGroupUsers=[];
  List<String> listOfUids;
  TextEditingController groupNameTxtController= TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedGroupUsers = widget.selectedGroupUsers;
    return  BaseView<AddGroupDetailViewModel>(
      onModelReady: (model) async {

      },
      builder: (context, model, child) => addGroupDetailsView(context, model),
    );
  }

  Scaffold addGroupDetailsView(BuildContext context,AddGroupDetailViewModel model) {
    return Scaffold(
    key: scaffoldKey,
      drawer: DrawerMain(context: context,),
      endDrawer: DrawerRight(context: context,),
    bottomNavigationBar: MyBottomNavigationBar(context: context,
    scaffoldKey: scaffoldKey,),
      backgroundColor: MyColors.colorDarkBlack,
      body: BaseScrollView().baseView(context, [

        Padding(
          padding: const EdgeInsets.only(top: 70,left: 50,right: 50),
          child: plainTextField('Group Name',textController: groupNameTxtController),
        ),

        Padding(
          padding: EdgeInsets.only(top: 40,left: 15,right: 15,bottom: 30),
          child:imageBoxItem(
                  ()async{
              imageFile = await PickImageController.instance.picker
                  .getImage(source: ImageSource.gallery);
              if (imageFile != null) {
                setState(() {});
              }
              }
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 30,left:15,right: 15),
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
                              hintText: 'Search Users',
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
                    child: Icon(
                      Icons.add,
                      size: 35,
                      color: MyColors.colorWhite,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 0,bottom: 20),
          child:ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.selectedGroupUsers.length,
              shrinkWrap: true,
              itemBuilder: (context,position){
                return itemSearchProfile(position);
              }),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 40,left: 50,right: 50,bottom: 30),
          child: roundedSquareButton(Localization
              .stLocalized('createGroup'),50,
                  ()async{

            listOfUids=[];
            for(var item in selectedGroupUsers){
              listOfUids.add(item['userId']);
            }
            if(groupNameTxtController.text.isNotEmpty &&
            imageFile!= null
            )
            {
              CTheme.showCircularProgressDialog(context);
                var groupCreationSuccess = await model.createGroup(
                    imageFile: File(imageFile.path),
                    groupName: groupNameTxtController.text,
                    listOfGroupMembers: listOfUids);
                if (groupCreationSuccess != 'Failed') {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/social_inbox',
                          (route) => route.isFirst);
                }
                else
                  {
                    Navigator.pop(context);
                  CTheme.showAppAlertOneButton(
                    "Okay",
                      context: context,

                      title: 'Creation Failed',
                      bodyText: 'Error creating group');
                }
              }
            else{
              CTheme.showAppAlertOneButton(
                  "Okay",
                  context: context,
                  title: 'Empty Fields',
                  bodyText: "Image and Name should'nt be empty");
            }
            }),
        )

      ])
  );
  }

  Widget imageBoxItem(Function onTap) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Card(
                  color: MyColors.appBlue,
                  elevation: 8,
                  shadowColor: MyColors.appBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child:imageFile==null?
                        Container(
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.colorLogoOrange,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 35,
                                color: MyColors.colorWhite,
                              ),
                              onPressed: ()async{
                                imageFile = await PickImageController.instance.picker
                                    .getImage(source: ImageSource.gallery);
                                if(imageFile!=null)
                                {
                                  setState(() {
                                  });
                                }
                              },
                            )
                        )
                            :Container(
                            height: 140,
                            width: 140,
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(75)),
                                child: Image.file(File(imageFile.path)
                                  ,fit: BoxFit.cover,))),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(top: 15,left: 85,right: 85,bottom: 20),
                        child: roundedSquareButton(Localization
                            .stLocalized('uploadImage'),
                            30 ,onTap),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  Container whiteMultilineTextField() {
    return Container(
            decoration: BoxDecoration(
              color: MyColors.colorWhite,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                maxLines: 4,
                style: CTheme.textRegular16Black(),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  fillColor: MyColors.colorWhite,
                ),
              ),
            ),
          );
  }

  Widget profileTypeBox(String headingText,String subText,String btnText
      ,Function onTap)
  {
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
                  padding: const EdgeInsets.only(top:10,left: 75,right: 75),
                  child: Text(
                    subText,
                    style: CTheme.textRegular11WhiteItalic(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25,left: 40,right: 40,bottom: 25),
                  child:Row(
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
                  )
                )
              ],
            ),
          );
  }
  Widget roundedSquareButton(String btnText,double height,Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: height,
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

  TextField plainTextField(String hintText,
      {TextEditingController textController}) {
    return TextField(
      controller: textController,
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
        hintText:hintText,
        hintStyle: CTheme.textRegular18White(),

      ),
    );
  }

  Widget itemSearchProfile(int position) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: GestureDetector(
        onTap: ()=>{
          Navigator.pushNamed(context, '/comment_on_post')
        },
        child: Container(
          color: MyColors.appBlue,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: widget.selectedGroupUsers[position]['userImageUrl']!=null
                          ?CachedNetworkImage(
                        imageUrl: widget.selectedGroupUsers[position]['userImageUrl'],
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.selectedGroupUsers[position]['name'],
                          style: CTheme.textRegular16White(),
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
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.colorWhite,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: GestureDetector(
                                onTap: ()=>{
                                  if(widget.selectedGroupUsers.length>1)
                                    {
                                      setState((){
                                        selectedGroupUsers.removeAt(position);
                                      })
                                    }
                                  else{
                                    CTheme.showAppAlertOneButton(   "Okay",context: context,
                                        title: 'Group with no users',
                                        bodyText: 'There should be at least one user'
                                            ' in group'),
                                  }
                                },
                                child: Icon(
                                    Icons.close,
                                    size: 15,
                                    color: MyColors.colorFullBlack,
                                ),
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
