import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import './firebase_options.dart';
import './widgets/custom_buttons.dart';

import './state/auth_state.dart';
import './routes/sign_in.dart';
import './routes/profile.dart';



void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await dotenv.load(fileName: ".env");
	
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,   
    );

  	runApp(const MyApp());
}





Map<String, WidgetBuilder> _routes = {
	'/': (BuildContext ctx)=> const HomeScreen(),
	'/signin': (BuildContext ctx)=> const SignInRoute(),
	'/profile': (BuildContext ctx)=> const ProfileRoute(),
};






class MyApp extends StatelessWidget {
	const MyApp({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				ChangeNotifierProvider.value(value: AuthState() ),
			],
			child: MaterialApp(
				title: "Firebase Social Authentication",
				routes: _routes,
			),
		);
	}
}





class HomeScreen extends StatelessWidget {
	const HomeScreen({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		AuthState authState = Provider.of<AuthState>(context);

		return Scaffold(
			backgroundColor: Colors.blueGrey[900],
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					// SizedBox to expand the column to fill the screen
					const SizedBox(width: double.infinity),

					// Image
					Image.asset(
						'assets/images/authentication.png',
						width: 150,
						height: 150,
					),
					
					// Title
					const SizedBox(height: 25),
					const Padding(
						padding: EdgeInsets.symmetric(horizontal: 15),
						child: Text(
							"Firebase Social Auth",
							textAlign: TextAlign.center,
							style: TextStyle(fontSize: 45, color: Colors.white),
						),
					),

					// Sign in / Profile button
					const SizedBox(height: 30),
					RoundedOutlinedButton(
						child: Text(
							authState.state == AuthStateEnum.LOGGED_IN
								? "Profile"
								: "Sign In",
							style: TextStyle(fontSize: 18, color: Colors.orange.shade200)
						),
						primaryColor: Colors.orange.shade300,
						borderRadius: 20,
						padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
						onPressed: () {
							Navigator.pushNamed(
								context, 
								authState.state == AuthStateEnum.LOGGED_IN? '/profile': '/signin',
							);
						},
					),
				],
			),
		);
	}
}