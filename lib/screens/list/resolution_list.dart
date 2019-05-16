import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/resolutions.dart';
import '../../screens/list/resolution_list_item.dart';

class ResolutionList extends StatefulWidget {
  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  final _resolutions = <Resolution>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchResolution(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // _resolutions = snapshot.data;
            _resolutions.addAll(snapshot.data);

            return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _resolutions.length,
                itemBuilder: (context, i) {
                  return ResolutionListItem(resolution: _resolutions[i]);
                });
          } else {
            return new CircularProgressIndicator();
          }
        });
  }
}
