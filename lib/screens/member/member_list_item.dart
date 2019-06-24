import 'package:cztery_pory_roku/models/members.dart';
import 'package:flutter/material.dart';

import 'details/member_details.dart';

class MemberListItem extends StatelessWidget {
  final Member _member;
  final Function() callback;
  const MemberListItem(
    this._member, {
    Key key,
    @required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemberDetails(
                  member: _member,
                  callback: callback,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          child: Container(
            color: Colors.lightBlue[50],
            child: ListTile(
              title: Text(
                  '${_member.id}. ${_member.firstName} ${_member.lastName}'),
              subtitle: Text('${_member.address} '),
            ),
          ),
        ),
      ),
    );
  }
}
