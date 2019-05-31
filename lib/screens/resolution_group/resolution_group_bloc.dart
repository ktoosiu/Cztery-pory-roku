import 'dart:async';

import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_event.dart';

class ResolutionGroupBloc {
  List<ResolutionGroup> _resolutionGroups;
  final _resolutionGroupStreamController =
      StreamController<List<ResolutionGroup>>();

  StreamSink<List<ResolutionGroup>> get resolutionSink =>
      _resolutionGroupStreamController.sink;
  Stream<List<ResolutionGroup>> get resolutionsStream =>
      _resolutionGroupStreamController.stream;

  final _fetchResolutionGroupsEvent =
      StreamController<FetchResolutionGroupsEvent>();
  Sink<FetchResolutionGroupsEvent> get fetchResolutionGroupsSink =>
      _fetchResolutionGroupsEvent.sink;

  ResolutionGroupBloc() {
    _fetchResolutionGroupsEvent.stream.listen(onFetchResolutionGroup);
  }

  void onFetchResolutionGroup(FetchResolutionGroupsEvent event) {
    _resolutionGroups = event.items;
    resolutionSink.add(_resolutionGroups);
  }

  dispose() {
    _resolutionGroupStreamController.close();
    _fetchResolutionGroupsEvent.close();
  }
}
