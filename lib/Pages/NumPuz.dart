//@dart=2.9
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Database/gameClass.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Pages/GameBoard.dart';

class NumPuz extends StatefulWidget {
  List<gameInfo> scores;
  NumPuz({ this.scores});

  @override
  _NumPuzState createState() => _NumPuzState();
}

class _NumPuzState extends State<NumPuz> {

  List<gameInfo> scores = [];

  @override
  void initState() {
    // TODO: implement initState
    scores = widget.scores;
    Admob().myBannerAd..load();
    super.initState();
  }

  @override

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
        child: new GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: ScreenUtil().setWidth(20),
              mainAxisSpacing: ScreenUtil().setHeight(20),
              childAspectRatio: 3
            ),
            itemCount: scores.length,
            itemBuilder: (context,index){
              return matrix(context,scores[index]);
            }
        ),

      ),
    );
  }
}

Widget matrix(BuildContext context,gameInfo score){

  return Stack(
    children: [
      InkWell(
        onTap: (){
          if(score.isLocked == 0){
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
  );
}

