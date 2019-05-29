import 'package:cztery_pory_roku/models/members.dart';
import 'package:flutter/material.dart';

import 'add_member_form.dart';

class AddMember extends StatelessWidget {
  final Function(Member) callback;

  const AddMember(this.callback, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new member"),
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
                  child: AddMemberForm(
                    callback: callback,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
