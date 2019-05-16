class Resolution {
  final int id;
  final String name;
  final DateTime date;
  final String description;
  final DateTime finishDate;
  Resolution(
      {this.id, this.name, this.date, this.description, this.finishDate});
  factory Resolution.fromJson(Map<String, dynamic> json) {
    return Resolution(
      id: json['id'],
      name: json['name'],
      date: jsonToDate(json['date']),
      description: json['description'],
      finishDate: jsonToDate(json['finish_date']),
    );
  }
}

DateTime jsonToDate(String date) {
  var temp = date.split('/');
  var t2 = temp[2] + temp[1] + temp[0];
  return DateTime.parse(t2);
}
