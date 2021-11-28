import 'package:flutter/material.dart';
import 'dart:async';


//=========================================================================
// An animated text widget that fades in with provided delay and duration
//=========================================================================
class FadeInText extends StatefulWidget {
	final int delay;
	final int duration;
	final double initialOpacity;
	final double endOpacity;
	final Widget text;

	const FadeInText({ 
		Key? key, 
		required this.delay,
		required this.duration,
		required this.text,
		this.initialOpacity = 0,
		this.endOpacity = 1,
	}) : super(key: key);

	@override
	FadeInTextState createState() => FadeInTextState();
}

class FadeInTextState extends State<FadeInText> {
	double _opacity = 0;

	@override
	void initState() {
		super.initState();
		_opacity = widget.initialOpacity;

		// After delay milliseconds, call setState to endOpacity to begin animation
		Future.delayed(Duration(milliseconds: widget.delay), () {
			setState(()=> _opacity = widget.endOpacity);
		});
	}


	@override
	Widget build(BuildContext context) {
		return AnimatedOpacity(
			opacity: _opacity, 
			duration: Duration(milliseconds: widget.duration),
			child: widget.text,
		);
	}
}