import 'package:flutter/material.dart';

import '../../screens/login/login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: Container(
              color: Colors.lightBlue[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                  Card(
                    child: LoginForm(),
                    color: Colors.lightBlueAccent[100],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
