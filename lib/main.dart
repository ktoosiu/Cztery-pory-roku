import 'package:flutter/material.dart';

import './screens/new/create_resolution.dart';
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
        Routes.createResolution: (context) => CreateResolution()
      },
    );
  }
  // TODO: dodać kto wysłał rezolucję
// TODO: resolution details na początku przy pustym daje mi update a nie send
//TODO:finish date check (colours), check if user can send a Signature
//odświeżanie rezolucji przy wyjściu z add

//TODO:redesign
//TODO: Loader wszędzie gdzie async
// TODO: spacje z loginu itp
//Todo wysyłka może być jako floatingactionwidget
//jakieś tam okienko z potwierdzeniem?
//login case sensitive?
//mieszamy językami/translacja

//Done:floating buttons z dodawaniem ustawy
//Done:pull to refresh
// DONE: multiple updates podczas jednej sesji na formularzu
//    data ostatniej zmiany-details
//    resolution list jeśli odpowiedziałem to info na co zagłosowałem
// DONE: user id w list na sztywno

}
