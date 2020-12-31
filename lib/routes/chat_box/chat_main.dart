
import 'dart:async';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMain extends StatefulWidget {

  @override
  _ChatMainScreenState createState() => _ChatMainScreenState();
}


class _ChatMainScreenState extends State<ChatMain> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorDarkBlack,
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
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: ()=>{
                    Navigator.pushNamed(context, '/about_us')
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    color: MyColors.appBlue,
                    child: Text(
                        'Followers',
                      style: CTheme.textRegular16White(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: ()=>{
                      Navigator.pushNamed(context, '/upload_image')
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      color: MyColors.appBlue,
                      child: Text(
                          'Groups',
                        style: CTheme.textRegular16White(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child:ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 25,
              shrinkWrap: true,
              itemBuilder: (context,position){
                return itemChatRow();
              }),
        ),
      ]),
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

  TextField plainTextField(String hintText) {
    return TextField(
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

  Widget itemChatRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        color: MyColors.appBlue,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.colorWhite,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    height: 40,
                    width: 40,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('JohnDoe',style: CTheme.textRegular11White(),
                        textAlign: TextAlign.start,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Liked Your Post',style: CTheme.textRegular11White()),
                      )
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
                        Text('JohnDoe',style: CTheme.textRegular11White(),
                          textAlign: TextAlign.start,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.play_arrow,
                            size: 18,
                            color: MyColors.colorWhite,
                          ),
                        )
                      ],
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

}