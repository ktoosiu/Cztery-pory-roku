import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:flutter/material.dart';

import 'create_resolution_form.dart';
import '../../models/user_data.dart';

class CreateResolution extends StatelessWidget {
  final UserData userData;
  final groupId;
  final Function(Resolution) callback;

  const CreateResolution(this.userData, this.groupId, this.callback, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new resolution"),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Container(
            color: Colors.lightBlue[100],
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.lightBlue[50],
                  child: CreateResolutionForm(userData, groupId, callback),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
