import 'package:cztery_pory_roku/screens/list/resolution_bloc.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:cztery_pory_roku/screens/member/member_list.dart';
import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'new_member/add_member.dart';

class MemberScreen extends StatefulWidget {
  final ResolutionListBloc parentBloc;

  const MemberScreen({Key key, this.parentBloc}) : super(key: key);
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); //routing
              },
              child: DrawerHeader(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.first_page,
                        color: Colors.white,
                        size: 32,
                      ),
                      Text(
                        'Cztery Pory Roku',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue), //TODO:dodać usera do drawera
              ),
            ),
            ListTile(
              title: Text('Resolutions'),
              leading: Icon(Icons.close),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Routes.resolutions));
              },
            ),
            ListTile(
              title: Text('Members'),
              leading: Icon(Icons.close),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddMember(
                    (newMember) => widget.parentBloc.addMemberSink.add(
                          AddMemberEvent(newMember),
                        ),
                  ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      body: MemberList(widget.parentBloc),
    );
  }

//TODO: edit member?
}
