import 'dart:async';

import 'package:cztery_pory_roku/models/signatures.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:cztery_pory_roku/viewModels/resolution_list_item_view_model.dart';

import '../../models/resolutions.dart';

class ResolutionListBloc {
  List<Resolution> _resolutions = [];
  List<Signature> _signatures = [];

  final _resolutionsStreamController =
      StreamController<List<ResolutionListItemViewModel>>();

  StreamSink<List<ResolutionListItemViewModel>> get resolutionSink =>
      _resolutionsStreamController.sink;
  Stream<List<ResolutionListItemViewModel>> get resolutionsStream =>
      _resolutionsStreamController.stream;

  //Events
  final _fetchSignaturesEventController =
      StreamController<FetchUserSignaturesEvent>();
  Sink<FetchUserSignaturesEvent> get fetchSignaturesSink =>
      _fetchSignaturesEventController.sink;

  final _fetchResolutionsEventController =
      StreamController<FetchResolutionListEvent>();
  Sink<FetchResolutionListEvent> get fetchResolutionSink =>
      _fetchResolutionsEventController.sink;

  final _addResolutionsEventController = StreamController<AddResolutionEvent>();
  Sink<AddResolutionEvent> get addResolutionSink =>
      _addResolutionsEventController.sink;

  final _addSignatureEventController =
      StreamController<AddUpdateSignatureEvent>();
  Sink<AddUpdateSignatureEvent> get addSignatureSink =>
      _addSignatureEventController.sink;

  final _updateResolutionsEventController =
      StreamController<UpdateResolutionEvent>();
  Sink<UpdateResolutionEvent> get updateResolutionSink =>
      _updateResolutionsEventController.sink;

  ResolutionListBloc() {
    _fetchResolutionsEventController.stream.listen(_onFetchResolutions);
    _addResolutionsEventController.stream.listen(_onAddResolution);
    _updateResolutionsEventController.stream.listen(_onUpdateResolution);
    _fetchSignaturesEventController.stream.listen(_onFetchUserSignatures);
    _addSignatureEventController.stream.listen(_onAddSignature);
  }

  _onFetchUserSignatures(FetchUserSignaturesEvent event) {
    _signatures = event.items;
    _processResolutionsStreamData();
  }

  _onFetchResolutions(FetchResolutionListEvent event) {
    _resolutions = event.items;
    _processResolutionsStreamData();
  }

  _onAddResolution(AddResolutionEvent event) {
    _resolutions.add(event.item);
    _processResolutionsStreamData();
  }

  _onAddSignature(AddUpdateSignatureEvent event) {
    final index =
        _signatures.indexWhere((signature) => signature.id == event.item.id);

    if (index != -1) {
      _signatures[index] = event.item;
    } else {
      _signatures.add(event.item);
    }
    _processResolutionsStreamData();
  }

  _onUpdateResolution(UpdateResolutionEvent event) {
    final index = _resolutions.indexWhere((resolution) {
      if (resolution.id == event.item.id) {
        return true;
      }
    });

    if (index != -1) {
      _resolutions[index] = event.item;
      _processResolutionsStreamData();
    } else {
      resolutionSink
          .addError("Cannot update resolution of id ${event.item.id}");
    }
  }

  void _processResolutionsStreamData() {
    List<ResolutionListItemViewModel> processedList = [];
    _resolutions.forEach((resolution) {
      final signature = _signatures.firstWhere((signature) {
        return signature.idResolution == resolution.id;
      }, orElse: () => null);
      processedList.add(ResolutionListItemViewModel(resolution, signature));
    });
    resolutionSink.add(processedList);
  }

  dispose() {
    _resolutionsStreamController.close();
    _fetchResolutionsEventController.close();
    _addResolutionsEventController.close();
    _updateResolutionsEventController.close();
    _fetchSignaturesEventController.close();
    _addSignatureEventController.close();
  }
}
