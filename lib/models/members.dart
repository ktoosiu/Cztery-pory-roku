class Member {
  final int id;
  final String firstName;
  final String lastName;
  final String address;

  Member({this.id, this.firstName, this.lastName, this.address});
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'address': address
      };
}
