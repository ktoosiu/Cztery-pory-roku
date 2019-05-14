class Members{
  final int id;
  final String firstName;
  final String lastName;
  final String address;

  Members({this.id, this.firstName, this.lastName, this.address});
  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      address: json['address'],

    );
  }
}