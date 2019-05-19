import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/signatures.dart';

class ResolutionForm extends StatefulWidget {
  @override
  ResolutionFormState createState() => ResolutionFormState();
}

class ResolutionFormState extends State<ResolutionForm> {
  TypeOfSign selectedValue;
  final _resolutionFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _resolutionFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter Fullname'),
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Name";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter Address'),
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Address";
              }
            },
          ),
          RadioButtonWiget(
            selectedValue: selectedValue,
            onChangeCallback: (TypeOfSign value) {
              setState(() {
                selectedValue = value;
              });
            },
            description: 'Accept',
            radioValue: TypeOfSign.accepted,
          ),
          RadioButtonWiget(
            selectedValue: selectedValue,
            onChangeCallback: (TypeOfSign value) {
              setState(() {
                selectedValue = value;
              });
            },
            description: 'Decline',
            radioValue: TypeOfSign.declined,
          ),
          RadioButtonWiget(
            selectedValue: selectedValue,
            onChangeCallback: (TypeOfSign value) {
              setState(() {
                selectedValue = value;
              });
            },
            description: 'Abstain',
            radioValue: TypeOfSign.abstained,
          ),
          Center(
            child: RaisedButton(
              child: Text('Send'),
              onPressed: () {
                if (selectedValue != null &&
                    _resolutionFormKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Sent"),
                    backgroundColor: Colors.greenAccent[400],
                  ));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Please select value"),
                    backgroundColor: Colors.redAccent[100],
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class RadioButtonWiget extends StatelessWidget {
  const RadioButtonWiget({
    Key key,
    @required this.selectedValue,
    @required this.onChangeCallback,
    this.description,
    this.radioValue,
  }) : super(key: key);

  final TypeOfSign selectedValue;
  final Function onChangeCallback;
  final description;
  final TypeOfSign radioValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: radioValue,
          onChanged: (TypeOfSign value) {
            onChangeCallback(value);
          },
          groupValue: selectedValue,
        ),
        Text(description)
      ],
    );
  }
}
