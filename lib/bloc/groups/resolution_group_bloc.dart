import 'dart:async';

import 'package:cztery_pory_roku/models/resolution_group.dart';

import 'resolution_group_event.dart';

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

  final _editResolutionGroupEventController =
      StreamController<EditGroupEvent>();
  Sink<EditGroupEvent> get editGroupSink =>
      _editResolutionGroupEventController.sink;

  ResolutionGroupBloc() {
    _fetchResolutionGroupsEvent.stream.listen(onFetchResolutionGroup);
    _addResolutionGroupEventController.stream.listen(_onAddResolutionGroup);
    _editResolutionGroupEventController.stream.listen(_onEditResolutionGroup);
  }

  _onAddResolutionGroup(AddResolutionGroupEvent event) {
    _resolutionGroups.add(event.item);
    resolutionGroupSink.add(_resolutionGroups);
  }

  _onEditResolutionGroup(EditGroupEvent event) {
    final index =
        _resolutionGroups.indexWhere((group) => group.id == event.item.id);
    if (index != -1) {
      _resolutionGroups[index] = event.item;
    }
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
    _editResolutionGroupEventController.close();
  }
}
