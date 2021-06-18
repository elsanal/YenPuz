//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Database/gameClass.dart';
import 'package:yenpuz/Database/sqflite.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Pages/GameBoard.dart';

class NumPuz extends StatefulWidget {
  List<gameInfo> scores;
  NumPuz({this.scores});
  @override
  _NumPuzState createState() => _NumPuzState();
}

class _NumPuzState extends State<NumPuz> {

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
    scores = widget.scores;
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("YenPuz", style:homeStyle),
        centerTitle: true,
        backgroundColor: Colors.red[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,size: ScreenUtil().setWidth(50),),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wood_wp.jpeg"),
            fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height,
                width: width,
                child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenUtil().setWidth(20),
                      mainAxisSpacing: ScreenUtil().setHeight(20),
                      childAspectRatio: 3
                    ),
                    itemCount: scores.length,
                    itemBuilder: (context,index){
                      print("$index");
                      return matrix(context,scores[index]);
                    }
                ),
              ),
            ),
            Positioned(
                bottom: ScreenUtil().setHeight(20),
                left: 0,
                right: 0,
                child: Container(
                  height: ScreenUtil().setHeight(150),
                  width: width,
                  child: AdWidget(ad: _bannerAd),
                )
            )
          ],
        ),

      ),
    );
  }


Widget matrix(BuildContext context,gameInfo score){
  return Stack(
    children: [
      InkWell(
        onTap: (){
          if(score.isLocked == 0){
            getScores();
            Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>GameBoard(score: score,fontSize: (900/score.row),)));
          }
        },
        child: Card(
          child: Center(child: Text("Matrix "+"${score.row}"+"x"+"${score.row}",
            style: numPuzStyle,),),
        ),
      ),
      score.isLocked==1?Positioned(
          right: ScreenUtil().setHeight(15),
          top: ScreenUtil().setHeight(20),
          child: new Icon(Icons.lock_outline,color: Colors.amber,)
      ):Container()
     ],
   ) ;
  }
 }

