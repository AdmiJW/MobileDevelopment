
/*
  ====================================
  ⌨️⌨️⌨️ 2.0 Basic Datatypes ⌨️⌨️⌨️
  ====================================

  Remember, Dart is strongly typed language. Datatypes must be known at compile
  time. HOWEVER, there is an exception that we will reveal later

  There are 5 basic datatypes (which can be set to null):
  > int
  > double
  > String
  > bool
  > dynamic

  and some collections datatypes:
  > List
  > Set
  > Map

  What? dynamic? Yes, dynamic variables can change datatypes during runtime,
  hence the name dynamic.

  Again to inform, type inference is always available, just use 'var' and
  compiler will infer the type for you!
*/

main() {

  //  int
  int n1 = 100;
  var n2 = 500;
  print('Integers are $n1 and $n2');

  //  double
  double d1 = 1.234;
  var d2 = 3.1415;
  print('Doubles are $d1 and $d2');

  //  Strings
  String s1 = "Hello World";
  var s2 = 'Bye World';
  print("Strings are $s1 and $s2");

  //  bool
  bool b1 = true;
  var b2 = false;
  print("Booleans are $b1 and $b2");

  //  Dynamic
  dynamic dy = "I am now string";
  print("Dynamic is now $dy");
  dy = 123;
  print("Dyanmic is now $dy");
  dy = null;
  print("Dynamic is now $dy");

}