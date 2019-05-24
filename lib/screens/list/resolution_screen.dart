import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes.dart';
import '../../screens/list/resolution_list.dart';

class ResolutionScreen extends StatefulWidget {
  @override
  _ResolutionScreenState createState() => _ResolutionScreenState();
}

class _ResolutionScreenState extends State<ResolutionScreen> {
  final resolutionLIst = ResolutionList();

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
          Navigator.pushNamed(context, Routes.createResolution);
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
      body: ResolutionList(),
    );
  }

  Future logOut(context) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    user.remove('id');
    Navigator.pushReplacementNamed(context, Routes.home);
  }
}
