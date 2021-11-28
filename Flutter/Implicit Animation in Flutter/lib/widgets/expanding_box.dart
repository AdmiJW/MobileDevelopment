import 'package:flutter/material.dart';
import 'dart:async';



class ExpandingXYBox extends StatefulWidget {
	final int delay;
	final int duration;
	final Widget child;

	const ExpandingXYBox({ 
		Key? key,
		required this.delay,
		required this.duration,
		required this.child,
	}) : super(key: key);

	@override
	_ExpandingBoxState createState() => _ExpandingBoxState();
}

class _ExpandingBoxState extends State<ExpandingXYBox> {
	double scale = 0;
	

	@override
	void initState() {
		super.initState();

		Future.delayed(Duration(milliseconds: widget.delay), () {
			setState(()=> scale = 1);
		});
	}

	@override
	Widget build(BuildContext context) {
		// Since AnimatedScale does not separate x and y component, we forced to use AnimateeContainer instead
		return AnimatedScale(
			duration: Duration(milliseconds: widget.duration),
			curve: Curves.bounceOut,
			scale: scale,
			child: widget.child,
		);
	}
}