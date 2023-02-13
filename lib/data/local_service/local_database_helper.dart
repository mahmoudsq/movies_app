import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../core/string.dart';

class DBHelper{
  factory DBHelper() => _instance;
  DBHelper.internal();
  static final DBHelper _instance = DBHelper.internal();
  static Database? _db;

  Future<Database> createDataBase() async{
    if(_db != null){
      return _db!;
    }else{
      String path = join(await getDatabasesPath(), 'MoviesLocal.db');
      _db = await openDatabase(path,version: 2,onCreate: initDB);
      return _db!;
    }
  }
  Future<void> deleteDatabase() async{
    String path = join(await getDatabasesPath(), 'MoviesLocal.db');
    databaseFactory.deleteDatabase(path);
  }

  void initDB (Database db,int v) async{
      await db.execute('create table $localMoviesTable(movieId integer primary key AUTOINCREMENT,title text,'
        'release_date text,vote_average real,overview text,backdrop_path text,poster_path text,'
          'id integer)');
  }

  Future<int> insertToTable({required String table,required Map<String, dynamic> row}) async{
    try{
      Database db = await createDataBase();
      int id = await db.insert(table, row);
      return id;
    }catch(e){
      debugPrint('Insert To Table Error: $e');
      rethrow;
    }

  }

  Future<int> insertQuery({required String query,required List<Object?> arg}) async{
    try{
      Database db = await createDataBase();
      int id = await db.rawInsert(query,arg);
      return id;
    }catch(e){
      debugPrint('Insert To Table Error: $e');
      rethrow;
    }

  }

  Future<dynamic> getFromTable(String table) async{
    try{
      Database db = await createDataBase();
      return db.query(table);
    }catch(e){
      debugPrint('Get From Table Error: $e');
    }
  }

  Future<dynamic> getLastRow(String table) async{
    try{
      Database db = await createDataBase();
      return db.rawQuery("SELECT * FROM $table ORDER BY id DESC LIMIT 1");
    }catch(e){
      debugPrint('Get From Table Error: $e');
    }
  }

  Future<void> cleanLocalDatabase(List<String> tables) async{
    Database db = await createDataBase();
    await db.transaction((txn) async{
      var batch = txn.batch();
      for(int i = 0; i<tables.length; i++){
        batch.delete(tables[i]);
      }
      await batch.commit();
    });
  }


  Future<int> delete({required String table,required int id}) async {
    Database db = await createDataBase();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update({required String table,required Map<String, dynamic> row,
    required int id}) async {
    Database db = await createDataBase();
    return await db.update(table, row,
        where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await createDataBase();
    dbClient.close();
  }
}