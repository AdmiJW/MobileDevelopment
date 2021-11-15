// The Rectangle class from Java's example - https://docs.oracle.com/javase/tutorial/java/javaOO/objectcreation.html
// This should be implemented with Dart along with the features

class Point {
    int x, y;
    Point(this.x, this.y);

    @override
    String toString()=> '($x, $y)';
}


class Rectangle {
    int width, height;
    Point _origin;

    Point get origin => _origin;
    void set origin(val)=> _origin = val;

    @override
    String toString()=> 
        'Rectangle (Origin: $_origin, Width: $width, Height: $height)';


    //? 1 - Optional parameters
    //?
    //? Like Javascript style, optional parameters are passed as Map (Object)
    //? Additionally, we still can immediately assign via 'this.memberVariable'
    //? Like C++, using a colon : we can assign member variables too, especially
    //? useful if you have private members (cannot use this.membervariable syntax)
    Rectangle({ 
        Point? origin,
        this.width = 0,
        this.height = 0
    }): _origin = origin ?? Point(0, 0);


    void move(int x, int y) {
        origin.x = x;
        origin.y = y;
    }

    int getArea() => width * height;
}






main() {
    print(Rectangle(origin: Point(10, 20), width: 100, height: 200));
    print(Rectangle(origin: Point(10, 10)));
    print(Rectangle(width: 200));
    print(Rectangle());
}