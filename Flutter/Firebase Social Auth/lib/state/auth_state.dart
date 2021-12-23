// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


//? Authentication State for Provider.
//? Stores information about current application state (Logged in/Logged out) via AuthStateEnum
//? If logged in, also stores information about the user:
//?		> name, email, photoUrl, accessToken
//? Also provides methods for logged in via several authentication providers - Google, Facebok, and Github


enum AuthStateEnum {
	LOGGED_OUT,
	LOGGED_IN
}



class AuthState extends ChangeNotifier {
	AuthStateEnum state = AuthStateEnum.LOGGED_OUT;
	String? name;
	String? email;
	String? photoUrl;
	String? accessToken;		// needed for retrieving profile picture from Facebook (due to their GraphQL)


	//? Within the constructor of this state object, listen to FirebaseAuth authentication changes
	AuthState() {
		FirebaseAuth.instance
			.userChanges()
			.listen( (User? user) {
				if (user == null) {
					state = AuthStateEnum.LOGGED_OUT;
					name = 'Not Logged In';
					email = '';
					photoUrl = null;
					accessToken = null;
				} 
				else {
					state = AuthStateEnum.LOGGED_IN;
					name = user.displayName;
					email = user.email ?? user.providerData[0].email;
					photoUrl = user.photoURL;

					// Specific case for Facebook - Requires graphQL query and access token
					if (photoUrl != null && accessToken != null) {
						photoUrl = photoUrl! + '?access_token=$accessToken&height=150';
					}
				}

				notifyListeners();
			});
	}



	// Initiates sign in authentication workflow for Google. Returns null if failed login.
	Future<UserCredential?> signInWithGoogle() async {
		// Trigger the authentication flow
		final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
		if (googleUser == null) return null;

		// Obtain the auth details from the request
		final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
		if (googleAuth == null) return null;

		// Create a new credential
		final credential = GoogleAuthProvider.credential(
			accessToken: googleAuth.accessToken,
			idToken: googleAuth.idToken,
		);

		// Once signed in, return the UserCredential
		return await FirebaseAuth.instance.signInWithCredential(credential);
	}



	// Initiates sign in authentication workflow for Github. Returns null if failed login.
	Future<UserCredential?> signInWithGitHub(BuildContext context) async {
		// Create a GitHubSignIn instance.
		//* The values here are from .env file. Read README for more details
		final GitHubSignIn gitHubSignIn = GitHubSignIn(
			clientId: dotenv.env['GITHUB_CLIENT_ID']!,
			clientSecret: dotenv.env['GITHUB_CLIENT_SECRET']!,
			redirectUrl: dotenv.env['GITHUB_REDIRECT_URL']!,
		);

		final result = await gitHubSignIn.signIn(context);
		if (result.status != GitHubSignInResultStatus.ok) return null;

		final githubAuthCredential = GithubAuthProvider.credential(result.token!);
		return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
	}



	// Initiates sign in authentication workflow for Facebook. Returns null if failed login.
	Future<UserCredential?> signInWithFacebook() async {
		// Trigger the sign-in flow
		final LoginResult loginResult = await FacebookAuth.instance.login();
		if (loginResult.accessToken == null) return null;

		// Create a credential from the access token
		final OAuthCredential facebookAuthCredential = 
			FacebookAuthProvider.credential(loginResult.accessToken!.token);
		
		accessToken = facebookAuthCredential.accessToken;
		return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
	}



	// Signs the current logged in user out.
	Future<void> signOut() async {
		await FirebaseAuth.instance.signOut();
	}
}