import 'package:cztery_pory_roku/bloc/groups/resolution_group_bloc.dart';
import 'package:cztery_pory_roku/bloc/groups/resolution_group_event.dart';
import 'package:cztery_pory_roku/screens/common/app_drawer.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_list.dart';
import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_group/add_resolution_group.dart';

class ResolutionGroupScreen extends StatefulWidget {
  @override
  ResolutionGroupScreenState createState() => ResolutionGroupScreenState();
}

class ResolutionGroupScreenState extends State<ResolutionGroupScreen> {
  ResolutionGroupBloc _bloc = ResolutionGroupBloc();

  @override
  void initState() {
    super.initState();
  }

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
  //Done:
  //refactoring: foldery, rename itp
  //bloc members do osobnego
  //animacja na fade transition
  //dodawanie grupy => przechodzi od razu do grupy
  //dodawanie od razu do grupy

}
