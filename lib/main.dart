import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// TODO: check if user can send a Signature (outdated/already sent)
// TODO: refresh - RefreshIndicator
//singlechildscroll w loginie?
//routing z parametrem
//jak nie ma połączenia to exception ale nic nie pokazuje
//jeżeli tak to zapisać id do shared preferences żeby można było odczytywać -- shared preferences pamięta po zamknięciu
//login case sensitive?
//mieszamy językami
// jeżeli nie ma użytkownika to post z tworzeniem/albo snackbar nei ma użytkownika

//szare tło dla nieaktywnych
//add isolate (compute) - https://flutter.dev/docs/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate
}
