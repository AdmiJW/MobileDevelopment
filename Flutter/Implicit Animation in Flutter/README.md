# Implicit Animations in Flutter

[__Youtube Video__](https://youtu.be/GXIJJkq_H8g)

---


Flutter does code-based animations in two ways:
-   Implicit Animation
-   Explicit Animation

According to official Flutter guideline, determining whether to use implicit animation or explicit animation boils down to these three questions:

1. Does the animation repeat forever (infinite)
1. Is it discontinuous (the graph can be drawn in one continuous line)
1. Do the animation involve multiple widgets coordinated together

Any 'yes' to the above answers lead to choosing explicit animation.

However, explicit animations are harder to be done.

> Explicit animations are a set of controls for telling Flutter how to rapidly rebuild the widget tree while changing widget properties to create animation effects. This approach enables you to create effects that you can’t achieve using implicit animations.


---

In __Implicit Transformation__, we doesn't handle the rendering ourselves. Basically, we simply change the state (Eg: changing opacity from 1 to 0), and the widget will handle the animation for us! 

In fact, if you are not doing advanced animations, most of the time you will prefer implicit transformation, especially with the powerful built-in widgets like [__AnimatedContainer__](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html), which you may animate opacity, translation, rotation, color etc all in one widget. 

If that's not the case for you, you still can remain in the realm of implicit animation with [__TweenAnimationBuilder__](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html), as long as you still didn't answer 'yes' to the 3 questions mentioned above.

---

Tips:

1. Built-in implicit animation classes usually follow the naming convention of `AnimatedFoo` (AnimatedContainer, AnimatedOpacity, AnimatedScale). On the other hand, build-in explicit animation classes usually have `Transition` in them (FadeTransition, SizeTransition)