import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Pages/NumPuz.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("YenPuz", style:homeStyle),
        centerTitle: true,
        backgroundColor: Colors.brown.shade600,
      ),
      body: Container(
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
        child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: ScreenUtil().setWidth(10),
        mainAxisSpacing: ScreenUtil().setHeight(10)
        ),
        children: [
          new Card(
            child: InkWell(
              onTap: (){
               Navigator.push(context, new MaterialPageRoute(
                   builder: (context)=>NumPuz()));
              },
              child: Center(
                  child: Text("NumPuz",style: homeStyle,)),
            ),),
          new Card(
            child: InkWell(
              onTap: (){
                print("ImagePuz");
              },
              child: Center(
                  child: Text("ImagePuz",style: homeStyle,)),
            ),)
        ],
       )
     )
    );
  }
}
