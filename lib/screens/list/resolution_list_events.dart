import '../../models/resolutions.dart';

abstract class ResolutionListEvent {}

class FetchResolutionListEvent extends ResolutionListEvent {
  final List<Resolution> items;

  FetchResolutionListEvent(this.items);
}

class AddResolutionEvent extends ResolutionListEvent {
  final Resolution item;

  AddResolutionEvent(this.item);
}

class UpdateResolutionEvent extends ResolutionListEvent {
  final Resolution item;

  UpdateResolutionEvent(this.item);
}
