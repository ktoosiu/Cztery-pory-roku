import 'dart:async';

import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/list/resolution_bloc.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../models/resolutions.dart';
import '../../screens/list/resolution_list_item.dart';

class ResolutionList extends StatefulWidget {
  final ResolutionBloc parentBloc;
  final UserData userData;

  const ResolutionList(this.userData, this.parentBloc, {Key key})
      : super(key: key);

  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  Future<void> refresh() async {
    setState(() {
      fetchResolution().then((list) => widget.parentBloc.fetchResolutionSink
          .add(FetchResolutionListEvent(list)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: RefreshIndicator(
        child: StreamBuilder<List<Resolution>>(
            stream: widget.parentBloc.resolutionsStream,
            initialData: [],
            builder: (BuildContext context,
                AsyncSnapshot<List<Resolution>> snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ResolutionListItem(
                        resolution: snapshot.data[i],
                        userId: widget.userData.id,
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
