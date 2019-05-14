import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    // TODO: implement build

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _resolutions.length,
      itemBuilder: (context, i){
                
    
        return ResolutionListItem(resolution: _resolutions[i]);
      },
    );
  }
}
