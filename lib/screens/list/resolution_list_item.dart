import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //Date formatting library

import '../../models/resolutions.dart';

class ResolutionListItem extends StatelessWidget {
  final Resolution resolution;

  const ResolutionListItem({Key key, this.resolution}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
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
              maxLines: 3, overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.all(4.0),
          ),
          Divider()
        ],
      ),
    );
  }
}
//todo: 
//pobieranie danych przez http
//stworzyć serwis pobierający dane z jsonserver używać tych danych, mocki usunąć
//ewentualnie: navigator, widok detali

//alert dialog
//szare tło dla nieaktywnych
