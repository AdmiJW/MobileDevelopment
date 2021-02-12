
/*
    =======================================
    ❌❌❌ 9.0 Exception Handling ❌❌❌
    =======================================

    Every programming language has mechanisms to handle Errors and Exceptions
    to prevent program from crashing, so does Dart.

    Like other languages, exception is handled using those keywords:
    > try
    > catch
    > finally
    > throw
    
    You could throw exception easily using Exception class,

        if (error)
          throw Exception("Error is true");

    we can catch anything as an variable:

        try {...} catch (e) { ... }

    'finally' block will always be executed no matter exception occur or not

        try {...} catch (e) {...} finally {...}

    In Dart, we can go specific on what type of error to catch using 'on'
    keyword. With that, we can choose to catch the error as variable or not

        try {...}
        on AKindOfException {...}
        on AnotherException catch (e) {... e }
        catch(e) { ... }

    In one of the catch clauses, we can also make it to only handle partially
    the exception, by rethrowing() the exception!

        on ... { rethrow; }
*/
import 'dart:math';



class RainException implements Exception {
  String msg;
  RainException([String msg]) {
    this.msg = msg ?? "RainException occurred";
  }

  String toString() {
    return msg;
  }
}


exception_1() {
  int isRain = Random().nextInt(2);

  try {
    if ( isRain == 1 ) throw RainException("Raining!!!");
    else throw Exception("No Rain");
  } on RainException catch (e) {
    print(e.toString() );
  } catch (other) {
    print(other.toString() );
  } finally {
    print("Done");
  }
}


main() {
  exception_1();
}