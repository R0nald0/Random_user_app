

import 'package:bloc/bloc.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/repository_exception.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/domain/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/presentation/detail/detail_page_state.dart';

class DetailViewModel extends Cubit<DetailPageState> {
  final PersonRepository _personRepository;

  DetailViewModel({required PersonRepository personRepository})
    : _personRepository = personRepository,
      super(DetailPageState(user: null, status: DetailPageStatus.loading));

  Future<void> loadUser(User user) async {
    try {
      emit(state.copyWith(user: () => user, status: DetailPageStatus.success));

      emit(state.copyWith(status: DetailPageStatus.loading));

      final userPersisted = await _personRepository.findbyApiId(user.uuid);

       if (userPersisted != null) {
      emit(
        state.copyWith(
          user: () => state.user!.copyWith(id: () => userPersisted.id),
          status: DetailPageStatus.success,
        ),
      );
    }
    } on RepositoryException catch (_) {
      emit(
        state.copyWith(
          message: () => 'Erro ao buscar dados do usuário salvo',
          status: DetailPageStatus.error,
        ),
      );
    }
  }

  Future<void> removeUser(User user) async {
    try {
      if (user.id == null) return;
      emit(state.copyWith(status: DetailPageStatus.loading));
      await _personRepository.removeUser(user.id!);
      emit(
        state.copyWith(
          status: DetailPageStatus.success,
          user: () => user.copyWith(id: () => null),
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          status: DetailPageStatus.error,
          message: () => "Erro ao remover o usuário do banco",
        ),
      );
    }
  }

  Future<void> addUser(User user) async {
    try {
      emit(state.copyWith(status: DetailPageStatus.loading));
      final line = await _personRepository.save(user);
      emit(
        state.copyWith(
          user: () => state.user!.copyWith(id: () => line),
          status: DetailPageStatus.success,
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          status: DetailPageStatus.error,
          message: () => "Erro ao remover o usuário do banco",
        ),
      );
    }
  }
}
