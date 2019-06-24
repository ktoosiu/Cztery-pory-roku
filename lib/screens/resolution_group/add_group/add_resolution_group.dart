import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_resolution_group_form.dart';

class AddResolutionGroup extends StatelessWidget {
  final Function(ResolutionGroup) callback;

  const AddResolutionGroup(this.callback, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nowa grupa uchwał"),
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
                  child: AddResolutionGroupForm(callback),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
