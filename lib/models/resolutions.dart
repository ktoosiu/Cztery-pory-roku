import '../utils/json_to_date.dart';
import 'package:intl/intl.dart';

class Resolution {
  final int id;
  final String name;
  final DateTime date;
  final String description;
  final DateTime finishDate;
  final String proposedBy;
  Resolution(
      {this.id,
      this.name,
      this.date,
      this.description,
      this.finishDate,
      this.proposedBy});

  factory Resolution.fromJson(Map<String, dynamic> json) {
    return Resolution(
      id: json['id'],
      name: json['name'],
      date: jsonToDate(json['date']),
      description: json['description'],
      finishDate: jsonToDate(json['finish_date']),
      proposedBy: json['proposed_by'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': DateFormat('dd/MM/yyyy').format(date),
        'description': description,
        'finish_date': DateFormat('dd/MM/yyyy').format(finishDate),
        'proposed_by': proposedBy
      };
}
