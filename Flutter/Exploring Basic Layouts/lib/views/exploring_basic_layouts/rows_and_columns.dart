import 'package:flutter/material.dart';
import 'package:exploring_basic_layouts/widgets/box.dart';
import 'package:exploring_basic_layouts/widgets/section.dart';


// Page Structure:
// - Column
//    - Title
//    - Description
//    - Example


// - MainAxisSize
// - CrossAxisAlignment
// - MainAxisAlignment


class RowsAndColumns extends StatelessWidget {
  const RowsAndColumns({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: getListviewOfSections([
        Section(
          title: 'Hello Hello Hello Hello Hello', 
          description: 'Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',
          bodies: [Box.regular(), Box.regular()]
        ),
        Section(
          title: 'Hello Hello Hello Hello Hello', 
          description: 'Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',
          bodies: [Box.regular(), Box.regular()]
        ),
        Section(
          title: 'Hello Hello Hello Hello Hello', 
          description: 'Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',
          bodies: [Box.regular(), Box.regular()]
        ),
        Section(
          title: 'Hello Hello Hello Hello Hello', 
          description: 'Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',
          bodies: [Box.regular(), Box.regular()]
        ),
      ]),
    );
  }
}







