import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:soundpool/soundpool.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Logic/gameCompleted.dart';
import 'package:yenpuz/Logic/gameLogic.dart';
import 'package:yenpuz/Notifications/Sound.dart';
import 'package:yenpuz/Notifications/Timer.dart';
import 'package:yenpuz/Notifications/onCompleted.dart';

class GameBoard extends StatefulWidget {
  int row;
  double fontSize;
  GameBoard({required this.row, required this.fontSize});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  int row = 0; int size = 0;
  double fontSize = 0;
  ValueNotifier<List> originalList = ValueNotifier([]);
  ValueNotifier<List> randomList = ValueNotifier([]);
  ValueNotifier<bool> isFinished = ValueNotifier(false);

  int newIndex = 0; int steps = 0; String time = '';
  int seconds = 0; int minutes = 0; int hours = 0;
  Timer _timer = Timer(Duration(seconds: 0),(){});
  Soundpool _soundPool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.ring));
  late Future<int> _soundId ;


  @override
  void initState() {
    // TODO: implement initState
    row = widget.row;
    size = row*row;
    fontSize = widget.fontSize;
    _matrixGenerator();
    startTimer();
    _soundId = loadSound();
    super.initState();
  }

  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  _matrixGenerator(){
    for(int i=1; i<=size;i++){
      originalList.value.add(i);
      randomList.value.add(i);
    }
    randomList.value.shuffle();
  }

  Future<int> loadSound() async {
    var asset = await rootBundle.load("assets/clicked.mp3");
    return await _soundPool.load(asset);
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
                      child: Text("$row x $row",style: boardTileStyle,),),
                    Card(
                      child: new Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          bottom: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setHeight(40),
                          right: ScreenUtil().setHeight(40),
                        ),
                        color: Colors.brown,
                        child: Text("steps : $steps",style: boardTileStyle,),),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: ScreenUtil().setHeight(200),
                child: Container(
                  width: width,
                  child: CircleAvatar(
                    radius: ScreenUtil().setWidth(150),
                    backgroundColor: Colors.redAccent[200],
                    child: !isFinished.value?Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new SizedBox(height: ScreenUtil().setHeight(20),),
                        new Text("Timer",style: boardTimerStyle,),
                        new SizedBox(height: ScreenUtil().setHeight(60),),
                        new Text(_timeFormat,style: boardTimerStyle,),
                      ],
                    ):InkWell(
                      onTap: (){

                        setState(() {
                          randomList.value.clear();
                          originalList.value.clear();
                          isFinished.value = false;
                        });
                        _matrixGenerator();
                        startTimer();
                        print(randomList.value);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         new Text("Replay",style: boardTimerStyle,)
                        ],
                      ),
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

                      if(randomList.value[index]==(randomList.value.length)){
                        return Container();
                      }
                      return InkWell(
                        onTap: (){
                        _stateController(index);
                        },
                        child: Draggable(
                          data: index,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/wood_wp1.jpeg"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: FittedBox(
                              fit: BoxFit.none,
                              child: Center(
                                child: Text(randomList.value[index].toString(),
                                  style: boardStyle.copyWith(fontSize: ScreenUtil().setSp(fontSize)),),
                              ),
                            ),
                          ),
                          feedback: Container(),
                          childWhenDragging: Container(),
                          onDragStarted: (){
                           _stateController(index);
                          },
                        ),
                      );
                    }),
              ),
            )
          ],),
        ),
      )
    );
  }

  /// Make the exchange of the items
  void _replace(int index, int newIndex){
    int temp = 0;
    setState(() {
      temp = randomList.value[index];
      randomList.value[index] = randomList.value[newIndex];
      randomList.value[newIndex] = temp;
    });
  }

  /// Start the up counter
 String _timeFormat = '00:00:00';
  String hr = '00';
  String mn = '00';
  String ss = '00';
  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(() {
          if (seconds < 0) {
            timer.cancel();
          } else {
            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
          hr = hours<10?"0$hours:":"$hours:";
          mn = minutes<10?"0$minutes:":"$minutes:";
          ss = seconds<10?"0$seconds":"$seconds";
          _timeFormat = hr + mn + ss;
        });
      },
    );
  }

  /// Check the different conditions
  _stateController(int index)async{
    setState(() {
      newIndex = moveValidation(index, row, randomList);
    });
    _replace(index, newIndex);
    bool isCompleted = completed(context,size, randomList, originalList);
    if(isCompleted){
      _timer.cancel();
      Future.delayed(Duration(milliseconds: 800),(){
        finished(context, _timeFormat, steps.toString(),_timeFormat);
        setState(() {
          isFinished.value = true;

        });
      });
    }
    if(index!=newIndex){
      setState(() {
        steps+=1;
      });
      await Sound(soundId: _soundId, soundpool: _soundPool,).playSound();
    }
  }

}
