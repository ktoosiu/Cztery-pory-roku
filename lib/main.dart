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
  //kolory dopasować
  //add wycentrować
  //usunąć new i widget

// spacje z loginu itp?
//login case sensitive?
//jakieś tam okienko z potwierdzeniem?

//Done:redesign
//done odświeżanie rezolucji przy wyjściu z add
//Done: dodać kto wysłał rezolucję
//Done:finish date check (colours), check if user can send a Signature
//Done:floating buttons z dodawaniem ustawy
//Done:pull to refresh
// DONE: multiple updates podczas jednej sesji na formularzu
//    data ostatniej zmiany-details
//    resolution list jeśli odpowiedziałem to info na co zagłosowałem

}
