//@dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:soundpool/soundpool.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Database/gameClass.dart';
import 'package:yenpuz/Database/sqflite.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Logic/gameCompleted.dart';
import 'package:yenpuz/Logic/gameLogic.dart';
import 'package:yenpuz/Notifications/Sound.dart';
import 'package:yenpuz/Notifications/help.dart';
import 'package:yenpuz/Pages/NumPuz.dart';

class GameBoard extends StatefulWidget {
  double fontSize;
  gameInfo score;
  int index;
  GameBoard({this.fontSize, this.score,this.index});
  @override
  _GameBoardState createState() => _GameBoardState();
}



class _GameBoardState extends State<GameBoard> {

  int row = 0; int size = 0;int bestDuration = 0; int id = 0;
  double fontSize = 0;gameInfo score; int levelIndex = 0;
  Future<int> _soundId;
  ValueNotifier<List> originalList = ValueNotifier([]);
  ValueNotifier<List> randomList = ValueNotifier([]);
  ValueNotifier<bool> isFinished = ValueNotifier(false);
  ValueNotifier<bool> isMuted = ValueNotifier(false);

  int newIndex = 0; int steps = 0; String time = '';
  int seconds = 0; int minutes = 0; int hours = 0;
  List<gameInfo> scores = [];
  // bool isReplay = true;
  Timer _timer = Timer(Duration(seconds: 0),(){});
  Soundpool _soundPool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.ring));
  BannerAd _bannerAd = Admob().myBannerAd;


  @override
  void initState() {
    // TODO: implement initState
    score = widget.score;
    levelIndex = widget.index;
    row = score.row;
    id = score.id;
    bestDuration = score.duration;
    fontSize = widget.fontSize;
    _matrixGenerator(row);
    startTimer();
    _soundId = loadSound();
    _bannerAd..load();
    super.initState();
  }

  void dispose(){
    _timer.cancel();
    _soundPool.dispose();
    _bannerAd..dispose();
    super.dispose();
  }

  _matrixGenerator(int row){
    for(int i=1; i<=(row*row);i++){
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
    if((scores.length == 0)||(isFinished.value == true)){
      getScores();
    }
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.red,
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
                      onTap:()async{
                        getScores();
                        Admob().myVideoAdLoading();
                        Future.delayed(Duration(milliseconds: 500),(){
                          Navigator.pushReplacement(context, new MaterialPageRoute(
                              builder: (context)=>NumPuz(scores: scores,)));
                        });

                      },
                      child: Card(
                        color: Colors.red.withOpacity(0.3),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            bottom: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setHeight(40),
                            right: ScreenUtil().setHeight(40),
                          ),
                            child: new Text("Back",style: boardTileStyle,)),
                      ),),
                    Card(
                      color: Colors.red.withOpacity(0.3),
                      child: new Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          bottom: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setHeight(40),
                          right: ScreenUtil().setHeight(40),
                        ),
                        child: Text("$row x $row",style: boardTileStyle,),),
                    ),
                    Card(
                      color: Colors.red.withOpacity(0.3),
                      child: new Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          bottom: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setHeight(40),
                          right: ScreenUtil().setHeight(40),
                        ),
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
                    child: isFinished.value==false?Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new SizedBox(height: ScreenUtil().setHeight(20),),
                        new Text("Timer",style: boardTimerStyle,),
                        new SizedBox(height: ScreenUtil().setHeight(60),),
                        new Text(_timeFormat,style: boardTimerStyle,),
                      ],
                    ):InkWell(
                      onTap: ()async{
                        await _replay(true);
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
              top: ScreenUtil().setHeight(180),
              right: ScreenUtil().setHeight(45),
              child: Card(
                color: Colors.red.withOpacity(0.3),
                child: Container(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    bottom: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setHeight(40),
                    right: ScreenUtil().setHeight(40),
                  ),
                  child: isMuted.value?InkWell(
                    onTap: ()async{
                      setState(() {
                        isMuted.value = false;
                      });
                      await Sound(soundId: _soundId, soundpool: _soundPool,).updateVolume(1.0);
                    },
                    child: Icon(Icons.volume_off,size: ScreenUtil().setHeight(80),color: Colors.white,),
                  ):InkWell(
                    onTap: ()async{
                      setState(() {
                        isMuted.value = true;
                      });
                      await Sound(soundId: _soundId, soundpool: _soundPool,).updateVolume(0.0);
                    },
                    child: Icon(Icons.volume_up,size: ScreenUtil().setHeight(80),color: Colors.white,),
                  ),
                ),
              )
            ),
            Positioned(
                top: ScreenUtil().setHeight(180),
                left: ScreenUtil().setHeight(45),
                child: Card(
                  color: Colors.red.withOpacity(0.3),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(20),
                      bottom: ScreenUtil().setHeight(20),
                      left: ScreenUtil().setHeight(40),
                      right: ScreenUtil().setHeight(40),
                    ),
                    child: InkWell(
                      onTap: ()=>Help(context, row),
                      child: Text("Help",style:boardTimerStyle,),
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
                        _stateController(index,id);
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
                          childWhenDragging: Container(
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
                          onDragStarted: (){
                           _stateController(index,id);
                          },
                        ),
                      );
                    }),
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
          ],),
        ),
      ),
    );
  }

  /// Make the exchange of the items
  void _replace(int itemIndex, int newIndex){
    int temp = 0;
    setState(() {
      temp = randomList.value[itemIndex];
      randomList.value[itemIndex] = randomList.value[newIndex];
      randomList.value[newIndex] = temp;
    });
  }

  /// Start the up counter
 String _timeFormat = '00:00:00';
  int newDuration = 0;

  startTimer() {
    String hr = '00';
    String mn = '00';
    String ss = '00';
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
  
  /// time format

  String _formatTime(int duration){
    int hr =0;
    int mn =0;
    int ss =0;
    String hour = '';
    String minute = '';
    String second = '';

    setState(() {
      hr = (duration~/360).toInt();
      mn = ((duration - (hr*360))~/60).toInt();
      ss = duration - ((mn*60) + (hr*360));
      hour = hr<10?"0$hr:":"$hr:";
      minute = mn<10?"0$mn:":"$mn:";
      second = ss<10?"0$ss":"$ss";
    });

    return (hour + minute + second);
  }

  /// Check the different conditions
  _stateController(int itemIndex, int id)async{
    setState(() {
      newIndex = moveValidation(itemIndex, row, randomList);
    });
    _replace(itemIndex, newIndex);
    bool isCompleted = completed(context,(row*row), randomList, originalList);
    if(isCompleted){
      _timer.cancel();
      newDuration= hours*360 + minutes*60 + seconds;
      if((score.duration > newDuration)||(score.duration == 0)){
        setState(() {
          bestDuration = newDuration;
        });
        List<gameInfo> scores = [
          gameInfo(id : id,isLocked: 0, row: row, duration: bestDuration, steps: steps),
          gameInfo(id : (id+1).toInt(),isLocked: 0, row: (row+1).toInt(), duration: 0, steps: 0)
        ];
        await localDB(tableName: "SCORE").updateScore(scores);
      }
      Future.delayed(Duration(milliseconds: 500),()async{
        setState(() {
          isFinished.value = true;
          _finished(context, _timeFormat,steps,_formatTime(bestDuration));
        });
      });
    }
    if(itemIndex!=newIndex){
      setState(() {
        steps+=1;
      });
      await Sound(soundId: _soundId, soundpool: _soundPool,).playSound();
    }
  }

  Future _replay(bool isReplay)async{
    setState(() {
      minutes =0;hours =0;seconds =0;steps=0;
      _timeFormat = '00:00:00';
      isFinished.value = false;
    });
    if(isReplay == true){
      randomList.value.clear();
      originalList.value.clear();
      _matrixGenerator(row);
      startTimer();
      score = scores[levelIndex];
    }else if(isReplay == false){
      if(levelIndex<10){
        row +=1;
        levelIndex +=1;
        id +=1;
      }
      fontSize = (900/score.row);
      randomList.value.clear();
      originalList.value.clear();
      _matrixGenerator((row).toInt());
      startTimer();
      score = scores[levelIndex];
    }

  }

  getScores()async{
    scores = await localDB(tableName: "SCORE").retrieveScore();
    print(scores);
  }

  _finished(BuildContext context,String newDuration,
      int steps, String bestDuration){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Admob().myVideoAdLoading();
    isFinished.value = true;
    Alert(
      title: "Congratulation!!!",
      context: context,
      onWillPopActive: false,
      style: AlertStyle(
          backgroundColor: Colors.white.withOpacity(0.1),
          titleStyle: alertFinishedTitleStyle,
          descStyle: alertFinishedStyle
      ),
      buttons: [
        DialogButton(
            color: Colors.white.withOpacity(0.5),
            child: Text("Replay",style: alertFinishedTitleStyle,),
            onPressed: (){
              setState(() {
                _timeFormat = '00:00:00';
                isFinished.value = false;
              });
              _replay(true);
              startTimer();
              Navigator.of(context).pop(true);
            }),
        DialogButton(
            color: Colors.white.withOpacity(0.5),
            child: Text("Next",style: alertFinishedTitleStyle,),
            onPressed: (){
              setState(() {
                isFinished.value = false;
                _timeFormat = '00:00:00';
              });
              _replay(false);
              startTimer();
              Navigator.of(context).pop(true);
            }),
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
            new Text("Steps : "+steps.toString(),style: alertFinishedStyle,),
            new Text("Time : "+newDuration.toString(),style: alertFinishedStyle,),
            new Text("Best time : "+bestDuration.toString(),style: alertFinishedStyle,),
          ],
        ),
      ),
    )..show();
  }

}
