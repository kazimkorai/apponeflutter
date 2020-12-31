
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {

  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyBottomNavigationBar({this.context,this.scaffoldKey});


  @override
  MyBottomNavigationBarState createState() => MyBottomNavigationBarState();
}
class MyBottomNavigationBarState extends State<MyBottomNavigationBar>{
  Color colorMenu = MyColors.colorWhite;
  Color colorHome = MyColors.colorWhite;
  Color colorLogo= MyColors.colorWhite;
  Color colorChat = MyColors.colorWhite;
  Color colorProfile = MyColors.colorWhite;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.colorDarkBlack,
      height: 65,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:Icon(
                    Icons.menu,
                    color: colorMenu,
                    size: 20,
                  ),
                  onPressed: ()=>{
                    widget.scaffoldKey.currentState.openDrawer(),
                    setState((){
                      if(colorMenu!= MyColors.colorBottomNavIcon)
                        {
                          colorMenu = MyColors.colorBottomNavIcon;
                          colorHome = MyColors.colorWhite;
                          colorLogo = MyColors.colorWhite;
                          colorChat = MyColors.colorWhite;
                          colorProfile = MyColors.colorWhite;
                        }
                      else
                        {
                          colorMenu = MyColors.colorWhite;
                        }
                    })
                  },
                ),
                Text(
                  'Menu',
                  style: CTheme.textRegular11White(),
                )

              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:Icon(
                    Icons.home,
                    color: colorHome,
                    size: 20,
                  ),
                  onPressed: ()=>{
                Navigator.pushNamed(context, '/profile_home'),

                     setState((){
                      if(colorHome!= MyColors.colorBottomNavIcon)
                      {
                        colorMenu = MyColors.colorWhite;
                        colorHome = MyColors.colorBottomNavIcon;
                        colorLogo = MyColors.colorWhite;
                        colorChat = MyColors.colorWhite;
                        colorProfile = MyColors.colorWhite;
                      }
                      else
                      {
                        colorHome = MyColors.colorWhite;
                      }
                    })
                  },
                ),
                Text(
                  'Home',
                  style: CTheme.textRegular11White(),
                )

              ],
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:Icon(
                    Icons.home,
                    color: colorLogo,
                    size: 20,
                  ),
                  onPressed: ()=>{
                    setState((){
                      if(colorLogo!= MyColors.colorBottomNavIcon)
                      {
                        colorMenu = MyColors.colorWhite;
                        colorHome = MyColors.colorWhite;
                        colorLogo = MyColors.colorBottomNavIcon;
                        colorChat = MyColors.colorWhite;
                        colorProfile = MyColors.colorWhite;
                      }
                      else
                      {
                        colorLogo = MyColors.colorWhite;
                      }
                    })
                  },
                ),
                Text(
                  'My Posts',
                  style: CTheme.textRegular11White(),
                )

              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:Icon(
                    Icons.forum,
                    color: colorChat,
                    size: 20,
                  ),
                  onPressed: ()=>{
                    Navigator.pushNamed(context, '/social_inbox'),
                    setState((){
                      if(colorChat!= MyColors.colorBottomNavIcon)
                      {
                        colorMenu = MyColors.colorWhite;
                        colorHome = MyColors.colorWhite;
                        colorLogo = MyColors.colorWhite;
                        colorChat = MyColors.colorBottomNavIcon;
                        colorProfile = MyColors.colorWhite;
                      }
                      else
                      {
                        colorChat = MyColors.colorWhite;
                      }
                    })
                  },
                ),
                Text(
                  'Chat',
                  style: CTheme.textRegular11White(),
                )

              ],
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:Icon(
                    Icons.people,
                    color: colorProfile,
                    size: 20,
                  ),
                  onPressed: ()=>{
                    widget.scaffoldKey.currentState.openEndDrawer(),
                    setState((){
                      if(colorProfile!= MyColors.colorBottomNavIcon)
                      {
                        colorMenu = MyColors.colorWhite;
                        colorHome = MyColors.colorWhite;
                        colorLogo = MyColors.colorWhite;
                        colorChat = MyColors.colorWhite;
                        colorProfile = MyColors.colorBottomNavIcon;
                      }
                      else
                      {
                        colorProfile = MyColors.colorWhite;
                      }
                    }),
                  },
                ),
                Text(
                  'Profile',
                  style: CTheme.textRegular11White(),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

}
