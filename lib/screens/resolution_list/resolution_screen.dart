import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/bloc/resolutions/resolution_bloc.dart';
import 'package:cztery_pory_roku/bloc/resolutions/resolution_list_events.dart';
import 'package:cztery_pory_roku/models/user_data.dart';

import 'package:cztery_pory_roku/utils/get_user.dart';
import 'package:flutter/material.dart';

import 'new_resolution/create_resolution.dart';
import 'resolution_list.dart';

class ResolutionScreen extends StatefulWidget {
  final groupId;
  final groupDate;
  const ResolutionScreen({Key key, this.groupId, this.groupDate})
      : super(key: key);

  @override
  _ResolutionScreenState createState() => _ResolutionScreenState();
}

class _ResolutionScreenState extends State<ResolutionScreen> {
  ResolutionListBloc _bloc = ResolutionListBloc();
  UserData userData;
  @override
  initState() {
    getUser().then((data) {
      userData = data;
      fetchResolution(widget.groupId).then((list) =>
          _bloc.fetchResolutionSink.add(FetchResolutionListEvent(list)));
      fetchUserSignatures(data.id).then((list) =>
          _bloc.fetchSignaturesSink.add(FetchUserSignaturesEvent(list)));
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resolutions"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => CreateResolution(
                    userData,
                    widget.groupId,
                    (newResolution) => _bloc.addResolutionSink.add(
                          AddResolutionEvent(newResolution),
                        ),
                  ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      body: ResolutionList(userData, widget.groupDate, _bloc, widget.groupId),
    );
  }
}