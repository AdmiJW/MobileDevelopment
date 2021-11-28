
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:exploring_basic_layouts/states/route_state.dart';
import 'package:exploring_basic_layouts/navdrawer.dart';






class ExploringBasicLayoutsScaffold extends StatelessWidget {
  const ExploringBasicLayoutsScaffold({ Key? key }) : super(key: key);

  //? Tabbar for this route.
  AppBar get _appBar {
    const tabBar = TabBar(
      isScrollable: true,
      tabs: [
        Tab(child: Text('Row and Columns')),
        Tab(child: Text('Flexible & Expanded')),
        Tab(child: Text('SizedBox, Spacer & Container')),
      ],
    );

    return AppBar(
      title: const Text("Exploring Basic Layouts"),
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