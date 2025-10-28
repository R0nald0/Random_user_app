import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_bus_2_teste/app/core/app_lifecycle_observer.dart';
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
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
          create: (context) =>
              HomeViewModel(personRepository: context.read<PersonRepository>()),
          child: HomePage(),
        ),
        '/detail': (context) {
          final userResult = ModalRoute.of(context)?.settings.arguments as User;
          return BlocProvider(
            create: (context) => DetailViewModel(
              personRepository: context.read<PersonRepository>(),
            ),
            child: DetailPage(userResult: userResult),
          );
        },
        '/perstisteds': (context) => BlocProvider(
          create: (context) => PersistedViewModel(
            personRepository: context.read<PersonRepository>(),
          )..findAll(),
          child: PersistedUsersPage(),
        ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Ticker ticker;
  Duration _lastFetch = Duration.zero;

  @override
  void initState() {
    super.initState();
    ticker = Ticker(counter);
    ticker.start();
  }

  counter(Duration elapsed) {
    if (elapsed - _lastFetch >= const Duration(seconds: 5)) {
      _lastFetch = elapsed;
      log('tiker value ${elapsed.inSeconds}');
      if (mounted) {
        _incrementCounter();
      }
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ticker.stop();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
