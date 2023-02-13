# Dart Cheatsheet

> Author: [AdmiJW](https://github.com/AdmiJW)

My personal cheatsheet for Dart language to quickly get started with Dart programming language and as a reference for myself (and you), even in the future when I had forgotten most of it.

---
<br>

## **Table of Contents**

1. [**1. Hello, Dart**](#1-hello-dart)
1. [**2. Datatype and Variables**](#2-datatype-and-variables)
1. [**3. Strings**](#3-strings)
1. [**4. Operators**](#4-operators)
1. [**5. Control Statements**](#5-control-statements)
1. [**6. Collections**](#6-collections)
1. [**7. Functions**](#7-functions)
1. [**8. Classes**](#8-classes)
1. [**9. Exceptions**](#9-exceptions)

---
<br>

## **1. Hello, Dart**

- Dart is the programming language for Flutter, which is mainly used in mobile application development - Even companies like Grab, Tencent etc.

- Dart is 
    - Statically typed language - Once the datatype for a variable is determined, the type cannot be changed later on, except if you use `dynamic` datatype.
    - Compiled AOT - Compiled ahead of time during production, and JIT - Compiled just in time when we run the code during development
    - 100% Object Oriented - Everything is an object! int is an object, even null is an object!

- Dart's program entry point is the `main()` function with `void` return type.

- To print to the console. simply call `print(obj)`.

- Dart allow `void` return type to be omitted, so any function without a return type will be assumed to be `void`.

- Every dart script comes with a defualt package (aka modules/libraries) imported: `dart:core`

- To deal with command line input and output, you need to import the `dart:io` package. This allows, for example, the following functions to be used:

    - `stdout.writeln()`
    - `stdin.readLineSync()`

---
<br>

## **2. Datatype and Variables**

- Dart is strongly typed language. Datatypes must be known at compile time, **EXCEPT** if you use the `dynamic` datatype.

- There are 5 primitive datatypes in Dart:

    - `int` - 64-bit signed integer
    - `double` - 64-bit floating point number
    - `bool` - Boolean value
    - `String` - Sequence of UTF-16 code units
    - `dynamic` - Any type, can be changed at runtime

- In addition, collections datatypes:

    - `List` - An ordered group of objects
    - `Set` - A collection of unique objects
    - `Map` - A collection of key-value pairs

- Dart supports type inference. Using `var` will cause it to infer the datatype based on its value. However, that does not mean you can change the value to a different datatype later like `dynamic` does!

- Constants are declared using `const`. You may omit the datatype if it can be inferred.

- To get the type of a variable, use `obj.runtimeType`.

---
<br>

## **3. Strings**

- In Dart, single quotes `'` and double quotes `"` are both valid for strings.

- To have raw strings (strings that ignore escape characters), prefix a `r` before the string, like `r'This is a raw string'`

- String interpolation works similar to Javascript using `${}` syntax, such as `"1 + 2 is ${1+2}"`

- In addition, if you only need to interpolate a single variable, you can use the `$` without the `{}`, such as `"Welcome, $username"`

- Multiline strings are achieved using `'''` or `"""`, such as `'''This is a multiline string'''`

- Conversion between string and other datatypes can be done very easily, since everything is a object in Dart:

    - `int.parse(123)`
    - `double.parse(12.34)`
    - `1.toString()`
    - `3.1231.toString()`

---
<br>

## **4. Operators**

- Common operators that you see in other languages are also in dart:  `+, -, *, /, %, ==, !=, >=, <=, *=, +=, -=, ++, --, &&, ||, !`

- Division operator `/` will always return a `double` value. If you want a integer division, use `~/` .

- Ternary operator: `condition ? true : false`.

- Type checking operator using `is` and `is!`. For example, `obj is String`, `x is! double`.

- Type casting via `as` keyword. For example, `obj as String`.

- Null-aware operators: 

    - `a ?? b` - If a is not null, return a. Otherwise, return b.

    - `a?.b` - If a is not null, return a.b. Otherwise, return null.

    - `a ??= b` - If a is not null, return a. Otherwise, **assign b to a** and return b.

- Cascades: 

    - If we want to chain operations on an object, the traditional way is that the functions will have to return the object itself. Like: `[].map(...).filter(...).forEach(...)`. 

    - If any of the intermediate functions doesn't return the object, the chaining is gone, unless in Dart, we can use **Cascades**!

    - Cascades is used by `..` syntax, and can be used on functions to return the reference of original object, or even on member variables!

        ```dart
        querySelector('#confirm')?
        ..text = 'Confirm' 
        ..classes.add('important')
        ..onClick.listen((e) => window.alert('Confirmed!'));
        ```

---
<br>

## **5. Control Statements**

- `if .. else if ... else` and `switch() { case ... break }` are the same.

- `for (a; b; c) {}`, `while ()`, `do {} while ()`, `break` and `continue` are the same.

- To loop through a iterable, you may use `for (var item in collection) {}`

- Or you may use `forEach()` function: `[1,2,3].forEach((item) => print(item))`

---
<br>

## **6. Collections**

- Define a list: `var list = [1,2,3]`. 

- More explicitly, use `List<T>`. For example, `List<int> list = [1,2,3]`.

- If using `var`, you can restrict the type: `var list = <int>[1,2,3]`.

- Define a set: `var set = {1,2,3}`.

- To create a empty set using `{}`, the compiler will assume it is a map. Therefore be more specific: `var set = <int>{};`, `var set = <Object>();`.

- Maps contain key-value pairs. Create a map: `var map = {'a': 1, 'b': 2}`.

---
<br>

## **7. Functions**

- Functions allow `dynamic` to be used as return value.

- Functions allow `dynamic` and `var` to be used as parameter type.

- One line arrow functions, can only consist of single statement: `var foo = ()=> print("Hello");` or `bar () => print("Bye");`

- Multiple statement functions, without the `=>` syntax: `var foo = () { print("Hello"); print("World"); }`

- These 2 types of functions can be used as anonymous functions, such as in `list.forEach((item) => print(item))` or `list.forEach((item) { print(item); })`

- Arguments are positional by default. To make them named, use `{}` syntax: `void foo({int a, int b}) {}`. To call it: `foo(a: 1, b: 2)`.

- You may mix positional and named arguments, but positional arguments must come first: `void foo(int a, {int b}) {}`. To call it: `foo(1, b: 2)`.

- Both positional and named arguments can be optional:

    - Positional arguments: `void foo([int a, int b]) {}`. To call it: `foo(1, 2)` or `foo(1)` or `foo()`.

    - Named arguments (optional by default): `void foo({int a, int b}) {}`. To call it: `foo(a: 1, b: 2)` or `foo(a: 1)` or `foo()`.

---
<br>

## **8. Classes**

- No need to use `new` keyword to create an object. Like `var obj = MyClass();`

- We can directly set object properties in the constructor: `MyClass(this.a, this.b) {}`.

- If the constructor does nothing but setting properties, we can close off the constructor with `;` without any body: `MyClass(this.a, this.b);`

- Or you may use an initializer list: `MyClass(int a, int b) : this.a = a, this.b = b;`;

- Dart provides named constructors, which can be used to create different objects with different properties: `MyClass.namedConstructor(this.a, this.b) {}`. To call it: `var obj = MyClass.namedConstructor(1, 2);`

- There isn't a `private` modifier in Dart. Instead, use `_` to make a variable private: `_a`.

- Define a getter: `int get a => _a;`. 

- Define a setter: `set a(int value) => _a = value;`.

- Inside of classes, `const` and `final` have differences:

    - `const` - Compile time constant. Cannot be changed even by constructor. Since it will be same in all instances, `static` modifier must be given

    - `final` - Runtime constant. Can be set by the constructor and that's it. Once initialized by the constructor, the variable cannot be further modified

- Inheritance is done via `extends` keyword: `class MyClass extends BaseClass {}`.

- Superclasses' constructor isn't inherited. Call the base class constructor in the child class constructor: `MyClass() : super(1, 2) {}`.

- Call superclass' method using `super`: `super.method();`.

- Override superclass' method using `@override` annotation: `@override void method() {}`.

- Factory constructors:

    ```dart
    abstract class Shape {
        factory Shape(String type) {
            if (type == 'circle') return Circle(2);
            if (type == 'square') return Square(2);
            throw 'Can\'t create $type.';
        }
    }
    ```

- The Dart language doesn't include an `interface` keyword, because every class defines an interface. You can implement an interface by using `implements` keyword: `class MyClass implements AnotherClass {}`.

---
<br>

## **9. Exceptions**

- `try`, `catch`, `finally` and `throw` are the same.

- To throw an (generic) exception, use `throw Exception("Error message")`.

- Catching an exception: `catch (e) {}`. `e` is the exception object.

- We can go specific on what type of error to catch using `on` keyword:

    ```dart
    try {...}
    on AKindOfException {...}
    on AnotherException catch (e) {... e }
    catch(e) { ... }
    ```

- Re-throwing an exception: `on Exception { rethrow; }` or `catch (e) { rethrow; }`.


---
<br>