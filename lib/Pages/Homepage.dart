//@dart=2.9
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Database/gameClass.dart';
import 'package:yenpuz/Database/sqflite.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Pages/NumPuz.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _itemCount = 9;
  List<gameInfo> scores = [];

  @override
  void initState() {
    // TODO: implement initState
    getScores();
    Admob().myBannerAd..load();
    super.initState();
  }

  getScores()async{
    scores = await localDB(tableName: "SCORE").retrieveScore();
    if(scores.length==0){
      for(int i=3; i<=10;i++){
        gameInfo score = gameInfo(
          isLocked: i==3?0:1,
          duration: 0,
          row: i,
          steps: 0
        );
        scores.add(score);
        await localDB(tableName: "SCORE").saveScore(score);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Admob().myBannerAd..show(anchorType: AnchorType.bottom);
    return Scaffold(
      appBar: AppBar(
        title: Text("YenPuz", style:homeStyle),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.white,
        ),
        child: Container(
          height:height,
          width:width,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20)
          ),
          decoration: BoxDecoration(
            gradient: homeGrad,
            image: DecorationImage(
              image: AssetImage("assets/wood_wp.jpeg"),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            fit: StackFit.loose,
           children: [
            Positioned(
                left: ScreenUtil().setHeight(width/7),
                top: ScreenUtil().setHeight(70),
                child: Center(
                    child: new
                    Text("NumPuzzle",style: GoogleFonts.aladin(
                      fontSize: ScreenUtil().setSp(100),
                      color: Colors.blueGrey[100]
                    ),))),
            Positioned(
                right: ScreenUtil().setHeight(width/7),
                top: ScreenUtil().setHeight(70),
                child: Center(
                    child: new
                    Text("ImagePuzzle",style: GoogleFonts.aladin(
                        fontSize: ScreenUtil().setSp(100),
                        color: Colors.blueGrey[100]
                    ),))),

            Positioned(
              left: 0,
              top: ScreenUtil().setHeight(200),
              child: Container(
                width: width/2.1,
                height: width/2.1,
                margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                child: InkWell(
                  onTap: (){
                   Navigator.push(context, new MaterialPageRoute(
                       builder: (context)=>NumPuz(scores: scores,)));
                  },
                  child: Center(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1
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
                                  )
                              ),
                              child: Center(child: Text("${index+1}",style: homeStyle,)));
                        }
                      )),
                ),
              ),
            ),
             Positioned(
               right: 0,
               top: ScreenUtil().setHeight(200),
               child: Container(
                 width: width/2.1,
                 height: width/2.1,
                 margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   image: DecorationImage(
                     image: AssetImage("assets/adrienne-andersen.jpg"),
                     fit: BoxFit.cover
                   )
                 ),
                 child: Center(
                     child: GridView.builder(
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 3,
                         ),
                         itemCount: _itemCount,
                         itemBuilder: (context, index) {
                           // if(index == 8){return Container(color: Colors.brown,);}
                           return Container(
                             decoration: BoxDecoration(
                               color: Colors.white.withOpacity(0.1),
                               border: Border.all(color: Colors.white,
                                   style: BorderStyle.solid, width: ScreenUtil().setWidth(3))
                             ),
                           );
                         }
                     )),
               ),
             ),
             Positioned(
               right: 0,
               top: ScreenUtil().setHeight(200),
               child: Container(
                 width: width/2.1,
                 height: width/2.1,
                 color: Colors.transparent,
                 margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                 child: Icon(Icons.lock_outline,color: Colors.red,
                   size: ScreenUtil().setHeight(width),),
               ),
             ),
          ],
         )
     ),
      )
    );
  }
}
