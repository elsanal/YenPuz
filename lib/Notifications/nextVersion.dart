import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yenpuz/Decoration.dart';


NextVersion(BuildContext context){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return Alert(
    title: "",
    context: context,
    style: AlertStyle(
      backgroundColor: Colors.white,
      titleStyle: alertFinishedTitleStyle.copyWith(fontSize: 16, color: Colors.black87),
    ),
    buttons: [
      DialogButton(
          color: Colors.black87.withOpacity(0.5),
          child: Text("OK",style: alertFinishedTitleStyle.copyWith(color: Colors.white),),
          onPressed: (){
            Navigator.of(context).pop(true);
          }),
    ],
    content: Container(
      height: height*(1/4),
      width: width,
      color : Colors.white,
      child: new Container(
        alignment: Alignment.center,
        child: Text("We are still building this part. "
            " You will able to play it very soon. Don't forget to update "
            "the application to use new features.",textAlign: TextAlign.justify,),
      ),
    ),
  )..show();
}
