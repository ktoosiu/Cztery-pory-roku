import 'package:cztery_pory_roku/app_container/app_container.dart';
import 'package:cztery_pory_roku/models/app_state.dart';
import 'package:cztery_pory_roku/screens/member/member_screen.dart';
import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_screen.dart';
import 'package:cztery_pory_roku/utils/get_user.dart';
import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  void _navigateToResolution(context) {
    getUser().then((userData) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: Routes.resolutionGroups),
          builder: (context) => AppContainer(
              state: AppState(userData), child: ResolutionGroupScreen())));
    });
  }

  void _navigateToMember(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        settings: RouteSettings(name: Routes.member),
        builder: (context) => MemberScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); //routing
            },
            child: DrawerHeader(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.first_page,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Cztery Pory Roku',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue), //TODO:dodać usera do drawera
            ),
          ),
          ListTile(
            title: Text('Resolutions'),
            leading: Icon(Icons.close),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              _navigateToResolution(context);
            },
          ),
          ListTile(
            title: Text('Members'),
            leading: Icon(Icons.close),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              _navigateToMember(context);
            },
          ),
        ],
      ),
    );
  }
}
