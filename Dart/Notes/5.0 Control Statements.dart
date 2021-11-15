
/*
    =======================================
    ⚒️⚒️⚒️ 5.0 Control Statements ⚒️⚒️⚒️
    =======================================

    In Dart, most of the control statements we already know. See:

    if .. else if ... else
    switch() { case ... break }

    For looping, the good old for loop syntax is the very same
        for (var i = 0; i < 10; ++i) 

    There is while loop as well, with break and continue working

    Also, to loop through arrays, we can use for..in loop,
        for (var v in arr)

    Through higher order functions, we can use forEach loop, and pass
    in a function to be executed on each element
        arr.forEach( (x)=> ... );
*/

import 'dart:math';
import 'dart:io';

control_1() {
  var arr = [];
  var rand = new Random();

  for (var i = 0; i < 10; ++i) arr.add( rand.nextInt(50) );
  
  for (var v in arr) stdout.write("$v ");
  print("");
  arr.forEach( (x) => stdout.write("$x ") );
}



main() {
  control_1();
}