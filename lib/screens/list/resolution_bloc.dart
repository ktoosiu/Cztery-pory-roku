import 'dart:async';

import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';

import '../../models/resolutions.dart';

class ResolutionBloc {
  List<Resolution> _resolutions = [];

  final _resolutionsStreamController = StreamController<List<Resolution>>();

  StreamSink<List<Resolution>> get resolutionSink =>
      _resolutionsStreamController.sink;

  Stream<List<Resolution>> get resolutionsStream =>
      _resolutionsStreamController.stream;

  //Events
  final _fetchResolutionsEventController =
      StreamController<FetchResolutionListEvent>();
  Sink<FetchResolutionListEvent> get fetchResolutionSink =>
      _fetchResolutionsEventController.sink;

  final _addResolutionsEventController = StreamController<AddResolutionEvent>();
  Sink<AddResolutionEvent> get addResolutionSink =>
      _addResolutionsEventController.sink;

  final _updateResolutionsEventController =
      StreamController<UpdateResolutionEvent>();
  Sink<UpdateResolutionEvent> get updateResolutionSink =>
      _updateResolutionsEventController.sink;

  ResolutionBloc() {
    _fetchResolutionsEventController.stream.listen(_onFetchResolutions);
    _addResolutionsEventController.stream.listen(_onAddResolution);
    _updateResolutionsEventController.stream.listen(_onUpdateResolution);
  }

  _onFetchResolutions(FetchResolutionListEvent event) {
    _resolutions = event.items;
    resolutionSink.add(_resolutions);
  }

  _onAddResolution(AddResolutionEvent event) {
    _resolutions.add(event.item);
    resolutionSink.add(_resolutions);
  }

  _onUpdateResolution(UpdateResolutionEvent event) {
    final index = _resolutions.indexWhere((resolution) {
      if (resolution.id == event.item.id) {
        return true;
      }
    });

    if (index != -1) {
      _resolutions[index] = event.item;
      resolutionSink.add(_resolutions);
    } else {
      resolutionSink
          .addError("Cannot update resolution of id ${event.item.id}");
    }
  }

  dispose() {
    _resolutionsStreamController.close();
    _fetchResolutionsEventController.close();
    _addResolutionsEventController.close();
    _updateResolutionsEventController.close();
  }
}
