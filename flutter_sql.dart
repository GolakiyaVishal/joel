import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDb {
  final _dbName = 'sample.db';
  final _dbPath = 'assets/sample.db';
  final _table1 = 'table1';
  final _table2 = 'table2';

  /// get data from assets
  void getDatabase() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, _dbName);

// Delete any existing database:
    await deleteDatabase(dbPath);

// Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load(_dbPath);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    var db = await openDatabase(dbPath);

    print('animal data >>${db.isOpen}');
    print('db path :: ${db.path}');
    print(" ${Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $_table2'))}");

    var category = await db.rawQuery('SELECT * FROM $_table1');
    print("table1:: $category");

    var pair = await db.rawQuery('SELECT * FROM $_table2');
    print('table2:: $pair');

  }
}