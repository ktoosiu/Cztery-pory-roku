import 'package:cztery_pory_roku/screens/login/login.dart';
import 'package:flutter/material.dart';

import './screens/list/resolution_list.dart';

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
}

//TODO: dokończenie widoku logowania 
//2 textformfield + button login -osobny stateful widget 
//po naciśnieciu logi zapytanie do api czy użytkownik istnieje 
//jeżeli tak to zapisać id do shared preferences żeby można było odczytywać
//nawigacja do resolution screen
//metoda post signature
//
// jeżeli nie ma użytkownika to post z tworzeniem/albo snackbar nei ma użytkownika