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
  ValueNotifier<List> originalList = ValueNotifier([]);
  ValueNotifier<List> randomList = ValueNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    row = widget.row;
    size = row*row;
    matrixGenerator();
    super.initState();
  }

  matrixGenerator(){
    for(int i=1; i<=size;i++){
      originalList.value.add(i);
      randomList.value.add(i);
    }
    randomList.value.shuffle();
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
                    itemCount: randomList.value.length,
                    itemBuilder: (context,index){
                      ValueNotifier<int> data = ValueNotifier(0);
                      data.value = randomList.value[index];
                      if(randomList.value[index]==(randomList.value.length)){
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
                        child: InkWell(
                          onTap: (){
                            moveValidation(index);
                          },
                          child: Draggable(
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.none,
                                child: ValueListenableBuilder(
                                  valueListenable: data,
                                  builder: (context,value,widget){
                                    return Text(value.toString(),
                                      style: boardStyle.copyWith(fontSize: ScreenUtil().setSp(400)),);
                                  },
                                ),
                              ),
                            ),
                            feedback: Container(),
                            childWhenDragging: Container(),
                            onDragStarted: (){
                              moveValidation(index);
                            },
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

  moveValidation(int index){
    int temp = 0;
    int length = randomList.value.length;
    var _up = index-row;
    var _down = index + row;
    var _forward = index +1;
    var _backward = index - 1;
    int maxValue = length;

    if(index == 0){
      // top left item
      print("index : $index");
      if(randomList.value[_forward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_forward];
        randomList.value[_forward] = temp;
      }else if(randomList.value[_down]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_down];
        randomList.value[_down] = temp;
      }

    }else if(index == (row-1)){
      // top right item
      print("index : $index");
      if(randomList.value[_backward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_forward];
        randomList.value[_forward] = temp;
      }else if(randomList.value[_down]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_down];
        randomList.value[_down] = temp;
      }
    }else if((index + row)%row==0){
      //most left column
      print("index : $index");
      if(randomList.value[_forward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_forward];
        randomList.value[_forward] = temp;
      }else if(randomList.value[_down]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_down];
        randomList.value[_down] = temp;
      }else if(randomList.value[_up]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_up];
        randomList.value[_up] = temp;
      }
    }else if((index - (row-1))%row==0) {
      // most right column
      print("index : $index");
       if(randomList.value[_down]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_down];
        randomList.value[_down] = temp;
      }else if(randomList.value[_up]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_up];
        randomList.value[_up] = temp;
      }else if(randomList.value[_backward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_backward];
        randomList.value[_backward] = temp;
      }
    }else if((index>0)&(index<row-1)){
      // most top row
      print("index : $index");
      if(randomList.value[_forward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_forward];
        randomList.value[_forward] = temp;
      }else if(randomList.value[_down]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_down];
        randomList.value[_down] = temp;
      }else if(randomList.value[_backward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_backward];
        randomList.value[_backward] = temp;
      }
    }else if((index>(length-row-1))&(index<length)){
      // most bottom row
      print("index : $index");
      if(randomList.value[_forward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_forward];
        randomList.value[_forward] = temp;
      }else if(randomList.value[_up]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_up];
        randomList.value[_up] = temp;
      }else if(randomList.value[_backward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_backward];
        randomList.value[_backward] = temp;
      }
    }else if(index == (length-row+1)){
      //left bottom item
      print("index : $index");
      if(randomList.value[_forward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_forward];
        randomList.value[_forward] = temp;
      }else if(randomList.value[_up]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_up];
        randomList.value[_up] = temp;
      }
    }else if(index == length){
      // right bottom item
       if(randomList.value[_up]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_up];
        randomList.value[_up] = temp;
      }else if(randomList.value[_backward]==maxValue){
        temp = randomList.value[index];
        randomList.value[index] = randomList.value[_backward];
        randomList.value[_backward] = temp;
      }
    }else{
      print("index : $index");
    }
  }

}
