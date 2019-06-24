import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/resolution_details/resolution_details.dart';
import 'package:cztery_pory_roku/viewModels/resolution_list_item_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/signatures.dart';

class ResolutionListItem extends StatelessWidget {
  final ResolutionListItemViewModel viewModel;
  final UserData userData;
  final Function(Signature) callback;
  const ResolutionListItem(
      {Key key, this.viewModel, this.userData, @required this.callback})
      : super(key: key);

  Widget checkChoice() {
    if (viewModel.signature == null) {
      return Container();
    } else {
      switch (viewModel.signature.type) {
        case TypeOfSign.accepted:
          return Text('User choice: Accepted',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15));

        case TypeOfSign.declined:
          return Text('User choice: Declined',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15));

        case TypeOfSign.abstained:
          return Text('User choice: Abstained',
              style: TextStyle(
                  color: Colors.yellow[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 15));
        default:
          return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResolutionDetails(
                  item: viewModel,
                  userData: userData,
                  callback: callback,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
            child: Container(
          decoration: BoxDecoration(
              color: viewModel.resolution.finishDate.isAfter(DateTime.now())
                  ? Colors.lightBlue[50]
                  : Colors.grey[300]),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewModel.resolution.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(viewModel.date))
                  ],
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    viewModel.resolution.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: checkChoice(),
                      ),
                      Container(
                          child: viewModel.resolution.finishDate
                                  .isAfter(DateTime.now())
                              ? Container()
                              : Text(
                                  'Closed',
                                  style: TextStyle(color: Colors.red),
                                )),
                    ],
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        )),
      ),
    );
  }
}
