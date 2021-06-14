import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenpuz/Decoration.dart';

class GameBoard extends StatefulWidget {
  int row;
  GameBoard(this.row);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  int row = 0;
  int size = 0;

  @override
  void initState() {
    // TODO: implement initState
    row = widget.row;
    size = row*row;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wood_wp.jpeg"),
              fit: BoxFit.cover
            )
          ),
          child: Stack(children: [
            Positioned(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(0),
              right: ScreenUtil().setWidth(0),
              child: Container(
                width: width,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new InkWell(
                      onTap:()=>Navigator.of(context).pop(true),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            bottom: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setHeight(40),
                            right: ScreenUtil().setHeight(40),
                          ),
                            color: Colors.brown,
                            child: new Text("Back",style: boardTileStyle,)),
                      ),),
                    new Container(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        bottom: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setHeight(40),
                        right: ScreenUtil().setHeight(40),
                      ),
                      color: Colors.brown,
                      child: Text("Matrix",style: boardTileStyle,),),
                    Card(
                      child: new Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          bottom: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setHeight(40),
                          right: ScreenUtil().setHeight(40),
                        ),
                        color: Colors.brown,
                        child: Text("Steps",style: boardTileStyle,),),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: ScreenUtil().setHeight(200),
                // left: ScreenUtil().setWidth(0),
                // right: ScreenUtil().setWidth(0),
                child: Container(
                  width: width,
                  child: CircleAvatar(
                    radius: ScreenUtil().setWidth(150),
                    backgroundColor: Colors.redAccent[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new SizedBox(height: ScreenUtil().setHeight(20),),
                        new Text("Timer",style: boardTimerStyle,),
                        new SizedBox(height: ScreenUtil().setHeight(60),),
                        new Text("98 : 12 : 34",style: boardTimerStyle,)
                      ],
                    ),
                  ),
                )
            ),

            Positioned(
              top: ScreenUtil().setHeight(550),
              left: ScreenUtil().setWidth(0),
              right: ScreenUtil().setWidth(0),
              child: Container(
                width: width,
                height: width,
                padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  border: Border.all(
                    width: ScreenUtil().setWidth(30),
                    style: BorderStyle.solid,
                    color: Colors.red.shade900
                  )
                ),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: row,
                      crossAxisSpacing: ScreenUtil().setWidth(5),
                      mainAxisSpacing: ScreenUtil().setHeight(5)
                    ),
                    itemCount: size,
                    itemBuilder: (context,index){
                      var value = index +1;
                      if(index==size-1){
                        return Container();
                      }
                      return Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/wood_wp1.jpeg"),
                            fit: BoxFit.cover
                          )
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Text("$value",
                              style: boardStyle.copyWith(fontSize: ScreenUtil().setSp(400)),),
                          ),
                        )
                      );
                    }),
              ),
            )
          ],),
        ),
      )
    );
  }


}
