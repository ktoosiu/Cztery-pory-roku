import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signatures.dart';
import '../../api/http_data.dart';
import '../../utils/json_to_date.dart';

class ResolutionForm extends StatefulWidget {
  final resolutionId;

  const ResolutionForm({Key key, this.resolutionId}) : super(key: key);

  @override
  ResolutionFormState createState() => ResolutionFormState();
}

class ResolutionFormState extends State<ResolutionForm> {
  TypeOfSign selectedValue;
  final _resolutionFormKey = GlobalKey<FormState>();
  int userId;
  int newSignatureID;
  DateTime editDate;
  Signature signature;
  @override
  initState() {
    getUserId();
    super.initState();
  }

  Future<int> getUser() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var temp = user.getInt('id');
    return temp;
  }

  getUserId() async {
    final val = await getUser();
    getSignatureId(val);
    userId = val;
  }

  getSignatureId(int userId) async {
    final val = await checkSignatureId(widget.resolutionId, userId);

    if (val is int) {
      newSignatureID = val;
    } else {
      signature = Signature.fromJson(val);
      setState(() {
        selectedValue = signature.type;
        if (val['update_date'] != null) {
          editDate = jsonToDate(val['update_date']);
        }
      });
    }
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
            child: RaisedButton(
              child: Text('Send'),
              onPressed: () {
                if (selectedValue != null &&
                    _resolutionFormKey.currentState.validate()) {
                  if (newSignatureID != null) {
                    createSignature(Signature(
                        id: newSignatureID,
                        date: DateTime.now(),
                        idMember: userId,
                        idResolution: widget.resolutionId,
                        type: selectedValue));
                    newSignatureID = null;
                  } else {
                    updateSignature(
                      id: signature.id,
                      choice: selectedValue,
                    );
                  }

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(newSignatureID != null ? 'Sent' : 'Updated'),
                    backgroundColor: Colors.greenAccent[400],
                  ));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Please select value"),
                    backgroundColor: Colors.redAccent[100],
                  ));
                }
                setState(() {
                  getSignatureId(userId);
                });
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
