import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScrollView{

  Widget baseView(BuildContext context,List<Widget> children,
      {ScrollController controller,ScrollPhysics baseScrollPhysics}){
    return SingleChildScrollView(
      physics: baseScrollPhysics,
      scrollDirection: Axis.vertical,
     controller: controller!=null?controller:null,
     child: Center(
          child: Column(
              children: children
          ),
        ),
    );
  }
}