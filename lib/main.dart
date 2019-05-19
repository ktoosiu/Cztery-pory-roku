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
        '/': (context) => Login(),
        '/resolution': (context) => ResolutionScreen(),
        // '/details': (context) => ResolutionDetails()
      },
    );
  }

//singlechildscroll w loginie?
//routing z parametrem
//jak nie ma połączenia to exception ale nic nie pokazuje
//jeżeli tak to zapisać id do shared preferences żeby można było odczytywać -- shared preferences pamięta po zamknięciu
//wywala exception przy ładowaniu username

//login case sensitive?
//mieszamy językami
//test czy już pobrałem
//csprawdzi czy nie głosowałem, czy data się zgadza
// jeżeli nie ma użytkownika to post z tworzeniem/albo snackbar nei ma użytkownika

//szare tło dla nieaktywnych
//add isolate (compute) - https://flutter.dev/docs/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate
}
