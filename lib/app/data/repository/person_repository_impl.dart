import 'dart:developer';

import 'package:random_user_bus_2_teste/app/core/exceptions/data_source_exception.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/data/dao/user_dao.dart';
import 'package:random_user_bus_2_teste/app/data/datasource/rest_client.dart';
import 'package:random_user_bus_2_teste/app/data/local/database/random_user_database.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final RestClient _restClient;
  final RandomUserDatabase _randomUserDatabase;

  PersonRepositoryImpl({
    required RestClient restClient,
    required RandomUserDatabase randomUserDatabase,
  }) : _restClient = restClient,
       _randomUserDatabase = randomUserDatabase;
  @override
  Future<List<User>> fetchUser() async {
    try {
      final userResult = await _restClient.fetcUser();

      return userResult.map((us) {
        final userDomain = us.toDomain();

        _randomUserDatabase.save(UserDao.fromDomain(userDomain));
        return userDomain;
      }).toList();
    } on DataTableSourceException catch (e, s) {
      log(
        "Erro ao buscar dados dos usuários",
        error: e,
        stackTrace: s,
        name: 'Repository errorS',
      );
      throw RepositoryException(message: 'erro ao buscar dados');
    }
  }

  @override
  Future<User?> findById(int id) async {
    try {
      final userDao = await _randomUserDatabase.findbyId(id);
      return userDao?.toDomain();
    } on DataTableSourceException catch (e, s) {
      var userErro = 'Erro ao remover usuário';
      log(userErro, error: e, stackTrace: s, name: "REMOVE USER");
      throw RepositoryException(message: userErro);
    }
  }

  @override
  Future<void> removeUser(int id) async {
    try {
      await _randomUserDatabase.delete(id);
    } on DataTableSourceException catch (e, s) {
      var userErro = 'id do usuário inválido';
      log(userErro, error: e, stackTrace: s, name: "Find Byid");
      throw RepositoryException(message: userErro);
    }
  }

  @override
  Future<List<User>> findAll() async {
    try {
      final daoUsers = await _randomUserDatabase.finaAll();

      return daoUsers.map((d) => d.toDomain()).toList();
    } on DataTableSourceException catch (e, s) {
      var userErro = 'Erro ao buscar dados dos usuários';
      log(userErro, error: e, stackTrace: s, name: "FIND ALL USER");
      throw RepositoryException(message: userErro);
    }
  }

  @override
  Future<int> save(User user) async {
    try {
      final userDao = UserDao.fromDomain(user);
      return _randomUserDatabase.save(userDao);
    } on DataTableSourceException catch (e, s) {
      var userErro = 'Erro ao Salvar usuário';
      log(userErro, error: e, stackTrace: s, name: "Save USER");
      throw RepositoryException(message: userErro);
    }
  }
  
  @override
  Future<User?> findbyApiId(String uuid) async {
    try {
      final userDao = await _randomUserDatabase.findbyApiId(uuid);
      return userDao?.toDomain();
    } on DataTableSourceException catch (e, s) {
      var userErro = 'id do usário inválido';
      log(userErro, error: e, stackTrace: s, name: "Find By Api id");
      throw RepositoryException(message: userErro);
    }
  }
}
