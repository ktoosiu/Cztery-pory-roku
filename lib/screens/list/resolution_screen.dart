import 'package:cztery_pory_roku/screens/list/resolution_list.dart';
import 'package:flutter/material.dart';

class ResolutionWidget extends StatelessWidget{
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