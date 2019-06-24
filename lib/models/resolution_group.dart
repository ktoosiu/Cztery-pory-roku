import 'package:cztery_pory_roku/utils/json_to_date.dart';
import 'package:intl/intl.dart';

class ResolutionGroup {
  final int id;
  final DateTime date;
  final String name;

  ResolutionGroup({this.id, this.date, this.name});
  factory ResolutionGroup.fromJson(Map<String, dynamic> json) {
    return ResolutionGroup(
      id: json['id'],
      date: jsonToDate(json['date']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'name': name,
        'date': DateFormat('yyyy-MM-dd').format(date),
      };
    }
    return {
      'id': id,
      'name': name,
      'date': DateFormat('yyyy-MM-dd').format(date),
    };
  }
}
