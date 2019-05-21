import 'package:flutter/material.dart';

import './utils/routes.dart';
import './screens/list/resolution_screen.dart';
import './screens/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        Routes.home: (context) => Login(),
        Routes.resolutions: (context) => ResolutionScreen(),
      },
    );
  }

// TODO: user id w list na sztywno
//TODO:pull to refresh RefreshIndicator
//TODO:floating buttons z dodawaniem ustawy
//TODO:finish date check (colours), check if user can send a Signature
//TODO:redesign
//TODO: Loader wszędzie gdzie async
// TODO: nie updatuje jeśli nie przeładuje ale tylko po dodaniu

//login case sensitive?
//mieszamy językami/translacja

// DONE: multiple updates podczas jednej sesji na formularzu
//    data ostatniej zmiany-details
//    resolution list jeśli odpowiedziałem to info na co zagłosowałem

}
