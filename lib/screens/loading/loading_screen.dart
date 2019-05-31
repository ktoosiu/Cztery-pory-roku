import 'package:cztery_pory_roku/screens/resolution_group/resolution_group_screen.dart';
import 'package:cztery_pory_roku/utils/get_user.dart';
import 'package:cztery_pory_roku/utils/routes.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });

    _controller.forward();
    _checkUser();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      children: [
                        ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.1)
                              .animate(_controller),
                          child: Image.asset(
                            'assets/logo.png',
                            height: 150,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  void _navigateToResolution() {
    getUser().then((userData) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: Routes.resolutionGroups),
          builder: (context) => ResolutionGroupScreen()));
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  Future _checkUser() async {
    await Future.delayed(Duration(seconds: 2));
    final SharedPreferences user = await SharedPreferences.getInstance();
    var savedId = user.getInt('id');
    if (savedId != null) {
      _navigateToResolution();
    } else {
      _navigateToLogin();
    }
  }
}
