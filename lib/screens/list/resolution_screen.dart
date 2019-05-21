import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/list/resolution_list.dart';

class ResolutionScreen extends StatelessWidget {
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
      body: ResolutionList(),
    );
  }

  Future logOut(context) async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    user.remove('id');
    Navigator.pop(context);
  }
}
