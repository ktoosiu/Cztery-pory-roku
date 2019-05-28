import 'dart:async';

import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/list/resolution_bloc.dart';
import 'package:cztery_pory_roku/screens/list/resolution_list_events.dart';
import 'package:cztery_pory_roku/viewModels/resolution_list_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../screens/list/resolution_list_item.dart';

class ResolutionList extends StatefulWidget {
  final ResolutionListBloc parentBloc;
  final UserData userData;

  const ResolutionList(this.userData, this.parentBloc, {Key key})
      : super(key: key);

  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  Future<void> refresh() async {
    fetchResolution().then((list) => widget.parentBloc.fetchResolutionSink
        .add(FetchResolutionListEvent(list)));
    fetchUserSignatures(widget.userData.id).then((list) => widget
        .parentBloc.fetchSignaturesSink
        .add(FetchUserSignaturesEvent(list)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: RefreshIndicator(
        child: StreamBuilder<List<ResolutionListItemViewModel>>(
            stream: widget.parentBloc.resolutionsStream,
            initialData: [],
            builder: (BuildContext context,
                AsyncSnapshot<List<ResolutionListItemViewModel>> snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ResolutionListItem(
                        viewModel: snapshot.data[i],
                        userData: widget.userData,
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
