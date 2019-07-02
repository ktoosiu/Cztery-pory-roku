import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditGroupForm extends StatefulWidget {
  final ResolutionGroup resolutionGroup;

  final Function(ResolutionGroup) callback;

  const EditGroupForm({Key key, this.callback, this.resolutionGroup})
      : super(key: key);

  @override
  EditGroupFormState createState() => EditGroupFormState();
}

class EditGroupFormState extends State<EditGroupForm> {
  final _addGroupKey = GlobalKey<FormState>();
  bool _isButtonDisabled;
  final dateFormat = DateFormat();

  DateTime finishDate;
  var formController = TextEditingController();

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
    formController = TextEditingController(text: widget.resolutionGroup.name);
    finishDate = widget.resolutionGroup.finishDate;
  }

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
                  hintText: "Nazwa grupy",
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Wprowadź nazwę';
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_day),
              title: DateTimePickerFormField(
                format: dateFormat,
                inputType: InputType.date,
                decoration: InputDecoration(
                    labelText: widget.resolutionGroup.finishDate.toString(),
                    hasFloatingPlaceholder: true),
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
      if (_addGroupKey.currentState.validate()) {
        setState(() {
          _isButtonDisabled = true;
        });
        //await Future.delayed(Duration(seconds: 5));
        final group = ResolutionGroup(
          date: widget.resolutionGroup.date,
          finishDate: DateTime(
              finishDate.year, finishDate.month, finishDate.day, 23, 59, 00),
          name: formController.text,
        );
        editResolutionGroup(group).then((createdGroup) {
          widget.callback(ResolutionGroup(
              id: widget.resolutionGroup.id,
              date: group.date,
              finishDate: group.finishDate,
              name: group.name));

          Navigator.pop(context);
        }).catchError((error) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Nieznany błąd'),
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
