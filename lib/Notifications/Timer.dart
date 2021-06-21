import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yenpuz/Decoration.dart';


class CountUpTimer extends StatefulWidget {
  @override
  _CountUpTimerState createState() => _CountUpTimerState();
}

class _CountUpTimerState extends State<CountUpTimer> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  Timer _timer = Timer(Duration(seconds: 0),(){});

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(hours<10?"0$hours:":"$hours:",style:  boardTimerStyle,),
          new Text(minutes<10?"0$minutes:":"$minutes:",style:  boardTimerStyle,),
          new Text(seconds<10?"0$seconds":"$seconds",style:  boardTimerStyle,),
        ],
      ),
    );
  }

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
        });
      },
    );
  }
}


