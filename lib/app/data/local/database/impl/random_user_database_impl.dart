import 'dart:developer';

import 'package:random_user_bus_2_teste/app/core/app_constants/app_constants.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/data_source_exception.dart';
import 'package:random_user_bus_2_teste/app/data/dao/user_dao.dart';
import 'package:random_user_bus_2_teste/app/data/local/database/random_user_database.dart';
import 'package:random_user_bus_2_teste/app/data/local/database/slqlite_connection.dart';
import 'package:sqflite/sqflite.dart';

class RandomUserDatabaseImpl implements RandomUserDatabase {
  late final SqlliteConnection _database;

  RandomUserDatabaseImpl() {
    _database = SqlliteConnection();
  }

 @override
  Future<Database>  get db  async => await  _database.openConnection();



  @override
  Future<int> save(UserDao userDao) async {
    try {
      final db = await _database.openConnection();
      return await db.insert(AppConstants.tableName, userDao.toMap());
    } on DatabaseException catch (e, s) {
      _showSqlError(e, s);
    }finally{
      _database.closeConnection();
    }
  }

  @override
  Future<List<UserDao>> finaAll()async{
    try {
      final db = await _database.openConnection();
      final data  = await db.rawQuery('SELECT *FROM ${AppConstants.tableName}');
     return data.map<UserDao>((u) =>UserDao.fromMap(u)).toList();
    } on DatabaseException catch (e, s) {
     log('EROOO $e');
     log('EROOO ${e.result}');

      
      _showSqlError(e, s);
    }finally{
      _database.closeConnection();
    }
  }

  @override
  Future<int> delete(int id)async{
    try {
      final db = await _database.openConnection();
      return await db.rawDelete('DELETE FROM ${AppConstants.tableName} WHERE id =?',[id]);
    } on DatabaseException catch (e, s) {
      _showSqlError(e, s);
    }finally{
      _database.closeConnection();
    }
  }
   @override
     Future<UserDao?> findbyId(int id)async{
    try {
      final db = await _database.openConnection();
       final user  =  await db.rawQuery('SELECT * FROM ${AppConstants.tableName} WHERE id =?',[id]);
       return UserDao.fromMap(user.first);
    } on DatabaseException catch (e, s) {
      _showSqlError(e, s);
    }finally{
      _database.closeConnection();
    }
  }

     @override
       Future<UserDao?> findbyApiId(String uuid)async{
    try {
      final db = await _database.openConnection();
       final user  =  await db.rawQuery('SELECT * FROM ${AppConstants.tableName} WHERE uuid =?',[uuid]);
       return  UserDao.fromMap(user.first);
    } on DatabaseException catch (e, s) {
      _showSqlError(e, s);
    }finally{          
      _database.closeConnection();
    }
  }

  Future<void> closeConnection() => _database.closeConnection();

 Never  _showSqlError(DatabaseException e, StackTrace s) {
    if (e.isSyntaxError()) {
      throw DataTableSourceException(
        message: "ocorred a syntax error",
        stackTrace: s,
      );
    }
    if (e.isNotNullConstraintError()) {
      throw DataTableSourceException(
        message: "is a not null constraint error",
        stackTrace: s,
      );
    }
    if (e.isDuplicateColumnError()) {
      throw DataTableSourceException(
        message: "is a duplicate column error",
        stackTrace: s,
      );
    }
    if (e.isOpenFailedError()) {
      throw DataTableSourceException(
        message: "exception is an open failed error",
        stackTrace: s,
      );
    }
    
    throw DataTableSourceException(
      message: "Erro ao conectar no banco desconhecido",
      stackTrace: s,
    );
  }
}
