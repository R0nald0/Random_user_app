import 'package:flutter/material.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/data/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_page_state.dart';

class PersistedViewModel extends ChangeNotifier {
  final PersonRepository _personRepository;
  PersistedPageState _state = PersistedPageState.inital();

  PersistedViewModel({required PersonRepository personRepository})
    : _personRepository = personRepository ;

  PersistedPageState get state => _state;
  set _mstate(PersistedPageState state) => _state = state;

  Future<void> fetchPerson() async {
    try {
      notifyListeners();
      _mstate = _state.copyWith(status: PersistedPageStatus.loading);
      final users = await _personRepository.fetchUser();
   
      _mstate = _state.copyWith(
        status: PersistedPageStatus.success,
        resultUser: () => users.first,
      );

      _mstate = _state.copyWith(users:users);

      _mstate = _state.copyWith(
        status: PersistedPageStatus.success,
        users: state.users,
      );
    } on RepositoryException catch (e) {
      _mstate = _state.copyWith(
        status: PersistedPageStatus.error,
        message: () => "Erro ao buscar dados",
      );
    } finally {
      notifyListeners();
    }
  }
  Future<void> remove(User user)async{}
  Future<void> save(User user)async{}
}
