import 'dart:async';

import 'package:intl/intl.dart';
import 'package:mother_wallet/db/Database.dart';
import 'package:mother_wallet/db/models/Spending.dart';

class SpendingProvider {
  String _tableName = 'spending';
  String _idColumn = 'id';
  String _dateColumn = 'date';

  Future<int> insert(Spending spending) async {
    return new DatabaseConnection().insert(_tableName, spending.toMap());
  }

  Future<int> update(Spending spending) async {
    return new DatabaseConnection()
        .update(_tableName, _idColumn, spending.id, spending.toMap());
  }

  Future<int> delete(Spending spending) async {
    return new DatabaseConnection().delete(_tableName, _idColumn, spending.id);
  }

  Future<List<Spending>> getSpendingByDate(DateTime date) async {
    var maps = await new DatabaseConnection().query(
      _tableName,
      where: "$_dateColumn LIKE ?",
      whereArgs: [new DateFormat('yyyy-MM-dd').format(date) + '%'],
    );

    return maps.isNotEmpty
        ? maps.map((spending) => Spending.fromMap(spending)).toList()
        : [];
  }
}
