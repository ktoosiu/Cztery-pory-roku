import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/resolutions.dart';
import '../../screens/list/resolution_list_item.dart';
import '../../mocks/resolution_mocks.dart';

class ResolutionList extends StatefulWidget {
  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  final _resolutions = <Resolution>[];
  @override
  void initState() {
    _resolutions.addAll(resolutionMock);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _resolutions.length,
      itemBuilder: (context, i){
                
    
        return ResolutionListItem(resolution: _resolutions[i]);
      },
    );
  }
}
