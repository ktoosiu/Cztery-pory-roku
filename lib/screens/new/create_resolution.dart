import 'package:flutter/material.dart';

import 'create_resolution_form.dart';

class CreateResolution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new resolution"),
      ),
      body: CreateResolutionForm(),
    );
  }
}

//sprawdzić nr id
//name
//date - datetime.now
//description
//finish_ date

//zaproponowane przez?
