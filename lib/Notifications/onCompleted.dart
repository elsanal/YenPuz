import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yenpuz/Decoration.dart';


 finished(BuildContext context,String time, String steps, String bestTime){
   var height = MediaQuery.of(context).size.height;
   var width = MediaQuery.of(context).size.width;
  return Alert(
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
          child: Text("Ok",style: alertFinishedTitleStyle,),
          onPressed: ()=>Navigator.of(context).pop(true))
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
          new Text("Steps : "+steps,style: alertFinishedStyle,),
          new Text("Time : "+time,style: alertFinishedStyle,),
          new Text("Best time : "+bestTime,style: alertFinishedStyle,),
        ],
      ),
    ),
  )..show();
}