/*
    ===================================
    ➕➖➗✖️ 4.0 Operators ➕➖➗✖️
    ===================================

    Operators are important. They let you operate on data.

    Now, common operators that you see in other languages, apply here too!
    Quick refresher:
        +, -, *, /, %, ==, !=, >=, <=, *=, +=, -=, ++, --, &&, ||, !,
    Also, ternary operator works like Java, Javascript or C++
        expression? valIfTrue: valIfFalse;

    Type checking operator is simply a keyword 'is', like in Python
        x is int
*/

operators_1() {
  var val = 1;

  if (val is int) {
    print("val $val is an integer!");

    val == 1? print("val is one only"): print("val is not one!");
  }
}


/*
    =======================================
    🈚🈚🈚 Null Aware Operators 🈚🈚🈚
    ======================================

    Dart has what's called null aware operators, which will perform
    operation based on whether the variable is null or not. See variations:

    ?.    <= Mainly used when accessing an object method or property.
             If the variable is null, it simply skip accessing
    ??    <= Used along with "?.". When the object variable is indeed
             null, we can specify default value to return after this ??
    ??=   <= Kind of like || in javascript. If left side is null, will
             use the default value on right side

    Let's see example by using a real class and object!
*/

class Example {
  int num = 33;
}

operators_2() {
  var exists = Example();
  var notfound;

  //  Demonstration of ?. and ??
  print( exists?.num ?? "'exists' is null! ");    //  Since exists is not null, access .num
  print( notfound?.num ?? "'notfound' is null!"); //  Since notfound is null, default value

  print('\n');
  //  Demonstration of ??=
  exists.num = 66;
  exists ??= Example();     //  Since exists is not null, it will not be new Example()
  notfound ??= Example();   //  Since notfound is null, it is assigned new object

  print(exists?.num);       //  66 since dont change
  print(notfound?.num);     //  33. Now notfound has an object!
}


main() {
  operators_2();
}