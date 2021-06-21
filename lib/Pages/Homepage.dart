//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Database/gameClass.dart';
import 'package:yenpuz/Database/sqflite.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Notifications/nextVersion.dart';
import 'package:yenpuz/Pages/NumPuz.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _itemCount = 9;
  List<gameInfo> scores = [];
  BannerAd _bannerAd = Admob().myBannerAd;

  getScores()async{
    scores = await localDB(tableName: "SCORE").retrieveScore();
    if(scores.length==0){
      for(int i=3; i<=10;i++){
        gameInfo score = gameInfo(
          isLocked: i==3?0:1,
          duration: 0,
          row: i,
          steps: 0,
          id: (i-3)
        );
        scores.add(score);
        await localDB(tableName: "SCORE").saveScore(score);
      }
    }
    print(scores);
  }
  @override
  void initState() {
    // TODO: implement initState
    getScores();
    Admob().myInterstitialAd();
    _bannerAd..load();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    getScores();
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
        child: WillPopScope(
          onWillPop: (){
            return showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                        title: Text('Are you leaving YenPuz?',
                        style: homeStyle.copyWith(color: Colors.black87, fontSize: ScreenUtil().setSp(60)),),
                        backgroundColor:Colors.grey[100],
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                child: Text('yes',style: homeStyle.copyWith(color: Colors.black87, fontSize: ScreenUtil().setSp(60))),
                                onPressed: ()async{
                                  return Navigator.of(context).pop(true);
                                },),
                              ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                  child: Text('cancel',style: homeStyle.copyWith(color: Colors.black87, fontSize: ScreenUtil().setSp(60))),
                                  onPressed: () => Navigator.of(context).pop(false)),
                            ],
                          )
                    ]));
          },
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
                   child: InkWell(
                     onTap: ()=>NextVersion(context),
                     child: Icon(Icons.lock_outline,color: Colors.red,
                       size: ScreenUtil().setHeight(width),),
                   ),
                 ),
               ),
               Positioned(
                 bottom: ScreenUtil().setHeight(10.0),
                   left: 0,
                   right: 0,
                   child: Container(
                     height: ScreenUtil().setHeight(250),
                     width: width,
                     child: AdWidget(ad: _bannerAd),
                   )
               )
            ],
           )
     ),
        ),
      )
    );
  }
}
