import 'package:cztery_pory_roku/utils/json_to_date.dart';
import 'package:intl/intl.dart';

class Signature {
  final int id;
  final DateTime date;
  final TypeOfSign type;
  final int idMember;
  final int idResolution;

  Signature({this.id, this.date, this.type, this.idMember, this.idResolution});
  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(
        id: json['id'],
        date: jsonToDate(json['date']),
        type: TypeOfSign.values[json['type']],
        idMember: json['memberId'],
        idResolution: json['resolutionId']);
  }
  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'date': DateFormat('yyyy-MM-dd').format(date),
        'type': type.index,
        'memberId': idMember,
        'resolutionId': idResolution
      };
    }
    return {
      'id': id,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'type': type.index,
      'memberId': idMember,
      'resolutionId': idResolution
    };
  }
}

enum TypeOfSign { accepted, declined, abstained }
