import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yenpuz/Decoration.dart';


Help(BuildContext context,int row){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  int _itemCount = 9;
  return Alert(
    title: "How  to  play?",
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
      height: height*(4/6),
      width: width,
      color : Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setHeight(0),
            right: ScreenUtil().setHeight(0),
            child: new Container(child: Text(""
                "You can only move a number at once. Push or tap on the number near "
                " the empty box to move it. "
                "Your final result should look like the below table. "
                " Have fun ！！！！",),),
          ),
          Positioned(
            bottom: ScreenUtil().setHeight(0),
            left: ScreenUtil().setHeight(0),
            right: ScreenUtil().setHeight(0),
            child: Container(
              width: width,
              height: width,
              child: new Center(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: row,
                      ),
                      itemCount: _itemCount,
                      itemBuilder: (context, index) {
                        if(index == 8){return Container(color: Colors.brown[100],);}
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage("assets/wood_wp1.jpeg"),
                                    fit: BoxFit.cover
                                ),
                                border: Border.all(color: Colors.white,
                                    style: BorderStyle.solid, width: ScreenUtil().setWidth(3))
                            ),
                            child: Center(child: Text("${index+1}",style: homeStyle,)));
                      }
                  )),
            ),
          ),
        ],
      ),
    ),
  )..show();
}
