import 'package:cztery_pory_roku/screens/details/resolution_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //Date formatting library

import '../../models/resolutions.dart';
import '../details/resolution_details.dart';

class ResolutionListItem extends StatelessWidget {
  final Resolution resolution;

  const ResolutionListItem({Key key, this.resolution}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>ResolutionDetails()),
          );
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(Icons.assignment,),
                Text(
                  resolution.name,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormat('dd-MM-yyyy').format(resolution.date))
                //Text(resolution.date.day.toString()+"/"+resolution.date.month.toString()+"/"+resolution.date.year.toString())//tak też można
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
      ),
    );
  }
}

//ewentualnie: navigator, widok detali

//alert dialog
//szare tło dla nieaktywnych
//refresh

//add isolate (compute) - https://flutter.dev/docs/cookbook/networking/background-parsing#4-move-this-work-to-a-separate-isolate
