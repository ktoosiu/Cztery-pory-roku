import 'package:cztery_pory_roku/app_container/app_container.dart';
import 'package:cztery_pory_roku/bloc/groups/resolution_group_bloc.dart';
import 'package:cztery_pory_roku/bloc/groups/resolution_group_event.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/resolution_list/resolution_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit_group/edit_group.dart';

class ResolutionGroupListItem extends StatelessWidget {
  final ResolutionGroup item;
  final ResolutionGroupBloc parentBloc;

  const ResolutionGroupListItem(this.item, this.parentBloc, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer.of(context).state.userData.isAdmin == true
        ? new DismissibleItem(item: item, parentBloc: parentBloc)
        : SingleItemView(item: item);
  }
}

class DismissibleItem extends StatelessWidget {
  const DismissibleItem({
    Key key,
    @required this.item,
    @required this.parentBloc,
  }) : super(key: key);

  final ResolutionGroup item;
  final ResolutionGroupBloc parentBloc;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: new Container(
          padding: EdgeInsets.only(right: 20.0),
          color: Colors.blueGrey[200],
          child: new Align(
            alignment: Alignment.centerRight,
            child: new Text(
              'Edytuj',
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold),
            ),
          )),
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => EditGroup(
                  item,
                  (group) => parentBloc.editGroupSink.add(
                        EditGroupEvent(group),
                      ),
                ),
          ),
        );
      },
      child: SingleItemView(item: item),
    );
  }
}

class SingleItemView extends StatelessWidget {
  const SingleItemView({
    Key key,
    @required this.item,
  }) : super(key: key);

  final ResolutionGroup item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (itemContext) => ResolutionScreen(
                    group: item,
                    userData: AppContainer.of(context).state.userData)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
            child: Container(
          decoration: BoxDecoration(color: Colors.lightBlue[50]),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.id.toString(),
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(item.date))
                  ],
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: Text(
                    item.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        )),
      ),
    );
  }
}
