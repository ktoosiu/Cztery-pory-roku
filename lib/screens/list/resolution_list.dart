import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../models/resolutions.dart';
import '../../screens/list/resolution_list_item.dart';
import '../../api/http_data.dart';

class ResolutionList extends StatefulWidget {
  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  var _resolutions = <Resolution>[];
  Future<List<Resolution>> resolutionFuture;
  @override
  initState() {
    resolutionFuture = fetchResolution();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: resolutionFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _resolutions = snapshot.data;
            return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _resolutions.length,
                itemBuilder: (context, i) {
                  return ResolutionListItem(resolution: _resolutions[i]);
                });
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
        });
  }
}
