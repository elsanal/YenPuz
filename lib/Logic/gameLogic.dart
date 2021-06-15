import 'package:flutter/material.dart';

int moveValidation(int index,int row, ValueNotifier<List> randomList){
  int newIndex = index;
  int length = randomList.value.length;
  var _up = index-row;
  var _down = index + row;
  var _forward = index +1;
  var _backward = index - 1;
  int maxValue = length;

  if(index == 0){
    // top left item
    print("index : $index top left item");
    if(randomList.value[_forward]==maxValue){
     newIndex = _forward;
    }else if(randomList.value[_down]==maxValue){
      newIndex = _down;
    }
  }else if(index == (length - 1)){
    // right bottom item
    print("index : $index right bottom item");
    if(randomList.value[_up]==maxValue){
      newIndex = _up;
    }else if(randomList.value[_backward]==maxValue){
      newIndex = _backward;
    }
  }else if(index == (length-row)){
    //left bottom item
    print("index : $index left bottom item");
    if(randomList.value[_forward]==maxValue){
      newIndex = _forward;
    }else if(randomList.value[_up]==maxValue){
      newIndex = _up;
    }
  }else if(index == (row-1)){
    // top right item
    print("index : $index top right item");
    if(randomList.value[_backward]==maxValue){
      newIndex = _backward;
    }else if(randomList.value[_down]==maxValue){
      newIndex = _down;
    }
  }
  else if((index + row)%row==0){
    //most left column
    print("index : $index most left column");
    if(randomList.value[_forward]==maxValue){
      newIndex = _forward;
    }else if(randomList.value[_down]==maxValue){
      newIndex = _down;
    }else if(randomList.value[_up]==maxValue){
      newIndex = _up;
    }
  }else if((index - (row-1))%row==0) {
    // most right column
    print("index : $index most right column");
    if(randomList.value[_down]==maxValue){
      newIndex = _down;
    }else if(randomList.value[_up]==maxValue){
      newIndex = _up;
    }else if(randomList.value[_backward]==maxValue){
      newIndex = _backward;
    }
  }else if((index>0)&(index<(row-1))){
    // most top row
    print("index : $index most top row");
    if(randomList.value[_forward]==maxValue){
      newIndex = _forward;
    }else if(randomList.value[_down]==maxValue){
      newIndex = _down;
    }else if(randomList.value[_backward]==maxValue){
      newIndex = _backward;
    }
  }else if((index>(length-row))&(index<(length-1))){
    // most bottom row
    print("index : $index most bottom row");
    if(randomList.value[_forward]==maxValue){
      newIndex = _forward;
    }else if(randomList.value[_up]==maxValue){
      newIndex = _up;
    }else if(randomList.value[_backward]==maxValue){
      newIndex = _backward;
    }
  }else{
    // middle items
    print("index : $index middle items");
    if(randomList.value[_forward]==maxValue){
      newIndex = _forward;
    }else if(randomList.value[_up]==maxValue){
      newIndex = _up;
    }else if(randomList.value[_backward]==maxValue){
      newIndex = _backward;
    }else if(randomList.value[_down]==maxValue){
      newIndex = _down;
    }
  }
  return newIndex;
}