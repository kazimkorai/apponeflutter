import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}


class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Globals.currentRoute = '/profile_home';
        print(Globals.currentRoute);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: MyColors.colorDarkBlack,
          body: BaseScrollView().baseView(context, [
            Padding(
              padding: EdgeInsets.only(top: 20,bottom: 20),
              child:ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 25,
                  shrinkWrap: true,
                  itemBuilder: (context,position){
                return itemChatRow();
              }),
            ),
          ]),
      ),
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
      child: GestureDetector(
        onTap: ()=>{
          Navigator.pushNamed(context, '/chat_main')
        },
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
                          Text('5 Min Ago',style: CTheme.textRegular11White(),
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
      ),
    );
  }
}