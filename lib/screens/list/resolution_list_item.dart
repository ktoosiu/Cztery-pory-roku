import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/http_data.dart';
import '../../models/signatures.dart';
import '../../models/resolutions.dart';
import '../details/resolution_details.dart';
import '../../screens/details/resolution_details.dart';

class ResolutionListItem extends StatelessWidget {
  final Resolution resolution;
  final int userId;
  const ResolutionListItem({Key key, this.resolution, this.userId})
      : super(key: key);

  Future<Text> checkChoice(int userId, int resolutionId) async {
    final val = await checkSignatureId(resolutionId, userId);
    if (val is int) {
      return null;
    } else {
      // TypeOfSign.values[val['type']];
      switch (TypeOfSign.values[val['type']]) {
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
                  item: resolution,
                  userId: userId,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
            child: Container(
          decoration: BoxDecoration(
              color: resolution.finishDate.isAfter(DateTime.now())
                  ? Colors.lightBlue[50]
                  : Colors.grey[300]),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      resolution.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(DateFormat('dd-MM-yyyy').format(resolution.date))
                  ],
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    resolution.description,
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
                        child: FutureBuilder(
                            future: checkChoice(userId, resolution.id),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  return snapshot.data;
                                }
                              } else {
                                return Container();
                              }
                            }),
                      ),
                      Container(
                          child: resolution.finishDate.isAfter(DateTime.now())
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
