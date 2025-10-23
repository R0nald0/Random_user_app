
import 'package:flutter/widgets.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';

enum PersistedPageStatus{loading,error,success,initial}
class PersistedPageState {

  final String? message;
  final List<User> users;
  final PersistedPageStatus status;


  PersistedPageState.inital() :this(status: PersistedPageStatus.initial,users: [],);


  PersistedPageState({
    required this.users,
    required this.status,
    this.message
  });
  
  PersistedPageState copyWith({
    ValueGetter<User?>? resultUser,
    ValueGetter<String?>? message,
    List<User>? users,
    PersistedPageStatus? status,
  }) {
    return PersistedPageState(
      message: message != null ? message() : this.message,
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }
}
