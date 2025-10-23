import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:random_user_bus_2_teste/app/core/ui/theme/app_theme.dart';
import 'package:random_user_bus_2_teste/app/data/model/random_user_response.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/presentation/detail/detail_page.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_page.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_users_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/'  : (context) => HomePage(),
        '/detail'  : (context) {
          final userResult = ModalRoute.of(context)?.settings.arguments as User;
         return  DetailPage(userResult: userResult);
        },
        '/perstisteds' : (context) => PersistedUsersPage()
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
    ticker =Ticker(counter);
    ticker.start();
  }

  counter(Duration elapsed){
      if (elapsed - _lastFetch >= const Duration(seconds: 5)) {
      _lastFetch = elapsed;
      log('tiker value ${elapsed.inSeconds}');
      if(mounted){
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
        onPressed: (){
          ticker.stop();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
