import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

class HomeScreenController with ChangeNotifier {
  static late Database database;
  List<Map> travelogedataList = [];
  bool isLoding = false;
  static Future initDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase("mytravelogue4.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE TravelContent (id INTEGER PRIMARY KEY , title TEXT, content TEXT, date TEXT)');
    });
  }

  Future<void> addData(String title, String content) async {
    await database.rawInsert(
        'INSERT INTO TravelContent(title, content,date) VALUES( ?,?,?)',
        [title, content, currentDate]);
    await getData();
  }

  Future<void> getData() async {
    isLoding = true;
    notifyListeners();
    travelogedataList = await database.rawQuery('SELECT * FROM TravelContent');
    log(travelogedataList.toString());
    isLoding = false;
    notifyListeners();
  }

  Future removeContent(int id) async {
    await database.rawDelete('DELETE FROM TravelContent WHERE id = ?', [id]);
    await getData();
  }

  Future updateContent(String title, String content, int id) async {
    await database.rawUpdate(
        'UPDATE TravelContent SET title = ?, content = ? WHERE id = ?',
        [title, content, id]);
    await getData();
  }
}
