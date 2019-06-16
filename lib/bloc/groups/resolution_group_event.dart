import 'package:cztery_pory_roku/models/resolution_group.dart';

abstract class ResolutionGroupEvent {}

class FetchResolutionGroupsEvent extends ResolutionGroupEvent {
  final List<ResolutionGroup> items;
  FetchResolutionGroupsEvent(this.items);
}

class AddResolutionGroupEvent extends ResolutionGroupEvent {
  final ResolutionGroup item;

  AddResolutionGroupEvent(this.item);
}
