import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/data/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_page_state.dart';

class HomeViewModel extends ChangeNotifier {
  final PersonRepository _personRepository;
  HomePageState _state = HomePageState.inital();
  late Ticker _ticker;
  Duration _lastFetch = Duration.zero;

  HomeViewModel({required PersonRepository personRepository})
    : _personRepository = personRepository {
    _ticker = Ticker(counter);
    _ticker.start();
  }

  HomePageState get state => _state;
  set _mstate(HomePageState state) => _state = state;

 void stopTicker() => _ticker.stop();

  Future<void> fetchPerson() async {
    try {
      notifyListeners();
      _mstate = _state.copyWith(status: HomePageStatus.loading);
      final users = await _personRepository.fetchUser();
        
        log('user ${users.first.name}');
      _mstate = _state.copyWith(
        status: HomePageStatus.success,
        resultUser: () => users.first,
      );

      // notifyListeners();

      _mstate = _state.copyWith(users: [..._state.users, ...users]);

      _mstate = _state.copyWith(
        status: HomePageStatus.success,
        users: state.users,
      );
    } on RepositoryException catch (e) {
      _mstate = _state.copyWith(
        status: HomePageStatus.error,
        message: () => "Erro ao buscar dados",
      );
    } finally {
      notifyListeners();
    }
  }

  counter(Duration elapsed) {
    if (elapsed - _lastFetch >= const Duration(seconds: 5)) {
      _lastFetch = elapsed;
      fetchPerson();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
