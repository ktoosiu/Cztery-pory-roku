import '../utils/json_to_date.dart';
import 'package:intl/intl.dart';

class Resolution {
  final int id;
  final String name;
  final int groupId;
  final String description;
  final DateTime finishDate;
  final String proposedBy;
  Resolution(
      {this.id,
      this.name,
      this.groupId,
      this.description,
      this.finishDate,
      this.proposedBy});

  factory Resolution.fromJson(Map<String, dynamic> json) {
    return Resolution(
      id: json['id'],
      name: json['name'],
      groupId: json['groupId'],
      description: json['description'],
      finishDate: jsonToDate(json['finishDate']),
      proposedBy: json['proposedBy'],
    );
  }
  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'name': name,
        'groupId': groupId,
        'description': description,
        'finishDate': DateFormat('yyyy-MM-dd').format(finishDate),
        'proposedBy': proposedBy
      };
    }
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'description': description,
      'finishDate': DateFormat('yyyy-MM-dd').format(finishDate),
      'proposedBy': proposedBy
    };
  }
}
