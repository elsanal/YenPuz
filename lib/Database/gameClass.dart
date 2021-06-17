// ignore: camel_case_types
class gameInfo{

  int steps = 0;
  int duration = 0;
  int row = 0;
  int isLocked = 1;

  gameInfo({required this.isLocked,
            required this.row,
            required this.duration,
            required this.steps});

  Map<String, dynamic>toMap(){
    return {
      'steps':steps,
      'duration':duration,
      'row':row,
      'isLocked':isLocked
    };
  }

  factory gameInfo.fromJson(Map<String, dynamic> map)=> new gameInfo(
      steps:map['steps'],
      duration:map['duration'],
      row:map['row'],
      isLocked:map['isLocked']
  );

}