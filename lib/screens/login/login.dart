import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/login/login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Loader wszędzie gdzie async
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
