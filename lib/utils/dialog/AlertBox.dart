import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseAlertDialog extends StatefulWidget {
  final String title, description;
  final List<EWPAlertAction> actions;
  final Image image;
  final bool error;

  CloseAlertDialog({
    @required this.title,
    @required this.description,
    @required this.actions,
    this.image,
    this.error = false,
  });

  @override
  State<StatefulWidget> createState() {
    return CloseAlertDialogState(
        title: this.title,
        actions: this.actions,
        description: this.description,
        image: this.image);
  }
}

class CloseAlertDialogState extends State<CloseAlertDialog> {
  final String title, description;
  List<EWPAlertAction> actions;
  final Image image;

  CloseAlertDialogState({
    @required this.title,
    @required this.description,
    @required this.actions,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: MyColors.dialogBorder,
          width: 1,
          style: BorderStyle.solid
        ),

      ),
      elevation: 0.0,
      backgroundColor: MyColors.appBlue,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    Widget buttonsWidget;
    List<Widget> actionWidgets = List();
    if (actions.length > 0) {
      for (int i = 0; i < actions.length; i++) {
        EWPAlertAction action = actions[i];
        if (actions.length == 1) {
          actionWidgets.add(Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 0, end: 0, bottom: 10),
              child: cupertionButtonContainer(
                  context,
                  cupertinoButton(context, action, () {
                    if (action.handler == null) {
                      Navigator.of(context, rootNavigator: true).pop();
                    } else {
                      action.handler(action);
                    }
                    return;
                  }),
                  double.infinity,
                  action),
            ),
          ));
          buttonsWidget = actionWidgets[0];
        } else {
          actionWidgets.add(Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: i % 2 == 0 ? 8 : 0),
              child: cupertionButtonContainer(
                  context,
                  cupertinoButton(context, action, () {
                    if (action.handler == null) {
                      Navigator.of(context, rootNavigator: true).pop();
                    } else {
                      action.handler(action);
                    }
                    return;
                  }),
                  double.infinity,
                  action),
            ),
            flex: 1,
          ));
        }
      }
      if (buttonsWidget == null) {
        buttonsWidget = Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 0, end: 0, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: actionWidgets,
            ),
          ),
        );
      }
    }

    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsetsDirectional.only(
              top: 0,
              bottom: 0,
              start: 10,
              end: 10,
            ),
            margin: EdgeInsetsDirectional.only(top: 0),
            decoration: new BoxDecoration(
              color: MyColors.appBlue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0),
            ),
//            decoration: BoxDecoration(//ForBackground image, it work fine.
//              image: DecorationImage(image: AssetImage("assets/icons/popups/eid.png"), fit: BoxFit.fitWidth),
//            ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(title,
                      style: TextStyle(
                        fontSize: widget.error ? 14 : 16.0,
                        fontWeight: FontWeight.bold,
                        color: MyColors.colorWhite,
                        fontFamily: CTheme.defaultFont(),
                      )),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 8, end: 8),
                    child: Text(
                      description ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: widget.error ? 11 : 14.0,
                          fontFamily: CTheme.defaultFont(),
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  buttonsWidget,
                ],
              ),

        ),
      ],
    );
  }

  static CupertinoButton cupertinoButton(
      BuildContext context, EWPAlertAction action, Function onPressed()) {
    CupertinoButton cupertinoButton = CupertinoButton(
      child: Text(
        action.title ?? "",
        textAlign: TextAlign.center,
        softWrap: true,
        style: new TextStyle(
            fontFamily: CTheme.defaultFont(),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white),
        maxLines: 1,
      ),
      onPressed: () {
        onPressed();
      },
      pressedOpacity: 0.4,
      padding: EdgeInsetsDirectional.only(bottom: 0),
      borderRadius: BorderRadius.all(Radius.circular(0)),
    );

    return cupertinoButton;
  }

  static Container cupertionButtonContainer(
      BuildContext context,
      CupertinoButton cupertinoButton,
      double viewWidth,
      EWPAlertAction action) {
    return new Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: cupertinoButton,
      decoration: BoxDecoration(
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
          color: MyColors.appBlue,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: MyColors.appBlue, width: 1)),
      constraints: BoxConstraints.expand(width: viewWidth, height: 45),
    );
  }
}

class EWPAlertAction {
  String title;
  bool showWhiteButton = false;
  EWPAlertHandler handler;

  EWPAlertAction({this.title, this.handler, this.showWhiteButton = false});
}

typedef void EWPAlertHandler(EWPAlertAction action);
