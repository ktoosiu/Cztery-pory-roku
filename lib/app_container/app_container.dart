import 'package:cztery_pory_roku/models/app_state.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  const AppContainer({@required this.child, Key key, this.state})
      : super(key: key);
  static AppContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedWidgetContainer)
            as _InheritedWidgetContainer)
        .data;
  }

  @override
  AppContainerState createState() => AppContainerState(state: state);
}

class AppContainerState extends State<AppContainer> {
  AppState state;
  AppContainerState({@required this.state});

  @override
  Widget build(BuildContext context) {
    return new _InheritedWidgetContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedWidgetContainer extends InheritedWidget {
  final AppContainerState data;

  _InheritedWidgetContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
