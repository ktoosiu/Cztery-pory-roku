import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/resolutions.dart';
import '../../screens/list/resolution_list_item.dart';
import '../../api/http_data.dart';

class ResolutionList extends StatefulWidget {
  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  var _resolutions = <Resolution>[];

  int userId;
  @override
  initState() {
    getUserId();
    super.initState();
  }

  Future<int> getUser() async {
    final SharedPreferences user = await SharedPreferences.getInstance();
    var temp = user.getInt('id');
    return temp;
  }

  getUserId() async {
    final val = await getUser();
    userId = val;
  }

  Future<void> refresh() async {
    setState(() {
      getUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: RefreshIndicator(
        child: FutureBuilder(
            future: fetchResolution(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _resolutions = snapshot.data;

                return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _resolutions.length,
                    itemBuilder: (context, i) {
                      return ResolutionListItem(
                        resolution: _resolutions[i],
                        userId: userId,
                      );
                    });
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
            }),
        onRefresh: refresh,
      ),
    );
  }
}
