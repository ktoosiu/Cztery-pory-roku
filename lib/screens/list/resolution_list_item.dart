import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:flutter/material.dart';

class ResolutionListItem extends StatelessWidget {
  final Resolution resolution;

  const ResolutionListItem({Key key, this.resolution}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                resolution.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(resolution.date.toString())
            ],
          ),
          Text(resolution.description),
          Divider()
        ],
      ),
    );
  }
}
//todo: ładniej komórkę zrobić, paddingi, pobieranie danych przez http, stworzyć serwis pobierający dane z jsonserver używać tych danych, mocki usunąć 
//ewentualnie: navigator, widok detali