/*
    =================================
    📦📦📦 6.0 Collections 📦📦📦
    =================================

    List

    Arrays in Dart are called List. It is a dynamic array as in the length
    of the array can change easily as we append items into it.

    We can quickly define an array by 'var' or dynamic (No type inference)
    or to be type safe, use List class

        List arr = [...];

    Like Java, the above will result in a List<dynamic> being created, which
    can consist of any datatype. To enforce the datatype further, specify the
    type as follows:

        List<String> arr = [...];

    As usual, everything is Object in Dart. Simply access those useful properties
    and methods

        arr.length;
        arr.add( e );

    Note that when using var keyword, we can enforce the type by using <type>
    before the list, on the right hand side, like:

        var arr = <String>[...];

        var <String> arr = [...];   <- Invalid!
*/
import 'dart:io';


collections_1() {
  var anything = ["A", 1, 2.34];                //  List<Object>
  List anything2 = ["B", 2, 3.142];             //  List<dynamic>
  List<String> enforced = ["Adam", "Charles"];  //  List<String>

  var empty = List<String>();                   //  Constructor

  for (var i in anything) stdout.write("$i ");
  print("");
  for (var i in anything2) stdout.write("$i ");
  print("");
  for (var i in enforced) stdout.write("$i "); 
}



/*
    Set

    Dart comes with Set Collection. Set allow you to store unique elements,
    unordered.

    Arrays use square bracket notation, while a set uses curly bracket notation.
    { ... }
    However, when we want to create an empty set using {} and var, it will
    infer it as HashMap. Therefore we have to be more specific by specifying
    the type, like

        var s = <Object>{}
        var t = <dynamic>{}
*/

collections_2() {
  var anything = {"Apple", 2, 1.23};      //  Inferred as Set<Object>
  Set anything2 = {"Orange", 1, 5.678};   //  Set<dynamic>
  var fixed = <Object>{};                 //  Specify type to avoid HashMap infer
                                          //  on empty Set
  var names = <String>{"Chris", "Xavier"};

  var empty = Set<String>();              //  Constructor

  for (var i in anything) stdout.write("$i ");
  print("");
  for (var i in anything2) stdout.write("$i ");
  print("");
  for (var i in names) stdout.write("$i "); 
}





/*
    Map

    Like Set, but it maps to a value. A Map stores key value pairs.
    Inside curly bracket, we use colon : to seperate key and values.
*/

collections_3() {
  var map = { 1: "Adam", "val": 1.23 }; //  Inferred Map<Object, Object>
  Map map2 = { 2: "Chris", "float": 3.142 };  //  Map<dynamic, dynamic>
  var fixed = <int, int>{};                 //  Inferred as Map<int, int>

  var names = <int, String>{1: "Wong", 2: "Alex"};

  var empty = Map<Object, Object>();      //  Constructor


  map.forEach( (x,y)=> stdout.write("$x : $y\t") );
  print("");
  for (var k in map2.keys) stdout.write("$k : ${map2[k]}\t");
  print("");
  for (var e in names.entries) stdout.write("${e.key} : ${e.value}\t");
}

Function f = () {
  print("X");
};


main() {
  collections_3();
}