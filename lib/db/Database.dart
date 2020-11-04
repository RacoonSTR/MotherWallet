import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  String _path = 'main.db';

  _openConnection() async {
    return await openDatabase(
      _path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            '''CREATE TABLE pay (id INTEGER PRIMARY KEY, value INTEGER, start_date DATETIME, end_date DATETIME);
             CREATE TABLE spending (id INTEGER PRIMARY KEY, value INTEGER, comment STRING');''');
      },
    );
  }

  _closeConnection(Database database) async {
    await database.close();
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {List<String> columns, String where, List<dynamic> whereArgs}) async {
    Database _db = await _openConnection();
    var result = await _db.query(table,
        columns: columns, where: where, whereArgs: whereArgs);
    await _closeConnection(_db);
    return result;
  }

  Future<int> insert(String table, dynamic map) async {
    Database _db = await _openConnection();
    int id = await _db.insert(table, map);
    await _closeConnection(_db);
    return id;
  }

  Future<int> delete(String table, String columnId, int id) async {
    Database _db = await _openConnection();
    var result =
        await _db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    await _closeConnection(_db);
    return result;
  }

  Future<int> update(String table, String columnId, int id, dynamic map) async {
    Database _db = await _openConnection();
    var result =
        await _db.update(table, map, where: '$columnId = ?', whereArgs: [id]);
    await _closeConnection(_db);
    return result;
  }

  Future<void> execute(String query) async {
    Database _db = await _openConnection();
    var result = await _db.execute(query);
    await _closeConnection(_db);
    return result;
  }
}
