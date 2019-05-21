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

  const ResolutionListItem({Key key, this.resolution}) : super(key: key);

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResolutionDetails(
                    item: resolution,
                  )),
        );
      },
      child: Column(
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
          Container(
            child: Text(
              resolution.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.all(4.0),
          ),
          Container(
            child: FutureBuilder(
                future: checkChoice(1, resolution.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != '') {
                      return Text(
                        'User choice: ${snapshot.data}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
