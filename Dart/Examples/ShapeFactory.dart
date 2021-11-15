// Factory design pattern is common in Java.
//
// It is commonly used to return subtypes of instances instead of directly
// invoking the constructor
// Eg: A vehicleFactory may return Car, Bike, Motor, Lorry etc without us
//     having to explicitly call Car(), Bike(), Motor() etc
// 
// Dart embrace this design pattern further by providing factory constructors:
// syntax is like constructor, but may return subtypes


import 'dart:math';


//? 1 - Every class is an interface
//?
//? In Dart, every class definition is already defining an interface. Therefore
//? we don't have interface keyword here, yet we still can 'implement' the
//? interface in subclasses already
abstract class Shape {
    num get area;

    //? 2 - Factory constructor
    //?
    //? Using the 'factory' keyword, we can define a factory constructor.
    //? Within, we can return Subtypes of this class too!
    factory Shape(String type) {
        if (type == 'Circle') return Circle(0);
        else if (type == 'Square') return Square(0);
        throw 'Invalid type $type';
    }
}



class Circle implements Shape {
    final num radius;
    Circle(this.radius);

    num get area => radius * radius * pi;
}



class Square implements Shape {
    final num side;
    Square(this.side);

    num get area => pow(side, 2);
}



main() {
    final circle = Shape('Circle');
    final square = Shape('Square');
    
    print(circle.area);
    print(square.area);
}