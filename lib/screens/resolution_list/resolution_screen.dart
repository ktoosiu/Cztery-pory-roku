import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/bloc/resolutions/resolution_bloc.dart';
import 'package:cztery_pory_roku/bloc/resolutions/resolution_list_events.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/models/user_data.dart';

import 'package:flutter/material.dart';

import 'new_resolution/create_resolution.dart';
import 'resolution_list.dart';

class ResolutionScreen extends StatefulWidget {
  final ResolutionGroup group;
  final UserData userData;
  const ResolutionScreen({Key key, this.group, @required this.userData})
      : super(key: key);

  @override
  _ResolutionScreenState createState() => _ResolutionScreenState();
}

class _ResolutionScreenState extends State<ResolutionScreen> {
  ResolutionListBloc _bloc = ResolutionListBloc();
  @override
  initState() {
    fetchResolution(widget.group.id).then((list) =>
        _bloc.fetchResolutionSink.add(FetchResolutionListEvent(list)));
    fetchUserSignatures(widget.userData.id).then((list) =>
        _bloc.fetchSignaturesSink.add(FetchUserSignaturesEvent(list)));

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
        title: Text("Uchwały"),
      ),
      floatingActionButton: widget.userData.isAdmin == true
          ? AddResolutionButton(groupId: widget.group.id, bloc: _bloc)
          : null,
      body: ResolutionList(
        widget.userData,
        widget.group,
        _bloc,
      ),
    );
  }
}

class AddResolutionButton extends StatelessWidget {
  final UserData userData;
  final int groupId;
  final ResolutionListBloc bloc;

  const AddResolutionButton({Key key, this.userData, this.groupId, this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => CreateResolution(
                  userData,
                  groupId,
                  (newResolution) => bloc.addResolutionSink.add(
                        AddResolutionEvent(newResolution),
                      ),
                ),
          ),
        );
      },
      icon: Icon(Icons.add),
      label: Text('Dodaj'),
    );
  }
}
