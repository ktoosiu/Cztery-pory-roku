import 'package:cztery_pory_roku/models/members.dart';
import 'package:flutter/material.dart';

class MemberListItem extends StatelessWidget {
  final Member _member;

  const MemberListItem(
    this._member, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Container(
          color: Colors.lightBlue[50],
          child: ListTile(
            title:
                Text('${_member.id}. ${_member.firstName} ${_member.lastName}'),
            subtitle: Text('${_member.address} '),
          ),
        ),
      ),
    );
  }
}
