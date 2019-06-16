import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/screens/common/app_drawer.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_list.dart';
import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_group/add_resolution_group.dart';
import 'resolution_group_bloc.dart';
import 'resolution_group_event.dart';

class ResolutionGroupScreen extends StatefulWidget {
  @override
  ResolutionGroupScreenState createState() => ResolutionGroupScreenState();
}

class ResolutionGroupScreenState extends State<ResolutionGroupScreen> {
  ResolutionGroupBloc _bloc = ResolutionGroupBloc();
  // Future<void> refresh() async {
  //   fetchResolutionGroup().then((list) =>
  //       _bloc.fetchResolutionGroupsSink.add(FetchResolutionGroupsEvent(list)));
  // }

  // @override
  // void initState() {
  //   refresh();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resolution Groups"),
        actions: [
          IconButton(
            onPressed: () {
              logOut(context);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddResolutionGroup(
                    (group) => _bloc.addResolutionGroupSink.add(
                          AddResolutionGroupEvent(group),
                        ),
                  ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      body: ResolutionGroupList(_bloc),
    );
  }

  Future logOut(context) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    user.remove('id');
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  //TODO:  dodawanie grupy => przechodzi od razu do grupy
  //dodawanie od razu do grupy
  //bloc edit z members
  //refactoring: foldery, rename itp
  //doneanimacja na fade transition
}