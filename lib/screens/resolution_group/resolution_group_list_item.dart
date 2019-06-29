import 'package:cztery_pory_roku/app_container/app_container.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/resolution_list/resolution_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResolutionGroupListItem extends StatelessWidget {
  final ResolutionGroup item;

  const ResolutionGroupListItem(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (itemContext) => ResolutionScreen(
                    groupId: item.id,
                    groupDate: item.date,
                    finishDate: item.finishDate,
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
