import 'package:flutter/material.dart';


// A section of title, caption and a body consisting of multiple widgets
class Section extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> bodies;

  const Section({
    Key? key, 
    required this.title, 
    required this.description,
    required this.bodies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      const SizedBox( height: 12 ),
      Text(
        title, 
        style: Theme.of(context).textTheme.headline4,
      ),
      const SizedBox(height: 8,),
      Text(
        description, 
        style: Theme.of(context).textTheme.caption,
      ),
      const SizedBox(height: 10,),
    ];
    children.addAll(bodies);
    children.add( Divider(height: 64, color: Colors.grey[600]), );

    return Column( children: children, );
  }
}



// A page consist of multiple sections. This function combines them all into
// a Listview of sections - Scrollable
ListView getListviewOfSections(List<Section> sections) {
  return ListView(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    children: sections,
  );
}