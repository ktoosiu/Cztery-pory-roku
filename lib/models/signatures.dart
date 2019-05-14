class Signatures{
  final int id;
  final DateTime date;
  final TypeOfSign type;
  final int idMember;
  final int idResolution;

  Signatures({this.id, this.date, this.type, this.idMember, this.idResolution});
  factory Signatures.fromJson(Map<String, dynamic> json) {
    return Signatures(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      idMember: json['id_member'],
      idResolution: json['id_resolution'],

    );
  }
}
enum TypeOfSign{
  accepted,
  declaimed,
  abstained
}