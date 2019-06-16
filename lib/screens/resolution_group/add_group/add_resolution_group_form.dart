import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/resolution_list/resolution_screen.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AddResolutionGroupForm extends StatefulWidget {
  final Function(ResolutionGroup) callback;

  const AddResolutionGroupForm(this.callback, {Key key}) : super(key: key);
  @override
  AddResolutionGroupState createState() => AddResolutionGroupState();
}

class AddResolutionGroupState extends State<AddResolutionGroupForm> {
  final _addGroupKey = GlobalKey<FormState>();
  bool _isButtonDisabled;
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime finishDate;
  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
  }

  final formController = TextEditingController();

  @override
  void dispose() {
    formController.dispose();
    // Clean up the controller when the Widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addGroupKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                controller: formController,
                decoration: InputDecoration(
                  hintText: "Resolution Group Name",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Enter name';
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_day),
              title: DateTimePickerFormField(
                format: dateFormat,
                inputType: InputType.date,
                decoration: InputDecoration(
                    labelText: 'Date', hasFloatingPlaceholder: true),
                onChanged: (dt) => setState(() => finishDate = dt),
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

  _sendData() {
    if (_isButtonDisabled) {
      return null;
    } else {
      if (_addGroupKey.currentState.validate()) {
        setState(() {
          _isButtonDisabled = true;
        });
        //await Future.delayed(Duration(seconds: 5));
        final group = ResolutionGroup(
          date: finishDate,
          name: formController.text,
        );
        addResolutionGroup(group).then((createdGroup) {
          widget.callback(createdGroup);

          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => ResolutionScreen(
                    groupId: createdGroup.id,
                  ),
            ),
          );
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
    }
  }
}
