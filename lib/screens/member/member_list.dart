import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/bloc/members/members_bloc.dart';
import 'package:cztery_pory_roku/bloc/members/members_events.dart';
import 'package:cztery_pory_roku/models/members.dart';
import 'package:cztery_pory_roku/screens/member/member_list_item.dart';
import 'package:flutter/material.dart';

class MemberList extends StatefulWidget {
  final MembersBloc parentBloc;

  const MemberList(
    this.parentBloc, {
    Key key,
  }) : super(key: key);

  @override
  MemberListState createState() => MemberListState();
}

class MemberListState extends State<MemberList> {
  Future<void> refresh() async {
    fetchMembers().then((list) =>
        widget.parentBloc.fetchMemberSink.add(FetchMemberListEvent(list)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: RefreshIndicator(
        child: StreamBuilder<List<Member>>(
          stream: widget.parentBloc.membersStream,
          initialData: [],
          builder:
              (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return MemberListItem(
                    snapshot.data[i],
                    callback: () => {refresh()},
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
        onRefresh: refresh,
      ),
    );
  }
}
