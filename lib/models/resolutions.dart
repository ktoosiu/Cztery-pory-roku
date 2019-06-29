class Resolution {
  final int id;
  final String name;
  final int groupId;
  final String description;
  final String proposedBy;
  Resolution(
      {this.id, this.name, this.groupId, this.description, this.proposedBy});

  factory Resolution.fromJson(Map<String, dynamic> json) {
    return Resolution(
      id: json['id'],
      name: json['name'],
      groupId: json['groupId'],
      description: json['description'],
      proposedBy: json['proposedBy'],
    );
  }
  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'name': name,
        'groupId': groupId,
        'description': description,
        'proposedBy': proposedBy
      };
    }
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'description': description,
      'proposedBy': proposedBy
    };
  }
}
