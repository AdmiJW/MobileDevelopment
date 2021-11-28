import 'package:flutter/material.dart';

import 'package:implicit_animation_in_flutter/widgets/fade_in_text.dart';
import 'package:implicit_animation_in_flutter/widgets/expanding_box.dart';
import 'package:implicit_animation_in_flutter/widgets/sliding_widget.dart';


void main()=> runApp(const MyApp());




class MyApp extends StatelessWidget {
	const MyApp({ Key? key }) : super(key: key);


	static const Text title = Text(
		"Welcome to Implicit Animation",
		textAlign: TextAlign.center,
		style: TextStyle(
			fontWeight: FontWeight.bold,
			fontSize: 40,
		)
	);


	static const Text subtitle = Text(
		"This is an example for AnimatedOpacity (Fading)",
		textAlign: TextAlign.center,
		style: TextStyle(
			fontWeight: FontWeight.w300,
			fontSize: 20,
			color: Colors.grey,
		)
	);
	
	static Widget box = Container(
		decoration: const BoxDecoration(
			color: Colors.black12,
			borderRadius: BorderRadius.all(Radius.circular(20)),
		),
		child: Column(
			children: listChildren,
		),
	);


	static List<Widget> listChildren = [
		const SizedBox(height: 20,),
		const SlidingWidget(
			delay: 3500, 
			duration: 1000, 
			initialXOffset: -5, 
			initialYOffset: 0, 
			child: Text("Slide in from Left"),
		),
		const SizedBox(height: 20,),
		const SlidingWidget(
			delay: 4000, 
			duration: 1000, 
			initialXOffset: 5, 
			initialYOffset: 0, 
			child: Text("Slide in from Right"),
		),
		const SizedBox(height: 20,),
		const SlidingWidget(
			delay: 4500, 
			duration: 1000, 
			initialXOffset: -5, 
			initialYOffset: 0, 
			child: Text("Slide in from Left"),
		),
		const SizedBox(height: 20,),
		const SlidingWidget(
			delay: 5000, 
			duration: 1000, 
			initialXOffset: 5, 
			initialYOffset: 0, 
			child: Text("Slide in from Right"),
		),
		const SizedBox(height: 20,),
		const SlidingWidget(
			delay: 5500, 
			duration: 1000, 
			initialXOffset: -5, 
			initialYOffset: 0, 
			child: Text("Slide in from Left"),
		),
		const SizedBox(height: 20,),
		const SlidingWidget(
			delay: 6000, 
			duration: 1000, 
			initialXOffset: 5, 
			initialYOffset: 0, 
			child: Text("Slide in from Right"),
		),
	];





	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Implicit Animation in Flutter',
			home: Scaffold(
				body: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						const SizedBox(height: 40),
						const FadeInText(
							delay: 0,
							duration: 1000, 
							text: title
						),
						const SizedBox(height: 20),
						const FadeInText(
							delay: 1250,
							duration: 1000, 
							text: subtitle
						),
						const SizedBox(height: 10),
						Expanded(
							child: Padding(
								padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
								child: ExpandingXYBox(
									delay: 2500, 
									duration: 1000, 
									child: box,
								),
							),
						),
					],
				)
			),
		);
	}
}



