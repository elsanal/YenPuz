//@dart=2.9
// ignore: camel_case_types
class gameInfo{
  int id = 0;
  int steps = 0;
  int duration = 0;
  int row = 0;
  int isLocked = 1;

  gameInfo({this.isLocked, this.row, this.duration, this.steps, this.id});

  Map<String, dynamic>toMap(){
    return {
      'id':id,
      'steps':steps,
      'duration':duration,
      'row':row,
      'isLocked':isLocked
    };
  }

  factory gameInfo.fromJson(Map<String, dynamic> map)=> new gameInfo(
      id:map['id'],
      steps:map['steps'],
      duration:map['duration'],
      row:map['row'],
      isLocked:map['isLocked']
  );

}