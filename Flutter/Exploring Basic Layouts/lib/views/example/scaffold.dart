import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


import 'package:exploring_basic_layouts/navdrawer.dart';
import 'package:exploring_basic_layouts/states/route_state.dart';







class ExampleScaffold extends StatelessWidget {
  const ExampleScaffold({ Key? key }) : super(key: key);

  //? Tabbar for this route.
  AppBar get _appBar {
    const tabBar = TabBar(
      isScrollable: true,
      tabs: [
        Tab(child: Text('1')),
        Tab(child: Text('2')),
        Tab(child: Text('3')),
      ],
    );

    return AppBar(
      title: const Text("Example"),
      backgroundColor: Colors.green,
      bottom: tabBar,
    );
  } 


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar,
        drawer: const NavigationDrawer(),
        body: TabBarView(
          children: [
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}