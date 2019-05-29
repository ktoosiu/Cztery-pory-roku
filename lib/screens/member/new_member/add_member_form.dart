import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/members.dart';
import 'package:flutter/material.dart';

class AddMemberForm extends StatefulWidget {
  final Function(Member) callback;

  const AddMemberForm({Key key, this.callback}) : super(key: key);

  @override
  AddMemberFormState createState() => AddMemberFormState();
}

class AddMemberFormState extends State<AddMemberForm> {
  final _memberFormKey = GlobalKey<FormState>();
  bool _isButtonDisabled;
  final formController = [
    TextEditingController(), //first name
    TextEditingController(), //last name
    TextEditingController(), //address
  ];
  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in formController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _memberFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.face),
              title: TextFormField(
                controller: formController[0],
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Enter First Name';
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: TextFormField(
                controller: formController[1],
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Enter Last Name';
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: TextFormField(
                controller: formController[2],
                decoration: InputDecoration(
                  hintText: "Address",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Enter Address';
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildAddButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return new RaisedButton(
      child: Text('Send'),
      onPressed: () {
        _sendData();
      },
    );
  }

  _sendData() async {
    if (_isButtonDisabled) {
      return null;
    } else {
      if (_memberFormKey.currentState.validate()) {
        setState(() {
          _isButtonDisabled = true;
        });
        await Future.delayed(Duration(seconds: 5)); //TODO: tutaj też
        final member = Member(
            firstName: formController[0].text,
            lastName: formController[1].text,
            address: formController[2].text);
        addMember(member).then((createdMember) {
          widget.callback(createdMember);
          Navigator.pop(context);
        }).catchError((error) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Unknown error"),
            backgroundColor: Colors.redAccent[100],
          ));
        });
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Please enter values"),
          backgroundColor: Colors.redAccent[100],
        ));
      }
    }
  }
}
