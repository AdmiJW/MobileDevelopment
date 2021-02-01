
import 'dart:io';
/*
  =====================================
  🐤🐤🐤 1.0 Hello, Dart 🐤🐤🐤
  =====================================

  Dart is the programming language for Flutter, which is widely used in mobile
  app development - Grab, Tencent app etc.

  Dart is:
    > Statically typed language - Once the type for a variable is determined,
                                  the type cannot be changed
    > Compiled - AOT(Ahead of Time) - Compiled Ahead of time during production
               - JIT(Just in Time) - Compiled when we run the code during
                                     development
    > 100% Object Oriented - Everythings an Object. int is an object,
                             even null is an object!
*/

/*
  =======================
  HELLO WORLD
  =======================

  1. Dart's program entry point is main() function. It has void return
     type.
  2. To print to the console. simply print()
  3. For functions with return type 'void', 'void' can be neglected!
*/

main() {
  print("🌏Hello World!🌏\n");

  greet();
  getUserInput();
}





/*
  ==================
  Variables
  ==================

  1. Dart supports type inference. Using 'var' will cause it to infer the
     datatype based on its value. That does not mean you can change the value
     to different datatype later though!
  2. Instead of 'var', we can explicitly define the datatype itself, like
     'String'
  3. Like Javascript, you can do String interpolation, using $var_name or
     codes like ${statements}
*/

//  Remember that 'void' is optional!
void greet() {
  String first = "Admi";
  var last = "JW";

  print('Hello and nice to meet you ' + first + last);
  print('I hope you are doing alright $first$last\n');
}




/*
  =================
  Input and Output
  =================

  1. By default (Like Java), it comes with a defualt package (called modules
     or libraries in other languages) imported called 'dart:core'
  2. To deal with command line input and output, you need to import
     'dart:io' package.
  3. Then you can use:
        > stdout.wirteln(...)
        > stdin.readLineSync(...)
        and many more to explore!
*/

getUserInput() {
  stdout.writeln("Hello! What is your name?");
  String name = stdin.readLineSync();
  stdout.writeln("What is your age then?");
  int age = int.parse(stdin.readLineSync() ); 

  print("\nNice to Meet you $name");
  print("Being $age years old is still young!");
}