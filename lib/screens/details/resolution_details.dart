import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:cztery_pory_roku/screens/details/resolution_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResolutionDetails extends StatelessWidget {
  final Resolution item;

  const ResolutionDetails({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(item.description),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Data zakończenia ${DateFormat('dd-MM-yyyy').format(item.finishDate)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                ResolutionForm()
              ],
            ),
          ),
        ));
  }
}
