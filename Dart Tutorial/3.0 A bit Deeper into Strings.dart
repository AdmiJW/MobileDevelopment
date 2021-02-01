
/*
  =============================================
  🆒🆒🆒 3.0 A bit Deeper into Strings 🆒🆒🆒
  =============================================

  1. In Dart, single quotes and double quotes makes no difference, just like
     in CSS, HTML, Python or JS
  2. To have RAW strings (escape characters won't work), prefix a 'r' before
     the single/double opening quote, like
          r'This is my String'
  3. As said earlier, string interpolation works just like in JS. Using dollar
     sign
          '1 + 2 is ${1 + 2}'
          'my name is $name'
  4. Multiline strings are achieved using triple single/double quotes
  5. To easily convert between strings to another is easy due to everything
     being an object (Meaning they are associated with functions). 
        > int.parse()
        > double.parse()
        > 1.toString()
        > 3.1231.toString()
  6. Constants are declared using 'const'. No need to define any datatype after
     that
  7. To check the datatype at runtime, we can check upon 
        v.runtimeType
*/


main() {
  //  Raw Strings
  print("");
  print( r"Raw Strings \n\n Won't get processed!" );


  //  String Interpolation
  String adj = "charm";
  print( "String interpolation works like a $adj. 1 + 2 = ${1+2}");


  //  Multiline Strings
  String mult = '''
    This is a 
    Multiline String!
  ''';
  print(mult);


  //  Type conversion
  int conv1 = int.parse("12345");
  double conv2 = double.tryParse("1.2345");

  String conv3 = 1.toString();
  String conv4 = 1.2345.toString();

  print("String to int: $conv1");
  print("String to double: $conv2");
  print("Int to String: $conv3");
  print("Double to String: $conv4");


  //  Constants
  const con1 = "This is constant";
  const con2 = 12345;

  print( con1 + " " + con2.toString() );


  //  Type checking
  dynamic d1 = 12345;
  print('$d1 is ${d1.runtimeType} now');
  d1 = 1.2345;
  print('$d1 is ${d1.runtimeType} now');
  d1 = "Hello";
  print('$d1 is ${d1.runtimeType} now');
}

