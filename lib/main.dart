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
  //streamy flutter (refresh)
//TODO: zapoznać się z ideologią redux, głównie redux.js (poczytać jak działa)https://redux.js.org/
//https://github.com/brianegan/flutter_architecture_samples/tree/master/redux
}

//akcje
//no mutation- return a new object if the state changes.
//reducers-function that takes state and action as arguments, and returns the next state of the app
//Single source of truth - state in 1 object
//state is read only- changing state by actions
//only functions (reducers) can make changes
