// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';


//? This dart file provides two abstracted widget for rounded corner button, 
//? both outlined or filled.


const double _DEFAULT_BORDER_RADIUS = 16;
const Color _DEFAULT_PRIMARY_COLOR = Colors.blue;
const EdgeInsets _DEFAULT_PADDING = EdgeInsets.all(12);



abstract class _BaseButton extends StatelessWidget {
	final Widget child;
	final double borderRadius;
	final Color primaryColor;
	final void Function()? onPressed;
	final EdgeInsets padding;

	const _BaseButton({ 
		Key? key,
		required this.child,
		this.borderRadius = _DEFAULT_BORDER_RADIUS,
		this.primaryColor = _DEFAULT_PRIMARY_COLOR,
		this.onPressed,
		this.padding = _DEFAULT_PADDING,
	}) : super(key: key);
}




class RoundedElevatedButton extends _BaseButton {

	const RoundedElevatedButton({ 
		Key? key,
		required Widget child,
		EdgeInsets padding = _DEFAULT_PADDING,
		double borderRadius = _DEFAULT_BORDER_RADIUS,
		Color primaryColor = _DEFAULT_PRIMARY_COLOR,
		void Function()? onPressed,
	}) : super(
		key: key,
		child: child,
		borderRadius: borderRadius,
		primaryColor: primaryColor,
		onPressed: onPressed,
		padding: padding
	);

	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			onPressed: onPressed,
			child: child,
			style: ElevatedButton.styleFrom(
				primary: primaryColor,
				padding: padding,
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius) ),
			),
		);
	}
}





class RoundedOutlinedButton extends _BaseButton {

	final double outlineWidth;

	const RoundedOutlinedButton({ 
		Key? key,
		required Widget child,
		double borderRadius = _DEFAULT_BORDER_RADIUS,
		Color primaryColor = _DEFAULT_PRIMARY_COLOR,
		EdgeInsets padding = _DEFAULT_PADDING,
		void Function()? onPressed,

		this.outlineWidth = 1,
	}) : super(
		key: key,
		child: child,
		borderRadius: borderRadius,
		primaryColor: primaryColor,
		onPressed: onPressed,
		padding: padding,
	);

	@override
	Widget build(BuildContext context) {
		return OutlinedButton(
			onPressed: onPressed,
			child: child,
			style: OutlinedButton.styleFrom(
				side: BorderSide(color: primaryColor, style: BorderStyle.solid, width: outlineWidth),
				shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(borderRadius), ),
				padding: padding,
			),
		);
	}
}