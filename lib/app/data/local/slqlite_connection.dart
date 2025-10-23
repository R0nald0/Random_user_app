import 'dart:async';

import 'package:path/path.dart';
import 'package:random_user_bus_2_teste/app/core/app_constants/app_constants.dart';
import 'package:sqflite/sqflite.dart';

class SqlliteConnection {
  static const _version = 1;
  static const _databaseName = 'RANDOM_USER_db';
  static SqlliteConnection? _instance;
  Database? _db;

  SqlliteConnection._();

  factory SqlliteConnection() {
    _instance ??= SqlliteConnection._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    if (_db == null) {
      final dataBasePath = await getDatabasesPath();
      final pathDatabe = join(dataBasePath, _databaseName);
      _db = await openDatabase(
        pathDatabe,
        version: _version,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
        onUpgrade: _onUpgrade,
      );
    }
    return _db!;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    
    batch.commit();
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    batch.execute('''
          CREATE TABLE ${AppConstants.tableName}(
            id integer primary key autoincrement,
            address text not null,
            lat text,
            long text,
            addtional text
            )
         ''');
    batch.commit();
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }
}
