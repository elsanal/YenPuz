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

  int _itemCount = 9;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("YenPuz", style:homeStyle),
        centerTitle: true,
        backgroundColor: Colors.red[900],
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
          Center(child: new Text("NumPuz",style: homeStyle.copyWith(color: Colors.white),)),
          Center(child: new Text("ImPuz",style: homeStyle.copyWith(color: Colors.white),)),

          new Card(
            elevation: 5.0,
            child: InkWell(
              onTap: (){
               Navigator.push(context, new MaterialPageRoute(
                   builder: (context)=>NumPuz()));
              },
              child: Center(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1
                    ),
                    itemCount: _itemCount,
                    itemBuilder: (context, index) {
                      if(index == 8){return Container(color: Colors.brown,);}
                      return Container(
                        color: Colors.red,
                          child: Center(child: Text("${index+1}",style: homeStyle,)));
                    }
                  )),
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
