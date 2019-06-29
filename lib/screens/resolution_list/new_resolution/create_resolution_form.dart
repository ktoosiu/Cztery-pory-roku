import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:cztery_pory_roku/models/user_data.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateResolutionForm extends StatefulWidget {
  final UserData userData;
  final groupId;
  final Function(Resolution) callback;

  const CreateResolutionForm(this.userData, this.groupId, this.callback,
      {Key key})
      : super(key: key);

  @override
  CreateResolutionFormState createState() => CreateResolutionFormState();
}

class CreateResolutionFormState extends State<CreateResolutionForm> {
  final _createFormKey = GlobalKey<FormState>();
  bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
  }

  final formController = [
    TextEditingController(), //name
    TextEditingController(), //description
  ];

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    for (var controller in formController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(
                    'Data: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}')),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                controller: formController[0],
                decoration: InputDecoration(
                  hintText: "Tytuł",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Wprowadź tytuł';
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: TextFormField(
                controller: formController[1],
                decoration: InputDecoration(
                  hintText: "Treść",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Wprowadź treść';
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
      child: Text('Wyślij'),
      onPressed: () {
        _sendData();
      },
    );
  }

  _sendData() {
    if (_isButtonDisabled) {
      return null;
    } else {
      if (_createFormKey.currentState.validate()) {
        setState(() {
          _isButtonDisabled = true;
        });
        //await Future.delayed(Duration(seconds: 5));
        final resolution = Resolution(
            name: formController[0].text,
            description: formController[1].text,
            groupId: widget.groupId,
            proposedBy: "${widget.userData.name} ${widget.userData.lastName}");
        createResolution(resolution).then((createdResolution) {
          widget.callback(createdResolution);
          Navigator.pop(context);
        }).catchError((error) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Nieznany błąd"),
            backgroundColor: Colors.redAccent[100],
          ));
        });
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Wprowadź wartości"),
          backgroundColor: Colors.redAccent[100],
        ));
      }
    }
  }
}
