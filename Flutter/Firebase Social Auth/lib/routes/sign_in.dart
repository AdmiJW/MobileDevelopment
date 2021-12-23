import 'package:firebase_social_auth/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_buttons.dart';
import '../state/auth_state.dart';



class SignInRoute extends StatelessWidget {
	const SignInRoute({ Key? key }) : super(key: key);

	static final AppBar _appBar = AppBar(
		centerTitle: true,
		backgroundColor: Colors.blueGrey[900],
		title: const Text("Sign In"),
	);


	Widget _getSignInWithGoogleButton(BuildContext ctx, AuthState authState)=> Padding(
		padding: const EdgeInsets.symmetric(horizontal: 28),
		child: RoundedElevatedButton(
			primaryColor: Colors.blue,
			borderRadius: 4,
			onPressed: () async {
				if (await authState.signInWithGoogle() != null) {
					Fluttertoast.showToast(
						msg: "Successfully logged in as ${authState.name}",
						fontSize: 16.0
					);
					Navigator.pop(ctx);
				} else {
					Fluttertoast.showToast(
						msg: "Google sign in failed.",
						fontSize: 16.0
					);
				}
			},
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const Text(
						"Sign in with  ",
						style: TextStyle(fontSize: 18)
					),
					Image.asset(
						"assets/images/google.png",
						height: 20,
						width: 20,
					)
				],
			),
		),
	);



	Widget _getSignInWithGithubButton(BuildContext ctx, AuthState authState)=> Padding(
		padding: const EdgeInsets.symmetric(horizontal: 28),
		child: RoundedElevatedButton(
			primaryColor: Colors.grey.shade200,
			borderRadius: 4,
			onPressed: () async {
				if (await authState.signInWithGitHub(ctx) != null) {
					Fluttertoast.showToast(
						msg: "Successfully logged in as ${authState.name}",
						fontSize: 16.0
					);
					Navigator.pop(ctx);
				} else {
					Fluttertoast.showToast(
						msg: "Github sign in failed.",
						fontSize: 16.0,
						gravity: ToastGravity.BOTTOM,
					);
				}
			},
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const Text(
						"Sign in with  ",
						style: TextStyle(fontSize: 18, color: Colors.black)
					),
					Image.asset(
						"assets/images/github.png",
						height: 20,
						width: 20,
					),
				],
			),
		),
	);



	Widget _getSignInWithFacebookButton(BuildContext ctx, AuthState authState)=> Padding(
		padding: const EdgeInsets.symmetric(horizontal: 28),
		child: RoundedElevatedButton(
			primaryColor: Colors.blue.shade800,
			borderRadius: 4,
			onPressed: () async {
				if (await authState.signInWithFacebook() != null) {
					Fluttertoast.showToast(
						msg: "Successfully logged in as ${authState.name}",
						fontSize: 16.0
					);
					Navigator.pop(ctx);
				} else {
					Fluttertoast.showToast(
						msg: "Facebook sign in failed.",
						fontSize: 16.0,
						gravity: ToastGravity.BOTTOM,
					);
				}
			},
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const Text(
						"Sign in with  ",
						style: TextStyle(fontSize: 18)
					),
					Image.asset(
						"assets/images/facebook.png",
						height: 20,
						width: 20,
					)
				],
			),
		),
	);



	@override
	Widget build(BuildContext context) {
		AuthState authState = Provider.of<AuthState>(context, listen: false);

		return Scaffold(
			appBar: _appBar,
			body: Column(  
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const SizedBox(width: double.infinity,),

					const Text(
						"Social Sign In",
						textAlign: TextAlign.center,
						style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
					),
					const SizedBox(height: 30,),
					_getSignInWithGoogleButton(context, authState),
					const SizedBox(height: 10,),
					_getSignInWithGithubButton(context, authState),
					const SizedBox(height: 10,),
					_getSignInWithFacebookButton(context, authState),
				],
			)
		);
	}
}