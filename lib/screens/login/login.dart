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
                              'assets/euvic_with_tagline_blue.png',
                              height: 150,
                            ),
                            LoginForm()
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
