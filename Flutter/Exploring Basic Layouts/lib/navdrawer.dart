import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';


import 'package:exploring_basic_layouts/states/route_state.dart';


class NavigationDrawer extends StatelessWidget {

  const NavigationDrawer({ Key? key,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _getDrawerChildren(context),
      ),
    );
  }




  
  //* The Header for the Drawer.
  DrawerHeader _getDrawerHeader(BuildContext ctx) => DrawerHeader(
    decoration: BoxDecoration( 
      color: Colors.green[600], 
      image: const DecorationImage(
        image: AssetImage('assets/images/techbg.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Topics',
          style: Theme.of(ctx).textTheme.headline3?.copyWith( color: Colors.white,
          ),
        ),
      ],
    ),
  );


  //* Method to obtain the children of the drawer - A list of possible routes
  List<Widget> _getDrawerChildren(BuildContext ctx) => <Widget>[
    _getDrawerHeader(ctx),
    ListTile(
      title: const Text('Exploring Basic Layouts'),
      trailing: const Icon(Icons.account_tree_sharp),
      onTap: ()=> onRouteChange(ctx, 0),
    ),
    ListTile(
      title: const Text('Example 2'),
      trailing: const Icon(Icons.question_answer),
      onTap: ()=> onRouteChange(ctx, 1),
    ),
  ];



  //* Event handler when user taps on a route in drawer - Initiate route change
  onRouteChange(BuildContext ctx, int index) async {
    Navigator.pop(ctx);
    var routeProvider = Provider.of<RouteState>(ctx, listen: false);
    await Future.delayed(const Duration(milliseconds: 200));
    routeProvider.changeRoute(index);
  }

}