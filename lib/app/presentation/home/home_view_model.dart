import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/domain/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_page_state.dart';

class HomeViewModel extends Cubit<HomePageState> {
  final PersonRepository _personRepository;
  late Ticker _ticker;
  Duration _lastFetch = Duration.zero;

  HomeViewModel({required PersonRepository personRepository})
    : _personRepository = personRepository,
      super(HomePageState.inital()) {
    startTicker();
  }  

  void stopTicker(){
      _ticker.stop();
      _ticker.dispose();
  }
  void startTicker() {
     _ticker = Ticker(counter);
    _ticker.start();
  }

  Future<void> fetchPerson() async {
    try {
      emit(state.copyWith(status: HomePageStatus.loading));
      final users = await _personRepository.fetchUser();
  
      emit(
        state.copyWith(
          status: HomePageStatus.success,
          resultUser: () => users.first,
        ),
      );
      emit(state.copyWith(users: [...state.users, ...users]));

      emit(state.copyWith(status: HomePageStatus.success, users: state.users));
    } on RepositoryException catch (_) {
      emit(
        state.copyWith(
          status: HomePageStatus.error,
          message: () => "Erro ao buscar dados",
        ),
      );
    }
  }

  counter(Duration elapsed) {
   
    if (elapsed - _lastFetch >= const Duration(seconds: 5)) {
      
      _lastFetch = elapsed;
      fetchPerson();
    }
  }


}
