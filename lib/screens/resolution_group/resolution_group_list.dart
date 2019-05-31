import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_bloc.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_event.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_list_item.dart';
import 'package:flutter/material.dart';

class ResolutionGroupList extends StatefulWidget {
  @override
  ResolutionGroupListState createState() => ResolutionGroupListState();
}

class ResolutionGroupListState extends State<ResolutionGroupList> {
  ResolutionGroupBloc _bloc = ResolutionGroupBloc();
  Future<void> refresh() async {
    fetchResolutionGroup().then((list) =>
        _bloc.fetchResolutionGroupsSink.add(FetchResolutionGroupsEvent(list)));
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: RefreshIndicator(
        child: StreamBuilder<List<ResolutionGroup>>(
            stream: _bloc.resolutionsStream,
            initialData: [],
            builder: (BuildContext context,
                AsyncSnapshot<List<ResolutionGroup>> snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ResolutionGroupListItem(snapshot.data[i]);
                      // return ResolutionListItem(
                      //   viewModel: snapshot.data[i],
                      //   userData: widget.userData,
                      //   callback: (signature) =>
                      //       widget.parentBloc.addSignatureSink.add(
                      //         AddUpdateSignatureEvent(signature),
                      //       ),
                      // );
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
