import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Decoration.dart';


 finished(BuildContext context,String newDuration, int steps, String bestDuration){
   var height = MediaQuery.of(context).size.height;
   var width = MediaQuery.of(context).size.width;
   Admob().myVideoAdLoading();
   bool isReplay = true;
  Alert(
    title: "Congratulation!!!",
    context: context,
    style: AlertStyle(
      backgroundColor: Colors.white.withOpacity(0.1),
      titleStyle: alertFinishedTitleStyle,
      descStyle: alertFinishedStyle
    ),
    buttons: [
      DialogButton(
        color: Colors.white.withOpacity(0.5),
          child: Text("Replay",style: alertFinishedTitleStyle,),
          onPressed: (){
            isReplay = true;
            Navigator.of(context).pop(true);
          }),
      DialogButton(
          color: Colors.white.withOpacity(0.5),
          child: Text("Next",style: alertFinishedTitleStyle,),
          onPressed: (){
            isReplay = false;
            Navigator.of(context).pop(true);
          }),
    ],
    content: Container(
      height: height*(2/5),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Icon(Icons.emoji_events_sharp,
            size: ScreenUtil().setHeight(400),color: Colors.amber,),
          new Text("Steps : "+steps.toString(),style: alertFinishedStyle,),
          new Text("Time : "+newDuration.toString(),style: alertFinishedStyle,),
          new Text("Best time : "+bestDuration.toString(),style: alertFinishedStyle,),
        ],
      ),
    ),
  )..show();
  return isReplay;
}