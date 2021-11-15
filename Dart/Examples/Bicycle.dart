// The Bicycle class from Java's example - https://docs.oracle.com/javase/tutorial/java/javaOO/variables.html
// This should be implemented with Dart along with the features


class Bicycle {

    //? 1 - Private variables
    //?
    //? Dart does not provide access modifiers. Instead, we prefix the identifier
    //? with underscore to make it "not visible" to other modules
    int _cadence, _gear, _speed;


    //? 2 - Constructor to set member variables and default values
    //?
    //? A constructor can have no body - Use ; to terminate
    //? To set the member variables, we can directly put this.membervariable
    //? in parameters to set directly
    //? Also, default arguments are supported
    Bicycle(this._cadence, this._gear, this._speed);

    
    //? 3 - Getters and Setters
    //?
    //? Getters and setters are functions in Java. In dart, these can be 
    //? explicitly specified via 'get' and 'set' keyword.
    //? Furthermore, we can shorten it via fat arrow functions
    int get cadence => _cadence;
    int get gear => _gear;
    int get speed => speed;
    void set cadence(value) => _cadence=value;
    void set gear(value) => _gear=value;
    void set speed(value) => _speed=value;


    //? 4 - Override toString
    @override
    String toString() => 
        'Bicycle (Cadence: $_cadence, Gear: $_gear, Speed: $_speed)';



    void applyBrake(int decrement) => _speed -= decrement;
    void speedUp(int increment) => _speed += increment;
}




main() {
    var bike1 = Bicycle(1, 2, 3);

    bike1._cadence = 4;
    bike1._gear = 5;
    bike1._speed = 6;

    print(bike1);
}