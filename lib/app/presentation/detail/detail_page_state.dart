import 'package:flutter/widgets.dart';

import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';

enum DetailPageStatus { loading, error, success }

class DetailPageState {
  final String? message;
  final User? user;
  final DetailPageStatus status;

  DetailPageState({required this.user, required this.status, this.message});

  DetailPageState copyWith({
    ValueGetter<String?>? message,
    ValueGetter<User>? user,
    DetailPageStatus? status,
  }) {
    return DetailPageState(
      message: message != null ? message() : this.message,
      user: user != null ? user() : this.user,
      status: status ?? this.status,
    );
  }
}
