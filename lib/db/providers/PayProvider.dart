import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mother_wallet/db/Database.dart';
import 'package:mother_wallet/db/models/Pay.dart';

class PayProvider {
  String _tableName = 'pay';
  String _idColumn = 'id';
  String _startDateColumn = 'start_date';
  String _endDateColumn = 'end_date';

  Future<int> insert(Pay pay) async {
    return new DatabaseConnection().insert(_tableName, pay.toMap());
  }

  Future<int> update(Pay pay) async {
    return new DatabaseConnection()
        .update(_tableName, _idColumn, pay.id, pay.toMap());
  }

  Future<int> delete(Pay pay) async {
    return new DatabaseConnection().delete(_tableName, _idColumn, pay.id);
  }

  Future<void> checkCurrentPay() async {
    List<Pay> pays = await getPays(DateTime.now(), DateTime.now());
    if (pays.isEmpty) {
      await insert(new Pay(value: 100, startDate: DateTime.now()));
    }
  }

  FutureOr<Pay> getPay(int id) async {
    var maps = await new DatabaseConnection()
        .query(_tableName, where: '$_idColumn = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return Pay.fromMap(maps.first);
    }

    return null;
  }

  FutureOr<Pay> getPayByDate(DateTime date) async {
    var maps = await new DatabaseConnection().query(
      _tableName,
      where:
          '$_startDateColumn < ? AND ($_endDateColumn IS NULL OR $_endDateColumn > ?)',
      whereArgs: [date.toString(), date.toString()],
    );

    if (maps.length > 0) {
      return Pay.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Pay>> getPays(DateTime startDate, DateTime endDate) async {
    var maps = await new DatabaseConnection().query(_tableName,
        where: 'NOT $_startDateColumn > ? OR NOT $_endDateColumn < ?',
        whereArgs: [endDate.toString(), startDate.toString()]);

    return maps.isNotEmpty ? maps.map((pay) => Pay.fromMap(pay)).toList() : [];
  }

  Future<int> getPayment(DateTime startDate, DateTime endDate) async {
    await checkCurrentPay();
    List<Pay> pays = await this.getPays(startDate, endDate);

    int sum = 0;

    pays.forEach((pay) {
      DateTimeRange range = new DateTimeRange(
          start: pay.startDate == null || pay.startDate.isBefore(startDate)
              ? startDate
              : pay.startDate,
          end: pay.endDate == null || pay.endDate.isAfter(endDate)
              ? endDate
              : pay.endDate);
      sum += (range.duration.inDays + 1) * pay.value;
    });

    return sum;
  }
}
