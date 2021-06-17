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
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
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
    return scores;
  }

  /// update the scores
  Future updateScore(gameInfo score)async{
    var req = await db;
    await req.update("$tableName",score.toMap(), where: "row = ?", whereArgs: [score.row]);
  }

}