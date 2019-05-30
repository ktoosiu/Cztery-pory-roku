import 'dart:async';

import 'package:cztery_pory_roku/models/members.dart';
import 'package:cztery_pory_roku/models/signatures.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:cztery_pory_roku/viewModels/resolution_list_item_view_model.dart';

import '../../models/resolutions.dart';

class ResolutionListBloc {
  List<Resolution> _resolutions = [];
  List<Signature> _signatures = [];
  List<Member> _members = [];

  final _resolutionsStreamController =
      StreamController<List<ResolutionListItemViewModel>>();

  StreamSink<List<ResolutionListItemViewModel>> get resolutionSink =>
      _resolutionsStreamController.sink;
  Stream<List<ResolutionListItemViewModel>> get resolutionsStream =>
      _resolutionsStreamController.stream;

  final _membersStreamController = StreamController<List<Member>>();
  StreamSink<List<Member>> get memberSink => _membersStreamController.sink;
  Stream<List<Member>> get membersStream => _membersStreamController.stream;

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

  final _fetchMemberEventController = StreamController<FetchMemberListEvent>();
  Sink<FetchMemberListEvent> get fetchMemberSink =>
      _fetchMemberEventController.sink;

  final _addMemberEventController = StreamController<AddMemberEvent>();
  Sink<AddMemberEvent> get addMemberSink => _addMemberEventController.sink;

  ResolutionListBloc() {
    _fetchResolutionsEventController.stream.listen(_onFetchResolutions);
    _addResolutionsEventController.stream.listen(_onAddResolution);
    _updateResolutionsEventController.stream.listen(_onUpdateResolution);
    _fetchSignaturesEventController.stream.listen(_onFetchUserSignatures);
    _addSignatureEventController.stream.listen(_onAddSignature);
    _fetchMemberEventController.stream.listen(_onFetchMember);
    _addMemberEventController.stream.listen(_onAddMember);
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

  _onFetchMember(FetchMemberListEvent event) {
    _members = event.items;
    _processMembersStreamData();
  }

  _onAddMember(AddMemberEvent event) {
    final index = _members.indexWhere((member) => member.id == event.item.id);

    if (index != -1) {
      _members[index] = event.item;
    } else {
      _members.add(event.item);
    }
    _processMembersStreamData();
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

  void _processMembersStreamData() {
    memberSink.add(_members);
  }

  dispose() {
    _resolutionsStreamController.close();
    _fetchResolutionsEventController.close();
    _addResolutionsEventController.close();
    _updateResolutionsEventController.close();
    _fetchSignaturesEventController.close();
    _addSignatureEventController.close();
    _addMemberEventController.close();
    _fetchMemberEventController.close();
    _membersStreamController.close();
  }
}
