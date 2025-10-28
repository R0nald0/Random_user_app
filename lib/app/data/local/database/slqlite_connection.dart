import 'dart:async';
import 'dart:developer';

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
    log("ONCREATE  INCIADO");

    batch.execute('''
    CREATE TABLE ${AppConstants.tableName}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      gender TEXT,
      title TEXT,
      first_name TEXT,
      last_name TEXT,
      street_number INTEGER,
      street_name TEXT,
      city TEXT,
      state TEXT,
      country TEXT,
      postcode TEXT,
      latitude TEXT,
      longitude TEXT,
      timezone_offset TEXT,
      timezone_description TEXT,
      email TEXT,
      uuid TEXT,
      username TEXT,
      password TEXT,
      salt TEXT,
      md5 TEXT,
      sha1 TEXT,
      sha256 TEXT,
      date_of_birth TEXT,
      age INTEGER,
      registered_date TEXT,
      registered_age INTEGER,
      phone TEXT,
      cell TEXT,
      id_name TEXT,
      id_value TEXT,
      picture_large TEXT,
      picture_medium TEXT,
      picture_thumbnail TEXT,
      nat TEXT,
      is_persisted INTEGER NOT NULL DEFAULT 0
    );
  ''');
     
    log("ONCREATE  FINALIDADO");

    await batch.commit();
  }

  Future<void> closeConnection() async {
    await _db?.close();
    _db = null;
  }
}
