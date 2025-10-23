
import 'package:flutter/widgets.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';

enum HomePageStatus{loading,error,success,initial}
class HomePageState {
  
  final User? resultUser;
  final String? message;
  final List<User> users;
  final HomePageStatus status;


  HomePageState.inital() :this(status: HomePageStatus.initial,users: [],);


  HomePageState({
    required this.users,
    required this.status,
    this.resultUser,
    this.message
  });
  
  HomePageState copyWith({
    ValueGetter<User?>? resultUser,
    ValueGetter<String?>? message,
    List<User>? users,
    HomePageStatus? status,
  }) {
    return HomePageState(
      resultUser: resultUser != null ? resultUser() : this.resultUser,
      message: message != null ? message() : this.message,
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }
}
