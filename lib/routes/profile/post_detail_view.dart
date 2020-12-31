import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/post.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/dialog/custom_dialogs.dart';
import 'package:app_one/utils/drawer/drawer_main.dart';
import 'package:app_one/utils/drawer/drawer_right.dart';
import 'package:app_one/utils/my_bottom_bar.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/viewmodel/post_detail_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDetailView extends StatefulWidget {
  final Data postData;
  PostDetailView({this.postData});
  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}


class _PostDetailScreenState extends State<PostDetailView> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List<String> listOfHashTags;
  String hashTags = "";
  TextEditingController commentTC = TextEditingController();
  List<Map<String,dynamic>> listOfLikeAndCountForPost;
  bool onTapClicked = false;
  List<Map<String,dynamic>> listOfLikeAndCountForComment;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PostDetailViewModel>(
      onModelReady: (model)async{
        await model.postViewed(postId: widget.postData.postId.toString());
        if(model.postViewedSuccess)print("Success Viewing Post");
        else print("Failed Viewing Post");
      },
      builder: (context, model, child) => postDetailView(context, model),
    );
  }

  Scaffold postDetailView(BuildContext context,PostDetailViewModel model) {
    return Scaffold(
    key: scaffoldKey,
    drawer: DrawerMain(context: context,),
    endDrawer: DrawerRight(context: context,),
      backgroundColor: MyColors.colorDarkBlack,
      bottomNavigationBar: MyBottomNavigationBar(context:context,
      scaffoldKey: scaffoldKey,),
      body: FutureBuilder<bool>(
        future: model.getPostDetails(postId: widget.postData.postId.toString()),
        builder: (context,postDetailSnapshot){
          if(postDetailSnapshot.data !=null &&
              postDetailSnapshot.data)
          {
            listOfHashTags = [];
            hashTags="";
            for (var items in model.postDetailData.data.hashTag) {
              hashTags = "${hashTags}#${items.name}";
            }

            if(!onTapClicked)
            {
              listOfLikeAndCountForPost = [];
              model.postDetailData.data.isSelfLike == 'true'
                  ? listOfLikeAndCountForPost.add({
                      "isLiked": true,
                      "likeCount": model.postDetailData.data.isLikeCount
                    })
                  : listOfLikeAndCountForPost.add({
                      "isLiked": false,
                      "likeCount": model.postDetailData.data.isLikeCount
                    });
              print(model.postDetailData.data.isSelfLike);
              print(listOfLikeAndCountForPost);
            }

            if(!onTapClicked)
              {
                listOfLikeAndCountForComment=[];
                for(var items in model.postDetailData.data.comments){
                  items.selfCommentLike=='true'
                      ?listOfLikeAndCountForComment.add(
                      {"isLiked":true,
                        "likeCount":items.commentLikesCount
                      })
                      :listOfLikeAndCountForComment.add(
                      {"isLiked":false,
                        "likeCount":items.commentLikesCount
                      });
                }
              }
          }
         return postDetailSnapshot.data !=null
           ?postDetailSnapshot.data
           ?BaseScrollView().baseView(context, [
             ///Post Detail Item
           Padding(
             padding: const EdgeInsets.only(top: 30,left: 15,right: 15),
             child: Material(
               borderRadius: BorderRadius.circular(15),
               color: MyColors.appBlue,
               child: Column(
                 children: [
                   ///Post detail Item
                   Padding(
                     padding: const EdgeInsets.only(top: 30),
                     child: Card(
                       elevation: 0,
                       color: MyColors.appBlue,
                       child: Column(
                         children: [
                           Stack(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Expanded(
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(5),
                                       child: CachedNetworkImage(
                                         imageUrl: model.postDetailData.data.images[0].image,
                                         placeholder: (context, url) => Container(
                                           transform:
                                           Matrix4.translationValues(0, 0, 0),
                                           child: Container(
                                               width: MediaQuery.of(context).size.width/1.1,
                                               height: 230,
                                               child: Center(
                                                   child:
                                                   new CircularProgressIndicator())),
                                         ),
                                         errorWidget: (context, url, error) =>
                                         new Icon(Icons.error,color: MyColors.colorWhite,size: 40,),
                                         width: MediaQuery.of(context).size.width/1.15,
                                         height: 230,
                                         fit: BoxFit.fill,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),

                               SizedBox(
                                 height: 230,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.only(left: 30,bottom: 10),
                                       child:  ClipRRect(
                                         borderRadius: BorderRadius.circular(30),
                                         child: CachedNetworkImage(
                                           imageUrl:model.postDetailData.data.profileImage,
                                           placeholder: (context, url) => Container(
                                             transform:
                                             Matrix4.translationValues(0, 0, 0),
                                             child: Container(
                                                 width: 40,
                                                 height: 40,
                                                 child: Center(
                                                     child:
                                                     new CircularProgressIndicator())),
                                           ),
                                           errorWidget: (context, url, error) =>
                                           new Icon(Icons.error,color: MyColors.colorWhite,),
                                           width: 40,
                                           height: 40,
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                     ),

                                     Padding(
                                       padding: EdgeInsets.only(left: 10,bottom: 10),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.end,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             model.postDetailData.data.profileName
                                             ,style: CTheme.textRegular18White(),
                                             textAlign: TextAlign.start,),
                                           Padding(
                                             padding: const EdgeInsets.only(top: 0),
                                             child: Text(
                                                 model.postDetailData.data.createdAt,
                                                 style: CTheme.textRegular11Grey()),
                                           )
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                             ],
                           ),

                           Padding(
                             padding:EdgeInsets.only(top: 15,left: 15,right: 15),
                             child: Row(
                               children: [
                                 Text(
                                   hashTags,
                                   style: CTheme.textRegular14LogoOrange(),
                                   textAlign: TextAlign.start,
                                 ),
                               ],
                             ),
                           ),

                           Padding(
                             padding:EdgeInsets.only(top: 15,left: 15,right: 15),
                             child: SizedBox(
                               child: Row(
                                 children: [
                                   Expanded(
                                     child: Text(
                                       model.postDetailData.data.description,
                                       style: CTheme.textRegular14White(),
                                       textAlign: TextAlign.start,
                                     ),

                                   ),

                                 ],
                               ),
                             ),

                           ),

                           Padding(
                             padding:EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 20),
                             child: Stack(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     InkWell(
                                      splashColor: MyColors.colorRedPlay,
                                       borderRadius: BorderRadius.circular(5),
                                       child: Icon(
                                         Icons.favorite,
                                         color: listOfLikeAndCountForPost[0]['isLiked']
                                             ?MyColors.colorRedPlay
                                         :MyColors.colorWhite,
                                         size: 20,
                                       ),
                                       onTap: (){
                                         onTapClicked = true;
                                         print(listOfLikeAndCountForPost.length);
                                         listOfLikeAndCountForPost[0].update('isLiked',
                                                 (value) => value =!listOfLikeAndCountForPost[0]
                                             ['isLiked']);

                                         if( !listOfLikeAndCountForPost[0]
                                         ['isLiked']==true){
                                           listOfLikeAndCountForPost[0].update('likeCount',
                                                   (value) => value=listOfLikeAndCountForPost
                                               [0]['likeCount']-1);
                                         }
                                         if( !listOfLikeAndCountForPost[0]
                                         ['isLiked']==false){
                                           listOfLikeAndCountForPost[0].update('likeCount',
                                                   (value) => value=(listOfLikeAndCountForPost
                                               [0]['likeCount'])+1);
                                         }
                                         print(listOfLikeAndCountForPost.length);
                                         callLikeApi(model);
                                         setState(() {
                                           listOfLikeAndCountForPost;
                                         });
                                         },
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(left: 5),
                                       child: Text(
                                         listOfLikeAndCountForPost[0]
                                         ['likeCount'].toString(),
                                         style:CTheme.textRegular11White(),
                                       ),

                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(left: 25),
                                       child: Icon(
                                         Icons.mode_comment,
                                         color: MyColors.colorWhite,
                                         size: 20,
                                       ),
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(left: 5),
                                       child: Text(
                                         model.postDetailData.data.postCommentsCount.toString(),
                                         style:CTheme.textRegular11White(),
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Icon(
                                       Icons.reply,
                                       color: MyColors.colorWhite,
                                       size: 20,
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(left: 5),
                                       child: Text(
                                         model.postDetailData.data.isShareCount.toString(),
                                         style:CTheme.textRegular11White(),
                                       ),
                                     )
                                   ],
                                 )
                               ],
                             ),
                           ),


                         ],
                       ),
                     ),
                   ),

                   ///Comment List View
                   Padding(
                     padding: EdgeInsets.only(top: 0,bottom: 20),
                     child:ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                         itemCount: model.postDetailData.data.comments.length,
                         shrinkWrap: true,
                         itemBuilder: (context,position){
                           return commentItem(model, position);
                         }),
                   ),
                 ],
               ),
             ),
           ),

           ///Comment Button
           Padding(
             padding: EdgeInsets.only(top: 30,bottom: 30,left: 50,right: 50),
             child: roundedSquareButton('ADD COMMENT',
                     ()=>{
               CustomDialogs.showCommentDialog(context: context,controller: commentTC,
               btn1Text: 'Cancel',btn2Text: 'Add',labelText: 'Comment',
               onDialogAddPressed: ()async{
                 CTheme.showCircularProgressDialog(context);
                await model.commentOnPost(parameterMap:{
                   "post_id": model.postDetailData.data.postId,
                   "comment": commentTC.text.trim()
                 });
                if(model.postCommentSuccess)
                  {
                    commentTC.clear();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {
                      model.postDetailData.data;
                    });
                  }
                else{
                  Navigator.pop(context);
                  Navigator.pop(context);
                  CTheme.showAppAlertOneButton(         "Okay",context: context,
                  title: 'Comment Error',bodyText: "Error Posting Comment",
);
                }
               })
                     }
             ),
           )

         ])
             :Container()
             :Center(child:CTheme.showCircularProgressIndicator(strokeWidget: 5),
         );
        },
      ),
  );
  }

  Container commentItem(PostDetailViewModel model, int position) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF242A37), Color(0xFF4E586E)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///Comment Text
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.colorWhite,
                        borderRadius: BorderRadius.circular(20)),
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.postDetailData.data.comments[position]
                            .commentByProfileName,
                        style: CTheme.textRegular16White(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    model.postDetailData.data.comments[position].comment,
                    style: CTheme.textRegular16White(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),

          ///Comment Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: MyColors.colorRedPlay,
                  borderRadius: BorderRadius.circular(5),
                  child: Icon(
                    Icons.favorite,
                    color: listOfLikeAndCountForComment[position]['isLiked']
                    ?MyColors.colorRedPlay
                        :MyColors.colorWhite,
                    size: 20,
                  ),
                  onTap: () {
                    onTapClicked = true;
                    print(listOfLikeAndCountForComment.length);
                    listOfLikeAndCountForComment[position].update('isLiked',
                            (value) => value =!listOfLikeAndCountForComment[position]
                        ['isLiked']);

                    if( !listOfLikeAndCountForComment[position]
                    ['isLiked']==true){
                      listOfLikeAndCountForComment[position].update('likeCount',
                              (value) => value=listOfLikeAndCountForComment
                          [position]['likeCount']-1);
                    }
                    if( !listOfLikeAndCountForComment[position]
                    ['isLiked']==false){
                      listOfLikeAndCountForComment[position].update('likeCount',
                              (value) => value=(listOfLikeAndCountForComment
                          [position]['likeCount'])+1);
                    }
                    print(listOfLikeAndCountForComment.length);
                    callLikeApiComment(model, position);
                    setState(() {
                      listOfLikeAndCountForComment;
                    });
                   ;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 15),
                child: Text(
                  listOfLikeAndCountForComment[position]['likeCount'].toString(),
                  style: CTheme.textRegular11White(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  'Comment',
                  style: CTheme.textRegular16LogoOrange(),
                ),
              ),
            ],
          ),

          ///White Line
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: model.postDetailData.data.comments.length > 1
                ? Container(
                    height: 2,
                    color: MyColors.colorWhite,
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Future callLikeApi(PostDetailViewModel model) async {
    print(listOfLikeAndCountForPost[0]['isLiked']);

      await model.postActivities({
        "post_id": model.postDetailData.data.postId,
        "is_like": "${listOfLikeAndCountForPost[0]['isLiked']}",
        "is_share": "false",
        "is_favourite": "false"
      });
      if (model.postActivitySuccess) onTapClicked = false;
      else onTapClicked = false;

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

  Widget itemSearchProfile() {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: GestureDetector(
        onTap: ()=>{

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text('View Profile',style: CTheme.textRegular11White(),
                              textAlign: TextAlign.start,),
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

  callLikeApiComment(PostDetailViewModel model, int position) async {
    print(listOfLikeAndCountForComment[0]['isLiked']);
    await model.postCommentLike({
    "post_id": model.postDetailData.data.postId,
    "post_comment_id": model.postDetailData.data.comments[position].commentId,
    "is_like": "${listOfLikeAndCountForComment[0]['isLiked']}"
    });
    if (model.postCommentLikeSuccess) onTapClicked = false;
    else onTapClicked = false;
  }
}

