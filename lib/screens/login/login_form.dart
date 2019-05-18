import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(hintText: 'ID'),
                validator: (value) {
                  if (value.isEmpty) return 'Enter ID';
                }),
            TextFormField(
                decoration: InputDecoration(hintText: 'Fullname'),
                validator: (value) {
                  if (value.isEmpty) return 'Enter Fullname';
                }),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: RaisedButton(
                child: Text('Sign In'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // TODO: implement sending form
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Please enter values"),
                      backgroundColor: Colors.red,
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

//commit: Login Form created,
//http get service changed to generic
