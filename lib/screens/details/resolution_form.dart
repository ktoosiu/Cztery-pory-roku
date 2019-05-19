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
  String tempName;
  int tempID;

  Future<String> getUser() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var fullName =
        user.getString('firstName') + ' ' + user.getString('lastName');
    tempName = fullName;
    tempID = user.getInt('id');
    return fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _resolutionFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FutureBuilder(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '$tempName ',
                        style: TextStyle(fontSize: 18),
                      );
                    } else {
                      throw Exception('No user data'); // TODO: tu wywala
                    }
                  },
                ),
              ],
            ),
          ),
          // TextFormField(
          //   decoration: InputDecoration(hintText: 'Enter Fullname'),
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return "Enter Name";
          //     }
          //   },
          // ),
          // TextFormField(
          //   decoration: InputDecoration(hintText: 'Enter Address'),
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return "Enter Address";
          //     }
          //   },
          // ),
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
                  var signature = Signature(
                      id: 2,
                      idMember: tempID,
                      date: DateTime.now(),
                      idResolution: widget.resolutionId,
                      type:
                          selectedValue); // TODO: Resolution ID, resolution check
                  createSignature(signature);
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
