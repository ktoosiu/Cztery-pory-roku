import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/viewModels/resolution_list_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/signatures.dart';
import 'resolution_form.dart';

class ResolutionDetails extends StatelessWidget {
  final ResolutionListItemViewModel item;
  final UserData userData;
  final Function(Signature) callback;
  const ResolutionDetails(
      {Key key, this.item, this.userData, @required this.callback})
      : super(key: key);

  String checkChoice() {
    if (item.signature == null) {
      return '-';
    } else {
      switch (item.signature.type) {
        case TypeOfSign.accepted:
          return 'ZA';
          break;
        case TypeOfSign.declined:
          return 'PRZECIW';
          break;
        case TypeOfSign.abstained:
          return 'WSTRZYMAŁ SIĘ';
          break;
      }
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item.resolution.name),
        ),
        body: Container(
          color: Colors.lightBlue[100],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Container(
                color: Colors.lightBlue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(item.resolution.description),
                      item.resolution.proposedBy != null
                          ? Text(
                              'Uchwała utworzona przez ${item.resolution.proposedBy}')
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Data zakończenia: ${DateFormat('dd-MM-yyyy').format(item.resolution.finishDate)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: item.resolution.finishDate
                                .isAfter(DateTime.now())
                            ? ResolutionForm(
                                userData,
                                callback,
                                item.signature,
                                resolutionId: item.resolution.id,
                              )
                            : Column(children: [
                                Text(
                                  'Głosowanie zamknięte.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Twój wybór: ${checkChoice()}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
