import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:cztery_pory_roku/screens/list/resolution_screen.dart';
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
                builder: (context) => ResolutionScreen(
                      groupId: item.id,
                    )));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ResolutionDetails(
        //           item: viewModel,
        //           userData: userData,
        //           callback: callback,
        //         ),
        //   ),
        // );
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
                    Text(DateFormat('dd-MM-yyyy').format(item.date))
                  ],
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    item.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
