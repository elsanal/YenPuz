import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenpuz/Decoration.dart';
import 'package:yenpuz/Pages/GameBoard.dart';

class NumPuz extends StatefulWidget {
  const NumPuz({Key? key}) : super(key: key);

  @override
  _NumPuzState createState() => _NumPuzState();
}

class _NumPuzState extends State<NumPuz> {


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
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
          child: new GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: ScreenUtil().setWidth(20),
                mainAxisSpacing: ScreenUtil().setHeight(20),
                childAspectRatio: 3
              ),
              itemCount: 8,
              itemBuilder: (context,index){
                int row = index +3;
                return InkWell(
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context)=>GameBoard(row: row,fontSize: (900/row),)));
                  },
                    child: matrix(index+3));
              }
          ),

        ),
      ),
    );
  }
}

Widget matrix(int row){
  return Card(
    child: Center(child: Text("Matrix "+"$row"+"x"+"$row",
      style: numPuzStyle,),),
  );
}

