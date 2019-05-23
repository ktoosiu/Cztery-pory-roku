import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/http_data.dart';

class CreateResolutionForm extends StatefulWidget {
  @override
  CreateResolutionFormState createState() => CreateResolutionFormState();
}

class CreateResolutionFormState extends State<CreateResolutionForm> {
  final _createFormKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  String fullName;
  int userId;
  DateTime finishDate;
  int lastId;
  final formController = [
    TextEditingController(), //name
    TextEditingController(), //description
  ];

  @override
  initState() {
    checkUser();
    resolutionId();
    memberName(userId);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    for (var controller in formController) {
      controller.dispose();
    }
    super.dispose();
  }

  resolutionId() async {
    var resolutionList = await fetchResolution();
    int tempId = resolutionList.last.id + 1;
    lastId = tempId;
  }

  memberName(int userId) async {
    final val = await checkUserName(userId);
    if (val != null) {
      fullName = val;
    }
  }

  checkUser() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var savedId = user.getInt('id');
    userId = savedId;
    await memberName(savedId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
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
                    onPressed: () {
                      setState(() {
                        memberName(userId);
                      });
                      if (_createFormKey.currentState.validate()) {
                        createResolution(
                          Resolution(
                              id: lastId,
                              name: formController[0].text,
                              description: formController[1].text,
                              date: DateTime.now(),
                              finishDate: finishDate,
                              proposedBy: fullName),
                        );

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Sent'),
                          backgroundColor: Colors.greenAccent[400],
                        ));
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
      ),
    );
  }
}
