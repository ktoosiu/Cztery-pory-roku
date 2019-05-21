import 'package:flutter/material.dart';

import '../../screens/login/login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Container(
            color: Colors.lightBlueAccent[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 36),
                ),
                LoginForm()
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
