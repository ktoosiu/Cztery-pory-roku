import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/list/resolution_bloc.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:cztery_pory_roku/screens/new/create_resolution.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes.dart';
import '../../screens/list/resolution_list.dart';

class ResolutionScreen extends StatefulWidget {
  final UserData userData;

  const ResolutionScreen({Key key, this.userData}) : super(key: key);

  @override
  _ResolutionScreenState createState() => _ResolutionScreenState();
}

class _ResolutionScreenState extends State<ResolutionScreen> {
  ResolutionBloc _bloc = ResolutionBloc();

  @override
  initState() {
    fetchResolution().then((list) =>
        _bloc.fetchResolutionSink.add(FetchResolutionListEvent(list)));
    super.initState();
  }

  Future<UserData> getUser() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var id = user.getInt('id');
    var name = user.getString('name');
    var lastName = user.getString('lastName');

    return UserData(id, name, lastName);
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
        actions: [
          IconButton(
            onPressed: () {
              logOut(context);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => CreateResolution(widget.userData)));
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      body: ResolutionList(widget.userData, _bloc),
    );
  }

  Future logOut(context) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    user.remove('id');
    Navigator.pushReplacementNamed(context, Routes.login);
  }
}
