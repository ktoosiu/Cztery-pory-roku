import 'package:cztery_pory_roku/models/resolutions.dart';
import 'package:cztery_pory_roku/models/signatures.dart';

class ResolutionListItemViewModel {
  final Resolution resolution;
  final Signature signature;
  DateTime date;
  ResolutionListItemViewModel(this.resolution, this.signature, {this.date});
}
