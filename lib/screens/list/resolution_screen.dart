import 'package:flutter/material.dart';

import '../../screens/list/resolution_list.dart';

class ResolutionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resolutions"),
      ),
      body: ResolutionList(),
    );
  }
}
