import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

import '../../models/resolutions.dart';
import '../details/resolution_details.dart';
import '../../screens/details/resolution_details.dart';

class ResolutionListItem extends StatelessWidget {
  final Resolution resolution;

  const ResolutionListItem({Key key, this.resolution}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>ResolutionDetails(item: resolution,)),
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
          Divider(),
        ],
      ),
    );
  }
}