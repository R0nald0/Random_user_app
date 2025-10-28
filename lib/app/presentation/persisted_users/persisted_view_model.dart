import 'package:bloc/bloc.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/domain/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_page_state.dart';

class PersistedViewModel extends Cubit<PersistedPageState> {
  final PersonRepository _personRepository;

  PersistedViewModel({required PersonRepository personRepository})
    : _personRepository = personRepository,
      super(PersistedPageState.inital());

  Future<void> findAll() async {
    try {
      emit(state.copyWith(status: PersistedPageStatus.loading));
      final users = await _personRepository.findAll();

      emit(state.copyWith(status: PersistedPageStatus.success, users: users));
    } on RepositoryException catch (_) {
      emit(
        state.copyWith(
          status: PersistedPageStatus.error,
          message: () => "Erro ao buscar dados",
        ),
      );
    } 
  }

Future<void> removeUser(User user) async {
    try {
      if (user.id == null) return;
      emit(state.copyWith(status: PersistedPageStatus.loading));
      await _personRepository.removeUser(user.id!);
        state.users.remove(user);
      emit(
        state.copyWith(
          status: PersistedPageStatus.success,
          users: state.users
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          status: PersistedPageStatus.error,
          message: () => "Erro ao remover o usuário do banco",
        ),
      );
    }
  }
}
