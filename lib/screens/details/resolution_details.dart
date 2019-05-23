import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/http_data.dart';
import '../../models/signatures.dart';
import '../../models/resolutions.dart';
import 'resolution_form.dart';

class ResolutionDetails extends StatelessWidget {
  final Resolution item;
  final userId;
  const ResolutionDetails({Key key, this.item, this.userId}) : super(key: key);
  checkChoice(int userId, int resolutionId) async {
    final val = await checkSignatureId(resolutionId, userId);
    if (val is int) {
      return '';
    } else {
      // TypeOfSign.values[val['type']];
      switch (TypeOfSign.values[val['type']]) {
        case TypeOfSign.accepted:
          return 'Accepted';
          break;
        case TypeOfSign.declined:
          return 'Declined';
          break;
        case TypeOfSign.abstained:
          return 'Abstained';
          break;
      }
    }
  }

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
                item.proposedBy != null
                    ? Text('Resolution proposed by ${item.proposedBy}')
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Finish Date: ${DateFormat('dd-MM-yyyy').format(item.finishDate)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: item.finishDate.isAfter(DateTime.now())
                      ? ResolutionForm(
                          resolutionId: item.id,
                        )
                      : Column(children: [
                          Text(
                            'Resolution is closed.',
                            style: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.italic),
                          ),
                          FutureBuilder(
                              future: checkChoice(userId, item.id),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != '') {
                                    return Text(
                                      'Your choice: ${snapshot.data}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    );
                                  } else {
                                    return Text('You didn\'t vote.');
                                  }
                                } else {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ]),
                )
              ],
            ),
          ),
        ));
  }
}
