//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenpuz/Database/admob.dart';
import 'package:yenpuz/Pages/Homepage.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Admob().adInit();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom,]);
  runApp(YenPuz());
}

class YenPuz extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080,1920),
      builder:()=> MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homepage()
      ),
    );
  }
}



