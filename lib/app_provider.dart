import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:random_user_bus_2_teste/app/data/datasource/rest_client.dart';
import 'package:random_user_bus_2_teste/app/data/local/database/impl/random_user_database_impl.dart';
import 'package:random_user_bus_2_teste/app/data/local/database/random_user_database.dart';
import 'package:random_user_bus_2_teste/app/data/repository/person_repository_impl.dart';
import 'package:random_user_bus_2_teste/app/domain/repository/person_repository.dart';

class AppProvider extends StatelessWidget {
  final Widget _child;
  const AppProvider({super.key, required Widget child}) : _child = child;

  List<SingleChildWidget> _coreProviders() => [
    Provider(create: (context) => RestClient()),
    Provider<RandomUserDatabase>(create: (context) => RandomUserDatabaseImpl()),
    Provider<PersonRepository>(
      create: (context) => PersonRepositoryImpl(
        restClient: context.read<RestClient>(),
        randomUserDatabase: context.read<RandomUserDatabase>(),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: _coreProviders(), child: _child);
  }
}
