class Signature{
  final int id;
  final DateTime date;
  final TypeOfSign type;
  final int idMember;
  final int idResolution;

  Signature({this.id, this.date, this.type, this.idMember, this.idResolution});
  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      idMember: json['id_member'],
      idResolution: json['id_resolution'],

    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'type': type,
        'id_member': idMember,
        'id_resolution': idResolution
      };
}
enum TypeOfSign{
  accepted,
  declined,
  abstained
}