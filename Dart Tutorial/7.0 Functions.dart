
/*
    ==============================
    🔨🔨🔨 7.0 Functions 🔨🔨🔨
    ==============================

    - As stated previously, for void functions, the return type can be ignored,
      just like main!

          main() {...}

    - To allow for variable type return value, use 'dynamic'. To allow for
      variable type parameter, use 'var' or 'dynamic'
*/

dynamic functions_1( var anyType ) {
  print("You just passed in ${anyType.runtimeType}!");
  return anyType;
} 





/*
    Arrow Functions and Anonymous functions

    Functions are first class citizens, due to EVERYTHING IN DART IS OBJECT
    (repeated many times). They can be assigned to variable as well!

    1. Arrow functions can only consist of one line statement!

        var foo = ()=> print("Hello");      //  It will infer return type
        bar () => print("Bye");             //  dynamic return type, without
                                                assigning 

    2. To have multilines, use curly brackets, but without arrow operator
        var foo = () {
          ...                           //  Warning about cannot infer type
        };                              //  but still runnable. PUT SEMICOLON!

        bar () {                    //  Revealing! This is a normal function
          ...                       //  declaration of void as said before
        }                           //  Turns out, it infers as dynamic return type


    3. Anonymous functions are functions without names. Commonly used in passing
        as arguments.
        > Use either arrow function syntax, or
        > Use curly brackets for multilines

        arr.forEach( (x)=> ... );
        arr.forEach( (x) {
          ...
        });
*/

var printer = (var x) {
  x.forEach( (i) => print(i) );
};





/*
    Named arguments, Optional Arguments, and Default values

    1. By default, arguments are positional. To define named arguments, wrap
       them like a Map, in curly brackets

       dynamic sum({ num1, num2 }) {...}

       Then to use it: 
          sum( num2: 3, num1: 1);

    2. We can have a mix of positional and named arguments. Positional must
       come first before named!

       dynamic sum( num1, {num2}) {...}

       Then to use it:
          sum(1, num2: 3);

    3. Both positional and named arguments can be optional, as we put in 
       default values for them. Default values are given in =

       >  For a positional argument to be optional and able to have default
          values, it must be wrapped in [],

          dynamic sum([num1, num2 = 5]) {...}
      
       >  Named arguments are already optional.

          dynamic sum(num1, {num2 = 5}) {...}

      In all above cases, if no default values are given, it is now useful
      to use null checking operators - ??, ?. and ??=
*/

String getHttpUrl( String server, String path, {int port = 8000, Map query}) {
  
  //  Builds out the query string first
  String queryStr = query == null? "": "?";
  queryStr += query?.keys?.map((x)=> "$x=${query[x]}")?.join("&") ?? ""; 

  return "$server:$port/$path$queryStr";
}




main() {
  print( getHttpUrl("google.com", "profile", port: 80, query: {
    "name": "AdmiJW"
  }));
  print( getHttpUrl("google.com", "main"));
}