import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/routes.dart';
import '../../api/http_data.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final formController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  initState() {
    checkUser(context);
    super.initState();
  }

  Future setUserId(String id) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    user.setInt('id', int.parse(id));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    for (var controller in formController) {
      controller.dispose();
    }
    super.dispose();
  }

  Future checkUser(context) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var savedId = user.getInt('id');
    if (savedId != null) {
      Navigator.pushNamed(context, Routes.resolutions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: formController[0],
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'ID'),
              validator: (value) {
                if (value.isEmpty) return 'Enter ID';
              },
              autofocus: false,
            ),
            TextFormField(
              controller: formController[1],
              decoration: InputDecoration(hintText: 'First Name'),
              validator: (value) {
                if (value.isEmpty) return 'Enter First Name';
              },
            ),
            TextFormField(
              controller: formController[2],
              decoration: InputDecoration(hintText: 'Last Name'),
              validator: (value) {
                if (value.isEmpty) return 'Enter Last Name';
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(64, 24, 64, 8),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.blue,
                color: Colors.lightBlue[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('Sign In'),
                    ),
                  ],
                ),
                onPressed: () async {
                  if (_loginFormKey.currentState.validate()) {
                    if (await checkMember(
                        id: formController[0].text,
                        firstName: formController[1].text,
                        lastName: formController[2].text)) {
                      setUserId(formController[0].text);
                      Navigator.pushNamed(context, Routes.resolutions);
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'User ${formController[0].text} ${formController[1].text} ${formController[2].text} doesn\'t exist!'),
                          backgroundColor: Colors.redAccent[100],
                        ),
                      );
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Please enter values"),
                      backgroundColor: Colors.redAccent[100],
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
