import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/screens/common/app_drawer.dart';
import 'package:cztery_pory_roku/screens/list/resolution_bloc.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:cztery_pory_roku/screens/member/member_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'new_member/add_member.dart';

class MemberScreen extends StatefulWidget {
  //final ResolutionListBloc parentBloc;

  // const MemberScreen({Key key, this.parentBloc}) : super(key: key);
  const MemberScreen({Key key}) : super(key: key);

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  ResolutionListBloc _bloc = ResolutionListBloc();
  @override
  initState() {
    fetchMembers()
        .then((list) => _bloc.fetchMemberSink.add(FetchMemberListEvent(list)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddMember(
                    (newMember) => _bloc.addMemberSink.add(
                          AddMemberEvent(newMember),
                        ),
                  ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      body: MemberList(_bloc),
    );
  }

//TODO: edit member?
}
