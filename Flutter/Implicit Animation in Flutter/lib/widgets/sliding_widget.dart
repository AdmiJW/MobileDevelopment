import 'package:flutter/material.dart';
import 'dart:async';


class SlidingWidget extends StatefulWidget {
	final int delay;
	final int duration;
	final double initialXOffset;
	final double initialYOffset;
	final Widget child;


	const SlidingWidget({ 
		Key? key,
		required this.delay,
		required this.duration,
		required this.initialXOffset,
		required this.initialYOffset,
		required this.child,
	}) : super(key: key);

	@override
	_SlidingWidgetState createState() => _SlidingWidgetState();
}

class _SlidingWidgetState extends State<SlidingWidget> {
	Offset offset = Offset.zero;

	@override
	void initState() {
		super.initState();
		offset = Offset( widget.initialXOffset, widget.initialYOffset );

		// After delay milliseconds, call setState to endOpacity to begin animation
		Future.delayed(Duration(milliseconds: widget.delay), () {
			setState(()=> offset = Offset.zero);
		});
	}

	@override
	Widget build(BuildContext context) {
		return AnimatedSlide(
			offset: offset,
			duration: Duration(milliseconds: widget.duration),
			curve: Curves.easeOut,
			child: widget.child,
		);
	}
}