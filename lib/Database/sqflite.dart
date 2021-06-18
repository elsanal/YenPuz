import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yenpuz/Database/gameClass.dart';

// ignore: camel_case_types
class localDB{

  String  tableName;
  late Database db ;
  localDB({required this.tableName});

  init(int delay)async{
    db = await Future.delayed(Duration(milliseconds: delay), ()=>database());
    return db;
  }

////// create a table
  Future<Database> database()async{
    return openDatabase(
      join(await getDatabasesPath(),"YENPUZ"),
      onCreate: (Database dB, int version){
        print("created");
        return dB.execute("CREATE TABLE $tableName("
            "id INTEGER,"
            "row INTEGER,"
            "steps INTEGER,"
            "duration INTEGER,"
            "isLocked INTEGER"
            ")");
      },
      version: 1,
    );
  }

  /// Save the new score to the database

  Future saveScore(gameInfo score)async{
    var req = await init(1000);
    req.insert('$tableName', score.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
    print("Saved on $tableName");
    return true;
  }

  /// Restore all the score in stored in the table

  Future<List<gameInfo>> retrieveScore()async{
    var request  = await init(500);
    List<gameInfo> scores = [];
    List<Map<String, dynamic>> list = await request.query('$tableName');
    list.forEach((score) {
      gameInfo myScore = gameInfo.fromJson(score);
      scores.add(myScore);
    });
    print("Got data from table : $tableName");
    return scores;
  }
  Future<gameInfo> retrieveOneScore(int id)async{
    var request  = await init(500);
    Map<String, dynamic> score = await request.query('$tableName',where:"id = ?",whereArgs:[id]);
    gameInfo myScore = gameInfo.fromJson(score);
    print("Got data from table : $tableName");
    return myScore;
  }

  /// update the scores
  Future updateScore(List<gameInfo> scores)async{
    var request  = await init(500);
    for(int i = 0; i<scores.length;i++){
      await request.update("$tableName",scores[i].toMap(),
          where: "id = ?", whereArgs: [scores[i].id],conflictAlgorithm: ConflictAlgorithm.replace,);
      print("Update of element ID : ${scores[i].id} $tableName");
    }
  }

}