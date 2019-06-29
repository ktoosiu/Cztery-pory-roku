import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../models/signatures.dart';
import '../../api/http_data.dart';
import 'radio_button.dart';

class ResolutionForm extends StatefulWidget {
  final Function(Signature) callback;
  final resolutionId;
  final UserData userData;
  final Signature _signature;

  const ResolutionForm(
    this.userData,
    this.callback,
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
                    'Last updated: ${DateFormat('yyyy-MM-dd').format(editDate)}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                : null,
          ),
          RadioButtonWidget(
            selectedValue: selectedValue,
            onChangeCallback: (TypeOfSign value) {
              setState(() {
                selectedValue = value;
              });
            },
            description: 'ZA',
            radioValue: TypeOfSign.accepted,
          ),
          RadioButtonWidget(
            selectedValue: selectedValue,
            onChangeCallback: (TypeOfSign value) {
              setState(() {
                selectedValue = value;
              });
            },
            description: 'PRZECIW',
            radioValue: TypeOfSign.declined,
          ),
          RadioButtonWidget(
            selectedValue: selectedValue,
            onChangeCallback: (TypeOfSign value) {
              setState(() {
                selectedValue = value;
              });
            },
            description: 'WSTRZYMAŁ SIĘ',
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
                          "Wyślij",
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
                        widget.callback(newSignature);
                        setState(() {
                          signature = newSignature;
                        });
                      });
                    } else {
                      updateSignature(Signature(
                              date: DateTime.now(),
                              idMember: widget.userData.id,
                              idResolution: widget.resolutionId,
                              type: selectedValue))
                          .then((response) {
                        widget.callback(Signature(
                            date: signature.date,
                            id: signature.id,
                            idMember: signature.idMember,
                            idResolution: signature.idResolution,
                            type: selectedValue));
                      });
                    }

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            signature == null ? 'Wysłano' : 'Zaktualizowano'),
                        backgroundColor: Colors.greenAccent[400],
                      ),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Proszę wybrać"),
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
