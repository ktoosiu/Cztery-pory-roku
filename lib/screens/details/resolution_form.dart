import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../models/signatures.dart';
import '../../api/http_data.dart';

class ResolutionForm extends StatefulWidget {
  final resolutionId;
  final UserData userData;
  final Signature _signature;

  const ResolutionForm(
    this.userData,
    this._signature, {
    Key key,
    this.resolutionId,
  }) : super(key: key);

  @override
  ResolutionFormState createState() => ResolutionFormState(_signature);
}

class ResolutionFormState extends State<ResolutionForm> {
  TypeOfSign selectedValue;

  final _resolutionFormKey = GlobalKey<FormState>();

  DateTime editDate;
  Signature signature;

  ResolutionFormState(this.signature) {
    selectedValue = this.signature?.type;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _resolutionFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: editDate != null
                ? Text(
                    'Last updated: ${DateFormat('dd/MM/yyyy').format(editDate)}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                : null,
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.blue[900],
                color: Colors.lightBlue[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
                onPressed: () {
                  if (selectedValue != null &&
                      _resolutionFormKey.currentState.validate()) {
                    if (signature == null) {
                      createSignature(Signature(
                              date: DateTime.now(),
                              idMember: widget.userData.id,
                              idResolution: widget.resolutionId,
                              type: selectedValue))
                          .then((newSignature) {
                        setState(() {
                          signature = newSignature;
                        });
                      });
                    } else {
                      updateSignature(
                        id: signature.id,
                        choice: selectedValue,
                      );
                    }

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(signature == null ? 'Sent' : 'Updated'),
                        backgroundColor: Colors.greenAccent[400],
                      ),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Please select value"),
                      backgroundColor: Colors.redAccent[100],
                    ));
                  }
                },
              ),
            ),
          ),
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
