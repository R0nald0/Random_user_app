import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/data/datasource/rest_client.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';

class PersonRepository {
  final RestClient _restClient;
  

  PersonRepository({required RestClient restClient}) : _restClient = restClient;
  Future<List<User>> fetchUser() async {
    try {
     final userResult   = await _restClient.fetcUser();
      

     return userResult.map((us) => us.toDomain()).toList();
    } on RepositoryException catch (e, s) {
      throw RepositoryException(message: 'erro ao buscar dados');
    }
  }
}
