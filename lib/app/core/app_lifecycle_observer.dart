
import 'package:flutter/cupertino.dart';
import 'package:random_user_bus_2_teste/app/data/local/database/impl/random_user_database_impl.dart';

class AppLifecycleObserver with WidgetsBindingObserver{

     @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      final randoConnection  = RandomUserDatabaseImpl();
     switch(state){
       case AppLifecycleState.resumed:
       case AppLifecycleState.inactive:
       case AppLifecycleState.hidden:
       case AppLifecycleState.paused:
       case AppLifecycleState.detached:
          randoConnection.closeConnection();
          break;
     }
    super.didChangeAppLifecycleState(state);
  }
  
}