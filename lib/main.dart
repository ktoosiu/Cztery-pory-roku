import 'package:flutter/material.dart';

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
      home: Login(),
    );
  }
//czy dobrze wysyłka formularza jest zrobiona i sprawdzanie tekstu
// TODO:po naciśnieciu logi zapytanie do api czy użytkownik istnieje - metoda sprawdzająca 
//jeżeli tak to zapisać id do shared preferences żeby można było odczytywać
//nawigacja do resolution screen
//metoda post signature
//case sensitive
// jeżeli nie ma użytkownika to post z tworzeniem/albo snackbar nei ma użytkownika


//szare tło dla nieaktywnych
//add isolate (compute) - https://flutter.dev/docs/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate
}
