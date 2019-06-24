import 'package:cztery_pory_roku/api/http_data.dart';
import 'package:cztery_pory_roku/models/members.dart';
import 'package:flutter/material.dart';

class MemberDetails extends StatelessWidget {
  final Member member;
  final Function() callback;

  const MemberDetails({Key key, this.member, @required this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member.id.toString()),
      ),
      body: Container(
        color: Colors.lightBlue[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Container(
              constraints: BoxConstraints.expand(),
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Id: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: member.id.toString()),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Imię: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: member.firstName),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Nazwisko: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: member.lastName),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 64),
                      child: member.id != 1
                          ? FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              splashColor: Colors.red[900],
                              color: Colors.redAccent[200],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      "Usuń Użytkownika",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                deleteMember(member.id).then((x) {
                                  callback();
                                });
                                Navigator.pop(context);
                              },
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
