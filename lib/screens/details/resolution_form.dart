import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signatures.dart';

class ResolutionForm extends StatefulWidget {
  final resolutionId;

  const ResolutionForm({Key key, this.resolutionId}) : super(key: key);

  @override
  ResolutionFormState createState() => ResolutionFormState();
}

class ResolutionFormState extends State<ResolutionForm> {
  TypeOfSign selectedValue;
  final _resolutionFormKey = GlobalKey<FormState>();
  int userID;
  int newSignatureID;
  Signature signature;
  @override
  initState() {
    getUserId();
    super.initState();
  }

  Future<int> getUser() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    //userID = user.getInt('id');
    var temp = user.getInt('id');
    return temp;
  }

  getUserId() async {
    final val = await getUser();
    getSignatureId(val);
    userID = val;
  }

  getSignatureId(int userId) async {
    final val = await checkSignatureId(widget.resolutionId, userId);
    print(val);
    if (val is int) {
      newSignatureID = val;
    } else {
      signature = Signature.fromJson(val);
      setState(() {
        selectedValue = signature.type;
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
                        idMember: userID,
                        idResolution: widget.resolutionId,
                        type: selectedValue));
                  } else {
                    updateSignature(id: signature.id, choice: selectedValue);
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
