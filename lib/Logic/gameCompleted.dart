import 'package:flutter/cupertino.dart';
import 'package:yenpuz/Notifications/onCompleted.dart';

bool completed(BuildContext context,int size, ValueNotifier<List> randomList,
                ValueNotifier<List> originalList){
  bool isCompleted = true;
  for(int i=0; i<size;i++){
    if(randomList.value[i]!=originalList.value[i]){
      isCompleted = false;
    }
  }
  return isCompleted;
}