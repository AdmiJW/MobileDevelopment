//* Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Self defined widgets
import 'mytheme.dart';

//* States
import 'package:exploring_basic_layouts/states/route_state.dart';


void main()=> runApp(const MyApp());





class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RouteState() ),
      ],
      child: MaterialApp(
        title: 'Exploring Basic Layouts',
        theme: MyTheme.lightTheme,
        home: const MainScreen(),
      ),
    );
  }
}




class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stateProvider = Provider.of<RouteState>(context);
    var route = stateProvider.routes[ stateProvider.routeIndex ];

    return route;
  }
}


