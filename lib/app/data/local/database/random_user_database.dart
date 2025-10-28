import 'package:random_user_bus_2_teste/app/data/dao/user_dao.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class RandomUserDatabase {
    Future<int> save(UserDao userDao);
     Future<List<UserDao>> finaAll();
    Future<UserDao?> findbyId(int id);
    Future<UserDao?> findbyApiId(String uuid);
     Future<int> delete(int id);

      Future<Database>  get db ;
}