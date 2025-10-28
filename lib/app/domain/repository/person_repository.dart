import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';

abstract interface class PersonRepository {
  Future<List<User>> fetchUser();
  Future<void> removeUser(int id);
  Future<List<User>> findAll();
  Future<User?> findById(int id);
  Future<int> save(User user);
  Future<User?> findbyApiId(String uuid);
}
