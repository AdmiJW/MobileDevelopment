
import 'package:flutter/material.dart';
import 'package:firebase_social_auth/state/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_buttons.dart';



class ProfileRoute extends StatelessWidget {
	const ProfileRoute({ Key? key }) : super(key: key);

	static final AppBar _appBar = AppBar(
		centerTitle: true,
		backgroundColor: Colors.blueGrey[900],
		title: const Text("Profile"),
	);


	
	Widget _getProfile(BuildContext ctx, AuthState authState)=> Container(
		decoration: BoxDecoration(
			boxShadow: [ BoxShadow(
				offset: Offset.fromDirection(1.6, 5), 
				blurRadius: 5, 
				color: Colors.grey.shade300
			),],
			color: Colors.grey.shade100,
		),
		padding: const EdgeInsets.symmetric(vertical: 30),
		
		child: Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				CircleAvatar(
					backgroundColor: Colors.grey,
					radius: 60,
					foregroundImage: authState.photoUrl != null
						? Image.network( authState.photoUrl!, fit: BoxFit.cover ).image
						: null,
					child: Text( 
						authState.name?[0] ?? "User", 
						style: const TextStyle(fontSize: 36, color: Colors.black) 
					),
				),

				const SizedBox(width: 20,),
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							authState.name ?? "",
							style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
						),
						const SizedBox(height: 15),
						Text(
							authState.email ?? "",
							style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300)
						),
					],
				),
			],
		),
	);



	Widget _getSignOutButton(BuildContext ctx, AuthState authState)=> RoundedElevatedButton(
		primaryColor: Colors.red,
		onPressed: () async {
			await authState.signOut();
			Fluttertoast.showToast(
				msg: "Successfully logged out",
				fontSize: 16.0
			);
			Navigator.pop(ctx);
		},
		padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
		child: const Text(
			"Log out",
			style: TextStyle(fontSize: 18),
		),
	);



	@override
	Widget build(BuildContext context) {
		AuthState authState = Provider.of<AuthState>(context);

		return Scaffold(
			appBar: _appBar,
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const SizedBox(width: double.infinity),

					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 20),
						child: _getProfile(context, authState),
					),
					const SizedBox(height: 50),
					_getSignOutButton(context, authState),
				],
			)
		);
	}
}