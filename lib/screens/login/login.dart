import 'package:flutter/material.dart';

import '../../screens/login/login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    color: Colors.lightBlue[50],
                    child: Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              height: 150,
                            ),
                            Text(
                              'Cztery pory roku',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 6),
                              child: Text(
                                'Witamy w aplikacji do głosowania nad uchwałami osiedla cztery pory roku.\n'
                                'Aby zalogować się do aplikacji wpisz swój identyfikator oraz imie i nazwisko w poniższy formularz.'
                                'W razie problemów z logowaniem skontaktuj się z administracją osiedla.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            LoginForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
