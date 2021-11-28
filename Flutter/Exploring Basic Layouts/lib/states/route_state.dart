import 'package:flutter/material.dart';

//* Routes
import 'package:exploring_basic_layouts/views/exploring_basic_layouts/scaffold.dart';
import 'package:exploring_basic_layouts/views/example/scaffold.dart';




class RouteState extends ChangeNotifier {
  final List<Widget> routes = [
    const ExploringBasicLayoutsScaffold(),
    const ExampleScaffold(),
    Container(),
  ];
  int routeIndex = 0;

  
  //* Changes the routeIndex to the specified index. Calls notifyListeners()
  //* to initiate state update
  void changeRoute(int index) {
    if (index >= routes.length || index < 0) {
      throw ArgumentError("Route index is out of range. Index can only be"
                          "in range [0-${routes.length - 1}]");
    }
    if (index == routeIndex) return;

    routeIndex = index;
    notifyListeners();
  }
}