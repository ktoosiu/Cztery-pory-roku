import 'package:cztery_pory_roku/models/user_data.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../api/http_data.dart';
import '../../models/resolutions.dart';

class CreateResolutionForm extends StatefulWidget {
  final UserData userData;
  final Function(Resolution) callback;

  const CreateResolutionForm(this.userData, this.callback, {Key key})
      : super(key: key);

  @override
  CreateResolutionFormState createState() => CreateResolutionFormState();
}

class CreateResolutionFormState extends State<CreateResolutionForm> {
  final _createFormKey = GlobalKey<FormState>();

  final dateFormat = DateFormat('yyyy-MM-dd');

  DateTime finishDate;

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
                    'Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}')),
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                controller: formController[0],
                decoration: InputDecoration(
                  hintText: "Resolution Title",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Enter title';
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: TextFormField(
                controller: formController[1],
                decoration: InputDecoration(
                  hintText: "Description",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Enter description';
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_day),
              title: DateTimePickerFormField(
                format: dateFormat,
                inputType: InputType.date,
                decoration: InputDecoration(
                    labelText: 'Finish date', hasFloatingPlaceholder: true),
                onChanged: (dt) => setState(() => finishDate = dt),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: Text('Send'),
                  onPressed: () async {
                    if (_createFormKey.currentState.validate()) {
                      await Future.delayed(Duration(seconds: 5));
                      final resolution = Resolution(
                          name: formController[0].text,
                          description: formController[1].text,
                          date: DateTime.now(),
                          finishDate: finishDate,
                          proposedBy:
                              "${widget.userData.name} ${widget.userData.lastName}");
                      createResolution(resolution).then((createdResolution) {
                        widget.callback(createdResolution);
                        Navigator.pop(context);
                      }).catchError((error) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Unknown error"),
                          backgroundColor: Colors.redAccent[100],
                        ));
                      });
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter value"),
                        backgroundColor: Colors.redAccent[100],
                      ));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
