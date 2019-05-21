import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';

import './screens/list/resolution_screen.dart';
import './screens/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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

//data ostatniej zmiany-details
//pull to refresh
//resolution list jeśli odpowiedziałem to info na co zagłosowałem-list
//redesign
//floating buttons z dodawaniem ustawy
//finish date check

// TODO: check if user can send a Signature (outdated/already sent)
// TODO: refresh - RefreshIndicator
//login case sensitive?
//mieszamy językami

//szare tło dla nieaktywnych

// DONE: multiple updates podczas jednej sesji na formularzu
}
