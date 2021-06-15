import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


Gradient homeGrad = new LinearGradient(
  begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.brown,
      Colors.deepOrange,Colors.brown,]
);

TextStyle homeStyle = GoogleFonts.permanentMarker(
      fontSize: ScreenUtil().setSp(100),
      fontWeight: FontWeight.w600,
      color: Colors.black
);

TextStyle numPuzStyle = GoogleFonts.permanentMarker(
    fontSize: ScreenUtil().setSp(70),
    fontWeight: FontWeight.w400,
    color: Colors.black
);

TextStyle boardStyle = GoogleFonts.herrVonMuellerhoff(
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey[100]
);

TextStyle boardTileStyle = GoogleFonts.monoton(
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(50),
    color: Colors.blueGrey[100]
);

TextStyle boardTimerStyle = GoogleFonts.monoton(
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(40),
    color: Colors.blueGrey[100]
);

TextStyle alertFinishedStyle = GoogleFonts.shadowsIntoLight(
    fontWeight: FontWeight.w400,
    fontSize: ScreenUtil().setSp(60),
    color: Colors.blueGrey[100]
);

TextStyle alertFinishedTitleStyle = GoogleFonts.monoton(
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(60),
    color: Colors.blueGrey[100]
);