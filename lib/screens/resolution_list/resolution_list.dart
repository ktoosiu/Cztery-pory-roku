import 'dart:async';

import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/bloc/resolutions/resolution_bloc.dart';
import 'package:cztery_pory_roku/bloc/resolutions/resolution_list_events.dart';
import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:cztery_pory_roku/screens/resolution_list/resolution_list_item.dart';

import 'package:cztery_pory_roku/viewModels/resolution_list_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ResolutionList extends StatefulWidget {
  final ResolutionListBloc parentBloc;
  final groupDate;
  final finishDate;
  final UserData userData;
  final int groupId;
  const ResolutionList(this.userData, this.groupDate, this.parentBloc,
      this.groupId, this.finishDate,
      {Key key})
      : super(key: key);

  @override
  ResolutionListState createState() => ResolutionListState();
}

class ResolutionListState extends State<ResolutionList> {
  Future<void> refresh() async {
    fetchResolution(widget.groupId).then((list) => widget
        .parentBloc.fetchResolutionSink
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
              if (snapshot.hasData) {
                if (snapshot.data.isNotEmpty) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ResolutionListItem(
                          // viewModel: snapshot.data[i],
                          viewModel: ResolutionListItemViewModel(
                              snapshot.data[i].resolution,
                              snapshot.data[i].signature,
                              date: widget.groupDate,
                              finishDate: widget.finishDate),

                          userData: widget.userData,
                          callback: (signature) =>
                              widget.parentBloc.addSignatureSink.add(
                                AddUpdateSignatureEvent(signature),
                              ),
                        );
                      });
                } else {
                  return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey[250],
                            child: Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [Text('No resolutions')],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]);
                }
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
