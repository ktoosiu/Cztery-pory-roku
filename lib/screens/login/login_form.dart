import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/list/resolution_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes.dart';
import '../../api/http_data.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _formController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  void dispose() {
    for (var controller in _formController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 32),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: _formController[0],
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'ID'),
              validator: (value) {
                if (value.isEmpty) return 'Enter ID';
              },
              autofocus: false,
            ),
            TextFormField(
              controller: _formController[1],
              decoration: InputDecoration(hintText: 'First Name'),
              validator: (value) {
                if (value.isEmpty) return 'Enter First Name';
              },
            ),
            TextFormField(
              controller: _formController[2],
              decoration: InputDecoration(hintText: 'Last Name'),
              validator: (value) {
                if (value.isEmpty) return 'Enter Last Name';
              },
            ),
            _renderLoginButton(),
          ],
        ),
      ),
    );
  }

  Padding _renderLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        splashColor: Colors.blue,
        padding: EdgeInsets.fromLTRB(56, 12, 56, 12),
        color: Colors.blue,
        child: Text('Sign In', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          if (_loginFormKey.currentState.validate()) {
            await _processOnPress();
          } else {
            _showErrorSnackbar('Please enter values');
          }
        },
      ),
    );
  }

  Future _processOnPress() async {
    var id = _formController[0].text;
    var firstName = _formController[1].text;
    var lastName = _formController[2].text;

    if (await checkMember(id: id, firstName: firstName, lastName: lastName)) {
      _setUserData(id, firstName, lastName);
      _navigateToResolution(UserData(int.parse(id), firstName, lastName));
    } else {
      _showErrorSnackbar('User $id $firstName $lastName doesn\'t exist!');
    }
  }

  void _setUserData(String id, String name, String lastname) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('id', int.parse(id));
    preferences.setString('name', name);
    preferences.setString('lastName', lastname);
  }

  void _navigateToResolution(UserData userData) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        settings: RouteSettings(name: Routes.resolutionGroups),
        builder: (context) => ResolutionScreen()));
  }

  void _showErrorSnackbar(String errorText) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(errorText),
      backgroundColor: Colors.redAccent[100],
    ));
  }
}
