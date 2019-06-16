import 'dart:async';

import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_event.dart';

class ResolutionGroupBloc {
  List<ResolutionGroup> _resolutionGroups;
  final _resolutionGroupStreamController =
      StreamController<List<ResolutionGroup>>();

  StreamSink<List<ResolutionGroup>> get resolutionGroupSink =>
      _resolutionGroupStreamController.sink;
  Stream<List<ResolutionGroup>> get resolutionGroupStream =>
      _resolutionGroupStreamController.stream;

  final _fetchResolutionGroupsEvent =
      StreamController<FetchResolutionGroupsEvent>();
  Sink<FetchResolutionGroupsEvent> get fetchResolutionGroupsSink =>
      _fetchResolutionGroupsEvent.sink;

  final _addResolutionGroupEventController =
      StreamController<AddResolutionGroupEvent>();
  Sink<AddResolutionGroupEvent> get addResolutionGroupSink =>
      _addResolutionGroupEventController.sink;

  ResolutionGroupBloc() {
    _fetchResolutionGroupsEvent.stream.listen(onFetchResolutionGroup);
    _addResolutionGroupEventController.stream.listen(_onAddResolutionGroup);
  }
  _onAddResolutionGroup(AddResolutionGroupEvent event) {
    _resolutionGroups.add(event.item);
    resolutionGroupSink.add(_resolutionGroups);
  }

  void onFetchResolutionGroup(FetchResolutionGroupsEvent event) {
    _resolutionGroups = event.items;
    resolutionGroupSink.add(_resolutionGroups);
  }

  dispose() {
    _resolutionGroupStreamController.close();
    _fetchResolutionGroupsEvent.close();
    _addResolutionGroupEventController.close();
  }
}
