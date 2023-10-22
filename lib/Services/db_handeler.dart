import 'package:bmi_calculation_app/Services/activity_model_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }

    _db = await initDatabase();
    return _db;
  }

  initDatabase()async{

    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path , version: 1 ,onCreate: _onCreate);
    return db;
  }

  _onCreate (Database db, int version)async{
    await db.execute(
      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT NOT NULL , weight TEXT NOT NULL , height TEXT NOT NULL , gender TEXT ,bmi TEXT , wakeupTime TEXT , gym TEXT , meditation TEXT , reading TEXT)",
    );
  }

  Future<ActivitiesModel> insert(ActivitiesModel notesModel) async{
    var dbClient = await db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }

  Future<List<ActivitiesModel>> getNotesList () async{
    var dbClient = await db;
    final List<Map<String , Object?>> queryResult = await dbClient!.query('notes');

    return queryResult.map((e) => ActivitiesModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'notes' , where:'id = ?',
        whereArgs:[id]
    );
  }
}