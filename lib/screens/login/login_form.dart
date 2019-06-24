import 'package:cztery_pory_roku/app_container/app_container.dart';
import 'package:cztery_pory_roku/models/app_state.dart';
import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_screen.dart';
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
                if (value.isEmpty) return 'Wprowadź ID';
              },
              autofocus: false,
            ),
            TextFormField(
              controller: _formController[1],
              decoration: InputDecoration(hintText: 'Imię'),
              validator: (value) {
                if (value.isEmpty) return 'Wprowadź Imię';
              },
            ),
            TextFormField(
              controller: _formController[2],
              decoration: InputDecoration(hintText: 'Nazwisko'),
              validator: (value) {
                if (value.isEmpty) return 'Wprowadź Nazwisko';
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
        child: Text('Zaloguj', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          if (_loginFormKey.currentState.validate()) {
            await _processOnPress();
          } else {
            _showErrorSnackbar('Wprowadź dane');
          }
        },
      ),
    );
  }

  Future _processOnPress() async {
    var id = _formController[0].text;
    var firstName = _formController[1].text;
    var lastName = _formController[2].text;
    bool exists;
    bool admin;
    await checkMember(id: id, firstName: firstName, lastName: lastName)
        .then((x) => {
              exists = x.memberExist == true ? true : false,
              admin = x.isAdmin == true ? true : false
            });
    if (exists == true) {
      _setUserData(id, firstName, lastName, admin);
      _navigateToResolutionGroup(
          UserData(int.parse(id), firstName, lastName, admin));
    } else {
      _showErrorSnackbar('Użytkownik $id $firstName $lastName nie istnieje!');
    }
  }

  void _setUserData(String id, String name, String lastname, bool admin) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('id', int.parse(id));
    preferences.setString('name', name);
    preferences.setString('lastName', lastname);
    preferences.setBool('admin', admin);
  }

  void _navigateToResolutionGroup(UserData userData) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        settings: RouteSettings(name: Routes.resolutionGroups),
        builder: (context) => AppContainer(
            state: AppState(userData), child: ResolutionGroupScreen())));
  }

  void _showErrorSnackbar(String errorText) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(errorText),
      backgroundColor: Colors.redAccent[100],
    ));
  }
}
