import 'dart:async';

import 'package:cztery_pory_roku/models/members.dart';

import 'members_events.dart';

class MembersBloc {
  List<Member> _members = [];
  final _membersStreamController = StreamController<List<Member>>();
  StreamSink<List<Member>> get memberSink => _membersStreamController.sink;
  Stream<List<Member>> get membersStream => _membersStreamController.stream;
  final _fetchMemberEventController = StreamController<FetchMemberListEvent>();
  Sink<FetchMemberListEvent> get fetchMemberSink =>
      _fetchMemberEventController.sink;

  final _addMemberEventController = StreamController<AddMemberEvent>();
  Sink<AddMemberEvent> get addMemberSink => _addMemberEventController.sink;

  MembersBloc() {
    _fetchMemberEventController.stream.listen(_onFetchMember);
    _addMemberEventController.stream.listen(_onAddMember);
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

  void _processMembersStreamData() {
    memberSink.add(_members);
  }

  dispose() {
    _addMemberEventController.close();
    _fetchMemberEventController.close();
    _membersStreamController.close();
  }
}
