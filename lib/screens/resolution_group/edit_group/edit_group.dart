import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:flutter/material.dart';

import 'edit_group_form.dart';

class EditGroup extends StatelessWidget {
  final ResolutionGroup resolutionGroup;
  final Function(ResolutionGroup) callback;

  const EditGroup(this.resolutionGroup, this.callback, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edytuj uchwałę ${resolutionGroup.id}"),
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
                  child: EditGroupForm(
                    callback: callback,
                    resolutionGroup: resolutionGroup,
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
