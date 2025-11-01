import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_bus_2_teste/app/core/app_constants/app_constants.dart';
import 'package:random_user_bus_2_teste/app/core/app_lifecycle_observer.dart';
import 'package:random_user_bus_2_teste/app/core/ui/extensions/ui.extensions.dart';
import 'package:random_user_bus_2_teste/app/core/ui/theme/app_theme.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/domain/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/presentation/detail/detail_page.dart';
import 'package:random_user_bus_2_teste/app/presentation/detail/detail_view_model.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_page.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_view_model.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_users_page.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_view_model.dart';
import 'package:random_user_bus_2_teste/app_provider.dart';

void main() {
  runApp(const AppProvider(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appObserLifeCylce = AppLifecycleObserver();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(appObserLifeCylce);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(appObserLifeCylce);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [AppRouteObserver.instance],
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        AppConstants.ROUTER_HOME: (context) => BlocProvider(
          create: (context) =>
              HomeViewModel(personRepository: context.read<PersonRepository>())
                ..fetchPerson(),
          child: HomePage(),
        ),
        AppConstants.ROUTER_DETAIL_USER: (context) {
          final userResult = ModalRoute.of(context)?.settings.arguments as User;
          return BlocProvider(
            create: (context) => DetailViewModel(
              personRepository: context.read<PersonRepository>(),
            ),
            child: DetailPage(userResult: userResult),
          );
        },
        AppConstants.ROUTER_USER_PERSISTED: (context) => BlocProvider(
          create: (context) => PersistedViewModel(
            personRepository: context.read<PersonRepository>(),
          )..findAll(),
          child: PersistedUsersPage(),
        ),
      },
    );
  }
}
