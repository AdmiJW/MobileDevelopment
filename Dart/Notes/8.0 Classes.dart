
/*
    ============================
    🏫🏫🏫 8.0 Classes 🏫🏫🏫
    ============================

    Classes are an important aspect in Dart, a Object Oriented Language.
    As repeated many times, everything is an object in Dart!

    To define a class, simply follow the syntax as in other languages especially
    Java.

    To create an instance of the class, simply call the class name like it is
    a function, without the new keyword. Then, access any of its properties
    using dot operator .
*/  

class Person1 {
  String name;
  int age;

  void show() {
    print("name: $name, age: $age");
  }
}

classes_1() {
  var p1 = Person1();
  p1.name = "Alex";
  p1.age = 15;
  p1.show();
}






/*
    Constructors, Named Constructors, and this keyword

    Constructors are important to iniitalize the properties of the instance.
    A constructor is simply a special function that has the exact same name
    as the class name

    All previous concepts can be applied to the constructor. Optional arguments
    by position, or named arguments...

    To set the properties of the instance in the constructor, we have two 
    choices:
      > Using 'this' keyword, referring to the instance itself
      > In the parameter list, immediately refer to the property to be set,
        like:

            Person( this.name, this.age );

        Note that if the constructor does nothing other than initializing
        object properties, you can close the constructor off using semicolon

    In Dart, there is no overloading constructors. Above syntax is for default
    constructor already. Therefore, we need to use named constructors instead.

        Person.guestConstructor() {
          ...
        }

    Then, to use that constructor,

        var g = Person.guestConstructor();
*/


class Person2 {
  String name;
  int age;

  Person2(this.name, [this.age = 18] );

  Person2.guestConstructor() {
    this.name = 'Guest';
    this.age = 18;
    print("A guest person is created");
  }

  show() {
    print("Name: $name, Age: $age");
  }
}


classes_2() {
  var p1 = Person2("Adam");
  var g = Person2.guestConstructor();

  p1.show();
  g.show();
}







/*
    'final' and 'const'

    Outside of classes, const and final keyword has the same functionality:
    creating immutable variables.

    Inside of classes, they have differences:
    > const - Compile time constant. Cannot be changed even by constructor.
              Since it will be same in all instances, 'static' modifier
              must be given
    > final - Runtime constant. Can be set by constructor and that's it. Once
              initialized by constructor, the variable cannot be further
              modified
*/


class Person3 {
  final name;
  static const int age = 18;

  Person3( this.name );

  void show() {
    print("Name: $name, Age: $age");
  }
}

classes_3() {
  var p = Person3("Alex");
  p.show();
}





/*
    Inheritance and Polymorphism

    A class can simply extend other classes, this is called Inheritance.
    
        class Student extends Person {...}

    With this, we should call the super classes' constructor since super classes'
    constructor ISN'T INHERITED into the derived class. This is done by colon 
    sign after function signature:

        Student(...): super(...);

    In methods, we can also easily call super classes' methods, via super
    keyword

        ...
        super.showOutput();
        ...

    --------------------------------------------------------------------

    A method can be overridden. First we shoudl annotiate it with @override
    before function definition. Dart will check if there is such function
    in super class so we don't accidentally declare the wrong overridden
    function.

        @override
        void showOutput() {
          super.showOutput();
          ...
        }
*/

class Vehicle {
  String model;
  int year;

  Vehicle( this.model, this.year );

  showInfo() {
    print("Model: $model, Year: $year");
  }
}

class Car extends Vehicle {
  double price;

  Car( String model, int year, this.price): super(model, year);

  @override
  showInfo() {
    super.showInfo();
    print("Price: $price");
  }
}

classes_4() {
  var car = Car("Audi", 2021, 99999);
  car.showInfo();
}



/*
    Encapsulation

    If a object property starts with an underscore, it is considered private
    variable and cannot be accessed outside the class.

    To access and set its value, we can define Getters and Setters, done via
    'get' and 'set' keyword.
    Examples here:

        int get days => years * 365;                      //  Get days from this.years
        set name(String name) => this.name = "Mr.$name";
*/


class Person4 {
  String _name;
  int _age;

  Person4( this._name, this._age );

  String get info {
    String res = "Name: $_name\n";
    res += "Age: $_age";
    return res;
  }

  set name(String name) => _name = "Mr.$name";
  set age(int age) => _age = age;
}

classes_5() {
  var p = Person4("Alex", 18);
  print( p.info );

  p.name = "Billie";
  p.age = 32;
  print( p.info );
}


main() {
  classes_5();
}