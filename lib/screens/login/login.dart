import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/login/login_form.dart';

class Login extends StatelessWidget {
  Future checkUser(context) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var savedId = user.getInt('id');
    if (savedId != null && savedId is int) {
      Navigator.pushNamed(context, Routes.resolutions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
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
      ),
    );
  }
}
