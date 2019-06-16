import 'package:cztery_pory_roku/models/members.dart';

abstract class MembersEvent {}

class FetchMemberListEvent extends MembersEvent {
  final List<Member> items;

  FetchMemberListEvent(this.items);
}

class AddMemberEvent extends MembersEvent {
  final Member item;

  AddMemberEvent(this.item);
}
